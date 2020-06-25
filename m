Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FD3C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 16:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A50F2089D
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 16:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAP9zjxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406016AbgFYQL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405929AbgFYQL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 12:11:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82FBC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 09:11:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j94so6463621wrj.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KvgIqFLY/v82av3+z6cFtye5tirkr8wXs+78mIeuwI4=;
        b=oAP9zjxUkzIElL/EDQGGDrPxfHyj81xPkHol4Q898xKK67lpbhiraeMy2UJYFcg6SQ
         6SLnXL4262bttmnEkCLr/Jn8l4zHbFzVApzuZjpgiqef0XNij3k57yaou9gdKtPM1L91
         rEDxo4e+diSjeqAY3CycZuyn+yqrClmx72Q6bX8CHnNRBQo/Ipnk/CBNz1ou3MB+5XaE
         Hw/wmvE6ultQWKv9ssykdHrEgWmfdNjFUKGQwSSM5r9QfJOEIH7fQALCcFasDWgNdVYA
         Bzt/sRaVxuX9AH8+fc32q/JQLoiqN61VGu0vjca8KCTom+gQD/c79VsBDjd5H5DRLXJk
         B3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KvgIqFLY/v82av3+z6cFtye5tirkr8wXs+78mIeuwI4=;
        b=iTa7VfI9U4hS19foCNFawy8Jsa39FCDd5M1xUJSxZraC1iruK19g5CxWZJZ9Dy/jJB
         HhVsM0ieuU2BA6aSkb4SY7t1MqgnagIpogfH9y860qEQDulK6jfr35uPDegVbNhYe79i
         tYAN8J7Qq+XrrH0ER7bs5nuEA3ArfobKs7zV6sZKFn36gqtrJhCd3xgxa4dAXX75sZU5
         3C+FLxlCHqv4waI4iBC/P3FFMSMPLKJIc2rl9LFpscBx9Qqn5+PEo+37+7IVow0Ragwb
         nyCPL6ZH/vu0OYm8UHUIZn9VoofzUGlQFAI3fdt81q4Dk9Mg0x84VyWsfji145rr0lC9
         ncNw==
X-Gm-Message-State: AOAM532QILT4z1siybijJtSD7/xv3E885tKtP8qup05B+jNEvCgdqY72
        kWCgtL7jucYlXQWTUwyL2xZCLM/E
X-Google-Smtp-Source: ABdhPJz0kjNNOJP/TdEEw5fAAkvv3YSLiD1Pu9dvyxlU0s3M0f/0gRyPZeWAe6ftm5IhzEPfRz2Lug==
X-Received: by 2002:a5d:54d1:: with SMTP id x17mr15495440wrv.140.1593101487502;
        Thu, 25 Jun 2020 09:11:27 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id u84sm984391wmg.7.2020.06.25.09.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 09:11:26 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v1 16/17] sequencer: use the "resolve" strategy
 without forking
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200625121953.16991-17-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6bee3870-a363-2f02-1319-4c0bee7dec95@gmail.com>
Date:   Thu, 25 Jun 2020 17:11:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625121953.16991-17-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 25/06/2020 13:19, Alban Gruin wrote:
> This teaches the sequencer to invoke the "resolve" strategy with a
> function call instead of forking.

This is a good idea, however we should check the existing tests that use 
this strategy to see if they are doing so to test the 
try_merge_command() code path. I've got some patches in seen that use 
'--strategy=resolve' to exercise the "non merge-recursive" code path, so 
I'll update them to use a proper custom merge strategy.

Is it worth optimizing do_merge() to take advantage of resolve and 
octopus being builtin as well?

Best Wishes

Phil


> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   sequencer.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index fd7701c88a..ea8dc58108 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -33,6 +33,7 @@
>   #include "commit-reach.h"
>   #include "rebase-interactive.h"
>   #include "reset.h"
> +#include "merge-strategies.h"
>   
>   #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>   
> @@ -1922,9 +1923,15 @@ static int do_pick_commit(struct repository *r,
>   
>   		commit_list_insert(base, &common);
>   		commit_list_insert(next, &remotes);
> -		res |= try_merge_command(r, opts->strategy,
> -					 opts->xopts_nr, (const char **)opts->xopts,
> -					common, oid_to_hex(&head), remotes);
> +
> +		if (!strcmp(opts->strategy, "resolve")) {
> +			repo_read_index(r);
> +			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
> +		} else
> +			res |= try_merge_command(r, opts->strategy,
> +						 opts->xopts_nr, (const char **)opts->xopts,
> +						 common, oid_to_hex(&head), remotes);
> +
>   		free_commit_list(common);
>   		free_commit_list(remotes);
>   	}
> 
