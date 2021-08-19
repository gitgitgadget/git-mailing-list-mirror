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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E32DC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AEC610CE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhHSDfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhHSDff (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 23:35:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E35DC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:34:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d69-20020a25e6480000b02904f4a117bd74so5196760ybh.17
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=wA9y4rVq7Y692BXWnOq2NxWoqSRyWczEgp+zizC9618=;
        b=TWFHeWCp+FMXduJLA85FOsAUiG2GMjAfyp8/G7jeU2MhB9E9QjR8GPjHzmOgrxUZIX
         WY7AhMQ0o+IYNF74Cis/VYQRwqa8taQWq5+pBq+mUAnfrIFsQfIdNBby8QlM3fAUzk0u
         tj0WRPTrMx0Pt49KBOEuZYtYMTeKau+ZNjScuSlYaZshxJVJUk8Vn2wxu9+JqfD8noXP
         siOgwh/3OAtHm0PVMr+L7QlfTajI2TBataCBHSdGNaaPasc8emAIrdGhaTOam9D0Ag3N
         HHhOAoqKhyYySYVMx87K82VkJeY+1GBSxt/HVE6g9hOlaJwOvYgadL3kBTliWL4C+Cgk
         gKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=wA9y4rVq7Y692BXWnOq2NxWoqSRyWczEgp+zizC9618=;
        b=BzVUFbliXrGHIr6W7iJZLlZU3h4P+vbEWZbljJs6fGMIdiifrLNvXSjwvMLz3yFVgg
         VD8y5QC7msycj7gTTwj4Qt0RSDtulgnChiL1K3wMGprljPQW26uP78MPU6CImNVujB3N
         wyyqls/jV48c7zvvL/w1UwYaq4ds2rHZnkFCgz4V10TS/iI9wCEXqOi9PkZqhSgwtsS2
         HUDIv0S2hIOOXiz5kjpYFau8TEOcL256hc23I5f/1IoWNf0oFdXLSiLU9UH43qBisvhy
         FP/HTWXVxYVKGF2FkytZ+fkxARlk/Om+LGY/PGlo37IyZzbQVZRyjY+tEgxJj3t/UsZk
         KyEQ==
X-Gm-Message-State: AOAM5322tAMCu+3lvsXcAHk3BJzBrAfsnnsa4YjIavUbStBpwxQ1Hxa5
        SlTU1vssam81iyHy0tl4o8cZGACMfDqOsd0sUeCCgNL77nE982DCHb/w78ash0Jrl27yEV9qN0n
        cmJ3d3GZgXpNRlV9WOzsjOwyUx/mjBR7YrNrmnEIB4rBVyCLPU8eBs7dt/6l4v3/xqZZ/3WYGjA
        ==
X-Google-Smtp-Source: ABdhPJwZMXZJ34x2Jm8n8g2XnJV8cSSiX2O6C0+r3pcmUtl8sjxq44ZwjkM2yDFOm+ut26zsut9gsu9oyW7I2UBkXSk=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:cb0a:: with SMTP id
 b10mr15550132ybg.137.1629344098806; Wed, 18 Aug 2021 20:34:58 -0700 (PDT)
Date:   Wed, 18 Aug 2021 20:34:46 -0700
In-Reply-To: <20210819033450.3382652-1-emilyshaffer@google.com>
Message-Id: <20210819033450.3382652-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819033450.3382652-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 2/6] hook: allow parallel hook execution
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
parallel, if more than one was provided. hook.c already calls
run_processes_parallel(), so all we need to do is allow the job count we
hand to run_processes_parallel() to be greater than 1.

If users have specified no alternative, we can use the processor count
from online_cpus() to run an efficient number of tasks at once. However,
users can also override this number if they want by configuring
'hook.jobs'.

To avoid looking up 'hook.jobs' in cases where we don't end up with any
hooks to run anyways, teach the hook runner commands to notice if
.jobs=3D=3D0 and do a config or online_cpus() lookup if so, when we already
know we have jobs to run.

Serial execution can still be performed by setting .jobs =3D=3D 1.

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
index 9e3d4d9ab4..c7ffc7eafc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -446,7 +446,7 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
=20
 	assert(state->msg);
 	strvec_push(&opt.args, am_path(state, "final-commit"));
@@ -467,7 +467,7 @@ static int run_applypatch_msg_hook(struct am_state *sta=
te)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
=20
 	strvec_push(&opt.args, "rebase");
 	opt.path_to_stdin =3D am_path(state, "rewritten");
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6d69b4c011..2cb5c67f64 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -107,7 +107,7 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *ne=
w_commit,
 			      int changed)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
=20
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
diff --git a/builtin/clone.c b/builtin/clone.c
index 27fc05ee51..986c3b1932 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -776,7 +776,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err =3D 0;
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
=20
 	if (option_no_checkout)
 		return 0;
diff --git a/builtin/hook.c b/builtin/hook.c
index e18357ba1f..4dd3617876 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -22,7 +22,7 @@ static const char * const builtin_hook_run_usage[] =3D {
 static int run(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
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
index 9bd4a2532c..81d7ebbbf6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,7 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message =3D STRBUF_INIT;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
 	const struct object_id *head =3D &head_commit->object.oid;
=20
 	if (!msg)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index e7c668c99b..ad118c983c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1314,7 +1314,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 	char *squash_onto_name =3D NULL;
 	int reschedule_failed_exec =3D -1;
 	int allow_preemptive_ff =3D 1;
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct option builtin_rebase_options[] =3D {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ebec6f3bb1..7460124b74 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -909,7 +909,7 @@ static int run_receive_hook(struct command *commands,
 			    int skip_broken,
 			    const struct string_list *push_options)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct receive_hook_feed_context ctx;
 	struct command *iter =3D commands;
=20
@@ -948,7 +948,7 @@ static int run_receive_hook(struct command *commands,
=20
 static int run_update_hook(struct command *cmd)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
=20
 	strvec_pushl(&opt.args,
 		     cmd->ref_name,
@@ -1432,7 +1432,8 @@ static const char *push_to_checkout(unsigned char *ha=
sh,
 				    struct strvec *env,
 				    const char *work_tree)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
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
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 330867c19b..3090506790 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,7 +382,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout) {
-		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
=20
 		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
 		strvec_pushl(&opt.args,
diff --git a/commit.c b/commit.c
index 842e47beae..a38bd04752 100644
--- a/commit.c
+++ b/commit.c
@@ -1700,7 +1700,7 @@ int run_commit_hook(int editor_is_used, const char *i=
ndex_file,
 		    int *invoked_hook,
 		    const char *name, ...)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
 	va_list args;
 	const char *arg;
=20
diff --git a/hook.c b/hook.c
index 333cfd633a..b8420353fa 100644
--- a/hook.c
+++ b/hook.c
@@ -227,6 +227,28 @@ static int notify_hook_finished(int result,
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
@@ -236,16 +258,18 @@ int run_hooks(const char *hook_name, struct list_head=
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
+	/* INIT_PARALLEL sets jobs to 0, so go look up how many to use. */
+	if (!options->jobs)
+		options->jobs =3D configured_hook_jobs();
+
+	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
@@ -264,7 +288,11 @@ int run_hooks_oneshot(const char *hook_name, struct ru=
n_hooks_opt *options)
 {
 	struct list_head *hooks;
 	int ret =3D 0;
-	struct run_hooks_opt hook_opt_scratch =3D RUN_HOOKS_OPT_INIT;
+	/*
+	 * Turn on parallelism by default. Hooks which don't want it should
+	 * specify their options accordingly.
+	 */
+	struct run_hooks_opt hook_opt_scratch =3D RUN_HOOKS_OPT_INIT_PARALLEL;
=20
 	if (!options)
 		options =3D &hook_opt_scratch;
diff --git a/hook.h b/hook.h
index 12b56616bb..cd3123d290 100644
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
+#define RUN_HOOKS_OPT_INIT_SERIAL { \
+	.jobs =3D 1, \
+	.env =3D STRVEC_INIT, \
+	.args =3D STRVEC_INIT, \
+}
+
+#define RUN_HOOKS_OPT_INIT_PARALLEL { \
+	.jobs =3D 0, \
+	.env =3D STRVEC_INIT, \
+	.args =3D STRVEC_INIT, \
+}
+
 void run_hooks_opt_clear(struct run_hooks_opt *o);
=20
 /**
diff --git a/read-cache.c b/read-cache.c
index 90099ca14d..f157e62531 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3068,7 +3068,7 @@ static int do_write_locked_index(struct index_state *=
istate, struct lock_file *l
 {
 	int ret;
 	int was_full =3D !istate->sparse_index;
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
=20
 	ret =3D convert_to_sparse(istate);
=20
diff --git a/refs.c b/refs.c
index 73d4a93926..5543b8cdab 100644
--- a/refs.c
+++ b/refs.c
@@ -2062,7 +2062,7 @@ int ref_update_reject_duplicates(struct string_list *=
refnames,
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct string_list to_stdin =3D STRING_LIST_INIT_NODUP;
 	int ret =3D 0, i;
=20
diff --git a/reset.c b/reset.c
index 6499bc5127..1941adb771 100644
--- a/reset.c
+++ b/reset.c
@@ -128,7 +128,8 @@ int reset_head(struct repository *r, struct object_id *=
oid, const char *action,
 					    reflog_head);
 	}
 	if (run_hook) {
-		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
+
 		strvec_pushl(&opt.args,
 			     oid_to_hex(orig ? orig : null_oid()),
 			     oid_to_hex(oid),
diff --git a/sequencer.c b/sequencer.c
index f451e23d0c..30fbe79b8a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1148,7 +1148,7 @@ int update_head_with_reflog(const struct commit *old_=
head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct strbuf tmp =3D STRBUF_INIT;
 	struct string_list to_stdin =3D STRING_LIST_INIT_DUP;
 	int code;
@@ -4522,7 +4522,7 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process notes_cp =3D CHILD_PROCESS_INIT;
-			struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+			struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
=20
 			notes_cp.in =3D open(rebase_path_rewritten_list(), O_RDONLY);
 			notes_cp.git_cmd =3D 1;
diff --git a/transport.c b/transport.c
index 4ca8fc0391..33da71a108 100644
--- a/transport.c
+++ b/transport.c
@@ -1204,7 +1204,7 @@ static int run_pre_push_hook(struct transport *transp=
ort,
 			     struct ref *remote_refs)
 {
 	int ret =3D 0;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct ref *r;
 	struct string_list to_stdin =3D STRING_LIST_INIT_NODUP;
=20
--=20
2.33.0.rc2.250.ged5fa647cd-goog

