From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/2] http-push: add regression tests
Date: Wed, 27 Feb 2008 20:28:45 +0100
Message-ID: <20080227192845.GC1818@localhost>
References: <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org> <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org> <20080225232820.GA18254@localhost> <7vprukfttt.fsf@gitster.siamese.dyndns.org> <20080227085442.GA22501@localhost> <alpine.LSU.1.00.0802270947110.22527@racer.site> <20080227192334.GA1818@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURxx-0005l9-Ce
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737AbYB0T2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756315AbYB0T2k
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:28:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:21359 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247AbYB0T2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:28:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so493232ugc.16
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 11:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=KGznq3mPqBx4pK8hHMHbqs2ElI8xCQTYY4/y4sKiFts=;
        b=jlL6jcepk2U8SLMOHGxCkOARA8cVyhpvpiUTVUJMv0k3tmRikzmKsKr3DIaJMqwsmQBfLAuUah26h5xh8AKJbbejkLmeL2wOMEL0wkdfaXcP3Fl8II6sSVkKv5bwWHoRiP+Z8cMb1aWionLih/gY4VQoNvSZ6uNR/i8xcKx6fyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=hhDZf4fWWJjOxcFDbcNCiWGfe2Z7KxX5SBCzBk+rlbauxoRwZPd2EzvG4yjElasAuBCkrdi9AB2qG5UWyD6F412D8vyG15XWDBSeSygUMrW2/TikUFUX7EIuhlwiNhzGsovP+8kH8WHpLoKPPP0cbxW53FCa7XHjdbVAGD8mNVQ=
Received: by 10.67.123.19 with SMTP id a19mr1610385ugn.4.1204140516756;
        Wed, 27 Feb 2008 11:28:36 -0800 (PST)
Received: from darc.dyndns.org ( [84.154.73.116])
        by mx.google.com with ESMTPS id p9sm13098968fkb.19.2008.02.27.11.28.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 11:28:35 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JURxN-0000qH-Jl; Wed, 27 Feb 2008 20:28:45 +0100
Content-Disposition: inline
In-Reply-To: <20080227192334.GA1818@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75290>

http-push tests require a web server with WebDAV support.

This commit introduces a HTTPD test library, which can be configured using
the following environment variables.

GIT_TEST_HTTPD		enable HTTPD tests
LIB_HTTPD_PATH		web server path
LIB_HTTPD_MODULE_PATH	web server modules path
LIB_HTTPD_PORT		listening port
LIB_HTTPD_DAV		enable DAV
LIB_HTTPD_SVN		enable SVN
LIB_HTTPD_SSL		enable SSL

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/lib-httpd.sh          |   96 +++++++++++++++++++++++++++++++++++++++++++++++
 t/lib-httpd/apache.conf |   34 ++++++++++++++++
 t/lib-httpd/ssl.cnf     |    8 ++++
 t/t5540-http-push.sh    |   73 +++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |    9 +++-
 5 files changed, 218 insertions(+), 2 deletions(-)
 create mode 100644 t/lib-httpd.sh
 create mode 100644 t/lib-httpd/apache.conf
 create mode 100644 t/lib-httpd/ssl.cnf
 create mode 100755 t/t5540-http-push.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
new file mode 100644
index 0000000..7f206c5
--- /dev/null
+++ b/t/lib-httpd.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
+#
+
+if test -z "$GIT_TEST_HTTPD"
+then
+	say "skipping test, network testing disabled by default"
+	say "(define GIT_TEST_HTTPD to enable)"
+	test_done
+	exit
+fi
+
+LIB_HTTPD_PATH=${LIB_HTTPD_PATH-'/usr/sbin/apache2'}
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'8111'}
+
+TEST_PATH="$PWD"/../lib-httpd
+HTTPD_ROOT_PATH="$PWD"/httpd
+HTTPD_DOCUMENT_ROOT_PATH=$HTTPD_ROOT_PATH/www
+
+if ! test -x "$LIB_HTTPD_PATH"
+then
+        say "skipping test, no web server found at '$LIB_HTTPD_PATH'"
+        test_done
+        exit
+fi
+
+HTTPD_VERSION=`$LIB_HTTPD_PATH -v | \
+	sed -n 's/^Server version: Apache\/\([0-9]*\)\..*$/\1/p; q'`
+
+if test -n "$HTTPD_VERSION"
+then
+	if test -z "$LIB_HTTPD_MODULE_PATH"
+	then
+		if ! test $HTTPD_VERSION -ge 2
+		then
+			say "skipping test, at least Apache version 2 is required"
+			test_done
+			exit
+		fi
+
+		LIB_HTTPD_MODULE_PATH='/usr/lib/apache2/modules'
+	fi
+else
+	error "Could not identify web server at '$LIB_HTTPD_PATH'"
+fi
+
+HTTPD_PARA="-d $HTTPD_ROOT_PATH -f $TEST_PATH/apache.conf"
+
+prepare_httpd() {
+	mkdir -p $HTTPD_DOCUMENT_ROOT_PATH
+
+	ln -s $LIB_HTTPD_MODULE_PATH $HTTPD_ROOT_PATH/modules
+
+	if test -n "$LIB_HTTPD_SSL"
+	then
+		HTTPD_URL=https://127.0.0.1:$LIB_HTTPD_PORT
+
+		RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
+			-config $TEST_PATH/ssl.cnf \
+			-new -x509 -nodes \
+			-out $HTTPD_ROOT_PATH/httpd.pem \
+			-keyout $HTTPD_ROOT_PATH/httpd.pem
+		export GIT_SSL_NO_VERIFY=t
+		HTTPD_PARA="$HTTPD_PARA -DSSL"
+	else
+		HTTPD_URL=http://127.0.0.1:$LIB_HTTPD_PORT
+	fi
+
+	if test -n "$LIB_HTTPD_DAV" -o -n "$LIB_HTTPD_SVN"
+	then
+		HTTPD_PARA="$HTTPD_PARA -DDAV"
+
+		if test -n "$LIB_HTTPD_SVN"
+		then
+			HTTPD_PARA="$HTTPD_PARA -DSVN"
+			rawsvnrepo="$HTTPD_ROOT_PATH/svnrepo"
+			svnrepo="http://127.0.0.1:$LIB_HTTPD_PORT/svn"
+		fi
+	fi
+}
+
+start_httpd() {
+	prepare_httpd
+
+	trap 'stop_httpd; die' exit
+
+	"$LIB_HTTPD_PATH" $HTTPD_PARA \
+		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start
+}
+
+stop_httpd() {
+	trap 'die' exit
+
+	"$LIB_HTTPD_PATH" $HTTPD_PARA -k stop
+}
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
new file mode 100644
index 0000000..a447346
--- /dev/null
+++ b/t/lib-httpd/apache.conf
@@ -0,0 +1,34 @@
+PidFile httpd.pid
+DocumentRoot www
+ErrorLog error.log
+
+<IfDefine SSL>
+LoadModule ssl_module modules/mod_ssl.so
+
+SSLCertificateFile httpd.pem
+SSLCertificateKeyFile httpd.pem
+SSLRandomSeed startup file:/dev/urandom 512
+SSLRandomSeed connect file:/dev/urandom 512
+SSLSessionCache none
+SSLMutex file:ssl_mutex
+SSLEngine On
+</IfDefine>
+
+<IfDefine DAV>
+	LoadModule dav_module modules/mod_dav.so
+	LoadModule dav_fs_module modules/mod_dav_fs.so
+
+	DAVLockDB DAVLock
+	<Location />
+		Dav on
+	</Location>
+</IfDefine>
+
+<IfDefine SVN>
+	LoadModule dav_svn_module modules/mod_dav_svn.so
+
+	<Location /svn>
+		DAV svn
+		SVNPath svnrepo
+	</Location>
+</IfDefine>
diff --git a/t/lib-httpd/ssl.cnf b/t/lib-httpd/ssl.cnf
new file mode 100644
index 0000000..6dab257
--- /dev/null
+++ b/t/lib-httpd/ssl.cnf
@@ -0,0 +1,8 @@
+RANDFILE                = $ENV::RANDFILE_PATH
+
+[ req ]
+default_bits            = 1024
+distinguished_name      = req_distinguished_name
+prompt                  = no
+[ req_distinguished_name ]
+commonName              = 127.0.0.1
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
new file mode 100755
index 0000000..7372439
--- /dev/null
+++ b/t/t5540-http-push.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
+#
+
+test_description='test http-push
+
+This test runs various sanity checks on http-push.'
+
+. ./test-lib.sh
+
+ROOT_PATH="$PWD"
+LIB_HTTPD_DAV=t
+
+. ../lib-httpd.sh
+
+if ! start_httpd >&3 2>&4
+then
+	say "skipping test, web server setup failed"
+	test_done
+	exit
+fi
+
+test_expect_success 'setup remote repository' '
+	cd "$ROOT_PATH" &&
+	mkdir test_repo &&
+	cd test_repo &&
+	git init &&
+	: >path1 &&
+	git add path1 &&
+	test_tick &&
+	git commit -m initial &&
+	cd - &&
+	git clone --bare test_repo test_repo.git &&
+	cd test_repo.git &&
+	git --bare update-server-info &&
+	chmod +x hooks/post-update &&
+	cd - &&
+	mv test_repo.git $HTTPD_DOCUMENT_ROOT_PATH
+'
+	
+test_expect_success 'clone remote repository' '
+	cd "$ROOT_PATH" &&
+	git clone $HTTPD_URL/test_repo.git test_repo_clone
+'
+
+test_expect_success 'push to remote repository' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	: >path2 &&
+	git add path2 &&
+	test_tick &&
+	git commit -m path2 &&
+	git push
+'
+
+test_expect_success 'create and delete remote branch' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	git checkout -b dev &&
+	: >path3 &&
+	git add path3 &&
+	test_tick &&
+	git commit -m dev &&
+	git push origin dev &&
+	git fetch &&
+	git push origin :dev &&
+	git branch -d -r origin/dev &&
+	git fetch &&
+	! git show-ref --verify refs/remotes/origin/dev
+'
+
+stop_httpd
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 83889c4..9d9cb8d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -80,7 +80,7 @@ do
 	-q|--q|--qu|--qui|--quie|--quiet)
 		quiet=t; shift ;;
 	--no-color)
-	    color=; shift ;;
+		color=; shift ;;
 	--no-python)
 		# noop now...
 		shift ;;
@@ -142,7 +142,12 @@ test_count=0
 test_fixed=0
 test_broken=0
 
-trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
+die () {
+	echo >&5 "FATAL: Unexpected exit with code $?"
+	exit 1
+}
+
+trap 'die' exit
 
 test_tick () {
 	if test -z "${test_tick+set}"
-- 
1.5.4.2.156.ge3c5
