#!/bin/bash
WORK_PATH='/usr/project/my-vue3'
cd $WORK_PATH
echo '先清除老代码'
git reset --hard origin/main
git clean -f
echo '拉去最新代码'
git pull origin main
echo '编译'
npm run build
echo '开始执行构建'
docker build -t my-vue3:1.0 .
echo '停止旧容器并删除旧容器'
docker stop my-vue3-container
docker rm my-vue3-container
echo '启动新容器'
docker container run -p 80:80 --name my-vue3-container -d my-vue3:1.0