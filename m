Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A3CCD37B7
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 08:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjIPIhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 04:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjIPIh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 04:37:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217BE7F
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 01:37:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31ff1f3cde5so1413728f8f.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694853439; x=1695458239; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPyGpAXCv6lDiCmDYIWWSC88CFQ8fJNuUQw3/k2L2zM=;
        b=nhZSXTuki3VfxkvvG/aYRGutpa4b20b/6urpgJQ9iyzThvC4K2DiRRKAu5hVyaYZf8
         5QuC6Ia9Smdu0jU3DPpmFqzvQgLOxvVMKEM6qNQ7X7pTDOZQjdjhYAM/XNtybtAq5eT4
         kgxt8+ntl1KSCRDFOT80MVVnpUfkP848AjzXjyBI8TZq6jos69jmvJYdMrVrieNX54Cy
         gIF10hMxQLbmb18DGcCuhbQACu9lv6cZPp5Rsc1BqQDPWbucBb+XRt0G+cJp3yxYeU0N
         TNJRitd/nvA0UcXAF1KZ/GizU1O+H4r+QvwYLTVP2l2tVshLJlIAhFJ05HdAHe+8ez1W
         kCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694853439; x=1695458239;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPyGpAXCv6lDiCmDYIWWSC88CFQ8fJNuUQw3/k2L2zM=;
        b=r/cP75ggjk/GwpOwwqqzY3fLx7VsTeY93+S7vtMQ29eeXRyb8RjC5RpaNkUcOLjhnd
         jMBuSutoP+Mb1kbBYd4qdfVB/VNnXsD2zxHDORm9a8WkUkHkOwydF3kqwm4so6POnKoA
         c7lFvdWqc2PEH/HtZsqyCx05bs2AsDcagBmwD7jExWL4xb7E9YUF5Se4MYaeroCx9mOm
         zhNgJ2POjF1hWkEu6KYXSJz8zVu3E50s6/Y5ouyy41dpVprCrOYEDjftBpi68mAtT7Jw
         m4kbMQcL5yGofSAFKJohmHSwn9qJP5kTPcnwXgth8rpayAThDpvVyJ1pRBPTfqUH2dQB
         eqMw==
X-Gm-Message-State: AOJu0YzjorvJh27mnepJg1ult16jFLgZaWLF0/FnT7hVwklIcWPw03ZZ
        mk3N6PgFY5qMMksEVix4ZBvJshZhO5o=
X-Google-Smtp-Source: AGHT+IGwFCt3v5V8c8RF3zUjYErSGp7Jes+LlJBfQFqbJWXeLcWdsYn8GbANLuGippx1v6nPgSw6YQ==
X-Received: by 2002:adf:dcc1:0:b0:317:5168:c21f with SMTP id x1-20020adfdcc1000000b003175168c21fmr2938818wrm.31.1694853438475;
        Sat, 16 Sep 2023 01:37:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bj17-20020a0560001e1100b0031fe0576460sm6365573wrb.11.2023.09.16.01.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 01:37:18 -0700 (PDT)
Message-ID: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
References: <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
From:   "Izzy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Sep 2023 08:37:17 +0000
Subject: [PATCH v5] merge-tree: add -X strategy option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1565%2FWingT%2Fmerge_tree_allow_strategy_option-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT/merge_tree_allow_strategy_option-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1565

Range-diff vs v4:

 1:  d2d8fcc2e9b ! 1:  28d4282e0d8 merge-tree: add -X strategy option
     @@ Commit message
      
       ## builtin/merge-tree.c ##
      @@
     + #include "quote.h"
       #include "tree.h"
       #include "config.h"
     ++#include "strvec.h"
       
     -+static const char **xopts;
     -+static size_t xopts_nr, xopts_alloc;
       static int line_termination = '\n';
       
     - struct merge_list {
      @@ builtin/merge-tree.c: struct merge_tree_options {
       	int show_messages;
       	int name_only;
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       
       	opt.branch1 = branch1;
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     - 	return !result.clean; /* result.clean < 0 handled above */
     - }
     - 
     -+static int option_parse_x(const struct option *opt,
     -+			  const char *arg, int unset)
     -+{
     -+	if (unset)
     -+		return 0;
     -+
     -+	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
     -+	xopts[xopts_nr++] = xstrdup(arg);
     -+	return 0;
     -+}
     -+
       int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       {
       	struct merge_tree_options o = { .show_messages = -1 };
     ++	struct strvec xopts = STRVEC_INIT;
     + 	int expected_remaining_argc;
     + 	int original_argc;
     + 	const char *merge_base = NULL;
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       			   &merge_base,
       			   N_("commit"),
       			   N_("specify a merge-base for the merge")),
     -+		OPT_CALLBACK('X', "strategy-option", &xopts,
     -+			N_("option=value"),
     -+			N_("option for selected merge strategy"),
     -+			option_parse_x),
     ++		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
     ++			N_("option for selected merge strategy")),
       		OPT_END()
       	};
       
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char
       	argc = parse_options(argc, argv, prefix, mt_options,
       			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
       
     -+	for (int x = 0; x < xopts_nr; x++)
     -+		if (parse_merge_opt(&o.merge_options, xopts[x]))
     -+			die(_("unknown strategy option: -X%s"), xopts[x]);
     ++	for (int x = 0; x < xopts.nr; x++)
     ++		if (parse_merge_opt(&o.merge_options, xopts.v[x]))
     ++			die(_("unknown strategy option: -X%s"), xopts.v[x]);
      +
       	/* Handle --stdin */
       	if (o.use_stdin) {
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Content merge and a few c
      +	git merge --abort &&
      +
      +	git merge -X ours side4 &&
     -+	git rev-parse HEAD^{tree} > expected &&
     ++	git rev-parse HEAD^{tree} >expected &&
      +
     -+    git merge-tree -X ours side1 side4 > actual &&
     ++	git merge-tree -X ours side1 side4 >actual &&
      +
      +	test_cmp expected actual
      +'


 builtin/merge-tree.c             | 11 +++++++++++
 t/t4301-merge-tree-write-tree.sh | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 0de42aecf4b..97d0fe6c952 100644
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
@@ -439,6 +441,8 @@ static int real_merge(struct merge_tree_options *o,
 
 	init_merge_options(&opt, the_repository);
 
+	opt.recursive_variant = o->merge_options.recursive_variant;
+
 	opt.show_rename_progress = 0;
 
 	opt.branch1 = branch1;
@@ -513,6 +517,7 @@ static int real_merge(struct merge_tree_options *o,
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
 	struct merge_tree_options o = { .show_messages = -1 };
+	struct strvec xopts = STRVEC_INIT;
 	int expected_remaining_argc;
 	int original_argc;
 	const char *merge_base = NULL;
@@ -548,6 +553,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &merge_base,
 			   N_("commit"),
 			   N_("specify a merge-base for the merge")),
+		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
+			N_("option for selected merge strategy")),
 		OPT_END()
 	};
 
@@ -556,6 +563,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
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
