Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A713624A9
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423076; cv=none; b=GqecU2+sNd9xWoWlaGLLGMDFDVmmuCykb5hUxt8E0AHix8FL1mT3CmWroYisBd18qRW9ZvieaRHsoFN9m2N+WjhYBZUJQEnSTREyJARbGh8JYyAaRh85sw7xDioIDPj5ZfNuuMjg03vJpIESD2WH7LS5yWXblh2ADDMgUHvq5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423076; c=relaxed/simple;
	bh=68/hg3ipVIwPSImyqghz0uiH/40vQQJ+Wa3r+Cc2gY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4/CAh70gjtQJ0HLZSZVLaD8oxpjxHLaCwd7JMR9rgMXI2LfFGNtkRR/OshCCUy0AXCO61T5MhGLAnoz7VCMqL6fk9vPIRvCvfSSa0uj790H8txKYguc76wdWRnL7+B+8/oFHgiIkkL1Oq05+NjOl0brnG8Y7D6MKX8lXZmApbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J+bMGeHM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=caD5wZP3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J+bMGeHM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="caD5wZP3"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 753D31400131;
	Fri, 17 Apr 2026 06:51:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 17 Apr 2026 06:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423073;
	 x=1776509473; bh=3L0LGpx/c1a7sBKcKcMVX6nza6bJbv09S1AYPnmYewk=; b=
	J+bMGeHMfKkc8zVLrFPrRra6jPAeyCsUts2ukVLlzGuaZfJN/62R8ekne+s8Lb5s
	Os/LzRdWtX1bi/+n5EeMaCcziFEjG0bdAgWEL78yP6KW2DQGXes88QkVKaTDJE9A
	2B81sMRa2u1dVsG+lVU6HtNee7yk7qXA8pu66BxZh96u2TZ5MgUD4IQacXkhBXHq
	3HVTEYzMUNJODzeUTrhV5PJdLZB27kDsJN6iiwZVGtST42P+FWpBPEDnIKdkpFmH
	k1a+UY52j54LwmyLFTrDqY5ZEJvJ3gxZ3he3LstFUuBVMSAtZnMzKeJMv88BKT0R
	M70cz/AI9gfvKlwMRVUevQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423073; x=
	1776509473; bh=3L0LGpx/c1a7sBKcKcMVX6nza6bJbv09S1AYPnmYewk=; b=c
	aD5wZP3bn6P3gk2cp05RA4oCBW28M/SZRxHs8Lfq3Q3OLEWEZnihmVlb7TiFt4+X
	mQiTMnZmGny5iHIFQcXjm9sgngfUCKamQvY+s146i/a2QYwet5as8k5SlACR/hOW
	Gn/USzJ3Molh47/fCWWU58HMopjSsuhFcvloX/T/A2AJFTMoq4S1fui1kuJVGTit
	Z/TB1HJN6BwKdJF9nubZTpLsrMy/KAQFH3R4TQZV4Xo25HyZv4EVNO2EOnefsDHB
	YUozMcFDgzmNRi23E5vOycuhUOERQwp+fIgz7a6p4yzUJZZc/d1C+K6yKp9P5KIz
	nP/g4hhf+8q5rDnGLaoow==
X-ME-Sender: <xms:oRDiadnPe0jTq0WiNLeBg-ruibSyKGV6fSJDUP1FASzaXnSdQOwmqQ>
    <xme:oRDiaf01r0YTo5Ya9ThZiuUr-z9ZYhbHsyv5TwKJL2THkzW02-wCPBtKydgQVo1k0
    hlIPSM-vGQpvEBsfj1F66TJLM1lTrvFbF6-Wva83EDen83H3Z-Y5Q>
X-ME-Received: <xmr:oRDiaYpYQRxmRT9mnLTxWbsHSJSfxzV9DSKqxLzy4Iks1XzBPqtdmEQDYR_MMWV86Jy792RIsAzWEkxYddWEa9l9eqWru579N6rES4k4iCOm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvjeetteffheejveelvdffffffvefhffeije
    ffleeigffhveeigeffvdehtdekudenucffohhmrghinhephhhtthhpugdrshhhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oRDiace8tuFv0L_yqKomaVg8eyf_08l4AGVXQEmsG9cLC5OXTRGqzw>
    <xmx:oRDiaXpgHo9xQlFmnqiuX24OKZX0OM_zHQPcY940hQQI2fpYhRuIIw>
    <xmx:oRDiadH9qkU7xVBG7Jlbcj_6BzTBudsfz0XYIIUhrAKQ5iYX4RM30Q>
    <xmx:oRDiaXvrbgweFt3lTes5HYynLVf1F1NBmLnoGAvFgNJdSr7ZY9PwfQ>
    <xmx:oRDiaYknBwJtQeBZV5psdlF4jFgavb5Z7aFBjtD6-Usxn4sLLmFzIofk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1fe3ceef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:52 +0200
Subject: [PATCH v4 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-6-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

Several of our tests verify whether a certain binary can be executed,
potentially skipping tests in case we cannot, for example because the
binary doesn't exist. In those cases we often run the binary outside of
any conditionally.

This will start to fail once we enable `set -e`, as that will cause us
to bail out the test immediately. Improve these tests by executing them
inside of a conditional instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-svn.sh                |  7 +++----
 t/lib-httpd.sh                  |  3 +--
 t/t3901-i18n-patch.sh           |  3 ++-
 t/t5000-tar-tree.sh             |  4 ++--
 t/t7422-submodule-output.sh     |  2 +-
 t/t9200-git-cvsexportcommit.sh  |  3 +--
 t/t9400-git-cvsserver-server.sh |  5 +++--
 t/t9401-git-cvsserver-crlf.sh   |  4 ++--
 t/t9402-git-cvsserver-refs.sh   |  4 ++--
 t/test-lib-functions.sh         |  3 +--
 t/test-lib.sh                   | 10 ++++++----
 11 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 2fde2353fd..52843f667d 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -15,8 +15,7 @@ GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
 SVN_TREE=$GIT_SVN_DIR/svn-tree
 test_set_port SVNSERVE_PORT
 
-svn >/dev/null 2>&1
-if test $? -ne 1
+if ! svn help >/dev/null 2>&1
 then
 	skip_all='skipping git svn tests, svn not found'
 	test_done
@@ -27,13 +26,13 @@ export svnrepo
 svnconf=$PWD/svnconf
 export svnconf
 
+x=0
 perl -w -e "
 use SVN::Core;
 use SVN::Repos;
 \$SVN::Core::VERSION gt '1.1.0' or exit(42);
 system(qw/svnadmin create --fs-type fsfs/, \$ENV{svnrepo}) == 0 or exit(41);
-" >&3 2>&4
-x=$?
+" >&3 2>&4 || x=$?
 if test $x -ne 0
 then
 	if test $x -eq 42; then
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 4c76e813e3..fc646447d5 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -235,11 +235,10 @@ start_httpd() {
 
 	test_atexit stop_httpd
 
-	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
+	if ! "$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
 		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start \
 		>&3 2>&4
-	if test $? -ne 0
 	then
 		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
 		test_skip_or_die GIT_TEST_HTTPD "web server setup failed"
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index f03601b49a..ef7d7e1edc 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -28,7 +28,8 @@ check_encoding () {
 		8859)
 			grep "^encoding ISO8859-1" ;;
 		*)
-			grep "^encoding ISO8859-1"; test "$?" != 0 ;;
+			ret=0; grep "^encoding ISO8859-1" || ret=$?
+			test "$ret" != 0 ;;
 		esac || return 1
 		j=$i
 		i=$(($i+1))
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 5465054f17..a8c28533dc 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -503,8 +503,8 @@ test_expect_success LONG_IS_64BIT 'set up repository with huge blob' '
 # would generate the whole 64GB).
 test_expect_success LONG_IS_64BIT 'generate tar with huge size' '
 	{
-		git archive HEAD
-		echo $? >exit-code
+		{ ret=0 && git archive HEAD || ret=$?; } &&
+		echo "$ret" >exit-code
 	} | test_copy_bytes 4096 >huge.tar &&
 	echo 141 >expect &&
 	test_cmp expect exit-code
diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index aea1ddf117..852136fdfd 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -198,7 +198,7 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
 	(
 		cd repo &&
 		GIT_ALLOW_PROTOCOL=file git submodule add "$(pwd)"/../submodule &&
-		{ git submodule status --recursive 2>err; echo $?>status; } |
+		{ { ret=0 && git submodule status --recursive 2>err || ret=$?; } && echo $ret >status; } |
 			grep -q recursive-submodule-path-1 &&
 		test_must_be_empty err &&
 		test_match_signal 13 "$(cat status)"
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 14cbe96527..581cf3d28f 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -11,8 +11,7 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
-cvs >/dev/null 2>&1
-if test $? -ne 1
+if ! cvs version >/dev/null 2>&1
 then
     skip_all='skipping git cvsexportcommit tests, cvs not found'
     test_done
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e499c7f955..4b45398bab 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -17,12 +17,13 @@ if ! test_have_prereq PERL; then
 	skip_all='skipping git cvsserver tests, perl not available'
 	test_done
 fi
-cvs >/dev/null 2>&1
-if test $? -ne 1
+
+if ! cvs version >/dev/null 2>&1
 then
     skip_all='skipping git-cvsserver tests, cvs not found'
     test_done
 fi
+
 perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     skip_all='skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index a34805acdc..6b4cbb1651 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -60,12 +60,12 @@ check_status_options() {
     return $stat
 }
 
-cvs >/dev/null 2>&1
-if test $? -ne 1
+if ! cvs version >/dev/null 2>&1
 then
     skip_all='skipping git-cvsserver tests, cvs not found'
     test_done
 fi
+
 if ! test_have_prereq PERL
 then
     skip_all='skipping git-cvsserver tests, perl not available'
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 2ee41f9443..65f2ceedec 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -68,12 +68,12 @@ check_diff() {
 
 #########
 
-cvs >/dev/null 2>&1
-if test $? -ne 1
+if ! cvs version >/dev/null 2>&1
 then
 	skip_all='skipping git-cvsserver tests, cvs not found'
 	test_done
 fi
+
 if ! test_have_prereq PERL
 then
 	skip_all='skipping git-cvsserver tests, perl not available'
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5fd5494ef1..879ee1ee59 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1248,8 +1248,7 @@ test_might_fail () {
 test_expect_code () {
 	want_code=$1
 	shift
-	"$@" 2>&7
-	exit_code=$?
+	exit_code=0; "$@" 2>&7 || exit_code=$?
 	if test $exit_code = $want_code
 	then
 		return 0
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 70fd3e9baf..de7d9e7b92 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -143,8 +143,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 ################################################################
 # It appears that people try to run tests without building...
 GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
-"$GIT_BINARY" >/dev/null
-if test $? != 1
+
+if ! "$GIT_BINARY" version >/dev/null
 then
 	if test -n "$GIT_TEST_INSTALLED"
 	then
@@ -454,8 +454,10 @@ then
 	# from any previous runs.
 	>"$GIT_TEST_TEE_OUTPUT_FILE"
 
-	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
-	 echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
+	(
+		ret=0 && GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1 || ret=$?
+		echo "$ret" >"$TEST_RESULTS_BASE.exit"
+	) | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
 	exit
 fi

-- 
2.54.0.rc2.529.gd9106f7525.dirty

