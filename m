Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27B0C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 04:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED8A61056
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 04:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhHREwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 00:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhHREv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 00:51:59 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC95C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 21:51:25 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s16so895193ilo.9
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 21:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J5sGTc67XyGT2i4jMZF2r4TMn8sSzasP3c1BBrtoMT8=;
        b=YBcSZqVrTYc1XfxGqnAp/tmlWao7ssj8W0mapbSpXjrlvKbAf1D9Urm1xyL+Ay8wDe
         HFFqqzyigzOuqqOLQtNo8hs4yYfmeOeD0/6HWZyztOxsKkFoJ/qVYUruhXgtxBsGrcTa
         vJz9dA2S2WmUwDdZQnmvX+Vd45a4LLrEj6ju59tqMX9nKnieOaSYjoXA2s+vtvARK3TZ
         dPQ2QOLee/t3nzU6LbhwRLgrbdobgFTE+Ntb8A/7hw5wwW6SL7l2yPmYuIqoFCrmbjdA
         c7MJ1Rxya9v1A4vxUMkh6nw2qlHw4WAvMsrV7y5tL+Fnv9clyZEbl3Ng4VRauX/nb3TI
         yvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J5sGTc67XyGT2i4jMZF2r4TMn8sSzasP3c1BBrtoMT8=;
        b=bLrkRDlYVtQZct/Uo56H9ADgFtyfA/itfTzymbChdNkxq/Tgr9SrBh4PDm3NTvAlGj
         I23GY5VfPiZa4i/1Uy+X4yO+VGjaceIaD4ttEylpQ4kO6jJnND4Ng86bPa1gEqGY1D8s
         ob3cJi4WU7+iNc6qn8JA4HZzdmJJSd/QFOVWbn46wSF+lhuYtAgL76TfU9B8iFcjiosf
         uyfgvWllJHc0AMzDTDHiI7H+CsjeJm6h71PGaHoJs8QgTTU1eGZf/00/ooyLH/RwnML2
         dEcunIv0tz2Zx7xBwhPOVMzBjQJre+PM/P2MDGl6dKm+3b3Un1qF8BDy6se4pC142/H9
         vzaQ==
X-Gm-Message-State: AOAM531l9Uou/uEVIL2MFzdHyjHT3rUAWfMemQxFkl/xrDVF8LfJxT55
        cc9zow9ktkhNNNnzafne86z/ozJrVdS+V48DFf0=
X-Google-Smtp-Source: ABdhPJyMszGPvJ3pngAY5RBJ/7tZc6rhYFBRHW/56hwqgkw1lCshqYev3zqpDDjkvcMU1nfEFewLMbN/6mCgWivwX6A=
X-Received: by 2002:a92:2614:: with SMTP id n20mr3773025ile.53.1629262284879;
 Tue, 17 Aug 2021 21:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 18 Aug 2021 12:51:13 +0800
Message-ID: <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
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
=8818=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:10=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> On Mon, Aug 16, 2021 at 4:00 PM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Hi,
> >
> > In the implementation of %(raw) atom
> > (bd0708c7 ref-filter: add %(raw) atom), we use xmemdupz()
> > to copy the content of the object. But if we can reuse the content
> > of the object?
> >
> > Since git cat-file --batch needs to use ref-filter
> > as the backend, if the object buffer can be reused correctly here,
> > we can save a lot of copies and improve its performance by about 6%.
>
> Yeah, that would be great.
>
> > Tracing back to the source, the object buffer is allocated from
> > oid_object_info_extended(), but in parse_object_buffer() we may lose
> > the ownership of the buffer (maybe the buffer is eaten), but I browsed =
the
> > source code of for-each-ref.c or cat-file.c, and I don=E2=80=99t seem t=
o find that the
> > buffers which have been eaten are released by the program.
> >
> > So can we reuse it?
> >
> > This is what I want to do:
> >
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 93ce2a6ef2..1f6c1daabd 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -1443,7 +1443,7 @@ static void grab_sub_body_contents(struct
> > atom_value *val, int deref, struct exp
> >                         unsigned long buf_size =3D data->size;
> >
> >                         if (atom->u.raw_data.option =3D=3D RAW_BARE) {
> > -                               v->s =3D xmemdupz(buf, buf_size);
> > +                               v->s =3D buf;
>
> It seems to me that this could work only if 'buf' isn't freed. Have
> you checked that? Did we leak 'buf' before this patch? Otherwise when
> are we freeing it?
>
This is how I use gdb find out if this buffer have been freed:

Breakpoint 1, get_object (ref=3D0x5555559ad7a0, deref=3D1,
obj=3D0x7fffffffc930, oi=3D0x5555559a21e0 <oi_deref>, err=3D0x7fffffffcb80)
at ref-filter.c:1744
1744    {
(gdb) n
1746            int eaten =3D 1;
(gdb)
1747            if (oi->info.contentp) {
(gdb)
1749                    oi->info.sizep =3D &oi->size;
(gdb)
1750                    oi->info.typep =3D &oi->type;
(gdb)
1752            if (oid_object_info_extended(the_repository, &oi->oid,
&oi->info,
(gdb)
1756            if (oi->info.disk_sizep && oi->disk_size < 0)
(gdb)
1759            if (oi->info.contentp) {
(gdb) p oi->info.contentp
$1 =3D (void **) 0x5555559a2240 <oi_deref+96>
(gdb) p oi->content
$2 =3D (void *) 0x5555559afc90
(gdb) b free if $rdi =3D=3D 0x5555559afc90
Breakpoint 2 at 0x7ffff7e1f980
(gdb) d 1
(gdb) c
Continuing.
tree 2025c6f1d02348585487ab5597d77151f158325f
parent 532c266f73e11df407a8939135f2722c003b7539
author ZheNing Hu <adlternative@gmail.com> 1628909038 +0800
committer ZheNing Hu <adlternative@gmail.com> 1628909038 +0800

test2

tree 2025c6f1d02348585487ab5597d77151f158325f
parent 532c266f73e11df407a8939135f2722c003b7539
author ZheNing Hu <adlternative@gmail.com> 1628909038 +0800
committer ZheNing Hu <adlternative@gmail.com> 1628909038 +0800

test2

[Inferior 1 (process 74283) exited normally]

We didn't stop at the breakpoint, this means that we did not free() the mem=
ory.
Or will this be used as a caching mechanism? I dunno...

> >                                 v->s_size =3D buf_size;
> >                         } else if (atom->u.raw_data.option =3D=3D RAW_L=
ENGTH) {
> >                                 v->s =3D xstrfmt("%"PRIuMAX, (uintmax_t=
)buf_size);
> > @@ -1768,8 +1768,6 @@ static int get_object(struct ref_array_item
> > *ref, int deref, struct object **obj
> >         }
> >
> >         grab_common_values(ref->value, deref, oi);
> > -       if (!eaten)
> > -               free(oi->content);
>
> This change might not be needed. 'oi->content' seems to come from the
> 'buf' above, either directly or through a copy, but if we can indeed
> own the 'buf' completely, then we should be able to dispose of it how
> we want.
>

Since we will release the `v->s` (now is the buf) in free_array_item(), if =
we
continue to call free() in get_object(), it may cause double-free.

> >         return 0;
> >  }

Thanks.
--
ZheNing Hu
