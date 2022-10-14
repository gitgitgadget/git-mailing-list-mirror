Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C887C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 09:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJNJaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 05:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJNJaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 05:30:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAC3684C
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:30:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b4so6703166wrs.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=taxVqoJPLlYHwH3tY+N6sDvF8TNeiQTRiunk6Eobr6o=;
        b=N1vt4J6OG7CHX9hLvXymgRv4CWMB2iGjTAd/7EoLLdFzIGwT5QeWFpL7PcP7Z+gdU1
         0EfFZZgwgLl3oNP64j37KBlu1LeCQqm5nOLCTFxF7XStaoPbT8FcMcGSxT7jjE5DU0ZR
         BMEQmDtPB9QmlhwoXdkZCIMJIiCo9UKvpFDWONQGSZoeQClIJid64aMIrDz4EzscxzEa
         qjo5Rgq+C7+DKJtof9+O4wZtHVjGogbHO5hQDVfsxNHSZDHg9KfaD9z5egma8aQTSm8w
         bbDWjZ0clqH5AY3B9XFJ6g/9Gs0Y504I3txhgnRLh84AUP6oLMYQbymv8ZIChGLnWhgo
         Fkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taxVqoJPLlYHwH3tY+N6sDvF8TNeiQTRiunk6Eobr6o=;
        b=tG1g3GZ0bH+kk8xxsDZ6yWFM71M0Z2PCegdOmZcHQTTQEPl+Vp/UhEPqLC5R2x3V0z
         fGQxKBsqSJZKo2GKiMxFtGSA1P18HNm6m9uk4sCe7DwJUsOXDvqnKmKGQm7cNB4arCWn
         6shuQfKCwHYeXXH1PLM/GL/jwKrCfRE43BxKmJ9rzMOTmeNnq6REC4HhPv0pFM7KNtbo
         IOtW6wc/uNPjK45eGPZwkmyQCOsS+bQKo3HMmnnRRRwWsne7KSZ7wOZRsGSDnYywlbqQ
         5Q7AIHGWWOn30jU0q0C07KNPR33p3boP2n8ih4/oWEaKVCqvOEcxQBvnu0fL+4XVXM5q
         pKNA==
X-Gm-Message-State: ACrzQf3q5YSG/MwERx6cI0n3VSfPpNDva1CmkKLMoueXyewBWpVCERpq
        KyXg2eE4H4daYhxe7DwpV9Y=
X-Google-Smtp-Source: AMsMyM45MNrpnk2uIKfNBEAniGqRpY/vIHDCPD2t3guGWBLxDBje4nefhzRQW7/jNrTTxL547AboHg==
X-Received: by 2002:adf:dec3:0:b0:22e:6efe:7861 with SMTP id i3-20020adfdec3000000b0022e6efe7861mr2742340wrn.454.1665739806521;
        Fri, 14 Oct 2022 02:30:06 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id t65-20020a1c4644000000b003b505d26776sm6447791wma.5.2022.10.14.02.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 02:30:06 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a7463bc5-9a92-8f0f-c0ee-e72fbbeedc09@dunelm.org.uk>
Date:   Fri, 14 Oct 2022 10:30:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 04/15] run-command API: make "n" parameter a "size_t"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
 <patch-v3-04.15-58018a79b2f-20221012T205712Z-avarab@gmail.com>
In-Reply-To: <patch-v3-04.15-58018a79b2f-20221012T205712Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2022 22:02, Ævar Arnfjörð Bjarmason wrote:
> Make the "n" variable added in c553c72eed6 (run-command: add an
> asynchronous parallel child processor, 2015-12-15) a "size_t". As
> we'll see in a subsequent commit we do pass "0" here, but never "jobs
> < 0".
> 
> We could have made it an "unsigned int", but as we're having to change
> this let's not leave another case in the codebase where a size_t and
> "unsigned int" size differ on some platforms. In this case it's likely
> to never matter, but it's easier to not need to worry about it.
> 
> After this and preceding changes:
> 
> 	make run-command.o DEVOPTS=extra-all CFLAGS=-Wno-unused-parameter
> 
> Only has one (and new) -Wsigned-compare warning relevant to a
> comparison about our "n" or "{nr,max}_processes": About using our
> "n" (size_t) in the same expression as online_cpus() (int). A
> subsequent commit will adjust & deal with online_cpus() and that
> warning.

I've changed my mind a bit on this patch. Previously I thought it was 
just unnecessary, now I think it is actually going in the wrong 
direction. You have not changed any of the call sites which are all 
still passing an int, so you are introducing a bunch of signed->unsigned 
conversions. Before this patch we could have caught a negative value of 
n with an assertion. After this patch a negative value passed will 
become a large positive value (you have audited the current callers but 
that does not protect us from future mistakes). To be clear I think 
dropping this patch is the right way forward, not changing all the 
callers. Using an int for the number of processes seems perfectly 
reasonable and matches what all the callers are using.

Best Wishes

Phillip

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
>   run-command.c | 42 ++++++++++++++++++------------------------
>   run-command.h |  4 ++--
>   2 files changed, 20 insertions(+), 26 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 642e6b6e057..14a6e38e804 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1500,8 +1500,8 @@ int run_processes_parallel_ungroup;
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
> @@ -1522,7 +1522,7 @@ struct parallel_processes {
>   	unsigned shutdown : 1;
>   	unsigned ungroup : 1;
>   
> -	int output_owner;
> +	size_t output_owner;
>   	struct strbuf buffered_output; /* of finished children */
>   };
>   
> @@ -1543,9 +1543,7 @@ static int default_task_finished(int result,
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
> @@ -1560,20 +1558,19 @@ static void handle_children_on_signal(int signo)
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
> @@ -1594,7 +1591,7 @@ static void pp_init(struct parallel_processes *pp,
>   		CALLOC_ARRAY(pp->pfd, n);
>   	strbuf_init(&pp->buffered_output, 0);
>   
> -	for (i = 0; i < n; i++) {
> +	for (size_t i = 0; i < n; i++) {
>   		strbuf_init(&pp->children[i].err, 0);
>   		child_process_init(&pp->children[i].process);
>   		if (pp->pfd) {
> @@ -1609,10 +1606,8 @@ static void pp_init(struct parallel_processes *pp,
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
> @@ -1639,7 +1634,8 @@ static void pp_cleanup(struct parallel_processes *pp)
>    */
>   static int pp_start_one(struct parallel_processes *pp)
>   {
> -	int i, code;
> +	size_t i;
> +	int code;
>   
>   	for (i = 0; i < pp->max_processes; i++)
>   		if (pp->children[i].state == GIT_CP_FREE)
> @@ -1697,7 +1693,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>   	}
>   
>   	/* Buffer output from all pipes. */
> -	for (i = 0; i < pp->max_processes; i++) {
> +	for (size_t i = 0; i < pp->max_processes; i++) {
>   		if (pp->children[i].state == GIT_CP_WORKING &&
>   		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
>   			int n = strbuf_read_once(&pp->children[i].err,
> @@ -1714,7 +1710,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>   
>   static void pp_output(struct parallel_processes *pp)
>   {
> -	int i = pp->output_owner;
> +	size_t i = pp->output_owner;
>   
>   	if (pp->children[i].state == GIT_CP_WORKING &&
>   	    pp->children[i].err.len) {
> @@ -1725,8 +1721,8 @@ static void pp_output(struct parallel_processes *pp)
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
> @@ -1783,7 +1779,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
>   	return result;
>   }
>   
> -void run_processes_parallel(int n,
> +void run_processes_parallel(size_t n,
>   			    get_next_task_fn get_next_task,
>   			    start_failure_fn start_failure,
>   			    task_finished_fn task_finished,
> @@ -1817,9 +1813,7 @@ void run_processes_parallel(int n,
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
> @@ -1836,7 +1830,7 @@ void run_processes_parallel(int n,
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
