Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682D7C433FE
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 12:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378537AbiDTMas (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 08:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbiDTMar (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 08:30:47 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9E28980
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 05:28:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 21so2090746edv.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pS9wIHjBDqftkygR3I4TjlUGEYT6m1d/kFDNbJ8iIPk=;
        b=nQ4Gqfu8PHVAttlT6NGrM37Hd8+PobPILm74wHMIQzQIYvIl1Vgut+oP3UK+Td3Mbn
         7BqkS+3v10wWSAr4wze7drJk8rXfuC8X/3l63+agP7Vc3fCT41a1lMd2MKvCUxRmPXIi
         pME24b58mbp6RxZRiziQLSAqTuNfKyJmgwJHT9OJpVDrWEm0AqxOP2BzoBrnl6z4ZMo5
         r5yFJ841cFTivufiBJbAQWMXH10QjJxWVaBRoyzgUaJ/ftTxvl7YPk4pF5NpAcDx/s0+
         x0yZUMNPapK8L3Q5IP/H1b4We7BWAPjpUCti6/nBe1PIQsPOPU79zPfNxRROaHvC2b+U
         ql7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pS9wIHjBDqftkygR3I4TjlUGEYT6m1d/kFDNbJ8iIPk=;
        b=oxLlLw7+yODEApCPiBCknpD4aGRReztAXXoBIEXBYAa4+W/QRBloj+I4o5zxt4puWB
         P+A3X67R0xgoeb+w9bvfxre/sAg8UMliCYanEPi0ElEj4Y9q9C74ZHVylH23BW4tCHuY
         QUj34GijW1JC3qr2IpGoCcx8VfMVm/w17q1lxYLkNg8UkxlGxNMkMFZ+H5DWmvNNvASu
         kK+bHfVcaIbkbZIogHD/3hf3CrMPzJefGqFonhVdaTUbBwyWE71tAoOGDKbD95UgRewp
         x668/b1U8XQYyq7wgmMDbxErNF0t/2f+cEUIbHGtZoV03SReOVctJi551UK8tEu2jPX+
         bCtQ==
X-Gm-Message-State: AOAM533CfP40MrnhoX57ysJknedfQ29A5doxyJTinfkzoLTEIqvHGEUe
        z5kQYMMJV/HdRzgPAaHth9A=
X-Google-Smtp-Source: ABdhPJzEfpcQDm6rCAE8QISxGocPl9QM5rIlKNTRfGvDKtPC1v1hyUqyT0G0ApQpoxeDurzaT8SAMw==
X-Received: by 2002:aa7:cc02:0:b0:411:487e:36fe with SMTP id q2-20020aa7cc02000000b00411487e36femr22965561edt.338.1650457678462;
        Wed, 20 Apr 2022 05:27:58 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p24-20020a1709061b5800b006e88dfea127sm6660044ejg.3.2022.04.20.05.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 05:27:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nh9R7-007JUx-6V;
        Wed, 20 Apr 2022 14:27:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
Date:   Wed, 20 Apr 2022 14:25:15 +0200
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
 <Yl9Hn0C0TwalASC0@google.com>
 <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
Message-ID: <220420.86wnfk6isy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 20 2022, Phillip Wood wrote:

> Hi Emily
>
> On 20/04/2022 00:37, Emily Shaffer wrote:
>> On Tue, Apr 19, 2022 at 02:59:36PM -0400, Anthony Sottile wrote:
>>> [...]
>> Interesting. I'm surprised to see the tty-ness of hooks changing with
>> this patch, as the way the hook is called is pretty much the same:
>> run_hook_ve() ("the old way") sets no_stdin, stdout_to_stderr, args,
>> envvars, and some trace variables, and then runs 'run_command()';
>> run_command() invokes start_command().
>> run_hooks_opt ("the new way") ultimately kicks off the hook with a
>> callback that sets up a child_process with no_stdin, stdout_to_stderr,
>> args, envvars, and some trace variables (hook.c:pick_next_hook); the
>> task queue manager also sets .err to -1 on that child_process; then it
>> calls start_command() directly (run-command.c:pp_start_one()).
>> I'm not sure I see why the tty-ness would change between the two. If
>> I'm
>> being honest, I'm actually slightly surprised that `isatty` returned
>> true for your hook before - since the hook process is a child of Git and
>> its output is, presumably, being consumed by Git first rather than by an
>> interactive user shell.
>> I suppose that with stdout_to_stderr being set, the tty-ness of the
>> main
>> process's stderr would then apply to the child process's stdout (we do
>> that by calling `dup(2)`). But that's being set in both "the old way"
>> and "the new way", so I'm pretty surprised to see a change here.
>>
>> It *is* true that run-command.c:pp_start_one() sets child_process:err=-1
>> for the child and run-command.c:run_hook_ve() didn't do that; that -1
>> means that start_command() will create a new fd for the child's stderr.
>> Since run_hook_ve() didn't care about the child's stderr before, I
>> wonder if that is why? Could it be that now that we're processing the
>> child's stderr, the child no longer thinks stderr is in tty, because the
>> parent is consuming its output?
>
> Exactly, stderr is redirected to a pipe so that we can buffer the
> output from each process and then write it to the real stdout when the
> process has finished to avoid the output from different processes
> getting mixed together. Ideally in this case we'd see that stdout is a
> tty and create a pty rather than a pipe when buffering the output from
> the process.

All: I have a fix for this, currently CI-ing, testing etc. Basically it
just adds an option to run_process_parallel() to stop doing the
stdout/stderr interception.

It means that for the current jobs=1 we'll behave as before.

For jobs >1 in the future we'll need to decide what we want to do,
i.e. you can have TTY, or guaranteed non-interleaved output, but not
both.

I'd think for hooks no interception makes sense, but in any case we can
defer that until sometime later...

Preview of the fix below, this is on top of an earlier change to add the
"struct run_process_parallel_opts" to pass such options along:

diff --git a/hook.c b/hook.c
index eadb2d58a7b..1f20e5db447 100644
--- a/hook.c
+++ b/hook.c
@@ -126,6 +126,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 	struct run_process_parallel_opts run_opts = {
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
+		.no_buffering = 1,
 	};
 
 	if (!options)
diff --git a/run-command.c b/run-command.c
index 2383375ee07..0f9d84433ad 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1604,7 +1604,7 @@ static void pp_cleanup(struct parallel_processes *pp)
  * <0 no new job was started, user wishes to shutdown early. Use negative code
  *    to signal the children.
  */
-static int pp_start_one(struct parallel_processes *pp)
+static int pp_start_one(struct parallel_processes *pp, const int no_buffering)
 {
 	int i, code;
 
@@ -1623,9 +1623,12 @@ static int pp_start_one(struct parallel_processes *pp)
 		strbuf_reset(&pp->children[i].err);
 		return 1;
 	}
-	pp->children[i].process.err = -1;
-	pp->children[i].process.stdout_to_stderr = 1;
-	pp->children[i].process.no_stdin = 1;
+
+	if (!no_buffering) {
+		pp->children[i].process.err = -1;
+		pp->children[i].process.stdout_to_stderr = 1;
+		pp->children[i].process.no_stdin = 1;
+	}
 
 	if (start_command(&pp->children[i].process)) {
 		code = pp->start_failure(&pp->children[i].err,
@@ -1681,12 +1684,17 @@ static void pp_output(struct parallel_processes *pp)
 	}
 }
 
-static int pp_collect_finished(struct parallel_processes *pp)
+static int pp_collect_finished(struct parallel_processes *pp,
+			       const int no_buffering)
 {
 	int i, code;
 	int n = pp->max_processes;
 	int result = 0;
 
+	if (no_buffering)
+		for (i = 0; i < pp->max_processes; i++)
+			pp->children[i].state = GIT_CP_WAIT_CLEANUP;
+
 	while (pp->nr_processes > 0) {
 		for (i = 0; i < pp->max_processes; i++)
 			if (pp->children[i].state == GIT_CP_WAIT_CLEANUP)
@@ -1741,7 +1749,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 static int run_processes_parallel_1(int n, get_next_task_fn get_next_task,
 				    start_failure_fn start_failure,
 				    task_finished_fn task_finished,
-				    void *pp_cb)
+				    void *pp_cb, const int no_buffering)
 {
 	int i, code;
 	int output_timeout = 100;
@@ -1754,7 +1762,7 @@ static int run_processes_parallel_1(int n, get_next_task_fn get_next_task,
 		    i < spawn_cap && !pp.shutdown &&
 		    pp.nr_processes < pp.max_processes;
 		    i++) {
-			code = pp_start_one(&pp);
+			code = pp_start_one(&pp, no_buffering);
 			if (!code)
 				continue;
 			if (code < 0) {
@@ -1765,9 +1773,11 @@ static int run_processes_parallel_1(int n, get_next_task_fn get_next_task,
 		}
 		if (!pp.nr_processes)
 			break;
-		pp_buffer_stderr(&pp, output_timeout);
-		pp_output(&pp);
-		code = pp_collect_finished(&pp);
+		if (!no_buffering) {
+			pp_buffer_stderr(&pp, output_timeout);
+			pp_output(&pp);
+		}
+		code = pp_collect_finished(&pp, no_buffering);
 		if (code) {
 			pp.shutdown = 1;
 			if (code < 0)
@@ -1783,7 +1793,8 @@ static int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 				      start_failure_fn start_failure,
 				      task_finished_fn task_finished,
 				      void *pp_cb, const char *tr2_category,
-				      const char *tr2_label)
+				      const char *tr2_label,
+				      const int no_buffering)
 {
 	int result;
 
@@ -1791,7 +1802,7 @@ static int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 				   ((n < 1) ? online_cpus() : n));
 
 	result = run_processes_parallel_1(n, get_next_task, start_failure,
-					  task_finished, pp_cb);
+					  task_finished, pp_cb, no_buffering);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
 
@@ -1803,6 +1814,8 @@ int run_processes_parallel(int n, get_next_task_fn get_next_task,
 			   task_finished_fn task_finished, void *pp_cb,
 			   struct run_process_parallel_opts *opts)
 {
+	const int no_buffering = opts && opts->no_buffering;
+
 	if (!opts)
 		goto no_opts;
 
@@ -1811,12 +1824,13 @@ int run_processes_parallel(int n, get_next_task_fn get_next_task,
 		return run_processes_parallel_tr2(n, get_next_task,
 						  start_failure, task_finished,
 						  pp_cb, opts->tr2_category,
-						  opts->tr2_label);
+						  opts->tr2_label,
+						  no_buffering);
 	}
 
 no_opts:
 	return run_processes_parallel_1(n, get_next_task, start_failure,
-					task_finished, pp_cb);
+					task_finished, pp_cb, no_buffering);
 }
 
 
diff --git a/run-command.h b/run-command.h
index 9ec57a25de4..062eff81e17 100644
--- a/run-command.h
+++ b/run-command.h
@@ -463,11 +463,17 @@ typedef int (*task_finished_fn)(int result,
  *
  * tr2_category & tr2_label: sets the trace2 category and label for
  * logging. These must either be unset, or both of them must be set.
+ *
+ * no_buffering: Don't redirect stderr to stdout, and don't "buffer"
+ * the output of the N children started. The output will not be
+ * deterministic and may be interleaved, but we won't interfere with
+ * the connection to the TTY.
  */
 struct run_process_parallel_opts
 {
 	const char *tr2_category;
 	const char *tr2_label;
+	unsigned int no_buffering:1;
 };
 
 /**
@@ -477,7 +483,8 @@ struct run_process_parallel_opts
  *
  * The children started via this function run in parallel. Their output
  * (both stdout and stderr) is routed to stderr in a manner that output
- * from different tasks does not interleave.
+ * from different tasks does not interleave. This can be disabled by setting
+ * "no_buffering" in "struct run_process_parallel_opts".
  *
  * start_failure_fn and task_finished_fn can be NULL to omit any
  * special handling.
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index ee281909bc3..fb6ad0bf4f7 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -130,7 +130,7 @@ World
 EOF
 
 test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
-	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >actual 2>&1 &&
 	test_cmp expect actual
 '
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 26ed5e11bc8..c0eda4e9237 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -4,6 +4,7 @@ test_description='git-hook command'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook &&
@@ -120,4 +121,49 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	test_cmp expect actual
 '
 
+test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDOUT redirect' '
+	rm -rf .git &&
+	test_when_finished "rm -rf .git" &&
+	git init . &&
+
+	test_hook pre-commit <<-EOF &&
+	{
+		test -t 1 && echo STDOUT TTY || echo STDOUT NO TTY &&
+		test -t 2 && echo STDERR TTY || echo STDERR NO TTY
+	} >actual
+	EOF
+
+	test_commit A &&
+	test_commit B &&
+	git reset --soft HEAD^ &&
+	cat >expect <<-\EOF &&
+	STDOUT NO TTY
+	STDERR TTY
+	EOF
+	test_terminal git commit -m"msg" &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDERR redirect' '
+	test_when_finished "rm -rf .git" &&
+	git init . &&
+
+	test_hook pre-commit <<-EOF &&
+	{
+		test -t 1 && echo >&2 STDOUT TTY || echo >&2 STDOUT NO TTY &&
+		test -t 2 && echo >&2 STDERR TTY || echo >&2 STDERR NO TTY
+	} 2>actual
+	EOF
+
+	test_commit A &&
+	test_commit B &&
+	git reset --soft HEAD^ &&
+	cat >expect <<-\EOF &&
+	STDOUT TTY
+	STDERR NO TTY
+	EOF
+	test_terminal git commit -m"msg" &&
+	test_cmp expect actual
+'
+
 test_done
