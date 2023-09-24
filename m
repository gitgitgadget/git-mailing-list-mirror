Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28765CE7A89
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 02:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjIXCXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 22:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXCXw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 22:23:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39937124
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 19:23:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-313e742a787so2981350f8f.1
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 19:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695522224; x=1696127024; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do8JhG14U9bK2eHpALIHvTA+zNYh2+624BCRWn/vzhw=;
        b=LdpF4KLJtpbuh6jxH3COReA4NJSdoEbBpwQ4J/3EjYZamHecYmZIGBYPn/Vv/5n/e6
         5hzmYktJtwXEqF77kY68E1YkNjA+QM5UPMXAlb1ecCELoD17opwKITDzMpTNJPN+K3Dn
         5403x1TP93xE9IwfwvSjSNp+kOd8iiDLMJDwY7/R0n/XGQt7ckHal29ld+16TznvGSM2
         Oa1lKprjc2QrwGuO8G39bbTr9ujKpQX1XTuRtbqQzgS7VdctzKquTLDrsQmn0lEJpUFZ
         fgHUldLtBdnSAG0oKtcT+UdM3ilJIAwaNzVR2lYItE/eRzpClZkIYFFYy24lSUyGOBpd
         Tfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695522224; x=1696127024;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do8JhG14U9bK2eHpALIHvTA+zNYh2+624BCRWn/vzhw=;
        b=YCQbnO0pqNUnQanOJbthavUlvtoBYD2HcDupjMJOpML//HECqOEqj/xfaTaRAyEzLh
         jNvnx3kXRfYu3eIPQ1QyQiy6kCx9qt4VjyhuLAMTbpBT/pTsD1gWYLnkxU51fgsZMLQk
         8QQ4Od5hT9FzQZHNT8sBLJTRDDbSHQD23uTcCMBlfo1AyK7fr4K2KGQ4DNJxLTG9+v+m
         abHB0ebMd7JKfSJusVedIjj6bSBMCg+ZsgGnBm4uJYSEE86ou5wdW+YWyDeU1seBZt9C
         6lYK78hrPk2pPOz1yqD/HDwwMXdGi0tHG9/3Rr8i7ibXORcZI0BrbZBb9bhm98jlmn5a
         UDcg==
X-Gm-Message-State: AOJu0YygsS03uEDYJ5+EJN9DB/sfLwJnV0cTl0Ol+LvFqBPh3Or5/5bA
        J69G8RiD5llJqt1AUEdLNXtgOFhgswA=
X-Google-Smtp-Source: AGHT+IEZoUYxVzza1Fr563tFAWkMbciIMwoPn/fWgTRMiJP3/A/8GaCB/hd1tCcVQRXkQz6wCjuXEA==
X-Received: by 2002:a5d:4003:0:b0:321:f74d:ade3 with SMTP id n3-20020a5d4003000000b00321f74dade3mr4489683wrp.32.1695522224063;
        Sat, 23 Sep 2023 19:23:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g20-20020a7bc4d4000000b0040588d85b3asm68207wmk.15.2023.09.23.19.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:23:43 -0700 (PDT)
Message-ID: <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
References: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
From:   "Izzy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Sep 2023 02:23:42 +0000
Subject: [PATCH v6] merge-tree: add -X strategy option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Izzy <winglovet@gmail.com>, Tang Yuyi <winglovet@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tang Yuyi <winglovet@gmail.com>

Add merge strategy option to produce more customizable merge result such
as automatically resolving conflicts.

Signed-off-by: Tang Yuyi <winglovet@gmail.com>
---
    merge-tree: add -X strategy option
    
    Change-Id: I16be592262d13cebcff8726eb043f7ecdb313b76

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1565%2FWingT%2Fmerge_tree_allow_strategy_option-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT/merge_tree_allow_strategy_option-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1565

Range-diff vs v5:

 1:  28d4282e0d8 ! 1:  6a3dd8aeb13 merge-tree: add -X strategy option
     @@ builtin/merge-tree.c: struct merge_tree_options {
       
       static int real_merge(struct merge_tree_options *o,
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     + {
     + 	struct commit *parent1, *parent2;
     + 	struct commit_list *merge_bases = NULL;
     +-	struct merge_options opt;
     ++	struct merge_options opt = o->merge_options;
     + 	struct merge_result result = { 0 };
     + 	int show_messages = o->show_messages;
       
     - 	init_merge_options(&opt, the_repository);
     +@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     + 		help_unknown_ref(branch2, "merge-tree",
     + 				 _("not something we can merge"));
       
     -+	opt.recursive_variant = o->merge_options.recursive_variant;
     -+
     +-	init_merge_options(&opt, the_repository);
     +-
       	opt.show_rename_progress = 0;
       
       	opt.branch1 = branch1;
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char
       		OPT_END()
       	};
       
     -@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     ++	/* Init merge options */
     ++	init_merge_options(&o.merge_options, the_repository);
     ++
     + 	/* Parse arguments */
     + 	original_argc = argc - 1; /* ignoring argv[0] */
       	argc = parse_options(argc, argv, prefix, mt_options,
       			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
       
     ++	if (xopts.nr && o.mode == MODE_TRIVIAL)
     ++		die(_("--trivial-merge is incompatible with all other options"));
      +	for (int x = 0; x < xopts.nr; x++)
      +		if (parse_merge_opt(&o.merge_options, xopts.v[x]))
      +			die(_("unknown strategy option: -X%s"), xopts.v[x]);


 builtin/merge-tree.c             | 18 +++++++++++++++---
 t/t4301-merge-tree-write-tree.sh | 23 +++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 0de42aecf4b..7024b5ce2e4 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -18,6 +18,7 @@
 #include "quote.h"
 #include "tree.h"
 #include "config.h"
+#include "strvec.h"
 
 static int line_termination = '\n';
 
@@ -414,6 +415,7 @@ struct merge_tree_options {
 	int show_messages;
 	int name_only;
 	int use_stdin;
+	struct merge_options merge_options;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -423,7 +425,7 @@ static int real_merge(struct merge_tree_options *o,
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *merge_bases = NULL;
-	struct merge_options opt;
+	struct merge_options opt = o->merge_options;
 	struct merge_result result = { 0 };
 	int show_messages = o->show_messages;
 
@@ -437,8 +439,6 @@ static int real_merge(struct merge_tree_options *o,
 		help_unknown_ref(branch2, "merge-tree",
 				 _("not something we can merge"));
 
-	init_merge_options(&opt, the_repository);
-
 	opt.show_rename_progress = 0;
 
 	opt.branch1 = branch1;
@@ -513,6 +513,7 @@ static int real_merge(struct merge_tree_options *o,
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
 	struct merge_tree_options o = { .show_messages = -1 };
+	struct strvec xopts = STRVEC_INIT;
 	int expected_remaining_argc;
 	int original_argc;
 	const char *merge_base = NULL;
@@ -548,14 +549,25 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &merge_base,
 			   N_("commit"),
 			   N_("specify a merge-base for the merge")),
+		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
+			N_("option for selected merge strategy")),
 		OPT_END()
 	};
 
+	/* Init merge options */
+	init_merge_options(&o.merge_options, the_repository);
+
 	/* Parse arguments */
 	original_argc = argc - 1; /* ignoring argv[0] */
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (xopts.nr && o.mode == MODE_TRIVIAL)
+		die(_("--trivial-merge is incompatible with all other options"));
+	for (int x = 0; x < xopts.nr; x++)
+		if (parse_merge_opt(&o.merge_options, xopts.v[x]))
+			die(_("unknown strategy option: -X%s"), xopts.v[x]);
+
 	/* Handle --stdin */
 	if (o.use_stdin) {
 		struct strbuf buf = STRBUF_INIT;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 250f721795b..b2c8a43fce3 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -22,6 +22,7 @@ test_expect_success setup '
 	git branch side1 &&
 	git branch side2 &&
 	git branch side3 &&
+	git branch side4 &&
 
 	git checkout side1 &&
 	test_write_lines 1 2 3 4 5 6 >numbers &&
@@ -46,6 +47,13 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m rename-numbers &&
 
+	git checkout side4 &&
+	test_write_lines 0 1 2 3 4 5 >numbers &&
+	echo yo >greeting &&
+	git add numbers greeting &&
+	test_tick &&
+	git commit -m other-content-modifications &&
+
 	git switch --orphan unrelated &&
 	>something-else &&
 	git add something-else &&
@@ -97,6 +105,21 @@ test_expect_success 'Content merge and a few conflicts' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Auto resolve conflicts by "ours" strategy option' '
+	git checkout side1^0 &&
+
+	# make sure merge conflict exists
+	test_must_fail git merge side4 &&
+	git merge --abort &&
+
+	git merge -X ours side4 &&
+	git rev-parse HEAD^{tree} >expected &&
+
+	git merge-tree -X ours side1 side4 >actual &&
+
+	test_cmp expected actual
+'
+
 test_expect_success 'Barf on misspelled option, with exit code other than 0 or 1' '
 	# Mis-spell with single "s" instead of double "s"
 	test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR side1 side2 2>expect &&

base-commit: ac83bc5054c2ac489166072334b4147ce6d0fccb
-- 
gitgitgadget
