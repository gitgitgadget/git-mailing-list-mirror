Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A892C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 08:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E36861214
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 08:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhHYIMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhHYIMn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 04:12:43 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16E9C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 01:11:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id v16so23109239ilo.10
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sKyrTgXKB2DvU5bN4FqKRrKoZ8TnjoQcsXi3Dmp7HwM=;
        b=oTpSOsmfl/Zx42oiq3wsExWYgHQSb8wLGauYtn0Mfwg8Jf1eM7Uextt6zccGKW04Rs
         mll7bphc5k55T2l6ycM/bcDQlTvZG5TgMpCq+xDmLed+UvlWTndf0AVYVCyTdec9cDic
         O/O62c4sPD05RmQRNHdZEbjPjLlRBSk42GfShNJnd9y23KPym/mXbxMq5XML8kDHuEGh
         ONGg+JiQJzja9u2ELjmXoHhRL5c12XFXAyY1rcG4kZE7LSr4r4q0nac58CqlDYTbwISG
         3n4k8LoOe2XSOoAmmyk9tGtw0i3+xnWrl3sGefL7p4O0Xc8sRqlcStroLgAsAfKWTb2U
         DOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sKyrTgXKB2DvU5bN4FqKRrKoZ8TnjoQcsXi3Dmp7HwM=;
        b=iDtMyjRzCZaJgAp3mVZF9zPpfUD9mn3vzMF8v+rssBLJfuRm8yLasugkCKUc6XqYCC
         rga7emTenniT+88jnRlryKd3ihStm+IRidgeIkq8C4dMgPUyTmDdX2oS7+XnoRBMXwWs
         nyibyRmz/Sqn/Smszgt/J1/EZzDZyMAN5iTNSRUx6yWbngzP6J+wP7uB505KSv6plEVn
         qba3VEBHLulI6O4QCWJWFTeFnXykuLQzqWvJe0VC79XoQbRNehOskc4FAfZP+Duz314Y
         T4kMaOLEuD9Wvr+eqqJtqWdUSziZ4wCFsYTPnkRQxfjiYCLuIvYEoB8iOTNs9AzHb3EU
         9TAA==
X-Gm-Message-State: AOAM532IDZAyhmByrjtcvG4CJ0Bh6ByYXUEIo5iDUBbRBEAuKqgzq6tc
        B+kVKL+uA1Ygg6F1uoJlt5+HHEc2mHgopqcJ29U=
X-Google-Smtp-Source: ABdhPJwSfGdODMd9+znRKsCbHtu41NR59EYfhtD9gHkyzl1ed/sXiLSKQpsbPyqIEVxQUP1msOcaDm3pw3IOjapVAv8=
X-Received: by 2002:a92:2614:: with SMTP id n20mr29624491ile.53.1629879117187;
 Wed, 25 Aug 2021 01:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
 <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
 <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
 <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com>
 <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com>
 <CAP8UFD0aDrqHxNp2ztecmZR49gs=SVJTN1NUzJvz6+ewpY-_wA@mail.gmail.com>
 <CAOLTT8St0PGPsw6zki2fwO3iVG_4W=s6GEqZfp3cmH=xngcO2A@mail.gmail.com> <CAP8UFD0pZVCHG_i+u_6QAP5yKUpmdYm+fkwr9aJMCDXukKF_7g@mail.gmail.com>
In-Reply-To: <CAP8UFD0pZVCHG_i+u_6QAP5yKUpmdYm+fkwr9aJMCDXukKF_7g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 25 Aug 2021 16:11:45 +0800
Message-ID: <CAOLTT8S-bbnb8BecJRzLQytEEnZKU_VwRwiF1tk+gy0yrjTOog@mail.gmail.com>
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
=8824=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:11=E5=86=99=E9=81=93=
=EF=BC=9A
>
> > set_commit_buffer()
> > or parse_tree_buffer() cache the 'buf'. 'eaten' means we don't need to =
free it
> > manually.
>
> Yeah, but it doesn't mean that we cannot use the buf. So perhaps we
> could still use it, even if it's eaten.
>

Yes. Just like the following question: How do we know that the eaten 'buf' =
has
not been free() by some logic in git when we want to use it?

> > In grab_sub_body_contents() we can indeed write the address of
> > 'buf' to v->s, but what I worry about is that before we completely writ=
e v->s to
> > the output buffer through append_atom(), will this buf be freed in
> > somewhere else?
>
> Yeah, that's a good question. But actually it seems that the buf is
> freed (at least in get_object()) only when it's not eaten.
>

get_object() will free the 'buf' which has not been eaten, but we can
take use of
it (v->s =3D buf and we free it later)

> > > > +                               else
> > > > +                                       v->s =3D buf;
> > > >                                 v->s_size =3D buf_size;
> > > >                         } else if (atom->u.raw_data.option =3D=3D R=
AW_LENGTH) {
> > > >                                 v->s =3D xstrfmt_len(&v->s_size,
> > > > "%"PRIuMAX, (uintmax_t)buf_size);
> > > >
> > > > As parse_object_buffer() does internally: the buffer of commit/tree=
 objects
> > > > needs to be copied, but blob/tag not. You said that the number of c=
ommits
> > > > is generally significantly greater than the others. It seems that w=
e cannot
> > > > make full use of this idea. But remember the "skip_parse_buffer" be=
fore?
> > > > If we skip the parse_object_buffer(), this buffer is also "!eaten".
> > > >
> > > > In other words, those default paths of git cat-file --batch are inc=
luded in it!
> > > > So from the perspective of performance regression, this patch will =
be
> > > > beneficial.
> > >
> > > Yeah, it seems that we can benefit from something like this, but it'd
> >
> > Only when the data allocated to us is dynamically allocated and we do h=
ave
> > the ownership of it, we can benefit by reducing copies and allocate
> > memory again.
> >
> > > be nice if things were clarified a bit more.
> >
> > OK. In get_object(), eaten means that the oi->content we obtained is ca=
ched
> > by git in parse_object_buffer(). This means that we don't need to free =
this buf
> > manually. In 28511adfa5 ([GSOC] ref-filter: skip parse_object_buffer())=
, we skip
> > parse_buffer() when using some atoms, which can avoid some meaningless =
parsing.
> > So under this path, our'buf' is not cached. This means we have
> > ownership of it, so we
> > can free it freely, and benefit from this.
>
> In the patch we are not freeing it, we only duplicate it when it's
> eaten. So I am not sure that the above explanation are clear enough.
> That's the issue I have with this patch, but maybe the commit message
> can now be discussed and improved after sending the patch series to
> the mailing list instead of in this thread.
>

My thoughts are:

1. those 'buf' which have been eaten, because we don't know when they
will be freed, if we
use it in append_atom(), it may be a little unsafe if it have been
freed, but it is safe to use after
copying it;
2. those  uneaten 'buf', it can be used safely.

Maybe we can guarantee that the buf have not been freed when append_atom()?
I don't have a good grasp.

> Thanks!

Thanks.
--
ZheNing Hu
