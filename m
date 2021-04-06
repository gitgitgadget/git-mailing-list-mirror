Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7130DC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 12:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE8A6113E
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 12:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbhDFM36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 08:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbhDFM35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 08:29:57 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A6AC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 05:29:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l76so10220103pga.6
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0pn8ir7TtbHXrLk6Ryot1WtWNbBqtzYM8w/lAkB1PsM=;
        b=avrDBqN9zC3WzYifV3bqyMUJAHlxgg2CnP18iXQmFHSZ28HOXwc8xfQaKUelI2nsJA
         832KhMqRST01eAqEWYMwKIJncWhKqRAgc/eOVWoJw4CbNu9WZBIYJdnDedu+HJ0b7SnO
         Q7x3N8zVcCLKDe9DkeXH/rybErrTzQ01GfYtGkNerCK/CJyN1kVRRX2lRVAr+pN5ETe1
         zQXtwH7Xdl2YdRQndx+LAYgv2RHe3uq0oFF6Qk8EtqSg6mUejRnB1IcUrk0JoCFGx2Wq
         Xt+wCT25yN1JjPWhSEx9ZNs8Ze44wtggk1iHFya3U8KeBMGepXOLqqRINqPr77u54HeE
         uG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0pn8ir7TtbHXrLk6Ryot1WtWNbBqtzYM8w/lAkB1PsM=;
        b=aQqFtaH0Mqsyxb701AhyhA/61LhVUy7paV4fXlbP41kSVcLSF2OkOBPvx6OfGCfXBF
         BYMrBUX/mBL5TT2vXqyannM8zMWu907nXWtp8vdc629bE7x+vTpi84IUKe/MkNsymIxd
         uuTsgHn5uoH8QJqjfnSNplP+K0RTonM0c2ISRAqkj/z/iO6u1Xydnqrr815i8Cc5Jyaa
         YHogBByqJYah5IJhxnMQKUVzpvc+cflfqbKj4I33Hr1fwDEQnySGwj7E+3rkRKoc6gGF
         0y3SgZCXzYaTQ7OebeeQ4j8E9UFmPmu9R8vRRtU6W8gEVGd/nTVPrhptXC8N1g75wjCZ
         myDg==
X-Gm-Message-State: AOAM530ONvl8PPmDFo2uQlx5LjP7/dRqwqlExMazz6ph1s73M+A8dUFr
        M1w+34LkcVOcZ4rY8lbulQU=
X-Google-Smtp-Source: ABdhPJyIYOYJ6c3xeRrTfjtl5XkslcWDJ2Ta2cFMYtj7ZB6pGAL+XU/4GDT3AN71ZFENALkNFVI/zg==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr5297877pge.77.1617712187279;
        Tue, 06 Apr 2021 05:29:47 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.157])
        by smtp.gmail.com with ESMTPSA id q25sm18419314pff.104.2021.04.06.05.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 05:29:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <61622cda-3ce5-7cd9-acd6-54906297500c@gmail.com>
Date:   Tue, 6 Apr 2021 17:59:43 +0530
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <60D8CE48-926B-4A09-9355-4331C14F6753@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
 <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
 <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
 <D8256AFA-898E-4388-8FCC-7D3D340C001E@gmail.com>
 <A3C3DD12-3C00-49ED-B427-37AAB4211C2A@gmail.com>
 <61622cda-3ce5-7cd9-acd6-54906297500c@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05-Apr-2021, at 15:34, Phillip Wood <phillip.wood123@gmail.com> =
wrote:
>=20
> Hi Atharva
>=20
> On 30/03/2021 11:22, Atharva Raykar wrote:
>>> On 30-Mar-2021, at 12:34, Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>>>=20
>>>=20
>>>=20
>>>> On 29-Mar-2021, at 15:48, Phillip Wood <phillip.wood123@gmail.com> =
wrote:
>>>>=20
>>>> Hi Atharva
>>>>=20
>>>> On 28/03/2021 13:23, Atharva Raykar wrote:
>>>>> On 28-Mar-2021, at 05:16, Johannes Sixt <j6t@kdbg.org> wrote:
>>>>> [...]
>>>>>>> diff --git a/t/t4018/scheme-local-define =
b/t/t4018/scheme-local-define
>>>>>>> new file mode 100644
>>>>>>> index 0000000000..90e75dcce8
>>>>>>> --- /dev/null
>>>>>>> +++ b/t/t4018/scheme-local-define
>>>>>>> @@ -0,0 +1,4 @@
>>>>>>> +(define (higher-order)
>>>>>>> +  (define local-function RIGHT
>>>>>>=20
>>>>>> ... this one, which is also indented and *is* marked as RIGHT.
>>>>> In this test case, I was explicitly testing for an indented =
'(define'
>>>>> whereas in the former, I was testing for the top-level =
'(define-syntax',
>>>>> which happened to have an internal define (which will inevitably =
show up
>>>>> in a lot of scheme code).
>>>>=20
>>>> It would be nice to include indented define forms but including =
them means that any change to the body of a function is attributed to =
the last internal definition rather than the actual function. For =
example
>>>>=20
>>>> (define (f arg)
>>>> (define (g x)
>>>>   (+ 1 x))
>>>>=20
>>>> (some-func ...)
>>>> ;;any change here will have '(define (g x)' in the hunk header, not =
'(define (f arg)'
>>>=20
>>> The reason I went for this over the top level forms, is because
>>> I felt it was useful to see the nearest definition for internal
>>> functions that often have a lot of the actual business logic of
>>> the program (at least a lot of SICP seems to follow this pattern).
>>> The disadvantage is as you said, it might also catch trivial inner
>>> functions and the developer might lose context.
>> Never mind this message, I had misunderstood the problem you were =
trying to
>> demonstrate. I wholeheartedly agree with what you are trying to say, =
and
>> the indentation heuristic discussed does look interesting. I shall =
have a
>> glance at the RFC you linked in the other reply.
>>> The disadvantage is as you said, it might also catch trivial inner
>>> functions and the developer might lose context.
>> Feel free to disregard me misquoting you here. You did not say that =
(:
>>> Another problem is it may match more trivial bindings, like:
>>>=20
>>> (define (some-func things)
>>>  ...
>>>  (define items '(eggs
>>>                  ham
>>>                  peanut-butter))
>>>  ...)
>>>=20
>>> What I have noticed *anecdotally* is that this is not common enough
>>> to be too much of a problem, and local define bindings seem to be =
more
>>> favoured in Racket than other Schemes, that use 'let' more often.
>>>=20
>>>> I don't think this can be avoided as we rely on regexs rather than =
parsing the source so it is probably best to only match toplevel =
defines.
>>>=20
>>> The other issue with only matching top level defines is that a
>>> lot of scheme programs are library definitions, something like
>>>=20
>>> (library
>>>    (foo bar)
>>>  (export ...)
>>>  (define ...)
>>>  (define ...)
>>>  ;; and a bunch of other definitions...
>>> )
>>>=20
>>> Only matching top level defines will completely ignore matching all
>>> the definitions in these files.
>> That said, I still stand by the fact that only catching top level =
defines
>> will lead to a lot of definitions being ignored. Maybe the occasional
>> mismatch may be worth the gain in the number of function contexts =
being
>> detected?
>=20
> I'm not sure that the mismatches will be occasional - every time you =
have an internal definition in a function the hunk header will be wrong =
when you change the main body of the function. This will affect grep =
--function-context and diff -W as well as the normal hunk headers. The =
problem is there is no way to avoid that and provide something useful in =
the library example you have above. It would be useful to find some code =
bases and diff the output of 'git log --patch' with and without the =
leading whitespace match in the function pattern to see how often this =
is a problem (i.e. when the funcnames do not match see which one is =
correct).

You are right -- on trying out the function on a two other scheme
codebases, I noticed that there are a lot more wrongly matched functions
than I initially thought. About half of them identify the wrong function
in one of the repositories I tried. However, removing the leading
whitespace in the pattern did not lead to better matching; it just led
to a lot of the hunk headers going blank. I am not sure what causes this
behaviour, but my guess is that the function contexts are shown only if
it is within a certain distance from the function definition?

Even if it did match only the top level defines correctly, the functions
matched would still often be technically wrong -- it will show the outer
function as the context when the user has edited an internal function
(and in Scheme, there is heavy usage of internal functions).

After running 'git grep --function-context' with the leading whitespace
removed, it seems to match too aggressively, as it captures a huge
region to match all the way upto the top level. Especially for files
where all the definitions are in a 'library'.

Overall, I personally felt that there were more downsides to matching
only at the top level. I'd rather the hunk header have the nearest
function to provide the context, than have no function displayed at all.
Even when the match is wrong, it at least helps me locate where the
change was made more easily.


> Best Wishes
>=20
> Phillip
>=20
>=20

