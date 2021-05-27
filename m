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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384EDC47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8B0613CA
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhE0ALT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbhE0AK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8341C061763
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 129-20020a2501870000b0290526b90a2992so3660669ybb.10
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vBF1RmMFwQJr3rNl8w+O7c1zzESPX+uCdyJN2Ei8ia8=;
        b=E/VstNFIjpZ/D+A2Ymc+aXHtcDSTCUIRi0aB8n4aHLrNWb+Hb/kN0xQY8E3q5JYIGn
         It6UxNtT7tch4DTVJi8x+pTfqb8zC9oqOmZR4MmUTyocS1zGZ9sXoZTD7nVu7kHh8A4t
         8jqbMcMzv3NPZdgDomBwM0EX7IJpqOXf7qCm6mNQKAUc73+O7KEwZ5jaeledbcRhjTLP
         fF45gSAllgL/NEL//Sgn2A0maWIBLjR7NKzJk6Mw+Vjeaf150EHg+xcIlVPUYMIwe6wb
         zbl/t3Xrbqs8+nnVksXn2TSNv//XH7wb4LrbZxOT/nohOtpEYgdAcMe/jPm97N6qojDy
         0Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vBF1RmMFwQJr3rNl8w+O7c1zzESPX+uCdyJN2Ei8ia8=;
        b=AN5l0Bml6Pyb/NI4jBnCtEknC8g0JURAkz1hYWtkfzOrROI8seAH7C63WdxwuMPEAS
         v2LQK71IU/1v1m605S8sYFNwQ8EYzFvU8kNvMWpfgBcac5J1FTdF6B9NshxMEEFelhkJ
         u8wSlpEowgDBp0YZkTxbWj/qgwSSvfiLN9plnGyc7iOrEh40+FNBepHeD/1NBm3Pe9Yh
         BQRTjx+p+sVu2reKJES1czbiN/74PGscBILYkpn3RXaPycToLXzqerOEP7MB5D7/1aWH
         28KiilZoxxIDMWlhIs/12jbnak+dJ/RW52AEFBv3QtUdOVir9aWonBaU0Wp5CiUMebO7
         V5Sg==
X-Gm-Message-State: AOAM530lkCqmvnTRNFJDeyJAIhjKu3qpJWMHFhLE7d2Az4IeQUEqeefT
        ILrAqMnVMA0zGbZ5sm4rAXD+cl1ZG8wBGami9+MhvllTwRw+EflTI7ACS63hyhqtuaiL6/WXUct
        s8RJo6ZJCQtfnv3NdK2UR7bsIBmgHSsbVcoac+f8Pgn7G4iD83jNI6OY9JxmqoRQ1qg3Ve9Lngg
        ==
X-Google-Smtp-Source: ABdhPJx74tXQ89xzhepUVfvTVfn3gX3MWEmrwc/6phZRjkOPqA400FWqhM1PBeXkZVBIhJc5AMfYlLAmI1bXBoqJ9f0=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:9942:: with SMTP id
 n2mr952158ybo.230.1622074162296; Wed, 26 May 2021 17:09:22 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:30 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 11/37] hook: allow parallel hook execution
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

Notes:
    Per AEvar's request - parallel hook execution on day zero.
    
    In most ways run_processes_parallel() worked great for me - but it didn't
    have great support for hooks where we pipe to and from. I had to add this
    support later in the series.
    
    Since I modified an existing and in-use library I'd appreciate a keen look on
    these patches.
    
     - Emily

 Documentation/config/hook.txt |   5 ++
 Documentation/git-hook.txt    |  14 ++++-
 builtin/hook.c                |   6 +-
 hook.c                        | 111 ++++++++++++++++++++++++++++------
 hook.h                        |  22 ++++++-
 5 files changed, 134 insertions(+), 24 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index 8b12512e33..4f66bb35cf 100644
--- a/Documentation/config/hook.txt
+++ b/Documentation/config/hook.txt
@@ -20,3 +20,8 @@ hook.runHookDir::
 	Controls how hooks contained in your hookdir are executed. Can be any of
 	"yes", "warn", "interactive", or "no". Defaults to "yes". See
 	linkgit:git-hook[1] and linkgit:git-config[1] "core.hooksPath").
+
+hook.jobs::
+	Specifies how many hooks can be run simultaneously during parallelized
+	hook execution. If unspecified, defaults to the number of processors on
+	the current system.
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 96a857c682..81b8e94994 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git hook' list <hook-name>
 'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>]
-	<hook-name>
+	[(-j|--jobs) <n>] <hook-name>
 
 DESCRIPTION
 -----------
@@ -99,7 +99,7 @@ in the order they should be run, and print the config scope where the relevant
 `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
 This output is human-readable and the format is subject to change over time.
 
-run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>] `<hook-name>`::
+run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>] [(-j|--jobs)<n>] `<hook-name>`::
 
 Runs hooks configured for `<hook-name>`, in the same order displayed by `git
 hook list`. Hooks configured this way may be run prepended with `sh -c`, so
@@ -131,6 +131,16 @@ Specify environment variables to set for every hook that is run.
 Specify a file which will be streamed into stdin for every hook that is run.
 Each hook will receive the entire file from beginning to EOF.
 
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
 CONFIGURATION
 -------------
 include::config/hook.txt[]
diff --git a/builtin/hook.c b/builtin/hook.c
index 0d9c052e84..c79a961e80 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -9,7 +9,7 @@
 static const char * const builtin_hook_usage[] = {
 	N_("git hook list <hookname>"),
 	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...]"
-	   "[--to-stdin=<path>] <hookname>"),
+	   "[--to-stdin=<path>] [(-j|--jobs) <count>] <hookname>"),
 	NULL
 };
 
@@ -114,10 +114,12 @@ static int run(int argc, const char **argv, const char *prefix)
 			   N_("argument to pass to hook")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_INTEGER('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
 
-	run_hooks_opt_init(&opt);
+	run_hooks_opt_init_async(&opt);
 
 	argc = parse_options(argc, argv, prefix, run_options,
 			     builtin_hook_usage, 0);
diff --git a/hook.c b/hook.c
index a2eda57fb9..784529fe2b 100644
--- a/hook.c
+++ b/hook.c
@@ -143,6 +143,14 @@ enum hookdir_opt configured_hookdir_opt(void)
 	return HOOKDIR_UNKNOWN;
 }
 
+int configured_hook_jobs(void)
+{
+	int n = online_cpus();
+	git_config_get_int("hook.jobs", &n);
+
+	return n;
+}
+
 static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
 {
 	struct strbuf prompt = STRBUF_INIT;
@@ -241,12 +249,19 @@ struct list_head* hook_list(const char* hookname)
 	return hook_head;
 }
 
-void run_hooks_opt_init(struct run_hooks_opt *o)
+void run_hooks_opt_init_sync(struct run_hooks_opt *o)
 {
 	strvec_init(&o->env);
 	strvec_init(&o->args);
 	o->path_to_stdin = NULL;
 	o->run_hookdir = configured_hookdir_opt();
+	o->jobs = 1;
+}
+
+void run_hooks_opt_init_async(struct run_hooks_opt *o)
+{
+	run_hooks_opt_init_sync(o);
+	o->jobs = configured_hook_jobs();
 }
 
 int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
@@ -274,22 +289,28 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
 	strvec_clear(&o->args);
 }
 
-static void prepare_hook_cp(const char *hookname, struct hook *hook,
-			    struct run_hooks_opt *options,
-			    struct child_process *cp)
+static int pick_next_hook(struct child_process *cp,
+			  struct strbuf *out,
+			  void *pp_cb,
+			  void **pp_task_cb)
 {
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct hook *hook = hook_cb->run_me;
+
 	if (!hook)
-		return;
+		return 0;
 
 	/* reopen the file for stdin; run_command closes it. */
-	if (options->path_to_stdin)
-		cp->in = xopen(options->path_to_stdin, O_RDONLY);
-	else
+	if (hook_cb->options->path_to_stdin) {
+		cp->no_stdin = 0;
+		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
+	} else {
 		cp->no_stdin = 1;
+	}
 
-	cp->env = options->env.v;
+	cp->env = hook_cb->options->env.v;
 	cp->stdout_to_stderr = 1;
-	cp->trace2_hook_name = hookname;
+	cp->trace2_hook_name = hook_cb->hookname;
 
 	/*
 	 * Commands from the config could be oneliners, but we know
@@ -304,13 +325,58 @@ static void prepare_hook_cp(const char *hookname, struct hook *hook,
 	 * add passed-in argv, without expanding - let the user get back
 	 * exactly what they put in
 	 */
-	strvec_pushv(&cp->args, options->args.v);
+	strvec_pushv(&cp->args, hook_cb->options->args.v);
+
+	/* Provide context for errors if necessary */
+	*pp_task_cb = hook;
+
+	/* Get the next entry ready */
+	if (hook_cb->run_me->list.next == hook_cb->head)
+		hook_cb->run_me = NULL;
+	else
+		hook_cb->run_me = list_entry(hook_cb->run_me->list.next,
+					     struct hook, list);
+
+	return 1;
+}
+
+static int notify_start_failure(struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cp)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct hook *attempted = pp_task_cp;
+
+	/* |= rc in cb */
+	hook_cb->rc |= 1;
+
+	strbuf_addf(out, _("Couldn't start '%s', configured in '%s'\n"),
+		    attempted->command.buf,
+		    attempted->from_hookdir ? "hookdir"
+			: config_scope_name(attempted->origin));
+
+	/* NEEDSWORK: if halt_on_error is desired, do it here. */
+	return 0;
+}
+
+static int notify_hook_finished(int result,
+				struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cb)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+
+	/* |= rc in cb */
+	hook_cb->rc |= result;
+
+	/* NEEDSWORK: if halt_on_error is desired, do it here. */
+	return 0;
 }
 
 int run_hooks(const char *hookname, struct run_hooks_opt *options)
 {
 	struct list_head *to_run, *pos = NULL, *tmp = NULL;
-	int rc = 0;
+	struct hook_cb_data cb_data = { 0, hookname, NULL, NULL, options };
 
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
@@ -318,17 +384,26 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	to_run = hook_list(hookname);
 
 	list_for_each_safe(pos, tmp, to_run) {
-		struct child_process hook_proc = CHILD_PROCESS_INIT;
 		struct hook *hook = list_entry(pos, struct hook, list);
 
 		if (hook->from_hookdir &&
 		    !should_include_hookdir(hook->command.buf, options->run_hookdir))
-			continue;
+			    list_del(pos);
+	}
+
+	if (list_empty(to_run))
+		return 0;
 
-		prepare_hook_cp(hookname, hook, options, &hook_proc);
+	cb_data.head = to_run;
+	cb_data.run_me = list_entry(to_run->next, struct hook, list);
 
-		rc |= run_command(&hook_proc);
-	}
+	run_processes_parallel_tr2(options->jobs,
+				   pick_next_hook,
+				   notify_start_failure,
+				   notify_hook_finished,
+				   &cb_data,
+				   "hook",
+				   hookname);
 
-	return rc;
+	return cb_data.rc;
 }
diff --git a/hook.h b/hook.h
index 37147f4c5e..cdb1ac5510 100644
--- a/hook.h
+++ b/hook.h
@@ -38,6 +38,9 @@ enum hookdir_opt
  */
 enum hookdir_opt configured_hookdir_opt(void);
 
+/* Provides the number of threads to use for parallel hook execution. */
+int configured_hook_jobs(void);
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -48,16 +51,31 @@ struct run_hooks_opt
 
 	/*
 	 * How should the hookdir be handled?
-	 * Leave the RUN_HOOKS_OPT_INIT default in most cases; this only needs
+	 * Leave the run_hooks_opt_init_*() default in most cases; this only needs
 	 * to be overridden if the user can override it at the command line.
 	 */
 	enum hookdir_opt run_hookdir;
 
 	/* Path to file which should be piped to stdin for each hook */
 	const char *path_to_stdin;
+
+	/* Number of threads to parallelize across */
+	int jobs;
+};
+
+/*
+ * Callback provided to feed_pipe_fn and consume_sideband_fn.
+ */
+struct hook_cb_data {
+	int rc;
+	const char *hookname;
+	struct list_head *head;
+	struct hook *run_me;
+	struct run_hooks_opt *options;
 };
 
-void run_hooks_opt_init(struct run_hooks_opt *o);
+void run_hooks_opt_init_sync(struct run_hooks_opt *o);
+void run_hooks_opt_init_async(struct run_hooks_opt *o);
 void run_hooks_opt_clear(struct run_hooks_opt *o);
 
 /*
-- 
2.31.1.818.g46aad6cb9e-goog

