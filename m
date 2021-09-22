Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B1C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 14:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A3761107
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 14:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhIVPAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbhIVPAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 11:00:35 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE1C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 07:59:05 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id f24so2016170uav.8
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vKS63TahwIcr/3Cr/vbZY3vv0jrByAfeV0nPA15Nhaw=;
        b=DE0tjQPURfd4KSaf6DsWV8OQz6r4ZESqEZ0u91ivNd6n9GyqZ6LUIDDYsB9PANNZI1
         4D8x1b6ZkCUfVv7XdlvfMUdLVvjKlTodWI81fYpFh3NhY4D+MDGlRI3+AnnXq6zEpl92
         yrBJrLAgS3k2tH+2K0xNoicuzq7QcshNiOEK1Zp27n0/LB/3S3HPYVwqIF7nSTD/UBmJ
         JppgJ7ZNBIHsGdKdsRWUkwXdGtS1FMZE++p95zXZ46Pgy1QHXABapUu+JhmINme/w+wg
         6ESgjzCm4kezEiVYeujslvVJY79wWUkVMQFupYS+Hs4Y9DS8MwNvV0ydApPzgOOyvOuX
         PsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vKS63TahwIcr/3Cr/vbZY3vv0jrByAfeV0nPA15Nhaw=;
        b=XHThYPFvlFiZ3qvnHwNT0NuIAkvRPxyyXQ/MdWi7mkKuifuhYP/GsVwjnEGorzTQct
         EflpZJTG7EPs4imJahKMqutWabU1cVlSgc0z8u+OR76vdO2MRLCIdIGYCB4oDXLeV2uc
         bx1eC9C2WEZkpETrI45q5px0N7hN7gu9aEJTiBMtjZD1XDfg9/rRH/WZ3ZrH7Rv2SOHw
         Dq9W3EXZ+HvRCWnQhm9BPE0vUN5nASV24K/GZsEqt1Zqb6hP9Xdrbsnc2PL7Uiiam2Zg
         wCOHmfV+45i3D2IsNWOIKtkuetwAK3/Nk6OFjgMGRRZehHxh3srqBHVETXnJ5PES3l8I
         REmw==
X-Gm-Message-State: AOAM532tKBJEcY7tyVVZ1+eYOtase+4+BpG7qtwgB9y1AmPwgvAvJLmu
        Llr2PtQ8+aAnQAdkDpE8nEKBe0uorJQotDluWSM=
X-Google-Smtp-Source: ABdhPJxW/Sg4AEws0zlvHnXNGfTsJipCfuL2RxxasiRgNcMtyenRBe+lAMe/ZmFI5IcTRkNBuykSZVYDggFkcRZ/RwY=
X-Received: by 2002:ab0:477:: with SMTP id 110mr146730uav.68.1632322744269;
 Wed, 22 Sep 2021 07:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local>
 <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com>
 <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com>
 <CAOLTT8S8TxuTmddGp2WGoPtTc3gwGXzizBfVzKd87otRw7Dpiw@mail.gmail.com> <CAP8UFD0xjUWK7B82xEerX4e_pkZ-BATKwjNcEjg4AxB4mipL1g@mail.gmail.com>
In-Reply-To: <CAP8UFD0xjUWK7B82xEerX4e_pkZ-BATKwjNcEjg4AxB4mipL1g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 22 Sep 2021 22:58:53 +0800
Message-ID: <CAOLTT8TQj==048r3poLcWHpy=duma26odK=ZxZdtWSOVfdZ5+w@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <ttaylorr@github.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Hariom verma <hariom18599@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:35=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Tue, Sep 21, 2021 at 7:39 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B49=
=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:52=E5=86=99=E9=
=81=93=EF=BC=9A
> > >
> > > On Mon, Sep 20, 2021 at 9:45 AM ZheNing Hu <adlternative@gmail.com> w=
rote:
>
> > > > I haven't thought of any good projects for the time being,
> > > > Christian, any ideas?
> > >
> > > I already suggested the following project upthread:
> > >
> > > > > About project ideas, maybe continuing Hariom Verma's GSoC 2020 "U=
nify
> > > > > ref-filter formats with other \-\-pretty formats" project could b=
e and
> > > > > idea, though maybe it could interact too much with ZheNing Hu
> > > > > continuing his GSoC 2021 "Use ref-filter formats in `git cat-file=
`"
> > > > > project.
> > >
> > > and you replied:
> > >
> > > > If the project idea is related to Hariom or my GSoC project, I thin=
k I can
> > > > provide a lot of help. :)  I can help them as a mentor.
> > >
> > > so I am ok to co-mentor this project with you.
> > >
> > > If you are still ok, I will submit it.
> >
> > Yeah, I am ok. grateful.
>
> I submitted it. You should see it and be able to register as a co-mentor =
there:
>
> https://www.outreachy.org/communities/cfp/git/
>

Yes, I saw it. Thanks!

> > I am still looking at the code in ref-filter.c these two days, I deeply
> > doubt whether we can add a --no-sort option to git for-each-ref,
> >
> > Inspired by Peff's experimental patches [1], I think the --no-sort opti=
on
> > may improve the performance of ref-filter by avoiding the execution
> > of ref_array_sort().
> >
> > I don't know if this can be regarded as a micro-project.
>
> If you think that such a patch is likely to be accepted and that would
> take you less than a few hours to prepare and submit, then it can
> probably be regarded as a micro-project, and you are welcome to send a
> pull request to add it to the micro-project page.
>

Eh, It may not be simple, I can try to solve it by myself first, but I
think it is
appropriate for novices to complete this mini-project to understand the
technical details of ref-filter.

> > This may require the help of this patch of mine: [2]
> > which use list api for ref_sorting. This may can help eliminate unneces=
sary
> > sorting.
> >
> > [1] https://lore.kernel.org/git/YTTC2IUO1ZmTOEoR@coredump.intra.peff.ne=
t/
> > [2] https://lore.kernel.org/git/pull.1025.git.1629882532.gitgitgadget@g=
mail.com/
>
> Then please add this information to the description of the micro-project.
>

ok!

> Thanks!

Thanks.
--
ZheNing Hu
