Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AAAC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7F061429
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhGCF63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 01:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhGCF62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 01:58:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104BC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 22:55:54 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id g3so11815145ilj.7
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 22:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aa40cUOpCpf9oezM5pG9GY6vgQuntWNide0Wc4D7tdI=;
        b=VF082oFSM2G9kcx9JciF9iIn9XM8NKw4LOiiMHYZ1+8ud1gI3gt3CWEoMk7eKMnkBy
         Aj5eYKSvY7FA+FJk0vMwtG8SlaTpy1zVVvt4zRgthUcu168xv3uPEEWeyWa+Z9MhZekh
         BnnY8JIvf1KGtR4ziMjXUpdqK5Mf+VSBP9ul9ax2h/UJhEPDNdJkG4DoNWvaV0QoSnxl
         xOXM4enpRuxX4bOF35hOPXS8V6Cn37aBWRxjevgEodF/dbQqbTHN1PaWn26GmUIxc8d3
         2pW9A5ZMQin++HNsNzMok2oO1EVW48/EyzmDA7cZEtWwmWP/3EjyQCxq6A5zpLvah+4b
         TP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aa40cUOpCpf9oezM5pG9GY6vgQuntWNide0Wc4D7tdI=;
        b=othj32Xux1WG+Qsh8tqXWrllFQrz8zO1DycMDNqu0uKUkMSF0BaOMssn4Bi09dRkfj
         TGtloA64D79uqUoq5HPyGeo7m/W5AVNKu4xD6XyOw3ovpWdyj8lQRfdYHYTkDdl2yvBG
         JsxL1Us64i5kYTrWaFooFnHEOuccTTUA0/WabfH+zPwsuX1+ELsNmABBKcSG43KpPWFB
         BlwTslNxVWyo0H1AEv+ofWTrfndXrJcaBwM2YuCTxZneV8PGuG0MUpK6Gc6wQ9SJ6aTl
         zvYfH4nZRtH3XKxMEFkyrc9dlEjSBxCM5szU/7pVyM+IwrxluFOrw57vRZQ11ylpsPE2
         PHew==
X-Gm-Message-State: AOAM5312ywl/pZahv5lnSLiRJJeobvcunaa+2+xBPzT5oOU9wQD+k6/k
        8FvIOiQQcNGtBdYqqxZ9hHwZM9pvc+VsIqMBrgw=
X-Google-Smtp-Source: ABdhPJxO4Do5bej6Z0eeY8sCj2bYVa+WS7L2WWTO46oD2+KsJ4Yoj6v+vnMpT93aXt4L6v8wyg5oa9z98JZgKtqN5aY=
X-Received: by 2002:a92:d2c5:: with SMTP id w5mr2438229ilg.174.1625291754430;
 Fri, 02 Jul 2021 22:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <9568baf5dddcc0637c15f698aea24d230c4d01b2.1625155693.git.gitgitgadget@gmail.com>
 <87czs0alhg.fsf@evledraar.gmail.com> <CAPig+cQinUsEZqEDb2_zhi37SdYuBCVEznmFbXPJuFB5cFznKg@mail.gmail.com>
 <CAP8UFD2FjY1mY=GS4ZZHiAxTpsqq7+1ywHfCvdRvJrr8Oo9-qg@mail.gmail.com>
In-Reply-To: <CAP8UFD2FjY1mY=GS4ZZHiAxTpsqq7+1ywHfCvdRvJrr8Oo9-qg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Jul 2021 13:55:48 +0800
Message-ID: <CAOLTT8SHAxtQFNYAhJcfpbv8P7k5xq2id8Bvwp8vwnLYm+2beg@mail.gmail.com>
Subject: Re: [PATCH 08/15] [GSOC] ref-filter: add cat_file_mode in struct ref_format
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=883=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=886:11=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Fri, Jul 2, 2021 at 9:28 PM Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> >
> > Aside from the potential maintenance burden of the `atom_type >=3D ...
> > && atom_type <=3D ...` approach, another problem is that it increases
> > cognitive load. The reader has to go reference the enum to fully
> > understand the cases to which this code applies. On the other hand,
> > the way the patch mentions the enumeration items explicitly, it is
> > obvious at-a-glance to which cases the code applies. An additional
> > downside of the suggestion is that the range specified by `>=3D` and
> > `<=3D` may cause some readers to think that there is some sort of
> > implicit relationship between the items in the range, which doesn't
> > seem to be the case. So, I find the way it's done in the patch
> > presently easier to comprehend.
>
> I agree that it's less cognitive load, but maybe it could be improved
> using a separate function like:
>
> static int reject_atom(int cat_file_mode, enum atom_type atom_type)
> {
>     if (!cat_file_mode)
>         return atom_type =3D=3D ATOM_REST;
>
>     /* cat_file_mode */
>     switch (atom_type) {
>     case ATOM_FLAG:
>     case ATOM_HEAD:
>     case ATOM_PUSH:
>     case ATOM_REFNAME:
>     case ATOM_SYMREF:
>     case ATOM_UPSTREAM:
>     case ATOM_WORKTREEPATH:
>         return 1;
>     default:
>         return 0;
>     }
> }

I agree. It is clearer to use a function to wrap origin reject atoms step.

Thanks.
--
ZheNIng Hu
