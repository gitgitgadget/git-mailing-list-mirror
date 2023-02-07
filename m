Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4B1C6379F
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjBGSSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjBGSRe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:34 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F3EB71
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:17:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5261de2841fso110457767b3.7
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUpIJZH3ue95F84uqowtHCl+qgA9d0kRegn+UN/ED78=;
        b=IOknm6hlGm7nvrBM6PP8rNVgh8vZtKWcm5Axm0cICbhp5QReQfs7E/j61dnKcFctm0
         xKMC100q0onlxq4XEzLzwE3Y8XB6hBzKa+YKEADiXMUs9hk0odXS2vv2lVZ+Y7Q5amnx
         aV09w9lO+GSMf86SglqTJ4HZNr2dC3DfQd3uw7ey+F1RnMQ4YTMwlJ1iLSP54rceF2KM
         3SOrjncKWNJi3Jg3tkorCyxKPkDOJipE7sf/gu8SJlko/Um7oEBPCV2yUE/C18qyV675
         cgBbqlYkNQbP6c1OPnaBpdr7yueFaaoexG1uGvNoktNS9POaRDM94xDpXv4p0YeStKdW
         lTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUpIJZH3ue95F84uqowtHCl+qgA9d0kRegn+UN/ED78=;
        b=xF7mxSPO+rRihUGZ++U7pGdWNqm8FMXG/8r1J7x2xePxht7IcDQIy0/2BRBsOjJSqJ
         1Y4oPxWE6CYPiqsgbL3Ycf1eUM5TdkcazIYM969CXkzjR9EYOdo/3QvheSAcOPH15pXc
         V5mT08G2/1CPd9sX52hrfgYZYtnxSVXAfKzRPjXkpUXzJQFP1957vbpCbdF8iPE+HV+9
         YBEOe5rnHaRAZ5/v7iGNp9A3WCihgvAvWzh8dILVbcrWTtdblPO3iWaVoqYAVGHeicFu
         wv9IuleB7ZZH2gnxg+3ktdw9E6nsCZilsuI3+Kkavr6r6Z0PVq3AaDNrM9Xo7it98Juc
         gd/Q==
X-Gm-Message-State: AO0yUKWH1+ESNTYVCLzQhPa/C+qaWt+mZLsMxlyQSjX4Q8uLDMTxK5lI
        O/miFBvql2bCaVQ9XvyDu23Dt/krbP+GNod2SKQ8KSnbXCds76UQGv5oRotJMh+AWqqGjyJaRKg
        hMa+ytIZUlPri5Us2sjYMopG5EM1lPpp4iHNckXzBZt1SifHEmRlSG6piSORi7Ajvdw==
X-Google-Smtp-Source: AK7set93r17bqz4gAbqtHp9NLXuH2bnCKYeTTQCZ+1j5Ui4aFg2zEOEDvPjeK5Gi2nGJ/jnmT3F3Nan31w/saY8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a5b:c12:0:b0:8b6:a289:24a6 with SMTP id
 f18-20020a5b0c12000000b008b6a28924a6mr129953ybq.569.1675793836947; Tue, 07
 Feb 2023 10:17:16 -0800 (PST)
Date:   Tue,  7 Feb 2023 18:17:00 +0000
In-Reply-To: <20230117193041.708692-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207181706.363453-2-calvinwan@google.com>
Subject: [PATCH v7 1/7] run-command: add duplicate_output_fn to run_processes_parallel_opts
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add duplicate_output_fn as an optionally set function in
run_process_parallel_opts. If set, output from each child process is
copied and passed to the callback function whenever output from the
child process is buffered to allow for separate parsing.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 run-command.c               | 16 ++++++++++++---
 run-command.h               | 27 +++++++++++++++++++++++++
 t/helper/test-run-command.c | 21 ++++++++++++++++++++
 t/t0061-run-command.sh      | 39 +++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 756f1839aa..cad88befe0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1526,6 +1526,9 @@ static void pp_init(struct parallel_processes *pp,
 	if (!opts->get_next_task)
 		BUG("you need to specify a get_next_task function");
 
+	if (opts->duplicate_output && opts->ungroup)
+		BUG("duplicate_output and ungroup are incompatible with each other");
+
 	CALLOC_ARRAY(pp->children, n);
 	if (!opts->ungroup)
 		CALLOC_ARRAY(pp->pfd, n);
@@ -1645,14 +1648,21 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 	for (size_t i = 0; i < opts->processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
-			int n = strbuf_read_once(&pp->children[i].err,
-						 pp->children[i].process.err, 0);
+			ssize_t n = strbuf_read_once(&pp->children[i].err,
+						     pp->children[i].process.err, 0);
 			if (n == 0) {
 				close(pp->children[i].process.err);
 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
-			} else if (n < 0)
+			} else if (n < 0) {
 				if (errno != EAGAIN)
 					die_errno("read");
+			} else {
+				if (opts->duplicate_output)
+					opts->duplicate_output(&pp->children[i].err,
+					       strlen(pp->children[i].err.buf) - n,
+					       opts->data,
+					       pp->children[i].data);
+			}
 		}
 	}
 }
diff --git a/run-command.h b/run-command.h
index 072db56a4d..6dcf999f6c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -408,6 +408,27 @@ typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * This callback is called whenever output from a child process is buffered
+ * 
+ * See run_processes_parallel() below for a discussion of the "struct
+ * strbuf *out" parameter.
+ * 
+ * The offset refers to the number of bytes originally in "out" before
+ * the output from the child process was buffered. Therefore, the buffer
+ * range, "out + buf" to the end of "out", would contain the buffer of
+ * the child process output.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel,
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ *
+ * This function is incompatible with "ungroup"
+ */
+typedef void (*duplicate_output_fn)(struct strbuf *out,
+				    size_t offset,
+				    void *pp_cb,
+				    void *pp_task_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -461,6 +482,12 @@ struct run_process_parallel_opts
 	 */
 	start_failure_fn start_failure;
 
+	/**
+	 * duplicate_output: See duplicate_output_fn() above. This should be
+	 * NULL unless process specific output is needed
+	 */
+	duplicate_output_fn duplicate_output;
+
 	/**
 	 * task_finished: See task_finished_fn() above. This can be
 	 * NULL to omit any special handling.
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3ecb830f4a..ffd3cd0045 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -52,6 +52,21 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
+static void duplicate_output(struct strbuf *out,
+			size_t offset,
+			void *pp_cb UNUSED,
+			void *pp_task_cb UNUSED)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	string_list_split(&list, out->buf + offset, '\n', -1);
+	for (size_t i = 0; i < list.nr; i++) {
+		if (strlen(list.items[i].string) > 0)
+			fprintf(stderr, "duplicate_output: %s\n", list.items[i].string);
+	}
+	string_list_clear(&list, 0);
+}
+
 static int task_finished(int result,
 			 struct strbuf *err,
 			 void *pp_cb,
@@ -439,6 +454,12 @@ int cmd__run_command(int argc, const char **argv)
 		opts.ungroup = 1;
 	}
 
+	if (!strcmp(argv[1], "--duplicate-output")) {
+		argv += 1;
+		argc -= 1;
+		opts.duplicate_output = duplicate_output;
+	}
+
 	jobs = atoi(argv[2]);
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index e2411f6a9b..879e536638 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -135,6 +135,15 @@ test_expect_success 'run_command runs in parallel with more jobs available than
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with more jobs available than tasks --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test 4 = $(grep -c "duplicate_output: Hello" err) &&
+	test 4 = $(grep -c "duplicate_output: World" err) &&
+	sed "/duplicate_output/d" err > err1 &&
+	test_cmp expect err1
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
 	test-tool run-command --ungroup run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -147,6 +156,15 @@ test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with as many jobs as tasks --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test 4 = $(grep -c "duplicate_output: Hello" err) &&
+	test 4 = $(grep -c "duplicate_output: World" err) &&
+	sed "/duplicate_output/d" err > err1 &&
+	test_cmp expect err1
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
 	test-tool run-command --ungroup run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -159,6 +177,15 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs in parallel with more tasks than jobs available --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test 4 = $(grep -c "duplicate_output: Hello" err) &&
+	test 4 = $(grep -c "duplicate_output: World" err) &&
+	sed "/duplicate_output/d" err > err1 &&
+	test_cmp expect err1
+'
+
 test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
 	test-tool run-command --ungroup run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_line_count = 8 out &&
@@ -180,6 +207,12 @@ test_expect_success 'run_command is asked to abort gracefully' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command is asked to abort gracefully --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-abort 3 false >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
 test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
 	test-tool run-command --ungroup run-command-abort 3 false >out 2>err &&
 	test_must_be_empty out &&
@@ -196,6 +229,12 @@ test_expect_success 'run_command outputs ' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command outputs --duplicate-output' '
+	test-tool run-command --duplicate-output run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
 test_expect_success 'run_command outputs (ungroup) ' '
 	test-tool run-command --ungroup run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
 	test_must_be_empty out &&
-- 
2.39.1.519.gcb327c4b5f-goog

