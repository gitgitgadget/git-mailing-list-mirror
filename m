Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CC9C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 23:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353271AbiD1XaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 19:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiD1XaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 19:30:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8BBBCB5D
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 16:26:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d23-20020a17090a115700b001d2bde6c234so6706858pje.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 16:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iMIM9gzbCekz57KcIzd8mTSaqyc2f18aZXf/IWMWR60=;
        b=b2/2b4vWk1cEyAURwJVFj1LWJoBalO5BetXfpaRpP0xeoRH9GOgMkLPc4ucwipRkwk
         hMlN7kakvLWKm3YT7uPgRt5zfPOtWUkChiiK34ggR8h+XsUwM8Mh9jqgiqMuqqpkN1Rl
         vURFSShniQvB16uo5vc/tLbrkkD9LLDgPDSGfX5xqTpmMZTPyxvgvT+FOU+CvS4KSHgf
         xF//MH/ah1d8YpEw8wZFyJVwHKFonABLkP55ctxfE64i8vh39Ygseq+uUxXgbuXcjqGp
         o6998loey9ahM9we6aYZFFiICZvJa/eqcbQbjCZKgz1MeeSs0Irfo1NhS6nwO1HUcpSG
         mxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iMIM9gzbCekz57KcIzd8mTSaqyc2f18aZXf/IWMWR60=;
        b=Ky6u9fe//jrWZBqXdMmSuRo6/1kL3oDtvI4dMIjVV3CbIioyAAwvj9yx1LRGzIzp7K
         j+1bkmK2539+r9HUMyRbVtW9sXU7hn+C+oVda6uSebamdyJJyXVG92lEE+ToU0UWOK+c
         73FgDbzssSAe1U6DEgSLkzrzzmaNOCMLJ065gcPSRefZNWRUEq1iskHd9g8VfGP9DM+L
         dVTsxn6jJWuDsTA5hIfDdyNOVqcQVtAJNS3HmWhWRssE2qJNV28KLlRtB89XlmU4ufe5
         dvB3N6pyldTWGGWDG1qh3uErdfwBEvfSUL1Bgk8ukP+v4FuMkL6YC4VnjRwGgPgiVxvZ
         CYIA==
X-Gm-Message-State: AOAM5303f9dBi8JXm6/kgpk0BnvzglLwhQK+oRJ357Cf5q+4FfuzUd6d
        7OGzY4bcL3to82PULLePP0P0Rlcd78lUog==
X-Google-Smtp-Source: ABdhPJyNyhDTkWlqYwFyY3Fui/l6bLYZmsNYte1Y63IXFpqXl/26dxTl9hG9QbpBFOAO9+cqYpHdlg==
X-Received: by 2002:a17:902:9b92:b0:158:9b65:a78 with SMTP id y18-20020a1709029b9200b001589b650a78mr36210160plp.53.1651188409755;
        Thu, 28 Apr 2022 16:26:49 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e691:b08d:17b1:1270])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090a6f8100b001d5c571f487sm8336732pjk.25.2022.04.28.16.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 16:26:48 -0700 (PDT)
Date:   Thu, 28 Apr 2022 16:26:42 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 3/6] run-command: add an "ungroup" option to
 run_process_parallel()
Message-ID: <YmsisnOwekVUdDEd@google.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
 <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <patch-3.6-d76f63c2948-20220421T122108Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.6-d76f63c2948-20220421T122108Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 02:25:28PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Extend the parallel execution API added in c553c72eed6 (run-command:
> add an asynchronous parallel child processor, 2015-12-15) to support a
> mode where the stdout and stderr of the processes isn't captured and
> output in a deterministic order, instead we'll leave it to the kernel
> and stdio to sort it out.
> 
> This gives the API same functionality as GNU parallel's --ungroup
> option. As we'll see in a subsequent commit the main reason to want
> this is to support stdout and stderr being connected to the TTY in the
> case of jobs=1, demonstrated here with GNU parallel:
> 
> 	$ parallel --ungroup 'test -t {} && echo TTY || echo NTTY' ::: 1 2
> 	TTY
> 	TTY
> 	$ parallel 'test -t {} && echo TTY || echo NTTY' ::: 1 2
> 	NTTY
> 	NTTY
> 
> Another is as GNU parallel's documentation notes a potential for
> optimization. Our results will be a bit different, but in cases where
> you want to run processes in parallel where the exact order isn't
> important this can be a lot faster:
> 
> 	$ hyperfine -r 3 -L o ,--ungroup 'parallel {o} seq ::: 10000000 >/dev/null '
> 	Benchmark 1: parallel  seq ::: 10000000 >/dev/null
> 	  Time (mean ± σ):     220.2 ms ±   9.3 ms    [User: 124.9 ms, System: 96.1 ms]
> 	  Range (min … max):   212.3 ms … 230.5 ms    3 runs
> 
> 	Benchmark 2: parallel --ungroup seq ::: 10000000 >/dev/null
> 	  Time (mean ± σ):     154.7 ms ±   0.9 ms    [User: 136.2 ms, System: 25.1 ms]
> 	  Range (min … max):   153.9 ms … 155.7 ms    3 runs
> 
> 	Summary
> 	  'parallel --ungroup seq ::: 10000000 >/dev/null ' ran
> 	    1.42 ± 0.06 times faster than 'parallel  seq ::: 10000000 >/dev/null '
> 
> A large part of the juggling in the API is to make the API safer for
> its maintenance and consumers alike.
> 
> For the maintenance of the API we e.g. avoid malloc()-ing the
> "pp->pfd", ensuring that SANITIZE=address and other similar tools will
> catch any unexpected misuse.
> 
> For API consumers we take pains to never pass the non-NULL "out"
> buffer to an API user that provided the "ungroup" option. The
> resulting code in t/helper/test-run-command.c isn't typical of such a
> user, i.e. they'd typically use one mode or the other, and would know
> whether they'd provided "ungroup" or not.

Interesting! It is separate from whether there are >1 jobs in the task
queue. I like that approach - but I do also think we could set ungroup
opportunistically if the task list has only one entry or the job number
is 1, no? I'd like to see that, too. I guess that we can't really tell
how many tasks are available (because it's a callback, not a list) but
setting ungroup if jobs=1 sounds like a reasonable improvement to me.

Otherwise, this patch's code is very straightforward and looks fine.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  run-command.c               | 95 ++++++++++++++++++++++++++++---------
>  run-command.h               | 32 +++++++++----
>  t/helper/test-run-command.c | 31 +++++++++---
>  t/t0061-run-command.sh      | 30 ++++++++++++
>  4 files changed, 151 insertions(+), 37 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 7b8159aa235..873de21ffaf 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1468,7 +1468,7 @@ int pipe_command(struct child_process *cmd,
>  enum child_state {
>  	GIT_CP_FREE,
>  	GIT_CP_WORKING,
> -	GIT_CP_WAIT_CLEANUP,
> +	GIT_CP_WAIT_CLEANUP, /* only for !ungroup */
>  };
>  
>  struct parallel_processes {
> @@ -1494,6 +1494,7 @@ struct parallel_processes {
>  	struct pollfd *pfd;
>  
>  	unsigned shutdown : 1;
> +	unsigned ungroup:1;
>  
>  	int output_owner;
>  	struct strbuf buffered_output; /* of finished children */
> @@ -1537,8 +1538,9 @@ static void pp_init(struct parallel_processes *pp,
>  		    get_next_task_fn get_next_task,
>  		    start_failure_fn start_failure,
>  		    task_finished_fn task_finished,
> -		    void *data)
> +		    void *data, struct run_process_parallel_opts *opts)
>  {
> +	const int ungroup = opts->ungroup;
>  	int i;
>  
>  	if (n < 1)
> @@ -1556,16 +1558,22 @@ static void pp_init(struct parallel_processes *pp,
>  	pp->start_failure = start_failure ? start_failure : default_start_failure;
>  	pp->task_finished = task_finished ? task_finished : default_task_finished;
>  
> +	pp->ungroup = ungroup;
> +
>  	pp->nr_processes = 0;
>  	pp->output_owner = 0;
>  	pp->shutdown = 0;
>  	CALLOC_ARRAY(pp->children, n);
> -	CALLOC_ARRAY(pp->pfd, n);
> +	if (!ungroup)
> +		CALLOC_ARRAY(pp->pfd, n);
> +
>  	strbuf_init(&pp->buffered_output, 0);
>  
>  	for (i = 0; i < n; i++) {
>  		strbuf_init(&pp->children[i].err, 0);
>  		child_process_init(&pp->children[i].process);
> +		if (ungroup)
> +			continue;
>  		pp->pfd[i].events = POLLIN | POLLHUP;
>  		pp->pfd[i].fd = -1;
>  	}
> @@ -1576,6 +1584,7 @@ static void pp_init(struct parallel_processes *pp,
>  
>  static void pp_cleanup(struct parallel_processes *pp)
>  {
> +	const int ungroup = pp->ungroup;
>  	int i;
>  
>  	trace_printf("run_processes_parallel: done");
> @@ -1585,14 +1594,17 @@ static void pp_cleanup(struct parallel_processes *pp)
>  	}
>  
>  	free(pp->children);
> -	free(pp->pfd);
> +	if (!ungroup)
> +		free(pp->pfd);
>  
>  	/*
>  	 * When get_next_task added messages to the buffer in its last
>  	 * iteration, the buffered output is non empty.
>  	 */
> -	strbuf_write(&pp->buffered_output, stderr);
> -	strbuf_release(&pp->buffered_output);
> +	if (!ungroup) {
> +		strbuf_write(&pp->buffered_output, stderr);
> +		strbuf_release(&pp->buffered_output);
> +	}
>  
>  	sigchain_pop_common();
>  }
> @@ -1606,6 +1618,7 @@ static void pp_cleanup(struct parallel_processes *pp)
>   */
>  static int pp_start_one(struct parallel_processes *pp)
>  {
> +	const int ungroup = pp->ungroup;
>  	int i, code;
>  
>  	for (i = 0; i < pp->max_processes; i++)
> @@ -1615,24 +1628,31 @@ static int pp_start_one(struct parallel_processes *pp)
>  		BUG("bookkeeping is hard");
>  
>  	code = pp->get_next_task(&pp->children[i].process,
> -				 &pp->children[i].err,
> +				 ungroup ? NULL : &pp->children[i].err,
>  				 pp->data,
>  				 &pp->children[i].data);
>  	if (!code) {
> -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> -		strbuf_reset(&pp->children[i].err);
> +		if (!ungroup) {
> +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> +			strbuf_reset(&pp->children[i].err);
> +		}
>  		return 1;
>  	}
> -	pp->children[i].process.err = -1;
> -	pp->children[i].process.stdout_to_stderr = 1;
> -	pp->children[i].process.no_stdin = 1;
> +
> +	if (!ungroup) {
> +		pp->children[i].process.err = -1;
> +		pp->children[i].process.stdout_to_stderr = 1;
> +		pp->children[i].process.no_stdin = 1;
> +	}
>  
>  	if (start_command(&pp->children[i].process)) {
> -		code = pp->start_failure(&pp->children[i].err,
> +		code = pp->start_failure(ungroup ? NULL : &pp->children[i].err,
>  					 pp->data,
>  					 pp->children[i].data);
> -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> -		strbuf_reset(&pp->children[i].err);
> +		if (!ungroup) {
> +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> +			strbuf_reset(&pp->children[i].err);
> +		}
>  		if (code)
>  			pp->shutdown = 1;
>  		return code;
> @@ -1640,14 +1660,26 @@ static int pp_start_one(struct parallel_processes *pp)
>  
>  	pp->nr_processes++;
>  	pp->children[i].state = GIT_CP_WORKING;
> -	pp->pfd[i].fd = pp->children[i].process.err;
> +	if (!ungroup)
> +		pp->pfd[i].fd = pp->children[i].process.err;
>  	return 0;
>  }
>  
> +static void pp_mark_working_for_cleanup(struct parallel_processes *pp)
> +{
> +	int i;
> +
> +	for (i = 0; i < pp->max_processes; i++)
> +		if (pp->children[i].state == GIT_CP_WORKING)
> +			pp->children[i].state = GIT_CP_WAIT_CLEANUP;
> +}
> +
>  static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>  {
>  	int i;
>  
> +	assert(!pp->ungroup);
> +
>  	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
>  		if (errno == EINTR)
>  			continue;
> @@ -1674,6 +1706,9 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>  static void pp_output(struct parallel_processes *pp)
>  {
>  	int i = pp->output_owner;
> +
> +	assert(!pp->ungroup);
> +
>  	if (pp->children[i].state == GIT_CP_WORKING &&
>  	    pp->children[i].err.len) {
>  		strbuf_write(&pp->children[i].err, stderr);
> @@ -1683,10 +1718,15 @@ static void pp_output(struct parallel_processes *pp)
>  
>  static int pp_collect_finished(struct parallel_processes *pp)
>  {
> +	const int ungroup = pp->ungroup;
>  	int i, code;
>  	int n = pp->max_processes;
>  	int result = 0;
>  
> +	if (ungroup)
> +		for (i = 0; i < pp->max_processes; i++)
> +			pp->children[i].state = GIT_CP_WAIT_CLEANUP;
> +
>  	while (pp->nr_processes > 0) {
>  		for (i = 0; i < pp->max_processes; i++)
>  			if (pp->children[i].state == GIT_CP_WAIT_CLEANUP)
> @@ -1697,8 +1737,8 @@ static int pp_collect_finished(struct parallel_processes *pp)
>  		code = finish_command(&pp->children[i].process);
>  
>  		code = pp->task_finished(code,
> -					 &pp->children[i].err, pp->data,
> -					 pp->children[i].data);
> +					 ungroup ? NULL : &pp->children[i].err,
> +					 pp->data, pp->children[i].data);
>  
>  		if (code)
>  			result = code;
> @@ -1707,10 +1747,13 @@ static int pp_collect_finished(struct parallel_processes *pp)
>  
>  		pp->nr_processes--;
>  		pp->children[i].state = GIT_CP_FREE;
> -		pp->pfd[i].fd = -1;
> +		if (!ungroup)
> +			pp->pfd[i].fd = -1;
>  		child_process_init(&pp->children[i].process);
>  
> -		if (i != pp->output_owner) {
> +		if (ungroup) {
> +			/* no strbuf_*() work to do here */
> +		} else if (i != pp->output_owner) {
>  			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>  			strbuf_reset(&pp->children[i].err);
>  		} else {
> @@ -1744,12 +1787,14 @@ static int run_processes_parallel_1(int n, get_next_task_fn get_next_task,
>  				    void *pp_cb,
>  				    struct run_process_parallel_opts *opts)
>  {
> +	const int ungroup = opts->ungroup;
>  	int i, code;
>  	int output_timeout = 100;
>  	int spawn_cap = 4;
>  	struct parallel_processes pp;
>  
> -	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
> +	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
> +		opts);
>  	while (1) {
>  		for (i = 0;
>  		    i < spawn_cap && !pp.shutdown &&
> @@ -1766,8 +1811,12 @@ static int run_processes_parallel_1(int n, get_next_task_fn get_next_task,
>  		}
>  		if (!pp.nr_processes)
>  			break;
> -		pp_buffer_stderr(&pp, output_timeout);
> -		pp_output(&pp);
> +		if (ungroup) {
> +			pp_mark_working_for_cleanup(&pp);
> +		} else {
> +			pp_buffer_stderr(&pp, output_timeout);
> +			pp_output(&pp);
> +		}
>  		code = pp_collect_finished(&pp);
>  		if (code) {
>  			pp.shutdown = 1;
> diff --git a/run-command.h b/run-command.h
> index 66e7bebd88a..936d334eee0 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -406,6 +406,10 @@ void check_pipe(int err);
>   * pp_cb is the callback cookie as passed to run_processes_parallel.
>   * You can store a child process specific callback cookie in pp_task_cb.
>   *
> + * The "struct strbuf *err" parameter is either a pointer to a string
> + * to write errors to, or NULL if the "ungroup" option was
> + * provided. See run_processes_parallel() below.
> + *
>   * Even after returning 0 to indicate that there are no more processes,
>   * this function will be called again until there are no more running
>   * child processes.
> @@ -424,9 +428,9 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
>   * This callback is called whenever there are problems starting
>   * a new process.
>   *
> - * You must not write to stdout or stderr in this function. Add your
> - * message to the strbuf out instead, which will be printed without
> - * messing up the output of the other parallel processes.
> + * The "struct strbuf *err" parameter is either a pointer to a string
> + * to write errors to, or NULL if the "ungroup" option was
> + * provided. See run_processes_parallel() below.
>   *
>   * pp_cb is the callback cookie as passed into run_processes_parallel,
>   * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> @@ -442,9 +446,9 @@ typedef int (*start_failure_fn)(struct strbuf *out,
>  /**
>   * This callback is called on every child process that finished processing.
>   *
> - * You must not write to stdout or stderr in this function. Add your
> - * message to the strbuf out instead, which will be printed without
> - * messing up the output of the other parallel processes.
> + * The "struct strbuf *err" parameter is either a pointer to a string
> + * to write errors to, or NULL if the "ungroup" option was
> + * provided. See run_processes_parallel() below.
>   *
>   * pp_cb is the callback cookie as passed into run_processes_parallel,
>   * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> @@ -464,11 +468,16 @@ typedef int (*task_finished_fn)(int result,
>   *
>   * tr2_category & tr2_label: sets the trace2 category and label for
>   * logging. These must either be unset, or both of them must be set.
> + *
> + * ungroup: Ungroup output. Output is printed as soon as possible and
> + * bypasses run-command's internal processing. This may cause output
> + * from different commands to be mixed.
>   */
>  struct run_process_parallel_opts
>  {
>  	const char *tr2_category;
>  	const char *tr2_label;
> +	unsigned int ungroup:1;
>  };
>  
>  /**
> @@ -478,12 +487,19 @@ struct run_process_parallel_opts
>   *
>   * The children started via this function run in parallel. Their output
>   * (both stdout and stderr) is routed to stderr in a manner that output
> - * from different tasks does not interleave.
> + * from different tasks does not interleave (but see "ungroup" above).
>   *
>   * start_failure_fn and task_finished_fn can be NULL to omit any
>   * special handling.
>   *
> - * Options are passed via a "struct run_process_parallel_opts".
> + * Options are passed via a "struct run_process_parallel_opts". If the
> + * "ungroup" option isn't specified the callbacks will get a pointer
> + * to a "struct strbuf *out", and must not write to stdout or stderr
> + * as such output will mess up the output of the other parallel
> + * processes. If "ungroup" option is specified callbacks will get a
> + * NULL "struct strbuf *out" parameter, and are responsible for
> + * emitting their own output, including dealing with any race
> + * conditions due to writing in parallel to stdout and stderr.
>   */
>  int run_processes_parallel(int n, get_next_task_fn, start_failure_fn,
>  			   task_finished_fn, void *pp_cb,
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 9b21f2f9f83..747e57ef536 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -31,7 +31,11 @@ static int parallel_next(struct child_process *cp,
>  		return 0;
>  
>  	strvec_pushv(&cp->args, d->args.v);
> -	strbuf_addstr(err, "preloaded output of a child\n");
> +	if (err)
> +		strbuf_addstr(err, "preloaded output of a child\n");
> +	else
> +		fprintf(stderr, "preloaded output of a child\n");
> +
>  	number_callbacks++;
>  	return 1;
>  }
> @@ -41,7 +45,10 @@ static int no_job(struct child_process *cp,
>  		  void *cb,
>  		  void **task_cb)
>  {
> -	strbuf_addstr(err, "no further jobs available\n");
> +	if (err)
> +		strbuf_addstr(err, "no further jobs available\n");
> +	else
> +		fprintf(stderr, "no further jobs available\n");
>  	return 0;
>  }
>  
> @@ -50,7 +57,10 @@ static int task_finished(int result,
>  			 void *pp_cb,
>  			 void *pp_task_cb)
>  {
> -	strbuf_addstr(err, "asking for a quick stop\n");
> +	if (err)
> +		strbuf_addstr(err, "asking for a quick stop\n");
> +	else
> +		fprintf(stderr, "asking for a quick stop\n");
>  	return 1;
>  }
>  
> @@ -412,17 +422,26 @@ int cmd__run_command(int argc, const char **argv)
>  	strvec_clear(&proc.args);
>  	strvec_pushv(&proc.args, (const char **)argv + 3);
>  
> -	if (!strcmp(argv[1], "run-command-parallel"))
> +	if (!strcmp(argv[1], "run-command-parallel") ||
> +	    !strcmp(argv[1], "run-command-parallel-ungroup")) {
> +		opts.ungroup = !strcmp(argv[1], "run-command-parallel-ungroup");
>  		exit(run_processes_parallel(jobs, parallel_next,
>  					    NULL, NULL, &proc, &opts));
> +	}
>  
> -	if (!strcmp(argv[1], "run-command-abort"))
> +	if (!strcmp(argv[1], "run-command-abort") ||
> +	    !strcmp(argv[1], "run-command-abort-ungroup")) {
> +		opts.ungroup = !strcmp(argv[1], "run-command-abort-ungroup");
>  		exit(run_processes_parallel(jobs, parallel_next, NULL,
>  					    task_finished, &proc, &opts));
> +	}
>  
> -	if (!strcmp(argv[1], "run-command-no-jobs"))
> +	if (!strcmp(argv[1], "run-command-no-jobs") ||
> +	    !strcmp(argv[1], "run-command-no-jobs-ungroup")) {
> +		opts.ungroup = !strcmp(argv[1], "run-command-no-jobs-ungroup");
>  		exit(run_processes_parallel(jobs, no_job, NULL, task_finished,
>  					    &proc, &opts));
> +	}
>  
>  	fprintf(stderr, "check usage\n");
>  	return 1;
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 131fcfda90f..0a82db965e8 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -135,18 +135,36 @@ test_expect_success 'run_command runs in parallel with more jobs available than
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
> +	test-tool run-command run-command-parallel-ungroup 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_line_count = 8 out &&
> +	test_line_count = 4 err
> +'
> +
>  test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
>  	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
>  	test_must_be_empty out &&
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
> +	test-tool run-command run-command-parallel-ungroup 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_line_count = 8 out &&
> +	test_line_count = 4 err
> +'
> +
>  test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
>  	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
>  	test_must_be_empty out &&
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
> +	test-tool run-command run-command-parallel-ungroup 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_line_count = 8 out &&
> +	test_line_count = 4 err
> +'
> +
>  cat >expect <<-EOF
>  preloaded output of a child
>  asking for a quick stop
> @@ -162,6 +180,12 @@ test_expect_success 'run_command is asked to abort gracefully' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
> +	test-tool run-command run-command-abort-ungroup 3 false >out 2>err &&
> +	test_must_be_empty out &&
> +	test_line_count = 6 err
> +'
> +
>  cat >expect <<-EOF
>  no further jobs available
>  EOF
> @@ -172,6 +196,12 @@ test_expect_success 'run_command outputs ' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'run_command outputs (ungroup) ' '
> +	test-tool run-command run-command-no-jobs-ungroup 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
> +	test_must_be_empty out &&
> +	test_cmp expect actual
> +'
> +
>  test_trace () {
>  	expect="$1"
>  	shift
> -- 
> 2.36.0.893.g80a51c675f6
> 
