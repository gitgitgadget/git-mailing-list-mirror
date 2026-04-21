Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C96382F35
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756877; cv=none; b=l3zmaVwcnTF5ochmAjqXUvXyzgbbKy/+jchrxeHd/TVXqVtiT8o+LqJGSX/qSfZexpBGMJFttxTjvStdfhSzhInwmQsA+bT6y04Fxe8MeYHzC1l/ZKfj2lmiZuhZe1aIIqd0mmbiToH6Ai5hJ+HwJvPXxguO7qZEKHQMlmg8+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756877; c=relaxed/simple;
	bh=SOc8EpZO1e3jmcJAzdgWVL5UjOs566WnAa6MoZdMTcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XR+Kkh53HyWFy0ckZa77Bao8UUsULNdq2VIa708vylvGhxYXGKf2evdUDB0Rbfjp3N+x5uvAUUDmbB3qmJPJrT6RhkRuZZLwSZdCyQGfK5nEgs5zmij/lewYL6PqDxzGSixqYffknP5T3Tsrkm9QC1OTIB32YeZEdq83P14fLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xScdGOut; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NgsBWTKA; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xScdGOut";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NgsBWTKA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75BF5140006E;
	Tue, 21 Apr 2026 03:34:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 21 Apr 2026 03:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756875;
	 x=1776843275; bh=NSA8AMa22cqyze1sgDe3zr+We+94p3mhZ6/lgI9YIOY=; b=
	xScdGOutIuZsLra8ErcZVZPbdMNve26cgX+BU900fP+42MABKixRQURZaM6l5fJC
	XkN5wdbFu2mY+Qwuaah2Y2oBmLvDZDY4gHi16zmUQAceC1eRwcYACwk8nlftn1Ib
	W0uWTtDvC2bpdWi/WlwlEXIqS61XLyr5cOz1X0T6V2KK50SZJJ0sgfNL3UcCxHGT
	WVtVUI50W/g39OHeIwX7uCCw34/NcYFH11oIW9n1D3wi/XxLJwEZF6rarzZl7uJ8
	e1hTZNbo5LwRSwBmQaCEX1C/veKU71hvnsyeCjh4RpG45Zu+z3VRyphXqTCYbLMP
	LWHrMvfYTtSI+xTrHRn3wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756875; x=
	1776843275; bh=NSA8AMa22cqyze1sgDe3zr+We+94p3mhZ6/lgI9YIOY=; b=N
	gsBWTKAxLSdOryAoQy/e7Umg70PdpcwJimeEr0RQaANIXp13WD2tXWVL0OMVUHIE
	NRAJdSiU4d83LWaOF/OS/tzBrO4c6bOrWgKPffPuWbh3A3VlvykBmMjaVHALlN6N
	z1MFG7Ws1ZKipsWChYmEm3XVYM/YBLEUpAD16+Eaj4JHPl7lw63Ac0Fyk3goACaE
	1zLzEqwZVozQY4Hc2D4029DGopoOoXDUVCom3FoTad681OvBP9gknEj5cFWzPV2N
	wrhBAVkESYiA02hF0CNK8P7ZP6fF92lZs/+x2nLYaEGDjMSMRLPIsabyESeLW0N8
	nJdXKPZ38a01HOvjy1/iA==
X-ME-Sender: <xms:iyjnad09s08wO3M67M7H1DMFjYgdxFo_hQAJbHZHZz8I9U9iion_xA>
    <xme:iyjnabGl0Andmx0bauMEK_AGxFfqYh2231SOfkaWY_QMEjBt4fcxJdWTU4YEOoPQb
    SkoUGcSFGIQW3ZXcLBHNRMTMsMESLU5Gb6NbqqrCNnM1szZb0Vpqyo>
X-ME-Received: <xmr:iyjnaS6gyU1c9aDIsjvqSCpyk6Gdi44jE9pzeltkU0ROlvbIzp4gvheqsnsQVDkuJsgSsjzds0JLtLukxxuSk95kVYW7qKvfcNjtq6Tqcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvjeetteffheejveelvdffffffvefhffeije
    ffleeigffhveeigeffvdehtdekudenucffohhmrghinhephhhtthhpugdrshhhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iyjnaZuVSqym9u4LVtOp80_LptcPxAq1ubVwFaGsGGSeSxH3RKHdwQ>
    <xmx:iyjnab4qUGCy6mXCkw1Iivj0JckzKfFwI5yVzgvOEANv2II9QcJOcg>
    <xmx:iyjnacU0R4Jar-YqHJB78QbOD-euzt2RlXZ0kqkbOfDESJpacs0iOA>
    <xmx:iyjnaV-JQXUQ5BCa9GDDLzYp6bG7uvSj4LA3z81CLrWn83h1_YioLA>
    <xmx:iyjnaa1UKZ6runc8Ix93YbksHVLm9yTefrVUWlqzOtRG-9wH4UMD4ejf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3dfc95a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:19 +0200
Subject: [PATCH v6 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-6-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

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
2.54.0.545.g6539524ca2.dirty

