Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA8FC4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 12:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B68760E09
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 12:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhGYLYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 07:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhGYLYN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 07:24:13 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF8BC061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 05:04:44 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r6so8238743ioj.8
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iQRFVnL5AJh42n0LXxQtHr9dDMt+SpC3LvwF+rkQHM=;
        b=eNPg01NUCuVnPNB3GuJqNe7qwCH+uUaYT6R5hvvn5aIwBqPnKbigINdwwfQpmRQ+Xm
         c/25OOZGfIwZ3RQJyzLBWrzOi8jIi5h6ArBkb5x97a85SnREQ/Fi9NRR2a1VCnjmdUi0
         dmJ0uas66vMDlEGqluakpe/jJSw7Q2Ekw3AmnHkf8/5RniZfHWSUf6WQDA4HopCK20i6
         iDt9b8x0XVUnUvTHCs7uRhl5dga9YH4y3cHs/I2qW8jgClLtbdjKInnMudf/s/k386uW
         gxxyBTT871e7eMc5pDXAyqAOSUyyf/VwgCeee4iRn598cGtbFXflpqIGb2VjkwMk65oh
         uh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iQRFVnL5AJh42n0LXxQtHr9dDMt+SpC3LvwF+rkQHM=;
        b=Bo6LwRO/wssLQ557JDVRf4K+EPkf4dd0twIZJyr+MMuDjog/UR1L8PqimCCyJ4Entl
         7tNwQLe/nBm6E64WuYyH6zX0a2A2jSCt6IHtXagD1xZDhB5jSSgj8eP6p6Tawssc4aLN
         yZdG9FTscaLlT8ttKPokG5yhxnMHTYHNLlgTyIk6/n/5Lrupk1ChC4YMPqxFWWBENx5s
         NkHqBJiWp7iHhO5qinZ44kwsYHZJXDaJ2OqnG08JjjLJlc1LFvaNlWwi6zkNg+ovNZsI
         B+QGuuwrjphPt5vgPx5bA3SKOq3H0n5MXLef5qStr4dpyG1/02E5pGib2y37ZkT5/kiq
         WPJw==
X-Gm-Message-State: AOAM533rlZ9293Unyg76BZzx5JyTCprzF8OMJMojr2e6kxE2n6IbXoqm
        pkAh9Xaqwms+Fyg75Y/1H6byZhknolTK/rueZZ4=
X-Google-Smtp-Source: ABdhPJyDogDvvEuSFADC7/IojIc5lte5ZO3L3J0y6xDyyS0JVRTlb6nbz9zL1m1/2+MkVpMuC32bZP5Ok3Dck8k5/gw=
X-Received: by 2002:a02:ccad:: with SMTP id t13mr11953123jap.29.1627214683538;
 Sun, 25 Jul 2021 05:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RR3nvtXotqhSO8xPCzGQpGUA8dnNgraAjREZ6uLf4n4w@mail.gmail.com>
 <87im0zs8wn.fsf@evledraar.gmail.com>
In-Reply-To: <87im0zs8wn.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 25 Jul 2021 20:05:12 +0800
Message-ID: <CAOLTT8Sbusr8=iJbG1qXcSerivZqP5xm-GS8R7TqDMh7QXSZaA@mail.gmail.com>
Subject: Re: [GSOC] How to improve the performance of git cat-file --batch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=885:23=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Sat, Jul 24 2021, ZheNing Hu wrote:
>
> > After reusing ref-filter logic for cat-file --batch, the function of
> > cat-file --batch has been enhanced,
> > but the performance of cat-file is severely degraded. So we need a
> > better solution to solve it.
> > its last version is here:
> > https://lore.kernel.org/git/pull.993.v2.git.1626363626.gitgitgadget@gma=
il.com/
> >
> > Use google doc to show some of my recent ideas:
> > https://docs.google.com/document/d/1hyM-ecMd8C_TJ3OsOn46nMr8ZxCUxeK7HKj=
-bRkq3sk/edit?usp=3Dsharing
> >
> > Anyone is welcome to comment and suggest better solutions!
>
> Having looked at that Google Doc it seems to just discuss "Plan A", or
> there some multi-doc magic and there's a "Plan B", or...? I'm not very
> familiar with Google Docs.
>

There may be several plan that have not been written to it for the time bei=
ng.

> Anyway, I'd encourage you to just send this as an E-Mail to the mailing
> list.
>

Ok, I can migrate them here.

> Having skimmed it I'm a bit confused about this in reference to
> performance generally. I haven't looked into the case you're discussing,
> but as I noted in
> https://lore.kernel.org/git/87im1p6x34.fsf@evledraar.gmail.com/ the
> profiling clearly shows that the main problem is that you've added
> object lookups we skipped before.
>

Yeah, you showed me last time that lookup_object() took up a lot of time.

> I think any plan to improve performance should start with a perf test,
> see which of your patches have performance regressions, if some don't
> and are otherwise OK perhaps those can go in earlier.
>

Makes sense. Last time the test performance of commits is here:
https://lore.kernel.org/git/CAOLTT8RR4+tUuT2yc2PDL9NwCburW8bM_Sht6nhKJ_fYV8=
fGsQ@mail.gmail.com/

The main commit with performance degradation is "[GSOC] cat-file:
reuse ref-filter logic",
we need to focus on it.

> Then we'll have the smallest possible set of changes that's correct, but
> introduces performance regressions, and can look at what those are doing
> to slow things down...

Ok.

Thanks.
--
ZheNing Hu
