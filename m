Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0FFC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 13:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B7860240
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 13:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUNUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 09:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhFUNUR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 09:20:17 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22935C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 06:18:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k16so15683852ios.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=epntItPRI1i8CT3GEEr8+65vs/C/3X1X10rUKu5w6wE=;
        b=DcIt761A2E8f+oy4eMWydGGSXpkSd0vNGCU7mvc09XLx1ImldFyfBCCE6szy/FIr6t
         3zfaIiQORbJLwORqSv7D86FpS0EG5N9FkzWctUMpDSVa9ZA4W3/geEEfcn79v4kfhZCQ
         72S1beWHwDKqBtfyyOSRLHKzyubDtJU9NcC8GNSTWuAMa4IYgQS8puIHu4Yxq/Xo0Wap
         n57LYPsWRygQO7cUzylHkA96tn+swuGWjT7XUR776axW3A3r1SEggLZGjOY5Kl30+cQQ
         HTy2YgMdPk7wmceGDOvoqd2Q/beXPD7krNtt4DPFPhLz88+JSN3GG8DtwTIGEqu39DH1
         oG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=epntItPRI1i8CT3GEEr8+65vs/C/3X1X10rUKu5w6wE=;
        b=bDdGv1k2x8CdxbH8En5M/hpIiRO2F/ReJBioT4zob6u2z7oy4WbCNectjHHJ7xQq5i
         otN1+0VoJFSdAk/Rdy7wTYWHjeC+qHzD7iMC6a0mlgAVJRmdNvCMBbRgrb0kazNMTPAy
         wvb0BkwcsQcayyCtApt5tj0rAqWqp3wsYjsneQykvDY0u9FxjmTd6TqxIm1JGeMxssTo
         C+xsmpjUMh0itHHVCBvXRPSHvRNWliJdUIcnPoMlD5KNR09M7Hk+itK+k4xPbsffsHPE
         dg208CzqDfGNz4gRPQ9hGmhoulkIa7S0f3tCFTmNMDuubH/gq7VQEXgtIERQncBquMKt
         sTGg==
X-Gm-Message-State: AOAM531chLWvAaCnOxbT7fbjlE0IIbvyPg5Pa5I2rdn5EzOpDMBBIppP
        /Yk5E8dw9o+IxK0X+XwceBd5UTrNU7Wjhkt6ivk=
X-Google-Smtp-Source: ABdhPJxO0muJdXsRqziQjAo0OzEgmnEwWyWm9yOJTZxGUlZoVyKd1rcD+T9+Ckxg8gDtYtbWseJktN6gNiM735l6O98=
X-Received: by 2002:a05:6602:581:: with SMTP id v1mr20365394iox.192.1624281482640;
 Mon, 21 Jun 2021 06:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TZqKQ1vkRX7apvzAJ04Cv9aHJ9kF1+wJcEvyi-pibOOw@mail.gmail.com>
 <CAP8UFD0sHevUHB-ryUZm9Sxm=daKMwbqe6_Q7kc-pZAZN-eHWA@mail.gmail.com>
In-Reply-To: <CAP8UFD0sHevUHB-ryUZm9Sxm=daKMwbqe6_Q7kc-pZAZN-eHWA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 21 Jun 2021 21:17:51 +0800
Message-ID: <CAOLTT8TYn0x_wuDz7Nn1sKn0VKMyF320p1urxG1KHc+se4aiNA@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 5
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:07=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Sun, Jun 20, 2021 at 6:53 PM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > My fifth week blog finished:
> > The web version is here:
> > https://adlternative.github.io/GSOC-Git-Blog-5/
>
> Great, thanks!
>
> > ## Week5: Tempting apple
> >
> > This week, I spent a lot of time working on the digital circuit
> > course design of the school. So this week's patches for git
> > was completed in a hurry. This week `=C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason`
>
> s/was/were/
>
> > gave a lot of useful suggestions for the patch I wrote earlier.
>
> Maybe a link could help.
>
> > Some are related to code style improvements, and some are
> > better design ideas.
>
> [...]
>
> > But something like `fill_remote_ref_details()`, things gradually
> > become complicated and difficult. `fill_remote_ref_details()`.
>
> I think you can remove the above `fill_remote_ref_details()` as you
> are talking about it later.
>

OK.

> > * FootNote:
> > 1. Why is there no `strbuf_empty()` in `strbuf` API? I think this may b=
e
> > a very important thing.
>
> There is a 'size_t len' field in 'struct strbuf', so doing `buf->len
> =3D=3D 0` works.
>

Really? So I think for reader who is learning strbuf api for the first time=
,
the characteristics of empty strbuf are not so obvious. For example,
`strbuf_slopbuf` may mean "empty". In any case, adding a macro
is absolutely reasonable and will not affect performance.

#define strbuf_empty(sb) (sb->len =3D=3D 0)

> > 2. Another thing worth mentioning is: I will have the school final exam
> > between July 7th and July 14th, I may be busy during this period.
>
> Ok, thanks for telling us in advance.

Correct the time deviation, the examination time is from July 1st to July 1=
2th.

--
ZheNing Hu
