Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DECC433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CE661460
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 17:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbhD1Rlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 13:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbhD1Rl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 13:41:28 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295C4C061574
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 10:40:42 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id s2so20013603uap.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a6rSvuV8bpruCKw19cCtyeQ2zwOVk4xnKf9zIu580gQ=;
        b=aPVvPhLsaaWpn2iX4eG9StGwsnoqU4GZP7CuiySc6oZF91hJsyQaDtZJjpJrLaSNkD
         2AYINM7XM5DL39kdE/g3H+Zz62k944zeEyOzo8d+l5Z/GNuWhZ4ELimpkqQEQ5enzD1Q
         UL6ChfVBdjHaXQ91KHemhCwKVshXm9dmdJEZcbRBQGwoIhRUxFgGNBQdUe4HPf4cdUzk
         CPdyb6Lsyfv02D31tkmAKgkEH6rDJPKH5phiFqp9Dhk1arn4csQCRXdTxwQ268XCNSSp
         Vna7eO0Tqj1mPe19aroNrUexYS3TST21BgNSJ6F+Kf+mBQLIUCDaCbzDL508y/vpk2d6
         ZlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a6rSvuV8bpruCKw19cCtyeQ2zwOVk4xnKf9zIu580gQ=;
        b=Ojy9eb4NWYiDTgzvLm/Geahb+5ujsXiV7LC4oHggPpw6ehQWA2zOzc1Fye04QB1l/z
         vw/BiwSz8G/CSDSOVHQfAmy4t9HvJ/ajw9PfJZAeZSfMuH2XXqBEtIOSEhlOJNUQ8rJS
         5RJxuEcR51XJaiXhaeBWTCSpgqE9ftRwveoBfVaZnOcEOJpunCpD14673x4rj2+xLWoC
         8SPLZAc2lC29L8zXxFPwFnYQD0ZmMbuT3Dwir3heRyyUSn+eTSKwivpsxp9PD26yYvsL
         6uMqMB9mNoYZkP8gVea48bJohlbioPJY4UCVYii+XtyBjGETmfNflvVuKnZzij8Vun34
         H3ow==
X-Gm-Message-State: AOAM531jRApfv2omZP85NMNNDj6DFzUPi+a7beXJKgsOOH9gQLRC2d05
        iRsMWxyrxEEiae2sNql25u9fqLrIEOppOUU6FVKb2g==
X-Google-Smtp-Source: ABdhPJzP0RA2x1VujC6Bt9k1oRcAbctFVLcAIkmOjA15pUEy+q/LpBrOiIkVnZp8ycluTLkHP9ur8Q6fJky0RpfrvFk=
X-Received: by 2002:ab0:7216:: with SMTP id u22mr25327056uao.83.1619631641168;
 Wed, 28 Apr 2021 10:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
 <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com> <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <871ree8eto.fsf@evledraar.gmail.com> <CAFQ2z_Pco4KhhE7S_8zBZ7hCwOH=DnxHoKE8zus7REdQaXCZiQ@mail.gmail.com>
 <87lf953yto.fsf@evledraar.gmail.com> <CAFQ2z_Pb62Oe352UwdsPWLxjXd7P97pyuggTMK2URJd2p=OTnA@mail.gmail.com>
 <87h7jqz7k5.fsf@evledraar.gmail.com>
In-Reply-To: <87h7jqz7k5.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 28 Apr 2021 19:40:29 +0200
Message-ID: <CAFQ2z_P8vgY0RRT+XSH9K3VDQt39FLqXx6qfeZqaZPkwhq1w+A@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] Reftable support for git-core
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 6:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >> I.e. per [1] once if and when we have GIT_TEST_REFTABLE passing surely
> >> one of the best way to garner feedback on the rest is to discover thos=
e
> >> parts (using "make gcov", after running with/without
> >> GIT_TEST_REFTABLE=3D[true|false]) where we still have outstanding blin=
d
> >> spots between the tests and code.
> >
> > Getting GIT_TEST_REFTABLE=3D1 passing is the hard part, because it mean=
s
> > having  to understand exactly how the current code is supposed to
> > work.  Once I get to that point (with knowledge being complete and
> > tests passing), it will be easy to document what is happening and why.
> >
> > I was hoping that by posting these series with known test failures,
> > and questions marked "XXX" in reftable-backend.c, I would get feedback
> > from the other people who know exactly how this part of the code
> > works.  But from your mail, I get the sense that nobody understands
> > how the whole picture fits together?
>
> Almost definitely not. I don't know about you but when I'm looking at
> code I wrote 6 months ago handling some special case it takes me a while
> to get up to speed on just knowing what I knew then, and when we're
> talking about something like refs.c ...

:-(

on the bright side, once this is in, the expectations will be much
more explicit, because there are two backends that have to work in
roughly the same way.

> On the topic of the way forward: I for one would very much be for a plan
> where step 0 is to just a series import the reftable code you have
> as-is. I.e. we'd include it as an imported external library, maybe have
> some light test-tool integration and compile it / run its own tests, but
> not have/advertise the "git init" etc. integration yet.

I would really like that too, and I support this way forward. The bulk
of the work and problems are in the refs/reftable-backend.c and
assorted incompatibilities across the code base. The library itself
seems pretty solid at this point.

> I'm sure there's some things that'll need to change as we start the
> test/integration work, e.g. the reflog topic that's been discussed. But
> that's surely better done as some patches on top of the already-landed
> library import at this point v.s. trying to get the library perfect
> before getting it in-tree.
>
> Maybe Junio disagrees, just my 0.02....

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
