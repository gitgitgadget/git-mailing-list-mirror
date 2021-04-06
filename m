Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA36C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3CF61382
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 19:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhDFTLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhDFTLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 15:11:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74998C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 12:11:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1565158wma.0
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wp1yp80woWEkPeqx+Jx5VMiOYO5Se/0ZZPYq4iVg5dw=;
        b=NYuUZGizzQzUlJvd1X8rWLC7swL7Uocr9jiYYhzLbRUbHel/QaEkY71r4BsTTnykHz
         RXKpDO2hVR+JXUb9QpFc2vGFmrr6BIEkWk2NIrSn7zimzLjVJjJJbnKFG5KXoMZrSKOI
         tJnKyyXrw+0FVNo2ma5fpx5+kFk2rgqDmYbVFj6EZtN/GAkTtsovKfvhcJ73agp98HMG
         qbkg/p1efcK9lHli2so67/tbPSVb3pfTjnoRMkKpPv3iutfHIJhLQSV/ChS2jX+4LlMO
         UBD6FMwfS2EXJnEqJCRQT8aT59dsNNZ9ItrpSG8/Q01nzJ2cdR9I8A5vlHBfnzW4WjQD
         sveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Wp1yp80woWEkPeqx+Jx5VMiOYO5Se/0ZZPYq4iVg5dw=;
        b=ptZsrhQsC4IIok4sTZYNpcPq5NENI51qDhVQ6/AgtjGH1xJJBsvDdNXJlx+nv3sa2C
         9GHiNcBFaNC/gdhwv3aVFe3s7IVgMWmmn14JwsbCsibrTI6yybl/bpDXoZvndyPxTJyW
         NtGrDBlXpxxxUENfN9HqAyZCBCk0N/QdBzFwDpi2PZPqP7CSwi+jSuXIUnakzGJwXPe0
         nAU4PjzeMY98cbBypbaBGrR6u4YAZCWg8PYjLZIGt+BG1RJTKiwA3vrsNm272+P+bPhg
         W7upggdFIy1J0/ABm9tQ2XXZWfg4O07aSdvk7pcdXZ6T+4GZ3K/VeqNvotPk8iBLJEt0
         tCmw==
X-Gm-Message-State: AOAM532wbSQb7R9LaIuK7mh0akiV4owf7eTQPKA+t+cyAgcpiu4zJ6qR
        Sk4DjvwU6QW+16UWoa1xxONDdjhSfyM=
X-Google-Smtp-Source: ABdhPJwHV5RC7yO7bIed8pDvxsTn4gkTorsgAwhQbiaUE1YUNBhMtU2nUYH1EMtxmdIT8xzE7ki/iw==
X-Received: by 2002:a05:600c:b57:: with SMTP id k23mr5383211wmr.145.1617736261174;
        Tue, 06 Apr 2021 12:11:01 -0700 (PDT)
Received: from [192.168.1.240] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.gmail.com with ESMTPSA id y12sm8856857wrs.65.2021.04.06.12.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 12:11:00 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
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
 <61622cda-3ce5-7cd9-acd6-54906297500c@gmail.com>
 <60D8CE48-926B-4A09-9355-4331C14F6753@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <570c172a-0bc5-8a3d-eeca-c5dd81c84206@gmail.com>
Date:   Tue, 6 Apr 2021 20:10:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <60D8CE48-926B-4A09-9355-4331C14F6753@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva

On 06/04/2021 13:29, Atharva Raykar wrote:
> On 05-Apr-2021, at 15:34, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Atharva
>>
>> On 30/03/2021 11:22, Atharva Raykar wrote:
>>>> On 30-Mar-2021, at 12:34, Atharva Raykar <raykar.ath@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>>> On 29-Mar-2021, at 15:48, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>>>
>>>>> Hi Atharva
>>>>>
>>>>> On 28/03/2021 13:23, Atharva Raykar wrote:
>>>>>> On 28-Mar-2021, at 05:16, Johannes Sixt <j6t@kdbg.org> wrote:
>>>>>> [...]
>>>>>>>> diff --git a/t/t4018/scheme-local-define b/t/t4018/scheme-local-define
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000000..90e75dcce8
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/t/t4018/scheme-local-define
>>>>>>>> @@ -0,0 +1,4 @@
>>>>>>>> +(define (higher-order)
>>>>>>>> +  (define local-function RIGHT
>>>>>>>
>>>>>>> ... this one, which is also indented and *is* marked as RIGHT.
>>>>>> In this test case, I was explicitly testing for an indented '(define'
>>>>>> whereas in the former, I was testing for the top-level '(define-syntax',
>>>>>> which happened to have an internal define (which will inevitably show up
>>>>>> in a lot of scheme code).
>>>>>
>>>>> It would be nice to include indented define forms but including them means that any change to the body of a function is attributed to the last internal definition rather than the actual function. For example
>>>>>
>>>>> (define (f arg)
>>>>> (define (g x)
>>>>>    (+ 1 x))
>>>>>
>>>>> (some-func ...)
>>>>> ;;any change here will have '(define (g x)' in the hunk header, not '(define (f arg)'
>>>>
>>>> The reason I went for this over the top level forms, is because
>>>> I felt it was useful to see the nearest definition for internal
>>>> functions that often have a lot of the actual business logic of
>>>> the program (at least a lot of SICP seems to follow this pattern).
>>>> The disadvantage is as you said, it might also catch trivial inner
>>>> functions and the developer might lose context.
>>> Never mind this message, I had misunderstood the problem you were trying to
>>> demonstrate. I wholeheartedly agree with what you are trying to say, and
>>> the indentation heuristic discussed does look interesting. I shall have a
>>> glance at the RFC you linked in the other reply.
>>>> The disadvantage is as you said, it might also catch trivial inner
>>>> functions and the developer might lose context.
>>> Feel free to disregard me misquoting you here. You did not say that (:
>>>> Another problem is it may match more trivial bindings, like:
>>>>
>>>> (define (some-func things)
>>>>   ...
>>>>   (define items '(eggs
>>>>                   ham
>>>>                   peanut-butter))
>>>>   ...)
>>>>
>>>> What I have noticed *anecdotally* is that this is not common enough
>>>> to be too much of a problem, and local define bindings seem to be more
>>>> favoured in Racket than other Schemes, that use 'let' more often.
>>>>
>>>>> I don't think this can be avoided as we rely on regexs rather than parsing the source so it is probably best to only match toplevel defines.
>>>>
>>>> The other issue with only matching top level defines is that a
>>>> lot of scheme programs are library definitions, something like
>>>>
>>>> (library
>>>>     (foo bar)
>>>>   (export ...)
>>>>   (define ...)
>>>>   (define ...)
>>>>   ;; and a bunch of other definitions...
>>>> )
>>>>
>>>> Only matching top level defines will completely ignore matching all
>>>> the definitions in these files.
>>> That said, I still stand by the fact that only catching top level defines
>>> will lead to a lot of definitions being ignored. Maybe the occasional
>>> mismatch may be worth the gain in the number of function contexts being
>>> detected?
>>
>> I'm not sure that the mismatches will be occasional - every time you have an internal definition in a function the hunk header will be wrong when you change the main body of the function. This will affect grep --function-context and diff -W as well as the normal hunk headers. The problem is there is no way to avoid that and provide something useful in the library example you have above. It would be useful to find some code bases and diff the output of 'git log --patch' with and without the leading whitespace match in the function pattern to see how often this is a problem (i.e. when the funcnames do not match see which one is correct).
> 
> You are right -- on trying out the function on a two other scheme
> codebases, I noticed that there are a lot more wrongly matched functions
> than I initially thought. About half of them identify the wrong function
> in one of the repositories I tried. However, removing the leading
> whitespace in the pattern did not lead to better matching; it just led
> to a lot of the hunk headers going blank. I am not sure what causes this
> behaviour, but my guess is that the function contexts are shown only if
> it is within a certain distance from the function definition?
> 
> Even if it did match only the top level defines correctly, the functions
> matched would still often be technically wrong -- it will show the outer
> function as the context when the user has edited an internal function
> (and in Scheme, there is heavy usage of internal functions).
> 
> After running 'git grep --function-context' with the leading whitespace
> removed, it seems to match too aggressively, as it captures a huge
> region to match all the way upto the top level. Especially for files
> where all the definitions are in a 'library'.
> 
> Overall, I personally felt that there were more downsides to matching
> only at the top level. I'd rather the hunk header have the nearest
> function to provide the context, than have no function displayed at all.
> Even when the match is wrong, it at least helps me locate where the
> change was made more easily.

Thanks for taking the time to check the differences between the two 
approaches, as there is no perfect solution I'm happy to go with the one 
that seemed to be best in your investigations

Best Wishes

Phillip

>> Best Wishes
>>
>> Phillip
>>
>>
> 
