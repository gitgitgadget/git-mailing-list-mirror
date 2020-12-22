Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5992BC433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F34222B2D
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLVAF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgLVAF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:05:57 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F31EC0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:45 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id eb4so9335666qvb.21
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DKmsIxc4f89WV+IsjEfUFNY3Ih4tONMREdtf+PB9Zak=;
        b=YIjK/KiGbJ4rxfawWEne0Rm6+qxvEQe9Jdv8UqOjoo5wNp11QbRObMcIuLHct5OaCI
         kuxfcPFjuaXNbFYxo+rzAWQZorsJuI3j4TdEYvBumvwyntJBcnXHLtISuCPKIWxoEhZI
         muttuHsLt+efTv48gQUi0XcTaE9omZ7FO+a0SXMmviJ6n3LMqcRmQjnXAsewq1x5cHem
         dBn7Ri3zZtEyUGTv/L3XTcN57qykdXY0LiQc5Ki/SG/sF+aKqy4yW367ez7C3k/V+RdC
         YBoBOaJMfFO4RNWwWQm/ZvSqYtBtYXEtr2e85oFRBvXpoEPuWgXv6KzkPfHE7o4l+TiD
         WDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DKmsIxc4f89WV+IsjEfUFNY3Ih4tONMREdtf+PB9Zak=;
        b=nNxzRBSebUy4xzRUz51BMsEuPKIYuKvqcGfby6SGt79EdMTBjdZIBIgsZf5p8liK2N
         cu2ikuuOU2OCa8uVF0Ato7+s4pcfCdF4tvGjXIy01I+0vUKXb8Ji3Kf02JjB/Zj46QZC
         rRlBsmWy5D74UPsrrAk4+wo+mS7T6aXI1XWINzP48icetIN5QXROdyzcqrIjJxVRdwLu
         z/Yj+V8hvfOHOswHLoI2sA8XnSC+AqPWutgi3aQHsT9jh2K9z/gctGqoIxegLMZPKPZ7
         C6zjb2hhNMvzQi5kgQ1kY1kwFnPkkeT/frDi6gbBc/7i7g5L9uqNdPFHPA8Hbvr23Un6
         RNiw==
X-Gm-Message-State: AOAM531DaphPEequO2X+fUWrgQ/CNFqregJ1G2OO+KVNUpQcXuxZw/5f
        +weuFl48O5QxCrfIExNAM0G7cchP3zHipaVQU82C3y66Izr0zAG+V5CLXewvd4OTA3QQqPysybO
        aubSOb6Lr8riwcXXX0Izv7HpRlurZ4JKCvLMb3E68gi1xmkV5M0nv2dRqncV1nPKKhl2UPm40Ow
        ==
X-Google-Smtp-Source: ABdhPJzGdelXVshnN7jyKP2KNq0osbQcelbGqAylfvq7XQcOkg63FsmYJWoiZ9oqmSUfjPyMS0sCK/nDjat/veCgBR0=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:4e4d:: with SMTP id
 eb13mr19292228qvb.6.1608595484765; Mon, 21 Dec 2020 16:04:44 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:19 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 01/17] commit: use config-based hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the adoption of config-based hooks, teach run_commit_hook()
to call hook.h instead of run-command.h. This covers 'pre-commit',
'commit-msg', and 'prepare-commit-msg'. Additionally, ask the hook
library - not run-command - whether any hooks will be run, as it's
possible hooks may exist in the config but not the hookdir.

Because all but 'post-commit' hooks are expected to make some state
change, force all but 'post-commit' hook to run in series. 'post-commit'
"is meant primarily for notification, and cannot affect the outcome of
`git commit`," so it is fine to run in parallel.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt                    | 10 ++++++++++
 builtin/commit.c                              | 11 +++++-----
 builtin/merge.c                               |  9 +++++----
 commit.c                                      | 20 +++++++++++++------
 commit.h                                      |  3 ++-
 sequencer.c                                   |  7 ++++---
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 17 ++++++++++++++--
 7 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ffccfc7760..8b352be43f 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -103,6 +103,8 @@ The default 'pre-commit' hook, when enabled--and with the
 `hooks.allownonascii` config option unset or set to false--prevents
 the use of non-ASCII filenames.
 
+Hooks executed during 'pre-commit' will not be parallelized.
+
 pre-merge-commit
 ~~~~~~~~~~~~~~~~
 
@@ -125,6 +127,8 @@ need to be resolved and the result committed separately (see
 linkgit:git-merge[1]). At that point, this hook will not be executed,
 but the 'pre-commit' hook will, if it is enabled.
 
+Hooks executed during 'pre-merge-commit' will not be parallelized.
+
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
 
@@ -150,6 +154,8 @@ be used as replacement for pre-commit hook.
 The sample `prepare-commit-msg` hook that comes with Git removes the
 help message found in the commented portion of the commit template.
 
+Hooks executed during 'prepare-commit-msg' will not be parallelized.
+
 commit-msg
 ~~~~~~~~~~
 
@@ -166,6 +172,8 @@ file.
 The default 'commit-msg' hook, when enabled, detects duplicate
 `Signed-off-by` trailers, and aborts the commit if one is found.
 
+Hooks executed during 'commit-msg' will not be parallelized.
+
 post-commit
 ~~~~~~~~~~~
 
@@ -175,6 +183,8 @@ invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git commit`.
 
+Hooks executed during 'post-commit' will run in parallel by default.
+
 pre-rebase
 ~~~~~~~~~~
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..f4dea2b510 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -36,6 +36,7 @@
 #include "help.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "hook.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -699,7 +700,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (!no_verify && run_commit_hook(use_editor, 0, index_file, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -983,7 +984,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit", configured_hookdir_opt())) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
@@ -998,7 +999,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+	if (run_commit_hook(use_editor, 0, index_file, "prepare-commit-msg",
 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
 
@@ -1015,7 +1016,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, 0, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
 
@@ -1701,7 +1702,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, 1, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 1cff730715..d654b6923c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -42,6 +42,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "hook.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -836,14 +837,14 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
+	if (!no_verify && run_commit_hook(0 < option_edit, 0, index_file, "pre-merge-commit", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (find_hook("pre-merge-commit"))
+	if (hook_exists("pre-merge-commit", configured_hookdir_opt()))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
@@ -864,7 +865,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
-	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
+	if (run_commit_hook(0 < option_edit, 0, get_index_file(), "prepare-commit-msg",
 			    git_path_merge_msg(the_repository), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
@@ -872,7 +873,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
+	if (!no_verify && run_commit_hook(0 < option_edit, 0, get_index_file(),
 					  "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
diff --git a/commit.c b/commit.c
index fe1fa3dc41..1bad721a20 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1630,25 +1631,32 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 	return boc ? len - boc : len - cutoff;
 }
 
-int run_commit_hook(int editor_is_used, const char *index_file,
+int run_commit_hook(int editor_is_used, int parallelize, const char *index_file,
 		    const char *name, ...)
 {
-	struct strvec hook_env = STRVEC_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
 	va_list args;
+	const char *arg;
 	int ret;
 
-	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	if (parallelize)
+		opt.jobs = configured_hook_jobs();
+
+	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		strvec_push(&hook_env, "GIT_EDITOR=:");
+		strvec_push(&opt.env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	while ((arg = va_arg(args, const char *)))
+		strvec_push(&opt.args, arg);
 	va_end(args);
-	strvec_clear(&hook_env);
+
+	ret = run_hooks(name, &opt);
+	run_hooks_opt_clear(&opt);
 
 	return ret;
 }
diff --git a/commit.h b/commit.h
index 5467786c7b..dd33ead8e0 100644
--- a/commit.h
+++ b/commit.h
@@ -352,6 +352,7 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
 LAST_ARG_MUST_BE_NULL
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+int run_commit_hook(int editor_is_used, int parallelize, const char *index_file,
+		    const char *name, ...);
 
 #endif /* COMMIT_H */
diff --git a/sequencer.c b/sequencer.c
index 8909a46770..5a98fd2fbc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -34,6 +34,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -1203,7 +1204,7 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 	} else {
 		arg1 = "message";
 	}
-	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
+	if (run_commit_hook(0, 0, r->index_file, "prepare-commit-msg", name,
 			    arg1, arg2, NULL))
 		ret = error(_("'prepare-commit-msg' hook failed"));
 
@@ -1438,7 +1439,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	if (hook_exists("prepare-commit-msg", configured_hookdir_opt())) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
@@ -1528,7 +1529,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	run_commit_hook(0, r->index_file, "post-commit", NULL);
+	run_commit_hook(0, 1, r->index_file, "post-commit", NULL);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
 
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index b3485450a2..fc93bc3d23 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -5,8 +5,8 @@ test_description='pre-commit and pre-merge-commit hooks'
 . ./test-lib.sh
 
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
-PRECOMMIT="$HOOKDIR/pre-commit"
-PREMERGE="$HOOKDIR/pre-merge-commit"
+PRECOMMIT="$(pwd)/$HOOKDIR/pre-commit"
+PREMERGE="$(pwd)/$HOOKDIR/pre-merge-commit"
 
 # Prepare sample scripts that write their $0 to actual_hooks
 test_expect_success 'sample script setup' '
@@ -103,6 +103,19 @@ test_expect_success 'with succeeding hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+# NEEDSWORK: when 'git hook add' and 'git hook remove' have been added, use that
+# instead
+test_expect_success 'with succeeding hook (config-based)' '
+	test_when_finished "git config --unset hook.pre-commit.command success.sample" &&
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	git config hook.pre-commit.command "$HOOKDIR/success.sample" &&
+	echo "$HOOKDIR/success.sample" >expected_hooks &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -m "more" &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success 'with succeeding hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
-- 
2.28.0.rc0.142.g3c755180ce-goog

