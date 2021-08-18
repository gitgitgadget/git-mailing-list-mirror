Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD0C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 08:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0ED86024A
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 08:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhHRIyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhHRIyg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 04:54:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A5C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 01:54:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b10so3431133eju.9
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DBUyuQwrLDM+l75RwFUYVoQ94E8hHpv9kqQ20Fpx1/k=;
        b=Cqr9XQCALmWOyYT5U3ldZAKDkURdauki6w028iqFStgpyZHw52pByBjDkXQQ13WqLH
         uZwmU8oiTWKEdj4L73yuvVgoruQiRCEYV3EGX+jLYu9lUiYOeTvWrhH5pd3PaAXSN3sJ
         tuPj3oA34xLyb6QrXeU7+7EOR15rAvk2LoC7N6fSY0JZVqi79kKKnHSkh72vkQwlZyGp
         eO7GM0xSQ89z0ZHt63lfHbC3eVCsqSUlsN/gTUzQXrdrOakP52vSB0KkV8/9TemkGNSy
         UKP+wL8yy2rIdtCEBLhCW7pDPppOJJ3R9vIXVjmDF7mDvoUwxWwVy86CLVfcV2GJruCX
         tIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DBUyuQwrLDM+l75RwFUYVoQ94E8hHpv9kqQ20Fpx1/k=;
        b=ECAMEZTt4GwqDjqZN9dLcbA1svY5nDxP42WjdMOCVoEwdbmb5qyPFAzTxBWR07WPj2
         jNob3uR4Hhxnpaq+jO2CKmHK1/Zp9Kpno+SvxwU+fECMZIK282+Rv/VQQXaRi7ihoTeY
         gbM/a5Exti8mMgMCOw0p5PlsdnEk9m+HvAl4XXwKGqftsnPD4s+lwR0n6CAYsJuyn+kT
         dibE0nNSXJwfZmZOK1o3SfNBnxeZXTEjNEPoxjcqxeyWmGcHYjRW70JMvdUFXwHWrnqa
         4Ug5fzCCUDr3JZGFBtRGGsWu4AoMsuwrprbEzH4wQZMnb9qmSCGRsNRc59DX7ahn29Kz
         miGA==
X-Gm-Message-State: AOAM5330qqX8lFvFX3pjCjL9SDJQvCOAirGs9lip25OLGmB5YifP/KS4
        07zhmpwP4ZchB9Tr2GbpXmHqbtuv45Wf7H5uxOc=
X-Google-Smtp-Source: ABdhPJx31jm/OF4f0TWbInHMWYf+HTBqi/RoisZPdLomQZSlX6o+ODK6b9mE/P/PaNAsc3cdNsILXATdnJLnI/PUR9s=
X-Received: by 2002:a17:906:f8c7:: with SMTP id lh7mr4789393ejb.211.1629276840841;
 Wed, 18 Aug 2021 01:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com> <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
In-Reply-To: <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 18 Aug 2021 10:53:49 +0200
Message-ID: <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
Subject: Re: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 18, 2021 at 6:51 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=
=9C=8818=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:10=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > Hi,
> >
> > On Mon, Aug 16, 2021 at 4:00 PM ZheNing Hu <adlternative@gmail.com> wro=
te:
> > >
> > > Hi,
> > >
> > > In the implementation of %(raw) atom
> > > (bd0708c7 ref-filter: add %(raw) atom), we use xmemdupz()
> > > to copy the content of the object. But if we can reuse the content
> > > of the object?
> > >
> > > Since git cat-file --batch needs to use ref-filter
> > > as the backend, if the object buffer can be reused correctly here,
> > > we can save a lot of copies and improve its performance by about 6%.
> >
> > Yeah, that would be great.
> >
> > > Tracing back to the source, the object buffer is allocated from
> > > oid_object_info_extended(), but in parse_object_buffer() we may lose
> > > the ownership of the buffer (maybe the buffer is eaten), but I browse=
d the
> > > source code of for-each-ref.c or cat-file.c, and I don=E2=80=99t seem=
 to find that the
> > > buffers which have been eaten are released by the program.
> > >
> > > So can we reuse it?
> > >
> > > This is what I want to do:
> > >
> > > diff --git a/ref-filter.c b/ref-filter.c
> > > index 93ce2a6ef2..1f6c1daabd 100644
> > > --- a/ref-filter.c
> > > +++ b/ref-filter.c
> > > @@ -1443,7 +1443,7 @@ static void grab_sub_body_contents(struct
> > > atom_value *val, int deref, struct exp
> > >                         unsigned long buf_size =3D data->size;
> > >
> > >                         if (atom->u.raw_data.option =3D=3D RAW_BARE) =
{
> > > -                               v->s =3D xmemdupz(buf, buf_size);
> > > +                               v->s =3D buf;
> >
> > It seems to me that this could work only if 'buf' isn't freed. Have
> > you checked that? Did we leak 'buf' before this patch? Otherwise when
> > are we freeing it?
> >
> This is how I use gdb find out if this buffer have been freed:

I was asking about 'buf' before the patch.

Before the patch, we were doing:

v->s =3D xmemdupz(buf, buf_size);

which means that in v->s there is a copy of 'buf', not 'buf' itself.
So I was wondering if 'buf' was freed then, not the copy in in v->s.
