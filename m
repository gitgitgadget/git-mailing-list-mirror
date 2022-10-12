Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA8C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJLNJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiJLNJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:09:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABD2FAD7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:09:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r13so26139705wrj.11
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UYXuxSWUELpOlSOWdi8CjhU75SC2tpQSXkTcTi0j8UY=;
        b=cY93BKy1WZe7IimwU0OYwxXX3oXNsEV6VnhUjHSV65cMn8hm100EDh2AFkq7dm/rnX
         JX0ewcn034yIg6R8toFc5ypWjMHp7cNKZRnFND4lwEhdZQJpK9zQuuTW2WkjCXDSzHUU
         WPOshLoBciZITlzrykwG+GbiFHe7VP6JtaR6dkqsA59TOeK2EUl4x/r2WgZFqVk/L0ow
         FADUZj2bIhkIGK9+42kC3nYFAKlwkqWKprQhi/lcTq/gYyqqA6hukwFDVRrGoKXdmtut
         6VJ+9msC6dAE5lxFhNUqId+58wnmYJuulsVUXT7LnMMIdNXLeNPGV45B/LyTu975UPil
         T5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYXuxSWUELpOlSOWdi8CjhU75SC2tpQSXkTcTi0j8UY=;
        b=ToiM/reoEYvlRahhj6VNgv6NRK7u0jrTKUnnsgHBIjvMX5XxEELwpJXuv9OEEwsCc+
         bohqj8Yrso8dbjUcYtJTe32TM+D9Z08YvpwFrnZtMPQ2yXtpzQPyCfnxU5z94xUQX1vS
         vRyw5efgQ138BJbTqCDhd0WgHUC75RwMcqZ+5XrZHpqATwqZC99sjaHD8gBhUIu7BNox
         1aXXzsqNxo+dehwtPm8ZfLROz+r6N/nccfIcA8yrAlGN7gUOrzGAoYyHDSSXmtjGFaFV
         2iUeVNPA5ahSIozB8WOlPFrbaRlhCPGhhzsdesEtHxKaoICMB8rqcdzgwtfEp9ZAqqji
         Dk9g==
X-Gm-Message-State: ACrzQf3COeBRbqr0Uu8OI8ykzlmdBxjoaykJ9dQtwL9p8BJNa8ZJMtgW
        b4CTSrIq764UnusUJT6OpzY=
X-Google-Smtp-Source: AMsMyM6GYFNlk+XCql3E10DfU99OfAvWQrk8kK/L3GWHIDg3bZu+THGZh/jM495To/ZADVYWwdPm1Q==
X-Received: by 2002:a05:6000:1aca:b0:231:d8e5:5bde with SMTP id i10-20020a0560001aca00b00231d8e55bdemr2941112wry.446.1665580191765;
        Wed, 12 Oct 2022 06:09:51 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id l15-20020adfe58f000000b0022ac119fcc5sm13281436wrm.60.2022.10.12.06.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:09:51 -0700 (PDT)
Message-ID: <9713ca36-7658-f044-9369-cc6200b34d1b@gmail.com>
Date:   Wed, 12 Oct 2022 14:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 09/22] run-command API: make "n" parameter a "size_t"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <patch-v2-09.22-a900711270c-20221012T084850Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v2-09.22-a900711270c-20221012T084850Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 12/10/2022 10:01, Ævar Arnfjörð Bjarmason wrote:
> Make the "n" variable added in c553c72eed6 (run-command: add an
> asynchronous parallel child processor, 2015-12-15) a "size_t". As
> we'll see in a subsequent commit we do pass "0" here, but never "jobs
> < 0".

This feels like a pretty arbitrary change that is not related to 
converting run_processes_parallel() to take a struct of options. There 
must be lots of places in the code base where we use int to pass a 
non-negative number around and int is more than wide enough to hold the 
number of jobs.

Best Wishes

Phillip

> We could have made it an "unsigned int", but as we're having to change
> this let's not leave another case in the codebase where a size_t and
> "unsigned int" size differ on some platforms. In this case it's likely
> to never matter, but it's easier to not need to worry about it.
> 
> After this and preceding changes:
> 
> 	make run-command.o DEVOPTS=extra-all CFLAGS=-Wno-unused-parameter
> 
> Only has one (and new) -Wsigned-compare warning, about a comparison of
> "i" to online_cpus(), a subsequent commit will adjust & deal with
> online_cpus() and that warning.
> 
> The only users of the "n" parameter are:
> 
>   * builtin/fetch.c: defaults to 1, reads from the "fetch.parallel"
>     config. As seen in the code that parses the config added in
>     d54dea77dba (fetch: let --jobs=<n> parallelize --multiple, too,
>     2019-10-05) will die if the git_config_int() return value is < 0.
> 
>     It will however pass us n = 0, as we'll see in a subsequent commit.
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
>     value is < 0, but like builtin/fetch.c it will pass us n = 0.
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
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   run-command.c | 44 ++++++++++++++++++--------------------------
>   run-command.h |  4 ++--
>   2 files changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 7b27e4de78d..5a63008b6e1 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1498,8 +1498,8 @@ int run_processes_parallel_ungroup;
>   struct parallel_processes {
>   	void *data;
>   
> -	int max_processes;
> -	int nr_processes;
> +	size_t max_processes;
> +	size_t nr_processes;
>   
>   	get_next_task_fn get_next_task;
>   	start_failure_fn start_failure;
> @@ -1520,7 +1520,7 @@ struct parallel_processes {
>   	unsigned shutdown : 1;
>   	unsigned ungroup : 1;
>   
> -	int output_owner;
> +	size_t output_owner;
>   	struct strbuf buffered_output; /* of finished children */
>   };
>   
> @@ -1541,9 +1541,7 @@ static int default_task_finished(int result,
>   
>   static void kill_children(struct parallel_processes *pp, int signo)
>   {
> -	int i, n = pp->max_processes;
> -
> -	for (i = 0; i < n; i++)
> +	for (size_t i = 0; i < pp->max_processes; i++)
>   		if (pp->children[i].state == GIT_CP_WORKING)
>   			kill(pp->children[i].process.pid, signo);
>   }
> @@ -1558,20 +1556,19 @@ static void handle_children_on_signal(int signo)
>   }
>   
>   static void pp_init(struct parallel_processes *pp,
> -		    int n,
> +		    size_t n,
>   		    get_next_task_fn get_next_task,
>   		    start_failure_fn start_failure,
>   		    task_finished_fn task_finished,
>   		    void *data, int ungroup)
>   {
> -	int i;
> -
>   	if (n < 1)
>   		n = online_cpus();
>   
>   	pp->max_processes = n;
>   
> -	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
> +	trace_printf("run_processes_parallel: preparing to run up to %"PRIuMAX" tasks",
> +		     (uintmax_t)n);
>   
>   	pp->data = data;
>   	if (!get_next_task)
> @@ -1592,7 +1589,7 @@ static void pp_init(struct parallel_processes *pp,
>   		CALLOC_ARRAY(pp->pfd, n);
>   	strbuf_init(&pp->buffered_output, 0);
>   
> -	for (i = 0; i < n; i++) {
> +	for (size_t i = 0; i < n; i++) {
>   		strbuf_init(&pp->children[i].err, 0);
>   		child_process_init(&pp->children[i].process);
>   		if (pp->pfd) {
> @@ -1607,10 +1604,8 @@ static void pp_init(struct parallel_processes *pp,
>   
>   static void pp_cleanup(struct parallel_processes *pp)
>   {
> -	int i;
> -
>   	trace_printf("run_processes_parallel: done");
> -	for (i = 0; i < pp->max_processes; i++) {
> +	for (size_t i = 0; i < pp->max_processes; i++) {
>   		strbuf_release(&pp->children[i].err);
>   		child_process_clear(&pp->children[i].process);
>   	}
> @@ -1637,7 +1632,8 @@ static void pp_cleanup(struct parallel_processes *pp)
>    */
>   static int pp_start_one(struct parallel_processes *pp)
>   {
> -	int i, code;
> +	size_t i;
> +	int code;
>   
>   	for (i = 0; i < pp->max_processes; i++)
>   		if (pp->children[i].state == GIT_CP_FREE)
> @@ -1685,8 +1681,6 @@ static int pp_start_one(struct parallel_processes *pp)
>   
>   static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>   {
> -	int i;
> -
>   	while (poll(pp->pfd, pp->max_processes, output_timeout) < 0) {
>   		if (errno == EINTR)
>   			continue;
> @@ -1695,7 +1689,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>   	}
>   
>   	/* Buffer output from all pipes. */
> -	for (i = 0; i < pp->max_processes; i++) {
> +	for (size_t i = 0; i < pp->max_processes; i++) {
>   		if (pp->children[i].state == GIT_CP_WORKING &&
>   		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
>   			int n = strbuf_read_once(&pp->children[i].err,
> @@ -1712,7 +1706,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>   
>   static void pp_output(struct parallel_processes *pp)
>   {
> -	int i = pp->output_owner;
> +	size_t i = pp->output_owner;
>   
>   	if (pp->children[i].state == GIT_CP_WORKING &&
>   	    pp->children[i].err.len) {
> @@ -1723,8 +1717,8 @@ static void pp_output(struct parallel_processes *pp)
>   
>   static int pp_collect_finished(struct parallel_processes *pp)
>   {
> -	int i, code;
> -	int n = pp->max_processes;
> +	int code;
> +	size_t i, n = pp->max_processes;
>   	int result = 0;
>   
>   	while (pp->nr_processes > 0) {
> @@ -1781,7 +1775,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
>   	return result;
>   }
>   
> -void run_processes_parallel(int n,
> +void run_processes_parallel(size_t n,
>   			    get_next_task_fn get_next_task,
>   			    start_failure_fn start_failure,
>   			    task_finished_fn task_finished,
> @@ -1815,9 +1809,7 @@ void run_processes_parallel(int n,
>   		if (!pp.nr_processes)
>   			break;
>   		if (ungroup) {
> -			int i;
> -
> -			for (i = 0; i < pp.max_processes; i++)
> +			for (size_t i = 0; i < pp.max_processes; i++)
>   				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
>   		} else {
>   			pp_buffer_stderr(&pp, output_timeout);
> @@ -1834,7 +1826,7 @@ void run_processes_parallel(int n,
>   	pp_cleanup(&pp);
>   }
>   
> -void run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
> +void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
>   				start_failure_fn start_failure,
>   				task_finished_fn task_finished, void *pp_cb,
>   				const char *tr2_category, const char *tr2_label)
> diff --git a/run-command.h b/run-command.h
> index e76a1b6b5b3..6f7604e1146 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -485,12 +485,12 @@ typedef int (*task_finished_fn)(int result,
>    * API reads that setting.
>    */
>   extern int run_processes_parallel_ungroup;
> -void run_processes_parallel(int n,
> +void run_processes_parallel(size_t n,
>   			    get_next_task_fn,
>   			    start_failure_fn,
>   			    task_finished_fn,
>   			    void *pp_cb);
> -void run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
> +void run_processes_parallel_tr2(size_t n, get_next_task_fn, start_failure_fn,
>   				task_finished_fn, void *pp_cb,
>   				const char *tr2_category, const char *tr2_label);
>   

