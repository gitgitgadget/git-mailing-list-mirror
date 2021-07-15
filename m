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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC62CC636CA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC229613DA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhGOX3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhGOX3I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:08 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583E3C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:13 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k63-20020a37a1420000b02903b4fb67f606so4993961qke.10
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L7NcHwymbQGKVXLQYFClcnEJT/ChRmZ3SYV/JAQ6MGw=;
        b=Utjp0h0JLcD4QOp1OBrfhrM9B4mR7e43zPZ7WHYGguPgznp2xzvOcEgbWttRJ0UaBS
         OAmdOTBQxn83nKG67WEV89N+7Q/FF2SqFc8loIsyQNwFucIimXzVoQZnYksIytiULCLT
         JJNMCDoPBjY9X3o1wB11fxsmKgezuU4a9TqJ/1JMn1LyElNWsuwxN5HRyImOJEw0uM6x
         6kO3oOjLl+HxKyb0U8HXWeTe4FDUqavFbtZBX3878zt5JQmXfnwfvX4a+P7ToxKQA1ih
         hJOHAV1D6iObtiCVGpk1jCsFUbziDpZkgAqWkh72dmAyJQEkRm7H1oLAHABIKKY3TZ2C
         nC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L7NcHwymbQGKVXLQYFClcnEJT/ChRmZ3SYV/JAQ6MGw=;
        b=DakDpvkZ0Ne7dMyKk+zb9qqzigqbp854UmIm6pqGmgFTQIgyINVsbrV2/u7SsCKAgW
         FhmGpyNogMzd98TadEpCTxB4WwL6kXRWGhb1sHYgRfazD6svgFC83gJyUkdNCkrGV3dW
         pVFlfn/dpGw8PoQf8sKC2YqBecu0hMe1f1SOS5xU2trGfFqZwqBpm7JD0gPh3DsbIqt+
         I2xvaEMlTkjricXY/X1NzHbCK54fhQ+aJimhDbFbnqJNm6dO9XX/prp2xaXkHnUcbnBP
         kJPzAQ+y8ALNt0yFnTeoos106VgbfZ3/YFzAqgenlxuXFLraZUe1aGNOQKNvyHP00v+y
         LSKg==
X-Gm-Message-State: AOAM5337Ab8fCrAFJJEkxshM/Z1j78CTLGbYFdXxzoKfiylPQuUtuUHu
        bxjcup2zM4hQv1iPRBhPWRb8VrHhI1W7s08O9Kt0sAOTkmFwAHcqDA/1ZXb8RamuVBeBariq21/
        YiX0qA8Xr5EzhVHLXK7kwNZu35yoizUnIxsLhxq1/7yw9VuaYLvx897+wiWIQsvzsWSvfztNsOA
        ==
X-Google-Smtp-Source: ABdhPJx7/sLbztXly105Q37W1PLZzuWKInZBaBqODS6cVXesL/HA23NRssLxuxYbdhCy0fL/w4kwltAz16gzyXBFtTA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:47a8:: with SMTP id
 a8mr7033367qvz.53.1626391572468; Thu, 15 Jul 2021 16:26:12 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:25:56 -0700
In-Reply-To: <20210715232603.3415111-1-emilyshaffer@google.com>
Message-Id: <20210715232603.3415111-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 2/9] hook: allow parallel hook execution
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many cases, there's no reason not to allow hooks to execute in
parallel. run_processes_parallel() is well-suited - it's a task queue
that runs its housekeeping in series, which means users don't
need to worry about thread safety on their callback data. True
multithreaded execution with the async_* functions isn't necessary here.
Synchronous hook execution can be achieved by only allowing 1 job to run
at a time.

Teach run_hooks() to use that function for simple hooks which don't
require stdin or capture of stderr.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/hook.txt |  4 ++++
 Documentation/git-hook.txt    | 17 ++++++++++++++++-
 builtin/am.c                  | 12 ++++++++----
 builtin/checkout.c            |  3 ++-
 builtin/clone.c               |  3 ++-
 builtin/gc.c                  |  3 ++-
 builtin/hook.c                |  6 +++++-
 builtin/merge.c               |  3 ++-
 builtin/rebase.c              |  3 ++-
 builtin/receive-pack.c        | 14 ++++++++++----
 builtin/worktree.c            |  3 ++-
 commit.c                      |  4 +++-
 hook.c                        | 32 +++++++++++++++++++++++++++++---
 hook.h                        | 11 +++++------
 read-cache.c                  |  3 ++-
 refs.c                        |  3 ++-
 reset.c                       |  4 +++-
 sequencer.c                   |  7 +++++--
 transport.c                   |  4 +++-
 19 files changed, 107 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/config/hook.txt

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
new file mode 100644
index 0000000000..96d3d6572c
--- /dev/null
+++ b/Documentation/config/hook.txt
@@ -0,0 +1,4 @@
+hook.jobs::
+	Specifies how many hooks can be run simultaneously during parallelized
+	hook execution. If unspecified, defaults to the number of processors on
+	the current system.
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index fa68c1f391..8bf82b5dd4 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,7 +8,8 @@ git-hook - run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--to-stdin=<path>] [--ignore-missing] <hook-name> [-- <hook-args>]
+'git hook' run [--to-stdin=<path>] [--ignore-missing] [(-j|--jobs) <n>]
+	<hook-name> [-- <hook-args>]
 
 DESCRIPTION
 -----------
@@ -42,6 +43,20 @@ OPTIONS
 	tools that want to do a blind one-shot run of a hook that may
 	or may not be present.
 
+-j::
+--jobs::
+	Only valid for `run`.
++
+Specify how many hooks to run simultaneously. If this flag is not specified, use
+the value of the `hook.jobs` config. If the config is not specified, use the
+number of CPUs on the current system. Some hooks may be ineligible for
+parallelization: for example, 'commit-msg' intends hooks modify the commit
+message body and cannot be parallelized.
+
+CONFIGURATION
+-------------
+include::config/hook.txt[]
+
 SEE ALSO
 --------
 linkgit:githooks[5]
diff --git a/builtin/am.c b/builtin/am.c
index 6e4f9c8036..bdad38142a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -445,8 +445,9 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 
+	run_hooks_opt_init_sync(&opt);
 	assert(state->msg);
 	strvec_push(&opt.args, am_path(state, "final-commit"));
 	ret = run_hooks("applypatch-msg", &opt);
@@ -467,9 +468,10 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	int ret;
 
+	run_hooks_opt_init_async(&opt);
 	strvec_push(&opt.args, "rebase");
 	opt.path_to_stdin = am_path(state, "rewritten");
 
@@ -1602,9 +1604,10 @@ static void do_commit(const struct am_state *state)
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
-	struct run_hooks_opt hook_opt_pre = RUN_HOOKS_OPT_INIT;
-	struct run_hooks_opt hook_opt_post = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt_pre;
+	struct run_hooks_opt hook_opt_post;
 
+	run_hooks_opt_init_async(&hook_opt_pre);
 	if (run_hooks("pre-applypatch", &hook_opt_pre)) {
 		run_hooks_opt_clear(&hook_opt_pre);
 		exit(1);
@@ -1659,6 +1662,7 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
+	run_hooks_opt_init_async(&hook_opt_post);
 	run_hooks("post-applypatch", &hook_opt_post);
 
 	run_hooks_opt_clear(&hook_opt_pre);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6205ace09f..be4450a433 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -107,9 +107,10 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	int rc;
 
+	run_hooks_opt_init_sync(&opt);
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
 	strvec_pushl(&opt.args,
diff --git a/builtin/clone.c b/builtin/clone.c
index de57a3119b..87cfbf60e5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -776,7 +776,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
-	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt;
 
 	if (option_no_checkout)
 		return 0;
@@ -822,6 +822,7 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
+	run_hooks_opt_init_sync(&hook_opt);
 	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid), "1", NULL);
 	err |= run_hooks("post-checkout", &hook_opt);
 	run_hooks_opt_clear(&hook_opt);
diff --git a/builtin/gc.c b/builtin/gc.c
index a12641a691..16890b097c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -349,7 +349,7 @@ static void add_repack_incremental_option(void)
 
 static int need_to_gc(void)
 {
-	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt;
 
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
@@ -397,6 +397,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
+	run_hooks_opt_init_async(&hook_opt);
 	if (run_hooks("pre-auto-gc", &hook_opt)) {
 		run_hooks_opt_clear(&hook_opt);
 		return 0;
diff --git a/builtin/hook.c b/builtin/hook.c
index a41ff36da9..d196d8498c 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -21,7 +21,7 @@ static const char * const builtin_hook_run_usage[] = {
 static int run(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	int rc = 0;
 	int ignore_missing = 0;
 	const char *hook_name;
@@ -32,9 +32,13 @@ static int run(int argc, const char **argv, const char *prefix)
 			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_INTEGER('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
 
+	run_hooks_opt_init_async(&opt);
+
 	argc = parse_options(argc, argv, prefix, run_options,
 			     builtin_hook_run_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
diff --git a/builtin/merge.c b/builtin/merge.c
index 0425c9bf2b..67c2eba053 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,7 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
@@ -490,6 +490,7 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
+	run_hooks_opt_init_async(&opt);
 	strvec_push(&opt.args, squash ? "1" : "0");
 	run_hooks("post-merge", &opt);
 	run_hooks_opt_clear(&opt);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2081f6fa8d..fe9f144cad 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1314,7 +1314,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
-	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -2024,6 +2024,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* If a hook exists, give it a chance to interrupt*/
+	run_hooks_opt_init_async(&hook_opt);
 	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
 	if (!ok_to_skip_pre_rebase &&
 	    run_hooks("pre-rebase", &hook_opt)) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cd658f41d5..e4726eb211 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -910,7 +910,7 @@ static int run_receive_hook(struct command *commands,
 			    int skip_broken,
 			    const struct string_list *push_options)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	struct receive_hook_feed_context ctx;
 	int rc;
 	struct command *iter = commands;
@@ -922,6 +922,7 @@ static int run_receive_hook(struct command *commands,
 		return 0;
 
 	/* pre-receive hooks should run in series as the hook updates refs */
+	run_hooks_opt_init_async(&opt);
 	if (!strcmp(hook_name, "pre-receive"))
 		opt.jobs = 1;
 
@@ -956,9 +957,10 @@ static int run_receive_hook(struct command *commands,
 
 static int run_update_hook(struct command *cmd)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	int code;
 
+	run_hooks_opt_init_async(&opt);
 	strvec_pushl(&opt.args,
 		     cmd->ref_name,
 		     oid_to_hex(&cmd->old_oid),
@@ -1443,7 +1445,10 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
+
+
+	run_hooks_opt_init_sync(&opt);
 	opt.invoked_hook = invoked_hook;
 
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
@@ -1642,8 +1647,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 
+	run_hooks_opt_init_async(&opt);
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2ad26a76f4..5a2c9d1039 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,8 +382,9 @@ static int add_worktree(const char *path, const char *refname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout) {
-		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt;
 
+		run_hooks_opt_init_sync(&opt);
 		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
 		strvec_pushl(&opt.args,
 			     oid_to_hex(null_oid()),
diff --git a/commit.c b/commit.c
index cf62ebceae..58ee2c81bb 100644
--- a/commit.c
+++ b/commit.c
@@ -1700,10 +1700,12 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook,
 		    const char *name, ...)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	va_list args;
 	const char *arg;
 	int ret;
+
+	run_hooks_opt_init_sync(&opt);
 	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
diff --git a/hook.c b/hook.c
index c1dac6982f..935751fa6c 100644
--- a/hook.c
+++ b/hook.c
@@ -88,6 +88,14 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
 
+int configured_hook_jobs(void)
+{
+	int n = online_cpus();
+	git_config_get_int("hook.jobs", &n);
+
+	return n;
+}
+
 int hook_exists(const char *name)
 {
 	return !!find_hook(name);
@@ -117,6 +125,26 @@ struct list_head* hook_list(const char* hookname)
 	return hook_head;
 }
 
+void run_hooks_opt_init_sync(struct run_hooks_opt *o)
+{
+	strvec_init(&o->env);
+	strvec_init(&o->args);
+	o->path_to_stdin = NULL;
+	o->jobs = 1;
+	o->dir = NULL;
+	o->feed_pipe = NULL;
+	o->feed_pipe_ctx = NULL;
+	o->consume_sideband = NULL;
+	o->invoked_hook = NULL;
+	o->absolute_path = 0;
+}
+
+void run_hooks_opt_init_async(struct run_hooks_opt *o)
+{
+	run_hooks_opt_init_sync(o);
+	o->jobs = configured_hook_jobs();
+}
+
 void run_hooks_opt_clear(struct run_hooks_opt *o)
 {
 	strvec_clear(&o->env);
@@ -238,11 +266,9 @@ int run_found_hooks(const char *hook_name, struct list_head *hooks,
 		.invoked_hook = options->invoked_hook,
 	};
 
+	cb_data.head = hooks;
 	cb_data.run_me = list_first_entry(hooks, struct hook, list);
 
-	if (options->jobs != 1)
-		BUG("we do not handle %d or any other != 1 job number yet", options->jobs);
-
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
diff --git a/hook.h b/hook.h
index b97237931b..586ddf40bb 100644
--- a/hook.h
+++ b/hook.h
@@ -35,6 +35,9 @@ struct hook {
  */
 struct list_head* hook_list(const char *hookname);
 
+/* Provides the number of threads to use for parallel hook execution. */
+int configured_hook_jobs(void);
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -93,12 +96,6 @@ struct run_hooks_opt
 	int *invoked_hook;
 };
 
-#define RUN_HOOKS_OPT_INIT { \
-	.jobs = 1, \
-	.env = STRVEC_INIT, \
-	.args = STRVEC_INIT, \
-}
-
 /*
  * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
  * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list()'.
@@ -117,6 +114,8 @@ struct hook_cb_data {
 	int *invoked_hook;
 };
 
+void run_hooks_opt_init_sync(struct run_hooks_opt *o);
+void run_hooks_opt_init_async(struct run_hooks_opt *o);
 void run_hooks_opt_clear(struct run_hooks_opt *o);
 
 /*
diff --git a/read-cache.c b/read-cache.c
index f801313cc9..e8cbbc6ef2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3063,7 +3063,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
-	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt;
 
 	ret = convert_to_sparse(istate);
 
@@ -3092,6 +3092,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
+	run_hooks_opt_init_async(&hook_opt);
 	strvec_pushl(&hook_opt.args,
 		     istate->updated_workdir ? "1" : "0",
 		     istate->updated_skipworktree ? "1" : "0",
diff --git a/refs.c b/refs.c
index 1149e7e7dc..61d0bb2579 100644
--- a/refs.c
+++ b/refs.c
@@ -2063,7 +2063,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 	int ret = 0, i;
 	char o[GIT_MAX_HEXSZ + 1], n[GIT_MAX_HEXSZ + 1];
@@ -2071,6 +2071,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	if (!hook_exists("reference-transaction"))
 		return ret;
 
+	run_hooks_opt_init_async(&opt);
 	strvec_push(&opt.args, state);
 
 	for (i = 0; i < transaction->nr; i++) {
diff --git a/reset.c b/reset.c
index e6af33b901..48d45f5b79 100644
--- a/reset.c
+++ b/reset.c
@@ -128,7 +128,9 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 					    reflog_head);
 	}
 	if (run_hook) {
-		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt;
+
+		run_hooks_opt_init_sync(&opt);
 		strvec_pushl(&opt.args,
 			     oid_to_hex(orig ? orig : null_oid()),
 			     oid_to_hex(oid),
diff --git a/sequencer.c b/sequencer.c
index 2440b9dccd..17b93242a7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1148,11 +1148,13 @@ int update_head_with_reflog(const struct commit *old_head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	struct strbuf tmp = STRBUF_INIT;
 	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 	int code;
 
+	run_hooks_opt_init_async(&opt);
+
 	strvec_push(&opt.args, "amend");
 
 	strbuf_addf(&tmp,
@@ -4524,7 +4526,7 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process notes_cp = CHILD_PROCESS_INIT;
-			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+			struct run_hooks_opt hook_opt;
 
 			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			notes_cp.git_cmd = 1;
@@ -4534,6 +4536,7 @@ static int pick_commits(struct repository *r,
 			/* we don't care if this copying failed */
 			run_command(&notes_cp);
 
+			run_hooks_opt_init_async(&hook_opt);
 			hook_opt.path_to_stdin = rebase_path_rewritten_list();
 			strvec_push(&hook_opt.args, "rebase");
 			run_hooks("post-rewrite", &hook_opt);
diff --git a/transport.c b/transport.c
index 9969ed2cdd..3381d24225 100644
--- a/transport.c
+++ b/transport.c
@@ -1200,11 +1200,13 @@ static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
 	int ret = 0;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	struct strbuf tmp = STRBUF_INIT;
 	struct ref *r;
 	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 
+	run_hooks_opt_init_async(&opt);
+
 	strvec_push(&opt.args, transport->remote->name);
 	strvec_push(&opt.args, transport->url);
 
-- 
2.32.0.402.g57bb445576-goog

