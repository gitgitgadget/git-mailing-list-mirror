Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFC0C07E9E
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE1861879
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhGEOh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhGEOh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 10:37:27 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063DC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 07:34:49 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id r9so7053548ual.7
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nchk4/leTPZySk2Rg4h/IY7TfgAdct2CY3mJB/wXAXc=;
        b=R5d6NIX+z9iYqyXY0QjHgWMwfe6LT3yZ5f864twc6Ls0CW+YsW5HkJ0mI0/aYnFiOI
         AMkt4SseFwuIjRf2iGZ/xgJF+kfAxlAGTHEhOfWV07hkrbD98GD0mGGxLGIKitEkAEtU
         kjLUKGFgDV/9XS2Qypxloz14Fgbdu0rCSdBXnWipBMtmtQaIbPO2+JOHzmzqHBQrDSzo
         d7kxf8qSzH14aAgqAPFyx+rJa662R01XrzfqWDY/juT1ofaHbb3n9/apk6B6HvfuotN8
         LSYQPI0rOdENaQjNhu1DkxhTCPRo0z+M3sLLX1eau1/7u/kfKMm1S4SGU6Yuf9zq7Ivy
         AYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nchk4/leTPZySk2Rg4h/IY7TfgAdct2CY3mJB/wXAXc=;
        b=TaYlbY2epT+Sm1NtyFumtT159XXNB9qoCLG2qu22/8G6z+3sb2jLJuQzlwcMIzOh+d
         zZgekCMbyXk29moOHz3eYlixo8BkX6HCM8aqr9LOUjO/5LDiSBBj1mwz1+DYhxACNL/l
         LGPYJVVOKPrlYxUQL6aLBAOGnSZulZu+rCKizfcTKIpm3Pbpv6UCtCvce8UXuyUBDGei
         x/MOqo8BhXk9VDETKFeCpkGszcLc080cOyQKf0xkbVLd+tKHdyLev8W0VEUZlIVASp2Z
         Xt+SQF7qNTyRP1jd8Y+wJLIDyaguM0x9EvE+8by5d8lgFGOHlpv2WauYVSUdHqVM5cTS
         xqHQ==
X-Gm-Message-State: AOAM531j1BvV8J9DxSlIjDe5WM5yjIH/YrY8hUvubRKcM53tJNZMZdhS
        ZsxA1PIhPV/RdfvRV8M/cK9rqXcCTy8Ce+8VpPAz9Q==
X-Google-Smtp-Source: ABdhPJxXe67q7lsux/nzg4zYmznHX4TSiQWrdHiAZygFrgmtxKIDgEuomwXdMFX4oO4Hu58l+I2wSnW1AIJ9Q0oVx8E=
X-Received: by 2002:a9f:3ec6:: with SMTP id n6mr10293742uaj.87.1625495687417;
 Mon, 05 Jul 2021 07:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com> <3e2831e59c8e4cb8aef416a41b55083887b4559c.1623329869.git.gitgitgadget@gmail.com>
 <87h7hedz9z.fsf@evledraar.gmail.com>
In-Reply-To: <87h7hedz9z.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 5 Jul 2021 16:34:36 +0200
Message-ID: <CAFQ2z_M5bbDgdmVmn-esxg5kAoT9tGS4azvvB5LGMb0UZg9QwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] refs: make errno output explicit for read_raw_ref_fn
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 1, 2021 at 1:55 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> > diff --git a/refs.c b/refs.c
> > index 8c9490235ea6..bebe3f584da7 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1675,13 +1675,17 @@ int refs_read_raw_ref(struct ref_store *ref_sto=
re,
> >                     const char *refname, struct object_id *oid,
> >                     struct strbuf *referent, unsigned int *type)
> >  {
> > +     int result, failure;
>
> Style nit: Different variables should be on different lines, except
> where they're the same, so "int i, j", not "int ret, i". Perhaps "ret"
> and "errno" are similar enough, but I'd split them, just my 0.02.
>
> Also nit: s/failure/failure_errno/, just like the function signature.

done.

> >       if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEA=
D")) {
> >               return refs_read_special_head(ref_store, refname, oid, re=
ferent,
> >                                             type);
> >       }
> >
> > -     return ref_store->be->read_raw_ref(ref_store, refname, oid, refer=
ent,
> > -                                        type);
> > +     failure =3D 0;
> > +     result =3D ref_store->be->read_raw_ref(ref_store, refname, oid, r=
eferent,
> > +                                          type, &failure);
> > +     errno =3D failure;
> > +     return result;
> >  }
>
> Is there some subtlety here where this isn't equivalent to the more
> simple/straightforward:
>
>         diff --git a/refs.c b/refs.c
>         index bebe3f584da..49ab7555de9 100644
>         --- a/refs.c
>         +++ b/refs.c
>         @@ -1675,17 +1675,14 @@ int refs_read_raw_ref(struct ref_store *r=
ef_store,
>                               const char *refname, struct object_id *oid,
>                               struct strbuf *referent, unsigned int *type=
)
>          {
>         -       int result, failure;
>                 if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "M=
ERGE_HEAD")) {
>                         return refs_read_special_head(ref_store, refname,=
 oid, referent,
>                                                       type);
>                 }
>
>         -       failure =3D 0;
>         -       result =3D ref_store->be->read_raw_ref(ref_store, refname=
, oid, referent,
>         -                                            type, &failure);
>         -       errno =3D failure;
>         -       return result;
>         +       errno =3D 0;
>         +       return ref_store->be->read_raw_ref(ref_store, refname, oi=
d, referent,
>         +                                            type, &errno);

There is a big difference: in this case, in read_raw_ref, the
failure_errno pointer is aliased to errno. Which means that things
like

   *failure_errno =3D 0
   some_syscall();

might mysteriously clobber *failure_errno again, which is the kind of
effect-at-a-distance we're trying to get rid of.

> I can only imagine a case where we think files_read_raw_ref() would
> encounter a new errno after it assigned to *failure_errno, which is just
> a couple of strbuf_release() calls.
>
> if that is a case we're worried about then like in my comment on 2/8
> shouldn't we be explicitly checking for such a lost/different errno?
> I.e. something like (should probably be less fatal than BUG(...):
>
>         diff --git a/refs.c b/refs.c
>         index bebe3f584da..9584ddae392 100644
>         --- a/refs.c
>         +++ b/refs.c
>         @@ -1675,16 +1675,22 @@ int refs_read_raw_ref(struct ref_store *r=
ef_store,
>                               const char *refname, struct object_id *oid,
>                               struct strbuf *referent, unsigned int *type=
)
>          {
>         -       int result, failure;
>         +       int result, failure_errno =3D 0;
>         +
>                 if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "M=
ERGE_HEAD")) {
>                         return refs_read_special_head(ref_store, refname,=
 oid, referent,
>                                                       type);
>                 }
>
>         -       failure =3D 0;
>         +       errno =3D 0;
>                 result =3D ref_store->be->read_raw_ref(ref_store, refname=
, oid, referent,
>         -                                            type, &failure);
>         -       errno =3D failure;
>         +                                            type, &failure_errno=
);
>         +       if (errno)
>         +               BUG("Got another errno from read_raw_ref()?: %s, =
failure errno: %s",
>         +                   strerror(errno),
>         +                   strerror(failure_errno));

The whole idea is to make sure that important (ie. errno values that
influence downstream logic) are separate from unimportant (ie. used
for error messages). By adding a BUG() here, you're making a drastic
downstream logic change depending on errno,  so your example code is
going precisely in the opposite direction of where I want to go, and
forces implementers of read_raw_ref to walk on eggshells again wrt.
errno handling to avoid triggering error messages.

> > + * Return 0 on success. If the ref doesn't exist, set failure_errno to=
 ENOENT
> > + * and return -1. If the ref exists but is neither a symbolic ref nor =
an object
> > + * ID, it is broken; set REF_ISBROKEN in type, and return -1 (failure_=
errno
> > + * should not be ENOENT). The files backend may return EISDIR (if the =
ref name
> > + * is a directory) and ENOTDIR (if a ref prefix is not a directory). I=
f there is
> > + * another error reading the ref, set failure_errno appropriately and =
return -1.
> >   *
>
> This documentation is a bit confusing in light of the above comments. I
> assume that "set failure_errno appropriately" here means that it will do
> it, but it's really worded like it's suggesting that you should do it,
> and does the "another error" suggest that a caller may need to deal with
> an arbitrary errno, not just the ENOENT|EISDIR|ENOTDIR?

Tried to clarify this.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
