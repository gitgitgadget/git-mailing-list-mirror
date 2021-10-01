Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0416C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4106134F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353354AbhJAKG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353289AbhJAKGy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E44C0613E2
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u18so14617507wrg.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0nlpRJOEtdCL+KzTLQluG+wbpMPJe/FBhyqKzosYL80=;
        b=otZkR36Gn0dlIcmwhuX511LxomoLJzdCdHChtR+iO8CeXXwyvY6L3t3Hp4xrEbrcFR
         pI5P41wKMSYBELvltcBMjImZ5ab1kXDb+DKnOPTzc2IrXAWsonngBd9jqIj+pdTsgg72
         g0zzKzSO3IsVJyV9qzRn6EKbplZd8UoTPuW0o0rUwrA0biMtVbpujyTFvQ1svQ1GXmyB
         4DodejiL29M79Q/Lf1he3u+1k/E0nfhD31Kjtbeg8HVKMJD8dg3rz6g4V2DierzYQjE7
         WhpCUr3i242uLye+MG+57c3LzldQQJpOOBU4JKKWNLzxtg9ZYxseob/QbyDTVhGKS7DN
         AnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0nlpRJOEtdCL+KzTLQluG+wbpMPJe/FBhyqKzosYL80=;
        b=NK5n9YP6dFznQm2k1f9mBYep5SP/490L6hwBpvUQvRXfQXLsxUihmojhkGGyWGlO+m
         rEg9dFl4bc7oytwHup0w3YbjVZESUZ/rC7POI982wV+u/kuoE98ciB2+rC60vdAOBAyq
         QKPdaRaYsmVmBYqBRo1rchqvx0GP8WN6r5LHD0T6q0AflBlaqLyepmRlQv5nudNsQGRk
         +0Eh3vUwDEofRXeTVK7zP/0sPMx9cbyWi/H2mloreVleG+ITjVlBcvwMcIMjKCxQ9QKl
         1uVCFnXNHX1eiNmT0oXKosDcV7FNi3sdtYN0w+ra+HrpYPfsenDDPBWSttv84XT2CM9a
         ADhg==
X-Gm-Message-State: AOAM533yfyubLzb9tao9/YmLRL+FNrE8IYiPTcpowXNl89zjVeiMv5sK
        yG4yXuu3iBuWnFqznExaOPqzz2XyyY8=
X-Google-Smtp-Source: ABdhPJxGLmLejxD8FLe6o3qEe4Wj99tt2MJuiGUAYhMNAw4n8LUEEgbXVKAZTXmqmJiMtN6wUCf9iA==
X-Received: by 2002:adf:a3c7:: with SMTP id m7mr11208277wrb.339.1633082708083;
        Fri, 01 Oct 2021 03:05:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm5156114wmi.42.2021.10.01.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:07 -0700 (PDT)
Message-Id: <4503defe5912aecc4e6a50ac82a31aa7b230456b.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:04:57 +0000
Subject: [PATCH 06/11] reset_head(): make default_reflog_action optional
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

This parameter is only needed when a ref is going to be updated and
the caller does not pass an explicit reflog message. Callers that are
just discarding changes in the working tree like create_autostash() do
not update any refs so should not have to worry about passing this
parameter.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/merge.c  |  6 ++----
 builtin/rebase.c | 14 ++++++--------
 reset.c          | 16 ++++++++++++----
 sequencer.c      |  6 +++---
 sequencer.h      |  3 +--
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d2c52b6e971..35833a963fc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1561,8 +1561,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		if (autostash)
 			create_autostash(the_repository,
-					 git_path_merge_autostash(the_repository),
-					 "merge");
+					 git_path_merge_autostash(the_repository));
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
@@ -1632,8 +1631,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (autostash)
 		create_autostash(the_repository,
-				 git_path_merge_autostash(the_repository),
-				 "merge");
+				 git_path_merge_autostash(the_repository));
 
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 26f53c55cc4..1a6af508f49 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -791,8 +791,7 @@ static int move_to_original_branch(struct rebase_options *opts)
 		    opts->head_name);
 	ret = reset_head(the_repository, NULL, opts->head_name,
 			 RESET_HEAD_REFS_ONLY,
-			 orig_head_reflog.buf, head_reflog.buf,
-			 DEFAULT_REFLOG_ACTION);
+			 orig_head_reflog.buf, head_reflog.buf, NULL);
 
 	strbuf_release(&orig_head_reflog);
 	strbuf_release(&head_reflog);
@@ -1109,7 +1108,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 		    options->switch_to);
 	if (reset_head(the_repository, &options->orig_head,
 		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-		       NULL, buf.buf, DEFAULT_REFLOG_ACTION) < 0)
+		       NULL, buf.buf, NULL) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
 	strbuf_release(&buf);
 
@@ -1558,7 +1557,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		string_list_clear(&merge_rr, 1);
 
 		if (reset_head(the_repository, NULL, NULL, RESET_HEAD_HARD,
-			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
+			       NULL, NULL, NULL) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
 		if (read_basic_state(&options))
@@ -1964,8 +1963,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("could not read index"));
 
 	if (options.autostash) {
-		create_autostash(the_repository, state_dir_path("autostash", &options),
-				 DEFAULT_REFLOG_ACTION);
+		create_autostash(the_repository,
+				 state_dir_path("autostash", &options));
 	}
 
 	if (require_clean_work_tree(the_repository, "rebase",
@@ -2083,8 +2082,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
 		reset_head(the_repository, NULL, options.head_name,
-			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
-			   DEFAULT_REFLOG_ACTION);
+			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf, NULL);
 		strbuf_release(&msg);
 		ret = finish_rebase(&options);
 		goto cleanup;
diff --git a/reset.c b/reset.c
index 668c7639127..be4e18eed98 100644
--- a/reset.c
+++ b/reset.c
@@ -21,8 +21,13 @@ static int update_refs(const struct object_id *oid, const char *switch_to_branch
 	size_t prefix_len;
 	int ret;
 
-	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
+	if ((update_orig_head && !reflog_orig_head) || !reflog_head) {
+		if (!default_reflog_action)
+			BUG("default_reflog_action must be given when reflog messages are omitted");
+		reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+		strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action :
+							  default_reflog_action);
+	}
 	prefix_len = msg.len;
 
 	if (update_orig_head) {
@@ -71,6 +76,7 @@ int reset_head(struct repository *r, struct object_id *oid,
 {
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
 	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
+	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -141,8 +147,10 @@ int reset_head(struct repository *r, struct object_id *oid,
 		goto leave_reset_head;
 	}
 
-	ret = update_refs(oid, switch_to_branch, reflog_head, reflog_orig_head,
-			  default_reflog_action, flags);
+	if (oid != &head_oid || update_orig_head || switch_to_branch)
+		ret = update_refs(oid, switch_to_branch, reflog_head,
+				  reflog_orig_head, default_reflog_action,
+				  flags);
 
 leave_reset_head:
 	rollback_lock_file(&lock);
diff --git a/sequencer.c b/sequencer.c
index 07d2a582d39..56a204f18c5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4093,8 +4093,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-void create_autostash(struct repository *r, const char *path,
-		      const char *default_reflog_action)
+void create_autostash(struct repository *r, const char *path)
+
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4131,7 +4131,7 @@ void create_autostash(struct repository *r, const char *path,
 		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
-			       default_reflog_action) < 0)
+			       NULL) < 0)
 			die(_("could not reset --hard"));
 
 		if (discard_index(r->index) < 0 ||
diff --git a/sequencer.h b/sequencer.h
index 2088344cb37..92357536ff4 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -198,8 +198,7 @@ void commit_post_rewrite(struct repository *r,
 			 const struct commit *current_head,
 			 const struct object_id *new_head);
 
-void create_autostash(struct repository *r, const char *path,
-		      const char *default_reflog_action);
+void create_autostash(struct repository *r, const char *path);
 int save_autostash(const char *path);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
-- 
gitgitgadget

