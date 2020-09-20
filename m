Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA59AC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6703620EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLn4cunf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgITLWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgITLWm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BCFC0613D0
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id bw23so2862924pjb.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=56LkUKwzEcs/uoY40e6JBavUJJKJqxA7uBuZ2S+9glA=;
        b=BLn4cunftEG1mmQ29hsfkno/9KjXc0XWxjO69apzGZCHPzD2TDf9Fg5k/UlQl7rO46
         fOoVCourEWD7/++sfqE5nRi+4hBmfKo2lvVAdSV/dfZQRMyf4HMvnMZUWNUKa5u2PIuH
         tRTxu81CTrZEYh2FAcFRkZ8ei7sKmN1MaEMO2Gtzr2NZZNDW/hQMJwYjgRVRezWkjKHl
         GZh3iv28My3gdyCA97zk/hYlVcgMFfCYJmlHCFBNXNRRuKlFy2T6VXi2/2JWqA9VFeNP
         GC/0yOd8WfppNccKwP+lGvXtTLILNMjb/NZB6RTqxbYn/N+NxMJxbEbzVUlUWUQNHApV
         r1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56LkUKwzEcs/uoY40e6JBavUJJKJqxA7uBuZ2S+9glA=;
        b=P6UcbkKGznuWtMrmcRA/EZlUli9YB81uPYHgCjjj6J8WO/t9C2eqBU6Oi5/YaDUe0/
         y1LJWFj/ZMB0Fbiavy83virmS+hUZqGNBSqEgCSOihXA0rXe4/S+N9iPni7Sf0GYvnle
         RwA2Sgq80nOEbfbUVMARl71FWMJ7+k2pG/00SAgpkozkEk56GplZFSRVbBBk8mQe5XFl
         yTq/DNO+KYBifB5ELwu5k2I5nM2mKzXU7W2W/DbRotPtyJgYta7bxxk9ldBzYYQQ7og+
         Qtv20A3Y03TpACNFBoMFPoja6tZv8WJhEA7+x5PSXOlQRGOjv62T+AHIIpgdUZHJTgN4
         pt4g==
X-Gm-Message-State: AOAM531DDsnOnCqxrTItkbnMlhRZaVMTuyxZxtznoYfUDwC0IbsB4b0y
        yqfrAwGwdmD44+lfg1iyS/IwPioJ1GY=
X-Google-Smtp-Source: ABdhPJz6j5NZBn4Tut7pIMnRjPoNLQxgcfn3sYQvHsryJEPeVhlenDzQNzlMSGj3+xX1lOmOZK7aBw==
X-Received: by 2002:a17:902:9f84:b029:d1:cc21:9a49 with SMTP id g4-20020a1709029f84b02900d1cc219a49mr28859453plq.9.1600600961022;
        Sun, 20 Sep 2020 04:22:41 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:40 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 05/10] diff-lib: accept option flags in run_diff_index()
Date:   Sun, 20 Sep 2020 04:22:22 -0700
Message-Id: <99d8b51585b0b6831f3feaefb83de8390689b683.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
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
 diff-lib.c           | 3 ++-
 diff.h               | 4 +++-
 4 files changed, 13 insertions(+), 10 deletions(-)

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
index 50521e2093..d5b2c8af56 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -518,9 +518,10 @@ static int diff_cache(struct rev_info *revs,
 	return unpack_trees(1, &t, &opts);
 }
 
-int run_diff_index(struct rev_info *revs, int cached)
+int run_diff_index(struct rev_info *revs, unsigned int option)
 {
 	struct object_array_entry *ent;
+	int cached = !!(option & DIFF_INDEX_CACHED);
 
 	if (revs->pending.nr != 1)
 		BUG("run_diff_index must be passed exactly one tree");
diff --git a/diff.h b/diff.h
index e0c0af6286..aea0d5b96b 100644
--- a/diff.h
+++ b/diff.h
@@ -585,7 +585,9 @@ const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
 int run_diff_files(struct rev_info *revs, unsigned int option);
-int run_diff_index(struct rev_info *revs, int cached);
+
+#define DIFF_INDEX_CACHED 01
+int run_diff_index(struct rev_info *revs, unsigned int option);
 
 int do_diff_cache(const struct object_id *, struct diff_options *);
 int diff_flush_patch_id(struct diff_options *, struct object_id *, int, int);
-- 
2.28.0.760.g8d73e04208

