Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43FC2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C6E613BD
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhEZLQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 07:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhEZLQP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 07:16:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B3AC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:14:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z16so1174030ejr.4
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gspVUrw28YQWy6F3JtuKvwsQQC1xZ+wLwOWNMBRYmeI=;
        b=M7t6NF9jzk/nlMdWG4hGghOelvrS4Wx+hZvKfEXLygwpdXEuXs1Lgqeq3FfpiQIr3Q
         U6B5AJXLOPwzpc2PLfQfga4Z1V+n0l92YBAA5rDuUU2Yz/3l8WLdU6xNb/ctll+li6DU
         Nhc9h9mXxr5g6cOqJpXuRMG6skcSka4nwD4XLMB4lPeS3MU43W5/EMBH9bBiCsrIKSTe
         +i63oAGBvuM5oUnYRmLXktWGOxn3dJ6JIaETCkMiiWm50sgKflIlsv9AqCgk/hVUdkUy
         U5r3KepjvT51e6zlrnZOztUdGVoljizTryHtB6FchNgg4e2Qje7mJILszGHR7rSiRqnX
         lxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gspVUrw28YQWy6F3JtuKvwsQQC1xZ+wLwOWNMBRYmeI=;
        b=bON7NAq4/UxRRyGWEDJ0wCo9T1iHjenD4Ux1z5P587t58/pTgj9ohu6deXw55eWvSp
         QsxjfEEIGD79oysyPXyP9V4T8o6IBY0MupGMJ96UU+AKOjj4CxaIOIZy2OtUrpbYiFgg
         wByZ/Ozay1NsfDpde9o6SfUAX54fQjFq+hWzD0ml9wOAeGnGnpCSZYiEjPHClSGzKEy/
         SOHUeB/n5JZvdsf9xdwcJtUFM1y4MVUrGYk3Jsyfxl+akfSOcBHOjohsJhMFCirKTzGS
         50VGAuoxPkWP8GtdJfSIZquZUXaBk1irK1ZVQhRbUCM36RjWuWuZK1LbaduYkUGbE0Kl
         puyQ==
X-Gm-Message-State: AOAM531p+uQIT5BW6zJ5nnXSxgZ4zBLwLGrZGH2Ppgq+DYa7GS2jTL2Y
        5/bUM/Png29huCu33sJCZVM=
X-Google-Smtp-Source: ABdhPJxVgX6xWafA5H0dpmVZj0+Ld1A21MzCJUmR1pP3BQVTQrqsj4kM5Y+bEzWEFrft7Zg154hR1Q==
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr32776413ejb.542.1622027681883;
        Wed, 26 May 2021 04:14:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x10sm12174642edd.30.2021.05.26.04.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 04:14:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: CoC, inclusivity etc. (was "Re: [...] systemd timers on Linux")
Date:   Wed, 26 May 2021 12:29:01 +0200
References: <20210509213217.449489-1-lenaic@lhuard.fr>
        <20210520221359.75615-1-lenaic@lhuard.fr>
        <20210520221359.75615-5-lenaic@lhuard.fr>
        <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
        <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
        <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
        <60aaa09aebce4_454920811@natae.notmuch>
        <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
        <87wnrooa17.fsf@evledraar.gmail.com> <xmqqim38jfja.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
Message-ID: <87mtshn3vj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 25 2021, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 25 May 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > Personally I don't care whether someone submits a patch where their
>> > commit message discusses an example of "he", "she", "they", "it" or
>> > whatever. It's just meant as an example, and not some statement about
>> > what the gender (or lack thereof) of such a user *should* be.
>> >
>> > It's immediately obvious what the author meant in this case, and that
>> > the particular wording is arbitrary. For the purposes of discussing the
>> > contribution it matters whether it's unclear or ambiguous, which it's
>> > not.
>>
>> Nicely put.  Thanks.
>
> _Personally_ I don't care either. Because I am exactly in that group of
> young, Caucasian male developers that are so highly overrepresented in our
> community already. I will never have a problem thinking that I don't
> belong here. I never had that problem.
>
> And I believe that you, =C3=86var, are very much in the same boat. You wi=
ll
> never feel as if you don't belong in tech. You're Caucasian, male, and
> like me, come with an abundance of confidence.
>
> Now, let's go for a little thought experiment. Let's pretend for a moment
> that we lacked that confidence. That we were trying to enter a community
> with almost no male members at all. Where an email thread was going on
> about inviting us to join, using no male pronouns, or putting them last.
> And remember: no confidence, no representation. Now, would you dare
> chiming in, offering myself as a target? I know I wouldn't. Yet that's
> exactly the atmosphere we're fostering here.
>
> What you say, matters. _How_ you say it, matters.
>
> In other words, I think that the _personal_ opinions of everybody who
> spoke up in this mail thread (you might have noticed that all of us are
> male, you could even call it a "male thread") are not the problem we are
> discussing. Personal opinions are kind of missing the point here. By a
> mile. And then some.
>
> The actual point is that we want to avoid giving the impression that
> only people who feel included by the pronoun "he" are invited. That we
> only really care about male users and developers, and pay only scant
> tribute to the rest.
>
> And yes, even "he/she", or "(s)he" would give that impression, by
> emphasizing a priority order. And "they" simply would not do that. And if
> it makes a few male readers slightly uncomfortable, it might present a
> fine opportunity to exercise some empathy with those who feel
> uncomfortable and excluded all the time.
>
> Thank you,

I don't think it's helpful or in the spirit of our CoC to characterize
discussion in terms of the genders or nationalities of its participants.

I'm not accusing you of some CoC violation, just suggesting that it
makes more better conversation to take participants at their word and
assume good faith.

You can't say based on some superficial piece of information what a
project participant might be dealing with, e.g. perhaps they're anxious
about screwing up some trivial thing on a public ML, feel that they're
inexperienced and/or have some "impostor syndrome" etc.

The reason I chimed in on this thread was that I thought concern over
one such topic had started to negatively impact another. We've got a lot
of people trying to contribute who aren't comfortable contributing in
English, or whose proficiency doesn't extend to the latest linguistic
trends.

I'm suggesting that it's more helpful to leave certain things be than to
pounce on contributors about things that are ultimately not integral to
their work, and which can be readily understood.

E.g. if someone's clearly a speaker of a Slavic language and it shows in
their grammar I don't think we should be aiming to have them massage
their patch until it's indistinguishable from that of a native speaker
of English.

We should make sure we understand what's being said[1], but I think
anything past that point is starting to bring us negative value. At some
point it's good enough that we can understand the intent, and by
assuming good faith we're better off letting things like "he" v.s. "she"
v.s. "they" slide.

To not do so is to needlessly create a barrier to participation in this
project. I think the side discussion about Merriam Webster[2] somewhat
misses the mark here.

The question isn't whether what's being suggested would be a valid
sentence according to a dictionary, but whether e.g. someone who's
learned English from a commonly available textbook (I daresay most
"Beginner English" textbooks have more "he" and "she" examples than
"they") is going to inadvertently run afoul of other people's
preferences.

If they do it's more work for them (partially because they're a
non-native speaker), and ultimately more things we need to cover in
Documentation/SubmittingPatches etc. All of that's more barriers of
entry to project participation.

1. https://lore.kernel.org/git/87wns6u8pc.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/YKrk4dEjEm6+48ji@camp.crustytoothpaste.net/
