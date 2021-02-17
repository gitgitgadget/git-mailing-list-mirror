Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051BDC4332E
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA41164E24
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 11:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhBQLno (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 06:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhBQLnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 06:43:32 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A260BC061797
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 03:40:35 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id b16so9322021otq.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 03:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tVwycDs9y/7n6O0wljLgljfRDBxmNDiwJCMUgO+XVd0=;
        b=KGUp0czGWnx9H/HhZYee3SbL5A/GSvend5PiElU0JQUmIQQrNETz5Bwu8qIdhE4aDY
         tXOr/gyiJ8t0vMNT12+z2T4fQ9h7T63niONG384EAc5DrLWvDrmWWGRSz59J/9zCbo68
         i0ThZUQh/AjM3S10zzNcl1M4ayqm0InTbT3wvE2peK2zFBdhRtbL0auorOaADWiuzznI
         qRGVmuvIFmnv6OcE+pvzhOjGRcfVuZQ512YorvNz7H5PXbDtnmbZ4ZqQSXty0S0SyB/t
         fgXbcyS2HHJDXCgN3tK0pFWIWtwtBoyqMH2C1iofsyjPEf6mY8YTTG3fo8Sn+MxKjlUF
         SAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tVwycDs9y/7n6O0wljLgljfRDBxmNDiwJCMUgO+XVd0=;
        b=mmC9rsrlkzkJEAYy+uF4iTZ862wRKAkp5k51GkfJYMQb2Tym37G9z5zBYMhFW9AIdU
         LzR5hNysrjKErAcCddQ01mX0fQEnC2sRBha04leIUAiANgGIPbMR8dp+zkgFhokq6nex
         0un75LI9AWZtF5LwsHEZiatPdZWvLL9mtMDq1oww6oHeE/nOQUQPLNK/k+OJvckdgSYh
         DXTCF042iqBGVWUEKAm3/edzdhu1803jEAPBzWQOfD9hVsa8EB8o2MCCOcYZPpqOXIj6
         GvJfAyK21C4s4/IPLZDBg3uljMG37wgM3iLLB+vevgNs3sV5Htr3EePjsV2gLY0Y5/+j
         4faw==
X-Gm-Message-State: AOAM5320HmRdtv2S/Co57DjIQkLVTlC05ZaKMdJQWICprCcG7Mb7sdGO
        zjzhZ52rDRWaZuqrqyGPAqArAfsc1CM8pHNhrDI=
X-Google-Smtp-Source: ABdhPJxPJ0LyXjPOxXbx3nUv0CgzQowqFCSHBo3UTCrFNI666Xxnrd7aYZ5HT1L4l1UHu1pItG/poTDtDvR3y0o6jjE=
X-Received: by 2002:a9d:6308:: with SMTP id q8mr16711074otk.160.1613562035111;
 Wed, 17 Feb 2021 03:40:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
 <pull.870.v5.git.1613480198.gitgitgadget@gmail.com> <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
 <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com> <YCz6oDZCAODPS8sY@generichostname>
In-Reply-To: <YCz6oDZCAODPS8sY@generichostname>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 17 Feb 2021 19:40:23 +0800
Message-ID: <CAOLTT8Ri+XbSg_=KaLOCmNX4Nrii1ssN9_FFbnmm7ew4vYN5nA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton Liu,
You mean I should cherry-pick Junio's patch to my topic branch, right?

Denton Liu <liu.denton@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:14=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing,
>
> On Wed, Feb 17, 2021 at 12:12:10PM +0800, ZheNing Hu wrote:
> > Oh, I am sorry.
> > Then I only need to squash the two commit, right?
>
> I've never used GGG before but I suspect that in your GitHub PR, you
> need to set the PR base to 'master' instead of 'jc/diffcore-rotate'.
>
> CCing the creator of GGG, please correct me if I'm wrong.
>
> -Denton
>
> > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:45=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > >
> > > > Junio C Hamano (1):
> > > >   diff: --{rotate,skip}-to=3D<path>
> > >
> > > That's not part of your series (didn't I ask you not to include it)?
> > >
> > > > ZheNing Hu (1):
> > > >   difftool.c: learn a new way start at specified file
> > >
> > > Will see what I find, but I may not be able to get to it today.
> > >
> > > Thanks.
