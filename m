Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BDAC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJTXZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJTXZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:25:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94FFF8FC
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-368e6c449f2so8680437b3.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLtMtz1HzG6FmW7t66EFkPPB0mWkMRURetxLgwhmnqM=;
        b=QIB5jA5NTo3ANZ6yO8zkONQPpx0REVByiW3MgMEsxyiZ/BU1VHtBra9AHCfFXLFTRv
         rqDuQl0JGj6If9ms3v57+a/pP4Ko1n6oEI4XNgihnnaXJafWXmo3akEx9aTY1uSyE1eG
         wFKGcwUuKvohjmW2dC44fqSTpNLQZdBbP4SCllfpx2lldH2cDdWUFppQFpHKLALj37tj
         gTmQ05GL//uRkotChTItVOcpVicd7WH4n8rTXN2GTmX33kDBhxHJx9qYqRN3esRl/65W
         HOiZq/wfHUeOzq0+7Z7nGFK1N+VcrRu8AEUxpgf5r6dk1sM7ITljD2VCEfkRlGMDxyGy
         UoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLtMtz1HzG6FmW7t66EFkPPB0mWkMRURetxLgwhmnqM=;
        b=DEjT6M7WlUt1+PP3q6eIwJ+MHfgXIO/oKzkv5M9fCrACJ2gfgmbbkvMmqASsTprsDv
         +qB1asj9bxDyq1F5bEEzsVNXn6mE0Ab/AWqIAVV6SObmKVa7GAkLhje7EhHEv9mxAEQy
         e7PGXby9dX/ZClcZk2G7vOhn+VJNwLGRxcjddg4eA16RUcQbtN3AeLioIXIL2N/3s8hz
         fgoXu57k+Kmv7ItDj0x4q48Hf6Nnr630rhA/un4JrGxlmnqtAFcsuLTzkMwkw972f1+z
         9MOi0ydizWFYxHIckPKjL6YolEbgDKadhHqr2wwR72KdSIIMJOzT+pX9iXSl5sMpnyhj
         8ZrQ==
X-Gm-Message-State: ACrzQf2s+1nb+7Tttg8fq5fR7pC7hQybQ42KjDHValG7WiAB91anehU6
        HxFYUkGuY8rIa1XXCVGOH99J1REBA8dJCU7LOotXYT1PpWV+ge3/E0ucs3tkj7QGNCOXvJojKr1
        UgB72Ug9gLDRPbxBjU8uFbJEZsG8aUMY6LapzGbehEDRm97wXeZpZw4SepW7nqJ7OlQ==
X-Google-Smtp-Source: AMsMyM7LFtfkGDVlkzqyYDuptqImIL0nwtA9ELmIEkRxsIjaja6OCTVwk7vHyTLb+yZf7QDFoilNbejfuEbk8zo=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:349:b0:695:9d03:e009 with SMTP
 id e9-20020a056902034900b006959d03e009mr12835369ybs.588.1666308349522; Thu,
 20 Oct 2022 16:25:49 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:25:27 +0000
In-Reply-To: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221020232532.1128326-2-calvinwan@google.com>
Subject: [PATCH v3 1/6] run-command: add pipe_output_fn to run_processes_parallel_opts
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add pipe_output_fn as an optionally set function in
run_process_parallel_opts. If set, output from each child process is
first separately stored in 'out' and then piped to the callback
function when the child process finishes to allow for separate parsing.

Two of the tests check for line count rather than an exact match
since the interleaved output order is not guaranteed to be exactly
the same every run through.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 run-command.c               | 21 +++++++++++++++++++--
 run-command.h               | 21 +++++++++++++++++++++
 t/helper/test-run-command.c | 13 +++++++++++++
 t/t0061-run-command.sh      | 30 ++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index c772acd743..03787bc7f5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1503,6 +1503,7 @@ struct parallel_processes {
 		enum child_state state;
 		struct child_process process;
 		struct strbuf err;
+		struct strbuf out;
 		void *data;
 	} *children;
 	/*
@@ -1560,6 +1561,9 @@ static void pp_init(struct parallel_processes *pp,
 
 	if (!opts->get_next_task)
 		BUG("you need to specify a get_next_task function");
+	
+	if (opts->pipe_output && opts->ungroup)
+		BUG("pipe_output and ungroup are incompatible with each other");
 
 	CALLOC_ARRAY(pp->children, n);
 	if (!opts->ungroup)
@@ -1567,6 +1571,8 @@ static void pp_init(struct parallel_processes *pp,
 
 	for (size_t i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
+		if (opts->pipe_output)
+			strbuf_init(&pp->children[i].out, 0);
 		child_process_init(&pp->children[i].process);
 		if (pp->pfd) {
 			pp->pfd[i].events = POLLIN | POLLHUP;
@@ -1586,6 +1592,7 @@ static void pp_cleanup(struct parallel_processes *pp,
 	trace_printf("run_processes_parallel: done");
 	for (size_t i = 0; i < opts->processes; i++) {
 		strbuf_release(&pp->children[i].err);
+		strbuf_release(&pp->children[i].out);
 		child_process_clear(&pp->children[i].process);
 	}
 
@@ -1680,8 +1687,12 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 	for (size_t i = 0; i < opts->processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
-			int n = strbuf_read_once(&pp->children[i].err,
-						 pp->children[i].process.err, 0);
+			struct strbuf buf = STRBUF_INIT;
+			int n = strbuf_read_once(&buf, pp->children[i].process.err, 0);
+			strbuf_addbuf(&pp->children[i].err, &buf);
+			if (opts->pipe_output)
+				strbuf_addbuf(&pp->children[i].out, &buf);
+			strbuf_release(&buf);
 			if (n == 0) {
 				close(pp->children[i].process.err);
 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
@@ -1717,6 +1728,12 @@ static int pp_collect_finished(struct parallel_processes *pp,
 		if (i == opts->processes)
 			break;
 
+		if (opts->pipe_output) {
+			opts->pipe_output(&pp->children[i].out, opts->data,
+					  pp->children[i].data);
+			strbuf_reset(&pp->children[i].out);
+		}
+
 		code = finish_command(&pp->children[i].process);
 
 		if (opts->task_finished)
diff --git a/run-command.h b/run-command.h
index e3e1ea01ad..b4584c3698 100644
--- a/run-command.h
+++ b/run-command.h
@@ -440,6 +440,21 @@ typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * This callback is called on every child process that finished processing.
+ * 
+ * "struct strbuf *process_out" contains the output from the finished child
+ * process.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel,
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ *
+ * This function is incompatible with "ungroup"
+ */
+typedef void (*pipe_output_fn)(struct strbuf *process_out,
+			       void *pp_cb,
+			       void *pp_task_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -493,6 +508,12 @@ struct run_process_parallel_opts
 	 */
 	start_failure_fn start_failure;
 
+	/**
+	 * pipe_output: See pipe_output_fn() above. This should be
+	 * NULL unless process specific output is needed
+	 */
+	pipe_output_fn pipe_output;
+
 	/**
 	 * task_finished: See task_finished_fn() above. This can be
 	 * NULL to omit any special handling.
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3ecb830f4a..e9b41419a0 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -52,6 +52,13 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
+static void pipe_output(struct strbuf *process_out,
+			void *pp_cb,
+			void *pp_task_cb)
+{
+	fprintf(stderr, "%s", process_out->buf);
+}
+
 static int task_finished(int result,
 			 struct strbuf *err,
 			 void *pp_cb,
@@ -439,6 +446,12 @@ int cmd__run_command(int argc, const char **argv)
 		opts.ungroup = 1;
 	}
 
+	if (!strcmp(argv[1], "--pipe-output")) {
+		argv += 1;
+		argc -= 1;
+		opts.pipe_output = pipe_output;
+	}
+
 	jobs = atoi(argv[2]);
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 7b5423eebd..e50e57db89 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -134,6 +134,12 @@ test_expect_success 'run_command runs in parallel with more jobs available than
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with more jobs available than tasks --pipe-output' '
+	test-tool run-command --pipe-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_line_count = 20 err
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
 	test-tool run-command --ungroup run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -145,6 +151,12 @@ test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with as many jobs as tasks --pipe-output' '
+	test-tool run-command --pipe-output run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_line_count = 20 err
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
 	test-tool run-command --ungroup run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -156,6 +168,12 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with more tasks than jobs available --pipe-output' '
+	test-tool run-command --pipe-output run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_line_count = 20 err
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
 	test-tool run-command --ungroup run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -176,6 +194,12 @@ test_expect_success 'run_command is asked to abort gracefully' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command is asked to abort gracefully --pipe-output' '
+	test-tool run-command --pipe-output run-command-abort 3 false >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
 test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
 	test-tool run-command --ungroup run-command-abort 3 false >out 2>err &&
 	test_must_be_empty out &&
@@ -191,6 +215,12 @@ test_expect_success 'run_command outputs ' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command outputs --pipe-output' '
+	test-tool run-command --pipe-output run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
 test_expect_success 'run_command outputs (ungroup) ' '
 	test-tool run-command --ungroup run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_must_be_empty out &&
-- 
2.38.0.135.g90850a2211-goog

