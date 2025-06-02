Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161719D8B2
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846703; cv=none; b=IcWUNnbvTWq0kd2rew2JFoYBklm3KYvfVQ7/KtUBChI6qaiU1QG2fslm+p1zDabw5ZM8Numh9wkpDXDw68D9zQ7+5MYzaf36xKWXwIMeOdy4Yyjt3YTlkq+DehUg6oXRClPZ/0VkVwqr5fNe+FSHHx9XT+uJcie1Z6XimqTMu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846703; c=relaxed/simple;
	bh=UMtfiKWG5j0jPy8qZB+Cv8Na6dE8M/TGFAzDQMt2qR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPFzl8KI+BiYrXwo8NDLgeCOUvRQFgruelsdOlXwNiLS9iWBk3E+V69qFUqI9DDdE3EOUkRLbQ7tn0y8pEqT8qBpq6xho1EC4lsnRyL/fQDwLXEg2K94ZF34khEAZw+kUbNFrTBFQ2z2+ySvgyTI1OJG1fvw6wL+wGSpMZ8jKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nuU9P3gA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BGY+vJb2; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nuU9P3gA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGY+vJb2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6EC0C1140151;
	Mon,  2 Jun 2025 02:45:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 02:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846701;
	 x=1748933101; bh=h2OG0Tzkid6sCfvsUFKRU8RVSuenor2tdLPzo3t+DXA=; b=
	nuU9P3gA1Rl3W1QTUNqOSZ12u/uCg1w++4I4wvadZEKwJPw1BdyeP2WhH2Jh8VlQ
	eZRmv0bsUeGI0VkBR+ITBF6kBJbXOYGyr30uY28X1X6pBI6y1KNQTLrEYHV0XCl0
	DLwR8o7lUGLKnRiGXjqoiWU3yQAeUoc4x5OAjKwG39zQuF8GlF9MQzSzSusqozDe
	D3BllXkj5IARsqpbiFtpCbc4IlVbAEwDjnXAy4/2srR3eFRhXTEntQ1eUiGs8c6v
	WaTA2Y0Lz63gmX9MzW1MncUsCU5ml+8khz79owqJepZKYvd4Bbcl5jReea4BW3Pu
	W6eAesgwta0PHBSGj+YVOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846701; x=
	1748933101; bh=h2OG0Tzkid6sCfvsUFKRU8RVSuenor2tdLPzo3t+DXA=; b=B
	GY+vJb25BD/ZHWtyKz68UT9Alwl6YoKiUS3n07KFuJVwxkA93vYEzbtpP7QhVHql
	p+tYtKuMDWC8itQCX+7t0FIiEZT6Q6hsErULBT68d6V4sV7BFoVrV+AVo6hGWIy8
	pG3zVilGITbAN+3bFN9U0ArhIMbTHRx7S0YbH6PXbYOJqmOqzXtUc0xOxHMYA9EO
	DInamCVSbM8fdLJEemE5gTYfVLTuBGC73Jjn5jhJNffzolS0HzUmfjToqz638/K9
	elXI+Bn/cbALI0M7HndLJ5z4MxVlBePKZ+l6KHfJcdBd5ezw+ZaswmFqetG376ba
	GGAN9rnTC3cJNdePeinLA==
X-ME-Sender: <xms:bUg9aJUmKeBXCFvTKgtEfI6pv3aB_ijytbdy9EFGXwSd972P3yNHSQ>
    <xme:bUg9aJlngXlKHbzaImgwp2ya09kBZMvHwIg9-C83ojCC_UKsgTFbY9HCHSJKt9bKg
    Ltzkkput5SJ2rPQwA>
X-ME-Received: <xmr:bUg9aFbqmCUKO1KVUqdr4cP6cyFtxFwO-epgcP6ycd4NL_m7tvPP8fKi-ht_Vbnjl-YEuF_GnfAqe3hO-ERIHYaZhPukweQMoF6Cs3iCb9aqow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgeevffekfedtudel
    iefghefgtdfghfevudfhueevveejjeetgedtgfehueetveefnecuffhomhgrihhnpehtvg
    hsthgrnhihthhhihhnghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtg
    hpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgt
    phhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bUg9aMV20ERCX3GrWtjgWAEIsPOoJSQPNnlMeYQIVf7clbwo1BYDGQ>
    <xmx:bUg9aDlUVyeA9HNaTjFwNCYkWA20T03ww8RlGOI9C3mXC2q1-vhOZQ>
    <xmx:bUg9aJeuTMlxwTNYnfGtED8hcQtxULIq5t0GkXV5T8Xffh34MFpu7A>
    <xmx:bUg9aNGRU_LM2q_Psm9hlMPz7zVLV0F-tsyatSQJRarmGIVHr9Z5Sg>
    <xmx:bUg9aC4JtOn2xkyjJXZ8UiTZIE2JYtIw4g9wWdGXDSum_3bTK6xARYNS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a5257e7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:48 +0200
Subject: [PATCH v4 08/10] test-lib: fail on unexpectedly passing tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-8-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

When tests are executed via `test_expect_failure` we rather obviously
expect the test itself to fail. If it unexpectedly does not fail then we
count the test as a "fixed" test and announce that a known breakage has
vanished:

    ok 1 - setup
    ok 2 - create refs/heads/main # TODO known breakage vanished
    ok 3 - create refs/heads/main with oldvalue verification
    ...
    ok 299 - update-ref should also create reflog for HEAD
    # 1 known breakage(s) vanished; please update test(s)
    # passed all remaining 298 test(s)
    1..299

While we announce that tests should be updated, the overall test suite
still passes. This makes it quite hard to detect when a test that has
previously failed succeeds now as the developer needs to pay close
attention to the exact output. Even more importantly, tests that only
succeed on _some_ systems are even easier to miss now, as one would have
to explicitly take a look at respective CI jobs to notice that those do
pass now.

Furthermore, we are about to introduce support for parsing TAP output in
Meson. In contrast to prove(1), which treats unexpected passes as a
successful test run, Meson treats those as failure. Neither of these
tools is wrong in doing so. Quoting the TAP specification [1]:

    Should a todo test point begin succeeding, the harness may report it
    in some way that indicates that whatever was supposed to be done has
    been, and it should be promoted to a normal Test Point.

So it is essentially implementation-defined how exactly the unexpected
pass is reported, and whether it should cause the overall test suite to
fail or not. It is unarguably a bad thing for us though if these tools
interpret these differently, as it would mean that test results now
depend on whether the developer uses prove(1) or Meson.

Unify the behaviour by causing a test suite to fail when there are any
unexpected passes. As prove(1) does not consider an unexpected pass to
be an error this leads to somewhat funky output:

    t1400-update-ref.sh ................................ Dubious, test returned 1 (wstat 256, 0x100)
    All 299 subtests passed
            (1 TODO test unexpectedly succeeded)

    ...

    Test Summary Report
    -------------------
    t1400-update-ref.sh                              (Wstat: 256 (exited 1) Tests: 299 Failed: 0)
      TODO passed:   2
      Non-zero exit status: 1

But as we directly announce that the root cause is an unexpected TODO
that has succeeded it's not all that bad.

[1]: https://testanything.org/tap-version-14-specification.html

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0000-basic.sh | 4 ++--
 t/test-lib.sh    | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 16b785f3b91..2b63e1c86ca 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -130,7 +130,7 @@ test_expect_success 'subtest: a failing TODO test' '
 '
 
 test_expect_success 'subtest: a passing TODO test' '
-	write_and_run_sub_test_lib_test passing-todo <<-\EOF &&
+	write_and_run_sub_test_lib_test_err passing-todo <<-\EOF &&
 	test_expect_failure "pretend we have fixed a known breakage" "true"
 	test_done
 	EOF
@@ -142,7 +142,7 @@ test_expect_success 'subtest: a passing TODO test' '
 '
 
 test_expect_success 'subtest: 2 TODO tests, one passin' '
-	write_and_run_sub_test_lib_test partially-passing-todos <<-\EOF &&
+	write_and_run_sub_test_lib_test_err partially-passing-todos <<-\EOF &&
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_success "pretend we have a passing test" "true"
 	test_expect_failure "pretend we have fixed another known breakage" "true"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0a124ffad38..5352209d3e4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1272,7 +1272,14 @@ test_done () {
 
 		check_test_results_san_file_ "$test_failure"
 
-		if test -z "$skip_all" && test -n "$invert_exit_code"
+		if test "$test_fixed" != 0
+		then
+			if test -z "$invert_exit_code"
+			then
+				GIT_EXIT_OK=t
+				exit 1
+			fi
+		elif test -z "$skip_all" && test -n "$invert_exit_code"
 		then
 			say_color warn "# faking up non-zero exit with --invert-exit-code"
 			GIT_EXIT_OK=t

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

