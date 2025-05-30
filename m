Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5B22C35E
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611919; cv=none; b=Rzp332c3o/T3vQP4xNx3ZqMl9Z4e5S3E/AeoUQBbQHv8UpKEu+RxhRg9+Tm+n/OGXlDWnqUCZCmFYsRb3av7+NayIhortRBc+DHHXCTOBO+87cHdNOBz5uC4JtKT7Uydb2Bfy0f5F97RDuwN1OTg2OzS8dtAgNvAh9WSgdddUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611919; c=relaxed/simple;
	bh=6RWSoNN8xuYYn6KcBFPL79rJtVM8JwLf7j+L9W5yrf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e34KpCoc4FmM3hbqKSyNh5OKfUrvakroq44yBibbPoqrmycfX9oIBEtrgjilEYZ/atqWEAJ66r+IMUvJHmKnAmGXDXFYez1/AEN/NTWBv8UrlE0hjlmpiKfESaZKnYw/ytMpejkMKuR24ZdpfLDiSsTXg9gxBdi6QzDLY6j7OWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=enMLyqRC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gfdYOW8c; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="enMLyqRC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gfdYOW8c"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C08241140180;
	Fri, 30 May 2025 09:31:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 30 May 2025 09:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611916;
	 x=1748698316; bh=wTOY3qgDjzi0doVhB+RHG7jamBPLfGrTeYor4+YojMw=; b=
	enMLyqRCuW61XmPYmWk4UjA3Kq7oaVWoYSzHsCKup/hlbuWIgp4AHIXmewHXCR9P
	IRXwaeVuK8/W8QGpG4CEyIf2prKz93erL9nxbD5a+ZR810jTeDDtdsOPLdmSkfXU
	mWtofJF93U41SmJEFjmzD+2x+nCrMf2pFNxNGmMDw7qxzLXRu9heiLvmFny1gbGY
	6L/JS+RHsFn4+R8zliK2e/ntzppi+v+zZVxwDKesNSKGqwCMCZXS1Lx9xsfL4iwQ
	X7LWlYdJcOh4/NsY0T18+p4EwCjOKO4350X6Dj9PdKzLU9Cf8oL16PDu6Oj0J2w3
	2wHeKFyYisrZOzwPdMVHlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611916; x=
	1748698316; bh=wTOY3qgDjzi0doVhB+RHG7jamBPLfGrTeYor4+YojMw=; b=g
	fdYOW8cwhWcBdq47JTaFobYcxI27WV2FO71/axrG0aiuGCNKJf7ercjUywweX+h5
	XsTULec3wvp7wOMLrVeLwSf0ioaIJ3JEbay4kcASn1Sa1gH4QqJIkcG+h6cs1u9k
	uMlEwwp1i4cW7AA8yuMLoDKU5Rrud08oxc3QoeQgjJQfHtC0Bj+QO0jCWScZetjd
	lgArvTikQiCLsj2lSfmIxxRJzgDRIsydS7/EyHHYMg7mPsCSbKwgC9sDwG44/ljV
	licz9iRVOhs0L2/nTN/VkS1fbavlZwCJ9fqY2UwB0zB8o7gmJbi8bvbjnH0g5Dq1
	hG/Cb/ZMvPNYJBLQ0m2yg==
X-ME-Sender: <xms:TLM5aHzpVSoMtfu1gOPlKon8gFQKX2-3V7GCaGsui5DSV-F4r8_K0A>
    <xme:TLM5aPTtn0QvQZc-tiHqLKcbHKnGPMfFJQIGAFQ8BctT8u6WWNl3WH160lZrSylA5
    zM9SKnR86uO0_1IYg>
X-ME-Received: <xmr:TLM5aBXhMdRaRe2mHTTL8QIpzLt-Pd3X16eTPH5bU2ihJxCARlhAWeD1KTqiVEDMNT9_HEJIsTmqQ3jrgZqJUoV4FO68VGYDdnvs1QBgUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledugeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgeevffekfedtudel
    iefghefgtdfghfevudfhueevveejjeetgedtgfehueetveefnecuffhomhgrihhnpehtvg
    hsthgrnhihthhhihhnghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    thhmiiesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhn
    vghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:TLM5aBggtSNskp42eumaYP3UnRan3MLjJmFazatL4YCkIkyRCHWjrw>
    <xmx:TLM5aJD-V5GBeRQeWwC0SZXEwmTDq0FUTd15ChU5gSQr5zmD47WnpA>
    <xmx:TLM5aKJf0_5NFufhAwGjBBF5Ohb_sJCM9EdtF5Mbp8yxgNRIJMIqbg>
    <xmx:TLM5aIDV4H8rxEUbIqag-Gc_ye-pYrf2zDXk2Qr0mb8MtCPyCsbpsw>
    <xmx:TLM5aFWyVIJZfCGvo4jpOjUYXgcId2ONWGxWVY2MczAe_Bov42F6ETBW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c25229a1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:46 +0200
Subject: [PATCH v3 08/10] test-lib: fail on unexpectedly passing tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-8-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

