Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2522FC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 09:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiDHJXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 05:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiDHJXW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 05:23:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244D2348A60
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 02:21:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so16088815ejd.3
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RrrSz+J0mssDqDpfeABPpmiOg5+ROqRbHcfPwyH8kKg=;
        b=qU5mhhdjcv4XqwL+OU5yewytuMOpLnCI0fLuBQsIqhDuZjkonjg/tR49Y/JpYkW38x
         Kre7wkommOEO5mVPRME2RzWHOH+1la6lWPjSUQST8SJVA/L8BA2OazWLWBQzuJlKkVX9
         azWTaHqLd6z6Bdvi/5e3WEnrHcT4AGa3L8bMpGO30iHJvNNoaU0wwopuywFH2aolN00K
         /JDQUxanSdhzH/AdfubIQ0XYAm4LvxXdWlt/gPNU+q0cJauh/es9yrkTeWao6JdYokeC
         2BDh4GhUx8oEmnW2zeW1Dw4iHl+wLn6ly1erRrB+Etjc27kdBba3qDwsDJ49MY69uJmA
         IIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RrrSz+J0mssDqDpfeABPpmiOg5+ROqRbHcfPwyH8kKg=;
        b=ShgJVO+k5Se+1q8nhla5dxUp8hqeesUdn48ujQJ1BrrzjDEvDzeIeAKQTe1FcAfRTm
         lqpG9piSriieTZbYRCRdVZsuI5ATlmVi2KCfCceF54jD3JGvHtpHoj+dUY1JaEzL1D6D
         P+Y6v2uECB71gItcT7g/Dibja4O6ajYZHbEFmaJgoxWvFnLDVcx++yb5E6mz7bXohPi2
         iCz7wZ0drfhipbucZmbal6zwbwGaQS6uHRmidQJHNHBbsjMhUOmAkld+TxJZCYrzTaEG
         64poZykbvHAp7nn7ln3QIei5ejOizDbCeKdGRngU1mOZPWv7WfcS6qkgC9M7ofidcpbD
         mrXw==
X-Gm-Message-State: AOAM530YA7vNWaTzgPv9yPw4GL7SAbE9ZlyVPKVfXmyVKhb+JtLXGjY4
        hq6rxNNq7An4R4iVy3ZFT9I=
X-Google-Smtp-Source: ABdhPJwyMEjeYoXWja0jwnPPLN4a4n6fCu9gymaGS4t9ORvs7fh5CH+3loeJhbxjwQCtjYn2XAsPkg==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr17218766ejc.287.1649409670359;
        Fri, 08 Apr 2022 02:21:10 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906770900b006d20acf7e2bsm8510203ejm.200.2022.04.08.02.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 02:21:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncknl-001GBc-4s;
        Fri, 08 Apr 2022 11:21:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Date:   Fri, 08 Apr 2022 11:15:25 +0200
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
        <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
        <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
        <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com>
        <220304.86a6e5g44z.gmgdl@evledraar.gmail.com>
        <1469e420-63e5-e2db-21d5-c70674ab04d5@github.com>
        <ddebc223-1e13-e758-f9b1-d3f23961e459@github.com>
        <1b63a8eb-9a6d-a07e-9070-9cdc0c4d5a1c@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1b63a8eb-9a6d-a07e-9070-9cdc0c4d5a1c@github.com>
Message-ID: <220408.86zgkwaq2i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 07 2022, Derrick Stolee wrote:

> On 3/8/2022 12:15 PM, Derrick Stolee wrote:
>> On 3/4/2022 10:12 AM, Derrick Stolee wrote:
>>> On 3/4/2022 9:49 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> Also, as noted in the upthread
>>>> <220224.86czjdb22l.gmgdl@evledraar.gmail.com> it might be useful to ch=
at
>>>> in a more voice/video medium in parallel (maybe mid-next-week) about t=
he
>>>> high-level ideas & to get a feel for our goals, conflicts etc. Doing
>>>> that over very long E-Mail exchanges (and the fault of "long" there is
>>>> mostly on my side:) can be a bit harder...
>>>
>>> I agree. I we can work out a time in a private thread and I can send
>>> you a video call invite.
>>=20
>> =C3=86var and I just finished our chat and came away with these two
>> action items:
>>=20
>> 1. =C3=86var will finish prepping his RFC as-is and send it to the list.
>>    It contains several deeply technical optimizations that are
>>    critical to how his model works, but could also be used to
>>    improve scenarios in the table of contents model.
>
> =C3=86var: I'm still waiting on the full version of this. While you
> updated [1] your original RFC [2], it was incomplete. I am still
> looking forward to seeing your full vision of how it works with
> incremental fetch and how your optimizations to download only the
> headers of the bundles will work.
>
> [1] [RFC PATCH v2 00/13] bundle-uri: a "dumb CDN" for git
>     https://lore.kernel.org/git/RFC-cover-v2-00.13-00000000000-20220311T1=
55841Z-avarab@gmail.com/
>
> [2] [RFC PATCH 00/13] Add bundle-uri: resumably clones, static "dumb" CDN=
 etc.
>     https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T15053=
4Z-avarab@gmail.com/
>
>> 2. =C3=86var will then do a round of taking both series and combining
>>    them in a way that allows the union of possible functionality
>>    to work.
>
> Or perhaps you are jumping straight to this part?

Yeah, that was part of it...

>> 3. As these things come out, I will make it a priority to read the
>>    patches and provide feedback focusing on high-level concepts
>>    and ways we can split the future, non-RFC series into chunks
>>    that provide incremental functionality while keeping review
>>    easier than reading the whole series.
>
> I'm still looking forward to seeing progress in this area. Please
> let me know what your plan is here.

Hi. I'm sorry about the delay, I ran into various life/software things,
and found that this topic required a lot of continuous "sit down for a
day and work on it" attention from me v.s. some other topics where I'd
deal with interruption better.

Then I was hoping that the merger of your bundle.c changes would come a
bit earlier before the rc, but they pretty much coincided, and since the
rc dropped I've been hesitant to send a very large topic to the list
(c.f. e.g. [1]).

Maybe I should just bite the bullet and submit it anyway, what do you
think?

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2204071407160.347@tvgsbejv=
aqbjf.bet/
