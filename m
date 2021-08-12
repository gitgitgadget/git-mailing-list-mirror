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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F1C4320A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C218760FC3
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhHLAnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 20:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhHLAnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 20:43:40 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892C3C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:16 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r13-20020ac85c8d0000b029028efef0404cso2254340qta.14
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=JtIDsVyWQ6ZoB9IXVAEzKb4E9DwVjqwDJabf0K90n/o=;
        b=bUOtKdPH+vMAryQCM12rc94ZsR4I3HwpalXsI/AHuRMegnPs+Y2rK7FOTu/gLzczOV
         2Oe/K5iREjhTiJ1JwZjdzVlOrBtR9khWTtQJKvg7T71wY6vMtc0pyDzzfq3RfbiHAVRt
         er/3CMuh3nn7y/Eu3EWylTlxECKtsSz6OhHsnK/s5jajFocp0jvPqHIFdtsQodC2q2cK
         M+DL5ixVRLqt4btUlGNjhlJGKzf20VItgGa+WiZkKTsxzC5OCLznaJXRyuywWekO37LN
         VwCyvQvnHtPQjpqXCN0+NDQIzsScxvJsdT4xSroo+lVETsg/NnIAe3H95S3fqTz9la5o
         SnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=JtIDsVyWQ6ZoB9IXVAEzKb4E9DwVjqwDJabf0K90n/o=;
        b=jvkGxo+HnFmuFfhxjZ1xaGMuT9oJ/dCcL6hOOJ40NC1DzAo+/pHvoorqVvnlRuKiLA
         rkwxajRG4YHOPkJ25/RXBikcIZVVKmBNTnpdFYbGH7c5EvpnIn+0bxZ0m6G4xH7JZi5k
         VCoZvIOEv6v3pE5xChAApxP0Uys4Axu0xu39FbYTjTvfHUx8RhS33fpCkxpHDzEs5I7z
         tW3rfPWPqQlIW7zHbWW3UYyFaTeJfg/kMCkI1xTHqPUQLAdc5RreAuwzlmPuoKfppQD1
         moVPAN24A4Rc9qmJJjrhfHzqxSXSFv2MFMYtWEqKEZ+/YXNIrmv0Bmp8w9Ajk1wwoYnZ
         3K3w==
X-Gm-Message-State: AOAM532ssnQlMZ7TKOUk6enFuzC6W5ru2TQgWXhmY06zkSczZ7Mq53Ji
        kZtxag4VnOxSWJb5cuu3CpPCiEofqIox8oRBh8FfW9J25tYgorO4r/xayAdA8S2s6yyQBenBq1W
        uFA7ZZuOFGqY2xWWDR89GsNmz9xssScxuBglvOVngB0HsbuPC90OLWUm9pkcjkFiyyA+wT1VbOQ
        ==
X-Google-Smtp-Source: ABdhPJxwI1I106pS0eluUlHhxzrCUcIHc1UkjjoxzaMjSqo6e1LYL8b2/4ZAlGmhiAguSVRl7l99NVSjapvvUQssipc=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:d801:: with SMTP id
 h1mr1459636qvj.60.1628728995716; Wed, 11 Aug 2021 17:43:15 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:42:54 -0700
In-Reply-To: <20210812004258.74318-1-emilyshaffer@google.com>
Message-Id: <20210812004258.74318-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210812004258.74318-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 2/6] hook: allow parallel hook execution
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 Documentation/config/hook.txt |  4 ++++
 Documentation/git-hook.txt    | 17 ++++++++++++++++-
 builtin/am.c                  |  4 ++--
 builtin/checkout.c            |  2 +-
 builtin/clone.c               |  2 +-
 builtin/hook.c                |  4 +++-
 builtin/merge.c               |  2 +-
 builtin/rebase.c              |  2 +-
 builtin/receive-pack.c        |  9 +++++----
 builtin/worktree.c            |  2 +-
 commit.c                      |  2 +-
 hook.c                        | 36 +++++++++++++++++++++++++++++++----
 hook.h                        | 24 ++++++++++++++++++-----
 read-cache.c                  |  2 +-
 refs.c                        |  2 +-
 reset.c                       |  3 ++-
 sequencer.c                   |  4 ++--
 transport.c                   |  2 +-
 18 files changed, 94 insertions(+), 29 deletions(-)
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
-'git hook' run [--to-stdin=3D<path>] [--ignore-missing] <hook-name> [-- <h=
ook-args>]
+'git hook' run [--to-stdin=3D<path>] [--ignore-missing] [(-j|--jobs) <n>]
+	<hook-name> [-- <hook-args>]
=20
 DESCRIPTION
 -----------
@@ -42,6 +43,20 @@ OPTIONS
 	tools that want to do a blind one-shot run of a hook that may
 	or may not be present.
=20
+-j::
+--jobs::
+	Only valid for `run`.
++
+Specify how many hooks to run simultaneously. If this flag is not specifie=
d, use
+the value of the `hook.jobs` config. If the config is not specified, use t=
he
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
index 9e3d4d9ab4..c24a27d6a1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -446,7 +446,7 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
=20
 	assert(state->msg);
 	strvec_push(&opt.args, am_path(state, "final-commit"));
@@ -467,7 +467,7 @@ static int run_applypatch_msg_hook(struct am_state *sta=
te)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
=20
 	strvec_push(&opt.args, "rebase");
 	opt.path_to_stdin =3D am_path(state, "rewritten");
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6d69b4c011..27166c0bb8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -107,7 +107,7 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *ne=
w_commit,
 			      int changed)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
=20
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
diff --git a/builtin/clone.c b/builtin/clone.c
index 27fc05ee51..599e7a7936 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -776,7 +776,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err =3D 0;
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_SYNC;
=20
 	if (option_no_checkout)
 		return 0;
diff --git a/builtin/hook.c b/builtin/hook.c
index 4d39c9e75e..12c9126032 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -22,7 +22,7 @@ static const char * const builtin_hook_run_usage[] =3D {
 static int run(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
 	int ignore_missing =3D 0;
 	const char *hook_name;
 	struct list_head *hooks;
@@ -32,6 +32,8 @@ static int run(int argc, const char **argv, const char *p=
refix)
 			 N_("exit quietly with a zero exit code if the requested hook cannot be=
 found")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_INTEGER('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
 	int ret;
diff --git a/builtin/merge.c b/builtin/merge.c
index 9bd4a2532c..c749c382c3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,7 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message =3D STRBUF_INIT;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
 	const struct object_id *head =3D &head_commit->object.oid;
=20
 	if (!msg)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index e7c668c99b..fecf248ed9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1314,7 +1314,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 	char *squash_onto_name =3D NULL;
 	int reschedule_failed_exec =3D -1;
 	int allow_preemptive_ff =3D 1;
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
 	struct option builtin_rebase_options[] =3D {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ebec6f3bb1..b32dcc9000 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -909,7 +909,7 @@ static int run_receive_hook(struct command *commands,
 			    int skip_broken,
 			    const struct string_list *push_options)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
 	struct receive_hook_feed_context ctx;
 	struct command *iter =3D commands;
=20
@@ -948,7 +948,7 @@ static int run_receive_hook(struct command *commands,
=20
 static int run_update_hook(struct command *cmd)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
=20
 	strvec_pushl(&opt.args,
 		     cmd->ref_name,
@@ -1432,7 +1432,8 @@ static const char *push_to_checkout(unsigned char *ha=
sh,
 				    struct strvec *env,
 				    const char *work_tree)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
+
 	opt.invoked_hook =3D invoked_hook;
=20
 	strvec_pushf(env, "GIT_WORK_TREE=3D%s", absolute_path(work_tree));
@@ -1628,7 +1629,7 @@ static const char *update(struct command *cmd, struct=
 shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 330867c19b..efead564c1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,7 +382,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout) {
-		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
=20
 		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
 		strvec_pushl(&opt.args,
diff --git a/commit.c b/commit.c
index 842e47beae..0e6e5a5b27 100644
--- a/commit.c
+++ b/commit.c
@@ -1700,7 +1700,7 @@ int run_commit_hook(int editor_is_used, const char *i=
ndex_file,
 		    int *invoked_hook,
 		    const char *name, ...)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
 	va_list args;
 	const char *arg;
=20
diff --git a/hook.c b/hook.c
index 80e150548c..37f682c6d8 100644
--- a/hook.c
+++ b/hook.c
@@ -228,6 +228,28 @@ static int notify_hook_finished(int result,
 	return 0;
 }
=20
+/*
+ * Determines how many jobs to use after we know we want to parallelize. F=
irst
+ * priority is the config 'hook.jobs' and second priority is the number of=
 CPUs.
+ */
+static int configured_hook_jobs(void)
+{
+	/*
+	 * The config and the CPU count probably won't change during the process
+	 * lifetime, so cache the result in case we invoke multiple hooks during
+	 * one process.
+	 */
+	static int jobs =3D 0;
+	if (jobs)
+		return jobs;
+
+	if (git_config_get_int("hook.jobs", &jobs))
+		/* if the config isn't set, fall back to CPU count. */
+		jobs =3D online_cpus();
+
+	return jobs;
+}
+
 int run_hooks(const char *hook_name, struct list_head *hooks,
 		    struct run_hooks_opt *options)
 {
@@ -237,16 +259,18 @@ int run_hooks(const char *hook_name, struct list_head=
 *hooks,
 		.options =3D options,
 		.invoked_hook =3D options->invoked_hook,
 	};
-	int jobs =3D 1;
=20
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
=20
-
 	cb_data.head =3D hooks;
 	cb_data.run_me =3D list_first_entry(hooks, struct hook, list);
=20
-	run_processes_parallel_tr2(jobs,
+	/* INIT_ASYNC sets jobs to 0, so go look up how many to use. */
+	if (!options->jobs)
+		options->jobs =3D configured_hook_jobs();
+
+	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
@@ -265,7 +289,11 @@ int run_hooks_oneshot(const char *hook_name, struct ru=
n_hooks_opt *options)
 {
 	struct list_head *hooks;
 	int ret =3D 0;
-	struct run_hooks_opt hook_opt_scratch =3D RUN_HOOKS_OPT_INIT;
+	/*
+	 * Turn on parallelism by default. Hooks which don't want it should
+	 * specify their options accordingly.
+	 */
+	struct run_hooks_opt hook_opt_scratch =3D RUN_HOOKS_OPT_INIT_ASYNC;
=20
 	if (!options)
 		options =3D &hook_opt_scratch;
diff --git a/hook.h b/hook.h
index 7705e6a529..4f90228a0c 100644
--- a/hook.h
+++ b/hook.h
@@ -43,6 +43,13 @@ struct run_hooks_opt
 	/* Args to be passed to each hook */
 	struct strvec args;
=20
+	/*
+	 * Number of threads to parallelize across. Set to 0 to use the
+	 * 'hook.jobs' config or, if that config is unset, the number of cores
+	 * on the system.
+	 */
+	int jobs;
+
 	/* Resolve and run the "absolute_path(hook)" instead of
 	 * "hook". Used for "git worktree" hooks
 	 */
@@ -85,11 +92,6 @@ struct run_hooks_opt
 	int *invoked_hook;
 };
=20
-#define RUN_HOOKS_OPT_INIT { \
-	.env =3D STRVEC_INIT, \
-	.args =3D STRVEC_INIT, \
-}
-
 /*
  * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to=
 the
  * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list=
()'.
@@ -111,6 +113,18 @@ struct hook_cb_data {
 	int *invoked_hook;
 };
=20
+#define RUN_HOOKS_OPT_INIT_SYNC { \
+	.jobs =3D 1, \
+	.env =3D STRVEC_INIT, \
+	.args =3D STRVEC_INIT, \
+}
+
+#define RUN_HOOKS_OPT_INIT_ASYNC { \
+	.jobs =3D 0, \
+	.env =3D STRVEC_INIT, \
+	.args =3D STRVEC_INIT, \
+}
+
 void run_hooks_opt_clear(struct run_hooks_opt *o);
=20
 /**
diff --git a/read-cache.c b/read-cache.c
index 90099ca14d..fd2bc67667 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3068,7 +3068,7 @@ static int do_write_locked_index(struct index_state *=
istate, struct lock_file *l
 {
 	int ret;
 	int was_full =3D !istate->sparse_index;
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
=20
 	ret =3D convert_to_sparse(istate);
=20
diff --git a/refs.c b/refs.c
index 73d4a93926..305a075746 100644
--- a/refs.c
+++ b/refs.c
@@ -2062,7 +2062,7 @@ int ref_update_reject_duplicates(struct string_list *=
refnames,
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
 	struct string_list to_stdin =3D STRING_LIST_INIT_NODUP;
 	int ret =3D 0, i;
=20
diff --git a/reset.c b/reset.c
index 6499bc5127..b93fe6a783 100644
--- a/reset.c
+++ b/reset.c
@@ -128,7 +128,8 @@ int reset_head(struct repository *r, struct object_id *=
oid, const char *action,
 					    reflog_head);
 	}
 	if (run_hook) {
-		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
+
 		strvec_pushl(&opt.args,
 			     oid_to_hex(orig ? orig : null_oid()),
 			     oid_to_hex(oid),
diff --git a/sequencer.c b/sequencer.c
index f451e23d0c..f13a0cbfbe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1148,7 +1148,7 @@ int update_head_with_reflog(const struct commit *old_=
head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
 	struct strbuf tmp =3D STRBUF_INIT;
 	struct string_list to_stdin =3D STRING_LIST_INIT_DUP;
 	int code;
@@ -4522,7 +4522,7 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process notes_cp =3D CHILD_PROCESS_INIT;
-			struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+			struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
=20
 			notes_cp.in =3D open(rebase_path_rewritten_list(), O_RDONLY);
 			notes_cp.git_cmd =3D 1;
diff --git a/transport.c b/transport.c
index 4ca8fc0391..abf8785885 100644
--- a/transport.c
+++ b/transport.c
@@ -1204,7 +1204,7 @@ static int run_pre_push_hook(struct transport *transp=
ort,
 			     struct ref *remote_refs)
 {
 	int ret =3D 0;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
 	struct ref *r;
 	struct string_list to_stdin =3D STRING_LIST_INIT_NODUP;
=20
--=20
2.32.0.605.g8dce9f2422-goog

