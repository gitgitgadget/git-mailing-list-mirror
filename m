Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C10C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 08:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412D460EE9
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 08:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhHDI5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 04:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhHDI5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 04:57:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4FFC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 01:57:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id go31so2653499ejc.6
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YkU49Pk0lriZtYOTyT4y/fHWR1FVxPW3bgVR3UCjD7s=;
        b=WwkbZaRg4GhT5i1dFJeEdpRK4hEMse1vundED+OElbSKvet7JORSs6wBPmCe8ww2Bp
         HMSD+XG5pRsgbSeq4hQXezfoU9ZWYD+bHqlIeHe94hRkfP8tIimIZ2HkI7nENkqKaTjG
         LR2lJGaLygOK7M6Mr7U8XGAizYiEKyF4n+wgBp7BfrPtTmNB7qBiknzVqtxU8J/AOJeZ
         2NTUsZcPQ0wJD6LnsirCPZKavzFXPUm2UwQoIMFUSyEJeiNNdO1oYttZ/9NwmhsS/pw2
         1MP9L/bIxAcyEppxlKX0UgepBpgw+V/B0I0Jl2k+0Lka3CF7Jji3v0ad4BPx9R/QvxN9
         ynsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YkU49Pk0lriZtYOTyT4y/fHWR1FVxPW3bgVR3UCjD7s=;
        b=o0+gWzaa1Fyzice41OOpQ9USKJBNcWcymSaAZ/8iNLR9NZ54ZZeGWazdER0fk5wPMO
         7xUuceBJJnP0874uhAnypIjTPMcn5cLJiZyekMzM8AyNGZ9SEgRFKdCf8ldE5ut/Lx4/
         ZUUYiM/qjErJkCuvqdVVprdOegQK+qDil25yor+NuJUDftWqRFoBG7WUkgJ55VpH5XsC
         5ggLkt1MIwzW39LwQHUlEgK6x4gwGFc15fvmozqyK7Q9lYou1HSARSIo+qI4qQigP8BV
         WV73rYKgGfil3/ojOhuHFfu66Y3y7XP0CUYVNU0uiPX938FJ4MkAL0/cnLrELbtLn9bO
         PaRg==
X-Gm-Message-State: AOAM531KbRzq90Pa4zqEIPYnNIx88Q4u387pKSV7fX55UQ5/SX4pFks7
        9GFLbXHO0VeZF9IulPwnuhLy9QIVa8iaiAa+6do=
X-Google-Smtp-Source: ABdhPJzCallyGUt2/o4Qkqr8zhNn/mDhzJ+iTODS3Ud6j+S8GrTsVI5UuUyX58cyFddr8mJxz7QjoulsjS7ydMbZHQQ=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr15893428eje.341.1628067422424;
 Wed, 04 Aug 2021 01:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RwwMF07f=XxWN=zGsPU0VQ8FqPVdyepQp78Ei8WZpSrw@mail.gmail.com>
 <CAP8UFD16pqERdF4Mdq=_ktvFB1rcXwB9PRy8TjNq=ThH5HbeqA@mail.gmail.com>
 <CAOLTT8SaXqWF3AJssqudrDK-KZN3oESO7Xh0JTYB_=HR9L9sHg@mail.gmail.com> <CAOLTT8QDo1A4tRqU0w-yas8OxrHB6uQ_PECswUQtQ7yY2-iWgw@mail.gmail.com>
In-Reply-To: <CAOLTT8QDo1A4tRqU0w-yas8OxrHB6uQ_PECswUQtQ7yY2-iWgw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 4 Aug 2021 10:56:51 +0200
Message-ID: <CAP8UFD3E9oR9E4S=f8iReKOnvVO_WrXVziyztHZJCiScUAxDRg@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 11
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 4:48 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:37=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=
=E6=9C=882=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:25=E5=86=99=E9=81=
=93=EF=BC=9A
> > >
> > > On Sun, Aug 1, 2021 at 8:45 AM ZheNing Hu <adlternative@gmail.com> wr=
ote:
> > >
> > > > in some cases, this is the result of the performance test of
> > > > `t/perf/p1006-cat-file.sh`:
> > > >
> > > > ```
> > > > Test                                        HEAD~             HEAD
> > > > -------------------------------------------------------------------=
-----------------
> > > > 1006.2: cat-file --batch-check              0.10(0.09+0.00)
> > > > 0.11(0.10+0.00) +10.0%
> > > > 1006.3: cat-file --batch-check with atoms   0.09(0.08+0.01)
> > > > 0.09(0.06+0.03) +0.0%
> > > > 1006.4: cat-file --batch                    0.62(0.58+0.04)
> > > > 0.57(0.54+0.03) -8.1%
> > > > 1006.5: cat-file --batch with atoms         0.63(0.60+0.02)
> > > > 0.52(0.49+0.02) -17.5%
> > > > ```
> > > >
> > > > We can see that the performance of `git cat-file --batch` has been =
a
> > > > certain improvement!
> > >
> > > Yeah, sure -8.1% or -17.5% is really nice! But why +10.0% for
> > > `cat-file --batch-check`?
> >
> > I think it's not very important. Because our optimization is skipping
> > parse_object_buffer(), git cat-file --batch-check will not set oi->cont=
entp
> > by default, parse_object_buffer() will not be executed.

Do you think that if git cat-file --batch-check would set
oi->contentp, there would be no performance regression for `cat-file
--batch-check`?
Could you test that?

> > Therefore, we did
> > not optimize `git cat-file --batch-check` at all. 10% may be small enou=
gh
> > for git cat-file --batch-check. The noise of environment even will cove=
r it...
>
> By the way, its performance may still be worse than "upstream/master", bu=
t it
> will be better than before optimization.

Nice that there is some improvement, but it would be better if it was
similar to "upstream/master".

> Test                                        HEAD~             this tree
> -------------------------------------------------------------------------=
-----------
> 1006.2: cat-file --batch-check              0.10(0.09+0.01)
> 0.09(0.08+0.01) -10.0%
> 1006.3: cat-file --batch-check with atoms   0.09(0.07+0.02)
> 0.08(0.05+0.03) -11.1%
> 1006.4: cat-file --batch                    0.61(0.59+0.02)
> 0.53(0.51+0.02) -13.1%
> 1006.5: cat-file --batch with atoms         0.60(0.57+0.02)
> 0.52(0.49+0.03) -13.3%

Yeah, your patch seems to be an overall improvement when the
ref-filter code is used.

> Test                                        upstream/master   this
> tree
> -------------------------------------------------------------------------=
-----------
> 1006.2: cat-file --batch-check              0.08(0.07+0.01)
> 0.10(0.07+0.02) +25.0%
> 1006.3: cat-file --batch-check with atoms   0.06(0.05+0.01)
> 0.08(0.08+0.00) +33.3%
> 1006.4: cat-file --batch                    0.49(0.46+0.03)
> 0.53(0.50+0.03) +8.2%
> 1006.5: cat-file --batch with atoms         0.48(0.45+0.03)
> 0.51(0.48+0.02) +6.3%

This means that some further performance improvements are still needed
both for --batch and --batch-check though.

Have you tried to see, using gprof or something else, what is still
degrading the performance compared to when the ref-filter code isn't
used?
