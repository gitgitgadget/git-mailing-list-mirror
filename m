Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9319A20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 22:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeLIW4s (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 17:56:48 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38427 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLIW4r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 17:56:47 -0500
Received: by mail-wm1-f48.google.com with SMTP id m22so9386495wml.3
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 14:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pqn52Ct7RhIwYD3wiHqnQPEVBAA9fM7H6DSStXSYpmw=;
        b=XtNWBNovrPA2FgsEaQyfOT6xgWCqqasuLWAHkycaZgl48mbaJOEqnPgVnxB9Kp7Fhu
         eeRI3wWdkrqO3qasAtBj2+xkqzjYlAvlpekjczTU1s/xXf6pkl2/EHK0WCMHllHnyJBU
         fCanFrTf2hzoKiYMd56DJWkC6NMlC4ksZ9xbjX2drdRBOTfskLeqXeOflmJrC2ifqc6M
         YnflTttllaosnYgxpt4A5bhIF2HRXLn2PcGRI8eDwqd6VWDDEtkGr2hoBlMRSU9wCLQg
         lZyM4Lq4sNB6/e2EsZV9BJMfXKxBN9rvHqLGyZ2qN+BLVFY+X+EaHT4RbDl0WUbq2pSn
         pJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pqn52Ct7RhIwYD3wiHqnQPEVBAA9fM7H6DSStXSYpmw=;
        b=OcUFLf4CN7WmVQblJgFoLgXOpba3Oriz2vCgc3pu3KgYQLjMMhBHDKTkhdnZXJ9iIW
         CDpQDp7BJSLFRy2nIw5ptY7wdqiQsuvQUYwo40GR4ywDYcgJimgGKOFAIKCpSNtJar9j
         cxcIxAOSLi7thA6aHh3T4g2z3oovswQ7fsLKxHd207iUAGq8bY16jQTLcfuR2L2KtoAb
         0hEOlduBEwUx9Pb01KrtF3ydI2T+oEYfu8zdeo5FJKGpLcQW8A2Be1q2OAD+7RdVVpOV
         dY71Mi633b353E5FjPisItP3hg0x0rchEy7wop4FbXYm1x1BrZnZuQYufpozmVKnCCSM
         jq8Q==
X-Gm-Message-State: AA+aEWZne6k0Buw65i7Fte/ENS489UxHSP+OUGV0Idvicj+G+V7llPFw
        BimlnvNP+enjJo2litELargJHwjM
X-Google-Smtp-Source: AFSGD/XRFPNjbvPrn30ruwNXczlM3HWl3DXugSNyZJWWjpToBGsSpW7wEAi8JU/+S22wmNAdj1Z2QQ==
X-Received: by 2002:a1c:868a:: with SMTP id i132mr8361303wmd.49.1544396204009;
        Sun, 09 Dec 2018 14:56:44 -0800 (PST)
Received: from localhost.localdomain (x4db97970.dyn.telefonica.de. [77.185.121.112])
        by smtp.gmail.com with ESMTPSA id w6sm12581807wme.46.2018.12.09.14.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 14:56:43 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 6/7] test-lib-functions: introduce the 'test_set_port' helper function
Date:   Sun,  9 Dec 2018 23:56:27 +0100
Message-Id: <20181209225628.22216-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181209225628.22216-1-szeder.dev@gmail.com>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several test scripts run daemons like 'git-daemon' or Apache, and
communicate with them through TCP sockets.  To have unique ports where
these daemons are accessible, the ports are usually the number of the
corresponding test scripts, unless the user overrides them via
environment variables, and thus all those tests and test libs contain
more or less the same bit of one-liner boilerplate code to find out
the port.  The last patch in this series will make this a bit more
complicated.

Factor out finding the port for a daemon into the common helper
function 'test_set_port' to avoid repeating ourselves.

Take special care of test scripts with "low" numbers:

  - Test numbers below 1024 would result in a port that's only usable
    as root, so set their port to '10000 + test-nr' to make sure it
    doesn't interfere with other tests in the test suite.  This makes
    the hardcoded port number in 't0410-partial-clone.sh' unnecessary,
    remove it.

  - The shell's arithmetic evaluation interprets numbers with leading
    zeros as octal values, which means that test number below 1000 and
    containing the digits 8 or 9 will trigger an error.  Remove all
    leading zeros from the test numbers to prevent this.

Note that the 'git p4' tests are unlike the other tests involving
daemons in that:

  - 'lib-git-p4.sh' doesn't use the test's number for unique port as
    is, but does a bit of additional arithmetic on top [1].

  - The port is not overridable via an environment variable.

With this patch even 'git p4' tests will use the test's number as
default port, and it will be overridable via the P4DPORT environment
variable.

[1] Commit fc00233071 (git-p4 tests: refactor and cleanup, 2011-08-22)
    introduced that "unusual" unique port computation without
    explaining why it was necessary (as opposed to simply using the
    test number as is).  It seems to be just unnecessary complication,
    and in any case that commit came way before the "test nr as unique
    port" got "standardized" for other daemons in commits c44132fcf3
    (tests: auto-set git-daemon port, 2014-02-10), 3bb486e439 (tests:
    auto-set LIB_HTTPD_PORT from test name, 2014-02-10), and
    bf9d7df950 (t/lib-git-svn.sh: improve svnserve tests with parallel
    make test, 2017-12-01).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-git-daemon.sh      |  2 +-
 t/lib-git-p4.sh          |  9 +--------
 t/lib-git-svn.sh         |  2 +-
 t/lib-httpd.sh           |  2 +-
 t/t0410-partial-clone.sh |  1 -
 t/t5512-ls-remote.sh     |  2 +-
 t/test-lib-functions.sh  | 36 ++++++++++++++++++++++++++++++++++++
 7 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index f98de95c15..41eb1e3ae8 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -28,7 +28,7 @@ then
 	test_skip_or_die $GIT_TEST_GIT_DAEMON "file system does not support FIFOs"
 fi
 
-LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-${this_test#t}}
+test_set_port LIB_GIT_DAEMON_PORT
 
 GIT_DAEMON_PID=
 GIT_DAEMON_DOCUMENT_ROOT_PATH="$PWD"/repo
diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index c27599474c..b3be3ba011 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -53,14 +53,7 @@ time_in_seconds () {
 	(cd / && "$PYTHON_PATH" -c 'import time; print(int(time.time()))')
 }
 
-# Try to pick a unique port: guess a large number, then hope
-# no more than one of each test is running.
-#
-# This does not handle the case where somebody else is running the
-# same tests and has chosen the same ports.
-testid=${this_test#t}
-git_p4_test_start=9800
-P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
+test_set_port P4DPORT
 
 P4PORT=localhost:$P4DPORT
 P4CLIENT=client
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index a8130f9119..f3b478c307 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -13,6 +13,7 @@ fi
 GIT_DIR=$PWD/.git
 GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
 SVN_TREE=$GIT_SVN_DIR/svn-tree
+test_set_port SVNSERVE_PORT
 
 svn >/dev/null 2>&1
 if test $? -ne 1
@@ -119,7 +120,6 @@ require_svnserve () {
 }
 
 start_svnserve () {
-	SVNSERVE_PORT=${SVNSERVE_PORT-${this_test#t}}
 	svnserve --listen-port $SVNSERVE_PORT \
 		 --root "$rawsvnrepo" \
 		 --listen-once \
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index a8729f8232..e465116ef9 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -82,7 +82,7 @@ case $(uname) in
 esac
 
 LIB_HTTPD_PATH=${LIB_HTTPD_PATH-"$DEFAULT_HTTPD_PATH"}
-LIB_HTTPD_PORT=${LIB_HTTPD_PORT-${this_test#t}}
+test_set_port LIB_HTTPD_PORT
 
 TEST_PATH="$TEST_DIRECTORY"/lib-httpd
 HTTPD_ROOT_PATH="$PWD"/httpd
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index ba3887f178..0aca8d7588 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -480,7 +480,6 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
 	! grep "$TREE_HASH" out
 '
 
-LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 32e722db2e..cd9e60632d 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -260,7 +260,7 @@ test_lazy_prereq GIT_DAEMON '
 # This test spawns a daemon, so run it only if the user would be OK with
 # testing with git-daemon.
 test_expect_success PIPE,JGIT,GIT_DAEMON 'indicate no refs in standards-compliant empty remote' '
-	JGIT_DAEMON_PORT=${JGIT_DAEMON_PORT-${this_test#t}} &&
+	test_set_port JGIT_DAEMON_PORT &&
 	JGIT_DAEMON_PID= &&
 	git init --bare empty.git &&
 	>empty.git/git-daemon-export-ok &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6b3bbf99e4..3746327bde 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1263,3 +1263,39 @@ test_oid () {
 	fi &&
 	eval "printf '%s' \"\${$var}\""
 }
+
+# Choose a port number based on the test script's number and store it in
+# the given variable name, unless that variable already contains a number.
+test_set_port () {
+	local var=$1 port
+
+	if test $# -ne 1 || test -z "$var"
+	then
+		BUG "test_set_port requires a variable name"
+	fi
+
+	eval port=\$$var
+	case "$port" in
+	"")
+		# No port is set in the given env var, use the test
+		# number as port number instead.
+		# Remove not only the leading 't', but all leading zeros
+		# as well, so the arithmetic below won't (mis)interpret
+		# a test number like '0123' as an octal value.
+		port=${this_test#${this_test%%[1-9]*}}
+		if test "${port:-0}" -lt 1024
+		then
+			# root-only port, use a larger one instead.
+			port=$(($port + 10000))
+		fi
+
+		eval $var=$port
+		;;
+	*[^0-9]*)
+		error >&7 "invalid port number: $port"
+		;;
+	*)
+		# The user has specified the port.
+		;;
+	esac
+}
-- 
2.20.0.rc2.156.g5a9fd2ce9c

