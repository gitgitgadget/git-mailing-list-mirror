Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8B1BC41
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754785241; cv=none; b=Cc9hAZUjSiY9VPVYGuIZsVFdqGkfsgjw6rqqqa/5PBfveO51zN/Cgs6lE8v4Q/jQh2qq/0d4ERs+4BCJ+IBMh8+uvt3WjTYbW4FDMkTvdOO3uVyKGaP1GjmTn50OmCKt42od2McceovTWIif6KdoifkAL2OS0YaV5lBuIhWmoZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754785241; c=relaxed/simple;
	bh=GHXC3gmNRj6snajHqRMKy+uLDI0O/sytzVLkEvOzOws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i0zkQp7WXWUp2LTF1SdWz45Mw9P3oiZwSvb9KaIpcGXwsZT93uqzhFuO8IQZL6/yrVzmuzraNBAH55EvYdQWBNpyUsB0guz8v0qnKFkaqqJpWK9Q821g+Vr7EZy5ArwNbvBTgYb5tuGt2XxCSSyFGfr4SRiYrX6shbvr2vP2s4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q/uVj/R5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ib3cMpZi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q/uVj/R5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ib3cMpZi"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBAC41400040;
	Sat,  9 Aug 2025 20:20:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 09 Aug 2025 20:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1754785238; x=1754871638; bh=XQr+h+1jIw757JoQgsbuYYZV7zsrU6vt
	hW/Hxd95SVM=; b=Q/uVj/R5LlY4R4j9sq+dph8Rl+XWrxnnCcbm1b/coOk+sl1m
	PXbuxYKtd7yYiZ2l8x24BMo4fRmIdI6cRk+ie8yFWWrVW2OqZOxeFRI8CNGktSMy
	xgM9V8iQFo03jcj+fsLr3J1y+rm8R8fGrGOGgt5l1c08sSXlczqFKfbGXPI3pXM6
	gVRv934VvvBf65QgXJIIed5maiH/Y9vsso0i6j9SPPKq72nNRJpw67kjJjF7+K1h
	p+iQwy2ct+tkHdQZMKX3kWxpVikDts52EuE7CyOpQZw1j97XyoYzcZx2ZOtbXOOH
	XnajNg4EZ96JE1IBfgxe2P7vGwI/qDSTinI13w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754785238; x=
	1754871638; bh=XQr+h+1jIw757JoQgsbuYYZV7zsrU6vthW/Hxd95SVM=; b=i
	b3cMpZiX01/tSslOChAGYZYLJF765mWAYbvgaQDuoJoxxRG2Yt9ZKPz86XCa/nHn
	HMqlk3MBH9AUf2gm9TGVUFdz0nD3KY8Nz003UClzdZcaqmIf8JxPGF5sRh3wApcK
	pXvD5/+5p+j3pEhP2teH3E6viN5VT2luSU085YLmbBApzFFz+7faa6ivNWi77c3J
	LmiBSRyDltQasup33Wo2tJZ4NaoKa+YyFBwWYgPpz3b90db6VyqEfd1QucOx+z9k
	Iv/Xq0oTqO8AeMwwXiRSrFWCUYxM0sVipXiATbA6OZnCdGfxBJhibsFrZz+9fcSb
	zbuTeWE2B8AMKdlz4NZJA==
X-ME-Sender: <xms:1uWXaFrltv1znSF9x_dgj2UUTYdMVpKQC18KLWX0RYhNosEwbeE2OQ>
    <xme:1uWXaDHRfCJg6X7rL7_BUjvdd1Bh1kzBLjZsxH-unzUcmLsdV1h810r4ZrfrZ6c9x
    4SASKNFZldqxCkrNw>
X-ME-Received: <xmr:1uWXaFsrLrI5WE6FsMxByEwp7WZwDLhM2ibxmqiN0QqnIWVlwVpnj1Ts5lFRB_4uRoJShp5xBpcttKxSItXnJIu48sfuFVc_6oGc-04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdekudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepjefhgfefvdekfedthfejgeffieevieeifeegueeihfejleeufeffjeetkeffffej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghp
    thhtohepohhpvghnshhouhhrtggvsehgrhgvghhoihhrvghgvgdrihhspdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1uWXaFUerVUXKvgfrh7Ht-TxatyTAVTQknw297ucJfsTJpxoTqPEtg>
    <xmx:1uWXaBHbZFO-PapT2JpuwvGjFxuQFPVhXN-AA_y2lEnVQr4_3cm4eQ>
    <xmx:1uWXaH22D1YR8uC0nZirmo-TXAddldrkGUMiAAHR9toNH8Jj5C_3ag>
    <xmx:1uWXaDO-9pjh_du_kvI4yiclVT5MflAiXKOcPtxUJgYDDnuDHDZWMw>
    <xmx:1uWXaC-hZBtZWKzGeGiKk8wCfTx-NxD6FT3qdVD1GSEW38lup5Osutlz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Aug 2025 20:20:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Gregoire Geis <opensource@gregoirege.is>
Subject: [PATCH v2] diff: --no-index should ignore the worktree
Date: Sat, 09 Aug 2025 17:20:36 -0700
Message-ID: <xmqq1ppk58ob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The act of giving "--no-index" tells Git to pretend that the current
directory is not under control of any Git index or repository, so
even when you happen to be in a Git controlled working tree, where
in that working tree should not matter.

But the start-up sequence tries to discover the top of the working
tree and chdir(2)'s there, even before Git passes control to the
subcommand being run.  When diff_no_index() starts running, it
starts at a wrong (from the end-user's point of view who thinks "git
diff --no-index" is merely a better version of GNU diff) directory,
and the original directory the user started the command is at
"prefix".

Because the paths given from argv[] have already been adjusted to
account for this path shuffling by prepending the prefix, and
showing the resulting path by stripping the prefix, the effect of
these nonsense operations (nonsense in the context of "--no-index",
that is) is usually not observable.

Except for special cases like "-", where it is not preprocessed by
prepending the prefix.

Instead of papering over by adding more special cases only to cater
to the no-index codepath in the generic code, drive the diff
machinery more faithfully to what is going on.  If the user started
"git diff --no-index" in directory X/Y/Z in a working tree
controlled by Git, and the start up sequence of Git chdir(2)'ed up
to directory X and left Y/Z in the prefix, revert the effect of the
start up sequence by chdir'ing back to Y/Z and emptying the prefix.

Reported-by: Gregoire Geis <opensource@gregoirege.is>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/diff.c           | 15 +++++++++++++++
 t/t4053-diff-no-index.sh | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index 9a89e25a98..0b23c41456 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -487,6 +487,21 @@ int cmd_diff(int argc,
 
 	init_diff_ui_defaults();
 	repo_config(the_repository, git_diff_ui_config, NULL);
+
+	/*
+	 * If we are ignoring the fact that our current directory may
+	 * be part of a working tree controlled by a Git repository to
+	 * pretend to be a "better GNU diff", we should undo the
+	 * effect of the setup code that did a chdir() to the top of
+	 * the working tree.  Where we came from is recorded in the
+	 * prefix.
+	 */
+	if (no_index && prefix) {
+		if (chdir(prefix))
+			die(_("cannot come back to cwd"));
+		prefix = NULL;
+	}
+
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
 	repo_init_revisions(the_repository, &rev, prefix);
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 01db9243ab..44b4b13f5d 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -26,6 +26,23 @@ test_expect_success 'git diff --no-index directories' '
 	test_line_count = 14 cnt
 '
 
+test_expect_success 'git diff --no-index with -' '
+	cat >expect <<-\EOF &&
+	diff --git a/- b/-
+	new file mode 100644
+	--- /dev/null
+	+++ b/-
+	@@ -0,0 +1 @@
+	+frotz
+	EOF
+	(
+		cd a &&
+		echo frotz |
+		test_expect_code 1 git diff --no-index /dev/null - >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git diff --no-index relative path outside repo' '
 	(
 		cd repo &&

Range-diff against v1:
1:  456a265746 ! 1:  4166ccb163 diff: --no-index should ignore the worktree
    @@ builtin/diff.c: int cmd_diff(int argc,
     +	 * prefix.
     +	 */
     +	if (no_index && prefix) {
    -+		chdir(prefix);
    ++		if (chdir(prefix))
    ++			die(_("cannot come back to cwd"));
     +		prefix = NULL;
     +	}
     +
-- 
2.51.0-rc1-130-g831cc762e6

