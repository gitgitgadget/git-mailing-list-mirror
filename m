Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E933BBD7
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582533; cv=none; b=egA2zkoo+mpX7JzZe2H4CotqXaLKgMHm29WFjvpjPIW49YUxZYWrTxYtbdQCrpg+WLvX21fhIqFs2NRpoc1vokpzqAk5fB+6UuVJtHX/k3OImAMYVGYDPIRmRfOjcjxbbWsk35zUvqSGs+41k1wIJAOPnBQaXQq3AXCrV5vcSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582533; c=relaxed/simple;
	bh=out1K4l8GX47SxR369shvOlAPwR/xNhIHDIdFKIuxdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHFJ5etm618tjA0Ms7NphsJR9kZz4itNmuf/F0gy4oJWy+MKhWRTqptZcXcpcjvIy0jGUIxuxPdJFpAlM7y1ulUhMTSoB8Ornq7mgqFDelVDiphwvI1yJ1FWvZwR3L/dMt1pOy6i/bczWSQta+7nf8hyyDZAVeeolk/h36yKnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SIWomQ+s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lfEwBe5T; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SIWomQ+s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfEwBe5T"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D51F1D001BE;
	Fri, 20 Feb 2026 05:15:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 20 Feb 2026 05:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771582530;
	 x=1771668930; bh=xy/Bt6oBsJs9OKRTmZvns4tuAY2w0tmQZ4l00cwSwbM=; b=
	SIWomQ+s3Cta3T3azsCYdbIveE80SLGzqA0R1mlxJ+gFZ4cFgKHj6lOdk4HjT8jW
	1eDgV2CkB2vT8f9TQ2pb5OCN9MlduT2g0QB3vKAlKDLb48mUGf6A+yIrBGSkT+RL
	vGtJgkRd8gt6EQBIJpHXoiS9nNnZsSEAfhAvm/0USYMKvhRW48Nbi2+E0LqlO/CK
	Z3m+L1WQR0rjaXglITOfG72fsUv3HB1PuYamGTjysaC/gAJcXJqyHAL1p6D10+Q2
	m0lwB0ImcE3+3KVFSDf31mlNzKIqLGRmukoxJCXsZcHBRlvWQiMm0OfEA09kaEJH
	CRE4BJHk658iGcL6VBb2cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771582530; x=
	1771668930; bh=xy/Bt6oBsJs9OKRTmZvns4tuAY2w0tmQZ4l00cwSwbM=; b=l
	fEwBe5T8SFBWZKaG6dFK+hMagAJnY+ssn3u/EXmoAr/sJH+FiXpJr6cHZbq1P07j
	GRKRPcGT+Bjj1/vlzErCmMRcHpzC453km7IzM0I8AAwgPtUmkM7//XcxPuk1gE2z
	1c3fYEdSkb3uGHqFNsfuhQdYj20aySqURkYm4yPcrmAz5uXLR89Pw9ijW+Pxnr4c
	+jhWeZOQ5CmEnVQD0C/1zLe6pa/BLRXSGilvRfLHDW8r7z2OHb8I0F8XuiawTrOt
	NZk7MWO3PoKkATzOdlJOkRy91nX4UVAgwVTiq92nvtnUAFQ+tiPQhGR8doJcy2h4
	BQSTniPTRxC8cRV/t7BWQ==
X-ME-Sender: <xms:QjSYaVk_JUwsN55a8PukYk-oVcBMW6SMwWDnXnHYIIGzMlaBlhxgrw>
    <xme:QjSYaYTmoyguzzYJja7YjOI61E_sgn8ur6JQqPavftENGWuhtoNBIH5KYcB8gwttN
    M-h3xyjVSaTMT5rwF9n-vp_REdzBoz0NBf6taKcsVqhEytumfMiMb8>
X-ME-Received: <xmr:QjSYaZDGEb3RV3MAszBI20mz0rCZPkstux_vwOwcoyrnvFu1V8kucc_xPK2wH1WF6Ca1sPGWRsFVw3Ngp5FZFgJIkZ6bOpodZx9jx07xKT-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QjSYafRugU4NTBl2x7Z-2iqU5nakbz2L7CXLlju-DmtoHdyYVERd2w>
    <xmx:QjSYaXrxHAJGiOCB0u-4uAX95cXbUDzasXsvsCIqnIQSs7jWltAVJA>
    <xmx:QjSYaRzuT1rUtVhx8eroozxUHvmSSxR1VTTj5HfTNnvBpy0ja4SOoA>
    <xmx:QjSYacKTmHtXIoQfPc2zyrWKHR25HWpLwBIRi3jByz3hvhyQGJQffw>
    <xmx:QjSYaYulm4VFxByymTd80GniNlIRopAATRXZV-5nsqbjVeCgiF_M_eZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:15:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7711fa9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:15:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 11:15:07 +0100
Subject: [PATCH 3/8] t34xx: don't expire reflogs where it matters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-3-faeb321ad13b@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We have a couple of tests in the t34xx range that rely on reflogs. This
never really used to be a problem, but in a subsequent commit we will
change the default maintenance strategy from "gc" to "geometric", and
this will cause us to drop all reflogs in these tests.

This may seem surprising and like a bug at first, but it's actually not.
The main difference between these two strategies is that the "gc"
strategy will skip all maintenance in case the object database is in a
well-optimized state. The "geometric" strategy has separate subtasks
though, and the conditions for each of these tasks is evaluated on a
case by case basis. This means that even if the object database is in
good shape, we may still decide to expire reflogs.

So why is that a problem? The issue is that Git's test suite hardcodes
the committer and author dates to a date in 2005. Interestingly though,
these hardcoded dates not only impact the commits, but also the reflog
entries. The consequence is that all newly written reflog entries are
immediately considered stale as our reflog expiration threshold is in
the range of weeks, only. It follows that executing `git reflog expire`
will thus immediately purge all reflog entries.

This hasn't been a problem in our test suite by pure chance, as the
repository shapes simply didn't cause us to perform actual garbage
collection. But with the upcoming "geometric" strategy we _will_ start
to execute `git reflog expire`, thus surfacing this issue.

Prepare for this by explicitly disabling reflog expiration in tests
impacted by this upcoming change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3404-rebase-interactive.sh  | 2 ++
 t/t3406-rebase-message.sh      | 3 +++
 t/t3431-rebase-fork-point.sh   | 2 ++
 t/t3432-rebase-fast-forward.sh | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e778dd8ae4..5e4623f7f1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -31,6 +31,8 @@ Initial setup:
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'setup' '
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
 	git switch -C primary &&
 	test_commit A file1 &&
 	test_commit B file1 &&
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index a1d7fa7f7c..f89209c8d9 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -8,6 +8,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
+
 	test_commit O fileO &&
 	test_commit X fileX &&
 	git branch fast-forward &&
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index be09fc78c1..3a3c3a70a5 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -17,6 +17,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 # C was formerly part of main but main was rewound to remove C
 #
 test_expect_success setup '
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
 	test_commit A &&
 	test_commit B &&
 	test_commit C &&
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 5086e14c02..6e8de6c7aa 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -11,6 +11,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
 	test_commit A &&
 	test_commit B &&
 	test_commit C &&

-- 
2.53.0.414.gf7e9f6c205.dirty

