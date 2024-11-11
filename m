Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2519ABD1
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321551; cv=none; b=nRvDgKkg5lysPf3NtKrzI+4ZX3cfztMUBo05WSs4PMWGefY6dAZf3Hb/UbRT6+cbqlEbeKFoA4NcXqYISda6cfH8Fl2lK5cwvj1js7EEflY3kfWwE/xZ/Urc2iBiG0YmZVB/0Jv/tewHO0sqXYThAHDnYXV5FItbNcyxMPVQEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321551; c=relaxed/simple;
	bh=i6AuhMe5aqlRu1ZkRc0NjA8iISIbfoSGlcA0mqyRxaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDqIhLHMH9RaAjj9tkjNyituvSJSFrhXCPcIsrT/zEZfjfQEAS3htqwoqzsNP+y8S9Z0TFKq0kJFWXPOIfzIclS9HlM1s7II7sI4twXKYETRmGLIIGaPq2r87weNapk3XxfgxiYZOx9PtlcDl69BuU1MA1Aw8GnmiWlgLYDAzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v13E1277; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HspLqK4y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v13E1277";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HspLqK4y"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D6D7213802D7;
	Mon, 11 Nov 2024 05:39:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 11 Nov 2024 05:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321548;
	 x=1731407948; bh=9Z/42uTUFpugFtXlAD27+F/mw3LJKWg8Bw/T6qsNiqk=; b=
	v13E12777RW2nrk7nBl76iw0iUvF9lVNzl5Dd+Gx7gdvj3ipwaOESPaPJi35bSVS
	Y+ckUnmU/Tjw/geXJ+d+xz/xNJueaMeyccHfXFfN7v3OhPJ1Dola2aPooA44Q8GX
	Ts5fPS41vmrTSIvR5uczzcQP1xsvSo1rSsuT6GFoqBcVVnlBM1CjOEodl1NjdlDt
	wUbSKxGufBLH2dg+8qtv/1SCzGyuKhy4gFeljeV0Q21r4vf1oIrtPh9yxJUkcVGD
	O1g4sR0k4kIfVdpamYOIMx6jHe1GZxWU72R1KHZe4iqaFrPJg3HWs0dfLTswBzbu
	MqHCgaZOlV2qz5V2UH2X2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321548; x=
	1731407948; bh=9Z/42uTUFpugFtXlAD27+F/mw3LJKWg8Bw/T6qsNiqk=; b=H
	spLqK4yeoNZaxnACySs37FUzV/R4QN93pcvGChp5oo+YVs4tMAWw3U5OXBq2My3Q
	WRu8VgO4/irwBdiJwLCZAy83kygNj8pMcQJRynau8sesWrcBSOSKIVRkVQOXL4Ii
	k9Uw+dxVNWV3LIYWHyB1FBIBWMm8HmR9j/rvyA7HeS5tOKOZbFrCeDJxL04qd++s
	LjSBrgMhgRVQdLDR+8+4/gX/6gXpXDtgmsSPma0L9GlPqiXxBISfLdiNWW2pBgx1
	bGbcf7qkeWyt7Hi6Ywx+6Z0iRkFsCcguxS7afisXT3qWzRHidEmdNTZPeGYEfdmY
	X/QUH9DNsszDTi4F1Rifw==
X-ME-Sender: <xms:zN4xZ0dPkSsZSL1fsGSdrmAh9KaBJqzlrZOKJ1b28esahrDqaIXXQQ>
    <xme:zN4xZ2OnggnPPLoWnkswINs96m7Erumly_mqS1HAZDsA0KQV5vXRU-m-8A4Fc45pi
    L66C2-fuhQx9yYM2Q>
X-ME-Received: <xmr:zN4xZ1iPqI9k0hkCIoo9mdCw_guK_ZyBg5k5uX1kOeL01BSqhm0dyyaL7A0VluqZLUaAV9IrJGpsbNpls4KQhumk2-xC6KhhVZqgxy0cHvPNbTel>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zN4xZ5-EkVXuPdnTAGb1DKz-5nVCoQd0TIbUlRYjchVmxszZ7ZqOdw>
    <xmx:zN4xZwsW9IyZluXUx_GAs-WITdPy6OuQMfEfrEHcH_S9Gfc9v526Og>
    <xmx:zN4xZwHhxazLPPpnK7v3iqpgvHQyHpt2m6cmsjY-EUegb1ss3dYYUg>
    <xmx:zN4xZ_NE8RWxcwhliUbuw5lA_Du8LlQNzux1AMT9sfvCr3HHDVEAig>
    <xmx:zN4xZ565iYY6OmNHXM8VFot-h34gJq-uKBm06BS3sbJiE2KvZsxPbCQL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab2fd5f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:54 +0100
Subject: [PATCH v2 25/27] t: remove unneeded !SANITIZE_LEAK prerequisites
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-25-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

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
index c8d84ab6061a9de5fe26cd333fe8a7e504a5f963..08df74cacfc6910c51568705855dffa90b79d5be 100755
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
index f6835c91dcc49cfeb23881fe0ef7a96629bfb2e6..7750dc9265a90bdd8b0e3781accb13f00a23bb09 100755
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
index 3baa52a9bf653da9e45df720435cb23d0713e1db..0e5a05894fd1a1be1098b6895283452ca877137c 100755
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

