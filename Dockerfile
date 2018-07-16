FROM centos
MAINTAINER WangXianfeng wangxf7@asiainfo-sec.com
#解压java7
RUN mkdir /usr/java 
COPY jdk1.7.0_79 /usr/java/jdk1.7.0_79
#安装并设置中文环境
RUN yum -y update \
    && yum -y install kde-l10n-Chinese && yum -y reinstall glibc-common \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
	&& /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo 'Asia/Shanghai' > /etc/timezone
#设置jdk环境变量	
ENV LANG zh_CN.UTF-8 \
  && LC_ALL zh_CN.UTF-8 \
  && JAVA_HOME /usr/java/jdk1.7.0_79 \
  && JRE_HOME /usr/java/jdk1.7.0_79/jre 
ENV  PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin \ 
  && CLASSPATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib

COPY Shanghai  /etc/localtime

CMD ["java -version"]
