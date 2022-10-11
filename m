Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC59C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 23:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJKX0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 19:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJKX0c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 19:26:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C903371718
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 16:26:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id y71-20020a638a4a000000b0046014b2258dso5068318pgd.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ceeTMB+fvef5OOtMwQxHt1ya7sLwCsHHOc9Au/3yZw0=;
        b=LMq5sCjBG1ipU26JEKvpBm8PcFjjdSMBmP3EP7wkfs107NL8urwx9r0KERJCHnh0vj
         bCwTw507UOTVXm4kxVg8+SEJVHbiHxM5kYcW6UsZTzD1hoXKRJIuvjBTtD8pq9xKuXMA
         iwZ4PCuTbCu88b5VWC637AHm1AI/uwOOkiQiv3i/XFaQINOTBxPlMgTXO4VuzCyZBL27
         rIqLrs24l7xCZWmenTOEpsGyiCyzqaTxvXy7IlPASF3BiXvh13u2+me1LPJxkcy7E83o
         X25ks54Iqc5uS2+4QQrC3Jbk0/ecVJptdnF46hnHdo5Cy4/HlHncoqo6m+IiBLQ867If
         z0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ceeTMB+fvef5OOtMwQxHt1ya7sLwCsHHOc9Au/3yZw0=;
        b=W9CD/j0Nh4LXNT/tQt16Xr2UFKOI/wD/dNVI9faM7NchepEkGEyCXa58hJ2OE5sdl/
         EpOu9iImTX1mcDrwlzZ9M8gzYGOBcdk3QCO94rZkHDlESmxzS4CM1X0C9PT69/N8VzBb
         z6sBqHHyvPN3VJ/X7RFVZ4HyOKM51gES+bCZ3Ex9Pj0Tv4G8MFS7mF0cYZeBRssNbGai
         mNowPFra8HEeJz/nNJiqyWpvw6BaKjlevb/K8p5zuLs5mdTCRbtvBWzjvVWp6Jgfie6Z
         flEdiWemDxaY2TGnSqopf0ma+oNW5dTYxNrNhSQtXHJucnUx6oLW5af8zgtwb7XcZoiq
         91xA==
X-Gm-Message-State: ACrzQf0POTDUSpMmXWFxbzIKi1rIQWFJJrAfDLGUiK9skwON4jvA1Zf0
        RArVCbJlwydfkTUnz8zkvzUs0xMQmdmLxStu+AkZC+L2k+irOgL9X/vPlvuT/jOEKM9Cw52vltD
        wfCv8wrvVaqOBuBj+ogEP3X+OIVKneA3BluCFjjREHq8oy3C5EVIF8ZlZhKVVWoNEqw==
X-Google-Smtp-Source: AMsMyM5E21BxzFE8BoqbxSIpzD8Np5RJoB+4mxjo4TwvDc8YRC5T+fFglXCGpO5Yon1mphVbekpkEJHH0+nu4uI=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:1707:b0:562:e790:dfc3 with SMTP
 id h7-20020a056a00170700b00562e790dfc3mr21638075pfc.59.1665530791191; Tue, 11
 Oct 2022 16:26:31 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:26:01 +0000
In-Reply-To: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011232604.839941-2-calvinwan@google.com>
Subject: [PATCH v2 1/4] run-command: add pipe_output_fn to run_processes_parallel_opts
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
piped to the callback function to allow for separate parsing.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 run-command.c               | 12 +++++--
 run-command.h               | 22 +++++++++++++
 t/helper/test-run-command.c | 18 ++++++++++
 t/t0061-run-command.sh      | 65 +++++++++++++++++++++++--------------
 4 files changed, 90 insertions(+), 27 deletions(-)

diff --git a/run-command.c b/run-command.c
index da02631933..c6090e4cb8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1689,12 +1689,16 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 	}
 }
 
-static void pp_output(struct parallel_processes *pp)
+static void pp_output(struct parallel_processes *pp,
+			const struct run_process_parallel_opts *opts)
 {
 	int i = pp->output_owner;
 
 	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
+		if (opts->pipe_output)
+			opts->pipe_output(&pp->children[i].err, pp->data,
+						pp->children[i].data);
 		strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
 	}
@@ -1716,6 +1720,10 @@ static int pp_collect_finished(struct parallel_processes *pp,
 
 		code = finish_command(&pp->children[i].process);
 
+		if (opts->pipe_output)
+			opts->pipe_output(&pp->children[i].err, pp->data,
+						pp->children[i].data);
+
 		if (opts->task_finished)
 			code = opts->task_finished(code, opts->ungroup ? NULL :
 						   &pp->children[i].err, pp->data,
@@ -1803,7 +1811,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
 		} else {
 			pp_buffer_stderr(&pp, output_timeout);
-			pp_output(&pp);
+			pp_output(&pp, opts);
 		}
 		code = pp_collect_finished(&pp, opts);
 		if (code) {
diff --git a/run-command.h b/run-command.h
index 075bd9b9de..cb51c56ea6 100644
--- a/run-command.h
+++ b/run-command.h
@@ -440,6 +440,22 @@ typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * This callback is periodically called while child processes are
+ * running and also when a child process finishes.
+ *
+ * "struct strbuf *out" contains the output collected from pp_task_cb
+ * since the last call of this function.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel,
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ *
+ * This function is incompatible with "ungroup"
+ */
+typedef void (*pipe_output_fn)(struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -493,6 +509,12 @@ struct run_process_parallel_opts
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
index 46bac2bb70..d3c3df7960 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -52,6 +52,18 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
+static void pipe_output(struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cb)
+{
+	fprintf(stderr, "%s", out->buf);
+	/*
+	 * Resetting output to show that piped output would print the
+	 * same as other tests without the pipe_output() function set
+	 */
+	strbuf_reset(out);
+}
+
 static int task_finished(int result,
 			 struct strbuf *err,
 			 void *pp_cb,
@@ -439,6 +451,12 @@ int cmd__run_command(int argc, const char **argv)
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
index 19af082750..feabb3717b 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -129,11 +129,14 @@ Hello
 World
 EOF
 
-test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
-	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
-	test_must_be_empty out &&
-	test_cmp expect err
-'
+for opt in '' '--pipe-output'
+do
+	test_expect_success "run_command runs in parallel with more jobs available than tasks $opt" '
+		test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+		test_must_be_empty out &&
+		test_cmp expect err
+	'
+done
 
 test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
 	test-tool run-command --ungroup run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
@@ -141,11 +144,14 @@ test_expect_success 'run_command runs ungrouped in parallel with more jobs avail
 	test_line_count = 4 err
 '
 
-test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
-	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
-	test_must_be_empty out &&
-	test_cmp expect err
-'
+for opt in '' '--pipe-output'
+do
+	test_expect_success "run_command runs in parallel with as many jobs as tasks $opt" '
+		test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+		test_must_be_empty out &&
+		test_cmp expect err
+	'
+done
 
 test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
 	test-tool run-command --ungroup run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
@@ -153,11 +159,14 @@ test_expect_success 'run_command runs ungrouped in parallel with as many jobs as
 	test_line_count = 4 err
 '
 
-test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
-	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
-	test_must_be_empty out &&
-	test_cmp expect err
-'
+for opt in '' '--pipe-output'
+do
+	test_expect_success "run_command runs in parallel with more tasks than jobs available $opt" '
+		test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+		test_must_be_empty out &&
+		test_cmp expect err
+	'
+done
 
 test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
 	test-tool run-command --ungroup run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
@@ -174,11 +183,14 @@ preloaded output of a child
 asking for a quick stop
 EOF
 
-test_expect_success 'run_command is asked to abort gracefully' '
-	test-tool run-command run-command-abort 3 false >out 2>err &&
-	test_must_be_empty out &&
-	test_cmp expect err
-'
+for opt in '' '--pipe-output'
+do
+	test_expect_success "run_command is asked to abort gracefully $opt" '
+		test-tool run-command run-command-abort 3 false >out 2>err &&
+		test_must_be_empty out &&
+		test_cmp expect err
+	'
+done
 
 test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
 	test-tool run-command --ungroup run-command-abort 3 false >out 2>err &&
@@ -190,11 +202,14 @@ cat >expect <<-EOF
 no further jobs available
 EOF
 
-test_expect_success 'run_command outputs ' '
-	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
-	test_must_be_empty out &&
-	test_cmp expect err
-'
+for opt in '' '--pipe-output'
+do
+	test_expect_success "run_command outputs $opt" '
+		test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+		test_must_be_empty out &&
+		test_cmp expect err
+	'
+done
 
 test_expect_success 'run_command outputs (ungroup) ' '
 	test-tool run-command --ungroup run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
-- 
2.38.0.rc1.362.ged0d419d3c-goog

