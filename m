Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0461C305A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110016; cv=none; b=LdsVd4z1sSeCuss918kz09nJgmOsDv0Mrg8mabx9M0C/E2S5s+lSu1OOPuQpLMCUmab2KNRQE6SfJrH3CV5R5P14a7HbMZGuIQpwWnkO5YfRtpmveMfavix3tnY5Nlvg/9TrS62XgkNc0NN9SR0Se5RMFmoKojl6yXlq4CNzlhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110016; c=relaxed/simple;
	bh=S7u0+At1o5Z0pkB6kV5nrLCr4jvOx8iBWWTmOp18Zu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GifiRPSZNVCStu7uP51iiS1EXz/Zd9fAseWFmAV50V9vSVU006YegrlGaICPCM3Q6ItSRCOb+tDdRZETuwIg19Ne1YmU0kN2IbQjQH0ZRfqVccgbN8r3wQPzteV6BilCWYHq2UzTA3wVxFe04EPdaMAtAvvm9Zbax5K+/OrKeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xszgRZwa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPulf+V+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xszgRZwa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPulf+V+"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7827B13806CE;
	Wed, 20 Nov 2024 08:40:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 08:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110014;
	 x=1732196414; bh=4casf7Ld0xPooiN8jK57BGPITvnYAIyIcHBXjWC1vlQ=; b=
	xszgRZwa4+UhykWW2lEq2KI4sO9/aPEFVDAhtFumPVUNfaZbdWVJDG6+z3k+rVbg
	A4K1xvl/Srh1tYa29J04ZZAcVUwHizetYmfyPwjpo+571SlvCNKB3QykqEV2Ax7h
	FXTaBYKdV+9AcrM1LsxOpEdJeiiiww66Ho5DQYHwjLy1GKwN4hU7MVZ7f34lZB3D
	0WlNtDTlxAh+P7CiOF5Mocy0PvR/BB08YRwhnwYvH+nqvlB4vRO7/NWZoHZyjPFE
	CooLJHXKoU76ht3eXg2Jh7gFV+pqJ4xECpZbxKeYFJ2r7a5eKih9djaZd86J4Abj
	eslumhvjtU8sgCwE58ot0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110014; x=
	1732196414; bh=4casf7Ld0xPooiN8jK57BGPITvnYAIyIcHBXjWC1vlQ=; b=H
	Pulf+V+0EFw05CtBSKaiu/cqrCO4UqqQ2BdWEtvP7RNuBHARcDyVMuf6KGZBY0PC
	+5GyqdcFxtz9DXsax31BmE9f0lH8obLwFosEmf/zcJmLD1eL+7igsyHfMDCt7KFm
	RokgrnCu9KFXGolMw535pnvZ/gMwpeXCQDpXHaI/1Zxw//c02SXkCCqbLM/4TN7W
	rmZ339gOSZ8FwjoYtiLgR95HZUAKmluohMGnGMMaSFC8K+4u0JjbWjUwJskhQSiB
	4PzZfByCQYL3T6cDJBt9dzVr52gCEmhab53CyS+VFtPTTO4bRzdpOIY+9yEoZvCJ
	OSTjNqOualaqWoE1nv+zg==
X-ME-Sender: <xms:vuY9Z4XoBG0Mdoil75G33eReLX08n_7gqqEzHc0eyRLEVwQd6QGIcQ>
    <xme:vuY9Z8makMyF28Am09USdj5yFfeQoOzmAjD58cvCitWVT1Q8Zej5Q1-NYCPes99K0
    hnAK4aNRy0xTyBO-w>
X-ME-Received: <xmr:vuY9Z8bVTvvlbV_pT3IrcCWhwZrejlTXqw3mdwmnod8568TAoOpyCg8e8d5q0mDGuwtkR7XBnKQFfna7bdW8jEGHgySpaE4RCWwfps3HwuNUgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vuY9Z3VVDOC7wrREQvwCUGkwfTRsyiSNQfU7EqMRJvlb8s3r6odMBQ>
    <xmx:vuY9ZylFJ_SuHs_q_7z9bkyhjC8NrLMlwm_5O584lZ1gt8TQb8EugQ>
    <xmx:vuY9Z8fkjQ2HzXmjTJgQkJMEqgNdBBFHo0NQZkWf9b6S1sUBSOqufg>
    <xmx:vuY9Z0HEBi38qxAILENRxc-roUoT1qPmlX2uCsClkt05o_C06mms2w>
    <xmx:vuY9ZzA6GhPDqtfdZ4ZtCWP5zf6Sy-YwnFYCs2GRyUB9F4RaRq0t1JYq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c63f1183 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:55 +0100
Subject: [PATCH v3 26/27] test-lib: unconditionally enable leak checking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-26-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
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
2.47.0.274.g962d0b743d.dirty

