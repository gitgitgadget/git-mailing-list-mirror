Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AB4C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C98613FE
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhGCFQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 01:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhGCFQt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 01:16:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73632C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 22:14:16 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id g3so12236336iok.12
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 22:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eqHcCYyb0krwkehfr+z4CTCS1/jQUPeriBMVHJ7mpSA=;
        b=L6Y1gqL1MqZwriML0ESKwQHQPA0I9UZAd3y3bxEdBv2iF7SodHpYTMcAeWdk04WJFV
         zXQstf/wtw0uKDNZm+hgRgotwTqJAx+Axh/F92qcocDUN42j/5xj6VL75ME6ntP2F0zr
         KX0rJptxcrUlup3E1QhX392lgvXJjzmyEZc5XbWrPTU8WIYQRp2SMJFeTu8txEnSQZ0H
         yA4Oy3pEWyI9+KMSqjTwgC367CzKNhQv5uI5oFRQ0KVHsLzdjFEFVqNxJsXoqMe33BkO
         O+gF7hSzhopCEkqqsPGMz0ZXTEznF256YyGqBxMWofHHTGQr8cOncz6Y+YD38ZVi7J0m
         zpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eqHcCYyb0krwkehfr+z4CTCS1/jQUPeriBMVHJ7mpSA=;
        b=F4sQ4vNHWI9YzU7gWySQDZPe4nOnleB6eQT6c4/0DnMtacYw83Sa1z+rm0MpFk/CVr
         WrlQ3w69uEUG73ULXgXQNpa4FFxHUOfY8nkIPzsU3fKaCw1BaDtXMARUQyO9dsGayHTx
         mcxtwtP9AA4+YB4eKYyW2oU4hicAqppDPFEGYsTN6sexPkcQplOqoUdITwg8AI9zckVP
         vO6CCIyDsIXYA6cQW4ggyPPzjxcPv9p5wpiv9MMt72Uti/fAGI++N+qqfJH33nlaMx+k
         xAZCbAxpd/U18+77QbdL+opWJ5FPel+pqr0pZS34N0q3rSgDgg1Lse0ns8+e2P6C18uw
         AqSQ==
X-Gm-Message-State: AOAM532rMof6TyRjh88ktVkP+N8OABcqrzMxQPUOVq5rHXxcn9lUnJpZ
        WOI4FJBIexXiZBNLJDQrU+e8Rbx8JD8yo/qrFTg=
X-Google-Smtp-Source: ABdhPJzsMF8YzhYooNuN9v0UHy8S8RvDHN+qWxixGp1oOr8nm00Xmlyo1I7JiN42FcpnT50S9yImJ9vWPLPoLgTA6aU=
X-Received: by 2002:a05:6638:3294:: with SMTP id f20mr2473328jav.130.1625289255284;
 Fri, 02 Jul 2021 22:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <ad71510feda0a100920a99de41db0ab137787796.1625155693.git.gitgitgadget@gmail.com>
 <87im1salrd.fsf@evledraar.gmail.com>
In-Reply-To: <87im1salrd.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Jul 2021 13:14:09 +0800
Message-ID: <CAOLTT8QjGekriRWFp_HM0Cqiz4TYB_=cN7bBxhCSdZqzg4BG0w@mail.gmail.com>
Subject: Re: [PATCH 02/15] [GSOC] ref-filter: add %(raw) atom
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
=B9=B47=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:27=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:
>
> > @@ -1362,17 +1398,29 @@ static void grab_sub_body_contents(struct atom_=
value *val, int deref, struct exp
> >       const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NULL;
> >       size_t sublen =3D 0, bodylen =3D 0, nonsiglen =3D 0, siglen =3D 0=
;
> >       void *buf =3D data->content;
> > +     unsigned long buf_size =3D data->size;
>
> Let's declare this.
>
> >       for (i =3D 0; i < used_atom_cnt; i++) {
> >               struct used_atom *atom =3D &used_atom[i];
> >               const char *name =3D atom->name;
> >               struct atom_value *v =3D &val[i];
> > +             enum atom_type atom_type =3D atom->atom_type;
> >
> >               if (!!deref !=3D (*name =3D=3D '*'))
> >                       continue;
> >               if (deref)
> >                       name++;
> >
> > +             if (atom_type =3D=3D ATOM_RAW) {
>
> Here, where it's going to be used.
>

Yeah, buf_size is only used here.

> > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > index 9e0214076b4..18554f62d94 100755
> > --- a/t/t6300-for-each-ref.sh
> > +++ b/t/t6300-for-each-ref.sh
> > @@ -130,6 +130,8 @@ test_atom head parent:short=3D10 ''
> >  test_atom head numparent 0
> >  test_atom head object ''
> >  test_atom head type ''
> > +test_atom head raw "$(git cat-file commit refs/heads/main)
> > +"
>
> Extra stay line here, is the \n intentional?

I think so. `\n` is necessary.
In cmd_for_each_ref(), there have a  extern "putchar('\n');"
In cat_one_file(), write_or_die() output origin data of the object.

Thanks.
--
ZheNing Hu
