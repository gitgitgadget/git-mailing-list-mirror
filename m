Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE8C001E0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 05:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjHLFdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 01:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjHLFdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 01:33:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B980BF5
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 22:33:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so23075115e9.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 22:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691818388; x=1692423188;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4t2OT8M+X4UaFEeWJgVm2GkubU3cSiECtlvZtgvpUI0=;
        b=LeqXMySVRpanvVTVxl2fduVULB/QhE+IX7xVaEKLQfzTXa2D35M9k4PQct+31Zh95O
         0S9mJcJT/Ko/+7TNvCIQy/wy06EIMdBXGLFt+ZnD6F7Gbeo3RAyzCjE2Ty8a/8Q09cNg
         94u1JsLD5S7dl16O/xcmL7gx4617L3d2XTfnisTDDiNxJiYC32pgMwHbcQp6Uy6K/6kU
         JnI8wRhZUrYQYOVjxaqQ5FrWGH4S6TKyHdhWOeb0h/Z71wswxp3ClcuZX2mWS8GF0VZM
         qX1F87qN2vwehSYLG1CN+cBic1F4By7uP2SyUFa8G8kZDQSpg8w3iqCqUzzSHaJpNTMX
         FmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691818388; x=1692423188;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4t2OT8M+X4UaFEeWJgVm2GkubU3cSiECtlvZtgvpUI0=;
        b=guvnrPsp/+JNw3Cbioj44iqeGHt5v/875Yz6/BOmqDjnT2wxoj2zP5AnQbW2AqGRMl
         ++G/seee5Si/rx4/eP58fpNfNTzRgjsUaKz5vBLC5S6yvUwLYQVbxM08T9256JtMtFIA
         KwWBuXHU8Hn1QJMwv5t9tQQ/Ck95r9a28tPOjP/kz+FT2ls9jYIgWN2vBgG2TRt+vMXw
         mWa3le7x6FmNCClWAuMqjtsLHNM5A0kQE8Ha8Rx4EH8X7Sz07ye2uGbqC4z8qP8alsB3
         mirE8oAmTJfarcIw0CTfIz3jqWV6E2JpqjhSbNgOMSTOw7cyspRfGgHpS3/8txt5zb5j
         EYPQ==
X-Gm-Message-State: AOJu0YzB/w4Y4yDdi3ODqsDHrv9qeGR/RPQS1m5hR1xIxRLnZpb0n+B0
        TsPCz0C+4TNldoOqmcGofi+dxR6CW/0=
X-Google-Smtp-Source: AGHT+IEQyT/DUT4Ugkvo6cHTPloo7qlapa2DFerpCckZ9eCn8xPRFLOHGVoqo9on4Er6gGTeafCc4g==
X-Received: by 2002:a7b:c399:0:b0:3fe:24df:4180 with SMTP id s25-20020a7bc399000000b003fe24df4180mr3207631wmj.13.1691818387635;
        Fri, 11 Aug 2023 22:33:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c231600b003fc015ae1e1sm7298198wmo.3.2023.08.11.22.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 22:33:07 -0700 (PDT)
Message-ID: <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.git.1691245481977.gitgitgadget@gmail.com>
References: <pull.1565.git.1691245481977.gitgitgadget@gmail.com>
From:   "Izzy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Aug 2023 05:33:06 +0000
Subject: [PATCH v2] merge-tree: add -X strategy option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Izzy <winglovet@gmail.com>, winglovet <winglovet@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: winglovet <winglovet@gmail.com>

Add merge strategy option to produce more customizable merge result such
as automatically solve conflicts.

Signed-off-by: winglovet <winglovet@gmail.com>
---
    merge-tree: add -X strategy option
    
    Change-Id: I16be592262d13cebcff8726eb043f7ecdb313b76

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1565%2FWingT%2Fmerge_tree_allow_strategy_option-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT/merge_tree_allow_strategy_option-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1565

Range-diff vs v1:

 1:  b843caed596 ! 1:  7d53d08381e merge-tree: add -X strategy option
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char
       	/* Handle --stdin */
       	if (o.use_stdin) {
       		struct strbuf buf = STRBUF_INIT;
     +
     + ## t/t4301-merge-tree-write-tree.sh ##
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
     + 	git branch side1 &&
     + 	git branch side2 &&
     + 	git branch side3 &&
     ++	git branch side4 &&
     + 
     + 	git checkout side1 &&
     + 	test_write_lines 1 2 3 4 5 6 >numbers &&
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
     + 	test_tick &&
     + 	git commit -m rename-numbers &&
     + 
     ++	git checkout side4 &&
     ++	test_write_lines 0 1 2 3 4 5 >numbers &&
     ++	echo yo >greeting &&
     ++	git add numbers greeting &&
     ++	test_tick &&
     ++	git commit -m other-content-modifications &&
     ++
     + 	git switch --orphan unrelated &&
     + 	>something-else &&
     + 	git add something-else &&
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Content merge and a few conflicts' '
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'Auto resolve conflicts by "ours" stragety option' '
     ++	git checkout side1^0 &&
     ++
     ++	# make sure merge conflict exists
     ++	test_must_fail git merge side4 &&
     ++	git merge --abort &&
     ++
     ++	git merge -X ours side4 &&
     ++	git rev-parse HEAD^{tree} > expected &&
     ++
     ++    git merge-tree -X ours side1 side4 > actual &&
     ++
     ++	test_cmp expected actual
     ++'
     ++
     + test_expect_success 'Barf on misspelled option, with exit code other than 0 or 1' '
     + 	# Mis-spell with single "s" instead of double "s"
     + 	test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR side1 side2 2>expect &&


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
index 250f721795b..2718817628c 100755
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
 
+test_expect_success 'Auto resolve conflicts by "ours" stragety option' '
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
