Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC87C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 13:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbiEYNTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244555AbiEYNTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 09:19:09 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163A1CFD8
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:18:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f4so3589538pgf.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5ZH6MMjTKSSFYdueAJ9YimMU+eJnlZeYr8TPVNDjrzU=;
        b=ejGY3JTNB3BUEIOngGgkJBeH8SsEglgEH3EZCc03wj/50+IphY+3G+dnyypKbAOrTy
         PyQ2jTy7CbxUeY4vsVlyp5zaON5Aj/ANC1z3D5vvbtiafk1dFgnrwLxGesaOQTjJGC2M
         3lFdU5Pp3Bsc49Uj3FZBRa3oU6zIynEH/oV8+WGb0DrNwN0s2BeghsRu8cmXh4e30TKo
         mJAw+CCKuCGCUa+Uob5o2AdnOH2QDxYMfIa91h8UocSLcZaLFoJ5OpfS25E1CoimSp5Z
         j71+qOe+/ac5oZMBtVMiJdSMqIqdwnbw+rySCo4VuqmXDN1R/pyWG7J5v75+bE7yUdkh
         SXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5ZH6MMjTKSSFYdueAJ9YimMU+eJnlZeYr8TPVNDjrzU=;
        b=xTtqCPx3stDaNb/5k4hM22OGrbgLNcUKF1wMCf8DzpWiWzoRLvcWeMKiymZmEc3VXW
         YQ85wIjMJqHQ2MsvrLCtQ2zHhVN7/O/UCGy8rjqe3YL4aD7ZxHESvwBqm0Uqr/WiMWPf
         IEfgZXb3l+8fdLunKU1S5MWn3wnSQwQPRt3sX7Q/v1kK3JpOu9uz5SDmqoVM4pUlUL2V
         6fpiO2w1Ox/m/iM3TRhZ29dByYaoWAEjG9ICsEBMVDxqDl9wsjK3AE1VdwVuH1qPEKHS
         RllSrPYoQajEjzi+62oEMLOkXtimn8ulR/4S6aHT/XgCFlSmcWX32ybtChJIotv86ZPx
         WDZg==
X-Gm-Message-State: AOAM530JWjIhYLVYiCo0wX7tp9Hb6EYhlSbT0RDPWuPZP1xlh+rAX09s
        Qj+UJFi8s0Nwf3fMmqmNgabJow==
X-Google-Smtp-Source: ABdhPJxVeDFCUH1bQQx0OZYdGkLuTwi7mjpkD8IMt3DoBRDCqe10aNJ8IX9eOH7j6ymath8woYu3oQ==
X-Received: by 2002:a65:6e44:0:b0:3db:219e:2250 with SMTP id be4-20020a656e44000000b003db219e2250mr28955858pgb.369.1653484723960;
        Wed, 25 May 2022 06:18:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:7c2b:742c:3d1a:bbb4])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902b11600b0015e8d4eb1ddsm9230724plr.39.2022.05.25.06.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:18:43 -0700 (PDT)
Date:   Wed, 25 May 2022 06:18:38 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/8] run-command API: use "opts" struct for
 run_processes_parallel{,_tr2}()
Message-ID: <Yo4sriq2YYtIsB0p@google.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
 <patch-v2-2.8-5f0a6e9925f-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-2.8-5f0a6e9925f-20220518T195858Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 18, 2022 at 10:05:18PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Add a new "struct run_process_parallel_opts" to replace the growing
> run_processes_parallel() and run_processes_parallel_tr2() argument
> lists. This refactoring makes it easier to add new options and
> parameters easier.
> 
> The *_tr2() variant of the function was added in ee4512ed481 (trace2:
> create new combined trace facility, 2019-02-22), and has subsequently
> been used by every caller except t/helper/test-run-command.c.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
[...]
> diff --git a/run-command.h b/run-command.h
> index 5bd0c933e80..b0268ed3db1 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -458,6 +458,32 @@ typedef int (*task_finished_fn)(int result,
>  				void *pp_task_cb);
>  
>  /**
> + * Options to pass to run_processes_parallel(), { 0 }-initialized
> + * means no options. Fields:
> + *
> + * tr2_category & tr2_label: sets the trace2 category and label for
> + * logging. These must either be unset, or both of them must be set.

I see this comment...

> + *
> + * jobs: see 'n' in run_processes_parallel() below.
> + *
> + * *_fn & data: see run_processes_parallel() below.
> + */
> +struct run_process_parallel_opts
> +{
> +	const char *tr2_category;
> +	const char *tr2_label;
> +
> +	int jobs;
> +
> +	get_next_task_fn get_next_task;
> +	start_failure_fn start_failure;
> +	task_finished_fn task_finished;
> +	void *data;
> +};

[moved snippet]
> -int run_processes_parallel(int n,
> -			   get_next_task_fn get_next_task,
> -			   start_failure_fn start_failure,
> -			   task_finished_fn task_finished,
> -			   void *pp_cb)
> +int run_processes_parallel(struct run_process_parallel_opts *opts)
>  {
>  	int i, code;
>  	int output_timeout = 100;
>  	int spawn_cap = 4;
>  	struct parallel_processes pp;
> +	const char *tr2_category = opts->tr2_category;
> +	const char *tr2_label = opts->tr2_label;
> +	const int do_trace2 = tr2_category && tr2_label;

...but it's not actually very well enforced here. That is, it seems I
can set one or the other but not both, and nothing bad will happen,
except that I am wasting my time setting one. If you want to enforce
them both to be set, then why not use a BUG()? But otherwise the comment
could be reworded, I think.

> +	const int n = opts->jobs;
>  
> -	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
> +	if (do_trace2)
> +		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
> +					   "max:%d", ((n < 1) ? online_cpus()
> +						      : n));
> +
> +	pp_init(&pp, opts);
>  	while (1) {
>  		for (i = 0;
>  		    i < spawn_cap && !pp.shutdown &&
[/moved snippet]


Otherwise, although the number of lines of code is often higher, I find
the named initializers in the struct much easier to read at the
callsites, so I like this change.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
