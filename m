Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF75C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJGJzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJGJzq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:55:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440A686813
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:55:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bi26-20020a05600c3d9a00b003c1e11f54d2so1065063wmb.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2g/hBnMhZP48nWcHzcj0vzK8WIEjOb/gz4LIZxJYjD4=;
        b=ZkL4T6wUdL63Rqa01k3huT+TqVk4D6nKGhfnK61ZJY6CH8Fr91pWO4M+Dy/D9IX0Hc
         P5MBmyq31FJ4KakJ1n2MQk2p4hHbJeuOoJjAvUdIwdpgQ1nsjBVAhQwwKIDQ3wkZDEL9
         W63SjD+q6GsVmCXWqbjZZrouepsAcMHnkYPmVJ12gJ4YIlXRsAkuesG4kxdYfxY3Gtmb
         57HnTtJcxyi1byu1qOj4k2snaMPDoL15bEMUP74Vs2kLXwtOw6vRB4f0NLQrIwIyN0rR
         0YPQCxEGhLmk7BTgm9EmeaX6/bbcfzLRgj4QBM+TcxhgbXbos/1qkFrqySVmHVDiXixu
         rPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2g/hBnMhZP48nWcHzcj0vzK8WIEjOb/gz4LIZxJYjD4=;
        b=VDxbnO2VGpuuFOqMZrJrIwRhIwr0XaX2RfuBiMGjHXuaqIoiVHb6M6eEVlIhlM3DDk
         hf5mQkE8BqJ+AIUyc9NaL5RaezzxiWUjkPNODtNxY+0npWRSBmbI5FoNRirlYF3julaa
         QzX0i53wEa5TU7SPrabAGYthf3xO/sTqHHTwz9tIGEw7nntDj/0yb2g+Z3IN/pQ6jbs6
         qsuc/ekJ3HuEzLRv6Kzgn/RFZvgFwrmKYzc/CgDg383dPu/lqFoRGOUrWkstOYJDHOe0
         7Xtu/9Dz/eTSwGWcExYQJUELnU7OZeUXytdptcfr8JRl8HvPX8YTjiZ0hJSq8eDgH2nh
         Z4jQ==
X-Gm-Message-State: ACrzQf168QLQ4tokkh5FpYdc7S67IoGRm6IMamoCk85yqzj2RMztb6/i
        RUeoQiknsF44s0xb7vckP8k=
X-Google-Smtp-Source: AMsMyM6pHFP5KpZO+LqJaKLnGy9pjtudw3e66IghCUnZhfMeUp0myLwQQ6YNdkWL0w3rVHlKT3XM9Q==
X-Received: by 2002:a05:600c:689b:b0:3c2:fd6e:1fe5 with SMTP id fn27-20020a05600c689b00b003c2fd6e1fe5mr1659638wmb.99.1665136543706;
        Fri, 07 Oct 2022 02:55:43 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id g1-20020adff3c1000000b0021e43b4edf0sm1655137wrp.20.2022.10.07.02.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 02:55:43 -0700 (PDT)
Message-ID: <5ee14b82-aebd-731d-1c6f-a113c9127000@gmail.com>
Date:   Fri, 7 Oct 2022 10:55:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/15] run-command API: add nascent "struct
 run_process_parallel_opts"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <patch-10.15-613ccb85fa2-20220930T111343Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-10.15-613ccb85fa2-20220930T111343Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/09/2022 12:28, Ævar Arnfjörð Bjarmason wrote:
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
> For now we're only changing how data is passed internally to
> "run-command.c", i.e. from "run_process_parallel()" to
> pp_init(). Subsequent commits will change "run_processes_parallel()"
> itself, as well as the "run_processes_parallel_tr2()" wrapper
> function.

This is a very welcome change, but I'd have found it easier to follow if 
patches 10-12 were squashed together. There is a lot of code that gets 
added only to be deleted or moved in a following commit. A single patch 
would be bigger but they'd be less changes to review overall. As far as 
I can tell the overall change is good.

Best Wishes

Phillip

> 1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   run-command.c | 38 ++++++++++++++++++++++----------------
>   run-command.h | 44 +++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 63 insertions(+), 19 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 31a856f8b9a..f82fc7f1515 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1563,21 +1563,21 @@ static void handle_children_on_signal(int signo)
>   }
>   
>   static void pp_init(struct parallel_processes *pp,
> -		    unsigned int jobs,
> -		    get_next_task_fn get_next_task,
> -		    start_failure_fn start_failure,
> -		    task_finished_fn task_finished,
> -		    void *data, int ungroup)
> +		    const struct run_process_parallel_opts *opts)
>   {
>   	unsigned int i;
> +	void *data = opts->data;
> +	get_next_task_fn get_next_task = opts->get_next_task;
> +	start_failure_fn start_failure = opts->start_failure;
> +	task_finished_fn task_finished = opts->task_finished;
>   
> -	if (!jobs)
> +	if (!opts->jobs)
>   		BUG("you must provide a non-zero number of jobs!");
>   
> -	pp->max_processes = jobs;
> +	pp->max_processes = opts->jobs;
>   
>   	trace_printf("run_processes_parallel: preparing to run up to %d tasks",
> -		     jobs);
> +		     opts->jobs);
>   
>   	pp->data = data;
>   	if (!get_next_task)
> @@ -1590,12 +1590,12 @@ static void pp_init(struct parallel_processes *pp,
>   	pp->nr_processes = 0;
>   	pp->output_owner = 0;
>   	pp->shutdown = 0;
> -	pp->ungroup = ungroup;
> -	CALLOC_ARRAY(pp->children, jobs);
> +	pp->ungroup = opts->ungroup;
> +	CALLOC_ARRAY(pp->children, opts->jobs);
>   	if (!pp->ungroup)
> -		CALLOC_ARRAY(pp->pfd, jobs);
> +		CALLOC_ARRAY(pp->pfd, opts->jobs);
>   
> -	for (i = 0; i < jobs; i++) {
> +	for (i = 0; i < opts->jobs; i++) {
>   		strbuf_init(&pp->children[i].err, 0);
>   		child_process_init(&pp->children[i].process);
>   		if (pp->pfd) {
> @@ -1793,14 +1793,20 @@ void run_processes_parallel(unsigned int jobs,
>   	int i, code;
>   	int output_timeout = 100;
>   	int spawn_cap = 4;
> -	int ungroup = run_processes_parallel_ungroup;
>   	struct parallel_processes pp = PARALLEL_PROCESSES_INIT;
> +	const struct run_process_parallel_opts opts = {
> +		.jobs = jobs,
> +		.get_next_task = get_next_task,
> +		.start_failure = start_failure,
> +		.task_finished = task_finished,
> +		.ungroup = run_processes_parallel_ungroup,
> +		.data = pp_cb,
> +	};
>   
>   	/* unset for the next API user */
>   	run_processes_parallel_ungroup = 0;
>   
> -	pp_init(&pp, jobs, get_next_task, start_failure, task_finished, pp_cb,
> -		ungroup);
> +	pp_init(&pp, &opts);
>   	while (1) {
>   		for (i = 0;
>   		    i < spawn_cap && !pp.shutdown &&
> @@ -1817,7 +1823,7 @@ void run_processes_parallel(unsigned int jobs,
>   		}
>   		if (!pp.nr_processes)
>   			break;
> -		if (ungroup) {
> +		if (opts.ungroup) {
>   			int i;
>   
>   			for (i = 0; i < pp.max_processes; i++)
> diff --git a/run-command.h b/run-command.h
> index 4502bdc64dc..210fb9e8bc4 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -458,6 +458,47 @@ typedef int (*task_finished_fn)(int result,
>   				void *pp_cb,
>   				void *pp_task_cb);
>   
> +/**
> + * Option used by run_processes_parallel(), { 0 }-initialized means no
> + * options.
> + */
> +struct run_process_parallel_opts
> +{
> +	/**
> +	 * jobs: see 'jobs' in run_processes_parallel() below.
> +	 */
> +	int jobs;
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
>   /**
>    * Runs up to 'jobs' processes at the same time. Whenever a process can be
>    * started, the callback get_next_task_fn is called to obtain the data
> @@ -467,9 +508,6 @@ typedef int (*task_finished_fn)(int result,
>    * (both stdout and stderr) is routed to stderr in a manner that output
>    * from different tasks does not interleave (but see "ungroup" below).
>    *
> - * start_failure_fn and task_finished_fn can be NULL to omit any
> - * special handling.
> - *
>    * If the "ungroup" option isn't specified, the API will set the
>    * "stdout_to_stderr" parameter in "struct child_process" and provide
>    * the callbacks with a "struct strbuf *out" parameter to write output

