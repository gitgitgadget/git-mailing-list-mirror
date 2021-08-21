Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA77C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 02:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE526115A
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 02:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhHUCwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 22:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUCwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 22:52:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C6BC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 19:51:33 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n24so14670923ion.10
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 19:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zDh8kP6DPaY8zUEjfTUbuG/wx57SY2DmCmyy75uoa5I=;
        b=SDLWhhL+L5bw0ShD0lsYEd8VKKWJY8+IR1oEd//zwrkSLnExPa7X/gt8RvfVyFSTv2
         hfIB1wVXo1znb+Hxdza0N7Sl+YI0DPnkawVlIc1fOx4bgQWedUJyE3IKXEYx3zhXR7IX
         a2PV+oHmGjRF9h4qAXPmsbWkwmGkP3JhRgfulFQsudKedb0u4HDFEPlx4InXYy977vuY
         awzb5oNWALhjYx/Aevnxuu97z3UK6PgVea9OMsqVtFjXhnpxZt+nay+nefSy+iDQxe6+
         PtosjJRCI6tv+Fo4S+1OBNN+y5baw8+25/KpFrO2PChbIWEyHJIvD3GN7my5Vi46uJTh
         DUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zDh8kP6DPaY8zUEjfTUbuG/wx57SY2DmCmyy75uoa5I=;
        b=g3eg8n/UU/5dP6EJ56MN7o3P8QbKv4kJR8U2PWNZZpNChvLg7suyP9GfCEvOghJdFZ
         IVyQB/dRYBtmP3yEShn763UtKuEIGVSi/5YfQMy5l/auQWnUOnFvCpZ0/bsGBDWbfmt8
         1mhrQOT6EXVcrS5ywTNs79HCsSgKwqGOlW76CIAXDP4Xfv3Fxp3zvGgQfMDUZTHRjTul
         wDqr6mQJuAPqyXKLkfWWViJj2DCVc5RuYf260vKMKeScojh89lorF3h9d1v7jZxVwXob
         oWopZEvBz1cMTeLCLaMN8HLunVuz6Hres4iUogMq8kXDGJF3ty9JbsXUFThZyPFVhx2h
         hczA==
X-Gm-Message-State: AOAM530ikkrL+grQTG+AcZPzH8/42MOW6LAG/UC7WdMPp+m7ajV3Nbs9
        OhYlX1X64U2A2EhaU9TOhLB0upl6rqjMvzWMMJg=
X-Google-Smtp-Source: ABdhPJzat20JdLgB4j24/IFF4GNYieCe56mrZrSfnB4/XJVd8+2Ec6wAvkBuwtCb+1OKsIHmgvqR6CyAsNXWhu2BYqo=
X-Received: by 2002:a6b:6603:: with SMTP id a3mr19059799ioc.68.1629514292590;
 Fri, 20 Aug 2021 19:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <m2lf4wys5o.fsf@gmail.com>
In-Reply-To: <m2lf4wys5o.fsf@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 21 Aug 2021 10:51:21 +0800
Message-ID: <CAOLTT8Rt1=DBrFukEU3_FCKT39jydUMzrG1UJLmHOdrOJbqNQQ@mail.gmail.com>
Subject: Re: [GSoC] The Final Git Dev Blog(s)
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Atharva Raykar.

Atharva Raykar <raykar.ath@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8821=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Git Developers,
>
> This is my last week with Git under the Google Summer of Code banner.
> This week's update will be different from usual, as I have split it into
> two separate posts.
>
> These are:
>
> 1. The Technical Report: https://atharvaraykar.me/gitnotes/final-report
>
>    This is a largely impersonal report that describes the current status
>    of my work.
>    Mentors: this is what I will be submitting to Google as my final work
>    product. Do let me know if it is missing anything.
>

I may not know the technical details of git submodules very well,
but, when I look through your blog occasionally, I know that you work very =
hard.

>
> 2. Reflections on Working With the Git Community:
>    https://atharvaraykar.me/gitnotes/final-reflection
>
>    This is a blog post that I wrote mostly for myself, and other people
>    interested in contributing to Git. It covers my personal experience
>    with my time here with the many ups and downs. I also wanted to thank
>    all the people who helped and collaborated with me in these 14 weeks.
>

Your articles are always more interesting than mine :-)

The COVID-19 affects each of us, and I hope we can get through it smoothly.

> This won't be the last time you will see me on the list, of course. I
> still have patches waiting to make it to the list, and other work
> undergoing review=E2=80=94the only difference now is that it won't be und=
er the
> GSoC banner anymore.
>
> Have a great weekend!
>
> ---
> Atharva Raykar
> =E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
> =E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0

Good luck!
--
ZheNing Hu
