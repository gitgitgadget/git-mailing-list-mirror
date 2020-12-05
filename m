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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9599AC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C89022DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgLEBsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgLEBsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:48:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A2C08E9AA
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k196so9284747ybf.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=a4ISl+AlC5HxlW/Cd9WsvKawkbmJdEAy9Xf+PQ6kfHQ=;
        b=hW2Xa8mENl5Dmx2gkd4Z4A2gdoNU6aBhF/GtlcR157STwSnERGEiBMlJweZ2WymtnK
         BQ9v6BiXSZrlMRyir64WGr/oYGl7LIni1N73a5a6hgq4xV4bdpJSvbVEKEviD23Q3pCc
         XbY1jJt832OxYGJrn7myGjJ0acM1LvbyCbEJ+MDLeicfxYUhK4CzYv6e6RkNQEyNq1q5
         6oSRDypGcfG4GECrfskFVmIKXfoS4COOs5llVa/JoSfx72wi3ZdTpw8L2SiL257VcEJx
         G1Kxam0TXG7NE9vXLcBJzc3R6wrAm+HQT7AaW6qeEDG38j8lYuZKZN6j/mMWdmTqTivF
         M/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a4ISl+AlC5HxlW/Cd9WsvKawkbmJdEAy9Xf+PQ6kfHQ=;
        b=Q3cD+fZfS5xOdzBv8vQ5YwPUlPQ4zahP7JZwF6a0Xtr2fF46S+Iwe/UMBNG0UhKqbd
         4jnpJb3BV4LCXQGQ7uTrzQ1qHUKfKoRYgIyH1XeH7SetdeHLgXnN3V90bW3SmzUkdNbC
         N6NUvlAGfc3igBBfwm/iuKGlpYqB7Q1Z2Zy5CwwDTQoo7WXMHMU/UOPm9uRNkukrHKdQ
         4T+df3TYA/sZwHylCu6xpdw2QwyDF+evrhkbNnH89ZUQQ+HrOSfQUOkBIdIsRlmHhtvp
         uBXlPgmOCJsy0wDrAOd4b0Rvj0l7ZR+mj+d20LtK7bQZbSoCMl9rUY6kIPgcl6YPk1EZ
         ti/w==
X-Gm-Message-State: AOAM533IdatqYB0NYpZofmHm8urQlI2J4uGhLDJXUYDs4rOhZNEzuZkK
        6eIWWZAOwhOOMOk4RNaEkuBCVINAqZ2IfsfP6pZF0FvW3KaEhiSB6hJ2Bo66za/KBjyZfRZ0niC
        VfCXNr7bRHPr2GB0DJkHBghpll4hPZ/wzm2Ou5OvTjjk0c+DuacFi8CJKwe+5fBJIYt6hxtYnFw
        ==
X-Google-Smtp-Source: ABdhPJysgkWki2bC43R9U+uw8t0KIOJlY0Hlz/Lvq/JPA9rHYgRuYwEgCgAlQFJJmnjxsQBLDC7ovr/CGjE/Sa1SoeI=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ce50:: with SMTP id
 x77mr10624032ybe.38.1607132804518; Fri, 04 Dec 2020 17:46:44 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:46:06 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-17-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 16/17] run-command: allow capturing of collated output
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some callers, for example server-side hooks which wish to relay hook
output to clients across a transport, want to capture what would
normally print to stderr and do something else with it. Allow that via a
callback.

By calling the callback regardless of whether there's output available,
we allow clients to send e.g. a keepalive if necessary.

Because we expose a strbuf, not a fd or FILE*, there's no need to create
a temporary pipe or similar - we can just skip the print to stderr and
instead hand it to the caller.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Originally when writing this patch I attempted to use a pipe in memory -
    but managing its lifetime was actually pretty tricky, and I found I could
    achieve the same thing with less code by doing it this way. Critique welcome,
    including "no, you really need to do it with a pipe".

 builtin/fetch.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 hook.c                      |  1 +
 run-command.c               | 33 +++++++++++++++++++++++++--------
 run-command.h               | 18 +++++++++++++++++-
 submodule.c                 |  2 +-
 t/helper/test-run-command.c | 25 ++++++++++++++++++++-----
 t/t0061-run-command.sh      |  7 +++++++
 8 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5e153b5193..6a634085d9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1647,7 +1647,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 		result = run_processes_parallel_tr2(max_children,
 						    &fetch_next_remote,
 						    &fetch_failed_to_start,
-						    NULL,
+						    NULL, NULL,
 						    &fetch_finished,
 						    &state,
 						    "fetch", "parallel/fetch");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bb623c1852..8c543d33fd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2294,7 +2294,7 @@ static int update_submodules(struct submodule_update_clone *suc)
 	int i;
 
 	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure, NULL,
+				   update_clone_start_failure, NULL, NULL,
 				   update_clone_task_finished, suc, "submodule",
 				   "parallel/update");
 
diff --git a/hook.c b/hook.c
index fbb49f241d..1186ee41b3 100644
--- a/hook.c
+++ b/hook.c
@@ -407,6 +407,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
+				   NULL,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/run-command.c b/run-command.c
index 7b65c087f8..0dce6bec83 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1549,6 +1549,7 @@ struct parallel_processes {
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
 	feed_pipe_fn feed_pipe;
+	consume_sideband_fn consume_sideband;
 	task_finished_fn task_finished;
 
 	struct {
@@ -1614,6 +1615,7 @@ static void pp_init(struct parallel_processes *pp,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
 		    feed_pipe_fn feed_pipe,
+		    consume_sideband_fn consume_sideband,
 		    task_finished_fn task_finished,
 		    void *data)
 {
@@ -1634,6 +1636,7 @@ static void pp_init(struct parallel_processes *pp,
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
 	pp->feed_pipe = feed_pipe ? feed_pipe : default_feed_pipe;
 	pp->task_finished = task_finished ? task_finished : default_task_finished;
+	pp->consume_sideband = consume_sideband;
 
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
@@ -1670,7 +1673,10 @@ static void pp_cleanup(struct parallel_processes *pp)
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	strbuf_write(&pp->buffered_output, stderr);
+	if (pp->consume_sideband)
+		pp->consume_sideband(&pp->buffered_output, pp->data);
+	else
+		strbuf_write(&pp->buffered_output, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1786,9 +1792,13 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 static void pp_output(struct parallel_processes *pp)
 {
 	int i = pp->output_owner;
+
 	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
-		strbuf_write(&pp->children[i].err, stderr);
+		if (pp->consume_sideband)
+			pp->consume_sideband(&pp->children[i].err, pp->data);
+		else
+			strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
 	}
 }
@@ -1827,11 +1837,15 @@ static int pp_collect_finished(struct parallel_processes *pp)
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		} else {
-			strbuf_write(&pp->children[i].err, stderr);
+			/* Output errors, then all other finished child processes */
+			if (pp->consume_sideband) {
+				pp->consume_sideband(&pp->children[i].err, pp->data);
+				pp->consume_sideband(&pp->buffered_output, pp->data);
+			} else {
+				strbuf_write(&pp->children[i].err, stderr);
+				strbuf_write(&pp->buffered_output, stderr);
+			}
 			strbuf_reset(&pp->children[i].err);
-
-			/* Output all other finished child processes */
-			strbuf_write(&pp->buffered_output, stderr);
 			strbuf_reset(&pp->buffered_output);
 
 			/*
@@ -1855,6 +1869,7 @@ int run_processes_parallel(int n,
 			   get_next_task_fn get_next_task,
 			   start_failure_fn start_failure,
 			   feed_pipe_fn feed_pipe,
+			   consume_sideband_fn consume_sideband,
 			   task_finished_fn task_finished,
 			   void *pp_cb)
 {
@@ -1865,7 +1880,7 @@ int run_processes_parallel(int n,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	pp_init(&pp, n, get_next_task, start_failure, feed_pipe, task_finished, pp_cb);
+	pp_init(&pp, n, get_next_task, start_failure, feed_pipe, consume_sideband, task_finished, pp_cb);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1903,6 +1918,7 @@ int run_processes_parallel(int n,
 int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 			       start_failure_fn start_failure,
 			       feed_pipe_fn feed_pipe,
+			       consume_sideband_fn consume_sideband,
 			       task_finished_fn task_finished, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label)
 {
@@ -1912,7 +1928,8 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 				   ((n < 1) ? online_cpus() : n));
 
 	result = run_processes_parallel(n, get_next_task, start_failure,
-					feed_pipe, task_finished, pp_cb);
+					feed_pipe, consume_sideband,
+					task_finished, pp_cb);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
 
diff --git a/run-command.h b/run-command.h
index e058c0e2c8..2ad8271f56 100644
--- a/run-command.h
+++ b/run-command.h
@@ -450,6 +450,20 @@ typedef int (*feed_pipe_fn)(struct strbuf *pipe,
 			    void *pp_cb,
 			    void *pp_task_cb);
 
+/**
+ * If this callback is provided, instead of collating process output to stderr,
+ * they will be collated into a new pipe. consume_sideband_fn will be called
+ * repeatedly. When output is available on that pipe, it will be contained in
+ * 'output'. But it will be called with an empty 'output' too, to allow for
+ * keepalives or similar operations if necessary.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel.
+ *
+ * Since this callback is provided with the collated output, no task cookie is
+ * provided.
+ */
+typedef void (*consume_sideband_fn)(struct strbuf *output, void *pp_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -485,10 +499,12 @@ int run_processes_parallel(int n,
 			   get_next_task_fn,
 			   start_failure_fn,
 			   feed_pipe_fn,
+			   consume_sideband_fn,
 			   task_finished_fn,
 			   void *pp_cb);
 int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
-			       feed_pipe_fn, task_finished_fn, void *pp_cb,
+			       feed_pipe_fn, consume_sideband_fn,
+			       task_finished_fn, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label);
 
 #endif
diff --git a/submodule.c b/submodule.c
index 953f41818c..215bff22d9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1638,7 +1638,7 @@ int fetch_populated_submodules(struct repository *r,
 	run_processes_parallel_tr2(max_parallel_jobs,
 				   get_next_submodule,
 				   fetch_start_failure,
-				   NULL,
+				   NULL, NULL,
 				   fetch_finish,
 				   &spf,
 				   "submodule", "parallel/fetch");
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 9348184d30..d53db6d11c 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -51,6 +51,16 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
+static void test_consume_sideband(struct strbuf *output, void *cb)
+{
+	FILE *sideband;
+
+	sideband = fopen("./sideband", "a");
+
+	strbuf_write(output, sideband);
+	fclose(sideband);
+}
+
 static int task_finished(int result,
 			 struct strbuf *err,
 			 void *pp_cb,
@@ -201,7 +211,7 @@ static int testsuite(int argc, const char **argv)
 		suite.tests.nr, max_jobs);
 
 	ret = run_processes_parallel(max_jobs, next_test, test_failed,
-				     test_stdin, test_finished, &suite);
+				     test_stdin, NULL, test_finished, &suite);
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
@@ -429,23 +439,28 @@ int cmd__run_command(int argc, const char **argv)
 
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, NULL, &proc));
+					    NULL, NULL, NULL, NULL, &proc));
 
 	if (!strcmp(argv[1], "run-command-abort"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, task_finished, &proc));
+					    NULL, NULL, NULL, task_finished, &proc));
 
 	if (!strcmp(argv[1], "run-command-no-jobs"))
 		exit(run_processes_parallel(jobs, no_job,
-					    NULL, NULL, task_finished, &proc));
+					    NULL, NULL, NULL, task_finished, &proc));
 
 	if (!strcmp(argv[1], "run-command-stdin")) {
 		proc.in = -1;
 		proc.no_stdin = 0;
 		exit (run_processes_parallel(jobs, parallel_next, NULL,
-					     test_stdin, NULL, &proc));
+					     test_stdin, NULL, NULL, &proc));
 	}
 
+	if (!strcmp(argv[1], "run-command-sideband"))
+		exit(run_processes_parallel(jobs, parallel_next, NULL, NULL,
+					    test_consume_sideband, NULL,
+					    &proc));
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 3eb572e6cd..c5a5b6df6c 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -143,6 +143,13 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command can divert output' '
+	test_when_finished rm sideband &&
+	test-tool run-command run-command-sideband 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_must_be_empty actual &&
+	test_cmp expect sideband
+'
+
 cat >expect <<-EOF
 preloaded output of a child
 listening for stdin:
-- 
2.28.0.rc0.142.g3c755180ce-goog

