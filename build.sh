#!/bin/bash

set -eu
mvn --version
Prompt(){
	echo "[$(date '+%D %H:%M:%S')] $@"
}

WORKSPACE=$(cd $(dirname $0); pwd)
Prompt "Work dir: $WORKSPACE"

cd $WORKSPACE

export LANG="en_US.UTF-8"

Prompt "Setting up environment variables OK..."

OUTPUT=$WORKSPACE/target/demo-1.0-SNAPSHOT-all/output

Prompt "Clean and Package"
mvn clean -U package -Dmaven.test.skip=true -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2 || exit $?
Prompt "Package for deploy"
rm -fr $WORKSPACE/output
mv $OUTPUT ./

Prompt "download jdk"
curl https://tony.oss.cn-north-1.jcloudcs.com/test-wl-0228/jdk-8u181-linux-x64.tar.gz > $WORKSPACE/output/jdk-8u111-linux-x64.tar.gz

mv appSpec.yml $WORKSPACE/output/appSpec.yml

Prompt "build finish exit:"$?

exit $?
