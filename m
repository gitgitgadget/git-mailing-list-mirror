Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DA5C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 10:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829CA61278
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 10:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhDEKEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhDEKEw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 06:04:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4899C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 03:04:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u17so9819518ejk.2
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+zN11G/fhmXejb2iPtRiFQMKV2AA7xyKhCQcawlR3Uc=;
        b=FJTn1PQPPjfgp0kqte8wur0UniCZ2HJT9Tj7r50Aaz5MZj3cttt6nygkFv7R4F5rtg
         VStK/wySPNLhxLMsJqG4JWi+WP4iIR0grYtkW2D7+kQBqQ2GWo6/lQWC7yO6YCD1cGOY
         JmVGtmSze165DxBWNNa2NW1WH2bUyacHLxMhQb5Fnsrsapct9QUQecs5BIl7/tJEoVkV
         OI3fpD9wWTaxWDqN8nkZZqcZFmdv73yiwmnpO3FFPXBX6ZTxG22QJN5tR/Udly2syaAk
         tnab7GIDZ+Syci442Mla8G8t5TcTk+QFWZMoOdMn+hMDkjZxkIggm68ZeFGB/aKB0W1X
         2IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+zN11G/fhmXejb2iPtRiFQMKV2AA7xyKhCQcawlR3Uc=;
        b=YzFLaXV331UYyAqBMGqiy8+HAQ3tiCLhhF1F23owDzwRFb3lMto2PStGpOLZVR9mn/
         31v3Xsc/8Wu7dTTQNfxkDUStrapzNfaVOOyC2uvv8jFZzDQAqFcT/vd9mbun7TvsIk/c
         D3tQRYJUTuzuXJ2lHZtMy7Gp6sMnY20lfLKMWc83t7iRHLjHNWX0haezW8vi39cIieam
         yBvHM0gM4gpHQmQsr6TvsWNBOPFhkV3GKzoi0MF2VPQtwkkMzPfLExpWaziUNmOAXeBu
         loEFBl33Emq9jP1XCDJBKCYSsa5g6a4YaoUxad1X52f7tQR/g8k4IFKwj7DYlqUgk8hF
         RNfg==
X-Gm-Message-State: AOAM531gQSpnMHtuskzkW+OtifnT54TW4WH/40SJR/t9W9SsM/c1uXM/
        8kAv2jEg/wGrKSL+G33Yxgw=
X-Google-Smtp-Source: ABdhPJyknmEwG9zPfxBuXk+cbOSmbIhYqVyQEI2bJDRI2iFYrADmxriKsHKDBWxcTJJnRwMpmGxNgA==
X-Received: by 2002:a17:906:a1c5:: with SMTP id bx5mr28706172ejb.166.1617617083514;
        Mon, 05 Apr 2021 03:04:43 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id wr20sm8406476ejb.111.2021.04.05.03.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 03:04:43 -0700 (PDT)
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
 <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
 <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
 <D8256AFA-898E-4388-8FCC-7D3D340C001E@gmail.com>
 <A3C3DD12-3C00-49ED-B427-37AAB4211C2A@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <61622cda-3ce5-7cd9-acd6-54906297500c@gmail.com>
Date:   Mon, 5 Apr 2021 11:04:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <A3C3DD12-3C00-49ED-B427-37AAB4211C2A@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva

On 30/03/2021 11:22, Atharva Raykar wrote:
> 
> 
>> On 30-Mar-2021, at 12:34, Atharva Raykar <raykar.ath@gmail.com> wrote:
>>
>>
>>
>>> On 29-Mar-2021, at 15:48, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>> Hi Atharva
>>>
>>> On 28/03/2021 13:23, Atharva Raykar wrote:
>>>> On 28-Mar-2021, at 05:16, Johannes Sixt <j6t@kdbg.org> wrote:
>>>> [...]
>>>>>> diff --git a/t/t4018/scheme-local-define b/t/t4018/scheme-local-define
>>>>>> new file mode 100644
>>>>>> index 0000000000..90e75dcce8
>>>>>> --- /dev/null
>>>>>> +++ b/t/t4018/scheme-local-define
>>>>>> @@ -0,0 +1,4 @@
>>>>>> +(define (higher-order)
>>>>>> +  (define local-function RIGHT
>>>>>
>>>>> ... this one, which is also indented and *is* marked as RIGHT.
>>>> In this test case, I was explicitly testing for an indented '(define'
>>>> whereas in the former, I was testing for the top-level '(define-syntax',
>>>> which happened to have an internal define (which will inevitably show up
>>>> in a lot of scheme code).
>>>
>>> It would be nice to include indented define forms but including them means that any change to the body of a function is attributed to the last internal definition rather than the actual function. For example
>>>
>>> (define (f arg)
>>> (define (g x)
>>>    (+ 1 x))
>>>
>>> (some-func ...)
>>> ;;any change here will have '(define (g x)' in the hunk header, not '(define (f arg)'
>>
>> The reason I went for this over the top level forms, is because
>> I felt it was useful to see the nearest definition for internal
>> functions that often have a lot of the actual business logic of
>> the program (at least a lot of SICP seems to follow this pattern).
>> The disadvantage is as you said, it might also catch trivial inner
>> functions and the developer might lose context.
> 
> Never mind this message, I had misunderstood the problem you were trying to
> demonstrate. I wholeheartedly agree with what you are trying to say, and
> the indentation heuristic discussed does look interesting. I shall have a
> glance at the RFC you linked in the other reply.
> 
>> The disadvantage is as you said, it might also catch trivial inner
>> functions and the developer might lose context.
> 
> Feel free to disregard me misquoting you here. You did not say that (:
> 
>> Another problem is it may match more trivial bindings, like:
>>
>> (define (some-func things)
>>   ...
>>   (define items '(eggs
>>                   ham
>>                   peanut-butter))
>>   ...)
>>
>> What I have noticed *anecdotally* is that this is not common enough
>> to be too much of a problem, and local define bindings seem to be more
>> favoured in Racket than other Schemes, that use 'let' more often.
>>
>>> I don't think this can be avoided as we rely on regexs rather than parsing the source so it is probably best to only match toplevel defines.
>>
>> The other issue with only matching top level defines is that a
>> lot of scheme programs are library definitions, something like
>>
>> (library
>>     (foo bar)
>>   (export ...)
>>   (define ...)
>>   (define ...)
>>   ;; and a bunch of other definitions...
>> )
>>
>> Only matching top level defines will completely ignore matching all
>> the definitions in these files.
> 
> That said, I still stand by the fact that only catching top level defines
> will lead to a lot of definitions being ignored. Maybe the occasional
> mismatch may be worth the gain in the number of function contexts being
> detected?

I'm not sure that the mismatches will be occasional - every time you 
have an internal definition in a function the hunk header will be wrong 
when you change the main body of the function. This will affect grep 
--function-context and diff -W as well as the normal hunk headers. The 
problem is there is no way to avoid that and provide something useful in 
the library example you have above. It would be useful to find some code 
bases and diff the output of 'git log --patch' with and without the 
leading whitespace match in the function pattern to see how often this 
is a problem (i.e. when the funcnames do not match see which one is 
correct).

Best Wishes

Phillip


