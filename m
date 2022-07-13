Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6803C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 09:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiGMJiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiGMJiR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 05:38:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F6A24F20
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 02:38:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r14so14706942wrg.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FGVX9KoBylOsaZWGny7jddtuY0jHozuPldudk7xxyis=;
        b=lyGJBP1uPT4S0KDXawa/uwXUdzo57ktN9eI3VIo6sIRbbR+V+VMFfJzkxzvRtmfzqt
         Clv29KKCG5uNyX4OmZJ2PXBPSCNmkZNr0HdBTnXG4IUVFwuqbS00L6Nm6MaSWqpyo09D
         eRBATBoYSI+conybM8/RZRQlk60Bc7dDPUAd3uT4PAxVlYdyeoxStlCdhiPYe6VVovze
         jp91BJ2GKTpMEiVH6fueS5j5ZPgvop0rdY8Qt0aVyekGbFbfqOxGSzNsY/LV2O/T3SSv
         g+jNAkpaDSyvmUJgaj4fEz4ipANkhdIL+6Q5hJ02hCCDUUth9ObdTmPRFR5iP/d8tG5e
         z+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FGVX9KoBylOsaZWGny7jddtuY0jHozuPldudk7xxyis=;
        b=0KPt0H7utwfyDEmnWZ6Ey+NMeyBhrsaw2DxjpPrKsX7Oc6LJ1HaNHI6WC4NmounAhJ
         wY9hHHNGNI1C1ShKpFFxokbRG5pYqOZiWyW3sV+FJC/Tx5L2z/DgHW6NEAS5+tMT8kjO
         EsJkSjIuWZavIRUjEan6e4aICzA7AOLO9P+q9s6TfzB/y5yW5+3BZcAtLvBLpdcS0LBF
         u5ZY5Yfyss4YBcx1eGbKKOnOIRwVVbLgni/8EKVAaNRTGGCcroxizWkECum8HHXH6jxs
         dTphkhtxbUoW1IZOsTxEChlLykygTt3co/6wvm5A+4IyIAGgXqnP142X1MwpYhZND6Fw
         4B+g==
X-Gm-Message-State: AJIora+9nwMq2AFiDmU60nZECSKpinbeu+AsmhD9+t0ZKrrYMjhihdRA
        Rry0nJ1hhbouuoZ8L/lBUg8=
X-Google-Smtp-Source: AGRyM1s09vbyy4DvdXQNH+Wjcqq5DaTnmrIkx++azwo/DMCXOsdHjk1Vcz20T9EYb2noDcPpOXcMbw==
X-Received: by 2002:a5d:5703:0:b0:21d:ada4:e827 with SMTP id a3-20020a5d5703000000b0021dada4e827mr2299588wrv.579.1657705095038;
        Wed, 13 Jul 2022 02:38:15 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b003a2fde6ef62sm537902wmq.7.2022.07.13.02.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:38:14 -0700 (PDT)
Message-ID: <46f70aff-59f1-01ca-8f1f-b07b230011bc@gmail.com>
Date:   Wed, 13 Jul 2022 10:38:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] xdiff: introduce XDL_ALLOC_GROW()
Content-Language: en-GB-large
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
 <8c24cd7737b29d461788b71f6a94eb74c468ad33.1657297520.git.gitgitgadget@gmail.com>
 <220709.86v8s78chj.gmgdl@evledraar.gmail.com>
 <bb1c85e4-50be-04a5-3c9f-f4c4dab6a50e@gmail.com>
 <Ys0gerokoiLC9llA@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Ys0gerokoiLC9llA@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

It's great to see you back on the list

On 12/07/2022 08:19, Jeff King wrote:
> On Mon, Jul 11, 2022 at 11:00:06AM +0100, Phillip Wood wrote:
> 
>>> But you've also changed every single callsite anyway.
>>>
>>> So why not just change:
>>>
>>>       if (XDL_ALLOC_GROW(recs, ...))
>>>
>>> To:
>>>
>>>       XDL_ALLOC_GROW(recs, ...);
>>>       if (!recs)
>>
>> Because I think it's ugly, we'd never define a function as void(int* result,
>> args...) and I don't think we should do that for a macro where we can avoid
>> it. The existing ALLOC_* macros make sense as statements because they die on
>> failure.
> 
> Those macros are already unlike functions, though. They take a variable
> _name_, not a pointer to a variable, and assign to it. A version which
> looked like a function would have to be:
> 
>    if (XDL_ALLOC_GROW(&recs, ...))
> 
> So in my head I read them as assignment statements already, making the
> expression-like form a bit jarring.

I see what you're saying, I agree it is not exactly analogous. I tend to 
think of assignment as an expression because it returns the value that's 
being assigned, though here it's a bit muddy because the assignment is 
hidden inside the macro and there is no tell-tale '&' as there would be 
if it were calling function.

> Just my two cents. I don't care _too_ much either way, but I'd probably
> be swayed if one implementation is much simpler than the other.

I don't think there is much difference in the complexity in this case. 
In general I think that using a function with a macro wrapper can make 
the implementation more readable as the function it is not littered with 
the extra parentheses and backslashes that the same code in a macro 
requires.

Best Wishes

Phillip
