Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE83C432BE
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854C261053
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhHRJIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhHRJIM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 05:08:12 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D03C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:07:37 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z2so1536238iln.0
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Cet/rmyPdrPeDJttaImEI0DXgMtX/0UOjjfqEvoG1E=;
        b=u2OOD+l2eO/XUOwndy+WTtlXU6RUzE3rXCEmFSVfcguXGmYYFhqJ4RkItNslhWc6fc
         FxXLuQsABouqENXIsov8Lpf7FOXMTM5Eo616FKL0Vyo93Jdm2uaFNO+LPA2tXfp5cevy
         GcT7sqjM/T843k9caFmrROhMBlccvJu6MG4JXPOm7bM8ty9Jxi/AY6mlw7lgWDGpnqsk
         UI6PxMLFp2C8ZojGE9azYj+WKVIW8uolKb7WpOV7LeEvUjt5nRNcMPBVsIb+UExMQjZK
         TxVe44taud2htDyrFikX7TCgt9IroGP+73l8qq/uaCDZqc9nDFVwCX22Or7Wp3Nd9zHM
         GGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Cet/rmyPdrPeDJttaImEI0DXgMtX/0UOjjfqEvoG1E=;
        b=WvY86sUZSZQsOev8eBS/wXEYqIVfLqs29Jl1fqpXh4ZtVr7iHJ5/AM9gm3GNvxMC9D
         71GaXwU2LIt5PTzxt3+ysIB1+V5Nh3mrzefxZS8BjrW1Vkyvg1s5jU7z+15FRifd1lPo
         wK9nLFKjQcVeMGxOMPUUskZb2KKJ6jc/keUzfuv7/DYn3Yfr1CPU2yTO27HIkIYF4Gpu
         6pvOm940WtsJ5dSqTYZJh9qsKc6fGXYW8Lscb5uqmRiO08euMGGxbPUGy5kXahrJucCv
         F1UeSiYiOc857n1vJCsgwjQf5v+LsMkeF2MfQgJlOOu2iTKBxkZFfyC8LP5ohjZDa4bP
         V4bQ==
X-Gm-Message-State: AOAM530TG1L/JtnsU0vGB7ihtPZLybbf5X2MTM4SpA76ZKBPSHOlBLVO
        k+CGX6ieDab7RmheeoSvmvva1YvxjMbuXSYbYqw=
X-Google-Smtp-Source: ABdhPJz/UDM9xkU66Ix086j+Ph49UeQw8YCUSDrKlu0k50az9eulNWQZs1MOelgEZhMCs5ePIbbZBrnAl80ZxpBMZbc=
X-Received: by 2002:a92:2614:: with SMTP id n20mr4352852ile.53.1629277657265;
 Wed, 18 Aug 2021 02:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
 <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com> <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
In-Reply-To: <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 18 Aug 2021 17:07:26 +0800
Message-ID: <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com>
Subject: Re: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=
=8818=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:54=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Wed, Aug 18, 2021 at 6:51 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=
=E6=9C=8818=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:10=E5=86=99=E9=
=81=93=EF=BC=9A
> > >
> > > Hi,
> > >
> > > On Mon, Aug 16, 2021 at 4:00 PM ZheNing Hu <adlternative@gmail.com> w=
rote:
> > > >
> > > > Hi,
> > > >
> > > > In the implementation of %(raw) atom
> > > > (bd0708c7 ref-filter: add %(raw) atom), we use xmemdupz()
> > > > to copy the content of the object. But if we can reuse the content
> > > > of the object?
> > > >
> > > > Since git cat-file --batch needs to use ref-filter
> > > > as the backend, if the object buffer can be reused correctly here,
> > > > we can save a lot of copies and improve its performance by about 6%=
.
> > >
> > > Yeah, that would be great.
> > >
> > > > Tracing back to the source, the object buffer is allocated from
> > > > oid_object_info_extended(), but in parse_object_buffer() we may los=
e
> > > > the ownership of the buffer (maybe the buffer is eaten), but I brow=
sed the
> > > > source code of for-each-ref.c or cat-file.c, and I don=E2=80=99t se=
em to find that the
> > > > buffers which have been eaten are released by the program.
> > > >
> > > > So can we reuse it?
> > > >
> > > > This is what I want to do:
> > > >
> > > > diff --git a/ref-filter.c b/ref-filter.c
> > > > index 93ce2a6ef2..1f6c1daabd 100644
> > > > --- a/ref-filter.c
> > > > +++ b/ref-filter.c
> > > > @@ -1443,7 +1443,7 @@ static void grab_sub_body_contents(struct
> > > > atom_value *val, int deref, struct exp
> > > >                         unsigned long buf_size =3D data->size;
> > > >
> > > >                         if (atom->u.raw_data.option =3D=3D RAW_BARE=
) {
> > > > -                               v->s =3D xmemdupz(buf, buf_size);
> > > > +                               v->s =3D buf;
> > >
> > > It seems to me that this could work only if 'buf' isn't freed. Have
> > > you checked that? Did we leak 'buf' before this patch? Otherwise when
> > > are we freeing it?
> > >
> > This is how I use gdb find out if this buffer have been freed:
>
> I was asking about 'buf' before the patch.
>
> Before the patch, we were doing:
>
> v->s =3D xmemdupz(buf, buf_size);
>
> which means that in v->s there is a copy of 'buf', not 'buf' itself.
> So I was wondering if 'buf' was freed then, not the copy in in v->s.

I think the 'buf' is not freed in ref-filter logic.

But one thing worth noting is:

parse_object_buffer() may take this buffer away, and store it in
tree->buffer or use set_commit_buffer() to store it in commit_slab.

So in theory, as long as we don=E2=80=99t use parse_object_buffer(), this
dynamically allocated memory can be used freely for us. If we use
parse_object_buffer() and free the buffer, there seems to be a risk,
but it does not appear so far.

--
ZheNing Hu
