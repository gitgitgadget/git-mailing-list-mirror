Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51570C5517A
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 08:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01BF20731
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 08:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbQjq/+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgKJIjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 03:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJIjs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 03:39:48 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B37C0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 00:39:44 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r10so9537478pgb.10
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 00:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffDoSnr6w6wMo6QiA5YtZqMGcMHa1Zygb80YtCAF6gA=;
        b=nbQjq/+EOjO7K8cYA8oDe06G4XArQlo3k2xC2D1VpSVFE3eb7OXGgrfRj6JgdcrQjt
         Hnqrms5XZUymVwFl+5Cyrpsd8BiT7m1C8dsgcaaaeLPsOvSE7T0REjrh13wCCg8u8Qq+
         XBFUpS1czJjh2LyUnj4tBz8xxIjbl+X0C4xfUc4DDmQk73FiLVIj9/pIWyphKVlJYYiq
         dayhBlHFmhRGeho6TUvhpRNjCt2OBjD7/ADZRbWFyibtFJtFw1IjmekBOjmfDWJAVceG
         Cyrsx+aLggjPbTAXBiLWioOCbbr6PuLFnYgcgKDsAlyfQNE6iqtJp5qN2AOKrLrwsMxp
         K6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffDoSnr6w6wMo6QiA5YtZqMGcMHa1Zygb80YtCAF6gA=;
        b=P8dKTSxYNNPOMA0qSjzQGM5dxg7al5bGOFCVb2XDsN9TTDpNvqBqS8bxS4+WfMfNlR
         1B7gWSrW0CgrCpcJgIh8KCE1YnnAJYFpWT4qqXwqwyeUvnHdTRr+fPdTB/ouTeKvS+yL
         BsRnVbxRl+X+16Q4ugrGKiIIjG+0xg0bQHrW9bK0yfDhzP1ClxBpP5vMBELhi3O5q5HF
         lfvU1aRpNV0HH3m4zCUCyI3EdqikFYmk8164e2FnbpTOmwVNxzhdSJ4MniENqo9qyEki
         CIc5cZV2zorUojIjWBS4hy32OHx9ZbWpjsbyD6V+s1SFW8Wo3MeKegoC826U86bdZAa9
         zl6g==
X-Gm-Message-State: AOAM5300LM1VLsrxw7JsIlyrwaaSnCFoOOB2mGe8Ug/pi1+RAUzAp9Lp
        ba5B/9hL6tuPvGWfuUfWJcC2NrLpESqKHw==
X-Google-Smtp-Source: ABdhPJybUMw0r/+PFitqll5OXvDz/rzvkjFJC4kU03jJ71WStda0jSVcby1DXXW7+zSJnLWASMhRfQ==
X-Received: by 2002:a05:6a00:c:b029:18b:eae3:bff0 with SMTP id h12-20020a056a00000cb029018beae3bff0mr11489539pfk.9.1604997583723;
        Tue, 10 Nov 2020 00:39:43 -0800 (PST)
Received: from localhost.localdomain ([42.108.200.159])
        by smtp.gmail.com with ESMTPSA id i10sm13230988pfd.60.2020.11.10.00.39.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 00:39:43 -0800 (PST)
From:   Sangeeta Jain <sangunb09@gmail.com>
To:     git@vger.kernel.org
Cc:     Sangeeta Jain <sangunb09@gmail.com>, phillip.wood123@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com,
        sunshine@sunshineco.com
Subject: [Outreachy][PATCH v7] diff: do not show submodule with untracked files as "-dirty"
Date:   Tue, 10 Nov 2020 14:09:00 +0530
Message-Id: <20201110083900.88161-1-sangunb09@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git diff reports a submodule directory as -dirty even when there are
only untracked files in the submodule directory. This is inconsistent
with what `git describe --dirty` says when run in the submodule
directory in that state.

Make `--ignore-submodules=untracked` the default for `git diff` when
there is no configuration variable or command line option, so that the
command would not give '-dirty' suffix to a submodule whose working
tree has untracked files, to make it consistent with `git
describe --dirty` that is run in the submodule working tree.

And also make `--ignore-submodules=none` the default for `git status`
so that the user doesn't end up deleting a submodule that has
uncommitted (untracked) files.

Signed-off-by: Sangeeta Jain <sangunb09@gmail.com>
---
 Documentation/config/diff.txt                |  2 ++
 diff.c                                       |  3 +++
 diff.h                                       |  1 +
 submodule.c                                  |  1 +
 t/t3701-add-interactive.sh                   |  6 ++++++
 t/t4027-diff-submodule.sh                    | 12 ++++++++++--
 t/t4041-diff-submodule-option.sh             | 16 ++++++++--------
 t/t4060-diff-submodule-option-diff-format.sh | 16 ++++++++--------
 wt-status.c                                  |  4 +++-
 9 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index c3ae136eba..2d3331f55c 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -85,6 +85,8 @@ diff.ignoreSubmodules::
 	and 'git status' when `status.submoduleSummary` is set unless it is
 	overridden by using the --ignore-submodules command-line option.
 	The 'git submodule' commands are not affected by this setting.
+	By default this is set to untracked so that any untracked
+	submodules are ignored.
 
 diff.mnemonicPrefix::
 	If set, 'git diff' uses a prefix pair that is different from the
diff --git a/diff.c b/diff.c
index 2bb2f8f57e..5a80695da8 100644
--- a/diff.c
+++ b/diff.c
@@ -4585,6 +4585,9 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
+	
+	if (!options->flags.ignore_submodule_set)
+		options->flags.ignore_untracked_in_submodules = 1;
 
 	if (diff_no_prefix) {
 		options->a_prefix = options->b_prefix = "";
diff --git a/diff.h b/diff.h
index 11de52e9e9..1e18e6b1c3 100644
--- a/diff.h
+++ b/diff.h
@@ -178,6 +178,7 @@ struct diff_flags {
 	unsigned diff_from_contents;
 	unsigned dirty_submodules;
 	unsigned ignore_untracked_in_submodules;
+	unsigned ignore_submodule_set;
 	unsigned ignore_dirty_submodules;
 	unsigned override_submodule_config;
 	unsigned dirstat_by_line;
diff --git a/submodule.c b/submodule.c
index b3bb59f066..8f6227c993 100644
--- a/submodule.c
+++ b/submodule.c
@@ -420,6 +420,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
+	diffopt->flags.ignore_submodule_set = 1;
 	diffopt->flags.ignore_submodules = 0;
 	diffopt->flags.ignore_untracked_in_submodules = 0;
 	diffopt->flags.ignore_dirty_submodules = 0;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ca04fac417..9a2489cde0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -765,6 +765,12 @@ test_expect_success 'setup different kinds of dirty submodules' '
 	cat >expected <<-\EOF &&
 	dirty-both-ways
 	dirty-head
+	EOF
+	test_cmp expected actual &&
+	git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
+	cat >expected <<-\EOF &&
+	dirty-both-ways
+	dirty-head
 	dirty-otherwise
 	EOF
 	test_cmp expected actual &&
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index d7145ccca4..894a11b224 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -93,6 +93,14 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
 	) &&
 	git diff HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (untracked) (none ignored)' '
+	test_config diff.ignoreSubmodules none &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subtip $subprev-dirty &&
 	test_cmp expect.body actual.body
 '
@@ -168,13 +176,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 		git clean -qfdx &&
 		>cruft
 	) &&
-	git diff HEAD >actual &&
+	git diff --ignore-submodules=none HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules=all HEAD >actual2 &&
 	test_must_be_empty actual2 &&
-	git diff --ignore-submodules=untracked HEAD >actual3 &&
+	git diff HEAD >actual3 &&
 	test_must_be_empty actual3 &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
 	test_must_be_empty actual4
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index f852136585..b3a7b7acaa 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -262,7 +262,7 @@ test_expect_success 'submodule is up to date' '
 
 test_expect_success 'submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	EOF
@@ -270,7 +270,7 @@ test_expect_success 'submodule contains untracked content' '
 '
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	test_must_be_empty actual
 '
 
@@ -286,7 +286,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
 
 test_expect_success 'submodule contains untracked and modified content' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -296,7 +296,7 @@ test_expect_success 'submodule contains untracked and modified content' '
 
 test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	EOF
@@ -337,7 +337,7 @@ test_expect_success 'submodule is modified' '
 
 test_expect_success 'modified submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p  --ignore-submodules=none --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 $head6..$head8:
@@ -347,7 +347,7 @@ test_expect_success 'modified submodule contains untracked content' '
 '
 
 test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head6..$head8:
 	  > change
@@ -371,7 +371,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
 
 test_expect_success 'modified submodule contains untracked and modified content' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -383,7 +383,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
 
 test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	Submodule sm1 $head6..$head8:
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index fc8229c726..dc7b242697 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -409,7 +409,7 @@ test_expect_success 'submodule is up to date' '
 
 test_expect_success 'submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	EOF
@@ -417,7 +417,7 @@ test_expect_success 'submodule contains untracked content' '
 '
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	test_must_be_empty actual
 '
 
@@ -433,7 +433,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
 
 test_expect_success 'submodule contains untracked and modified content' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -451,7 +451,7 @@ test_expect_success 'submodule contains untracked and modified content' '
 # NOT OK
 test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	diff --git a/sm1/foo6 b/sm1/foo6
@@ -512,7 +512,7 @@ test_expect_success 'submodule is modified' '
 
 test_expect_success 'modified submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 $head7..$head8:
@@ -528,7 +528,7 @@ test_expect_success 'modified submodule contains untracked content' '
 '
 
 test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
@@ -564,7 +564,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
 
 test_expect_success 'modified submodule contains untracked and modified content' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -583,7 +583,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
 
 test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	Submodule sm1 $head7..$head8:
diff --git a/wt-status.c b/wt-status.c
index 7074bbdd53..83d418647d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -606,7 +606,9 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	if (s->ignore_submodule_arg) {
 		rev.diffopt.flags.override_submodule_config = 1;
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
-	}
+	} else if (!rev.diffopt.flags.ignore_submodule_set && 
+			s->show_untracked_files != SHOW_NO_UNTRACKED_FILES)
+		handle_ignore_submodules_arg(&rev.diffopt, "none");
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
-- 
2.21.1 (Apple Git-122.3)

