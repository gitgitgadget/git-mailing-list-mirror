Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07280296BCF
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670067; cv=none; b=ML00uthE0ISlhZoHa76OrP51Pl2rKqXdK7faVLeJFw9jhDjVdOjrcM/BGo7QqJ+l71A1b0dY4jYjT7qkBNPavRnIO6Levinqa4YMNZ18zkyLUzEKRba9p+F1TDjhe2npkDWCp7DFl2RXoXOazwSjenvIpPYQtBnaYPZu4b9ERjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670067; c=relaxed/simple;
	bh=bSjY6HeucESpmsL3SNIMsjtiJN1P6j2BZu3GbFLhO/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4x9LOf/4/WEhy559MZQR1nBDjFPsmm1rFltlKM3Hnv/6LFnhgUix+KFisl9JkC6oFXLetSKrZiyNFxxHcq2bkJKhjbVGhx+9SUCBtwCiWRxbcG40i00Y3Pg0+xyi0GRMhUU8Zfc67gbvH4xJ8WCttVJq7Pb1LFY7a6coCetGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fAd9giHN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c7gmgIlG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fAd9giHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7gmgIlG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DC5914000A7;
	Mon, 20 Apr 2026 03:27:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 03:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670065;
	 x=1776756465; bh=dS7Ogq0jZCBGKLLzJQE+9s0i4gbVqAFfO5TnqWKWnhY=; b=
	fAd9giHNaBqZ9q2XiWVv5KRXax/AtmB1AgqfQYOVOZGWbuGNJQ6OGtYezkjemUJ1
	Kx1bn9GqnuFMgsUE7W7Nh0obj0y2xY4JUELVX1MXplDhTa4c2AmaKFDKl05bFB/Z
	nXvQjZ5jxcvZ/ze2/QvHVO5I/xorMVASVrgqe0h/MSJw1bLs2WGAIE5EtCSxzBw3
	vUuUmpG+dDmE6fSTr588/OelDktUfDxgumXr4G3hETdbFgq1H6kdadoGhP/vimnE
	h/imAP+lUjndcK3Fltaa2eSZEGGSKLsDoSZkAPLxjuN16tNNMRQsn7UvyWEggYAb
	R6PY1FMIWMUOLVaYT08fcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670065; x=
	1776756465; bh=dS7Ogq0jZCBGKLLzJQE+9s0i4gbVqAFfO5TnqWKWnhY=; b=c
	7gmgIlGxNIIzBJzv+WSvSRDscKmxxpUSg+xH4eq6BuQhvK+o9Kem0coiXB+Hw/PD
	vvHwB/Cx/X3LrhH1CqZ7bXAwEppwbXMeOFaiorSHmvor7L3vLwcN7RXl0Kmzzw7v
	QIBtlFmczk0Gv6wASmngfnUoXR8DPD99Tk+vNB3R/OGBwto9gvBM3ob+Q61w1mtZ
	DPIV6wpW1o9j3dI2P1XOmy6gb4tHFZPxYqIPrPKu2q6TF8MUFJkuR1QtTv8uirwL
	SqWQ7+MxaiL3Qb23nN3VUWVhXVGbFL3loKrCW2o/6MAxEb6O+CQFDlr8NdvPncC6
	xHUe7nSbQD+Qg9jvTCesQ==
X-ME-Sender: <xms:cdXlacVFuPGn-plPRhTxsAAnRDLHae7RXENG15su6WWNxEttOAuLOw>
    <xme:cdXlaXlz7wRZeCjnTY5WTMkBnMk53sHPaUNklkksZNDm4lPyttWDkVo8kQ5-BnDvy
    ASEf6QJuXrUqpJu2PdvoqdaQ1CoGuZsX2XaObpurmtKCS6qqD7meg>
X-ME-Received: <xmr:cdXlaVbuKAuuPpgAFTljMeX5BXLEA5FSJWkzvzlgrXn415_7Qs9ofRj4WziLD8wpiUKp2EgWKmzHjydwMgELJXAG30MqO1yyfvhrisDPL1Ys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvjeetteffheejveelvdffffffvefhffeije
    ffleeigffhveeigeffvdehtdekudenucffohhmrghinhephhhtthhpugdrshhhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cdXlaaPM9qq1W7W1M69BleBxb-THozQ1_zdaEd0LOHHry6cCOF5bWA>
    <xmx:cdXlaSbJdDRlh6bH2x8UqMYwPGBLChwUHvcVIaJSn7EOcNiBF16RBA>
    <xmx:cdXlaQ0XEPSVffWIUcAGrO3Orv5G2PYI74RiPoyBQXpsVJvuZP6D9g>
    <xmx:cdXlaQeSdm1tjD8LicLbscQaJRmBUQUJbkoMQjglQX0Zfa1t0VVLRg>
    <xmx:cdXladXBgwptyXSPmHMdf0v56Ckz57tjzgiANKuZw9KqpL4VS2BNwS0->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48ce0dc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:25 +0200
Subject: [PATCH v5 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-6-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
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
 t/t1410-reflog.sh               |  2 +-
 t/t3901-i18n-patch.sh           |  3 ++-
 t/t5000-tar-tree.sh             |  4 ++--
 t/t7422-submodule-output.sh     |  2 +-
 t/t9200-git-cvsexportcommit.sh  |  3 +--
 t/t9400-git-cvsserver-server.sh |  5 +++--
 t/t9401-git-cvsserver-crlf.sh   |  4 ++--
 t/t9402-git-cvsserver-refs.sh   |  4 ++--
 t/test-lib-functions.sh         |  3 +--
 t/test-lib.sh                   | 10 ++++++----
 12 files changed, 25 insertions(+), 25 deletions(-)

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
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ce71f9a30a..f289fc11e9 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -23,7 +23,7 @@ check_have () {
 }
 
 check_fsck () {
-	git fsck --full >fsck.output
+	git fsck --full >fsck.output || true
 	case "$1" in
 	'')
 		test_must_be_empty fsck.output ;;
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

