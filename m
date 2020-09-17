Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71E6C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B516206DC
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdoMxMVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIQHp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgIQHol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA14C06178A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l71so879159pge.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lEIs0fiNoKXMQOFVICJuD8pB9r3fR2cLnKNpmAitwzc=;
        b=YdoMxMVaK6LNOk+OChrgV9M8W6BpCkeHEfs9J2RhxmFDnXh/QzDJJwdZ7Wr1tJi/Az
         ljBNQdf1lsq0Zqah0hCWzVjLGEs2useozFckA3KrTA5Bp1OubGiwVMeRK8kxZnQy37mF
         EPTsbMWqAKdrZ9hGOdasHgiv+rETE4rM5gBNQS/HY9BaUN+1eKh3zcaVTmETrXUeUCo5
         RxMXDfdgbxcdoTUN0tLIMwnmn6CmhBos2FIT8bM67lUC03xVMGgN+BwQq7aSSUo3FngR
         B2CXW+eA4eo7qcFN4h+psD9Xi+vlcSkxj16HI/ppJyjlf3m8m9tn3hugbnMxm4NxsOnB
         7lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lEIs0fiNoKXMQOFVICJuD8pB9r3fR2cLnKNpmAitwzc=;
        b=ZraaxuE8zrL9JvkvTDshvG+ieUvEJM8Fz4+1H00k/6dOqJ0nyEevrvB9ENNdtKJCc2
         vOsM5R/Yi/l9mPUnIQzzuZeCgCfGtvTmVT9ytogD9kO8+k6/gM4GKy59NOZSIWvvRXyu
         sXv7zu8tsRqWp92IP3o0zLVd2XH799CAwEqDrKvnxtcVz5cxTzgf1qr+8oOkBkoyz6L/
         4sRv61ydJa91Tguy2TXJbGDItSN9Vx6CdYSZRgJa+/FXNHnYPygpF+JoNLXHohgBpikp
         i52cRahXhNYFQG48a58h7FLGZssAAkETHM921uOUMKoHP40DPsChXqbyhnZw6p3rXpd0
         z2cw==
X-Gm-Message-State: AOAM532sYCQIoQfVzcA/nATN/3VGMSLEQy1m00j6igdweargCV97Qhzh
        RbqrOySXVL2byUYdk0tXQTTP6J9+wqkKsQ==
X-Google-Smtp-Source: ABdhPJw7K3KJR9jBIZh7CxJhSoAhIxrb+Ot4CStfHn3Sq+k+eRisGWGGqmgb66UOcNZG6NEAxmPRaA==
X-Received: by 2002:a63:85c2:: with SMTP id u185mr20891790pgd.157.1600328678199;
        Thu, 17 Sep 2020 00:44:38 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:37 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/10] diff-lib: accept option flags in run_diff_index()
Date:   Thu, 17 Sep 2020 00:44:09 -0700
Message-Id: <496908ac10152edb9cbcfdb75c43b1d00e163e3c.1600328335.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com> <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will teach run_diff_index() to accept more
options via flag bits. For now, change `cached` into a flag in the
`option` bitfield. The behaviour should remain exactly the same.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/diff-index.c | 8 ++++----
 builtin/diff.c       | 8 ++++----
 diff-lib.c           | 6 +++---
 diff.h               | 3 ++-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 93ec642423..c3878f7ad6 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -15,7 +15,7 @@ COMMON_DIFF_OPTIONS_HELP;
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	int cached = 0;
+	unsigned int option = 0;
 	int i;
 	int result;
 
@@ -32,7 +32,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 
 		if (!strcmp(arg, "--cached"))
-			cached = 1;
+			option |= DIFF_INDEX_CACHED;
 		else
 			usage(diff_cache_usage);
 	}
@@ -46,7 +46,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	if (rev.pending.nr != 1 ||
 	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
 		usage(diff_cache_usage);
-	if (!cached) {
+	if (!(option & DIFF_INDEX_CACHED)) {
 		setup_work_tree();
 		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
 			perror("read_cache_preload");
@@ -56,7 +56,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		perror("read_cache");
 		return -1;
 	}
-	result = run_diff_index(&rev, cached);
+	result = run_diff_index(&rev, option);
 	UNLEAK(rev);
 	return diff_result_code(&rev.diffopt, result);
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index cb98811c21..e45e19e37e 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -134,11 +134,11 @@ static int builtin_diff_blobs(struct rev_info *revs,
 static int builtin_diff_index(struct rev_info *revs,
 			      int argc, const char **argv)
 {
-	int cached = 0;
+	unsigned int option = 0;
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--cached") || !strcmp(arg, "--staged"))
-			cached = 1;
+			option |= DIFF_INDEX_CACHED;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -151,7 +151,7 @@ static int builtin_diff_index(struct rev_info *revs,
 	    revs->max_count != -1 || revs->min_age != -1 ||
 	    revs->max_age != -1)
 		usage(builtin_diff_usage);
-	if (!cached) {
+	if (!(option & DIFF_INDEX_CACHED)) {
 		setup_work_tree();
 		if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
 			perror("read_cache_preload");
@@ -161,7 +161,7 @@ static int builtin_diff_index(struct rev_info *revs,
 		perror("read_cache");
 		return -1;
 	}
-	return run_diff_index(revs, cached);
+	return run_diff_index(revs, option);
 }
 
 static int builtin_diff_tree(struct rev_info *revs,
diff --git a/diff-lib.c b/diff-lib.c
index 50521e2093..0a0e69113c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -518,7 +518,7 @@ static int diff_cache(struct rev_info *revs,
 	return unpack_trees(1, &t, &opts);
 }
 
-int run_diff_index(struct rev_info *revs, int cached)
+int run_diff_index(struct rev_info *revs, unsigned int option)
 {
 	struct object_array_entry *ent;
 
@@ -527,10 +527,10 @@ int run_diff_index(struct rev_info *revs, int cached)
 
 	trace_performance_enter();
 	ent = revs->pending.objects;
-	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
+	if (diff_cache(revs, &ent->item->oid, ent->name, !!(option & DIFF_INDEX_CACHED)))
 		exit(128);
 
-	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
+	diff_set_mnemonic_prefix(&revs->diffopt, "c/", (option & DIFF_INDEX_CACHED) ? "i/" : "w/");
 	diffcore_fix_diff_index();
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
diff --git a/diff.h b/diff.h
index e0c0af6286..0cc874f2d5 100644
--- a/diff.h
+++ b/diff.h
@@ -585,7 +585,8 @@ const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
 int run_diff_files(struct rev_info *revs, unsigned int option);
-int run_diff_index(struct rev_info *revs, int cached);
+#define DIFF_INDEX_CACHED 01
+int run_diff_index(struct rev_info *revs, unsigned int option);
 
 int do_diff_cache(const struct object_id *, struct diff_options *);
 int diff_flush_patch_id(struct diff_options *, struct object_id *, int, int);
-- 
2.28.0.618.gf4bc123cb7

