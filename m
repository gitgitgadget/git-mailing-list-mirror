Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E020371A
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905905; cv=none; b=c8D/HT0Gk88DTU314DiVt/qIqNeeZbhAaJg3tAJxpLxcpHkLYxzW0P7wAkMwpuP9rUW8Fmc70BzqP8W1kiqHa6MitQfURVGHiEtiuaiwEZASuF70HAl3EIsPla7GRZMFKUsvOJJhr5++Q4k0ti0APeba0OixQB9uPleyX/a+GLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905905; c=relaxed/simple;
	bh=ULv7I4f5qaE6TpHuPWeSf3CpbQGrj6ldcnYyTUxR/2k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0gqGkOr4IC6DtliFIyfWfyc+LkeLjoBjKd6JCo2Tk2p6Tu1j8ETYPEXJ8JZH0GspGl6ixYUnhNyViEq4sgQQOFWdyT2/ciHcmkvzsnvF2ZHZU+ALXr2ixN2eakyDteTkBs2wfj+bgiUdck4H7tFVGIh30S1F2xsq1TbpVeqYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y7sPZEbT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dv0dPWrm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y7sPZEbT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dv0dPWrm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0053D13802C0
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 06 Nov 2024 10:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905902; x=1730992302; bh=ozEAa2keVH
	VwDwwKp+BmptRUctvwJAuif57b79P3Z94=; b=y7sPZEbTPyc+2HVL9mC/vkki9I
	ZBsvS1eQlevQESlPEoPHLFyyVCeGYQxFPVoRdZdaH9qterYG3d42stpCNt7K9P2s
	7zQqbKpuCA0ZWIg0n9zfYcugn7a7DB1CyTnJwUPPGxC0PPMRuqpb6DD3H1iaoQzY
	Urmqdw/lErTVSe/1qqOc/WdRoGd24gmUFeHfhwlYyPXx7uLtBLsmI2YyRQyNxhv9
	lD94fZup+7PTfea5ttGy2Thhdb04dIe3COffnctD+ljN1v02dK+sk7USH9BYr0lQ
	aofEFuxbz01Rgbz/YL0SbDbSvMqWrTRbX4N7y7nnapkv4n7iD87stBYRjXwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905902; x=1730992302; bh=ozEAa2keVHVwDwwKp+BmptRUctvwJAuif57
	b79P3Z94=; b=Dv0dPWrmrPP/hOJ3R8jmnCG2aq9qaOHefWGdRFqm15DFKlE3i4G
	kqSR6vr0NtDWKquqZhF/+faJ8APHWCLXMTZSmxwAexRmEpBtrOPjszWj8VPtcUen
	MGDio1CVec7uhiqTAX5L5rkyUiIrPMnmMcQ4CKXPMVzOwDSzLEkxohiupwDsDYGc
	CRmzao3j9F9n2j4Tc2lD62kI9P9r39H+dn3D/aYLIA/TBLzVxXM6p4YXlIi05aJK
	zMj0uLAoaGRM6JpNEchFwLTZ239S8Xj0/YZqNfZsexBPDX5Pk0c9q6b9hHNQFobP
	eZa+JdoUBfUQJ3vMGdsnJ2COvK6ESbxUgug==
X-ME-Sender: <xms:LocrZzhO-LarxdLLTYWKERp7_a9F2XMCJSWUi24HFqP_QvAlBrEjug>
    <xme:LocrZwC6lfGRYBrOJMb6Qg8m5QJnodnVNvGS8LHegMcaiVxBV4YJrVaclTg9Vt2-h
    ro-25jFtfuwkNcxyQ>
X-ME-Received: <xmr:LocrZzGKPNHj-4YnX1CgFUAXABfHSpIQ_qqbIsyt8iH55Jwe_Ai9NM1wEZYv6YN_cR8A0YpgjFS4E-TxRe0JX7TteK1dHsGF7o3qDW2QtaZGkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LocrZwRJ_qJuopeLmvdXU7y1q8X4etrFfzTaNB8PLSMEm1ZOYyPPvg>
    <xmx:LocrZwxz0t9Tju7wMvYKcf9YpLvu7QJD7-0kaXv7itfHhf0i1lRIiw>
    <xmx:LocrZ25g7lebCKCUgjS7Sp3hdM1Hd2Pjms5JLOniTjeqMCiWBkryHw>
    <xmx:LocrZ1x0J1cZI5-YdY7GaSt0tF2-vclreq-YK0WoItELmfXVGZk-bg>
    <xmx:LocrZ9rwCxczzyXwTOiHMReOkmghRqyGN7ksw8kofRdOB-1wYgVsWOT->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 414c47ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:11:18 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 25/26] test-lib: unconditionally enable leak checking
Message-ID: <ad7529ff2a2d5dd952b153ff9c9ee93d3eb4aa3c.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

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
 t/README         | 21 --------------
 t/lib-git-svn.sh |  4 ---
 t/test-lib.sh    | 72 +-----------------------------------------------
 4 files changed, 1 insertion(+), 97 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 246072a0932..930f98d7228 100755
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
index 8c0319b58e5..e84824dc002 100644
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
index ea28971e8ee..2fde2353fd3 100644
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
index a278181a056..508b5fe1f55 100644
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

