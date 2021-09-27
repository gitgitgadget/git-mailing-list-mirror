Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374AFC43217
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDCD60EE2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhI0Qft (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhI0Qfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556BFC06176D
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a131so1027497wmd.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LlVQbrKENKAU+AkK6zfNEUhLWVCPj3o/f0XLF00ZEb0=;
        b=Fk5eyvY9Rxwn7nfG0jkZlQTYJ371GLP8rbzqXzL4ia+dq1kHn0MTWhYS5QZ/aJa9N2
         f9/uKjtbjW+4IsIx4JjCQxE6KW7SjbXnIHoGCMIk8uA7QsKB9T7HlQ2T+z1AJKi/GXQr
         iZ7PmVXZ9D5dQOruet9+WqwTwkb8TgzD2Dubpo7lQtw+AdxM8MPLCcNHUeHcu87JWTT4
         VNEU2TYNCxSWOTam+1lifFT/M1qODAA7CAhUnlWiMYbVXrkfDPLLlXt2OFDzzUatFIf/
         a0DgaxM/pjDzkL24cfAm8h3s1gXrJyRqWV8+cytFyxkHI0a0uNfBwi4dp4w6aURMUnLR
         4XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LlVQbrKENKAU+AkK6zfNEUhLWVCPj3o/f0XLF00ZEb0=;
        b=PKE3rblvwnFYCDrl1hDqnASDay9wa4Y31yQ2FG+w4c79JBet0i48gZKA3LKApqR9Xw
         TOCLwdcU5tKB797Iw30aDkNlF0AZCDNrvSfMGvokA8weebZNB4BHFpcJ1PZnqLtLom/6
         lBRzNLz5wr+nfS3q/01oLiXyFO5ZqUTJxO+gj4cL9XmskZc5bT8eN/grpnNI8ayzuzYx
         VoAnkmk3vssGPtmibRsJRVfI9MBC2ggqOqxR6WbJG9Me5SNp0wRxmhUPe4+d2w03OY+c
         tJA3Kf023Uf50zykL17ct6CXfQsHb/s+crNml74QaOh08BWGP4Z7l8EJidIf/a+sjcJm
         EG4g==
X-Gm-Message-State: AOAM5338ABOqGas/QRUl6S8wAPUkROoqxNSkXduZLTbOkOS4fsBpqRGO
        J+Jm+YeLGvrXTbD/Y5s7cQHBjbMbpcw=
X-Google-Smtp-Source: ABdhPJwBvTK+hRpWF5bmoSMPH88G/980rdrCUmw4Vj9eHgHUvqKxKDJr+vkFV4koEeyxlCJRoI+CRw==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr851517wmj.160.1632760432918;
        Mon, 27 Sep 2021 09:33:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm17902898wra.52.2021.09.27.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:52 -0700 (PDT)
Message-Id: <b7fe354effff8da3de53bd9cc40a03b5fd455f67.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:43 +0000
Subject: [PATCH v3 06/11] Remove ignored files by default when they are in the
 way
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Change several commands to remove ignored files by default when they are
in the way.  Since some commands (checkout, merge) take a
--no-overwrite-ignore option to allow the user to configure this, and it
may make sense to add that option to more commands (and in the case of
merge, actually plumb that configuration option through to more of the
backends than just the fast-forwarding special case), add little
comments about where such flags would be used.

Incidentally, this fixes a test failure in t7112.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c               | 3 +--
 builtin/clone.c            | 3 +--
 builtin/merge.c            | 3 +--
 builtin/reset.c            | 3 +--
 builtin/stash.c            | 3 +--
 merge-ort.c                | 2 +-
 reset.c                    | 3 +--
 sequencer.c                | 3 +--
 t/t7112-reset-submodule.sh | 1 -
 9 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1ee70692bc3..57738eff0c5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1919,8 +1919,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.merge = 1;
 	opts.reset = reset;
 	if (!reset)
-		/* FIXME: Default should be to remove ignored files */
-		opts.preserve_ignored = 1;
+		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = twoway_merge;
 	init_tree_desc(&t[0], head->buffer, head->size);
 	init_tree_desc(&t[1], remote->buffer, remote->size);
diff --git a/builtin/clone.c b/builtin/clone.c
index be1c3840d62..11ec6c5f2c8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -687,8 +687,7 @@ static int checkout(int submodule_progress)
 	opts.update = 1;
 	opts.merge = 1;
 	opts.clone = 1;
-	/* FIXME: Default should be to remove ignored files */
-	opts.preserve_ignored = 1;
+	opts.preserve_ignored = 0;
 	opts.fn = oneway_merge;
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
diff --git a/builtin/merge.c b/builtin/merge.c
index 1e5fff095fc..0ccd5e1ac83 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -680,8 +680,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	opts.verbose_update = 1;
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
-	/* FIXME: Default should be to remove ignored files */
-	opts.preserve_ignored = 1;
+	opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	trees[nr_trees] = parse_tree_indirect(common);
 	if (!trees[nr_trees++])
 		return -1;
diff --git a/builtin/reset.c b/builtin/reset.c
index 7f38656f018..5df01cc42e0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -67,8 +67,7 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	case KEEP:
 	case MERGE:
 		opts.update = 1;
-		/* FIXME: Default should be to remove ignored files */
-		opts.preserve_ignored = 1;
+		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 		break;
 	case HARD:
 		opts.update = 1;
diff --git a/builtin/stash.c b/builtin/stash.c
index 88287b890d5..d60cdaf32f5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -259,8 +259,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.reset = reset;
 	opts.update = update;
 	if (update && !reset)
-		/* FIXME: Default should be to remove ignored files */
-		opts.preserve_ignored = 1;
+		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts))
diff --git a/merge-ort.c b/merge-ort.c
index 0d64ec716bd..04596b5e7b3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4045,7 +4045,7 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.quiet = 0; /* FIXME: sequencer might want quiet? */
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
-	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore*/
+	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
 	parse_tree(prev);
 	init_tree_desc(&trees[0], prev->buffer, prev->size);
 	parse_tree(next);
diff --git a/reset.c b/reset.c
index 41b3e2d88de..f40a8ecf663 100644
--- a/reset.c
+++ b/reset.c
@@ -56,8 +56,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
-	/* FIXME: Default should be to remove ignored files */
-	unpack_tree_opts.preserve_ignored = 1;
+	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
 	if (!detach_head)
 		unpack_tree_opts.reset = 1;
diff --git a/sequencer.c b/sequencer.c
index 098566c68d9..6872b7b00a4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3699,8 +3699,7 @@ static int do_reset(struct repository *r,
 	unpack_tree_opts.fn = oneway_merge;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
-	/* FIXME: Default should be to remove ignored files */
-	unpack_tree_opts.preserve_ignored = 1;
+	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index 19830d90365..a3e2413bc33 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -6,7 +6,6 @@ test_description='reset can handle submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
-KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
 test_submodule_switch_recursing_with_args "reset --keep"
 
-- 
gitgitgadget

