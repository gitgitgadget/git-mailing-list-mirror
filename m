Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA797C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949BD60ED5
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhHTP67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbhHTP67 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:58:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B8CC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:58:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h9so21196444ejs.4
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DhCjuItu0G40hrmpQN9AXpLrAiV1JOmtWy8Wb1Xy1hw=;
        b=hkMFw8mxG+II+hPKjMaCcY5OinecHMyyS2CtStpFQoNC61il4fsbS8knAvsxxHnnmC
         4A/SyM7Ew5WD7VKQ4cHfO0H8CzQh79ak1Rm3zALILLkBliLuD7IUkR/MV77ppoyWVePv
         V2N6w9S3BBg8ucf+Lvh0HkFKLPredNVNBbwZQSPHhp4o4mV8dzWvMAbOMICOSDRFNXEc
         96IlGWaaUZm5hbzj245lgG22bv26g1oXe79ikZwIF5IcJZ0UARAfa5GFtWxcWurBDdVx
         qUgtJVvCjC0/iZbGbA2lo+atLuvC9JP4xUkjBENcUpkPr4PW8+y9SqYsXlwWdjlm+CxU
         vFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DhCjuItu0G40hrmpQN9AXpLrAiV1JOmtWy8Wb1Xy1hw=;
        b=oLFhosL1XytNcHw2dajcSij74NhTDoY66ha6Gg/SAZ9BzUKRQgzfJbvCBo9vE0RXU9
         Z91MhecYoQk0z0zLRRSfXUp2YqeK2ZkMr3bSup2vmJY4Ykl/sGrCSoXa9ZvMaWFtn45z
         80tWn6Qs+6J8Dqh26qeYM9gp62/rGuJBOkaVsaGkwqPAQcmOTYa7MYFMvYokrVUIQ5+P
         E4OyW2fGiD1ocoj1/6+wua9DW007fbAAnP3IeWHeVp3cdQaQTNQBp7Zosj6w/McurUiG
         y7DSgUL2X5xbfYgX8unOXQt5H5uWgpaWDtFeEFG5TeAKY176Y3hF2xxQXxpZvvLaa/l0
         Y+qA==
X-Gm-Message-State: AOAM532J0OY5FYUSCKXl6A+zyzkVH1PL+nSSeth8gguR8vDQ4UfwWRrY
        vmERjQyoQutVdmA6DGwtgQ9pehJZY1wXVnYa03w=
X-Google-Smtp-Source: ABdhPJzwW1Lv0eI9JiA5oRTyRXS3PlKQpeTf+FcGz+ygResYHdSr6to6WRNuYqPVlGr5quR0G73Fn+YJMOqajxkkdWw=
X-Received: by 2002:a17:906:7d83:: with SMTP id v3mr22551998ejo.216.1629475099813;
 Fri, 20 Aug 2021 08:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
 <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
 <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
 <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com> <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com>
In-Reply-To: <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 20 Aug 2021 17:58:07 +0200
Message-ID: <CAP8UFD0aDrqHxNp2ztecmZR49gs=SVJTN1NUzJvz6+ewpY-_wA@mail.gmail.com>
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

On Wed, Aug 18, 2021 at 1:11 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:07=E5=86=99=E9=81=93=EF=BC=9A
> > I think the 'buf' is not freed in ref-filter logic.
> >
> > But one thing worth noting is:
> >
> > parse_object_buffer() may take this buffer away, and store it in
> > tree->buffer or use set_commit_buffer() to store it in commit_slab.
> >
> > So in theory, as long as we don=E2=80=99t use parse_object_buffer(), th=
is
> > dynamically allocated memory can be used freely for us. If we use
> > parse_object_buffer() and free the buffer, there seems to be a risk,
> > but it does not appear so far.
> >
>
> When parse_object_buffer() hints that we don=E2=80=99t free the buffer wh=
en
> eaten =3D=3D 1, I have a better idea, If the buffer is "eaten", we copy i=
t,
> otherwise we use the originally allocated space.
>
> -static void grab_sub_body_contents(struct atom_value *val, int deref,
> struct expand_data *data)
> +static void grab_sub_body_contents(struct atom_value *val, int deref,
> struct expand_data *data, int eaten)
>  {
>         int i;
>         const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NULL;
> @@ -1499,7 +1499,10 @@ static void grab_sub_body_contents(struct
> atom_value *val, int deref, struct exp
>                         unsigned long buf_size =3D data->size;
>
>                         if (atom->u.raw_data.option =3D=3D RAW_BARE) {
> -                               v->s =3D buf;
> +                               if (eaten)
> +                                       v->s =3D xmemdupz(buf, buf_size);

Can the 'buf' already be eaten at this point? I thought that it could
be eaten only through v->s so after this code.

> +                               else
> +                                       v->s =3D buf;
>                                 v->s_size =3D buf_size;
>                         } else if (atom->u.raw_data.option =3D=3D RAW_LEN=
GTH) {
>                                 v->s =3D xstrfmt_len(&v->s_size,
> "%"PRIuMAX, (uintmax_t)buf_size);
>
> As parse_object_buffer() does internally: the buffer of commit/tree objec=
ts
> needs to be copied, but blob/tag not. You said that the number of commits
> is generally significantly greater than the others. It seems that we cann=
ot
> make full use of this idea. But remember the "skip_parse_buffer" before?
> If we skip the parse_object_buffer(), this buffer is also "!eaten".
>
> In other words, those default paths of git cat-file --batch are included =
in it!
> So from the perspective of performance regression, this patch will be
> beneficial.

Yeah, it seems that we can benefit from something like this, but it'd
be nice if things were clarified a bit more.
