Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A4CC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33F46023F
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFMHrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 03:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMHrU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 03:47:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547FDC061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:45:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id he7so11055886ejc.13
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6GuHfD1u2HDvkp7RYW6yzYNuvZG4FtMTudinMJ4gvYI=;
        b=mNL03y3QSZTcEkhQR9ls6WYkC4e2g0B2gaCTLuZaNsySyS6NPQGMsPJa2jYfmYZJYD
         kpjJ9kwZwINudYNtpowvBitemPY0Rd7BdIO1JZbSFUc6YtkibuhpySNHAx0I6sYBsf3S
         +0tvcdfF9uhrY7UpsTL9SAvo/P3EbAZQPMVUsguYbxFnezjXKUAvyvScXChVVRD3HVTO
         HD+QPwXpvVm8fCUBvPgvZGd7yLpqPb0APp7mvyZkZbJrLmAhi+rOfTJbx6JvyfILbxGN
         5OYdaKCp4nMZ0cP0/tnb/U3LwVo9ZCzbgRBcysv/4cUc9nf13lR6TMJEDRYzBsbEVy0R
         lEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6GuHfD1u2HDvkp7RYW6yzYNuvZG4FtMTudinMJ4gvYI=;
        b=bMzqLx4WkLgEDAdSj/nvEjCb5XszcqzTFTQExOJIK9GFM9+mW4csqPoI3jEF4Qj5JP
         eLHACQizS1Rtx1bdXWD6cqVfIpKAiMpCsbsdeVz7RSZNfjkkQS7HdHO90FUAl/74E8hx
         rpgF3pnsxYuRJDxzY1nMWgdvzXYQb3XAdDG0aGPVPTIT9ere/TFqYcarifWz2E0+l90g
         PECeUio59x/ygSNZsSAdaD9Fit3tT95mT1xzhD3lPkqv+zfaIk1Sgyrg0ssIif/73hH9
         NSLffHVCWeUqQtFjPSUtG3/9Ton6oyMyjxG/zw27LY4Umx2QrF4+7kCRdnx5HXhtWlXi
         OsaA==
X-Gm-Message-State: AOAM533QIyyQ8hhnWawXitpDrl+EXEOjjSqcOYR7+Y99XhE6qz3AF6t9
        Qt7hzBxhViN0acaRw5r3W2g=
X-Google-Smtp-Source: ABdhPJwew5EauHa6H5w4AZ6PECt3P5TeQuouIlbgeVEV/8uADJe9+Su4SDbD7JmvY4zWu6lxhbMX9g==
X-Received: by 2002:a17:906:26cb:: with SMTP id u11mr10778003ejc.385.1623570317744;
        Sun, 13 Jun 2021 00:45:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w2sm4227975ejn.118.2021.06.13.00.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 00:45:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
Date:   Sun, 13 Jun 2021 09:17:21 +0200
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <87a6nz2fda.fsf@evledraar.gmail.com>
        <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
        <87pmwt1dz3.fsf@evledraar.gmail.com>
        <f4488360-bdaf-3e97-69c5-00087f797117@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <f4488360-bdaf-3e97-69c5-00087f797117@gmail.com>
Message-ID: <87h7i21a43.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 11 2021, Derrick Stolee wrote:

> On 6/10/2021 6:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Jun 10 2021, brian m. carlson wrote:
>>=20
> ...
>>> In many cases, saying less is better, I agree.  If we don't need to
>>> refer to a human being, then we don't need to consider any pronouns for
>>> that human being.  If we communicate things more simply with fewer
>>> words, then that's clearly better overall for everyone involved.
>>> Nobody's reading documentation for pleasure, after all.
>>>
>>> I do think that the recommendation that we refer to an anonymous user in
>>> a gender-neutral way still stands, though.  Sometimes we will need to
>>> refer to the user or another human actor and that will be the most
>>> natural way to express the idea, so we should use gender-neutral
>>> language to do so.
>>>
>>> So roughly here, I'm in favor of both approaches.
>>=20
>> When do we need or even prefer to refer to a user like that?
>>=20
>> I haven't seen an example in our documentation that's actually better
>> off because we're talking about things as if two "people" we need to
>> invent pronouns for are interacting.
>>=20
>> Can anyone name one that'll stand up under scrutiny, i.e. once we can
>> look at it and see if we couldn't phrase it better by avoiding the issue
>> this series tries to address with a regex search-replacement?
>>=20
>> The diffstat of this series is only:
>>=20
>>  12 files changed, 22 insertions(+), 15 deletions(-)
>>=20
>> I've looked at all of them and I can't see one that wouldn't be better
>> if the relevant text was changed similarly to what I've suggested
>> upthread.
>>=20
>> That's why I don't think this proposal is useful. If we accept this
>> series we're going to be left with an active recommendation for a
>> pattern that's already almost nonexistent in our documentation.
>>=20
>> Perhaps that's because we're doing it 98% right already and aren't using
>> "he" or "she" but "they" or "their". The multiple ways you can use
>> "they" or "their" in the English language makes that hard to grep for. A
>> lot of our "they"'s are referring e.g. to a command-line option, or
>> "their" referring to "their arguments", as in the argv vector of a
>> program.
>
> Since the examples are already few in number, it is not an
> overwhelming amount of work to remove third-person singular pronouns
> from the necessary locations. Perhaps if there were more examples
> then such a conversion would be too difficult and we would want to
> use a more mechanical replacement with singular "they".
>
> My general approach (as specified in this v2) is:
>
> 1. Use singular "they" over "he" or "she" and other variants.
> 2. If you don't want to write "they", then avoid third-person
>    singular pronouns.
>
> Your approach focuses only on item 2, giving this recommendation:
>
> * Avoid third-person singular pronouns.
>
> I think your change to CodingGuidelines is a bit verbose to get to
> that point, [...]

It is, because I'm not trying to get to that point at all, and I haven't
been convinced by your proposed series that we need to. I think it's
implicitly covered more generally applicable advice.

> and makes it difficult to understand one goal is to
> avoid gendered pronouns, which I think reduces the chance that a
> new contributor would discover and understand that recommendation.

I think a new contributor is going to be confused by your proposed
modification to the CodingGuidelines because it doesn't activtely tell
you how to do things in the common case, but just that you should avoid
this one obscure edge case.

I'm not saying my hastily written alternative is perfect, but it is a
start at providing some much more general advice that would also have
the effect of bypassing the issue you're concerned about, would it not?

> A semantically similar addition would be:
>
> 	Avoid gendered pronouns such as "he/him" and "she/her". If
> 	necessary, alter your sentence structure to use singular "you"
> 	to refer to the reader or plural "they" to refer to multiple
> 	actors.

Or, if we just fix these existing occurrences as a one-off there'll be
no existing examples of it in-tree, and as people tend to imitate
existing documentation they're unlikely to introduce new
occurrences.

Even before any discussion of an explicit recommendation the number of
occurrences is tiny compared to the volume of documentation we have.

If and when Felipe's <20210611202819.47077-1-felipe.contreras@gmail.com>
is applied how small is the diff you'll still have rebased on top of
that?

There's a cost/benefit trade-off between noting something in
CodingGuidelines, meaning that all contributors going forward will have
to read it and understand it, and just fixing a rare issue as a one-off.

I've provided examples of e.g. binutils, C library etc. documentation
that covers similar problem spaces, I'm fairly sure most/all of that
documentation was written in a way that satisfies your criteria without
the need for any specific advice on this point.

>> The skepticism about this being needed at all isn't an opinion I hold
>> about software documentation in general, but about software in Git's
>> problem space specifically.
>
> A change that says "don't use 'he' and/or 'she' unnecessarily" is
> important to encode as a project guideline so we can stop having
> discussions about their use whenever they are introduced in a patch.

> There is value in having this decision encoded, and the important
> thing from my standpoint is that we explicitly avoid gendered pronouns
> and can simply point contributors to that decision if we ever notice
> one being introduced. That reduces friction the same way that we
> decide where curly braces should be placed after an "if" statement.

I'd probably agree with you if this was anything as common in our
documentation as missing {} if/else braces are in our code.

Due to the relative rarity of the documentation issue you're fixing I
can't think of a comparison other than: There's probably also plenty of
generic issues in our code that if fixed, would result in a diffstat
similar to your "12 files changed, 22 insertions(+), 15
deletions(-)".

Assuming your series and Felipe's overlaps (I haven't tried rebasing it
myself) a "9 files changed, 13 insertions(+), 14 deletions(-)" would be
deducted from that.

It doesn't follow that an issue of that rarity belongs in the
CodingGuidelines. Maybe there are still convincing reasons to include
them, I just don't think you've provided any.

It seems to me that any future proposed addition of an elaborate example
where we're gendering the command-line utility or the UID of some OS
user can be changed in a way that satisfies your criteria because it's
overly verbose and imprecise.

> My preference continues to be singular "they" because it is an easy
> way to adapt natural sentence structures into an inclusive language.
> But if we decide that this grammar is too difficult for some readers
> to understand (due to English as a secondary language or other
> reasons to be more strict to older language patterns), then avoiding
> gendered pronouns entirely would satisfy my goals in this series.

Wouldn't it also satisfy your goals to re-roll on top of
<20210611202819.47077-1-felipe.contreras@gmail.com> and more generally
look at the leftover hunks as noted in my
<87a6nz2fda.fsf@evledraar.gmail.com>?
