Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7CBC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 16:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiHJQNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiHJQNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 12:13:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D421753B4
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 09:13:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f192so14112802pfa.9
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=e0rfaJM0t2rgHH56JxHsANjuxR4Wl1mS++A1h0AL+ng=;
        b=D55GpXTeuZaWjb+eo1AnnG97Ap5nticjHAeRR0LK1/8QGuYejN1Vmsja1+diBaCiUw
         oL2GmLvaLK3CHs7WBLJrxCzEmG9s2mMGwtgJffUsZZA5BhlykfNoQxdVqqGbd6NwYN1h
         I40TRk9Ew4oxCdtNpyoqBIb7DBOoRyIle1oD5Yr+YDX6Zv0OdKJek8Rb5j7ZWreSqkta
         smooh60l/r1XdU3P1fPeKZ7W877m/iRi7f62NRhgWon8FDVJUrfNaM3nmtjBD0IS78oE
         cBV6GTVQ9UVqpgiVB5pkO5CtnmYy9EtcQxVc+RE8/BdKPR4I/0H1sxS8bytzrBgN+yPH
         7JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=e0rfaJM0t2rgHH56JxHsANjuxR4Wl1mS++A1h0AL+ng=;
        b=r43T4fARJuUH+xJ6KrBuaaD6H501Z99KdVk1Z9ainwM9zvE71f6vVFFiif7jQnc+7M
         ybIcsD+scEe/9VC2SvXxfQRovFRZZbMUuZKaLSreIlVJWRn8f5rZ9jndNnivi5B8Fi4O
         GAobu9IlG8EPIMUNeZVK52dTzveWWHUd682hSDxcd7APMX8tKHNWi+iYBiQEmYbiSL/y
         iVinqxStlaK4GS/iwLP8DAjOdDevhi9XL+gHTVjV1nEOOrLYTBNBN4Db50mzMqTLsVS8
         n0kRer7HcJkopAor0KXYaSV0KOJfaBUALaHchxLJRnHUYHETbLD+YwVGNBOXSXp1r/sD
         870w==
X-Gm-Message-State: ACgBeo3PhH7IBX3J73qe5EWWrSp6Cl+7RKd+Ss7c6ooAchyttUY+q9SN
        DKOtcLOuZkkzxC5halJ6kuEr
X-Google-Smtp-Source: AA6agR4ARYDsWXadX442VMwjMJTaT4dmnb8R7ARJhriO0G+DwwJvqiQX6HHeYvXgB2cx1/v8X48kdQ==
X-Received: by 2002:aa7:80d0:0:b0:52d:f9c6:bb14 with SMTP id a16-20020aa780d0000000b0052df9c6bb14mr28325881pfn.57.1660148025986;
        Wed, 10 Aug 2022 09:13:45 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id t5-20020a1709027fc500b001708e1a10a3sm9562281plb.94.2022.08.10.09.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 09:13:44 -0700 (PDT)
Message-ID: <19fe9b29-a860-fb59-ecb4-0d72b61167fe@github.com>
Date:   Wed, 10 Aug 2022 09:13:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 08/10] builtin/bugreport.c: create '--diagnose' option
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <d81e7c10997e9e8dc211d241019fbafa6b25fb04.1659577543.git.gitgitgadget@gmail.com>
 <3dc402e1-1f27-8a24-544d-d90d403a7da0@github.com>
 <a45f5693-7186-2953-6620-3f1359a12238@github.com>
 <77f445f7-3934-c165-3160-e09d7b884774@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <77f445f7-3934-c165-3160-e09d7b884774@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 8/9/22 7:53 PM, Victoria Dye wrote:
>> Derrick Stolee wrote:
>>> On 8/3/2022 9:45 PM, Victoria Dye via GitGitGadget wrote:
> 
>>>> +static int option_parse_diagnose(const struct option *opt,
>>>> +				 const char *arg, int unset)
>>>> +{
>>>> +	enum diagnose_mode *diagnose = opt->value;
>>>> +
>>>> +	BUG_ON_OPT_NEG(unset);
>>>> +
>>>> +	if (!arg || !strcmp(arg, "basic"))
>>>> +		*diagnose = DIAGNOSE_BASIC;
>>>> +	else if (!strcmp(arg, "all"))
>>>> +		*diagnose = DIAGNOSE_ALL;
>>>
>>> Should we allow "none" to reset the value to DIAGNOSE_NONE?
>>
>> As far as I can tell, while some builtins have options that  match the
>> default behavior of the command (e.g., '--no-autosquash' in 'git rebase'),
>> those options typically exist to override a config setting (e.g.,
>> 'rebase.autosquash'). No config exists for 'bugreport --diagnose' (and I
>> don't think it would make sense to add one), so '--diagnose=none' would only
>> be used to override another '--diagnose' specification in the same
>> command/alias (e.g., 'git bugreport --diagnose=basic --diagnose=none'). 
> 
> Ah, so --diagnose=none isn't valuable because --no-diagnose would be
> the better way to write the same thing. You would need to remove the
> PARSE_OPT_NONEG from your OPT_CALLBACK_F() to allow that (and then do
> the appropriate logic with the "unset" parameter).

I'm not sure I follow. I wasn't suggesting a difference in value between
'--no-diagnose' and '--diagnose=none'. My point was that, when there's an
option variant that "resets" the value to the default (like
'--no-autosquash', '--no-recurse-submodules', etc.), it usually *also*
corresponds to an overridable config setting ('rebase.autosquash',
'push.recurseSubmodules'). No such 'bugreport.diagnose' config exists (or,
IMO, should exist), so the need for a "reset to default" option seemed
weaker. 

I used boolean options as my examples, but they aren't intended to imply a
meaningful difference between '--no-diagnose' amd '--diagnose=none'.

> 
> The reason to have these things is basically so users can create
> aliases (say 'git br' expands to 'git bugreport --diagnose=all', but
> they want to run 'git br --no-diagnose' to clear that --diagnose=all).

I considered that usage ("'--diagnose=none' would only be used to override
another '--diagnose' specification in the same command/alias"), but wasn't
sure how common it would be for this particular option. It sounds like you
can see it being useful, so I'll include '--diagnose=none' in the next
version.

> 
> Thanks,
> -Stolee

