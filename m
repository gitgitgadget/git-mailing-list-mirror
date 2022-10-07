Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B727C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJGJoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJGJoB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:44:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00DA0326
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:44:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk15so6400592wrb.13
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5pqrgS6yhJQeb9B3Vv2ISJWtZ3Yzwfg/U1xo/TGDPtE=;
        b=B057Wg64/K2goWGM0bJam+sXXm2XFNF4ISFOSEQpPmwma2/DTuJPckinOfrUSJPEpb
         71fxjEXHWxhqrvXNcLhiolgmN2Y8c2Nrz2nH+1x7qNy7UNtv0KIkIczbwqgjzhfYeNm3
         Ompk5Bvfg8vXbwUB+gzrPSOZrIdND5Q4mJDBlxEg8uyH9GJAFsBEQXrepbOJ33WPRScz
         U+7YI0pkpQBkhdtUtnIzRsiEus5M9w1E2p3T8AwhhySTKgnI5iLPfAcmImdVD+L9sPjf
         2hfN7QiSrobwc/9v7DtHC4XbM38deGG8os/sN+gz5eEAOwv0GTq012MQTYuD1qR8uUDa
         Jh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pqrgS6yhJQeb9B3Vv2ISJWtZ3Yzwfg/U1xo/TGDPtE=;
        b=quNw1xtpzwgu6RR74FLRnJCKSKp2EkAZkjZ+2WC2JIKl+WqFAW4ipzJseBDyvQzcpI
         8TQx2raIIABTymd6ITwaR71sLunPz2tGGwPzx2xvi6EvMbZ+qhPwpIFE4AnfhCATdKay
         woC6qfDJoUyVY5BlcfKWh9sTh/cBZjk0UDqbuKx181zPI49LOt5aMiSwQ++U1J2JPoS8
         hQmShh9D7GnqIaOZsoo2n+iNQc1qM7MO6SYYdfvNaIGkAJ48YAMgMqf8EGpjOrIdH2P0
         1/03nppCtooZ/drEUOlQdLbkmIhJdsOkQNtBQfFMRNBEr/SeL4mGpyhHtH5Gedy0XE+I
         pAPA==
X-Gm-Message-State: ACrzQf0x1q9GpOuARuIg8XOnoVps2TICc6HNn8DQZqc+2Oakbl+zueNa
        MOHhqbqBeCLrx68tCMWSngFSqsb0qk0=
X-Google-Smtp-Source: AMsMyM4cUgy7gYgJcT8tKflZF0CIU+aqGw1QeUSMtEcOyWOrEaNzjMO23OJRbRqx1EJSWqGusHWd8g==
X-Received: by 2002:a05:6000:1a8b:b0:22a:cb74:eaea with SMTP id f11-20020a0560001a8b00b0022acb74eaeamr2652153wry.253.1665135839164;
        Fri, 07 Oct 2022 02:43:59 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id t13-20020a5d42cd000000b00226dfac0149sm1491149wrr.114.2022.10.07.02.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 02:43:58 -0700 (PDT)
Message-ID: <7f407b30-cce6-9339-ed30-e40bf1663577@gmail.com>
Date:   Fri, 7 Oct 2022 10:43:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 06/15] run-command API: have
 "run_processes_parallel{,_tr2}()" return void
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <patch-06.15-c86dc59d07c-20220930T111343Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-06.15-c86dc59d07c-20220930T111343Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/09/2022 12:28, Ævar Arnfjörð Bjarmason wrote:
> Change the "run_processes_parallel{,_tr2}()" functions to return void,
> instead of int. Ever since c553c72eed6 (run-command: add an
> asynchronous parallel child processor, 2015-12-15) they have
> unconditionally returned 0.
> 
> To get a "real" return value out of this function the caller needs to
> get it via the "task_finished_fn" callback, see the example in hook.c
> added in 96e7225b310 (hook: add 'run' subcommand, 2021-12-22).
> 
> So the "result = " and "if (!result)" code added to "builtin/fetch.c"
> d54dea77dba (fetch: let --jobs=<n> parallelize --multiple, too,
> 2019-10-05) has always been redundant, we always took that "if"
> path. Likewise the "ret =" in "t/helper/test-run-command.c" added in
> be5d88e1128 (test-tool run-command: learn to run (parts of) the
> testsuite, 2019-10-04) wasn't used, instead we got the return value
> from the "if (suite.failed.nr > 0)" block seen in the context.
> 
> Subsequent commits will alter this API interface, getting rid of this
> always-zero return value makes it easier to understand those changes.

This looks good, having a fixed return value is confusing.

Phillip

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/fetch.c             | 17 ++++++++---------
>   run-command.c               | 27 +++++++++++----------------
>   run-command.h               | 16 ++++++++--------
>   t/helper/test-run-command.c |  4 ++--
>   4 files changed, 29 insertions(+), 35 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a0fca93bb6a..78043fb67ef 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1953,15 +1953,14 @@ static int fetch_multiple(struct string_list *list, int max_children)
>   		struct parallel_fetch_state state = { argv.v, list, 0, 0 };
>   
>   		strvec_push(&argv, "--end-of-options");
> -		result = run_processes_parallel_tr2(max_children,
> -						    &fetch_next_remote,
> -						    &fetch_failed_to_start,
> -						    &fetch_finished,
> -						    &state,
> -						    "fetch", "parallel/fetch");
> -
> -		if (!result)
> -			result = state.result;
> +		run_processes_parallel_tr2(max_children,
> +					   &fetch_next_remote,
> +					   &fetch_failed_to_start,
> +					   &fetch_finished,
> +					   &state,
> +					   "fetch", "parallel/fetch");
> +
> +		result = state.result;
>   	} else
>   		for (i = 0; i < list->nr; i++) {
>   			const char *name = list->items[i].string;
> diff --git a/run-command.c b/run-command.c
> index 5ec3a46dccf..642e6b6e057 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1783,11 +1783,11 @@ static int pp_collect_finished(struct parallel_processes *pp)
>   	return result;
>   }
>   
> -int run_processes_parallel(int n,
> -			   get_next_task_fn get_next_task,
> -			   start_failure_fn start_failure,
> -			   task_finished_fn task_finished,
> -			   void *pp_cb)
> +void run_processes_parallel(int n,
> +			    get_next_task_fn get_next_task,
> +			    start_failure_fn start_failure,
> +			    task_finished_fn task_finished,
> +			    void *pp_cb)
>   {
>   	int i, code;
>   	int output_timeout = 100;
> @@ -1834,25 +1834,20 @@ int run_processes_parallel(int n,
>   	}
>   
>   	pp_cleanup(&pp);
> -	return 0;
>   }
>   
> -int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
> -			       start_failure_fn start_failure,
> -			       task_finished_fn task_finished, void *pp_cb,
> -			       const char *tr2_category, const char *tr2_label)
> +void run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
> +				start_failure_fn start_failure,
> +				task_finished_fn task_finished, void *pp_cb,
> +				const char *tr2_category, const char *tr2_label)
>   {
> -	int result;
> -
>   	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
>   				   ((n < 1) ? online_cpus() : n));
>   
> -	result = run_processes_parallel(n, get_next_task, start_failure,
> -					task_finished, pp_cb);
> +	run_processes_parallel(n, get_next_task, start_failure,
> +			       task_finished, pp_cb);
>   
>   	trace2_region_leave(tr2_category, tr2_label, NULL);
> -
> -	return result;
>   }
>   
>   int run_auto_maintenance(int quiet)
> diff --git a/run-command.h b/run-command.h
> index 0e85e5846a5..e76a1b6b5b3 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -485,14 +485,14 @@ typedef int (*task_finished_fn)(int result,
>    * API reads that setting.
>    */
>   extern int run_processes_parallel_ungroup;
> -int run_processes_parallel(int n,
> -			   get_next_task_fn,
> -			   start_failure_fn,
> -			   task_finished_fn,
> -			   void *pp_cb);
> -int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
> -			       task_finished_fn, void *pp_cb,
> -			       const char *tr2_category, const char *tr2_label);
> +void run_processes_parallel(int n,
> +			    get_next_task_fn,
> +			    start_failure_fn,
> +			    task_finished_fn,
> +			    void *pp_cb);
> +void run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
> +				task_finished_fn, void *pp_cb,
> +				const char *tr2_category, const char *tr2_label);
>   
>   /**
>    * Convenience function which prepares env for a command to be run in a
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index ebda2203408..c431e3094df 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -192,8 +192,8 @@ static int testsuite(int argc, const char **argv)
>   	fprintf(stderr, "Running %"PRIuMAX" tests (%d at a time)\n",
>   		(uintmax_t)suite.tests.nr, max_jobs);
>   
> -	ret = run_processes_parallel(max_jobs, next_test, test_failed,
> -				     test_finished, &suite);
> +	run_processes_parallel(max_jobs, next_test, test_failed,
> +			       test_finished, &suite);
>   
>   	if (suite.failed.nr > 0) {
>   		ret = 1;

