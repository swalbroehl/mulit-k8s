docker build -t swalbroehl/multi-client:latest -t swalbroehl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t swalbroehl/multi-server:latest -t swalbroehl/multi-server:$SHA -f ./server/Dockerfile ./server
docker built -t swalbroehl/multi-worker:latest -t swalbroehl/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push swalbroehl/multi-client:latest
docker push swalbroehl/multi-server:latest
docker push swalbroehl/multi-worker:latest
docker push swalbroehl/multi-client:$SHA
docker push swalbroehl/multi-server:$SHA
docker push swalbroehl/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=swalbroehl/multi-server:$SHA
kubectl set image deployments/client-deployment client=swalbroehl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=swalbroehl/multi-worker:$SHA
