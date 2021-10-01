Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8C7C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78D561A50
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353294AbhJAKGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353273AbhJAKGw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3FC06177C
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a131-20020a1c7f89000000b0030d4c90fa87so1133393wmd.2
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k735m5bUirZ81cg5ccSckBHzq8i4raMoX1EA9nTqePs=;
        b=HwnWGsth7Ms1M/kkXuUDGXRjd2cJ9Cu3y3B93lvhk3o3tMmPqURMMmLQHhb5gc9Cbm
         53XW4mqEzIi6baE/UbKVnuwCuuKzjLMe5Q7wd2xGeDbVJtGUHwYhvb+PsA5RaHmQBOyc
         53y9GPOMt4zAlBwABJ/JjHJmoIGMSXrlvljXUCIpJcaVJAgn1T6RmQdctKHBayC2bWBl
         lNtqC98czLkSIcbCfDX8d/sAAtG5XesHLeDTTc4opIQTricNvKszqhxGFwrVQHKo1j8B
         gPS7WgM156IWPT34D8dEIDMnPESM8kbweuME3qNNeRQtBDWTvjxbM6WMcXT2dDnNxm8s
         FvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k735m5bUirZ81cg5ccSckBHzq8i4raMoX1EA9nTqePs=;
        b=wz0sJ7gLSMXCKxCcgH8FMWgB3a2E9Zh7y0cbYrMEcQ65FhtGJt04D9yvpX1NxsLp3o
         /1syvvonscCvdvLOif7cEeIdXJFM+M4AEJYPIaCD6hTAG7oPutL1Oip/kHPF7z+0buas
         CNAOjX7NAFj2WQQcNVxxk9Y4yS7WM3Jh0UwjWYiwaQOfBiMoXHs2uf9/B4IcyQYEQ7vg
         Cf8Mganj3/qQ3fuDvRr+00xRzPF5GuikBvNcomeZzCxb/GpqzVVWPtBskD8BkLdiF1y3
         ZMDH3bpGt9xvaxVGzgnD4pRRfEqWn3Bdm0Z+f6HjjgJEef7IcrD48guXxQDMyrzkwffy
         HyBg==
X-Gm-Message-State: AOAM532S++OzS/p2mchy+xSUbiVw9M6KqRK2yoveS4CKUNw0wTRjd68F
        +WjyEI2RyZqFiM/0Ha8BJ+cV+n38qtQ=
X-Google-Smtp-Source: ABdhPJxt732mAveeurzJKf2N9ipano5ueJBZZWMYR9fNwFZbnF2hcxkEB1x8dK5RTzrShFBIcEKvCg==
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr3501055wmr.99.1633082706732;
        Fri, 01 Oct 2021 03:05:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm6457341wrg.18.2021.10.01.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:06 -0700 (PDT)
Message-Id: <fbaf64d6b282730f91b16ea7d5844fb0e8d779da.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:04:55 +0000
Subject: [PATCH 04/11] reset_head(): remove action parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The action parameter is passed as the command name to
setup_unpack_trees_porcelain(). All but two cases pass either
"checkout" or "reset". The case that passes "reset --hard" should be
passing "reset" instead. The case that passes "Fast-forwarded" is only
updating HEAD and so does not call unpack_trees(). The value can be
determined by checking whether flags contains RESET_HEAD_HARD so it
does not need to be specified by the caller.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 14 +++++++-------
 reset.c          |  5 +++--
 reset.h          |  2 +-
 sequencer.c      |  3 +--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f4c312dd8b5..26f53c55cc4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -789,7 +789,7 @@ static int move_to_original_branch(struct rebase_options *opts)
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
 	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
 		    opts->head_name);
-	ret = reset_head(the_repository, NULL, "", opts->head_name,
+	ret = reset_head(the_repository, NULL, opts->head_name,
 			 RESET_HEAD_REFS_ONLY,
 			 orig_head_reflog.buf, head_reflog.buf,
 			 DEFAULT_REFLOG_ACTION);
@@ -880,7 +880,7 @@ static int run_am(struct rebase_options *opts)
 		free(rebased_patches);
 		strvec_clear(&am.args);
 
-		reset_head(the_repository, &opts->orig_head, "checkout",
+		reset_head(the_repository, &opts->orig_head,
 			   opts->head_name, 0,
 			   "HEAD", NULL, DEFAULT_REFLOG_ACTION);
 		error(_("\ngit encountered an error while preparing the "
@@ -1107,7 +1107,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 	strbuf_addf(&buf, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    options->switch_to);
-	if (reset_head(the_repository, &options->orig_head, "checkout",
+	if (reset_head(the_repository, &options->orig_head,
 		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, buf.buf, DEFAULT_REFLOG_ACTION) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
@@ -1557,7 +1557,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
-		if (reset_head(the_repository, NULL, "reset", NULL, RESET_HEAD_HARD,
+		if (reset_head(the_repository, NULL, NULL, RESET_HEAD_HARD,
 			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
@@ -1575,7 +1575,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (read_basic_state(&options))
 			exit(1);
-		if (reset_head(the_repository, &options.orig_head, "reset",
+		if (reset_head(the_repository, &options.orig_head,
 			       options.head_name, RESET_HEAD_HARD,
 			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
 			die(_("could not move back to %s"),
@@ -2064,7 +2064,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
-	if (reset_head(the_repository, &options.onto->object.oid, "checkout", NULL,
+	if (reset_head(the_repository, &options.onto->object.oid, NULL,
 		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, msg.buf, DEFAULT_REFLOG_ACTION))
@@ -2082,7 +2082,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
-		reset_head(the_repository, NULL, "Fast-forwarded", options.head_name,
+		reset_head(the_repository, NULL, options.head_name,
 			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
 			   DEFAULT_REFLOG_ACTION);
 		strbuf_release(&msg);
diff --git a/reset.c b/reset.c
index 5abb1a5683e..9ab007c0c34 100644
--- a/reset.c
+++ b/reset.c
@@ -8,7 +8,7 @@
 #include "tree.h"
 #include "unpack-trees.h"
 
-int reset_head(struct repository *r, struct object_id *oid, const char *action,
+int reset_head(struct repository *r, struct object_id *oid,
 	       const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action)
@@ -23,7 +23,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
-	const char *reflog_action;
+	const char *action, *reflog_action;
 	struct strbuf msg = STRBUF_INIT;
 	size_t prefix_len;
 	struct object_id *orig = NULL, oid_orig,
@@ -49,6 +49,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	if (refs_only)
 		goto reset_head_refs;
 
+	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
 	unpack_tree_opts.src_index = r->index;
diff --git a/reset.h b/reset.h
index 12f83c78e28..2daec804259 100644
--- a/reset.h
+++ b/reset.h
@@ -12,7 +12,7 @@
 #define RESET_HEAD_REFS_ONLY (1<<3)
 #define RESET_ORIG_HEAD (1<<4)
 
-int reset_head(struct repository *r, struct object_id *oid, const char *action,
+int reset_head(struct repository *r, struct object_id *oid,
 	       const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action);
diff --git a/sequencer.c b/sequencer.c
index 68316636921..07d2a582d39 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4130,8 +4130,7 @@ void create_autostash(struct repository *r, const char *path,
 			    path);
 		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
-		if (reset_head(r, NULL, "reset --hard",
-			       NULL, RESET_HEAD_HARD, NULL, NULL,
+		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
 			       default_reflog_action) < 0)
 			die(_("could not reset --hard"));
 
-- 
gitgitgadget

