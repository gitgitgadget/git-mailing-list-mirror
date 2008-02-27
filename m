From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: add regression tests
Date: Wed, 27 Feb 2008 09:54:42 +0100
Message-ID: <20080227085442.GA22501@localhost>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org> <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org> <20080225232820.GA18254@localhost> <7vprukfttt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 09:55:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUI4O-0008Kc-80
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 09:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbYB0Iym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 03:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbYB0Iym
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 03:54:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:33805 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbYB0Iyl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 03:54:41 -0500
Received: by ug-out-1314.google.com with SMTP id z38so236822ugc.16
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 00:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=EAfLvp4xSskT1yY0fScUGRV1+Gu3TU3L4USUcyfeD3A=;
        b=TbhjV8kzFX7bwIoQHbo+jtyDeKhSDbBKUgKZdweGAettIWNuepOarGW2BQ1xZtcjLiU54GcXqTmBv07m3SNHGTXCq/GAXE2fMcRf0sxHsIgBwfMQoczA/8c/BP/OOIzdL6m8EA1GnBosdrpyvgHJh1SHhdi92Sf0Wp1ypGXTZDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=PQlJZ5kX47rkfjqSWcmVTwZoprsOaaxwfMF4wrLnmQaCItA9Pvp2TUrg7kieue4hjyU8iz2PnoGAvJpe9cvRg5G/dTJeCZY8MftmxA1mRs4EHn4TH7jBWEnkwRXNkpwZy+75KxxeD3G87GnftHfiRbzXkcB/zUn6OFKIXlkCKh0=
Received: by 10.67.100.12 with SMTP id c12mr752442ugm.28.1204102478897;
        Wed, 27 Feb 2008 00:54:38 -0800 (PST)
Received: from darc.dyndns.org ( [84.154.104.122])
        by mx.google.com with ESMTPS id 28sm11950534fkx.11.2008.02.27.00.54.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 00:54:36 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JUI3m-0006Tp-8C; Wed, 27 Feb 2008 09:54:42 +0100
Content-Disposition: inline
In-Reply-To: <7vprukfttt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75214>

http-push tests require a web server with WebDAV support.

This commit introduces a HTTPD test library, which can be configured using
the following environment variables.

LIB_HTTPD_PATH		web server path
LIB_HTTPD_MODULE_PATH	web server modules path
LIB_HTTPD_PORT		listening port
LIB_HTTPD_DAV		enable DAV
LIB_HTTPD_SVN		enable SVN
LIB_HTTPD_SSL		enable SSL

Networking tests are disabled by default. Use GIT_TEST_OPTS=--network to
enable.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Mon, Feb 25, 2008 at 04:24:30PM -0800, Junio C Hamano wrote:
> I'd rather see these tests that are heavyweight and (more
> importantly) open a listened network ports kept strictly
> optional.

Ok. I added the test option --network, which enables networking tests.

> Subversion???  Ah, you are preparing for enhancement of t91XX series?

Yes.

> I have to wonder where it is arranged so that a test failure
> (including ^C out of it, or losing SSH connection to the
> terminal) would cause the server to be killed off.

I simply didn't know how to do that. I now copied the trap mechanism from
test-lib.sh, which I hope is the right thing to do. I didn't want to override
the test-lib.sh trap in lib-httpd.sh, so I wrapped the trap code in the
function die().

On Tue, Feb 26, 2008 at 08:32:06PM +0100, Mike Hommey wrote:
> > +HTTPD_ROOT_PATH="$PWD"/httpd
> > +HTTPD_DOCUMENT_ROOT_PATH="$PWD"/httpd/www
> 
> Why not just use $HTTPD_ROOT_PATH/www and don't use the
> $HTTPD_DOCUMENT_ROOT_PATH variable ?

I wanted to discourage the test case writer to use HTTPD_ROOT_PATH directly,
because it should not be any of his concern.

> > +	mkdir $HTTPD_ROOT_PATH
> > +	mkdir $HTTPD_DOCUMENT_ROOT_PATH
> 
> This could become mkdir -p $HTTPD_ROOT_PATH/www

I wanted to state explicitly that HTTPD_ROOT_PATH and HTTPD_DOCUMENT_ROOT_PATH
do not have to be related. I added the -p flag to both commands, however.

> > +	if test -n "$LIB_HTTPD_SSL"
> > +	if test "$LIB_HTTPD_SSL" != ""
> 
> Why use different tests?

I picked up the latter one while reading code from other tests, so my coding
style changed while implementing this patch. I'll now stick to test -n and test
-z, if that's ok.

> > +		openssl req \
> > +			-config $TEST_PATH/ssl.cnf \
> > +			-new -x509 -nodes \
> > +			-out $HTTPD_ROOT_PATH/httpd.pem \
> > +			-keyout $HTTPD_ROOT_PATH/httpd.pem
> > +		export GIT_SSL_NO_VERIFY=t
> > +		HTTPD_PARA="$HTTPD_PARA -DSSL"
> 
> For future improvement (that could be another patch), it would probably
> be nice to generate a CAcert and a certificate signed by it, so we can
> also test without GIT_SSL_NO_VERIFY.
> 
> By the way, why not just include the .pem ?

I included the generation of the .pem file mainly for documentation purposes
and in order to allow improvements like the one you are suggesting. The
downside is that it requires openssl, but I think whoever wants to test SSL is
likely to have it installed. Right?

> > +stop_httpd() {
> > +	"$LIB_HTTPD_PATH" $HTTPD_PARA -k stop
> > +}
> 
> As Junio said, it might be good to add a trap.

Indeed.

> > +RANDFILE                = $ENV::HOME/.rnd
> 
> Wouldn't it be better elsewhere ?

True.

I tried to incorporate all your suggestions. I hope I didn't miss anything.

Regards,
Clemens

 t/lib-httpd.sh          |   97 +++++++++++++++++++++++++++++++++++++++++++++++
 t/lib-httpd/apache.conf |   34 ++++++++++++++++
 t/lib-httpd/ssl.cnf     |    8 ++++
 t/t5540-http-push.sh    |   73 +++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |   16 +++++++-
 5 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 t/lib-httpd.sh
 create mode 100644 t/lib-httpd/apache.conf
 create mode 100644 t/lib-httpd/ssl.cnf
 create mode 100755 t/t5540-http-push.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
new file mode 100644
index 0000000..2d01fc9
--- /dev/null
+++ b/t/lib-httpd.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
+#
+
+if test -z "$GIT_TEST_NET"
+then
+	say "skipping test, network testing disabled by default"
+	say "(define GIT_TEST_OPTS=--net to enable)"
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
+	mkdir -p $HTTPD_ROOT_PATH
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
index 83889c4..e33b13b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -79,8 +79,10 @@ do
 		verbose=t; shift ;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		quiet=t; shift ;;
+	-n|--n|--ne|--net|--netw|--netwo|--networ|--network)
+		network=t; shift ;;
 	--no-color)
-	    color=; shift ;;
+		color=; shift ;;
 	--no-python)
 		# noop now...
 		shift ;;
@@ -89,6 +91,11 @@ do
 	esac
 done
 
+if test -n "$network"
+then
+	GIT_TEST_NET=t
+fi
+
 if test -n "$color"; then
 	say_color () {
 		case "$1" in
@@ -142,7 +149,12 @@ test_count=0
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
