Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CB36681F
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922764; cv=none; b=qCghUXbCmg6BtC9XpgtSlHcWIeraELgVCQIP1sF6Y0HwgKI0AsuzMfeR1Y0YGsmZe7FZC+pJyWb9e1gifg4VTcsqLZ/KpGgG7o5PZEh+A68CbXRu/uJ2QKSleYZTPWgMyQyUgdVZKTsZoTA++gFuyWy8p23uPDTmpm4/ON1MLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922764; c=relaxed/simple;
	bh=/kGD7bUz9QYpF31bKHLmg06J72tc3vqZ7KP8Kvz+kdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTxPJ7lvIoLuAyh09am/F6YfO/Z6ZxP1JSJYVdo2WPDirJ/D6+oJacZAGuo8HZIBDTyc99lAW0y16TzR4rcX1PFf1ffKV6Q6LpHVVlGXbqsSkrbnkyx/9JQUKY+Jki4L4WQxAMZWbJAcjJ64OuHQ8QN49pTHfIZrfUgAtS0M8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rIPikhdX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=euCXxBCP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rIPikhdX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="euCXxBCP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A184EC054F;
	Tue, 24 Feb 2026 03:46:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 03:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771922762;
	 x=1772009162; bh=cWL1MVVEYCQgos2OfCRSlsMlAagP1/EXMnmkVJsu9uU=; b=
	rIPikhdXGcvFkXK06e2P8lqcht225sGLQ3VwO7LvRA8gPgFkiOQLdi/tRFPiJ0Hq
	lZQZxADMfjZqIcr4ObcxOiWan/dnKFSfLoCGGfvyhy0MHbFmFMGYhfYx67vzCklq
	RdSaU2qRE335Pwep3bw2I3fiyAbuPCj7tH7T6kz6Mz6NbbzgM6FNGLGQw7S6nirm
	70yqO3fT1iEJGCZv1416X0ZUoX3xhfDzzffm6WqYxy3H8YuOBO2ur03VceOcknlX
	2Twp6dYCiMsec8k2UhAagKMr5Po9dzbcrgLSZOyUDrz7DfwSnidAerddVD/1hFZj
	AGfgTpS7XaRsT7JxaFMSAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771922762; x=
	1772009162; bh=cWL1MVVEYCQgos2OfCRSlsMlAagP1/EXMnmkVJsu9uU=; b=e
	uCXxBCPx6QgZnSwWCjsz86hUtsupIsXrwJyELilW+6E1jbSrSBJCH1tQyfX2Xv9s
	hCzbllUp8dC2ELcTp4pCnmHXt3HLVqCuK1LUUNL0FmPfAb1K9ygOTKkfSLlGhZHl
	FpVlWQPCsyLEkH4O4IOXIBOfsN0Ft0qMVnBuYlby9ocyXXiZR0obPOhW1DSn3WXE
	HOs/CFW/WVAzG4XBoETB8Ssqx2rASXj26oJYbkEYrYvG0/8u+k5uSXutLjsDnrin
	zieUslNGgG2hxHsbLaQZL6rVIzuNXXOz/aA7evO8AfJCK0ynoDNFIIQwtsbdPY5i
	v+JTnnwMuYRjd09Q1C3og==
X-ME-Sender: <xms:SmWdaWWVUopCQ4kd-zA2kDiQktkb3m7oy65bru0jdLIVlhpFrVVKyQ>
    <xme:SmWdaZkarclFwf7KQhRmp1T52dqIlSlZlEZeBa83sVnn96DPpLZRxffQSccUA0gus
    RZqEKaeVxuwEB-NmdCL8NoaxMJZo7fuPV5U5-qFnnb18EGp5RD7nb4>
X-ME-Received: <xmr:SmWdafbWjwVkTNPMPO3QFIlQBJu9rPvjvpXRklt2MrBp3BV8IsMyhnSbwKaFGYp7T7vn4SHp26dHTmCKQxf8XCO_1Ig_RiCVycgzSnH1AQX6yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SmWdacOYR_EK2N8k_J_fJ_4CHbMG0MrKqsYRZQM30Qzv1vuhZCEKMA>
    <xmx:SmWdacZywKnhCGNlo37h534-FO8t0OlBYK7yO7Ep7PLCoNAR0LJCYw>
    <xmx:SmWdaS0QLf9ATWCjtsOpiATH8NTo91z10TNcz1GJybkD1-siSOXyDQ>
    <xmx:SmWdaadkH5r9Prjymxe97-7eXCP26fdaJUHaBqgsLiqgn9u06yCvrQ>
    <xmx:SmWdabUvKBOe8R8M2W1_Ln9h65ahtjpljC8vHpe9IY0fIr8zHITIw85B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:46:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18f3a7cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:46:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Feb 2026 09:45:47 +0100
Subject: [PATCH v2 3/8] t34xx: don't expire reflogs where it matters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-3-8657338c6fa1@pks.im>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>
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
 t/t3404-rebase-interactive.sh  | 6 ++++++
 t/t3406-rebase-message.sh      | 6 ++++++
 t/t3431-rebase-fork-point.sh   | 6 ++++++
 t/t3432-rebase-fast-forward.sh | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e778dd8ae4..3e44562afa 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -31,6 +31,12 @@ Initial setup:
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'setup' '
+	# Commit dates are hardcoded to 2005, and the reflog entries will have
+	# a matching timestamp. Maintenance may thus immediately expire
+	# reflogs if it was running.
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
+
 	git switch -C primary &&
 	test_commit A file1 &&
 	test_commit B file1 &&
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index a1d7fa7f7c..bc51a9d3a7 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -8,6 +8,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	# Commit dates are hardcoded to 2005, and the reflog entries will have
+	# a matching timestamp. Maintenance may thus immediately expire
+	# reflogs if it was running.
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
+
 	test_commit O fileO &&
 	test_commit X fileX &&
 	git branch fast-forward &&
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index be09fc78c1..4336f417c2 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -17,6 +17,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 # C was formerly part of main but main was rewound to remove C
 #
 test_expect_success setup '
+	# Commit dates are hardcoded to 2005, and the reflog entries will have
+	# a matching timestamp. Maintenance may thus immediately expire
+	# reflogs if it was running.
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
+
 	test_commit A &&
 	test_commit B &&
 	test_commit C &&
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 5086e14c02..181d19dcc1 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -11,6 +11,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
+	# Commit dates are hardcoded to 2005, and the reflog entries will have
+	# a matching timestamp. Maintenance may thus immediately expire
+	# reflogs if it was running.
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
+
 	test_commit A &&
 	test_commit B &&
 	test_commit C &&

-- 
2.53.0.536.g309c995771.dirty

