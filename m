Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA86DC47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A46613CD
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhE0ALc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhE0ALJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:09 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A5C061345
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:34 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id n12-20020a0c8c0c0000b02901edb8963d4dso2546467qvb.18
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uO0yNrmc7QwXPsixtRLiwPhdxFgoz9yKm6nIA0ICH0g=;
        b=YIIU60K3MiHV0BqEZgfGySsih3YTrvPnS4NolQHWt48U5pIxhaXdiuaz4BgFYoCgnJ
         LjQBEs8rjarQDJFqVt6RWgfb+wpf/HLSHWOY/CZG1+7g1AFzf1954zG37dmYxBnKiFhI
         fDYcClhrWBsVNoO/5KBYUcEvSKoTFe3hm4o2N/S7vq3HvSCY80mpv/gYAp2dD6vZ0phO
         bRRZoJOlH9wsJrfqOMwuHquFlXihvnGU8IqW5MEeX8zfC+aOKOJ9aKcPvr8HKm3rBUbi
         iL/ooAFRgaRqiLDSq43omenTtCX1sia67SEZcmWcwjKLYJwuRaT3MHgbP+5rbJKTpVpd
         i/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uO0yNrmc7QwXPsixtRLiwPhdxFgoz9yKm6nIA0ICH0g=;
        b=P+YMuxMyVcgtXv2PGF5HNR4JdOntRAHULM8nBiXWyhy5N+Dj++Ht5G8USE5WtY38gq
         iSK2rw5r1XmyfCJE+jKee8+vQgo9KRuEFbnWCnWIzXpH6R1QpfkiZgzeAF45FljUi6o2
         giCKcNmQpW5qobBuI0hrJH7+QW46C8PYYCnu33Rrjlkgjcf3Y0NCvekbPyZXBeXmL3v9
         kuHtxgnzahra2DKdXEivuGxZQYlFybki8GIghgWx7CzdcwDm8yh5zMQh+FTYpeU0QvOS
         VEyLSSk9B9TYyni9AmsO4SuxSs1RK0MDKAGwpfPr3KesZFpV8JM9jkiQP0lriJNwMRjZ
         wE9g==
X-Gm-Message-State: AOAM5321hHHoaGAAoE4dFy+iTDe/yX645DCnnL1PKtLtNN38XoVwhusy
        RYskx6FVPYH6YdmWVBTf1XIEzXcYOxc1IORwoPkiSrH8uT6gz8dTpzdpUivoXeMvz9njnfybx1g
        NuFMtTG9s6V3RQhTLmzMzPgUb5adliJJNFJ00m8M4oITZ5pPZ2zhU7YqgLSUKwexL2W5acLYEtw
        ==
X-Google-Smtp-Source: ABdhPJyDI+xqAA7ik4mekh5GtfeO+1eqV2NiDB9Hb/rLEsmROYAb7/EcQ78BmvM23ieu4p8Hu6pabfTaAWPynXtgXWY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:d80f:: with SMTP id
 h15mr808415qvj.17.1622074174067; Wed, 26 May 2021 17:09:34 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:36 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-18-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 17/37] commit: use config-based hooks
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
 Documentation/githooks.txt                    | 13 +++++++++++
 builtin/commit.c                              | 11 +++++-----
 builtin/merge.c                               |  9 ++++----
 commit.c                                      | 22 ++++++++++++++-----
 commit.h                                      |  3 ++-
 sequencer.c                                   |  7 +++---
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 17 ++++++++++++--
 7 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b51959ff94..4af202b366 100644
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
 
@@ -150,6 +154,9 @@ be used as replacement for pre-commit hook.
 The sample `prepare-commit-msg` hook that comes with Git removes the
 help message found in the commented portion of the commit template.
 
+Hooks executed during 'prepare-commit-msg' will not be parallelized, because
+hooks are expected to edit the file containing the commit log message.
+
 commit-msg
 ~~~~~~~~~~
 
@@ -166,6 +173,9 @@ file.
 The default 'commit-msg' hook, when enabled, detects duplicate
 `Signed-off-by` trailers, and aborts the commit if one is found.
 
+Hooks executed during 'commit-msg' will not be parallelized, because hooks are
+expected to edit the file containing the proposed commit log message.
+
 post-commit
 ~~~~~~~~~~~
 
@@ -175,6 +185,9 @@ invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git commit`.
 
+Hooks executed during 'post-commit' will run in parallel, unless hook.jobs is
+configured to 1.
+
 pre-rebase
 ~~~~~~~~~~
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43..7e01802961 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -36,6 +36,7 @@
 #include "help.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "hook.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -728,7 +729,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (!no_verify && run_commit_hook(use_editor, 0, index_file, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -1044,7 +1045,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit", HOOKDIR_USE_CONFIG)) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
@@ -1059,7 +1060,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+	if (run_commit_hook(use_editor, 0, index_file, "prepare-commit-msg",
 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
 
@@ -1076,7 +1077,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, 0, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
 
@@ -1829,7 +1830,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, 1, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index eddb8ae70d..182dea418a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -43,6 +43,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "hook.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -841,14 +842,14 @@ static void prepare_to_commit(struct commit_list *remoteheads)
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
+	if (hook_exists("pre-merge-commit", HOOKDIR_USE_CONFIG))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
@@ -869,7 +870,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
-	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
+	if (run_commit_hook(0 < option_edit, 0, get_index_file(), "prepare-commit-msg",
 			    git_path_merge_msg(the_repository), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
@@ -877,7 +878,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
+	if (!no_verify && run_commit_hook(0 < option_edit, 0, get_index_file(),
 					  "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
diff --git a/commit.c b/commit.c
index 8ea55a447f..0da5b7e7f1 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1695,25 +1696,34 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 	return boc ? len - boc : len - cutoff;
 }
 
-int run_commit_hook(int editor_is_used, const char *index_file,
+int run_commit_hook(int editor_is_used, int parallelize, const char *index_file,
 		    const char *name, ...)
 {
-	struct strvec hook_env = STRVEC_INIT;
+	struct run_hooks_opt opt;
 	va_list args;
+	const char *arg;
 	int ret;
 
-	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	run_hooks_opt_init_sync(&opt);
+
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
index df42eb434f..a90c094ec2 100644
--- a/commit.h
+++ b/commit.h
@@ -363,7 +363,8 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
 LAST_ARG_MUST_BE_NULL
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+int run_commit_hook(int editor_is_used, int parallelize, const char *index_file,
+		    const char *name, ...);
 
 /* Sign a commit or tag buffer, storing the result in a header. */
 int sign_with_header(struct strbuf *buf, const char *keyid);
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38..72234af8ed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -34,6 +34,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -1207,7 +1208,7 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 	} else {
 		arg1 = "message";
 	}
-	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
+	if (run_commit_hook(0, 0, r->index_file, "prepare-commit-msg", name,
 			    arg1, arg2, NULL))
 		ret = error(_("'prepare-commit-msg' hook failed"));
 
@@ -1445,7 +1446,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	if (hook_exists("prepare-commit-msg", HOOKDIR_USE_CONFIG)) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
@@ -1537,7 +1538,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	run_commit_hook(0, r->index_file, "post-commit", NULL);
+	run_commit_hook(0, 1, r->index_file, "post-commit", NULL);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
 
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index 606d8d0f08..e9e3713033 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -8,8 +8,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
-PRECOMMIT="$HOOKDIR/pre-commit"
-PREMERGE="$HOOKDIR/pre-merge-commit"
+PRECOMMIT="$(pwd)/$HOOKDIR/pre-commit"
+PREMERGE="$(pwd)/$HOOKDIR/pre-merge-commit"
 
 # Prepare sample scripts that write their $0 to actual_hooks
 test_expect_success 'sample script setup' '
@@ -106,6 +106,19 @@ test_expect_success 'with succeeding hook' '
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
2.31.1.818.g46aad6cb9e-goog

