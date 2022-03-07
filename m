Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BA0C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbiCGMfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242534AbiCGMfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:35:11 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5972988B2D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:33:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l10so5239450wmb.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbi1o9KRmfGRzQireNWSIpCxDZfo7nn8Qy7CNKOvD8A=;
        b=TuHreUwkd0NoyBDDuQesakn8h1QF/czRCNt0ZsGV3ArR/NgPxaUJluTFrU3YxfP9wu
         doQMREM+IKvGmhCjr5wDKYRgD+nBrLbtG3RKBRKONayt7i7WXItICPReGB3eppkjIIEO
         LUO93kfZESrM9N64UpHyn6A8Kxh44wThrlvfudkKR9/eV/w3WDpvAzbis+5hjoSLE23s
         2ZTUQoX+jT8X9gce8vH80ljlUQ83CDBE6G9ZsuRvnTB12nFDPNekoIUAbSx/83w/Ab8A
         fxFmKQHqKYQa0IZ4CUXlaHuAhRlGZQ1/c+TZgIUbvxBGIf1V6umrMFZO3xLFG8daI51L
         P6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbi1o9KRmfGRzQireNWSIpCxDZfo7nn8Qy7CNKOvD8A=;
        b=4BKMLEpQevjp/OOzMKIBm5sw2cSdZjTFdK1zfhTgMnMBDxWY855TspaT0KuGUuiKCq
         GA+1olJYs1nCq3K8K6hRXOP+dNccEvzshcGvvpY2PEC0NMT/wNA7Lc13gDkbQfb0joOK
         Tnmn8aT8/mbUmzrJFF/RaskPQ01BRQ97W5L9CCe02pm512ZDtkdoKzAdFA+3pPSQ+dWy
         9r5VESILxUx62KyaMgIfiBXxnvV8sK9iyePVYTTey0VM1VhW8cGDjkMP/oS3W2/S0neW
         etMTM19qTTMqeYFlj57PHAgn5ER37Az53iKxmSYgbcmNBfEO4WeAdXfNdfFQvkIpGmkd
         pJtg==
X-Gm-Message-State: AOAM532TDOpLg7jfjJ3QLGitXqXfnFUwwGFwCrR0vQFujwvmnRSW0UPk
        AvUfjWMlyh0k6S/K+80Acp9LYJiT6T814w==
X-Google-Smtp-Source: ABdhPJwjSZ0YS8DAqoZRbyY01u/XADj8VhCpUoFm5wVLvzJrHWcz0ciMyJ7aqpZx533XeivPd+X5kg==
X-Received: by 2002:a05:600c:a45:b0:346:5e67:cd54 with SMTP id c5-20020a05600c0a4500b003465e67cd54mr17838138wmq.127.1646656431218;
        Mon, 07 Mar 2022 04:33:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00380e45cd564sm13657012wmq.8.2022.03.07.04.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:33:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] hooks: fix an obscure TOCTOU "did we just run a hook?" race
Date:   Mon,  7 Mar 2022 13:33:46 +0100
Message-Id: <patch-v2-2.2-9d16984898c-20220307T123244Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-0.2-00000000000-20220307T123244Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20220307T123244Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a Time-of-check to time-of-use (TOCTOU) race in code added in
680ee550d72 (commit: skip discarding the index if there is no
pre-commit hook, 2017-08-14).

This obscure race condition can occur if we e.g. ran the "pre-commit"
hook and it modified the index, but hook_exists() returns false later
on (e.g., because the hook itself went away, the directory became
unreadable, etc.). Then we won't call discard_cache() when we should
have.

The race condition itself probably doesn't matter, and users would
have been unlikely to run into it in practice. This problem has been
noted on-list when 680ee550d72 was discussed[1], but had not been
fixed.

This change is mainly intended to improve the readability of the code
involved, and to make reasoning about it more straightforward. It
wasn't as obvious what we were trying to do here, but by having an
"invoked_hook" it's clearer that e.g. our discard_cache() is happening
because of the earlier hook execution.

Let's also change this for the push-to-checkout hook. Now instead of
checking if the hook exists and either doing a push to checkout or a
push to deploy we'll always attempt a push to checkout. If the hook
doesn't exist we'll fall back on push to deploy. The same behavior as
before, without the TOCTOU race. See 0855331941b (receive-pack:
support push-to-checkout hook, 2014-12-01) for the introduction of the
previous behavior.

This leaves uses of hook_exists() in two places that matter. The
"reference-transaction" check in refs.c, see 67541597670 (refs:
implement reference transaction hook, 2020-06-19), and the
"prepare-commit-msg" hook, see 66618a50f9c (sequencer: run
'prepare-commit-msg' hook, 2018-01-24).

In both of those cases we're saving ourselves CPU time by not
preparing data for the hook that we'll then do nothing with if we
don't have the hook. So using this "invoked_hook" pattern doesn't make
sense in those cases.

The "reference-transaction" and "prepare-commit-msg" hook also aren't
racy. In those cases we'll skip the hook runs if we race with a new
hook being added, whereas in the TOCTOU races being fixed here we were
incorrectly skipping the required post-hook logic.

1. https://lore.kernel.org/git/20170810191613.kpmhzg4seyxy3cpq@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c       | 18 +++++++++++-------
 builtin/merge.c        | 11 +++++++----
 builtin/receive-pack.c |  8 +++++---
 commit.c               |  2 +-
 commit.h               |  3 ++-
 hook.c                 |  7 +++++++
 hook.h                 | 12 ++++++++++++
 sequencer.c            |  4 ++--
 8 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8b8bdad3959..009a1de0a3d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -726,11 +726,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
 	int merge_contains_scissors = 0;
+	int invoked_hook;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (!no_verify && run_commit_hook(use_editor, index_file, &invoked_hook,
+					  "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -1053,10 +1055,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && hook_exists("pre-commit")) {
+	if (!no_verify && invoked_hook) {
 		/*
-		 * Re-read the index as pre-commit hook could have updated it,
-		 * and write it out as a tree.  We must do this before we invoke
+		 * Re-read the index as the pre-commit-commit hook was invoked
+		 * and could have updated it. We must do this before we invoke
 		 * the editor and after we invoke run_status above.
 		 */
 		discard_cache();
@@ -1068,7 +1070,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+	if (run_commit_hook(use_editor, index_file, NULL, "prepare-commit-msg",
 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
 
@@ -1085,7 +1087,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, index_file, NULL, "commit-msg",
+			    git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
 
@@ -1841,7 +1844,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, get_index_file(), NULL, "post-commit",
+			NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index b26b4c45157..f178f5a3ee1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -846,7 +846,9 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	const char *index_file = get_index_file();
 
 	if (!no_verify) {
-		if (run_commit_hook(0 < option_edit, index_file,
+		int invoked_hook;
+
+		if (run_commit_hook(0 < option_edit, index_file, &invoked_hook,
 				    "pre-merge-commit", NULL))
 			abort_commit(remoteheads, NULL);
 		/*
@@ -854,7 +856,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		 * and write it out as a tree.  We must do this before we invoke
 		 * the editor and after we invoke run_status above.
 		 */
-		if (hook_exists("pre-merge-commit"))
+		if (invoked_hook)
 			discard_cache();
 	}
 	read_cache_from(index_file);
@@ -878,7 +880,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
-	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
+	if (run_commit_hook(0 < option_edit, get_index_file(), NULL,
+			    "prepare-commit-msg",
 			    git_path_merge_msg(the_repository), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
@@ -887,7 +890,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	}
 
 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
-					  "commit-msg",
+					  NULL, "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d10aeb7e78f..d4db5776694 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1408,10 +1408,12 @@ static const char *push_to_deploy(unsigned char *sha1,
 static const char *push_to_checkout_hook = "push-to-checkout";
 
 static const char *push_to_checkout(unsigned char *hash,
+				    int *invoked_hook,
 				    struct strvec *env,
 				    const char *work_tree)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	opt.invoked_hook = invoked_hook;
 
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
 	strvec_pushv(&opt.env, env->v);
@@ -1426,6 +1428,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 {
 	const char *retval, *git_dir;
 	struct strvec env = STRVEC_INIT;
+	int invoked_hook;
 
 	if (!worktree || !worktree->path)
 		BUG("worktree->path must be non-NULL");
@@ -1436,10 +1439,9 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!hook_exists(push_to_checkout_hook))
+	retval = push_to_checkout(sha1, &invoked_hook, &env, worktree->path);
+	if (!invoked_hook)
 		retval = push_to_deploy(sha1, &env, worktree->path);
-	else
-		retval = push_to_checkout(sha1, &env, worktree->path);
 
 	strvec_clear(&env);
 	return retval;
diff --git a/commit.c b/commit.c
index d400f5dfa2b..396e14d7b32 100644
--- a/commit.c
+++ b/commit.c
@@ -1713,7 +1713,7 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 }
 
 int run_commit_hook(int editor_is_used, const char *index_file,
-		    const char *name, ...)
+		    int *invoked_hook, const char *name, ...)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	va_list args;
diff --git a/commit.h b/commit.h
index 38cc5426615..3b174135bcf 100644
--- a/commit.h
+++ b/commit.h
@@ -369,7 +369,8 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
 LAST_ARG_MUST_BE_NULL
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+int run_commit_hook(int editor_is_used, const char *index_file,
+		    int *invoked_hook, const char *name, ...);
 
 /* Sign a commit or tag buffer, storing the result in a header. */
 int sign_with_header(struct strbuf *buf, const char *keyid);
diff --git a/hook.c b/hook.c
index 69a215b2c3c..1d51be3b77a 100644
--- a/hook.c
+++ b/hook.c
@@ -96,9 +96,13 @@ static int notify_hook_finished(int result,
 				void *pp_task_cb)
 {
 	struct hook_cb_data *hook_cb = pp_cb;
+	struct run_hooks_opt *opt = hook_cb->options;
 
 	hook_cb->rc |= result;
 
+	if (opt->invoked_hook)
+		*opt->invoked_hook = 1;
+
 	return 0;
 }
 
@@ -123,6 +127,9 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->invoked_hook)
+		*options->invoked_hook = 0;
+
 	if (!hook_path && !options->error_if_missing)
 		goto cleanup;
 
diff --git a/hook.h b/hook.h
index 18d90aedf14..4258b13da0d 100644
--- a/hook.h
+++ b/hook.h
@@ -18,6 +18,18 @@ struct run_hooks_opt
 	 * translates to "struct child_process"'s "dir" member.
 	 */
 	const char *dir;
+
+	/**
+	 * A pointer which if provided will be set to 1 or 0 depending
+	 * on if a hook was started, regardless of whether or not that
+	 * was successful. I.e. if the underlying start_command() was
+	 * successful this will be set to 1.
+	 *
+	 * Used for avoiding TOCTOU races in code that would otherwise
+	 * call hook_exist() after a "maybe hook run" to see if a hook
+	 * was invoked.
+	 */
+	int *invoked_hook;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/sequencer.c b/sequencer.c
index 35006c0cea6..84eed9e96bc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1220,7 +1220,7 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 	} else {
 		arg1 = "message";
 	}
-	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
+	if (run_commit_hook(0, r->index_file, NULL, "prepare-commit-msg", name,
 			    arg1, arg2, NULL))
 		ret = error(_("'prepare-commit-msg' hook failed"));
 
@@ -1552,7 +1552,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	run_commit_hook(0, r->index_file, "post-commit", NULL);
+	run_commit_hook(0, r->index_file, NULL, "post-commit", NULL);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
 
-- 
2.35.1.1242.gfeba0eae32b

