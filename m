Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCD8C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 03:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9B961183
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 03:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhHUDTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 23:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhHUDTK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 23:19:10 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63BC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 20:18:31 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j15so11457917ila.1
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 20:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dje7xRx5gTQfN/96ivCOShpledP4hqg/WExbv1dq8oQ=;
        b=HI8PdAEdZ16ZeLK/At/4TYvXioo3Bg34n8iPv0ml3tThCKWdxsKjJ8CY1D25bj7m9C
         TB+8utEYjXzcd+JgdiffDSxPmkyec+xlr2A/g/jLlcWWSmLCcUFVYE8g+VlfIApd97uP
         wk4dwhzp/SbVVTa/JlZtcc6MhA3R76fBeBjY9IhhhbYnMEXqnNKE86OSGjJPJD3ua5kQ
         rluTvzGjZG/1GzHwFwXUaM/HF6J8W6c7K7XDH4A5AKWe/WrTVSQA5xBfndxRWF+tbaUr
         EhUByhIC7iYzQOALhN84KxS5fld5wGVUtc86IwhrKDALHz+yjmAxIbt0cA2uZbo3nxpd
         U3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dje7xRx5gTQfN/96ivCOShpledP4hqg/WExbv1dq8oQ=;
        b=YnYzZMl7PS51Dm1xwJPVbhYmG3ri3d2DIZrWgOsVoGo/SqPnOibxYMuLuB4uAGK6ep
         k+XOhftAL3nDhtQRdN3FNOs69pKi9t7b7yW5lRH4Xmj8WdOkYu4+tYc2BqXZI57RsHhl
         hdwQdQr8lT9PAmvZie+q0tjjT6S1zlEyX8hEGXq80pYlOglS9BJ9V5+mZyy5NYHqLyBN
         4H6W+hB2OxTWw+Et9+Wc5QJ5+QSQpdDWGBRZIHOVZGSEsFvYN8peVQILLYnE9KXoVMNP
         VXhZ7TMlqmeKMnMnY+vyVOr4JuRnnpCdiyZY6gxPeJcNGW4HwCWEJlejP1s5KGFN0r7w
         Niog==
X-Gm-Message-State: AOAM532A7PdKxFmcQ69MYoq87nvlcJ0xn7cvi5DFWtk30sDBkNtSD29p
        YySNDdEocace5itC8rmDmGNF+X/shLRY/yuGD5M=
X-Google-Smtp-Source: ABdhPJy72xmxmY50T0brfD7orPLZDX3q5xbrk+kfXjvbR+Pm+Z4KJycco7r/4JVdbbA+8qDyea6EvUtZPS4z40pbFe4=
X-Received: by 2002:a05:6e02:5aa:: with SMTP id k10mr15940378ils.301.1629515911318;
 Fri, 20 Aug 2021 20:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SxHuH2EbiSwQX6pyJJs5KyVuKx6ZOPxpzWLH+Tbz5F+A@mail.gmail.com>
 <CAP8UFD0sbcJdrXYnumjHwzth150oEvW_uP9jgiR0NM0tn4Eu4A@mail.gmail.com> <xmqqbl5suhj6.fsf@gitster.g>
In-Reply-To: <xmqqbl5suhj6.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 21 Aug 2021 11:18:20 +0800
Message-ID: <CAOLTT8QgsWMCD0qi=Sasc=cF0JyR6eQKdAeQAWC+jdDeGYPCjg@mail.gmail.com>
Subject: Re: [GSoC] Git Final Blog
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Hariom verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Thu, Aug 19, 2021 at 7:39 AM ZheNing Hu <adlternative@gmail.com> wro=
te:
> >>
> >> My final week blog finished:
> >> The web version is here:
> >> https://adlternative.github.io/GSOC-Git-Final-Blog/
> >
> > Great, thanks!
> >
> >> ## Git Final Blog
> >
> > [...]
> >
> >> ### Concluding remarks
> >>
> >> This summer vacation, I have gained a lot, also made a lot of friends.
> >>
> >> Thanks to Google and Git.
> >>
> >> Thanks to those people who have helped me!
> >>
> >> Thanks to my two mentors Christian and Hariom.
> >
> > Thanks for all the work you did, and for your enthusiasm, dedication
> > and involvement with the mailing list!
> >
> >> Three months ago, at the beginning of GSoC, I cited the example
> >> of Junio's interview:
> >> [[GSoC] Hello Git](https://lore.kernel.org/git/CAOLTT8SHE-ok3D+oLNSWFi=
7KPU=3D=3DVQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com/).
> >> As an echo, I will maintain a passion for open source and technology,
> >> and continue to participate in the development and maintenance of the
> >> Git community.
> >
> > Great! We are looking forward to continuing to work with you!
>
> Surely.
>
> We hope each participant had developed useful skills, found that
> contributing to an open source project is fun, and most importantly,
> had a great fun.
>

Since Linus created Git in 2005, Git has been constantly changing and
improving. Even a small `git add`, it has a lot of content worth learning.

I think the greatest joy for me is my own feature can be used by people
all over the world :)

> I hate to see the "Final" label on these messages.  Even thoguh this
> round of GSoC may be coming to an end, don't become a stranger ;-)
>

"GSoC" Final, "Git Play" Begin.

> Thanks.
>

Thanks.
--
ZheNing Hu
