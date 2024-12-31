Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49B1F94C
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735611520; cv=none; b=b2ZxvBKB142GEJIwMgLUej2n4iRkwjAPNagMdqsnH1Wynu/eyhDnFqx4bR8sdiETk1WW8VPCjgzSc43JiXNysVOycqBGiSv6S4S0gEfo2kVl7rQf92QVdmso7OWDaz24szsjzsu2TDRVwoYSQbHuFOvDlMy3UFKktIi5leDUJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735611520; c=relaxed/simple;
	bh=Y1/6q3uZ4YV8INkRWuZes4zDXjMkBukkYQ8+cTN0X/E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yj2cstlAVR6bp7GnwVyafY9q8bow4uDkpT0AaaEqYdjvn64aO5IpSmaV4QErIuFVoUkSFDgE1cyZKqsEv7XkTswYCfJ1HBDeORaFmfs8DE47GMZTnPK4vxhNNaxI2OJU6Eq3elPS/V9FUpV4a4DvWusmWQwiQHXV6tf5aWlkf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFohmI7k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFohmI7k"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4368a293339so56602115e9.3
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 18:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735611517; x=1736216317; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=burQHKoOYZby68jA4umEYDoh5VxoEqrj5exShMvyTQI=;
        b=nFohmI7kK6Y1Hd22UbNqSMrcGNSrni9oGeigdHNVUImCuQQcXjwcL2Vq/eoVbRs1qf
         YEeNnmIzCIS8nwuPIi4FXZaQhKSfTmBnKL11Uz4UcgkVx2WioPlgeB/nn/kAEj+fQbN8
         1iXPN/t7JewkweaHa074zWrwQCcVsh8DMGBQ3jTkmExioSCqHu2KskMOOJLjjmwa8DU3
         0vF2B0g6mQpESPNzl4Ow0jjQC0DpJV1A1nTpXiviLxNorJpUOSpmWsCC9dxzVKdu+hVZ
         /KhggqKDCRjcC0UyvfN0buLv+Nlyl4fzzNqqgp/QeizSQB914mjKu+r1y8R94apzqDIC
         8xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735611517; x=1736216317;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=burQHKoOYZby68jA4umEYDoh5VxoEqrj5exShMvyTQI=;
        b=Rgp1j3QHK4W8h1E5T9HmatE4qw/nG/x9V0HmOBOJLffb8THfkDDcEDKSQQ0BENzhbG
         3dvP/GMYq9QUvD2tyIX1Nh3dAmMSU3Xpfab9Wh8pKGMcmPRbKi14ovtXyvQXmXM/oFoN
         mPlWMpEBc682wM7QlzcBNYqv/xFvfPy8ob+xdM0/Pb30kVv2U9N9cV3ys5zNJavewsXa
         tytblgh332mIQ5oKaQm3Zm8Udr0UYdpoVo8049BaSdYNYWZSgNWiVKvo9m3G16aZ40Uk
         5VJP5myU+/C/kUVzPeWMb69m6nLp2j+X5ycX9hjSkRJSNPczzXli9znta2nsw8kdu6N2
         mKyg==
X-Gm-Message-State: AOJu0YzQ4zba4g6FzLB7ArigChOVHtEt3tzWUsyTXag/bu5Pt/do0mTY
	3P7SdJzgi+23nYL7VigWWcs4GpokcYIWujOsmGch0yHMW1tfnrDz0T+qQw==
X-Gm-Gg: ASbGncsEtJxb2ztlMCoIPbZzaVBZFcO5FnSrFLQYXFG/QfqGz0FXumpmCDfLYFOYb5N
	a8I8JYiA9Xs79RgBK+XrL7HysgqSR9zZB4b6SXB1tuo+c/ExHU7BAtjwN0p5uYoy8Ih1GCJO1K2
	lsy4Ci02qQtq/VHsRw7qtALBgtzBIlcvd4GR1RGj9tp3NNIdKzBuC0pdsZnntDgpekoo679LRg2
	HEt76Inx3TNeQgL/1m9JrJk2EV1O8mRER2B3MDxezmVw9Vn8QLUvKzrWQ==
X-Google-Smtp-Source: AGHT+IErgA18uUIxxW4K5aZuD2SUvZ+pt4d9c7jqDlGTdHWLv5A8ZYOeq3OSVV7zONawLft8ce6foA==
X-Received: by 2002:a05:6000:144b:b0:385:e37a:2a56 with SMTP id ffacd0b85a97d-38a223fd302mr30004874f8f.52.1735611516941;
        Mon, 30 Dec 2024 18:18:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828f8fsm31077750f8f.12.2024.12.30.18.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 18:18:36 -0800 (PST)
Message-Id: <14e94bf04e5ae3895eb61253be9c6d0a0fe56328.1735611513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
References: <pull.1843.git.1735041177817.gitgitgadget@gmail.com>
	<pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
From: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Dec 2024 02:18:32 +0000
Subject: [PATCH v2 1/2] gc: add `--expire-to` option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    ZheNing Hu <adlternative@gmail.com>,
    ZheNing Hu <adlternative@gmail.com>

From: ZheNing Hu <adlternative@gmail.com>

This commit extends the functionality of `git gc`
by adding a new option, `--expire-to=<dir>`. Previously,
this feature was implemented in `git repack` (see 91badeb),
allowing users to specify a directory where unreachable and
expired cruft packs are stored during garbage collection.
However, users had to run `git repack --cruft --expire-to=<dir>`
followed by `git prune` to achieve similar results within `git gc`.

By introducing `--expire-to=<dir>` directly into `git gc`,
we simplify the process for users who wish to manage their
repository's cleanup more efficiently. This change involves
passing the `--expire-to=<dir>` parameter through to `git repack`,
making it easier for users to set up a backup location for cruft
packs that will be pruned.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-gc.txt | 6 ++++++
 builtin/gc.c             | 6 +++++-
 t/t6500-gc.sh            | 6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 370e22faaeb..b4c0cf02972 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -69,6 +69,12 @@ be performed as well.
 	the `--max-cruft-size` option of linkgit:git-repack[1] for
 	more.
 
+--expire-to=<dir>::
+	When packing unreachable objects into a cruft pack, write a cruft
+	pack containing pruned objects (if any) to the directory `<dir>`.
+	See the `--expire-to` option of linkgit:git-repack[1] for
+	more.
+
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c9..77904694c9f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -136,6 +136,7 @@ struct gc_config {
 	char *prune_worktrees_expire;
 	char *repack_filter;
 	char *repack_filter_to;
+	char *repack_expire_to;
 	unsigned long big_pack_threshold;
 	unsigned long max_delta_cache_size;
 };
@@ -441,6 +442,8 @@ static void add_repack_all_option(struct gc_config *cfg,
 		if (cfg->max_cruft_size)
 			strvec_pushf(&repack, "--max-cruft-size=%lu",
 				     cfg->max_cruft_size);
+		if (cfg->repack_expire_to)
+			strvec_pushf(&repack, "--expire-to=%s", cfg->repack_expire_to);
 	} else {
 		strvec_push(&repack, "-A");
 		if (cfg->prune_expire)
@@ -675,7 +678,6 @@ struct repository *repo UNUSED)
 	const char *prune_expire_sentinel = "sentinel";
 	const char *prune_expire_arg = prune_expire_sentinel;
 	int ret;
-
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
 		{ OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"),
@@ -694,6 +696,8 @@ struct repository *repo UNUSED)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "keep-largest-pack", &keep_largest_pack,
 			 N_("repack all other packs except the largest pack")),
+		OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
+			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_END()
 	};
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index ee074b99b70..d4b0653a9b7 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -339,6 +339,12 @@ test_expect_success 'gc.maxCruftSize sets appropriate repack options' '
 	test_subcommand $cruft_max_size_opts --max-cruft-size=3145728 <trace2.txt
 '
 
+test_expect_success '--expire-to sets appropriate repack options' '
+	mkdir expired &&
+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --expire-to=./expired/pack &&
+	test_subcommand $cruft_max_size_opts --expire-to=./expired/pack <trace2.txt
+'
+
 run_and_wait_for_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
gitgitgadget

