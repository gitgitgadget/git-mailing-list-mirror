Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FAA1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 13:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfKGNbA (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 08:31:00 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46866 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbfKGNbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 08:31:00 -0500
Received: by mail-qv1-f67.google.com with SMTP id w11so752080qvu.13
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gG/yBJf9q0YJi8xvqy46hmo1hx9LKlxvylltn7jSUPc=;
        b=gVpt61gC6pPuB7c6LxMGWesaxDzljydCblBUGCubHQuEtGQ8rxFstdE2JAmWp5yJ4d
         t7Lug5uOeJNHNiUCenwzu7LJMcuOdCcXp4efX1vaRvhbqbpfw4s5glyW86cm4e2uxAmy
         LpR4a9nhlZTkIz8Kvwi0UrM1tfbzguMD/CzkRCH213d1bEGPwkiSu7u6P+/PwgMfxjj5
         u/+Ddnsq6h6koda5G7IQrcguE62+NfyhFKTBYn9V403dvA+xzhbj+Jmzey+BPUrTJwJf
         97isxYViA5fptXvq8/eetS+ucDJFWEooAeqmDV+FEiE1MW77VOp2ebMmYQee8YTjDpVH
         aPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gG/yBJf9q0YJi8xvqy46hmo1hx9LKlxvylltn7jSUPc=;
        b=ls9d0Pc7acqKLFpUd38s6HrZCOqbSO0cIalTcfx3+UKVgblVLah7FYyeW3+aujrxDf
         HGABKhgssbDcFLJXbkjI9ECRvl0XA3nBBeCFMwOl/8vZRoC73mIYmWEIOSJ0b6Y/o/Q5
         1RBCQNqKLw0AHmx+0qhtSABo3/DZABVQcLOEPIrCiVu7IiwJ4KMLQSUw5e+5to52Prfc
         y1FWJLR/Be9/SyTyBnkF+2bmf1cczzQ4FZ5F99sftLt+U/Aii47echZprNgIm4on7Zmz
         Sy/DVkssRJvRa5U4aZl8QS24YzWoN4rrVRdaDor3rCMh+8VNbYIblbubxqB23gGYlew4
         pMsQ==
X-Gm-Message-State: APjAAAWuEsOXucAFdjaqez8D/l/PxYuR4XBglHnHUYFco4kxE2BuTzW6
        VHu34Ysg01hNtW+wNFBFLz8=
X-Google-Smtp-Source: APXvYqyKIh3Ysp0coiba56+XmfqzgxPeDXO1mqdEy1WuF8GbfXpDLd197OyxV+GVzXJ2c1Vs0JrSLg==
X-Received: by 2002:ad4:57ae:: with SMTP id g14mr3307235qvx.95.1573133457755;
        Thu, 07 Nov 2019 05:30:57 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:79c3:ae99:aa6:30a4? ([2001:4898:a800:1010:2af9:ae99:aa6:30a4])
        by smtp.gmail.com with ESMTPSA id j3sm1581628qke.25.2019.11.07.05.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 05:30:57 -0800 (PST)
Subject: Re: [PATCH v2 1/1] commit-graph: use start_delayed_progress()
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, rynus@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
 <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
 <78bd6bc2c02f1daf13938a738d8eae56b5f6b74c.1572984842.git.gitgitgadget@gmail.com>
 <20191106040955.GD4307@sigill.intra.peff.net>
 <832b3b8b-63e6-1d32-0013-158b3c6725c8@gmail.com>
 <20191107064058.GG6431@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <29e88f9c-2b35-efe6-9be1-2891061a7109@gmail.com>
Date:   Thu, 7 Nov 2019 08:30:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191107064058.GG6431@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/2019 1:40 AM, Jeff King wrote:
> On Wed, Nov 06, 2019 at 08:21:48AM -0500, Derrick Stolee wrote:
> 
>>>> Now that we changed this method, very fast commands show no progess at
>>>> all. This means we need to stop testing for seeing these progress lines
>>>> in the test suite.
>>>
>>> I think this is OK for now, though it does make me wonder if
>>> "--progress" ought to perhaps override "delayed" in some instances,
>>> since it's a positive signal from the caller that they're interested in
>>> seeing progress.
>>
>> I was thinking that we could start with a GIT_TEST_PROGRESS environment
>> variable to force all delayed progress to act like non-delayed progress.
>> That would at least give us confirmation on these kinds of tests.
> 
> I think this could actually be a non-test variable. E.g., something like
> this:
> 
> diff --git a/progress.c b/progress.c
> index 0063559aab..74b90e8898 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -14,6 +14,7 @@
>  #include "strbuf.h"
>  #include "trace.h"
>  #include "utf8.h"
> +#include "config.h"
>  
>  #define TP_IDX_MAX      8
>  
> @@ -269,7 +270,8 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
>  
>  struct progress *start_delayed_progress(const char *title, uint64_t total)
>  {
> -	return start_progress_delay(title, total, 2, 0);
> +	int delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 2);
> +	return start_progress_delay(title, total, delay_in_secs, 0);
>  }
>  
>  struct progress *start_progress(const char *title, uint64_t total)

I like this idea. It allows us to force the progress on in tests, and for
users to tweak their preferred delay. That includes _increasing_ the delay
if they want to.

> which lets you ask for more verbose progress. There are times when I'd
> use something like this for general debugging. Though these days I might
> suggest that something like GIT_TRACE2_PERF hook the progress code to
> output. That's a bit more complicated to implement, though.

Would it make sense to make delay_in_secs a local static variable, so we
remember it between calls? That would allow us to check the environment only
once (not that it is usually expensive).

-Stolee
