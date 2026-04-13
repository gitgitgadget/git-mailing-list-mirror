Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89403B2FC9
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073785; cv=none; b=mu+dGTBosKq3B3V6vyYA76sk7aWU3HCG8MzdudMWxWPKKHFdUi94QA06I8yQtBu7RweGI/Lv71sqKGsS83T/CvAqY/ufxnkei6QwZn2gbQlq+otMWHnrDgFTl06u4o4iZU1gA9rYPUlR0hxOMaE3f7y0NdlwLVgXUGHqilEmaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073785; c=relaxed/simple;
	bh=y46AVntuVfkE7Yo6x5zIeJO3KtgsnFDPueptAkbFV/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqAo1MBxurCTwatZQkJ4BsfFmlm6IEZID9WZFKRIQoS1C2gRNWWsireWCbV2dDHnGIHWFO8eJdAgyq9Od34HVZG2c5832waCE39oatzCtUOWWadgwj8KMbvrP7xC66NWTPlDaKYZJqUSMIMamjCEdFgT9x7/aBt8Q8hGb4huKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xIaenyoC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EeQ/cYvv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xIaenyoC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EeQ/cYvv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26E4A1400183;
	Mon, 13 Apr 2026 05:49:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 05:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073783;
	 x=1776160183; bh=R5w+Uv96MhlcVT8hbR5itP8JMCs5U/A3axREcd5IhqM=; b=
	xIaenyoCQfYBgi8k2bR+OTTdtVgCY+lMR4szK505VM69UYZj443m6mlHwbV3t4Hi
	P+hK4Le3t48Kpqf4cPWFybtio9g8M4Ir4eMDDdcgwLaLb9PhUscbNagCIRsvzZMg
	OQLnZyjRUOlUWtDwwUuUEUm4LFbLdu4hEwT6L65W6/5WI1zptTXbK1u57HeCOJhD
	KKxvKCeU2+k0RtVPDdQ4eztUzKbZ9v7uRfM7fJD8wGoIOt/iKVRhiXvi672gqDN8
	0XknFBlrsLGGaRDJ/3QRp8nEwPXpNSGWopD7DKOmEe6HGZBvUyI/UNyeiKAKArYu
	itb3zBH+FsOh2LCwefjyCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073783; x=
	1776160183; bh=R5w+Uv96MhlcVT8hbR5itP8JMCs5U/A3axREcd5IhqM=; b=E
	eQ/cYvvPUa5g/YkLnW0eIKs/4Uz8NCuWI79kIu6REFtKxdAZwaElGgHopIJmLFFB
	YUx8CxW6bi/IwOCfnTN26c/60kEO0IZOeUVj5RT0+Aq59txmaoLwJObK0vUZ8cIw
	CWeLiWmrK42wXkVeTd74xJ5gB5KYRYG0oWTt+CIuXwf9WjDGGJJyRokkaxGKLfbm
	E1zzcPmldlOO3siEMBKljHvnV9eGjLiz/FQNdYsfnda9TD0s7PEkxYgT2rkfC0mG
	MhWBu1MWXtI9KaJoSwQ0oZuOjFDbF4fW7mO5nbHp24MrbHycGXuChWm/rDhITAgc
	s2d0vGXPqeOMEArgER/TA==
X-ME-Sender: <xms:N7zcaWTM-LWsZ2Z_vFaO1lTJtGqq0xJZqLpf5sRpXtgEMB3MNnjF2Q>
    <xme:N7zcaRx-VP8-QOOvq9sCwsFnqHJJ2dV3HEKsE3mJfF6li4_pBQRllqDLBNBwhCCBz
    dj9uSDKTAvmJLH_M-wXEnvCma5O4GbuxPYkUe3wJ2jlM_nvPuznxMM>
X-ME-Received: <xmr:N7zcaRfQX16qb7RXWPy4RU80BL1T2orPWa8Yxq37E-yRXsCIdaPILFW8VRSbiKXYyvqFOqq2EkWald6Ok1hLUJ1aTNX_wkZqY-SUyhn9oRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvjeetteffheejveelvdffffffvefhffeije
    ffleeigffhveeigeffvdehtdekudenucffohhmrghinhephhhtthhpugdrshhhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:N7zcadKMzjJ6SWLLCxIdQxdBld9uGz-8sObLjsQSRr1dZJfw6JuiFA>
    <xmx:N7zcaSEf1QvzJtDFo2JhJTHnoDKRFtv0R_PQ4hdX9IIitOyNiNEwsA>
    <xmx:N7zcaXrSuXHsdSM9gUKYyVPoUIkWiXKcUggw3iM6ZQ8GOiGAkrpY-A>
    <xmx:N7zcabTsRA--egcBmzKqGbvrsfcYfCqDbeYmKZaDQ9gc8OpLFmWsDg>
    <xmx:N7zcacW3CilugnuV1ObNncNrbceBuNAE2NlPP54S-8H8wVvzXlKooqiW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90a2682e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:27 +0200
Subject: [PATCH 06/12] t: prepare execution of potentially failing commands
 for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
 t/lib-git-svn.sh                | 3 +--
 t/lib-httpd.sh                  | 3 +--
 t/t9200-git-cvsexportcommit.sh  | 3 +--
 t/t9400-git-cvsserver-server.sh | 5 +++--
 t/t9401-git-cvsserver-crlf.sh   | 4 ++--
 t/t9402-git-cvsserver-refs.sh   | 4 ++--
 t/test-lib.sh                   | 4 ++--
 7 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 2fde2353fd..07d86ea244 100644
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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 70fd3e9baf..81380fe978 100644
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

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

