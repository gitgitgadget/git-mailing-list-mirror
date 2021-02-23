Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFC4C433E9
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7615464E57
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 13:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhBWNM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhBWNMX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 08:12:23 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE8DC06178A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 05:11:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id do6so34495789ejc.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WOLp2A8KsySBbDkBTZKHBy22L0rh8+tvhlOBUd3ayqQ=;
        b=LY+RJw0GqCau0WB9nH6u0aLgBIArYHq4gWhEJzKBy5rV+f66ao6e47N6dr4mH5ALng
         3y3RQVHNsu+hpmcGncasynxM4dgecIwggmVdMxylFPWSe4Nzk9WS9fO3CQud4kevHUPv
         IpeUHqNKXqahu7ZploQVHdGisPwAHvJsp577ABKF0xvOKtP1d2CPf8mJKNggxa7BUDjP
         jaL7IMUZ5zc4m/YPtAbk0/jlZOEnoOX0WeHSXMGBi/d+FD8DOX7KbMd6sTJXV7w50c3W
         r9/ZCJI1Cy2FbZu+L+BelWmuCEyr8tVCHU/IzydRd2Uz6JgIIoF6CIS7F6r7ZHRYB3LG
         pMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WOLp2A8KsySBbDkBTZKHBy22L0rh8+tvhlOBUd3ayqQ=;
        b=dKl1U0ly4trII6GxBsewZBVXjRFGNoQZ3q4gBuPx4ft3E5njINYCUzzz+onAsRl/Nc
         FWn0CTYuhpvt4u1UW7jp5E1DTlfl2j6VvA0hX4PJUJ7cZ4Lybh/axJ5MhsnDPo2bCcO+
         C2yCRCb/cQQjzbGv5hMKlyL8nXw5XhClBuYCdWeO3P94/AaQ6eyoZynCHcJko0jrzkaH
         BCJg/bPR/nlWOU6QDi+SzISMrnvCmbYkYM+BSA+Kl+RoL0OtKAwuptO+UfrtypxfgECl
         8RJvBTIspRyxJMssPA8Rs1jFXqMN9CFB2jQISLAMmoHoge2H2I/jIChj7iZCwnh5blan
         Oa3A==
X-Gm-Message-State: AOAM5320v0aNAFBc02DfUgou77p7+zMuGZu5rKXqTuYIEiPMGsOf14o3
        bkMzUnUfRvDFg2blTO/RHrw=
X-Google-Smtp-Source: ABdhPJynIG3JDxibrIAXIJtB+dvzcxEaBTTQyryfh3uw9TDO4zR9C+vdMLCX+anpQr2hFleHNabIbQ==
X-Received: by 2002:a17:906:4088:: with SMTP id u8mr8099809ejj.208.1614085902225;
        Tue, 23 Feb 2021 05:11:42 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v12sm4029840edx.90.2021.02.23.05.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:11:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-10-avarab@gmail.com>
 <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
 <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
 <1b2cb670-b49b-b478-7f69-6d4c356c8118@kdbg.org>
 <87h7mba3h3.fsf@evledraar.gmail.com> <xmqqk0r6ldrn.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqk0r6ldrn.fsf@gitster.g>
Date:   Tue, 23 Feb 2021 14:11:40 +0100
Message-ID: <877dmz7wtv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 17 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> +		sed -ne "s/^@@[^@]*@@//p" actual |
>>>> +		if test -n "$HEAD"
>>>> +		then
>>>> +			grep -F "$HEAD"
>>>> +		else
>>>> +			grep "^.*RIGHT"
>>>> +		fi
>>>> +	'
>>>>   done
>>>>     test_done
>>>
>>>> diff --git c/t/t4018/bash-arithmetic-function w/t/t4018/bash-arithmeti=
c-function
>>>> index c0b276cb50..935f18d96d 100644
>>>> --- c/t/t4018/bash-arithmetic-function
>>>> +++ w/t/t4018/bash-arithmetic-function
>>>> @@ -2,3 +2,6 @@ RIGHT() ((
>>>>         ChangeMe =3D "$x" + "$y"
>>>>   ))
>>>> +
>>>> +
>>>> +# HEADER |right()|
>>>>=20
>>>
>>> Clever! Opt-in for those who desire precise tests.
>>
>> Tests aren't only for testing a subjective "good enough" in the
>> estimation of the author of the code in question, but also for others
>> who later touch the same area and want to avoid regressions.
>>
>> Which is why I think it's an anti-pattern to use "grep SOME-SUBSTR" in
>> lieu of test_cmp if we can easily do the latter.
>
> Sounds good.  It shouldn't be too hard to satisfy both camps,
> i.e. the quoted demonstrates one way to allow test writers to
> give expectation in-place in the single test file, and replacing
> how it uses "grep" to check the output with test_cmp or whatever
> wouldn't make the resulting tests too hard to write and maintain.

It doesn't satisfy both camps, because I'd like to convert all these
tests to test_cmp because for a subsequent refactoring of userdiff.c by
me or others I don't know in advance what might break, so I'd like to
assert the exact current behavior.

Whereas your patch provides a way to opt-in individual tests to a
test_cmp-alike, but leaves the rest at grepping for the "RIGHT"
substring. Failures in the tests who aren't opted-in will be hidden.

It also means that subsequent changes to the behavior in the form of
submitted patches won't be as self-documenting, e.g. I've wondered if we
could introduce a case to balance parens in this code (sometimes C
function declarations stretch across lines), and there's e.g. the
arbitrary limit of 80 bytes on the line (which to be fair, we don't
curretly have tests for).

Anyway, as noted in [1] I don't see how this custom format of grepping
stuff out of plain-text files is simpler, particularly when its behavior
would start to rely on other things like "# HEADER |right()|" whose
behavior is a function of what we grep/sed when/where in the logic
driving the tests.

But if you & Johannes S. disagree with that I don't really say a way
forward with this series. I think e.g. squashing 09/27 into the rest
would make things simpler/less verbose, but the end-state would still be
matching the full hunk line, and if that's not something that's wanted
in any shape or form as a default...

1. https://lore.kernel.org/git/87h7mba3h3.fsf@evledraar.gmail.com/
