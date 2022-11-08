Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F050BC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiKHSmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKHSmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:42:21 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98751EAC7
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:42:19 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c7-20020a170903234700b0018729febd96so11730774plh.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMNLWZfPj6vsTp6+ALJfFkGBMyKCWALQeo2lsroj8+c=;
        b=EwBlWs99Q6gGbDndFLDpvlgh1QTP6IS+6g+6ReYfxPRfpWBFpBHdXyihSrU26M+XNQ
         YAQ+qWVC9BP+F2AcEsKoRiMTH3+db8IZXkgwkpQBnp54I1HvzEex1IYplUJqAhStRTav
         KM9KujpqepJt3Wythoh5xIYfjV026ksl3TrP1ZlzOZU7PIUZmqXKBMAUk8aAjHC4ijbX
         LqoTvy9/10qqegCJBzwWJuXWlN7z98zS54RDSzzxd9kfIzDNpTQ9g0Won2sOaDPOLo7q
         VNEJFspKdwOnsuQ3Gq2N5SjZhRsyd0seovLZcXy1RI10o484wrJaVJ6pEkEcH1lkDDo6
         jG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMNLWZfPj6vsTp6+ALJfFkGBMyKCWALQeo2lsroj8+c=;
        b=wxCOYP1KMNL3K4EiXgMlOInnVeRSN5jw73egug6V+c3Te+h0d8BEgHCzB/NpqDjsPz
         rabQXq+ynOBfku5GQ7uPGEQyC92duyLBeWZRPOzAOclFWF/BPoS8UVVfbh5NppZsdMrc
         pD9tt3yUKxy3pCg2YNE865khOxMWTj5n/nFmI1xflClefOLqOi/UxQi1SFM8ZX4uUYyJ
         0urMOyxCuYvavaWNIIHJ1ilU0Rs3rJ+P/mwfhnjlPAIkHOrCLDiRHINNWS8G6HXklsqT
         cL8bdrqVp+TJkMqmP7v/2P9HTkoIMipRuiGPHI+fUub8EnQ4zECg4js2G5TGDQ08LhP0
         nQQw==
X-Gm-Message-State: ACrzQf1KXxioCo32mlFNFQ6v6uAMnrU1YIzJMXOsf7VOxGSUKtAOf8DK
        9A0RScv14DcX50pYZogUjQ1YESRAaMPTTcNeNgHtGf2qCeuPled2k/f4wYzBFuCulL/WeNuqY/P
        Zc/HFKpP04kgAiMHXBNe/AZE7fuVS7I9lbhOzU/Sc3pIgHJU8VbyizQy7RM+USbLX+A==
X-Google-Smtp-Source: AMsMyM5a94dly9xrMhZ51HrKeuR3i1/5D4q8A7lVcHn9Vh8bDvtFxP8SvhZFQeWKJ57rQ62P6Zcq5+iDCGDqdmw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:d30c:b0:213:1035:f914 with SMTP
 id p12-20020a17090ad30c00b002131035f914mr75627036pju.196.1667932939319; Tue,
 08 Nov 2022 10:42:19 -0800 (PST)
Date:   Tue,  8 Nov 2022 18:41:56 +0000
In-Reply-To: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108184200.2813458-2-calvinwan@google.com>
Subject: [PATCH v4 1/5] run-command: add duplicate_output_fn to run_processes_parallel_opts
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, myriamanis@google.com
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
 run-command.c               | 13 +++++++++++--
 run-command.h               | 24 +++++++++++++++++++++++
 t/helper/test-run-command.c | 21 ++++++++++++++++++++
 t/t0061-run-command.sh      | 39 +++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index c772acd743..b8f430eb03 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1560,6 +1560,9 @@ static void pp_init(struct parallel_processes *pp,
 
 	if (!opts->get_next_task)
 		BUG("you need to specify a get_next_task function");
+	
+	if (opts->duplicate_output && opts->ungroup)
+		BUG("duplicate_output and ungroup are incompatible with each other");
 
 	CALLOC_ARRAY(pp->children, n);
 	if (!opts->ungroup)
@@ -1680,8 +1683,14 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 	for (size_t i = 0; i < opts->processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
-			int n = strbuf_read_once(&pp->children[i].err,
-						 pp->children[i].process.err, 0);
+			struct strbuf buf = STRBUF_INIT;
+			int n = strbuf_read_once(&buf, pp->children[i].process.err, 0);
+			strbuf_addbuf(&pp->children[i].err, &buf);
+			if (opts->duplicate_output)
+				opts->duplicate_output(&buf, &pp->children[i].err,
+					  opts->data,
+					  pp->children[i].data);
+			strbuf_release(&buf);
 			if (n == 0) {
 				close(pp->children[i].process.err);
 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
diff --git a/run-command.h b/run-command.h
index e3e1ea01ad..dd6d6a86c2 100644
--- a/run-command.h
+++ b/run-command.h
@@ -440,6 +440,24 @@ typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * This callback is called whenever output from a child process is buffered
+ * 
+ * "struct strbuf *process_out" contains the output from the child process
+ * 
+ * See run_processes_parallel() below for a discussion of the "struct
+ * strbuf *out" parameter.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel,
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ *
+ * This function is incompatible with "ungroup"
+ */
+typedef void (*duplicate_output_fn)(struct strbuf *process_out,
+				    struct strbuf *out,
+				    void *pp_cb,
+				    void *pp_task_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -493,6 +511,12 @@ struct run_process_parallel_opts
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
index 3ecb830f4a..40dd329e02 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -52,6 +52,21 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
+static void duplicate_output(struct strbuf *process_out,
+			struct strbuf *out,
+			void *pp_cb,
+			void *pp_task_cb)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	string_list_split(&list, process_out->buf, '\n', -1);
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
index 7b5423eebd..130aec7c68 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -134,6 +134,15 @@ test_expect_success 'run_command runs in parallel with more jobs available than
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
@@ -145,6 +154,15 @@ test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
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
@@ -156,6 +174,15 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
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
@@ -176,6 +203,12 @@ test_expect_success 'run_command is asked to abort gracefully' '
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
@@ -191,6 +224,12 @@ test_expect_success 'run_command outputs ' '
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
2.38.1.431.g37b22c650d-goog

