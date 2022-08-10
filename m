Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1505C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 16:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiHJQrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiHJQrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 12:47:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0BD2715C
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 09:47:33 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i84so12607363ioa.6
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ku9PPi1JzwafE/jDnCp8MvmVCOySxyO372iIMETsB6g=;
        b=GOCayrDFW5z5XixBzcm3ept9q6w4aAWTMWQVxjrntGlYKkrVzIFw1Hu6Bf+TIvWqe3
         1U5Biz1XcAHDTwoIQpkBCBLZRyaRRvs8LBj+BdAJlqaXUi2xqW14Fs/srBBOO66IzTZF
         q43ChF+yf5EzBxyGRy4F3AJ3IFkc4KkUcn4Q8zn40c8yqTBnkXpRGMd581LCa3y5Mx0p
         y2tEDrShE4AiDHlBPyzB3cQLaR/iuDl4MNN6PLZ6nB4R6hQA03ToSjxAWRaCfqQht/el
         p2DSO1HTWnEzoZ0SAJPAUYwxOJ0ftPvf3fV8hMK3yLZqIZiREL9KeZ4z2mVXHKBmdv1t
         4c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ku9PPi1JzwafE/jDnCp8MvmVCOySxyO372iIMETsB6g=;
        b=4QkPGgkvX2XSfeTSLD14XRjlf0D2plyA2SatpBjL8pUCN+jIQA0VJJ1qHeq/dRXh6U
         67PLjR6+BjHuSjd4N9U6TqZHB0rQqEQ5YXkb4ydJ9KfY6hFW58vWXh0ML+7HFeLPOxis
         iX+Yy9rCwwoYfRATrTkiXdR+zADEypk/5YIgYFU8u880r1h2oTBYZK8k9txHcBE2oB7R
         nnl1UnKWgbP7CzQxuxtjJkazfeUwmghhoeadu84vFO5Fqc9epgXqMl1RgVzzoQ0nTt1N
         RKtxcqqC5kaloYqyLXS9NChxSciczuDPPDZmgQkpeVPlpXY6isPjXjrBeRsGqkCczAWl
         H0AA==
X-Gm-Message-State: ACgBeo30SJOK/6340V3lHyt5VRreghh+calcAPwh2MnYM4qK+Uzdwup0
        7lDqdB5D01+X3GODkX+JiUZl
X-Google-Smtp-Source: AA6agR48pjF8/7fyHQxerk+I+ZI4SwcIqkG6TjzX4ny0mJYBClMtqXsKxmbdH/uz3iMaEZKg5awcpw==
X-Received: by 2002:a05:6602:14cb:b0:684:f359:41bb with SMTP id b11-20020a05660214cb00b00684f35941bbmr4823435iow.69.1660150052532;
        Wed, 10 Aug 2022 09:47:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:51d1:38a9:eee4:f5d1? ([2600:1700:e72:80a0:51d1:38a9:eee4:f5d1])
        by smtp.gmail.com with ESMTPSA id bg12-20020a0566383c4c00b0033f4b1c2151sm7578079jab.154.2022.08.10.09.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 09:47:32 -0700 (PDT)
Message-ID: <87b19226-2542-2ea0-e16a-ce8e57d6b589@github.com>
Date:   Wed, 10 Aug 2022 12:47:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 08/10] builtin/bugreport.c: create '--diagnose' option
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
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
 <19fe9b29-a860-fb59-ecb4-0d72b61167fe@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <19fe9b29-a860-fb59-ecb4-0d72b61167fe@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/2022 12:13 PM, Victoria Dye wrote:
> Derrick Stolee wrote:
>> On 8/9/22 7:53 PM, Victoria Dye wrote:
>>> Derrick Stolee wrote:
>>>> On 8/3/2022 9:45 PM, Victoria Dye via GitGitGadget wrote:
>>
>>>>> +static int option_parse_diagnose(const struct option *opt,
>>>>> +				 const char *arg, int unset)
>>>>> +{
>>>>> +	enum diagnose_mode *diagnose = opt->value;
>>>>> +
>>>>> +	BUG_ON_OPT_NEG(unset);
>>>>> +
>>>>> +	if (!arg || !strcmp(arg, "basic"))
>>>>> +		*diagnose = DIAGNOSE_BASIC;
>>>>> +	else if (!strcmp(arg, "all"))
>>>>> +		*diagnose = DIAGNOSE_ALL;
>>>>
>>>> Should we allow "none" to reset the value to DIAGNOSE_NONE?
>>>
>>> As far as I can tell, while some builtins have options that  match the
>>> default behavior of the command (e.g., '--no-autosquash' in 'git rebase'),
>>> those options typically exist to override a config setting (e.g.,
>>> 'rebase.autosquash'). No config exists for 'bugreport --diagnose' (and I
>>> don't think it would make sense to add one), so '--diagnose=none' would only
>>> be used to override another '--diagnose' specification in the same
>>> command/alias (e.g., 'git bugreport --diagnose=basic --diagnose=none'). 
>>
>> Ah, so --diagnose=none isn't valuable because --no-diagnose would be
>> the better way to write the same thing. You would need to remove the
>> PARSE_OPT_NONEG from your OPT_CALLBACK_F() to allow that (and then do
>> the appropriate logic with the "unset" parameter).
> 
> I'm not sure I follow. I wasn't suggesting a difference in value between
> '--no-diagnose' and '--diagnose=none'. My point was that, when there's an
> option variant that "resets" the value to the default (like
> '--no-autosquash', '--no-recurse-submodules', etc.), it usually *also*
> corresponds to an overridable config setting ('rebase.autosquash',
> 'push.recurseSubmodules'). No such 'bugreport.diagnose' config exists (or,
> IMO, should exist), so the need for a "reset to default" option seemed
> weaker. 

You're right that these make the most sense when there can be a
non-CLI source of a setting to unset, which is a better reason than
the alias reason I gave.
 
> I used boolean options as my examples, but they aren't intended to imply a
> meaningful difference between '--no-diagnose' amd '--diagnose=none'.
> 
>>
>> The reason to have these things is basically so users can create
>> aliases (say 'git br' expands to 'git bugreport --diagnose=all', but
>> they want to run 'git br --no-diagnose' to clear that --diagnose=all).
> 
> I considered that usage ("'--diagnose=none' would only be used to override
> another '--diagnose' specification in the same command/alias"), but wasn't
> sure how common it would be for this particular option. It sounds like you
> can see it being useful, so I'll include '--diagnose=none' in the next
> version.

This change would make it easier to add a config option in the future,
though I doubt we will need it as 'git bugreport' should be used too
infrequently to want to set up such config in advance.

Thanks,
-Stolee
