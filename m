Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E78C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJGJxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJGJxP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:53:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51DBB97A1
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:53:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso2322598wmq.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ocR6oNK2F0M+wB1gBaxlT/XZ/8H+3TPr+S9mMg0f1Pc=;
        b=VLdPK4I90Fs2foy0bnc9v9zbbUtnop4iAoty/uk3cXRA+p0+A1FzEPWF6YlyhjSoJm
         e0W8HsS6T/cyWN7OMgLpv8p/K0mB9GElRTryqj9y9SolNvdTErP5WkCqxe8n1uhyIxiN
         GHjfBgbl0DRIBp++uCTxngyfxS/LBr2MMVWkRWqVvpoOt3HoeI/Woo3v2/te8OrsHkv0
         +XozaMBADu2ytC6abjaI5zpuFvJGpe/0Siw1oCcah6/2PPZnJiKfLmtleundn7op60zr
         bexv6eINoXM5Vyyk+f3I3iPBG18836C1h9IB+K0towq2WxYn+ekH5yAyELvSUEEwkU5E
         HVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocR6oNK2F0M+wB1gBaxlT/XZ/8H+3TPr+S9mMg0f1Pc=;
        b=7NRmIdUOApADBaNOBHDb3iy9ogM9LPUyveieFInC4O4A93KaFQnP2q+w1eFJoHLSOD
         FLp+9KQeTm7JLBmfnCIG1k6c2uvlOx1s3eQSU+iNLbIWVn9rT94CP0R+U5InBlFWsC6x
         5O5G1zGifSwgJW2MMms4uMDjNsLPhZoiJOQ77oJMAYrGEyOtJzQ6fptECUckQC03JvK8
         QBDn6hp1YjG3K9OufapokhLn8VI3Ia+NuXIEIntcrZIQ3MjIcpYFK+nO+7+1jSYCKBYP
         c5gHoIlVlDOx5qy3x60NwB7Z1YESvJryH4U/16hBxh5MA9C6lc4Ps1We2boE5blHBeLV
         jBYg==
X-Gm-Message-State: ACrzQf0ta351RDTUqMnm+xitv8z2uP1/UALVhKF83Ym9uPMbLTJdL1x+
        p2NguJlsVGDFz2i/sdff8yPdia0Xuuc=
X-Google-Smtp-Source: AMsMyM6hJLLrLo7blmu7EIMX+mk3trUNwhg/cerFLesDbeAGbDuCshadDCXyQufzqDHqod0pTH3qJw==
X-Received: by 2002:a05:600c:4e51:b0:3c0:55e0:7719 with SMTP id e17-20020a05600c4e5100b003c055e07719mr2720471wmq.3.1665136388487;
        Fri, 07 Oct 2022 02:53:08 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id z10-20020a05600c0a0a00b003a2f2bb72d5sm11465587wmp.45.2022.10.07.02.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 02:53:08 -0700 (PDT)
Message-ID: <04f23267-b495-cf7c-f0e3-4e49768fb077@gmail.com>
Date:   Fri, 7 Oct 2022 10:53:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 07/15] run-command API: make "jobs" parameter an "unsigned
 int"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <patch-07.15-a9810aaa852-20220930T111343Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-07.15-a9810aaa852-20220930T111343Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/09/2022 12:28, Ævar Arnfjörð Bjarmason wrote:
> The rename the "n" variable added in c553c72eed6 (run-command: add an
> asynchronous parallel child processor, 2015-12-15) to "jobs", and
> change the type to an "unsigned int". As we'll see in a subsequent
> commit we do pass "0" here, but never "jobs < 0".
> 
> The only users of the "jobs" parameter are:
> 
>   * builtin/fetch.c: defaults to 1, reads from the "fetch.parallel"
>     config. As seen in the code that parses the config added in
>     d54dea77dba (fetch: let --jobs=<n> parallelize --multiple, too,
>     2019-10-05) will die if the git_config_int() return value is < 0.
> 
>     It will however pass us jobs = 0, as we'll see in a subsequent
>     commit.
> 
>   * submodule.c: defaults to 1, reads from "submodule.fetchJobs"
>     config. Read via code originally added in a028a1930c6 (fetching
>     submodules: respect `submodule.fetchJobs` config option, 2016-02-29).
> 
>     It now piggy-backs on the the submodule.fetchJobs code and
>     validation added in f20e7c1ea24 (submodule: remove
>     submodule.fetchjobs from submodule-config parsing, 2017-08-02).
> 
>     Like builtin/fetch.c it will die if the git_config_int() return
>     value is < 0, but like builtin/fetch.c it will pass us jobs = 0.
> 
>   * builtin/submodule--helper.c: defaults to 1. Read via code
>     originally added in 2335b870fa7 (submodule update: expose parallelism
>     to the user, 2016-02-29).
> 
>     Since f20e7c1ea24 (submodule: remove submodule.fetchjobs from
>     submodule-config parsing, 2017-08-02) it shares a config parser and
>     semantics with the submodule.c caller.
> 
>   * hook.c: hardcoded to 1, see 96e7225b310 (hook: add 'run'
>     subcommand, 2021-12-22).
> 
>   * t/helper/test-run-command.c: can be -1 after parsing the arguments,
>     but will then be overridden to online_cpus() before passing it to
>     this API. See be5d88e1128 (test-tool run-command: learn to run (parts
>     of) the testsuite, 2019-10-04).

I'm afraid I think this commit is a complete waste of reviewers time. As 
far as I con see in a later commit all the changes here are rewritten. 
Why do we need to go from n -> jobs -> opts->jobs rather than just n -> 
opts->jobs later.

Best Wishes

Phillip

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   run-command.c | 33 +++++++++++++++++----------------
>   run-command.h |  6 +++---
>   2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 642e6b6e057..80d282dbdb6 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1500,8 +1500,8 @@ int run_processes_parallel_ungroup;
>   struct parallel_processes {
>   	void *data;
>   
> -	int max_processes;
> -	int nr_processes;
> +	unsigned int max_processes;
> +	unsigned int nr_processes;
>   
>   	get_next_task_fn get_next_task;
>   	start_failure_fn start_failure;
> @@ -1560,20 +1560,21 @@ static void handle_children_on_signal(int signo)
>   }
>   
>   static void pp_init(struct parallel_processes *pp,
> -		    int n,
> +		    unsigned int jobs,
>   		    get_next_task_fn get_next_task,
>   		    start_failure_fn start_failure,
>   		    task_finished_fn task_finished,
>   		    void *data, int ungroup)
>   {
> -	int i;
> +	unsigned int i;
>   
> -	if (n < 1)
> -		n = online_cpus();
> +	if (jobs < 1)
> +		jobs = online_cpus();
>   
> -	pp->max_processes = n;
> +	pp->max_processes = jobs;
>   
> -	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
> +	trace_printf("run_processes_parallel: preparing to run up to %d tasks",
> +		     jobs);
>   
>   	pp->data = data;
>   	if (!get_next_task)
> @@ -1587,14 +1588,14 @@ static void pp_init(struct parallel_processes *pp,
>   	pp->output_owner = 0;
>   	pp->shutdown = 0;
>   	pp->ungroup = ungroup;
> -	CALLOC_ARRAY(pp->children, n);
> +	CALLOC_ARRAY(pp->children, jobs);
>   	if (pp->ungroup)
>   		pp->pfd = NULL;
>   	else
> -		CALLOC_ARRAY(pp->pfd, n);
> +		CALLOC_ARRAY(pp->pfd, jobs);
>   	strbuf_init(&pp->buffered_output, 0);
>   
> -	for (i = 0; i < n; i++) {
> +	for (i = 0; i < jobs; i++) {
>   		strbuf_init(&pp->children[i].err, 0);
>   		child_process_init(&pp->children[i].process);
>   		if (pp->pfd) {
> @@ -1783,7 +1784,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
>   	return result;
>   }
>   
> -void run_processes_parallel(int n,
> +void run_processes_parallel(unsigned int jobs,
>   			    get_next_task_fn get_next_task,
>   			    start_failure_fn start_failure,
>   			    task_finished_fn task_finished,
> @@ -1798,7 +1799,7 @@ void run_processes_parallel(int n,
>   	/* unset for the next API user */
>   	run_processes_parallel_ungroup = 0;
>   
> -	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
> +	pp_init(&pp, jobs, get_next_task, start_failure, task_finished, pp_cb,
>   		ungroup);
>   	while (1) {
>   		for (i = 0;
> @@ -1836,15 +1837,15 @@ void run_processes_parallel(int n,
>   	pp_cleanup(&pp);
>   }
>   
> -void run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
> +void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_task,
>   				start_failure_fn start_failure,
>   				task_finished_fn task_finished, void *pp_cb,
>   				const char *tr2_category, const char *tr2_label)
>   {
>   	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
> -				   ((n < 1) ? online_cpus() : n));
> +				   ((jobs < 1) ? online_cpus() : jobs));
>   
> -	run_processes_parallel(n, get_next_task, start_failure,
> +	run_processes_parallel(jobs, get_next_task, start_failure,
>   			       task_finished, pp_cb);
>   
>   	trace2_region_leave(tr2_category, tr2_label, NULL);
> diff --git a/run-command.h b/run-command.h
> index e76a1b6b5b3..4502bdc64dc 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -459,7 +459,7 @@ typedef int (*task_finished_fn)(int result,
>   				void *pp_task_cb);
>   
>   /**
> - * Runs up to n processes at the same time. Whenever a process can be
> + * Runs up to 'jobs' processes at the same time. Whenever a process can be
>    * started, the callback get_next_task_fn is called to obtain the data
>    * required to start another child process.
>    *
> @@ -485,12 +485,12 @@ typedef int (*task_finished_fn)(int result,
>    * API reads that setting.
>    */
>   extern int run_processes_parallel_ungroup;
> -void run_processes_parallel(int n,
> +void run_processes_parallel(unsigned int jobs,
>   			    get_next_task_fn,
>   			    start_failure_fn,
>   			    task_finished_fn,
>   			    void *pp_cb);
> -void run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
> +void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn, start_failure_fn,
>   				task_finished_fn, void *pp_cb,
>   				const char *tr2_category, const char *tr2_label);
>   

