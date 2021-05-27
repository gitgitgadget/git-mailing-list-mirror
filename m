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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90C0C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831E0613CD
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhE0ALU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhE0ALA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:00 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C5C06138F
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:26 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d3-20020a0cdb030000b029021313001eeeso2365010qvk.15
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X5Ci3i4EAIEdram3u8mM7KNJ47PQuBSwRytFYjIp628=;
        b=RTV/fgv+i49+192AQzUPSGTfXBWvvzWIsF3632X2SRVstgdMAQr01E8wKYwsn/IVJV
         uCupEe6w22/Kigc29a8J6G6/fITq61CbeRkvmkIxIKjXW0g9xbRttK/1itccvYPXdrAz
         3lJsP3RQtwdlPM2ISdGqOK6POX98kaOszB3K42oCqX3sa0PPgTNZHsaVQROKjiakUbxt
         JVgQdR7FQwK6FqkSkdFuFP462CGBg2KNVCUtL7HuD5nHc7m9JGtLLZsJF/HV/T3o6beB
         drg4wDXXHO60yasWdAKwoYgR0pSMwsWUuu4QqL4sOLvDAvokpzdkOsWC0davAPGDaoOA
         I92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X5Ci3i4EAIEdram3u8mM7KNJ47PQuBSwRytFYjIp628=;
        b=JmL2YZ9/r/G35CZ4/n5pSoND2HvD+ozxEJCwNgq/ROLcOlDLXmypXhkopGfqBT8dhE
         V6g0vTkZsbNY7eyJwm4gY1tUiorb+SvKT8upFq0JFCn0VOmS3s4NM5yX1VNub3qGFkWU
         qu+PhYG0DUOzId9ciMfp9Ovzze6DzGH4p8HR4BZUuAanecLXbhic6sU0JdQW9STwXjFl
         eKLsGFVV7SSlsDfFsPJqH/o5YyNFpkG7RTETF3mpH4rX7HVtdyBbn1ldCSkfzbs5BGsx
         blq0LblU2GrsdzQnsDKP7yjA91ID6QJkZ+sislFMbRNcY7MHLbU09zkZV0SKtR2lYhkt
         tyVQ==
X-Gm-Message-State: AOAM532YKWFO4Bnz5wcr1MElHalNdppbort3I+cHClKATG2zcRhmQySJ
        k/Teq3QqReSHD61AOZysF/Twnfgm9sCuO773jMiYbUT2HeGnGX8QMigr3c72yYA7DjxteghRe6z
        LiYrPlZ3cLgfHinbts+T4whcNYdsrthe6UDWuNvUQhs0V6U4NoXZzCV3EhvvPFQ0Sj32yIQIGhg
        ==
X-Google-Smtp-Source: ABdhPJy0uKrXAl17MdO2FcX/QOKiE+QR9CoHL1xbuvFeyc47grfSIwbs8ZpKMGdAMaCLhgEpiiZmiR/EibYqxq5bpdo=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:e1ca:: with SMTP id
 v10mr512836qvl.47.1622074166092; Wed, 26 May 2021 17:09:26 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:32 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 13/37] run-command: add stdin callback for parallelization
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user of the run_processes_parallel() API wants to pipe a large
amount of information to stdin of each parallel command, that
information could exceed the buffer of the pipe allocated for that
process's stdin.  Generally this is solved by repeatedly writing to
child_process.in between calls to start_command() and finish_command();
run_processes_parallel() did not provide users an opportunity to access
child_process at that time.

Because the data might be extremely large (for example, a list of all
refs received during a push from a client) simply taking a string_list
or strbuf is not as scalable as using a callback; the rest of the
run_processes_parallel() API also uses callbacks, so making this feature
match the rest of the API reduces mental load on the user.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/fetch.c             |  1 +
 builtin/submodule--helper.c |  2 +-
 hook.c                      |  1 +
 run-command.c               | 54 +++++++++++++++++++++++++++++++++++--
 run-command.h               | 17 +++++++++++-
 submodule.c                 |  1 +
 t/helper/test-run-command.c | 31 ++++++++++++++++++---
 t/t0061-run-command.sh      | 30 +++++++++++++++++++++
 8 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index dfde96a435..a07816b650 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1817,6 +1817,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 		result = run_processes_parallel_tr2(max_children,
 						    &fetch_next_remote,
 						    &fetch_failed_to_start,
+						    NULL,
 						    &fetch_finished,
 						    &state,
 						    "fetch", "parallel/fetch");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..8d1e731073 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2295,7 +2295,7 @@ static int update_submodules(struct submodule_update_clone *suc)
 	int i;
 
 	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
+				   update_clone_start_failure, NULL,
 				   update_clone_task_finished, suc, "submodule",
 				   "parallel/update");
 
diff --git a/hook.c b/hook.c
index 920563607d..1fa7976583 100644
--- a/hook.c
+++ b/hook.c
@@ -402,6 +402,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
+				   NULL,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/run-command.c b/run-command.c
index 5237984ebe..6dd33caa57 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1558,6 +1558,7 @@ struct parallel_processes {
 
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
+	feed_pipe_fn feed_pipe;
 	task_finished_fn task_finished;
 
 	struct {
@@ -1585,6 +1586,13 @@ static int default_start_failure(struct strbuf *out,
 	return 0;
 }
 
+static int default_feed_pipe(struct strbuf *pipe,
+			     void *pp_cb,
+			     void *pp_task_cb)
+{
+	return 1;
+}
+
 static int default_task_finished(int result,
 				 struct strbuf *out,
 				 void *pp_cb,
@@ -1615,6 +1623,7 @@ static void pp_init(struct parallel_processes *pp,
 		    int n,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
+		    feed_pipe_fn feed_pipe,
 		    task_finished_fn task_finished,
 		    void *data)
 {
@@ -1633,6 +1642,7 @@ static void pp_init(struct parallel_processes *pp,
 	pp->get_next_task = get_next_task;
 
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
+	pp->feed_pipe = feed_pipe ? feed_pipe : default_feed_pipe;
 	pp->task_finished = task_finished ? task_finished : default_task_finished;
 
 	pp->nr_processes = 0;
@@ -1730,6 +1740,37 @@ static int pp_start_one(struct parallel_processes *pp)
 	return 0;
 }
 
+static void pp_buffer_stdin(struct parallel_processes *pp)
+{
+	int i;
+	struct strbuf sb = STRBUF_INIT;
+
+	/* Buffer stdin for each pipe. */
+	for (i = 0; i < pp->max_processes; i++) {
+		if (pp->children[i].state == GIT_CP_WORKING &&
+		    pp->children[i].process.in > 0) {
+			int done;
+			strbuf_reset(&sb);
+			done = pp->feed_pipe(&sb, pp->data,
+					      pp->children[i].data);
+			if (sb.len) {
+				if (write_in_full(pp->children[i].process.in,
+					      sb.buf, sb.len) < 0) {
+					if (errno != EPIPE)
+						die_errno("write");
+					done = 1;
+				}
+			}
+			if (done) {
+				close(pp->children[i].process.in);
+				pp->children[i].process.in = 0;
+			}
+		}
+	}
+
+	strbuf_release(&sb);
+}
+
 static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 {
 	int i;
@@ -1794,6 +1835,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		pp->nr_processes--;
 		pp->children[i].state = GIT_CP_FREE;
 		pp->pfd[i].fd = -1;
+		pp->children[i].process.in = 0;
 		child_process_init(&pp->children[i].process);
 
 		if (i != pp->output_owner) {
@@ -1827,6 +1869,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 int run_processes_parallel(int n,
 			   get_next_task_fn get_next_task,
 			   start_failure_fn start_failure,
+			   feed_pipe_fn feed_pipe,
 			   task_finished_fn task_finished,
 			   void *pp_cb)
 {
@@ -1835,7 +1878,9 @@ int run_processes_parallel(int n,
 	int spawn_cap = 4;
 	struct parallel_processes pp;
 
-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	pp_init(&pp, n, get_next_task, start_failure, feed_pipe, task_finished, pp_cb);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1852,6 +1897,7 @@ int run_processes_parallel(int n,
 		}
 		if (!pp.nr_processes)
 			break;
+		pp_buffer_stdin(&pp);
 		pp_buffer_stderr(&pp, output_timeout);
 		pp_output(&pp);
 		code = pp_collect_finished(&pp);
@@ -1863,11 +1909,15 @@ int run_processes_parallel(int n,
 	}
 
 	pp_cleanup(&pp);
+
+	sigchain_pop(SIGPIPE);
+
 	return 0;
 }
 
 int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 			       start_failure_fn start_failure,
+			       feed_pipe_fn feed_pipe,
 			       task_finished_fn task_finished, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label)
 {
@@ -1877,7 +1927,7 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 				   ((n < 1) ? online_cpus() : n));
 
 	result = run_processes_parallel(n, get_next_task, start_failure,
-					task_finished, pp_cb);
+					feed_pipe, task_finished, pp_cb);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
 
diff --git a/run-command.h b/run-command.h
index d08414a92e..1e3cf0999f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -443,6 +443,20 @@ typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * This callback is called repeatedly on every child process who requests
+ * start_command() to create a pipe by setting child_process.in < 0.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel, and
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ * The contents of 'send' will be read into the pipe and passed to the pipe.
+ *
+ * Return nonzero to close the pipe.
+ */
+typedef int (*feed_pipe_fn)(struct strbuf *pipe,
+			    void *pp_cb,
+			    void *pp_task_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -477,10 +491,11 @@ typedef int (*task_finished_fn)(int result,
 int run_processes_parallel(int n,
 			   get_next_task_fn,
 			   start_failure_fn,
+			   feed_pipe_fn,
 			   task_finished_fn,
 			   void *pp_cb);
 int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
-			       task_finished_fn, void *pp_cb,
+			       feed_pipe_fn, task_finished_fn, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label);
 
 #endif
diff --git a/submodule.c b/submodule.c
index 0b1d9c1dde..ea026a8195 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1645,6 +1645,7 @@ int fetch_populated_submodules(struct repository *r,
 	run_processes_parallel_tr2(max_parallel_jobs,
 				   get_next_submodule,
 				   fetch_start_failure,
+				   NULL,
 				   fetch_finish,
 				   &spf,
 				   "submodule", "parallel/fetch");
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 7ae03dc712..9348184d30 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -32,8 +32,13 @@ static int parallel_next(struct child_process *cp,
 		return 0;
 
 	strvec_pushv(&cp->args, d->argv);
+	cp->in = d->in;
+	cp->no_stdin = d->no_stdin;
 	strbuf_addstr(err, "preloaded output of a child\n");
 	number_callbacks++;
+
+	*task_cb = xmalloc(sizeof(int));
+	*(int*)(*task_cb) = 2;
 	return 1;
 }
 
@@ -55,6 +60,17 @@ static int task_finished(int result,
 	return 1;
 }
 
+static int test_stdin(struct strbuf *pipe, void *cb, void *task_cb)
+{
+	int *lines_remaining = task_cb;
+
+	if (*lines_remaining)
+		strbuf_addf(pipe, "sample stdin %d\n", --(*lines_remaining));
+
+	return !(*lines_remaining);
+}
+
+
 struct testsuite {
 	struct string_list tests, failed;
 	int next;
@@ -185,7 +201,7 @@ static int testsuite(int argc, const char **argv)
 		suite.tests.nr, max_jobs);
 
 	ret = run_processes_parallel(max_jobs, next_test, test_failed,
-				     test_finished, &suite);
+				     test_stdin, test_finished, &suite);
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
@@ -413,15 +429,22 @@ int cmd__run_command(int argc, const char **argv)
 
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, &proc));
+					    NULL, NULL, NULL, &proc));
 
 	if (!strcmp(argv[1], "run-command-abort"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, task_finished, &proc));
+					    NULL, NULL, task_finished, &proc));
 
 	if (!strcmp(argv[1], "run-command-no-jobs"))
 		exit(run_processes_parallel(jobs, no_job,
-					    NULL, task_finished, &proc));
+					    NULL, NULL, task_finished, &proc));
+
+	if (!strcmp(argv[1], "run-command-stdin")) {
+		proc.in = -1;
+		proc.no_stdin = 0;
+		exit (run_processes_parallel(jobs, parallel_next, NULL,
+					     test_stdin, NULL, &proc));
+	}
 
 	fprintf(stderr, "check usage\n");
 	return 1;
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 7d599675e3..87759482ad 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -143,6 +143,36 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
+cat >expect <<-EOF
+preloaded output of a child
+listening for stdin:
+sample stdin 1
+sample stdin 0
+preloaded output of a child
+listening for stdin:
+sample stdin 1
+sample stdin 0
+preloaded output of a child
+listening for stdin:
+sample stdin 1
+sample stdin 0
+preloaded output of a child
+listening for stdin:
+sample stdin 1
+sample stdin 0
+EOF
+
+test_expect_success 'run_command listens to stdin' '
+	write_script stdin-script <<-\EOF &&
+	echo "listening for stdin:"
+	while read line; do
+		echo "$line"
+	done
+	EOF
+	test-tool run-command run-command-stdin 2 ./stdin-script 2>actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<-EOF
 preloaded output of a child
 asking for a quick stop
-- 
2.31.1.818.g46aad6cb9e-goog

