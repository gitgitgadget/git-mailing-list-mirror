Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3455ECD37B1
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 03:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjIPDrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 23:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjIPDrO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 23:47:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AFA1BF2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:47:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-403012f27e1so29197705e9.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694836027; x=1695440827; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnaGGZYB5HN2ZYQxuUOFtfxVqYp34mjnV8JcgU4ukmM=;
        b=J2wrOlgPnq5ncnuBTAYpywttqFIpYZLdtJty+MW64nxbPDSbxeqPktXPYJ6EuRPX9e
         3jfCrLxFltbgz6sImxFyNa1i8qas4X/x+XkfZp21pkN99KN2I/1ShHhuEl3nVTwwC4zF
         wzBUZQ9BGjMNPnX1KwUzy2SrJ1wKSYvoNMJbh2/A/m7ue1ct/9xFqto94/3MuSVl3AG3
         yrZu8U0kGClQNw2YBt2GfLp88+tfkEmbBoHuOsnze4o1zpDWARy2kKvoWJ1akMJa0ze0
         aT6m0gKgZNhq59K6/UW1vmNRmPlsVswMjzTz5s1Waag2aCodgm9Yi6tlbCuH6wtyDWcc
         hWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694836027; x=1695440827;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnaGGZYB5HN2ZYQxuUOFtfxVqYp34mjnV8JcgU4ukmM=;
        b=ERyvYeOFaUkpT0JzKvNwmlMN+Q+KbNwyt/uX51FGLUVDd+KzvHN4BMoko4JsK9OIix
         69ZBZD91dh47HwbGktIhRtbQLsHLzg9Hi4WOnalltzerW5FS/UBiUciUnRp88ORgXB4Z
         m8TjCffOxbLaxfp6yj3WdtYMcG+NrO9PO1TZopa3sZJkykhZ4BQUbvgLJY6Po5jMaq+R
         +6YCJHFyxL/hJHyHP9BzfTlf+2HR5OnEJRqKYPo9ugjfuACFgF5ewONOjy6x8UZntMtX
         KwaawqlO8hulnn8uatdlYuP7tHOR6xqZ8Hz39nRcYuyZgV69hqtgP0xY/DFG+Giw0zCA
         fEng==
X-Gm-Message-State: AOJu0YwvA2TdJZNzF+w5c4QYUPulZFjmynT2JchQzRzJD2tzZapuHdrw
        Z9x1Xjts8V3i0NI/XHa5Gl4gJGTDjBo=
X-Google-Smtp-Source: AGHT+IGVF9yxATpN2kkVn7kBhmJNaNGc0MyjU7VwbKUHkdh5S9MVI3+rjb+OlbZQ6JyFHJyqa/25Aw==
X-Received: by 2002:a05:600c:2990:b0:400:ce4f:f184 with SMTP id r16-20020a05600c299000b00400ce4ff184mr3113229wmd.41.1694836026581;
        Fri, 15 Sep 2023 20:47:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7-20020a1c7707000000b003fedcd02e2asm6172331wmi.35.2023.09.15.20.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 20:47:06 -0700 (PDT)
Message-ID: <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com>
References: <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com>
From:   "Izzy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Sep 2023 03:47:05 +0000
Subject: [PATCH v4] merge-tree: add -X strategy option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Izzy <winglovet@gmail.com>,
        Tang Yuyi <winglovet@gmail.com>
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1565%2FWingT%2Fmerge_tree_allow_strategy_option-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT/merge_tree_allow_strategy_option-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1565

Range-diff vs v3:

 1:  d64a774fa7c ! 1:  d2d8fcc2e9b merge-tree: add -X strategy option
     @@ Commit message
          merge-tree: add -X strategy option
      
          Add merge strategy option to produce more customizable merge result such
     -    as automatically solve conflicts.
     +    as automatically resolving conflicts.
      
          Signed-off-by: Tang Yuyi <winglovet@gmail.com>
      


 builtin/merge-tree.c             | 24 ++++++++++++++++++++++++
 t/t4301-merge-tree-write-tree.sh | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 0de42aecf4b..2ec6ec0d39a 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -19,6 +19,8 @@
 #include "tree.h"
 #include "config.h"
 
+static const char **xopts;
+static size_t xopts_nr, xopts_alloc;
 static int line_termination = '\n';
 
 struct merge_list {
@@ -414,6 +416,7 @@ struct merge_tree_options {
 	int show_messages;
 	int name_only;
 	int use_stdin;
+	struct merge_options merge_options;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -439,6 +442,8 @@ static int real_merge(struct merge_tree_options *o,
 
 	init_merge_options(&opt, the_repository);
 
+	opt.recursive_variant = o->merge_options.recursive_variant;
+
 	opt.show_rename_progress = 0;
 
 	opt.branch1 = branch1;
@@ -510,6 +515,17 @@ static int real_merge(struct merge_tree_options *o,
 	return !result.clean; /* result.clean < 0 handled above */
 }
 
+static int option_parse_x(const struct option *opt,
+			  const char *arg, int unset)
+{
+	if (unset)
+		return 0;
+
+	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
+	xopts[xopts_nr++] = xstrdup(arg);
+	return 0;
+}
+
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
 	struct merge_tree_options o = { .show_messages = -1 };
@@ -548,6 +564,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &merge_base,
 			   N_("commit"),
 			   N_("specify a merge-base for the merge")),
+		OPT_CALLBACK('X', "strategy-option", &xopts,
+			N_("option=value"),
+			N_("option for selected merge strategy"),
+			option_parse_x),
 		OPT_END()
 	};
 
@@ -556,6 +576,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
+	for (int x = 0; x < xopts_nr; x++)
+		if (parse_merge_opt(&o.merge_options, xopts[x]))
+			die(_("unknown strategy option: -X%s"), xopts[x]);
+
 	/* Handle --stdin */
 	if (o.use_stdin) {
 		struct strbuf buf = STRBUF_INIT;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 250f721795b..4125bb101ec 100755
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
+	git rev-parse HEAD^{tree} > expected &&
+
+    git merge-tree -X ours side1 side4 > actual &&
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
