Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0E201273
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905903; cv=none; b=hY8H01LS1fHYrB3FkP4klQ2+E7X3rnsuYee4y+1HZ6NUGcJ37SzEEYLSnGMAhhZ/4EhvyHXSwotE0ugm8XxUDFtCigd/ZQoSJPA9IgIGntJhMm5LoR78Hkx54lD4yL2wZAYR8OGxvmp2zugoavnLfYPtrtQhU7ZFgP7RM8YOLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905903; c=relaxed/simple;
	bh=dVsO53I2mSdP0CkMRBkN4O+36eAAL3gHs/fA5hb0r+k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMXstcuPooynSHMLyhcrUmSi7IXu0yuTDx0Mvhy5+e1w7s42p30OJzF1CKCSx7UZVq+SJcFaZTPC9rsLtO2oIKj6OuqotRUV+wBtEUrFz8m87F4CNpII2fnjH3VgzWxx85fzlYeP9GtAUAiiTJBc2qYtZREegI3xW0HO9eIDY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lSeCvMex; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrcMOlLZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lSeCvMex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrcMOlLZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F50E114016A
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 06 Nov 2024 10:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905901; x=1730992301; bh=Kd4bbHczYI
	dPj9Tq1dM7v6FoFzAwW5I697jMYIm7evc=; b=lSeCvMexXRISxkPF7LhR/mLFYj
	pe/zA8RfrroIN2/jAR4aH6mRYIOSe3Xtqjsougjgzl0+Ha2QCcMCHLW2ERk2r0+f
	MSvg4AUkQhU9QJLCuzlz+Jt6Yr294dbT7R0NsRJ0rEXZnuowLc+TEkwaZsCzRPpT
	mrqMP3xVyz/Ukd5e3q/WLhOJGIKshtaXuBZbcnFb/tNbtOI27jIG1YG22vfxLJbN
	OTa3d1tSckdqxGiNcIG/zjGxIGqIIgSmr0hpfmZFRLWGSH9Ef0hdj6oFMkwKYQXT
	QOu4oK3OJnTgDznrHlWQTwcEQCn6czZ7rrqcOy3AUFZ05xQtqgYjwCWa5Vzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905901; x=1730992301; bh=Kd4bbHczYIdPj9Tq1dM7v6FoFzAwW5I697j
	MYIm7evc=; b=NrcMOlLZOhV05w4BEM+DPmfad8SIKWDms8jhlJTedBpnCsgtoZW
	GahqCWR69dhDivP3h+1OhQkHjaE2Rx2UAxQks5eJgJshlyfOjpYIoatTMvBvfZOw
	ej3XSP53YOKVLY/4DOgSFKCfy9pj96rVEiP2MiiWhS+UCCnC9kYaRpNSAztVHpSW
	8PJXw6srHjyt9fB0r/1p9hy+Ru8Lt1pzRnAR/viV0hpL0X5yzhAvqnaBjxHCzx1w
	543G2WQ0WGUMrB9MTLHmzLQS3dcBBDu21kurHHNMYKz7RB1IDY4zTt1fSc5J1vLB
	9qA3iaB+7bSyfdi/LdC9HLlRiH/TbFxYkQg==
X-ME-Sender: <xms:LIcrZ4oHIrVjsmNHPq51HDNAbsc7EY9mPzJARiEIV0m-xU-CuutqhA>
    <xme:LIcrZ-pNcZnbQer7c157LiTQFPNzv-MV-RakdDk47GPtgxwTGpCf2jH3KMBiqPm2K
    MSKj3lAFaNFKs3xhg>
X-ME-Received: <xmr:LIcrZ9PAVthHG_5g-sOBpw80WFzaXS7WxVS3F8EOj5jP2FcUNuE8sDnXVeUsdguWvEVkqnjp3Xp5ZDmeyIr9WbCrIAkFZ9eNsaelY6qkeCNiQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LIcrZ_4XlQ9TK9950p9vwq5LQPbfRkJUS_O8ElYS7Kzvrl3bME1RPQ>
    <xmx:LIcrZ34vdTRZxOtNE0VgSUXVkBB_vClYhddc0BDaB2oTf4y2M_Jywg>
    <xmx:LIcrZ_gInyvYim5bSKXQtjxIwveSshdB2gpZebHX5enX10pIrbSZ5g>
    <xmx:LIcrZx4zAzwKMRwfiMwq9eYmtY2wk1VIF9kCiheh4TMgo9cPPc4Ngg>
    <xmx:LYcrZxTlK_GZPDyrryMt1Z3bKYhrvzpYEPYDARcNWpb9h75aFBQ6mRxD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0fb955bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:11:15 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 24/26] t: remove unneeded !SANITIZE_LEAK prerequisites
Message-ID: <ccbda5a768295b7db56dc3383d992ab20953ba4e.1730901926.git.ps@pks.im>
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

We have a couple of !SANITIZE_LEAK prerequisites for tests that used to
fail due to memory leaks. These have all been fixed by now, so let's
drop the prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0095-bloom.sh          |  2 +-
 t/t2407-worktree-heads.sh | 16 ++++++++--------
 t/t4020-diff-external.sh  |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index c8d84ab6061..08df74cacfc 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -77,7 +77,7 @@ test_expect_success 'compute bloom key for test string 2' '
 	test_cmp expect actual
 '
 
-test_expect_success !SANITIZE_LEAK 'get bloom filters for commit with no changes' '
+test_expect_success 'get bloom filters for commit with no changes' '
 	git init &&
 	git commit --allow-empty -m "c0" &&
 	cat >expect <<-\EOF &&
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index f6835c91dcc..7750dc9265a 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -49,7 +49,7 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	done
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
+test_expect_success 'refuse to overwrite: worktree in bisect' '
 	test_when_finished git -C wt-4 bisect reset &&
 
 	# Set up a bisect so HEAD no longer points to wt-4.
@@ -61,7 +61,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
 	grep "cannot force update the branch '\''wt-4'\'' used by worktree at.*wt-4" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (apply)' '
+test_expect_success 'refuse to overwrite: worktree in rebase (apply)' '
 	test_when_finished git -C wt-2 rebase --abort &&
 
 	# This will fail part-way through due to a conflict.
@@ -71,7 +71,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (app
 	grep "cannot force update the branch '\''wt-2'\'' used by worktree at.*wt-2" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (merge)' '
+test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
 	test_when_finished git -C wt-2 rebase --abort &&
 
 	# This will fail part-way through due to a conflict.
@@ -81,7 +81,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (mer
 	grep "cannot force update the branch '\''wt-2'\'' used by worktree at.*wt-2" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with --update-refs' '
+test_expect_success 'refuse to overwrite: worktree in rebase with --update-refs' '
 	test_when_finished git -C wt-3 rebase --abort &&
 
 	git branch -f can-be-updated wt-3 &&
@@ -95,7 +95,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with
 	done
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
+test_expect_success 'refuse to fetch over ref: checked out' '
 	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
 	grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&
 
@@ -105,7 +105,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
 	grep "refusing to fetch into branch" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in bisect' '
+test_expect_success 'refuse to fetch over ref: worktree in bisect' '
 	test_when_finished git -C wt-4 bisect reset &&
 
 	# Set up a bisect so HEAD no longer points to wt-4.
@@ -117,7 +117,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in bisect
 	grep "refusing to fetch into branch" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in rebase' '
+test_expect_success 'refuse to fetch over ref: worktree in rebase' '
 	test_when_finished git -C wt-3 rebase --abort &&
 
 	# This will fail part-way through due to a conflict.
@@ -157,7 +157,7 @@ test_expect_success 'refuse to overwrite when in error states' '
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite during rebase with --update-refs' '
+test_expect_success 'refuse to overwrite during rebase with --update-refs' '
 	git commit --fixup HEAD~2 --allow-empty &&
 	(
 		set_cat_todo_editor &&
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 3baa52a9bf6..0e5a05894fd 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -102,7 +102,7 @@ test_expect_success 'diff attribute' '
 	test_cmp expect actual
 '
 
-test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
+test_expect_success 'diff attribute should apply only to diff' '
 	git log -p -1 HEAD >out &&
 	grep "^diff --git a/file b/file" out
 
@@ -129,7 +129,7 @@ test_expect_success 'diff attribute' '
 	test_cmp expect actual
 '
 
-test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
+test_expect_success 'diff attribute should apply only to diff' '
 	git log -p -1 HEAD >out &&
 	grep "^diff --git a/file b/file" out
 
-- 
2.47.0.229.g8f8d6eee53.dirty

