Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D51C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 12:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE832613C1
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 12:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhGBMzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 08:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhGBMzs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 08:55:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582CC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 05:53:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l24so13069214edr.11
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RMzamJ9p1RKEAPi6OuecEFkmd8VXlCSzogY8tPjMHDU=;
        b=c4ip1zf4xW8lDgeEq9U3biyZXPPC0Oabq+okkKFFvwFzQOhA8PRu+0TzLptMjmUCR8
         FqKCf+l33wVGCSJP5+Kr3nbYc0oNtnNggB1Xo6zG3PoAnhM6j9NOSEVJijQHXZhGQ1KT
         W/AD2SuPQa3Tf4MhiHk1weWkCy1GQ3umwx8Df5F2zvo7e1clfbsjoa7KsPA07Asa29Ch
         OAjS2WfzEAzzqLoCSDS54sLQALIC8sUkBNawt2z4dbKef4cjgw0N2DYDqglkBYttyS4n
         qEqamMDtgsq4HMmVrJ/5NMqhu4efYRWWPC7KPdj+BU6LMyueiysPv8AwCE/dkZB1NVgz
         28gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RMzamJ9p1RKEAPi6OuecEFkmd8VXlCSzogY8tPjMHDU=;
        b=a3FSnbGyzgd3fMpPLq5tXny3P8i5x1Xyu8n1VmA1RjbmsZYWG6uKBTZM8MV/6Ie8El
         UvCuxk/6M7t/ECaG2D6UbvfD9oyrdGIFZxZfErIGLWMBXhYriHaKmrIQIWjT0473zvd+
         DdkpVs1xPUGys9Btf4PBZ8Vd5ntppYiQTnMGu51Kx1maR77aIduXEyEC8CFVTNGhqG54
         K3JpZSS3B/Vo8dRRdwgpywzRTbcXxBKDKzwgad1Fvwj0IAKjdKKUVsktKakR57FiQcto
         gOcCMwI/VamaDJ+4Coo8CpmZwxennWWvcjhz7OMVVTgIN6KOOe4FBcNWpv5eiAecSa45
         oD3w==
X-Gm-Message-State: AOAM530IT7UfVZI6rDL2iTXvLj32q6uflpnjOr0TiNnk4dINnJQssgXi
        ICQA3RodL6kdboSi2AlTFyM=
X-Google-Smtp-Source: ABdhPJwJXT4UGfPcMHffxPdbwV5bFZZSvsB176K/i4Q2KuNDtsFpeSfUQlb+IwABuuBRHK1BPS+j2A==
X-Received: by 2002:a50:9556:: with SMTP id v22mr5960186eda.360.1625230395246;
        Fri, 02 Jul 2021 05:53:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c19sm995048eja.84.2021.07.02.05.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:53:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Date:   Fri, 02 Jul 2021 14:18:40 +0200
References: <xmqq4kdft122.fsf@gitster.g>
 <87o8bmcd9a.fsf@evledraar.gmail.com> <xmqqczs2rrew.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqczs2rrew.fsf@gitster.g>
Message-ID: <87tulcand1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> And:
>>
>>>  - Makefile: remove an out-of-date comment
>>>  - Makefile: stop hardcoding {command,config}-list.h
>>>  - Makefile: mark "check" target as .PHONY
>>
>> https://lore.kernel.org/git/cover-0.3-0000000000-20210629T190137Z-avarab=
@gmail.com/
>>
>> But you re-combined them. If it makes things easier for you I'm all for
>> it, but it seems better to me keep them split if that mean that some
>> parts can advance faster, and thus make the rest easier to review.
>
> I am all for that reasoning, but in this case (and other topics that
> I "combined", as well), one had textual dependencies on the other,
> and didn't make sense to split them into two, as neither part can
> advance without affecting the other, if I recall correctly.

Yes, they can't be advanced separately, one depends on the other in
turn. I'm suggesting that the parts that go earlier in the sequence
could advance before the later parts.

I.e. the whole hook topic is a big chunk that needs careful review, but
e.g. the relatively trivial Makefile topic could hopefully advance
fairly fast to "master", followed by the easily understood hook-list.h
topic.

The result would be peeling the first 6 commits off
ab/config-based-hooks-base, leaving a smaller set of commits for
reviewers of the "meaty" part of ab/config-based-hooks-base to focus on.

I started doing it this way because of your comments that I tended to
produce fairl long-winded topics. Often e.g. I'll find a bug, only to
discover that we don't test anything in that area. I thought that by
putting trivial cleanups, tests etc. first some of the "prep" work could
graduate early, leaving the more complex for later.

But perhaps that's not something you'd like to see. I'm still trying to
get a feel for if/how you'd like to split certain things.

One alternative in general (although not so much with the
ab/config-based-hooks-base topic) would be to simply withhold some of
the later parts locally. I've got several topics outstanding that are in
that state, the real "meaty" part hasn't landed on-list yet.

That has the advantage of having smaller and more incremental parts
on-list for review, but at the drawback that those earlier topics often
seem like a "bridge to nohere". E.g. my "handle_stdin_line" topic[1] is
one such topic. I found an existing in-tree user for it, but the real
thing I wanted it for still hasn't materialized.

>>> * ab/doc-retire-alice-bob (2021-06-16) 6 commits
>>>  - pack-protocol doc: use "www-data" in place of "alice"
>>>  - doc: replace "alice" and "bob" with "jdoe" and "msmith"
>>>  - fast-import doc: change "bob" in an example to "file.txt"
>>>  - daemon doc + code comments: reword "alice" example
>>>  - gitcvs-migration doc: replace "alice" and "bob" with "you" and "www-=
data"
>>>  - gittutorial doc: replace "alice" and "bob" with "you" and "www-data"
>>
>> Having re-read the discussion now I don't know if there's anything
>> outstanding to change about this series. It's gotten a lot of attention
>> so far, so it's more of a matter of if you're willing to take this sort
>> of documentation change or not.
>
> I actually do agree with the objection that www-data is a contrived
> thing to use in the examples, not because the user www-data is
> distro specific, but because it involves one physical human user
> acting on two accounts, instead of two human users interacting with
> each other.

The www-thing is arbitrary, and I can change that bit, but what do you
think of what I mentioned at the end of [2], i.e.:

=20=20=20=20
    [...] the purposes of the example in the guide replacing Alice & Bob
    with You & another version of you removes a lot of potential
    confusion, we don't need to cover permissions, the other user doing
    unexpected things like non-ff updates, pruning branches you may have
    relied on through the --local clone etc.
=20=20=20=20
    It's implicit that both "users" are you, so we only have to discuss the
    point of the actual example, how to pull and push between two different
    repos, the "different users" in this case was always a distraction.

I do think it makes things simpler in that sense, i.e. aside from "alice
and bob" if we start talking about two human users on the same system
the reader we'll need to be more guarded about describing repository
interactions, because we're acting on remote data that the reader might
correctly assume is changing concurrently outside of their control.

Whereas the real point of that example is to demonstrate how one user
might push and pull between two repositories under their control, so
using an example that assumes one user implicitly side-steps any such
discussion of permissions, data races etc.

1. https://lore.kernel.org/git/cover-0.4-00000000000-20210621T150651Z-avara=
b@gmail.com/
2. https://lore.kernel.org/git/875yyc5i6x.fsf@evledraar.gmail.com/
