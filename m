Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4324EC43460
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1149561076
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 16:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhDWQTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhDWQTp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 12:19:45 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2CFC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 09:19:08 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso43842557otb.13
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZHAMi+ZlTFAG034iOI1hIA5L7F3bwnODJhUrmeNZAeY=;
        b=qN+NPjB/8JFk9XxhY5yvaZpfl4SYF4eM9HXSawNK+iVE9Qylx+m00gOyh/onkTuL4A
         Ic8ZH/XAO5bFEEOYkgrUx/eTLj9xoZATcCfCmYIrl+cg2uk52sRvR6hAwSAoO7ZKdGzH
         6f7iqFW4BjB6pn80F/uNGOI1/X6MEZWUoClUWdCvS4WZZzF1hlJZ+jymh0XKtSnoliBF
         o5yZ/2vZ+YK1fX4HX0r0qICIvo5UbFOVjA4WtRmDAeFNDh1oeP0Bjtn6DZK2a6be6mOH
         z90ae2otzS1sFT5vagtdkziOHb1cUU+9j9yKyy9wgwHd6TNckvEU7NyyTjwxHbyzGP9i
         ypiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZHAMi+ZlTFAG034iOI1hIA5L7F3bwnODJhUrmeNZAeY=;
        b=hH4XYd3lGe3GwguJaAB7HZpt5XoFmO0bIEHrR4I+goAUttcFoHKYa8CM/8zdxxviPI
         Eg9EVx/XPZnb08RTYdDj3kbD8hnW2cEGSEoJp+N+7yL2Qp59BWNa/aQuLELYpVU3Kw41
         pfoHsfNbyxeP/oufeIROidDTA/2nHG840xTyl+KEy9/mb69r9aYrEeRa7L3Qe9IJG+66
         oATpM39aWU+nhJD2icMEGFVyDcw4PyKWgO3UthNQb0NBDnotYBTTJXLUUXcoksPKYAiE
         eb5gB+rvK3qUZthuBLPfNEqrmufmfnwAXZiCNy2mLXgu3OKMNhQu6f6DeLafg+JOWwlh
         I2Cg==
X-Gm-Message-State: AOAM53397xtKes62iJo6xa3lBCvsPAL/JX7jlNd0RdW09LTB2ZgqHY8H
        uV1TzhHdinVLsnOiTeK8waU=
X-Google-Smtp-Source: ABdhPJwMFG73hqyLzYsH/REufPsO3UMh2limalm8V3wGGvKPi3w5VM8RqPePaAXyFyTiXQ1dG+5XqQ==
X-Received: by 2002:a05:6830:781:: with SMTP id w1mr4064122ots.300.1619194748175;
        Fri, 23 Apr 2021 09:19:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3de1:cfe2:170e:4cb9? ([2600:1700:e72:80a0:3de1:cfe2:170e:4cb9])
        by smtp.gmail.com with ESMTPSA id q1sm1441898otm.26.2021.04.23.09.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 09:19:07 -0700 (PDT)
Subject: Re: [PATCH 2/7] builtin/checkout.c: complete parallel checkout
 support
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <5e0dee7beba083159f4277ddcd9e931859239bde.1619104091.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <058f6ca4-a575-a463-e29b-9071c35e5bd3@gmail.com>
Date:   Fri, 23 Apr 2021 12:19:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5e0dee7beba083159f4277ddcd9e931859239bde.1619104091.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/22/2021 11:17 AM, Matheus Tavares wrote:
> There is one code path in builtin/checkout.c which still doesn't benefit
> from parallel checkout because it calls checkout_entry() directly,> instead of unpack_trees(). Let's add parallel checkout support for this
> missing spot as well.

I couldn't tell immediately from the patch what would trigger this
code path. I had to trace the method calls to discover that it is
for the case of a pathspec-limited checkout:

	git checkout <ref> -- <pathspec>

I confirmed that this does work with this change, but it might be
nice to have a test that verifies that parallelism is triggering for
this case.

Looking ahead to patches 4-6, which add tests, I do not see one for this
code path. Yes, patch 7 will implicitly test it through optional
settings, but it would be nice to verify that the code is actually using
parallel workers. The test_checkout_workers helper in patch 4 should be
helpful for this effort.

Please point out the test that covers this case, in case I'm just not
seeing it.

The good news is that I can see a difference. By alternating checkouts
of the Git repository's "t" directory between v2.20 and v2.31.1, I can
see these results for varying numbers of workers:

Benchmark #1: 16 workers
  Time (mean ± σ):     108.6 ms ±   5.2 ms    [User: 146.1 ms, System: 146.1 ms]
  Range (min … max):    95.5 ms … 124.9 ms    100 runs
 
Benchmark #2: 8 workers
  Time (mean ± σ):     104.8 ms ±   4.8 ms    [User: 128.3 ms, System: 131.7 ms]
  Range (min … max):    94.2 ms … 119.0 ms    100 runs
 
Benchmark #3: 4 workers
  Time (mean ± σ):     112.3 ms ±   6.2 ms    [User: 114.6 ms, System: 112.1 ms]
  Range (min … max):   100.0 ms … 127.4 ms    100 runs
 
Benchmark #4: 2 workers
  Time (mean ± σ):     124.2 ms ±   4.2 ms    [User: 106.5 ms, System: 102.0 ms]
  Range (min … max):   114.8 ms … 136.3 ms    100 runs
 
Benchmark #5: sequential
  Time (mean ± σ):     154.6 ms ±   6.7 ms    [User: 83.5 ms, System: 79.4 ms]
  Range (min … max):   142.1 ms … 176.0 ms    100 runs
 
Summary
  '8 workers' ran
    1.04 ± 0.07 times faster than '16 workers'
    1.07 ± 0.08 times faster than '4 workers'
    1.19 ± 0.07 times faster than '2 workers'
    1.48 ± 0.09 times faster than 'sequential'

(Note: these time measurements are for the round-trip of two checkout
commands.)
> @@ -359,16 +360,22 @@ static int checkout_worktree(const struct checkout_opts *opts,
>  	int nr_checkouts = 0, nr_unmerged = 0;
>  	int errs = 0;
>  	int pos;
> +	int pc_workers, pc_threshold;
> +	struct mem_pool ce_mem_pool;
>  
>  	state.force = 1;
>  	state.refresh_cache = 1;
>  	state.istate = &the_index;
>  
> +	mem_pool_init(&ce_mem_pool, 0);
> +	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
>  	init_checkout_metadata(&state.meta, info->refname,
>  			       info->commit ? &info->commit->object.oid : &info->oid,
>  			       NULL);
>  
>  	enable_delayed_checkout(&state);
> +	if (pc_workers > 1)
> +		init_parallel_checkout();

I'm late to looking at your parallel checkout work, but I find this
to be a really nice API to get things initialized.


>  			else if (opts->merge)
>  				errs |= checkout_merged(pos, &state,
> -							&nr_unmerged);
> +							&nr_unmerged,
> +							&ce_mem_pool);

I see the need to populate these merged entries in the pool for now,
before...

>  			pos = skip_same_name(ce, pos) - 1;
>  		}
>  	}
> +	if (pc_workers > 1)
> +		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
> +					      NULL, NULL);
> +	mem_pool_discard(&ce_mem_pool, should_validate_cache_entries());
...now running the parallel checkout and discarding the entries.

Thanks,
-Stolee
