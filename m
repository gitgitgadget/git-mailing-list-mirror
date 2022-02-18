Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E946C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiBRUoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:44:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiBRUoV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:44:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1B483B5
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:44:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h6so16417563wrb.9
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0SvmAx4ZKrdtYDLfWpyQeuQ7IntQZSPUgbMnbVFNiE=;
        b=bzaPWoEhlORmfCzYj/9nSBjzG8bcAeUnGNNbWMwGZwwCX9q0KHblN14WC7Q/ASQc0W
         uy6r9aTkr7tHIFOZ8Bft4F1TrXZVaPF+Z9moAMhi73YBLGB/1+VQXuTUEbmaUv1tTa9E
         2dcpw7UeN2F7775mO+GSbpRsrDYD6tl+zzDGUcmBrNT1AANYV6n+Impn8O2gD/p3YP73
         vYmfbuY2+tMSlYXQ9K3st167zsKudrYT6k7VoSNFjqTgL8yb/YzifJCerUfNBE7qbJo5
         cau/QD4z3NoHG8eVEdnbNxGb7s8MPYBwZ95qT5m/ctj5MWDqselEyNyI8hri86ii0QBr
         NC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0SvmAx4ZKrdtYDLfWpyQeuQ7IntQZSPUgbMnbVFNiE=;
        b=4OqomYnfUa4hFfVnk+k8JHXHc/3Gy3dAJqXLPUTXRpWMxZaZ3E9UaiZB1EFdOBUxfN
         XkTw95L8ku0yK6fOrMxwfCf1YwfF1s9nBJK0yJu9cdwbxuQPlcDlTj9N3jk4HFuBhJRT
         hJSr8neOtZeaXG3TPJNxtnaG4VCyjPDBoF1RkHnPynAcVpbg/TfyNx+0QrXNXVrt4SYD
         hJrYBHM0FYbEEtw/IRWG9R1xzxaejm82ppU/ypUwx7uNWuDswdE+lo7s++QNiyJTd6pB
         +SrSrilZ+akQSRXGSRu2FOJORU5OQZf/SzXQfdXSNmLJSAAQIveKQvCmDxq98N1oc6ju
         zLBQ==
X-Gm-Message-State: AOAM531jxZ7OdKGCBAEUKXUb2hWB2orgKqEvA4K0hjoCxckxEwZc1qTK
        tiwqFo+ik8vuEazaH7qhFrV2qTbSs1dDew==
X-Google-Smtp-Source: ABdhPJzPiAqJdp37SA2eQlAoOB5FV5Rryeiou6J8jCXutT9zEV334xDoDnTvZuSud+3jEsNtS/jY8w==
X-Received: by 2002:adf:b645:0:b0:1e3:bab:7594 with SMTP id i5-20020adfb645000000b001e30bab7594mr7226661wre.346.1645217041945;
        Fri, 18 Feb 2022 12:44:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c14sm4680239wru.37.2022.02.18.12.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:44:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] hooks: fix a TOCTOU in "did we run a hook?" heuristic
Date:   Fri, 18 Feb 2022 21:43:52 +0100
Message-Id: <patch-2.2-d01d088073b-20220218T203834Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1031.g277d4562d2e
In-Reply-To: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a Time-of-check to time-of-use (TOCTOU) race in code added in
680ee550d72 (commit: skip discarding the index if there is no
pre-commit hook, 2017-08-14).

We can fix the race passing around information about whether or not we
ran the hook in question, instead of running hook_exists() after the
fact to check if the hook in question exists. This problem has been
noted on-list when 680ee550d72 was discussed[1], but had not been
fixed.

In addition to fixing this for the pre-commit hook as suggested there
I'm also fixing this for the pre-merge-commit hook. See
6098817fd7f (git-merge: honor pre-merge-commit hook, 2019-08-07) for
the introduction of its previous behavior.

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
prepare-commit-msg hook, see 66618a50f9c (sequencer: run
'prepare-commit-msg' hook, 2018-01-24).

In both of those cases we're saving ourselves CPU time by not
preparing data for the hook that we'll then do nothing with if we
don't have the hook. So using this "invoked_hook" pattern doesn't make
sense in those cases.

More importantly, in those cases the worst we'll do is miss that we
"should" run the hook because a new hook appeared, whereas in the
pre-commit and pre-merge-commit cases we'll skip an important
discard_cache() on the bases of our faulty guess.

I do think none of these races really matter in practice. It would be
some one-off issue as a hook was added or removed. I did think it was
stupid that we didn't pass a "did this run?" flag instead of doing
this guessing at a distance though, so now we're not guessing anymore.

1. https://lore.kernel.org/git/20170810191613.kpmhzg4seyxy3cpq@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c       | 18 +++++++++++-------
 builtin/merge.c        | 11 +++++++----
 builtin/receive-pack.c |  8 +++++---
 commit.c               |  2 +-
 commit.h               |  3 ++-
 hook.c                 |  7 +++++++
 hook.h                 |  9 +++++++++
 sequencer.c            |  4 ++--
 8 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b9ed0374e30..bc5d34bc31f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -725,11 +725,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -1052,10 +1054,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -1067,7 +1069,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+	if (run_commit_hook(use_editor, index_file, NULL, "prepare-commit-msg",
 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
 
@@ -1084,7 +1086,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, index_file, NULL, "commit-msg",
+			    git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
 
@@ -1845,7 +1848,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, get_index_file(), NULL, "post-commit",
+			NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index fab553e3bc4..4b2eab88b0d 100644
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
index c427ca09aaf..75595c7af38 100644
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
index 18d90aedf14..735a7d97002 100644
--- a/hook.h
+++ b/hook.h
@@ -18,6 +18,15 @@ struct run_hooks_opt
 	 * translates to "struct child_process"'s "dir" member.
 	 */
 	const char *dir;
+
+	/**
+	 * A pointer which if provided will be set to 1 or 0 depending
+	 * on if a hook was invoked (i.e. existed), regardless of
+	 * whether or not that was successful. Used for avoiding
+	 * TOCTOU races in code that would otherwise call hook_exist()
+	 * after a "maybe hook run" to see if a hook was invoked.
+	 */
+	int *invoked_hook;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/sequencer.c b/sequencer.c
index fb978a53a0f..967bf054709 100644
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
2.35.1.1031.g277d4562d2e

