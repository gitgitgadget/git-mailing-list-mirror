Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE73AC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 13:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E29613CC
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 13:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhGONzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhGONzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 09:55:43 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E51BC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 06:52:50 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id v26so6517703iom.11
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=npuNrieDsXcaTs3YjjnJ7LPn/HsDYD0AWrlunVhs6ls=;
        b=tLQhoxqZ2k6lq15RbaNudRodbp4+SVQubk2SEnEe8ht1fheQMNdQBrtIpn3B+07Lnw
         f57OA2FuovS8W3rUgbwEiIaR4ENwvGVFCoQihTLozno7rkdlpTkLhO/NRgLO6tYmiAMJ
         +KUrwFhB9jRQBACschqejHrtzyfSgDUSkapwf907ojdxYfKwRFx24GJ+pAFMgBbXSHtA
         h24AzpVIvasfDYOjB0V8dQi2DC5DWujVxJ9y2CKAvn1YnRvMHvHC28UqJ1Fssrbwce1B
         Wo61MO16nM/h9ruLPYTqNetn4v924NCcdzdDWf9VLi7naZu90U/Fg4aWm6u5LyDhEk2e
         EFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=npuNrieDsXcaTs3YjjnJ7LPn/HsDYD0AWrlunVhs6ls=;
        b=gD+8qy+KG2gC5L6aEeWGYXso8tHo0u1/+S+F/6EKtu2cujrg/aJcIzahMCy/zioXD/
         ZTEoy2a0JwXcBMxt0BqE5NWlbthxZdImmoK2XDORgwUEqDzGY1bumfk7MkpyGLkdUUli
         DNYuxK+k+OZMaBtxEFiW3xEcBHKkMqCDGTu/52h5p06WI2W57HXgv2Ok1q7dA8I3YWXl
         Fbu+DvpnS9xv6VzU5RF1zIObWNEjIla4HoRO2c4AdReoOF0xA1jlLqWnj1oGH3O4ja3y
         USOq+IVCQG2UreeGZzxXtPLqR88JEZ6OvG52oYkuoBvErfrnVVWFqhmqGyUcdQ4giZGd
         pAaA==
X-Gm-Message-State: AOAM531Af5to6qPkETbezAHv4J9moGajwWBYhEbZGag1vf3Xq1dU6yJa
        6zsfemj7MWs4EkUhybHNicfaqcWnEZ241Hco8F8=
X-Google-Smtp-Source: ABdhPJzwKxnR6yY5aDwTHH9e6I/TQvzaUwZ/1WL/QdhX/TiH8zrnzsWNhrXKT5qlOJpmcxtt4zdpgvx0m4opudb7N5o=
X-Received: by 2002:a5e:df08:: with SMTP id f8mr3300268ioq.172.1626357169988;
 Thu, 15 Jul 2021 06:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
 <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
 <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
 <xmqqtukz2rp4.fsf@gitster.g> <CAOLTT8RR4+tUuT2yc2PDL9NwCburW8bM_Sht6nhKJ_fYV8fGsQ@mail.gmail.com>
 <CAOLTT8Sa984Eo18QMBeGnMCX3_7sr+9qUYoAR4FS3UF6+CDtGw@mail.gmail.com> <CAP8UFD24X7UjXGKsRWr+f_xmX0x4EVDJHLBs2c1KhECb8-BnBw@mail.gmail.com>
In-Reply-To: <CAP8UFD24X7UjXGKsRWr+f_xmX0x4EVDJHLBs2c1KhECb8-BnBw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 15 Jul 2021 21:53:04 +0800
Message-ID: <CAOLTT8Qj_zAhPEzKxJ2dGg8O3R_b8Sn05G29VE5WJhymR4EQSg@mail.gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8815=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:45=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Thu, Jul 15, 2021 at 3:53 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8815=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:24=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:38=E5=86=99=E9=81=93=EF=BC=
=9A
>
> > > > I find it somewhat alarming if we are talking about "fast-path"
> > > > workaround before understanding why we are seeing slowdown in the
> > > > first place.
> > >
> > > There is no complete conclusion yet, but I try to use time and hyperf=
ine test
> > > for these commits (t/perf/* is not accurate enough):
> > >
> > > ---------------------------------------------------------------------=
-------------------------------------------------------
> > > |                        subject                                  |
> > > --batch-check (using hyperfine) |   --batch(using time) |
> > > ---------------------------------------------------------------------=
-------------------------------------------------------
> > > |[GSOC] cat-file: use fast path when using default_format         |
> > >         700ms                |          25.450s      |
> > > ---------------------------------------------------------------------=
-------------------------------------------------------
> > > |[GSOC] cat-file: re-implement --textconv, --filters options      |
> > >         790ms                |          29.933s      |
> > > ---------------------------------------------------------------------=
-------------------------------------------------------
> > > |[GSOC] cat-file: reuse err buf in batch_object_write()           |
> > >         770ms                |          29.153s      |
> > > ---------------------------------------------------------------------=
-------------------------------------------------------
> > > |[GSOC] cat-file: reuse ref-filter logic                          |
> > >         780ms                |          29.412s      |
> > > ---------------------------------------------------------------------=
-------------------------------------------------------
> > > |The third batch (upstream/master)                                |
> > >         640ms                |          26.025s      |
> > > ---------------------------------------------------------------------=
-------------------------------------------------------
> > >
> > > I think we their cost is indeed from "[GSOC] cat-file: reuse ref-filt=
er logic".
> > > But what causes the loss of performance needs further analysis.
> >
> > Now I think:
> > There are three main reasons why the performance of cat-file --batch
> > deteriorates after refactor.
> >
> > 1. Too many copies are used in ref-filter and we cannot avoid these cop=
ies
> > easily because ref-filter needs these copied data to implement atoms %(=
if),
> > %(else), %(end)... and the --sort option. The original cat-file
> > --batch only needs
> > to output the data to the final string. Its copy times are relatively s=
mall.
>
> Is it possible to check early if any of the atoms that needs these
> copied data is specified, and if none of them is specified then to
> avoid the copies?
>

Well, The copy I'm talking about here refers to something like "v->s =3D
xstrdup(xxx)";
but v->s is need by --sort, so it is very difficult to remove. At the
moment I think the
only solution is the fast path mentioned by =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason.

> > 2. More complex data structure and parsing process are used in ref-filt=
er.
> > This is why it can provide more and more useful atoms. Therefore, I thi=
nk the
> > performance degradation that occurs here is normal.
>
> Are there way the more complex parsing could be avoided if it's not
> needed by the atoms that are actually used?

No. For example, we can only support "objectsize" before and now we can
support "objectsize:short", so we need to pay more parsing process here.
(It's necessary)

>
> > 3. As =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason mentioned, oid_object_info=
_extend() was used
> > twice in get_object() before. oid_object_info_extend() is the hot
> > path, we should
> > try to avoid calling it, So in last version of  "[GSOC] cat-file:
> > re-implement --textconv,
> > --filters options", I make the unified processing of --textconv and
> > --filter avoid calling
> > oid_object_info_extend() twice.
>
> Ok, thanks for the details and your work on this performance issue!
>
> I wonder if your patch series could be split, so that the early parts
> that add new atoms to ref-filter could be merged sooner?
>

Should this part of the work be handed over to Junio?
The implementation of %(rest) and %(raw)  may be worth merging,
they are truly "zh/ref-filter-raw-data".
The other part may be called "cat-file-reuse-ref-filter-logic".

> Best,
> Christian.

Thanks.
--
ZheNing Hu
