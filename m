Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC7BC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188CA611CE
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhEXHlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhEXHlD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:41:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D774FC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:39:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id et19so33235083ejc.4
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=77H9/z8b3nqSSh7iU4isDcF9pD+tEGWzNtrz7VedZ1k=;
        b=HCwwvVAQpwPp+D6pBs1EUYXECziXAy0KSGo79CKL37WTExJVg+bc3STCp4qG99VzS9
         XfAS+PatmptVZ/FPbE/N1AOdag7NvgVCxTT9/XcrKQkZkcg40h0SEogJm2+rMhuTtmD/
         9oxNwkETeN70Fnhw8nBf2gJrJCLFfxB+mllXmMJ3B8LxdgEgq0qYsyEZBEUSI/4uMi3l
         qFu+4tBSxyIs0CgTEQuA3lHo36t/99YXD/3EFYAGxAzWW4PhNdQh8+HIcu6zfOf5eq+R
         2OKIvIoSK0lrnxqRue6Y8iwkL7ygyJ8HgFEtzHfbOiv1D8o/o1279R0ssf9Ty3ETqRDj
         F2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=77H9/z8b3nqSSh7iU4isDcF9pD+tEGWzNtrz7VedZ1k=;
        b=p6KwtDsrIFT24/ddXJqmlyXLu8eQJLAwRUnCYzlsQoGompdqomgYWEfOJHnKWTOqo6
         9CP/FDsgBH7yrH+HpyrudE2cycHJeUBI5FCY3XHEtcX3fo1ycwOxK3o1CEPEI/Ype4i4
         zzqKByJWfQXXwUf+677moCvcwkFdsREqE9OWcyHuTJ7OVW+yu4Gied/CUVaLFYHrzfmp
         7BPHU7VuMb9FuWZv3jeZmCZg2yJL1+qGdGDMLoncawrvZWL2qKE/j5NOj5XVeqRUHd7s
         12rvZ0Ag+9goSm6R5MXJOqKn0rn+8gbt+Z8qB1scqW+AVypBJQGflvZoYvKhuEl+hHw5
         CcWQ==
X-Gm-Message-State: AOAM5316FJdzXjBG2beUI1gt3E7AY4XNzmKSpgAeStLbXK7M/ZxfTFuX
        qD2Be6DQ5nJ3lLx4XQxehO8=
X-Google-Smtp-Source: ABdhPJxCfs3KCsnKuo03mkiw/W6P0F68WoYm69RS2j6LW4u6lqSparMmZLsP/5bqGRe8BPJqhhQCDQ==
X-Received: by 2002:a17:907:760b:: with SMTP id jx11mr22195368ejc.344.1621841973276;
        Mon, 24 May 2021 00:39:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gw6sm7137816ejb.86.2021.05.24.00.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:39:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on Linux
Date:   Mon, 24 May 2021 09:03:59 +0200
References: <20210509213217.449489-1-lenaic@lhuard.fr>
        <20210520221359.75615-1-lenaic@lhuard.fr>
        <20210520221359.75615-5-lenaic@lhuard.fr>
        <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
        <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
        <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
        <60aaa09aebce4_454920811@natae.notmuch>
        <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
Message-ID: <87wnrooa17.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 23 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-05-23 at 18:36:10, Felipe Contreras wrote:
>> Johannes Schindelin wrote:
>> > On Fri, 21 May 2021, Derrick Stolee wrote:
>> >=20
>> > > On 5/21/2021 5:59 AM, Bagas Sanjaya wrote:
>> > > > On 21/05/21 05.13, L=C3=A9na=C3=AFc Huard wrote:
>> > > >> The existing mechanism for scheduling background maintenance is d=
one
>> > > >> through cron. On Linux systems managed by systemd, systemd provid=
es an
>> > > >> alternative to schedule recurring tasks: systemd timers.
>> > > >>
>> > > >> The main motivations to implement systemd timers in addition to c=
ron
>> > > >> are:
>> > > >> * cron is optional and Linux systems running systemd might not ha=
ve it
>> > > >> =C2=A0=C2=A0 installed.
>> > > >> * The execution of `crontab -l` can tell us if cron is installed =
but not
>> > > >> =C2=A0=C2=A0 if the daemon is actually running.
>> > > >> * With systemd, each service is run in its own cgroup and its log=
s are
>> > > >> =C2=A0=C2=A0 tagged by the service inside journald. With cron, al=
l scheduled tasks
>> > > >> =C2=A0=C2=A0 are running in the cron daemon cgroup and all the lo=
gs of the
>> > > >> =C2=A0=C2=A0 user-scheduled tasks are pretended to belong to the =
system cron
>> > > >> =C2=A0=C2=A0 service.
>> > > >> =C2=A0=C2=A0 Concretely, a user that doesn=E2=80=99t have access =
to the system logs won=E2=80=99t
>> > > >> =C2=A0=C2=A0 have access to the log of its own tasks scheduled by=
 cron whereas he
>> > > >> =C2=A0=C2=A0 will have access to the log of its own tasks schedul=
ed by systemd
>> > > >> =C2=A0=C2=A0 timer.
>> > > >
>> > > > For gender neutrality, we can use he/she instead.
>> > >
>> > > Singular "they" is better. Fully accurate and less awkward.
>> >=20
>> > I agree.
>>=20
>> I disagree.
>
> I'm fully in support of singular "they".  It provides a useful pronoun
> to use in this context, is widely understood and used, is less awkward
> than "he/she," and is less sexist than the indefinite "he."

I think we should be the most concerned about the lack of inclusivity
and chilling effect in us being overly picky about the minute details of
commit message wording, long past the point of practical utility.

In this particular case the context is a discussion about "a user" on a
*nix system and what they do and don't have access to.

I think it's a particularly misguided distraction to argue about
he/she/they here, since the most accurate thing would really be "it".

At least on my *nix systems most users are system users, and don't map
to any particular human being, but I digress.

I would like to encourage people in this thread who are calling for a
change in wording here to consider whether this sort of discussion is a
good use of the ML's time, and the chilling effect of being overly picky
when many contributors are working in their second, third etc. language.

Personally I don't care whether someone submits a patch where their
commit message discusses an example of "he", "she", "they", "it" or
whatever. It's just meant as an example, and not some statement about
what the gender (or lack thereof) of such a user *should* be.

It's immediately obvious what the author meant in this case, and that
the particular wording is arbitrary. For the purposes of discussing the
contribution it matters whether it's unclear or ambiguous, which it's
not.
