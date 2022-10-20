Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766D3C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJTXZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJTXZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:25:52 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D11114DD1
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s13-20020a170902ea0d00b00183243c7a0fso472324plg.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIdV0eGQf08L4kmatnCvCzSClEB7YL7MPWJoBttP+6s=;
        b=XJ7DQZQgkVdkHwgnyjQe/O+CNg5av+GZ7aQhwQhqq/QE5JN4/mBgYwAcrsSsDodDsW
         BgMCmKkL15rctFnPYTkAaSq3/ufWNbN3sHjRMWs3xMvpi7oSzRZ8nXOueLOx5GSqasBk
         Fm8Sw3ypzBdwecPJI2nF6pcitJmYNS7vEKYqIQwgIOiM1KX2AmENayNAqY30zKUhX2Ec
         Y+si5s9eWgHZBMz1QlCXig1ElqLFli+not3cYktpxfoUEdvDinfjCOewB4SNJ2eUxoV0
         xQ8e/5rhWw13S9lyVJSsI8f3YQaHZ8JxS8sg/8VtIBEKHbyZoOOf6YxhwLfT6KI0FJc9
         ANWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIdV0eGQf08L4kmatnCvCzSClEB7YL7MPWJoBttP+6s=;
        b=4oOuUCeyFigBjDOwH6joJyfqKky62V9JlSdpnZBoMTKwQHHB0a1Khtu7d4kBld0vDr
         ajBP7ClS6Ah7Vf9VLRaG+yTTXkA5XHhIjJLmo/GNT2Ubiyx302I5lI7wLDR9GbUMOwmQ
         HoZ1DeLlc4uTJLLywoJTL9BnVvNExmCa8RjEWLaMCl8jCyxUz52/5+XpTnQLi/hnjd7U
         hM5QVvqUQDYdumfWnP3wEkWgVklOvVae4V2+5Os1ygQFH0kbOlIOnEPyEPW8Pq4d1c3E
         rz7zvomtOxbhJNcrPOijzDit3+1umrXX2360r6CTl/ApQ4xagGyLR+wMxeNiPkPnTdMo
         ujXQ==
X-Gm-Message-State: ACrzQf17xfir8dosDcD9Br3TLOh0C82Hc3uZIScIl9VuRzKCpvr0ZFtk
        VCLisj4n9mubskB9LX/UucZ5o3oKYD4VugWF0Jod8enW9WNeuKqbL6XT2tVNeIyI0hFsAHj1ieo
        ljdk03m4u4JbeZXWApHn7xm5OjNQVKbUtc500sKheZ+PGFDwHUNYu9HQAI8lL8VCb6g==
X-Google-Smtp-Source: AMsMyM7Jt1HiD27ufMKpabtrOe8AYgz5j71YwQe8bGbYP4Iwffn7F5VMBhVLUCpK+5OxQlpza56KOJyBX2rDDQQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:ef4c:b0:186:6399:6b48 with SMTP
 id e12-20020a170902ef4c00b0018663996b48mr5574039plx.128.1666308351227; Thu,
 20 Oct 2022 16:25:51 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:25:28 +0000
In-Reply-To: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221020232532.1128326-3-calvinwan@google.com>
Subject: [PATCH v3 2/6] run-command: add hide_output to run_processes_parallel_opts
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Output from child processes and callbacks may not be necessary to
print out for every invoker of run_processes_parallel. Add
hide_output as an option to not print said output.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 run-command.c               | 8 +++++---
 run-command.h               | 9 +++++++++
 t/helper/test-run-command.c | 6 ++++++
 t/t0061-run-command.sh      | 6 ++++++
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 03787bc7f5..3aa28ad6dc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1603,7 +1603,8 @@ static void pp_cleanup(struct parallel_processes *pp,
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	strbuf_write(&pp->buffered_output, stderr);
+	if (!opts->hide_output)
+		strbuf_write(&pp->buffered_output, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1754,7 +1755,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			pp->pfd[i].fd = -1;
 		child_process_init(&pp->children[i].process);
 
-		if (opts->ungroup) {
+		if (opts->ungroup || opts->hide_output) {
 			; /* no strbuf_*() work to do here */
 		} else if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
@@ -1826,7 +1827,8 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
 		} else {
 			pp_buffer_stderr(&pp, opts, output_timeout);
-			pp_output(&pp);
+			if (!opts->hide_output)
+				pp_output(&pp);
 		}
 		code = pp_collect_finished(&pp, opts);
 		if (code) {
diff --git a/run-command.h b/run-command.h
index b4584c3698..4570812c08 100644
--- a/run-command.h
+++ b/run-command.h
@@ -496,6 +496,11 @@ struct run_process_parallel_opts
 	 */
 	unsigned int ungroup:1;
 
+	/**
+	 * hide_output: see 'hide_output' in run_processes_parallel() below.
+	 */
+	unsigned int hide_output:1;
+
 	/**
 	 * get_next_task: See get_next_task_fn() above. This must be
 	 * specified.
@@ -547,6 +552,10 @@ struct run_process_parallel_opts
  * NULL "struct strbuf *out" parameter, and are responsible for
  * emitting their own output, including dealing with any race
  * conditions due to writing in parallel to stdout and stderr.
+ * 
+ * If the "hide_output" option is set, any output in the "struct strbuf
+ * *out" parameter will not be printed by this function. This includes
+ * output from child processes as well as callbacks.
  */
 void run_processes_parallel(const struct run_process_parallel_opts *opts);
 
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index e9b41419a0..1af443db4d 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -446,6 +446,12 @@ int cmd__run_command(int argc, const char **argv)
 		opts.ungroup = 1;
 	}
 
+	if (!strcmp(argv[1], "--hide-output")) {
+		argv += 1;
+		argc -= 1;
+		opts.hide_output = 1;
+	}
+
 	if (!strcmp(argv[1], "--pipe-output")) {
 		argv += 1;
 		argc -= 1;
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index e50e57db89..a0219f6093 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -180,6 +180,12 @@ test_expect_success 'run_command runs ungrouped in parallel with more tasks than
 	test_line_count = 4 err
 '
 
+test_expect_success 'run_command hides output when run in parallel' '
+	test-tool run-command --hide-output run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err
+'
+
 cat >expect <<-EOF
 preloaded output of a child
 asking for a quick stop
-- 
2.38.0.135.g90850a2211-goog

