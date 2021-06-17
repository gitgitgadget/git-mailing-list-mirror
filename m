Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44024C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDAA613F5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhFQKD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhFQKDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:03:25 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24940C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k16so2451335ios.10
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RbHxnDOvlAD92fzPdBwHr3ysNeP/U6/hpI9nH1MVBp4=;
        b=LH/e0hMuJapc4XIJXN8e71g3xwDchdjhom3r0nuSZz4dreXGQe6XfM8JLETB/j2EIE
         ydvWxeVwMw/XH5N5qSBtPBSABl443N10Ms47udJj532TGOqK2A13yFRbyeZRqwkIUDwM
         eEHcWcCt3gBU5nMKIOZ9XZ19nWN2X1vOaKwXQ/6ntDMoRs0z1yEVJdQGkf4+IXoJsIaA
         HrUUDw4O20n43o5Wh8Qxs2FN4jDHxA5UtZPMfp8rDcCd2QMoz/sIILAz+Bc61ko41zIz
         dpQ0xeWrSCMHYqOZr/z/aF0+LNQb3za9LmLJLJHEJn4wjoMf/fryg8BywDk9mj3EMBL9
         fUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RbHxnDOvlAD92fzPdBwHr3ysNeP/U6/hpI9nH1MVBp4=;
        b=L80XRwQJpki3kF1vDP5IZlx9lOh5741/LYzGQMLXYBuTD1i8OvDBpltfonen/HRD4q
         fF2WhjQ7oayuQOBTIFgSU5Ypcey5nOwUnTdkwJpiYJ7Gjwhc7JsKAlSHLKtNkLeu84Qr
         sw35cqc88dqGQnHdyzJ6rs52Q+2xxddZ4DcRNeH1eeLQsy/t55Y3QfjL/+8mLrhX39zF
         WBbEQJTRkFIDhG4tzJOSyXEqJXoRvZlzbQQ2b/2/YrPbLGs2KOq+drrAzViW7R6lJIuH
         2jI0eOvn4Ts23Sa1rQdjbcokjTguSjCZSqxdyTppfM30gQUR6NjXswWXVzphH0feg9Zd
         rc5w==
X-Gm-Message-State: AOAM5306fa14qktEDFT3IKc7MhY6oe+nbqYA0vdZKtz7dbmScMZH2S13
        o6QbMYoHNJeuZJ+Dh+jpscRzi+ed93LNik9f0pM=
X-Google-Smtp-Source: ABdhPJzYU0mCrc7lKCPQVYgz9D7e5gQZrEMYgnUj/bAPqwhFA3xt72Gl16+qt/OPWnxm2+einqTxgAZVCqm49Z7CWWk=
X-Received: by 2002:a6b:7004:: with SMTP id l4mr3233209ioc.68.1623924076579;
 Thu, 17 Jun 2021 03:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <c208b8a45d66556a3f905063bc7c5026ac4f1e82.1623496458.git.gitgitgadget@gmail.com>
 <87wnqtvtph.fsf@evledraar.gmail.com>
In-Reply-To: <87wnqtvtph.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 17 Jun 2021 18:01:05 +0800
Message-ID: <CAOLTT8RPMf6YcHT4Qi=NFwh_5ZR7c5xgj6E94GGWMJ+749zS0g@mail.gmail.com>
Subject: Re: [PATCH 5/8] [GSOC] ref-filter: teach get_object() return useful value
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B46=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:25=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Sat, Jun 12 2021, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Let `populate_value()`, `get_ref_atom_value()` and
> > `format_ref_array_item()` get the return value of `get_value()`
> > correctly. This can help us later let `cat-file --batch` get the
> > correct error message and return value of `get_value()`.
> >
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Hariom Verma <hariom18599@gmail.com>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  ref-filter.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 8868cf98f090..420c0bf9384f 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -1808,7 +1808,7 @@ static char *get_worktree_path(const struct used_=
atom *atom, const struct ref_ar
> >  static int populate_value(struct ref_array_item *ref, struct strbuf *e=
rr)
> >  {
> >       struct object *obj;
> > -     int i;
> > +     int i, ret =3D 0;
>
> The usual style is to not bunch up variables based on type, but only if
> they're related, i.e. we'd do:
>
>     if i, j; /* proceed to use i and j in two for-loops */
>
> But:
>
>     int i; /* for the for-loop */
>     int ret =3D 0; /* for our return value */
>
> (Without the comments)
>

I agree.

> >       struct object_info empty =3D OBJECT_INFO_INIT;
> >
> >       CALLOC_ARRAY(ref->value, used_atom_cnt);
> > @@ -1965,8 +1965,8 @@ static int populate_value(struct ref_array_item *=
ref, struct strbuf *err)
> >
> >
> >       oi.oid =3D ref->objectname;
> > -     if (get_object(ref, 0, &obj, &oi, err))
> > -             return -1;
> > +     if ((ret =3D get_object(ref, 0, &obj, &oi, err)))
> > +             return ret;
>
> Maybe more personal style, I'd just write this as:
>
>     ret =3D x();
>     if (!ret)
>         return ret;
>
> Makes it easier to read and balance parens in your head for the common
> case...
>

Yeah. This way it will be more readable.

> > @@ -2585,10 +2588,10 @@ int format_ref_array_item(struct ref_array_item=
 *info,
> >               if (cp < sp)
> >                       append_literal(cp, sp, &state);
> >               pos =3D parse_ref_filter_atom(format, sp + 2, ep, error_b=
uf);
> > -             if (pos < 0 || get_ref_atom_value(info, pos, &atomv, erro=
r_buf) ||
> > +             if (pos < 0 || (ret =3D get_ref_atom_value(info, pos, &at=
omv, error_buf)) ||
> >                   atomv->handler(atomv, &state, error_buf)) {
> >                       pop_stack_element(&state.stack);
>
> ... and use that mental energy on readist stuff like this, which I'd
> just leave as the inline assignment.

Indeed, inline assignment must be used in this case.

Thanks. I will pay attention to these style issues later.
--
ZheNing Hu
