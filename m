Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94621C43217
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 09:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJNJuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJNJu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 05:50:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C472C3545
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:50:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so6757795wrr.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tsj1FPW37ZRDCatHPxlOlF7o6clP3NGj04FILL8xkwU=;
        b=WXbu0WnunIWx4FtJHvBxzm9rq7u6HLx1RBlkbSxCm8QRHI4/m5w+rqMJAkdHexNiDQ
         Grbo6xF4Aa61fxx7ObNCATKYmNKasI1psKQqpEJgEXPHwe9q8ojPv3eolY+b08FaGxhH
         CNOHdmcOFFwagK7eM5RcxTxPR0QExUk/oL5s8806HIvwCZb24vN0LQUvoyC/OnlI2ly/
         QLHn37tB2+msM5cU3ef2+Lu3qgLbzETxFZRlnWZl2e8jjR3TEg1OhCP7DsGg724uHVbB
         9ku0uRPHsjEcXH1uxzZQR1pswg36i0ScNYDNsS+5fP4Dv23FMlEtVEj4wJoK9bhAY0VY
         rheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsj1FPW37ZRDCatHPxlOlF7o6clP3NGj04FILL8xkwU=;
        b=sSSjWNi9v8ZyZ2H5PpQiInwzoTN/do+WB1mFdwpGtE3IRvaF5pavUO7tXBBKjOeZ31
         qQL79j01NrxL40FtBkzz7COgcu88N+ZHb9CdX0bDvCKeuRrSQdT6tzEaSVNUCdeF7PxY
         YvoBlD9JdmNJ+8bTO0gR1GEonx/8TUuUNJ6SzqSEFiQf5k6bZp3h2kseAftqo4Ql8Lld
         pZnRd0TQXZGqzLlNJF0E6/ByGuNz9fRYDUDLHiJemNR2LlaOo5mZBbT1LGNPpMZ7sxmG
         Ts2Rp3tqFL36BWmP6yJhWewnDo2oG+D1jHxxO6ksWGs/nM5YGCMr2bEvvhiGZzC7dFW+
         abuQ==
X-Gm-Message-State: ACrzQf35X84U42+b7hzzxp2f/CVn+AeXmyxmrPTMKCNmkIVcGObxJtSF
        FzyqCuHL4CR8WLpcsnwLAy8=
X-Google-Smtp-Source: AMsMyM4+uy/8jdfLa6NLx2mT3dCqor4I7UQsTK9nfMmqHk4FyzN75A5OmGLps4+Sl/H02eFMKUGwBg==
X-Received: by 2002:adf:f2cd:0:b0:22e:49c0:aa3b with SMTP id d13-20020adff2cd000000b0022e49c0aa3bmr2773140wrp.97.1665741021994;
        Fri, 14 Oct 2022 02:50:21 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id i29-20020a1c541d000000b003c41144b3cfsm6641958wmb.20.2022.10.14.02.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 02:50:21 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <9aa09495-29d4-5eac-0f20-a77cd7803a11@dunelm.org.uk>
Date:   Fri, 14 Oct 2022 10:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 07/15] run-command API: have run_process_parallel()
 take an "opts" struct
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
 <patch-v3-07.15-eaed3d8838d-20221012T205712Z-avarab@gmail.com>
In-Reply-To: <patch-v3-07.15-eaed3d8838d-20221012T205712Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2022 22:02, Ævar Arnfjörð Bjarmason wrote:
> As noted in fd3aaf53f71 (run-command: add an "ungroup" option to
> run_process_parallel(), 2022-06-07) which added the "ungroup" passing
> it to "run_process_parallel()" via the global
> "run_processes_parallel_ungroup" variable was a compromise to get the
> smallest possible regression fix for "maint" at the time.
> 
> This follow-up to that is a start at passing that parameter and others
> via a new "struct run_process_parallel_opts", as the earlier
> version[1] of what became fd3aaf53f71 did.
> 
> Since we need to change all of the occurrences of "n" to
> "opt->SOMETHING" let's take the opportunity and rename the terse "n"
> to "processes". We could also have picked "max_processes", "jobs",
> "threads" etc., but as the API is named "run_processes_parallel()"
> let's go with "processes".
> 
> Since the new "run_processes_parallel()" function is able to take an
> optional "tr2_category" and "tr2_label" via the struct we can at this
> point migrate all of the users of "run_processes_parallel_tr2()" over
> to it.
> 
> But let's not migrate all the API users yet, only the two users that
> passed the "ungroup" parameter via the
> "run_processes_parallel_ungroup" global

This all sounds sensible, thanks for squashing the patches together.

Best Wishes

Phillip

> 1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   hook.c                      | 23 +++++++-----
>   run-command.c               | 54 ++++++++++++++++------------
>   run-command.h               | 72 ++++++++++++++++++++++++++++---------
>   t/helper/test-run-command.c | 31 ++++++++++------
>   4 files changed, 121 insertions(+), 59 deletions(-)
> 
> diff --git a/hook.c b/hook.c
> index a493939a4fc..a4fa1031f28 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -114,8 +114,20 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
>   		.options = options,
>   	};
>   	const char *const hook_path = find_hook(hook_name);
> -	int jobs = 1;
>   	int ret = 0;
> +	const struct run_process_parallel_opts opts = {
> +		.tr2_category = "hook",
> +		.tr2_label = hook_name,
> +
> +		.processes = 1,
> +		.ungroup = 1,
> +
> +		.get_next_task = pick_next_hook,
> +		.start_failure = notify_start_failure,
> +		.task_finished = notify_hook_finished,
> +
> +		.data = &cb_data,
> +	};
>   
>   	if (!options)
>   		BUG("a struct run_hooks_opt must be provided to run_hooks");
> @@ -137,14 +149,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
>   		cb_data.hook_path = abs_path.buf;
>   	}
>   
> -	run_processes_parallel_ungroup = 1;
> -	run_processes_parallel_tr2(jobs,
> -				   pick_next_hook,
> -				   notify_start_failure,
> -				   notify_hook_finished,
> -				   &cb_data,
> -				   "hook",
> -				   hook_name);
> +	run_processes_parallel(&opts);
>   	ret = cb_data.rc;
>   cleanup:
>   	strbuf_release(&abs_path);
> diff --git a/run-command.c b/run-command.c
> index b69deb1cc53..2858ec7bef5 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1496,7 +1496,6 @@ enum child_state {
>   	GIT_CP_WAIT_CLEANUP,
>   };
>   
> -int run_processes_parallel_ungroup;
>   struct parallel_processes {
>   	void *const data;
>   
> @@ -1558,11 +1557,12 @@ static void handle_children_on_signal(int signo)
>   }
>   
>   static void pp_init(struct parallel_processes *pp,
> -		    get_next_task_fn get_next_task,
> -		    start_failure_fn start_failure,
> -		    task_finished_fn task_finished)
> +		    const struct run_process_parallel_opts *opts)
>   {
> -	const size_t n = pp->max_processes;
> +	const size_t n = opts->processes;
> +	get_next_task_fn get_next_task = opts->get_next_task;
> +	start_failure_fn start_failure = opts->start_failure;
> +	task_finished_fn task_finished = opts->task_finished;
>   
>   	if (!n)
>   		BUG("you must provide a non-zero number of processes!");
> @@ -1769,27 +1769,27 @@ static int pp_collect_finished(struct parallel_processes *pp)
>   	return result;
>   }
>   
> -void run_processes_parallel(size_t n,
> -			    get_next_task_fn get_next_task,
> -			    start_failure_fn start_failure,
> -			    task_finished_fn task_finished,
> -			    void *pp_cb)
> +void run_processes_parallel(const struct run_process_parallel_opts *opts)
>   {
>   	int i, code;
>   	int output_timeout = 100;
>   	int spawn_cap = 4;
> -	int ungroup = run_processes_parallel_ungroup;
>   	struct parallel_processes pp = {
> -		.max_processes = n,
> -		.data = pp_cb,
> +		.max_processes = opts->processes,
> +		.data = opts->data,
>   		.buffered_output = STRBUF_INIT,
> -		.ungroup = ungroup,
> +		.ungroup = opts->ungroup,
>   	};
> +	/* options */
> +	const char *tr2_category = opts->tr2_category;
> +	const char *tr2_label = opts->tr2_label;
> +	const int do_trace2 = tr2_category && tr2_label;
>   
> -	/* unset for the next API user */
> -	run_processes_parallel_ungroup = 0;
> +	if (do_trace2)
> +		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
> +					   "max:%d", opts->processes);
>   
> -	pp_init(&pp, get_next_task, start_failure, task_finished);
> +	pp_init(&pp, opts);
>   	while (1) {
>   		for (i = 0;
>   		    i < spawn_cap && !pp.shutdown &&
> @@ -1806,7 +1806,7 @@ void run_processes_parallel(size_t n,
>   		}
>   		if (!pp.nr_processes)
>   			break;
> -		if (ungroup) {
> +		if (opts->ungroup) {
>   			for (size_t i = 0; i < pp.max_processes; i++)
>   				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
>   		} else {
> @@ -1822,19 +1822,27 @@ void run_processes_parallel(size_t n,
>   	}
>   
>   	pp_cleanup(&pp);
> +
> +	if (do_trace2)
> +		trace2_region_leave(tr2_category, tr2_label, NULL);
>   }
>   
> -void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
> +void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task,
>   				start_failure_fn start_failure,
>   				task_finished_fn task_finished, void *pp_cb,
>   				const char *tr2_category, const char *tr2_label)
>   {
> -	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d", n);
> +	const struct run_process_parallel_opts opts = {
> +		.tr2_category = tr2_category,
> +		.tr2_label = tr2_label,
> +		.processes = processes,
>   
> -	run_processes_parallel(n, get_next_task, start_failure,
> -			       task_finished, pp_cb);
> +		.get_next_task = get_next_task,
> +		.start_failure = start_failure,
> +		.task_finished = task_finished,
> +	};
>   
> -	trace2_region_leave(tr2_category, tr2_label, NULL);
> +	run_processes_parallel(&opts);
>   }
>   
>   int run_auto_maintenance(int quiet)
> diff --git a/run-command.h b/run-command.h
> index 6f7604e1146..aabdaf684db 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -459,17 +459,64 @@ typedef int (*task_finished_fn)(int result,
>   				void *pp_task_cb);
>   
>   /**
> - * Runs up to n processes at the same time. Whenever a process can be
> - * started, the callback get_next_task_fn is called to obtain the data
> + * Option used by run_processes_parallel(), { 0 }-initialized means no
> + * options.
> + */
> +struct run_process_parallel_opts
> +{
> +	/**
> +	 * tr2_category & tr2_label: sets the trace2 category and label for
> +	 * logging. These must either be unset, or both of them must be set.
> +	 */
> +	const char *tr2_category;
> +	const char *tr2_label;
> +
> +	/**
> +	 * processes: see 'processes' in run_processes_parallel() below.
> +	 */
> +	size_t processes;
> +
> +	/**
> +	 * ungroup: see 'ungroup' in run_processes_parallel() below.
> +	 */
> +	unsigned int ungroup:1;
> +
> +	/**
> +	 * get_next_task: See get_next_task_fn() above. This must be
> +	 * specified.
> +	 */
> +	get_next_task_fn get_next_task;
> +
> +	/**
> +	 * start_failure: See start_failure_fn() above. This can be
> +	 * NULL to omit any special handling.
> +	 */
> +	start_failure_fn start_failure;
> +
> +	/**
> +	 * task_finished: See task_finished_fn() above. This can be
> +	 * NULL to omit any special handling.
> +	 */
> +	task_finished_fn task_finished;
> +
> +	/**
> +	 * data: user data, will be passed as "pp_cb" to the callback
> +	 * parameters.
> +	 */
> +	void *data;
> +};
> +
> +/**
> + * Options are passed via the "struct run_process_parallel_opts" above.
> + *
> + * Runs N 'processes' at the same time. Whenever a process can be
> + * started, the callback opts.get_next_task is called to obtain the data
>    * required to start another child process.
>    *
>    * The children started via this function run in parallel. Their output
>    * (both stdout and stderr) is routed to stderr in a manner that output
>    * from different tasks does not interleave (but see "ungroup" below).
>    *
> - * start_failure_fn and task_finished_fn can be NULL to omit any
> - * special handling.
> - *
>    * If the "ungroup" option isn't specified, the API will set the
>    * "stdout_to_stderr" parameter in "struct child_process" and provide
>    * the callbacks with a "struct strbuf *out" parameter to write output
> @@ -479,19 +526,10 @@ typedef int (*task_finished_fn)(int result,
>    * NULL "struct strbuf *out" parameter, and are responsible for
>    * emitting their own output, including dealing with any race
>    * conditions due to writing in parallel to stdout and stderr.
> - * The "ungroup" option can be enabled by setting the global
> - * "run_processes_parallel_ungroup" to "1" before invoking
> - * run_processes_parallel(), it will be set back to "0" as soon as the
> - * API reads that setting.
>    */
> -extern int run_processes_parallel_ungroup;
> -void run_processes_parallel(size_t n,
> -			    get_next_task_fn,
> -			    start_failure_fn,
> -			    task_finished_fn,
> -			    void *pp_cb);
> -void run_processes_parallel_tr2(size_t n, get_next_task_fn, start_failure_fn,
> -				task_finished_fn, void *pp_cb,
> +void run_processes_parallel(const struct run_process_parallel_opts *opts);
> +void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
> +				start_failure_fn, task_finished_fn, void *pp_cb,
>   				const char *tr2_category, const char *tr2_label);
>   
>   /**
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index ee509aefa2f..3ecb830f4a8 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -136,7 +136,7 @@ static const char * const testsuite_usage[] = {
>   static int testsuite(int argc, const char **argv)
>   {
>   	struct testsuite suite = TESTSUITE_INIT;
> -	int max_jobs = 1, i, ret;
> +	int max_jobs = 1, i, ret = 0;
>   	DIR *dir;
>   	struct dirent *d;
>   	struct option options[] = {
> @@ -152,6 +152,12 @@ static int testsuite(int argc, const char **argv)
>   			 "write JUnit-style XML files"),
>   		OPT_END()
>   	};
> +	struct run_process_parallel_opts opts = {
> +		.get_next_task = next_test,
> +		.start_failure = test_failed,
> +		.task_finished = test_finished,
> +		.data = &suite,
> +	};
>   
>   	argc = parse_options(argc, argv, NULL, options,
>   			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> @@ -192,8 +198,8 @@ static int testsuite(int argc, const char **argv)
>   	fprintf(stderr, "Running %"PRIuMAX" tests (%d at a time)\n",
>   		(uintmax_t)suite.tests.nr, max_jobs);
>   
> -	run_processes_parallel(max_jobs, next_test, test_failed,
> -			       test_finished, &suite);
> +	opts.processes = max_jobs;
> +	run_processes_parallel(&opts);
>   
>   	if (suite.failed.nr > 0) {
>   		ret = 1;
> @@ -206,7 +212,7 @@ static int testsuite(int argc, const char **argv)
>   	string_list_clear(&suite.tests, 0);
>   	string_list_clear(&suite.failed, 0);
>   
> -	return !!ret;
> +	return ret;
>   }
>   
>   static uint64_t my_random_next = 1234;
> @@ -382,6 +388,9 @@ int cmd__run_command(int argc, const char **argv)
>   	struct child_process proc = CHILD_PROCESS_INIT;
>   	int jobs;
>   	int ret;
> +	struct run_process_parallel_opts opts = {
> +		.data = &proc,
> +	};
>   
>   	if (argc > 1 && !strcmp(argv[1], "testsuite"))
>   		return testsuite(argc - 1, argv + 1);
> @@ -427,7 +436,7 @@ int cmd__run_command(int argc, const char **argv)
>   	if (!strcmp(argv[1], "--ungroup")) {
>   		argv += 1;
>   		argc -= 1;
> -		run_processes_parallel_ungroup = 1;
> +		opts.ungroup = 1;
>   	}
>   
>   	jobs = atoi(argv[2]);
> @@ -435,18 +444,20 @@ int cmd__run_command(int argc, const char **argv)
>   	strvec_pushv(&proc.args, (const char **)argv + 3);
>   
>   	if (!strcmp(argv[1], "run-command-parallel")) {
> -		run_processes_parallel(jobs, parallel_next, NULL, NULL, &proc);
> +		opts.get_next_task = parallel_next;
>   	} else if (!strcmp(argv[1], "run-command-abort")) {
> -		run_processes_parallel(jobs, parallel_next, NULL,
> -				       task_finished, &proc);
> +		opts.get_next_task = parallel_next;
> +		opts.task_finished = task_finished;
>   	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
> -		run_processes_parallel(jobs, no_job, NULL, task_finished,
> -				       &proc);
> +		opts.get_next_task = no_job;
> +		opts.task_finished = task_finished;
>   	} else {
>   		ret = 1;
>   		fprintf(stderr, "check usage\n");
>   		goto cleanup;
>   	}
> +	opts.processes = jobs;
> +	run_processes_parallel(&opts);
>   	ret = 0;
>   cleanup:
>   	child_process_clear(&proc);
