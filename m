Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E9C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAC222D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLUSQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgLUSQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:16:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7CBC061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:15:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y19so25765354lfa.13
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulbuL7UWviHjRCDo+NgObEnzTe1eCYG8vdzTzEa2WYM=;
        b=fqhK1oKeSoxPcYwsVJDkCMYJ7xzmZgzXmZJpFZ5LY2KXxg47pcEfOdYeNif4DhQtSL
         GVQbF9/UM/aMvU3PO3ZWlXOMa3kHPIutquAxB8pPFT6YoaM4mt1LRbA20XS6THACcnyJ
         7LtxD4+fDUgqkXEkS/pFtcVqql1Iw9DBYVE4QF8NI0vXvsxgPceDCcsd8jlxXoA4bjWX
         UwuZrUES7uJ4Q8fi8N06qiuG4Scrx8ggSQqhgFrbh7nmkheAw/V5yfBW0j+D+86VQ2qg
         KrBO6/Hlony8BIgeTvDGwpGoJiUrn4r5iRr3bXx4w3YAZwIHgnIN13Iu+YyuCNp4zplh
         u4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulbuL7UWviHjRCDo+NgObEnzTe1eCYG8vdzTzEa2WYM=;
        b=O83VUjNbCVbj284n3xjcf+JzuAl0J/yOkvlFsL/URVHWt8z3XgxKjvAZsDBXvzFOKL
         xH3AQMxfdg3q7eFSUZoPE/ZHtucbM1RBz/r0jLOQrLq8+1VV1Zc8TSivPzVYZtE0oOtk
         0jDnDQGEzh5MCbUql18JtBwX3Rcfnlz1L055Ukq0KdAQDGhpmlf0hk3M25LOJA1kWybY
         LtGXN35CIkPylhVmfxdkFMNGLtrX8g5qK19OBuXjlzThvLigmUI0jYBCpI3oxZQiJ3hI
         rrf6dMT1e6iNBzHGtLe2jYD/H+rhEBra9IPA+Q6tH6Y2b5osG2Bb5Ad/0MN+4eYXw78J
         yUow==
X-Gm-Message-State: AOAM530IbDQmCWv0ZjjKkR00yQAgNgfE1GBMZWHkUl/9xNiu2Jtnv+jK
        wpm3BWxCpfvm9PSmrCg6KpQL8UPnFlo=
X-Google-Smtp-Source: ABdhPJz2OUDTNezVEDPHdCboZUMi5xUVDV6vLCjtIo3hx3RHt/HTNylz6fn93fj38svZTvZ5hayWXQ==
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr6661769lfg.309.1608564040001;
        Mon, 21 Dec 2020 07:20:40 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:39 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 06/32] diff-merges: rename all functions to have common prefix
Date:   Mon, 21 Dec 2020 18:19:34 +0300
Message-Id: <20201221152000.13134-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the same "diff_merges" prefix for all the diff merges function
names.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c |  4 ++--
 diff-merges.c | 10 +++++-----
 diff-merges.h | 15 ++++++++++-----
 revision.c    |  6 +++---
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ad3092fdd854..77a7bba543ad 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -599,7 +599,7 @@ static int show_tree_object(const struct object_id *oid,
 static void show_setup_revisions_tweak(struct rev_info *rev,
 				       struct setup_revision_opt *opt)
 {
-	rev_diff_merges_default_to_dense_combined(rev);
+	diff_merges_default_to_dense_combined(rev);
 	if (!rev->diffopt.output_format)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
@@ -724,7 +724,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	if (!rev->diffopt.output_format && rev->combine_merges)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	rev_diff_merges_first_parent_defaults_to_enable(rev);
+	diff_merges_first_parent_defaults_to_enable(rev);
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
diff --git a/diff-merges.c b/diff-merges.c
index 0204292aa9bb..9286dbbd4dfd 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,12 +2,12 @@
 
 #include "revision.h"
 
-void init_diff_merge_revs(struct rev_info *revs)
+void diff_merges_init_revs(struct rev_info *revs)
 {
 	revs->ignore_merges = -1;
 }
 
-int parse_diff_merge_opts(struct rev_info *revs, const char **argv)
+int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 {
 	int argcount = 1;
 	const char *optarg;
@@ -46,7 +46,7 @@ int parse_diff_merge_opts(struct rev_info *revs, const char **argv)
 	return argcount;
 }
 
-void setup_diff_merges_revs(struct rev_info *revs)
+void diff_merges_setup_revs(struct rev_info *revs)
 {
 	if (revs->combine_merges && revs->ignore_merges < 0)
 		revs->ignore_merges = 0;
@@ -56,13 +56,13 @@ void setup_diff_merges_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
-void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs)
+void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs)
 {
 	if (revs->first_parent_only && revs->ignore_merges < 0)
 		revs->ignore_merges = 0;
 }
 
-void rev_diff_merges_default_to_dense_combined(struct rev_info *revs)
+void diff_merges_default_to_dense_combined(struct rev_info *revs)
 {
 	if (revs->ignore_merges < 0) {
 		/* There was no "-m" variant on the command line */
diff --git a/diff-merges.h b/diff-merges.h
index 7e970b266cf5..4ced909b795e 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -9,10 +9,15 @@
 
 struct rev_info;
 
-void init_diff_merge_revs(struct rev_info *revs);
-int parse_diff_merge_opts(struct rev_info *revs, const char **argv);
-void setup_diff_merges_revs(struct rev_info *revs);
-void rev_diff_merges_default_to_dense_combined(struct rev_info *revs);
-void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
+void diff_merges_init_revs(struct rev_info *revs);
+
+int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
+
+void diff_merges_setup_revs(struct rev_info *revs);
+
+void diff_merges_default_to_dense_combined(struct rev_info *revs);
+
+void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
+
 
 #endif
diff --git a/revision.c b/revision.c
index 4bc14a08a624..5a0e3d6ad542 100644
--- a/revision.c
+++ b/revision.c
@@ -1814,7 +1814,7 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	init_diff_merge_revs(revs);
+	diff_merges_init_revs(revs);
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
@@ -2350,7 +2350,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
 		revs->diffopt.flags.tree_in_recursive = 1;
-	} else if ((argcount = parse_diff_merge_opts(revs, argv))) {
+	} else if ((argcount = diff_merges_parse_opts(revs, argv))) {
 		return argcount;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
@@ -2849,7 +2849,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				      &revs->prune_data);
 	}
 
-	setup_diff_merges_revs(revs);
+	diff_merges_setup_revs(revs);
 
 	revs->diffopt.abbrev = revs->abbrev;
 
-- 
2.25.1

