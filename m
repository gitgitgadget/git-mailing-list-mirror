Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B5ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 23:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIVXaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 19:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIVXaM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 19:30:12 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE575498
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:10 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id ev16-20020a17090aead000b00202cf672e74so5636334pjb.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=vsXH8eS7uXf5Gge0xiJaLe4TwS8CdLF4whLMgHRoL84=;
        b=gmJ367xKb0iWR+L81hZuPfWEmHkGKlpBTCwPQMaVPjol5S4akCISUeV3re7HhxxhxF
         htdpqWLc33svYH2ajoz6QfFaKijw6U8Tj9meT+ThTM/CoBfGHoWPC406fXj+0BXbf72w
         4tn5gbihuE5HiTLJabLbseOvbjrJQ9n5a/X84Nw3WL4cZfdui/U4AG7GYEfB/NfxacWk
         sSsecetWElQ/5C5taLW84Gn7NkDkhBmFdPiNwgRNcPwqfQ2rN71MGwqBzeC3YoFKU8mh
         0JDCVg8yC7qrhTQfZekd8C11x4tlwBmNr8QQe0GFqbv6ZoHFn1+pYtkXo/assE7w0qF/
         7OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=vsXH8eS7uXf5Gge0xiJaLe4TwS8CdLF4whLMgHRoL84=;
        b=Dstd342OoHtjBcCJz/1+gMFNefyg3SpSvNYc0VWySnsuoE5asWF3JklGJI0EAcmWxj
         sBr7vgckKOLS/q2MU/0Z0qfqzC7qFNJn5Q5DlAXva6Bm/CO+HjHCkMZqLrhUsQRuaNl0
         emtkRPgXbYvgWGrwopT74THQH45qWkkqIDNU9nkcVbDSdYtwHf2my3slMNUauiNtCSHz
         U1suISpu0+d1wun1v0uwpKCj8s+0GZmI9AeY+9mSDwJ0PJ7LdJlKzYJxWSmJZMwa/Ld2
         r9SaU/8XYfBYwrPvqpbNsVLDfBB/VcOuOPhsbzBDeokJMTofCTitKn56pxb9vlOg3dV/
         tG4A==
X-Gm-Message-State: ACrzQf2qCraAjyB6JWY3cxFVrVvHCyDnE/fN1oa3re+MSrqHkljDwHGy
        6KA9KzsRP/28oHBuh6WCUC66fb2cJ176xw/RcotcE1usdoOVlpCfo8nUqeEy4Yjq/uNbdDhglov
        xHI2Af/bLlmHnYgfo2XYV44EhBlvPms5P6gJchh5gZTKqwuhrO7xOo2Rb/mtect+rIg==
X-Google-Smtp-Source: AMsMyM5ZPAjpg9h+oXLcrX+vUwqZMCLjOE83mynx3lX5GoqFzwRi8fGnEyfGJ5ChK4R+l9bWtPmiJtc83FHlHUQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:aa7:8a49:0:b0:53e:6a9c:9a04 with SMTP id
 n9-20020aa78a49000000b0053e6a9c9a04mr6137035pfa.85.1663889409859; Thu, 22 Sep
 2022 16:30:09 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:29:44 +0000
In-Reply-To: <20220922232947.631309-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922232947.631309-2-calvinwan@google.com>
Subject: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

run_processes_parallel periodically collects output from its child
processes, prints it, and then resets the buffers for each child.
Add run_processes_parallel_pipe_output variable so output can be
collected and fed to task_finished. When set, the function referenced
by task_finished should parse the output of each child process.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 run-command.c               |  6 +++++-
 run-command.h               |  9 +++++++++
 t/helper/test-run-command.c | 31 ++++++++++++++++++++++++++++---
 t/t0061-run-command.sh      | 26 ++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 14f17830f5..893bc1d294 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1474,6 +1474,7 @@ enum child_state {
 };
 
 int run_processes_parallel_ungroup;
+int run_processes_parallel_pipe_output;
 struct parallel_processes {
 	void *data;
 
@@ -1770,10 +1771,12 @@ int run_processes_parallel(int n,
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	int ungroup = run_processes_parallel_ungroup;
+	int pipe_output = run_processes_parallel_pipe_output;
 	struct parallel_processes pp;
 
 	/* unset for the next API user */
 	run_processes_parallel_ungroup = 0;
+	run_processes_parallel_pipe_output = 0;
 
 	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
 		ungroup);
@@ -1800,7 +1803,8 @@ int run_processes_parallel(int n,
 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
 		} else {
 			pp_buffer_stderr(&pp, output_timeout);
-			pp_output(&pp);
+			if (!pipe_output)
+				pp_output(&pp);
 		}
 		code = pp_collect_finished(&pp);
 		if (code) {
diff --git a/run-command.h b/run-command.h
index 0e85e5846a..a5b1d63f49 100644
--- a/run-command.h
+++ b/run-command.h
@@ -483,8 +483,17 @@ typedef int (*task_finished_fn)(int result,
  * "run_processes_parallel_ungroup" to "1" before invoking
  * run_processes_parallel(), it will be set back to "0" as soon as the
  * API reads that setting.
+ * 
+ * If the "pipe_output" option is specified, the output will be piped
+ * to task_finished_fn in the "struct strbuf *out" variable. The output
+ * will still be printed unless the callback resets the strbuf. The
+ * "pipe_output" option can be enabled by setting the global
+ * "run_processes_parallel_pipe_output" to "1" before invoking
+ * run_processes_parallel(), it will be set back to "0" as soon as the
+ * API reads that setting.
  */
 extern int run_processes_parallel_ungroup;
+extern int run_processes_parallel_pipe_output;
 int run_processes_parallel(int n,
 			   get_next_task_fn,
 			   start_failure_fn,
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index c9283b47af..030e533c6b 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -20,6 +20,7 @@
 #include "wildmatch.h"
 #include "gettext.h"
 
+static int pipe_output = 0;
 static int number_callbacks;
 static int parallel_next(struct child_process *cp,
 			 struct strbuf *err,
@@ -52,15 +53,32 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
+static int task_finished_pipe_output(int result,
+			 struct strbuf *err,
+			 void *pp_cb,
+			 void *pp_task_cb)
+{
+	if (err && pipe_output) {
+		fprintf(stderr, "%s", err->buf);
+		strbuf_reset(err);
+	}
+	return 0;
+}
+
 static int task_finished(int result,
 			 struct strbuf *err,
 			 void *pp_cb,
 			 void *pp_task_cb)
 {
-	if (err)
+	if (err) {
 		strbuf_addstr(err, "asking for a quick stop\n");
-	else
+		if (pipe_output) {
+			fprintf(stderr, "%s", err->buf);
+			strbuf_reset(err);
+		}
+	} else {
 		fprintf(stderr, "asking for a quick stop\n");
+	}
 	return 1;
 }
 
@@ -423,13 +441,20 @@ int cmd__run_command(int argc, const char **argv)
 		run_processes_parallel_ungroup = 1;
 	}
 
+	if (!strcmp(argv[1], "--pipe-output")) {
+		argv += 1;
+		argc -= 1;
+		run_processes_parallel_pipe_output = 1;
+		pipe_output = 1;
+	}
+
 	jobs = atoi(argv[2]);
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
 
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, &proc));
+					    NULL, task_finished_pipe_output, &proc));
 
 	if (!strcmp(argv[1], "run-command-abort"))
 		exit(run_processes_parallel(jobs, parallel_next,
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 7b5423eebd..97ca942a74 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -140,6 +140,11 @@ test_expect_success 'run_command runs ungrouped in parallel with more jobs avail
 	test_line_count = 4 err
 '
 
+test_expect_success 'run_command runs pipe_output in parallel with more jobs available than tasks' '
+	test-tool run-command --pipe-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
 	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
@@ -151,6 +156,11 @@ test_expect_success 'run_command runs ungrouped in parallel with as many jobs as
 	test_line_count = 4 err
 '
 
+test_expect_success 'run_command runs pipe_output in parallel with as many jobs as tasks' '
+	test-tool run-command --pipe-output run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
 	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
@@ -162,6 +172,12 @@ test_expect_success 'run_command runs ungrouped in parallel with more tasks than
 	test_line_count = 4 err
 '
 
+test_expect_success 'run_command runs pipe_output in parallel with more tasks than jobs available' '
+	test-tool run-command --pipe-output run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
+
 cat >expect <<-EOF
 preloaded output of a child
 asking for a quick stop
@@ -182,6 +198,11 @@ test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
 	test_line_count = 6 err
 '
 
+test_expect_success 'run_command is asked to abort gracefully (pipe_output)' '
+	test-tool run-command --pipe-output run-command-abort 3 false 2>actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<-EOF
 no further jobs available
 EOF
@@ -197,6 +218,11 @@ test_expect_success 'run_command outputs (ungroup) ' '
 	test_cmp expect err
 '
 
+test_expect_success 'run_command outputs (pipe_output) ' '
+	test-tool run-command --pipe-output run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
 test_trace () {
 	expect="$1"
 	shift
-- 
2.37.3.998.g577e59143f-goog

