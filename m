Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B88CD37B0
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 02:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjIPCPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 22:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbjIPCOd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 22:14:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99E1FCE
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:14:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso31571115e9.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694830465; x=1695435265; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWBVBcpY1yqVG7XPGdnKaUzUzfvMNTXzTD9iw6ofSz8=;
        b=gsfIFncr6G21wuw55fvl1BKIzE7xDFk7H6y36hPvqFoCjx8N8uXkqEfr7QuEsY8tNa
         PiRenfRFUjFVIHqLOD2ZpOq/Q7YIAWQaZZ7zyu0bwS6cX8qnkCWz5YxtLtygNU2Iczme
         bHHMIaOHF3CarIN7W7+yE4ZfyCHFyGMrFPPPGIq7sX0WxDm+CzTgYNrHjMaRg2GQqTKX
         wAmzAngReJWaZT8VIvIGVd3vGpivxnGJ0U7UcjGGFUnPfn8T9VmFbL8xE5zPkqMHDfbt
         27Qx0Fvvzv91DTd2ivzEJc+hBSdbwG8VAnYOuGLOXYYKG4mE4N0LeHQ7B7FOEiFmAWg+
         FZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694830465; x=1695435265;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWBVBcpY1yqVG7XPGdnKaUzUzfvMNTXzTD9iw6ofSz8=;
        b=nY7aqbC67g+dIBDZOy1iDpRgo3C7ycfg7cFnV54jGtCv8Q6fDN0OLDcx6m8rAE5l4w
         mus9HVYgK4mcHBa8lqcJN4vb/HVe0vOp8EjD9zyUzQXfWRm6xFkyPXauDUHf9kmITH6z
         /xsjHTrtgmz8/9Ad5Ogzv6MxlPSCDMRX4+DDj/BqRak4PCMEsG1WFE21bZJhjwucguWp
         JhXGLng8/2wbyMwXPeELEEREO4dFsirR7cCV+PxSJ24M11Pj17/7OpXCVl+hoWY+6CN/
         0nOMH9aNpgWcjvXzqjyaxn2NNz7q1LQPQlgT8LLtMd+I7nN6dwiApPxeUSzgb8EOwROU
         76dQ==
X-Gm-Message-State: AOJu0YyortqnIkpvrzNGN4fRTJDGE28k9rm80Yf21zZKHq1S/ovcI2YZ
        hENG8qGY8k9RbCoCYFLSds693qRGQ0g=
X-Google-Smtp-Source: AGHT+IHgwKhbmnNquKkm74vBE6LFe8+nbyTG+viwqaFU9Vo1WKJKKzzTPlXml/oaIohJtAX7qyfK3Q==
X-Received: by 2002:adf:a209:0:b0:320:254:b874 with SMTP id p9-20020adfa209000000b003200254b874mr73166wra.11.1694830464385;
        Fri, 15 Sep 2023 19:14:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fg5-20020a056402548500b00530aae2d5bfsm752715edb.9.2023.09.15.19.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 19:14:24 -0700 (PDT)
Message-ID: <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com>
References: <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com>
From:   "Izzy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Sep 2023 02:14:22 +0000
Subject: [PATCH v3] merge-tree: add -X strategy option
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
as automatically solve conflicts.

Signed-off-by: Tang Yuyi <winglovet@gmail.com>
---
    merge-tree: add -X strategy option
    
    Change-Id: I16be592262d13cebcff8726eb043f7ecdb313b76

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1565%2FWingT%2Fmerge_tree_allow_strategy_option-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT/merge_tree_allow_strategy_option-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1565

Range-diff vs v2:

 1:  7d53d08381e ! 1:  d64a774fa7c merge-tree: add -X strategy option
     @@
       ## Metadata ##
     -Author: winglovet <winglovet@gmail.com>
     +Author: Tang Yuyi <winglovet@gmail.com>
      
       ## Commit message ##
          merge-tree: add -X strategy option
     @@ Commit message
          Add merge strategy option to produce more customizable merge result such
          as automatically solve conflicts.
      
     -    Signed-off-by: winglovet <winglovet@gmail.com>
     +    Signed-off-by: Tang Yuyi <winglovet@gmail.com>
      
       ## builtin/merge-tree.c ##
      @@
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Content merge and a few c
       	test_cmp expect actual
       '
       
     -+test_expect_success 'Auto resolve conflicts by "ours" stragety option' '
     ++test_expect_success 'Auto resolve conflicts by "ours" strategy option' '
      +	git checkout side1^0 &&
      +
      +	# make sure merge conflict exists


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
