Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E0FC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B5061165
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhHXHMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhHXHML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 03:12:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE1EC061575
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 00:11:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i6so30078103edu.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YfdfsU+Ja61UQ90Z/tyTT2zC1I9zZYAkEsaJ+yo9B08=;
        b=Sip/FtT5w4uoxfc0UOuXP+yy/x643ZeQ10TM1akH7qdWU1cCPOxfUY/rBsAZLHunNG
         eGufhvVU2RWA5dTCAqQ20rEJp9cgvzuzecpNmDt6QI2QH5wABNo12R+YeVH3zzsPMOFv
         6nfDa1REIwH/2n+TabMXm8u1MELnGnpLK1ye4Bc7wontY/OyjVIjrSvt8W5aq2sXgChM
         GVU4Rgum7/jjK1Z/oXcg/4qVXZfxIePRz6EmqlyGs+fZ1VqchPTvyvxFOyXCa5PWB44U
         lrJhdKqn7Z/FuFYgZ3vtOBdRB+pB1JB8ggCn9+AWkK8+toTUzgLnAqS3ByM6mTvgJq1E
         TmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YfdfsU+Ja61UQ90Z/tyTT2zC1I9zZYAkEsaJ+yo9B08=;
        b=i1P577VueBbMK1LOpordV9wFNVRiPvbshATP1nR+9x/uxSQ25n1GaRBL1W9UOxXVWo
         jNMaGmDG0i7I7obEzP1Ff3jVFn2pc5iMUsf0ElmSCWf114Ea+aiTh4F2otcdEBp79EkP
         8OcXOxTdv451eBR4DrNZTBWfsnRN8a2rTQrLMn83AZ+m9PkJcZ6uBfbEyoZdME3onIVr
         7NE2olinN7mKHNHU4CVR1LoVplHs8wJ4HZpvgrgdmOd+NxB+C+aqahuiByYRkSSfOlxk
         f+4TFB1WynInPDyqjl9fvZWpEcM0D11q9pyH2FP/chj25SqExKt3koZNT6BvJOPA+w50
         RMjA==
X-Gm-Message-State: AOAM532gcjXFGiC+Os4YhmfzJvPzCv/OfhXGFGbOWspa3j7AFLpaMS9T
        FKIzZO127TOreRtaAL+Mkf6S6XtTidoIzCo9RfE=
X-Google-Smtp-Source: ABdhPJwgWZ3d43a+Z0voUiEimsfDVmR9//nc2OGgyiutsV/EaF8l3Knv2cPd+GLQj9dPT4rY9jsEn79JGEWU6o3RdMc=
X-Received: by 2002:a05:6402:220f:: with SMTP id cq15mr20046078edb.142.1629789086635;
 Tue, 24 Aug 2021 00:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
 <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
 <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
 <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com>
 <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com>
 <CAP8UFD0aDrqHxNp2ztecmZR49gs=SVJTN1NUzJvz6+ewpY-_wA@mail.gmail.com> <CAOLTT8St0PGPsw6zki2fwO3iVG_4W=s6GEqZfp3cmH=xngcO2A@mail.gmail.com>
In-Reply-To: <CAOLTT8St0PGPsw6zki2fwO3iVG_4W=s6GEqZfp3cmH=xngcO2A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 Aug 2021 09:11:14 +0200
Message-ID: <CAP8UFD0pZVCHG_i+u_6QAP5yKUpmdYm+fkwr9aJMCDXukKF_7g@mail.gmail.com>
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

On Sat, Aug 21, 2021 at 4:16 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:58=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > On Wed, Aug 18, 2021 at 1:11 PM ZheNing Hu <adlternative@gmail.com> wro=
te:

> > > -static void grab_sub_body_contents(struct atom_value *val, int deref=
,
> > > struct expand_data *data)
> > > +static void grab_sub_body_contents(struct atom_value *val, int deref=
,
> > > struct expand_data *data, int eaten)
> > >  {
> > >         int i;
> > >         const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D N=
ULL;
> > > @@ -1499,7 +1499,10 @@ static void grab_sub_body_contents(struct
> > > atom_value *val, int deref, struct exp
> > >                         unsigned long buf_size =3D data->size;
> > >
> > >                         if (atom->u.raw_data.option =3D=3D RAW_BARE) =
{
> > > -                               v->s =3D buf;
> > > +                               if (eaten)
> > > +                                       v->s =3D xmemdupz(buf, buf_si=
ze);
> >
> > Can the 'buf' already be eaten at this point? I thought that it could
> > be eaten only through v->s so after this code.
>
> I think where the 'buf' is eaten is parse_object_buffer().

Yeah, right, and parse_object_buffer() seems to be called by
get_object() which calls grab_values() after that. So the buf can
indeed be eaten at that point.

> set_commit_buffer()
> or parse_tree_buffer() cache the 'buf'. 'eaten' means we don't need to fr=
ee it
> manually.

Yeah, but it doesn't mean that we cannot use the buf. So perhaps we
could still use it, even if it's eaten.

> In grab_sub_body_contents() we can indeed write the address of
> 'buf' to v->s, but what I worry about is that before we completely write =
v->s to
> the output buffer through append_atom(), will this buf be freed in
> somewhere else?

Yeah, that's a good question. But actually it seems that the buf is
freed (at least in get_object()) only when it's not eaten.

> > > +                               else
> > > +                                       v->s =3D buf;
> > >                                 v->s_size =3D buf_size;
> > >                         } else if (atom->u.raw_data.option =3D=3D RAW=
_LENGTH) {
> > >                                 v->s =3D xstrfmt_len(&v->s_size,
> > > "%"PRIuMAX, (uintmax_t)buf_size);
> > >
> > > As parse_object_buffer() does internally: the buffer of commit/tree o=
bjects
> > > needs to be copied, but blob/tag not. You said that the number of com=
mits
> > > is generally significantly greater than the others. It seems that we =
cannot
> > > make full use of this idea. But remember the "skip_parse_buffer" befo=
re?
> > > If we skip the parse_object_buffer(), this buffer is also "!eaten".
> > >
> > > In other words, those default paths of git cat-file --batch are inclu=
ded in it!
> > > So from the perspective of performance regression, this patch will be
> > > beneficial.
> >
> > Yeah, it seems that we can benefit from something like this, but it'd
>
> Only when the data allocated to us is dynamically allocated and we do hav=
e
> the ownership of it, we can benefit by reducing copies and allocate
> memory again.
>
> > be nice if things were clarified a bit more.
>
> OK. In get_object(), eaten means that the oi->content we obtained is cach=
ed
> by git in parse_object_buffer(). This means that we don't need to free th=
is buf
> manually. In 28511adfa5 ([GSOC] ref-filter: skip parse_object_buffer()), =
we skip
> parse_buffer() when using some atoms, which can avoid some meaningless pa=
rsing.
> So under this path, our'buf' is not cached. This means we have
> ownership of it, so we
> can free it freely, and benefit from this.

In the patch we are not freeing it, we only duplicate it when it's
eaten. So I am not sure that the above explanation are clear enough.
That's the issue I have with this patch, but maybe the commit message
can now be discussed and improved after sending the patch series to
the mailing list instead of in this thread.

Thanks!
