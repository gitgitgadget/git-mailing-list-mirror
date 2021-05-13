Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181D2C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91BC61435
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhEMJ1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhEMJ1S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 05:27:18 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC5BC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:26:09 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z1so14658083ils.0
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8+drpgq32znF7QjK2yKKF7ZmmAKPbYomeT7tkpYjCPU=;
        b=FilJFAIkGteBAE8Y7fag9GAtB6TQcrBzVTbG7UI7t1faJ59XKJvjEfwNPMCyb7u2ds
         kITIF+oSauWZ0+24GD7emW2HmbeTeRkb2+QdN0eScnqtY3aOqbYOr/p0iFbCpQaS9DNR
         uJMMPSiWMaP1kQUNZjPZQiCehq3jRPZO4ymSv41Dg9K58XIaO0FygERGpydrxm92+epG
         kGplTu5dHmfKjin1CdfET2DA9Avfo5pgpdR81Dkge4w8M5x6qoGeowJJnaqaK/0Q3Bdm
         YPkSBpypo/7rfKrTE0ctQH7nM8B/6r81Hmv48HDxlQYyHPBurquOCXTQuro7gWc5sA1J
         wefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8+drpgq32znF7QjK2yKKF7ZmmAKPbYomeT7tkpYjCPU=;
        b=KyC0Zl2WCVFswTYNjV7fOx8qCR4CUFZYIs7WAWkS0+o+mrxwXAysIOQGKxVexA0d/4
         LbgC2VUGa/i2/gefCy4m2N7p44akHjk2sslwjCHsOX1yySnJnt1xHvmpKN+0urgCJL9O
         9RNiS0uFrDF7utUS8je1w0H5WnCm/Tn0J8UJH2XaLdqBCcmfXHyxtsZ5iOTTfeYi9I1J
         MtVL0nrfVXNqECFR9De98OM63nxo+I4a7hC+CMm9WO5vpid1H+eszymmUe498Y/dku3i
         J8VGXv9e3ZVTnIBHj+lTb/Mzh4zkmCwacv8YlQMOdYlHFRZZVBA20IwMsHk0FHOCtGBX
         oLAA==
X-Gm-Message-State: AOAM5339FO9zYfavGKiq6X/IVEu+UAoVUO96z0uF2yfiyL8yXmZI0ghr
        QGwkZ6HUj57QuvOBqZlkyj1xvb6bFxgs+ofuVaI=
X-Google-Smtp-Source: ABdhPJz1LUjJtDXB3VGRUM2NXTddb3tINtw78INrcIsALfa4sxTZuh//TX4YUVqv/tRwWrgCX9LgoHAlnE9xU765LUo=
X-Received: by 2002:a92:340a:: with SMTP id b10mr35071091ila.301.1620897968961;
 Thu, 13 May 2021 02:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
 <pull.951.v3.git.1620821464.gitgitgadget@gmail.com> <43400cac58e74a2acab15ace929481a9efb7978f.1620821464.git.gitgitgadget@gmail.com>
 <xmqqk0o3edxw.fsf@gitster.g>
In-Reply-To: <xmqqk0o3edxw.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 13 May 2021 17:25:57 +0800
Message-ID: <CAOLTT8TuMJgETg7F7XG2FhFTC318Ag7dJ=8Zi1CG2AwQXtgHvA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] [GSOC] ref-filter: introduce enum atom_type
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:21=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +/*
> > + * The enum atom_type is used as the coordinates of valid_atom entry.
>
> Usually we do not say "coordinates" when we talk about X of an array
> element A[X].  "... used as an index in the valid_atom[] array." perhaps.
>

Ok, use index instead of coordinates.

> > + * In the atom parsing stage, it will be passed to used_atom.atom_type
> > + * as the identifier of the atom type. We can judge the type of used_a=
tom
>
> You seem to like the verb "judge" (it was also seen in the proposed
> log message for 1/2) and tend to overuse it when we use other verbs;
> in this particular case, probably the right verb is to "check".
>

Yes, "judge" closer to my personal language expression, I will use "check".

> > @@ -965,14 +1017,15 @@ static void grab_common_values(struct atom_value=
 *val, int deref, struct expand_
> >
> >       for (i =3D 0; i < used_atom_cnt; i++) {
> >               const char *name =3D used_atom[i].name;
> > +             enum atom_type atom_type =3D used_atom[i].atom_type;
> >               struct atom_value *v =3D &val[i];
> >               if (!!deref !=3D (*name =3D=3D '*'))
> >                       continue;
> >               if (deref)
> >                       name++;
> > -             if (!strcmp(name, "objecttype"))
> > +             if (atom_type =3D=3D ATOM_OBJECTTYPE)
> >                       v->s =3D xstrdup(type_name(oi->type));
> > -             else if (starts_with(name, "objectsize")) {
> > +             else if (atom_type =3D=3D ATOM_OBJECTSIZE) {
> >                       if (used_atom[i].u.objectsize.option =3D=3D O_SIZ=
E_DISK) {
> >                               v->value =3D oi->disk_size;
> >                               v->s =3D xstrfmt("%"PRIuMAX, (uintmax_t)o=
i->disk_size);
>
> Replacing !strcmp() with comparison with ATOM_* like the above is
> the best solution for this step, but I wonder if this part (or any
> other part that this patch touches) would benefit from using a
> switch statement on atom_type.  Something to think about in the
> future, after the dust settles.
>
> Thanks.

Well, that's right, use switch can increase readability and maintainability=
.
This can be used as a future direction.

Thanks.
--
ZheNing Hu
