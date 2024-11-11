Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2219C566
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321552; cv=none; b=iLNuBVobVq4Q7GaBaf1ms8IiuHdn0iDT71zJNGLloEFb45qJGQvFI8lYOAdaCvebbLVYGcLG4HyEkPfdQkOVZ7mzU2Snav8lOjD1nYj6glCOhR1pB32yUWGNLWQ3e8oI9QbXi7jcEdxDig+TWcw4D+J3+v/BORawFt4S+s/WfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321552; c=relaxed/simple;
	bh=AZBHiaXgAYBW9+YHBY8Hj4IMh9aCk/MRJnr+vHAbi8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYHqXXf5ai73FLQQB8aZyBUkVgdv66r/s4lW5kTLhUL1CH2gliYUNSfhzfhR02z6tw8B0hibHPGx9VJzHpTxfJjli5izzk2szE4SiICcYDVIosaZHhTay7kjRJW1JRUFmGtSP/U4nLEUZguZF1gO5R/RienM11YJo7DruyoZnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yTQBiVe4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qc8ugDqH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yTQBiVe4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qc8ugDqH"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CD1BC13801F5;
	Mon, 11 Nov 2024 05:39:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 05:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321549;
	 x=1731407949; bh=7DwStqiTzM7Z7y+tzTfNY2UWKq5eF5BJ/6vzivOh+SU=; b=
	yTQBiVe43K+BXZvcE3aTBo6bcYCqbkOJRaOFnM96bBmsEuV8dVdEE4wBZcVIGfDd
	RP2C+ZhCv0nba5xqDCWDsINngRZLlPLYUX8gwUpaXIXUq3JWccCaHhXf+TbPUOE6
	lbQUO4a/XM8Y7yZm9dSI7a2oQCZYLFDN0rMBTWcVXT9DkQ33S91tEriRaBN/d3jt
	RqQI+BN9AYDJ4a32wyi+aaMfrsJClR2OpZrods9NqD+sfaKOEqq0hByrAn7YaUy/
	R9/oVoxIvQMjDivf5fM+eTn3/pwIa+s0cJYXC7oSnsoPz5HEv/UL1NrsJiCAj3J4
	Uyfn+kMLcfVpa4A3SP/tfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321549; x=
	1731407949; bh=7DwStqiTzM7Z7y+tzTfNY2UWKq5eF5BJ/6vzivOh+SU=; b=Q
	c8ugDqH1tLl+PgJkSTaOK8xqYnj2GWbEJxNySOUBIa2ulXJWrkVgvjDQbwoAyP4o
	NUxQfGiH9Ds9FU4rm3be/eGfdZsfMqoazzWkyQC0xQBQ64K4BZlB1A6GgVXzDJvZ
	Bndo8oNEiPAzyrnFX8dH95n/8ceF+pz2Vrdd49/mHxpxus70IqFfwcUf9H2uLE2M
	y2t6ldCS2Vxzg0hdBlwvdqTf+HtOYSCfMVkw+vKzP/aK4MOhpgtCWlRUKDAEXFBK
	TL2atgKCjqRWPR6vvk9rLXxOCleZuMkkzFB6IuaB2XRu4tXWJh8Oy4m5604oEmgq
	yKJADCuxxo8QN0LANVbbA==
X-ME-Sender: <xms:zd4xZ6abG1r1G61dsGQ3ax2FdyKCEJSAk71WAqRVw2bTISEhXmaJUg>
    <xme:zd4xZ9aFluTYEqA8EtAf3FXaO_P5dTGYbl2iiTo-hSlLclIr3xL13m4AiIe5LmNTZ
    3in3ypvoOgbpu_Efw>
X-ME-Received: <xmr:zd4xZ0-Y_XzykNZWtjssKXpxKT2TDO9mKvakJR0B6vqsuzJ8qC2HyW-bfF4xBuWe6XBpnQiUqCh9H24gjAiEQVh6sYtD9BrPaMqXSobiOno3rEWl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zd4xZ8o_iD65tBRzU4Q3rX8KoPAzVXdy1bBn9mjkiWI4GzVRNtqeQw>
    <xmx:zd4xZ1ppzj_DW3ybhzZ3Efc64Go4yQc9KrfYu-EDYotmzVmb1vfljw>
    <xmx:zd4xZ6RTaEmQ3K8aaz2r-MGROKFjPf-PlvNMe59f_KnGp--5-GLLOA>
    <xmx:zd4xZ1qGXsJemggMbHX3nTtv0a3OQGk8AdxCrSwywRJRUUR9fLdVfA>
    <xmx:zd4xZ82H10n532a7xzMZxQ77HzNBFtvi_-PymMXn1pL36dtAGCt2Puyj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0084e96f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:55 +0100
Subject: [PATCH v2 26/27] test-lib: unconditionally enable leak checking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-26-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

Over the last two releases we have plugged a couple hundred of memory
leaks exposed by the Git test suite. With the preceding commits we have
finally fixed the last leak exposed by our test suite, which means that
we are now basically leak free wherever we have branch coverage.

From hereon, the Git test suite should ideally stay free of memory
leaks. Most importantly, any test suite that is being added should
automatically be subject to the leak checker, and if that test does not
pass it is a strong signal that the added code introduced new memory
leaks and should not be accepted without further changes.

Drop the infrastructure around TEST_PASSES_SANITIZE_LEAK to reflect this
new requirement. Like this, all test suites will be subject to the leak
checker by default.

This is being intentionally strict, but we still have an escape hatch:
the SANITIZE_LEAK prerequisite. There is one known case in t5601 where
the leak sanitizer itself is buggy, so adding this prereq in such cases
is acceptable. Another acceptable situation is when a newly added test
uncovers preexisting memory leaks: when fixing that memory leak would be
sufficiently complicated it is fine to annotate and document the leak
accordingly. But in any case, the burden is now on the patch author to
explain why exactly they have to add the SANITIZE_LEAK prerequisite.

The TEST_PASSES_SANITIZE_LEAK annotations will be dropped in the next
patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh        |  1 -
 t/README         | 21 -----------------
 t/lib-git-svn.sh |  4 ----
 t/test-lib.sh    | 72 +-------------------------------------------------------
 4 files changed, 1 insertion(+), 97 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 246072a0932621a64562d94f5a50a1ba880bd48b..930f98d7228166c37c236beb062b14675fb68ef3 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -384,7 +384,6 @@ linux-musl)
 	;;
 linux-leaks|linux-reftable-leaks)
 	export SANITIZE=leak
-	export GIT_TEST_PASSING_SANITIZE_LEAK=true
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
diff --git a/t/README b/t/README
index 8c0319b58e5c8333a13f4d07a47519fa8f137709..e84824dc002932102d0021e96c80f70354d4994c 100644
--- a/t/README
+++ b/t/README
@@ -368,27 +368,6 @@ excluded as so much relies on it, but this might change in the future.
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
-GIT_TEST_PASSING_SANITIZE_LEAK=true skips those tests that haven't
-declared themselves as leak-free by setting
-"TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
-test mode is used by the "linux-leaks" CI target.
-
-GIT_TEST_PASSING_SANITIZE_LEAK=check checks that our
-"TEST_PASSES_SANITIZE_LEAK=true" markings are current. Rather than
-skipping those tests that haven't set "TEST_PASSES_SANITIZE_LEAK=true"
-before sourcing "test-lib.sh" this mode runs them with
-"--invert-exit-code". This is used to check that there's a one-to-one
-mapping between "TEST_PASSES_SANITIZE_LEAK=true" and those tests that
-pass under "SANITIZE=leak". This is especially useful when testing a
-series that fixes various memory leaks with "git rebase -x".
-
-GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
-will run to completion faster, and result in the same failing
-tests.
-
-GIT_TEST_PASSING_SANITIZE_LEAK=check-failing behaves the same as "check",
-but skips all tests which are already marked as leak-free.
-
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index ea28971e8ee6abfcd3c0394c6d8b143c75ac12dd..2fde2353fd38356548fd40e4808984618b0d9585 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -1,7 +1,3 @@
-if test -z "$TEST_FAILS_SANITIZE_LEAK"
-then
-	TEST_PASSES_SANITIZE_LEAK=true
-fi
 . ./test-lib.sh
 
 if test -n "$NO_SVN_TESTS"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a278181a0568a2422ab1e7f007bc016b95a58e63..508b5fe1f550db690ba769c9c57f5ca8ce3d3102 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1227,23 +1227,7 @@ check_test_results_san_file_ () {
 	fi &&
 	say_color error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
 
-	if test -n "$passes_sanitize_leak" && test "$test_failure" = 0
-	then
-		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, exit non-zero!" &&
-		invert_exit_code=t
-	elif test -n "$passes_sanitize_leak"
-	then
-		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, and we're failing for other reasons too..." &&
-		invert_exit_code=
-	elif test -n "$sanitize_leak_check" && test "$test_failure" = 0
-	then
-		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
-		invert_exit_code=
-	elif test -n "$sanitize_leak_check"
-	then
-		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
-		invert_exit_code=t
-	elif test "$test_failure" = 0
+	if test "$test_failure" = 0
 	then
 		say "Our logs revealed a memory leak, exit non-zero!" &&
 		invert_exit_code=t
@@ -1274,11 +1258,6 @@ test_done () {
 		EOF
 	fi
 
-	if test -z "$passes_sanitize_leak" && test_bool_env TEST_PASSES_SANITIZE_LEAK false
-	then
-		BAIL_OUT "Please, set TEST_PASSES_SANITIZE_LEAK before sourcing test-lib.sh"
-	fi
-
 	if test "$test_fixed" != 0
 	then
 		say_color error "# $test_fixed known breakage(s) vanished; please update test(s)"
@@ -1515,51 +1494,8 @@ then
 	test_done
 fi
 
-BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK () {
-	BAIL_OUT "$1 has no effect except when compiled with SANITIZE=leak"
-}
-
 if test -n "$SANITIZE_LEAK"
 then
-	# Normalize with test_bool_env
-	passes_sanitize_leak=
-
-	# We need to see TEST_PASSES_SANITIZE_LEAK in "test-tool
-	# env-helper" (via test_bool_env)
-	export TEST_PASSES_SANITIZE_LEAK
-	if test_bool_env TEST_PASSES_SANITIZE_LEAK false
-	then
-		passes_sanitize_leak=t
-	fi
-
-	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
-	   test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing"
-	then
-		if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing" &&
-		   test -n "$passes_sanitize_leak"
-		then
-			skip_all="skipping leak-free $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=check-failing"
-			test_done
-		fi
-
-		sanitize_leak_check=t
-		if test -n "$invert_exit_code"
-		then
-			BAIL_OUT "cannot use --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=check"
-		fi
-
-		if test -z "$passes_sanitize_leak"
-		then
-			say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
-			invert_exit_code=t
-		fi
-	elif test -z "$passes_sanitize_leak" &&
-	     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
-	then
-		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
-		test_done
-	fi
-
 	rm -rf "$TEST_RESULTS_SAN_DIR"
 	if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
 	then
@@ -1574,12 +1510,6 @@ then
 	prepend_var LSAN_OPTIONS : log_exe_name=1
 	prepend_var LSAN_OPTIONS : log_path="'$TEST_RESULTS_SAN_FILE'"
 	export LSAN_OPTIONS
-
-elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
-     test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing" ||
-     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
-then
-	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
 fi
 
 if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&

-- 
2.47.0.229.g8f8d6eee53.dirty

