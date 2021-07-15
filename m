Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668D6C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41193613B5
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbhGOJst (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhGOJst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 05:48:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17195C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:45:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hc15so8284098ejc.4
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rf/6rSobOOGFjiPQD9d3L94tzEzgMvPKBlpXlCs/Asc=;
        b=MMTfqhSBJYxcu/+l6Ae98W9SETGL+bMvxPSf+rKnwPHCNPLu51x2YOhaYOIfaMR0Rl
         B1BKbVDMVSR6UJJeK/9tj2U6TdFjR2nqJFoTlic5IsQlNinlBZUuEfbXQN5vKm54rQO0
         wAGetR+5Ce54f9fxUvnn8Yej+9PHW10EZYPhs3/NTGwAK2WCLdsY8J+Hs/cm0cLkkGW9
         iccB5v9KktEw0yL+/kKwoBsb3zwfwL+xk3yzyx+kNqS1tqwdmfXTdZgTegWkI2rMMnNq
         KU/LhLOmVu8kTCk50ssIq3fnBkIc5DxA0IdSUVtL4tPGAwfnfQ+Aww2YhRqGxN3NCXuW
         wo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rf/6rSobOOGFjiPQD9d3L94tzEzgMvPKBlpXlCs/Asc=;
        b=Ul2IhqbmZYKrSBY5QU0hyrE3KFNWOkdIKR8d8TVAigNCpxbuUnQXY1yGZCAPyelSwp
         3I80tAH891Y6He/kWfTjWQ4zfhKtkF97Ibuy7hgznlCSCMCxd9pgGWZ+LGLbZHfLIUKu
         JS1YGYSRSmn5FIGaCokwBF5uWdG4POwXQN21cqpxyuR0qeibQvkQ4550Y9pCORkcmgZC
         1skAKXjoH6NMYF3HBR0A+/muUy2+DsPqVyw+E30zER4mstSewFw7qFzeA6AviLPFaVBU
         y/0M9VnlSYFcfjrSFjKtnNTfPGHj8Uo+gK40yjQen+Vmu1RTCWUwlE5JqV6SzL8OqGBW
         DzNA==
X-Gm-Message-State: AOAM531n6cw3gLsFVnob+ddUSxKymPsKIh6DC9VdTGkC20JHzjvE07Z6
        U2KqHbgQzsFPnnheWXhtRrdq01W0+SF3LlDOqxM=
X-Google-Smtp-Source: ABdhPJzQsLOmv71AKkKZkUX3moOLYvAqYCnYnUHwg8IGOioAvS7TC3fBOP3wD9hDxaFdiDqwVi4nuwdyCx3Zpa6xVDo=
X-Received: by 2002:a17:906:b18d:: with SMTP id w13mr4582060ejy.341.1626342353727;
 Thu, 15 Jul 2021 02:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
 <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
 <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
 <xmqqtukz2rp4.fsf@gitster.g> <CAOLTT8RR4+tUuT2yc2PDL9NwCburW8bM_Sht6nhKJ_fYV8fGsQ@mail.gmail.com>
 <CAOLTT8Sa984Eo18QMBeGnMCX3_7sr+9qUYoAR4FS3UF6+CDtGw@mail.gmail.com>
In-Reply-To: <CAOLTT8Sa984Eo18QMBeGnMCX3_7sr+9qUYoAR4FS3UF6+CDtGw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 15 Jul 2021 11:45:42 +0200
Message-ID: <CAP8UFD24X7UjXGKsRWr+f_xmX0x4EVDJHLBs2c1KhECb8-BnBw@mail.gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
To:     ZheNing Hu <adlternative@gmail.com>
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

On Thu, Jul 15, 2021 at 3:53 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8815=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:24=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:38=E5=86=99=E9=81=93=EF=BC=
=9A

> > > I find it somewhat alarming if we are talking about "fast-path"
> > > workaround before understanding why we are seeing slowdown in the
> > > first place.
> >
> > There is no complete conclusion yet, but I try to use time and hyperfin=
e test
> > for these commits (t/perf/* is not accurate enough):
> >
> > -----------------------------------------------------------------------=
-----------------------------------------------------
> > |                        subject                                  |
> > --batch-check (using hyperfine) |   --batch(using time) |
> > -----------------------------------------------------------------------=
-----------------------------------------------------
> > |[GSOC] cat-file: use fast path when using default_format         |
> >         700ms                |          25.450s      |
> > -----------------------------------------------------------------------=
-----------------------------------------------------
> > |[GSOC] cat-file: re-implement --textconv, --filters options      |
> >         790ms                |          29.933s      |
> > -----------------------------------------------------------------------=
-----------------------------------------------------
> > |[GSOC] cat-file: reuse err buf in batch_object_write()           |
> >         770ms                |          29.153s      |
> > -----------------------------------------------------------------------=
-----------------------------------------------------
> > |[GSOC] cat-file: reuse ref-filter logic                          |
> >         780ms                |          29.412s      |
> > -----------------------------------------------------------------------=
-----------------------------------------------------
> > |The third batch (upstream/master)                                |
> >         640ms                |          26.025s      |
> > -----------------------------------------------------------------------=
-----------------------------------------------------
> >
> > I think we their cost is indeed from "[GSOC] cat-file: reuse ref-filter=
 logic".
> > But what causes the loss of performance needs further analysis.
>
> Now I think:
> There are three main reasons why the performance of cat-file --batch
> deteriorates after refactor.
>
> 1. Too many copies are used in ref-filter and we cannot avoid these copie=
s
> easily because ref-filter needs these copied data to implement atoms %(if=
),
> %(else), %(end)... and the --sort option. The original cat-file
> --batch only needs
> to output the data to the final string. Its copy times are relatively sma=
ll.

Is it possible to check early if any of the atoms that needs these
copied data is specified, and if none of them is specified then to
avoid the copies?

> 2. More complex data structure and parsing process are used in ref-filter=
.
> This is why it can provide more and more useful atoms. Therefore, I think=
 the
> performance degradation that occurs here is normal.

Are there way the more complex parsing could be avoided if it's not
needed by the atoms that are actually used?

> 3. As =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason mentioned, oid_object_info_e=
xtend() was used
> twice in get_object() before. oid_object_info_extend() is the hot
> path, we should
> try to avoid calling it, So in last version of  "[GSOC] cat-file:
> re-implement --textconv,
> --filters options", I make the unified processing of --textconv and
> --filter avoid calling
> oid_object_info_extend() twice.

Ok, thanks for the details and your work on this performance issue!

I wonder if your patch series could be split, so that the early parts
that add new atoms to ref-filter could be merged sooner?

Best,
Christian.
