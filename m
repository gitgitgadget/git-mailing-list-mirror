Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4411C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 13:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C39C20770
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 13:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRmvLIJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgLANft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 08:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgLANft (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 08:35:49 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588E6C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 05:35:09 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id a4so420251vko.11
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 05:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GkwiFIgaG9yzUtNv0iCHL76DcRLfMT7i1GSc42s+Mtg=;
        b=ZRmvLIJJ5kqdN3oGjyxW4eT5RaVH/UVgbcCfY+1Kydi0GmYNlyV7dIsmbxK9cGesnx
         D0yR0ESMEm7gxE9SVCfUQLb0iaKBNVoZTXz2dTm+hc3Wsxyuv/1bqJECJma0fR/+TEsX
         gSeT3EfxGckEuiBUhAuC0t2VHD4EdV+0yJESUivimXW9k8whU/dSii4Q8+xvka/dgDGK
         ZzK4pisRMIx/RoaRB/2i0VHLkePeA9pi0cFeoYqHh+oQOGt4VylITECS8/hBhM8+nbZu
         g5VKuTHbKyU0JCmGuO555T29dWZnzRMm7tGgjqV9dwCqOFj5kRFw2OjFsrJsok5EoXDu
         Mwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GkwiFIgaG9yzUtNv0iCHL76DcRLfMT7i1GSc42s+Mtg=;
        b=WLASahZf3hsiKgKwxi2r3UgdMqzIIgSv8r4N8p8quwZgKB/7o745Cdn8l8gIiqsriH
         zN9mYZx1tyeWXq6o7oJRPXW4fl5Mo7W9FdPUUBobjypPCRZDKewzFQT9irj+1uO7HSEZ
         Djr+gn5OTHEVjiq6ZFFOtm2zQXMBp28b1ruFEi6J6cMWqOnycHJcBE+0JYcKemv6P/qT
         u8IRnBRY1x5dEK1XtShm6VbaCixlB9bofNmFJuA9gd4g4AsbM7cgTQQouAs6kPph8hNq
         KvSLCSxJ9lXsaWwBRYaH6SFdAdLwZQEYyFxF2P+IN1swbUqtJlkCJz0QoU+a3lVMyj48
         V9bg==
X-Gm-Message-State: AOAM532LLCtsR94Zno68IG63AL2C+bCBGN8mF2FkjFhQ6w5qD3yi1SEj
        PgoB+qj/8FZvCaKJda0oniG3KT/UrI1GWWOalVnXsQ==
X-Google-Smtp-Source: ABdhPJzcvxJTCPKlsJBAwLsEZgC2GMSq9F9Unmf+VJ6a8IOZ0jCBvQ86LAtaErEEqxaM5fL1w87UyUbGiXzx3rxpnPo=
X-Received: by 2002:a1f:2717:: with SMTP id n23mr873937vkn.25.1606829708308;
 Tue, 01 Dec 2020 05:35:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
 <87lfennln8.fsf@evledraar.gmail.com> <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
 <CAFQ2z_MXF0wO76tVTcBuJJp0CwjVoVfE11BOYYQ7Y7h1h_VwJg@mail.gmail.com>
 <CAMP44s0zoekLZYQ=r516jjdsGGQ2Y7m1fXpwW2BBJsGjQ5sseA@mail.gmail.com>
 <CAFQ2z_PaPdiJC71WGdePFVgxyJFFHZY_DFbmLg9sRFm=vc7XYw@mail.gmail.com>
 <CAMP44s0v92C+uUwoeBJxRv2MPCd2RuCPn8FVBUztNM9VOdjJgA@mail.gmail.com> <87wny1vjg0.fsf@evledraar.gmail.com>
In-Reply-To: <87wny1vjg0.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 1 Dec 2020 14:34:57 +0100
Message-ID: <CAFQ2z_OJQf3+b0TT6BmAV9q9G9c2icbLK0EqrEjpYmpi8g9Fsg@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] reftable: add LICENSE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 12:45 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Dec 01 2020, Felipe Contreras wrote:
>
> > On Tue, Dec 1, 2020 at 3:51 AM Han-Wen Nienhuys <hanwen@google.com> wro=
te:
> >> On Mon, Nov 30, 2020 at 10:21 PM Felipe Contreras
> >> <felipe.contreras@gmail.com> wrote:
> >> > On Mon, Nov 30, 2020 at 2:28 PM Han-Wen Nienhuys <hanwen@google.com>=
 wrote:
> >
> >> > Sounds to me Google has not made its mind about actually contributin=
g
> >> > these changes.
> >> >
> >> > Or am I missing something?
> >>
> >> The restrictions are not about the patches themselves. They are about
> >> restricting what gets posted under github.com/google/ .
> >
> > I see.
> >
> > But it doesn't have to be posted on github.com/google/, it doesn't
> > have to be posted on github.com at all. If the code is under an open
> > source license, you (or anyone) can post it anywhere.

I am also bound by my employment contract to follow company
instructions. While you (Felipe) can post code where you want, the
same is not true for me.

> The libgit2.git and git.git codebases are under different
> licenses. Therefore if the goal is to have code that's used in both it's
> not viable to e.g. store it in git.git under our current contribution
> policies.
> [..]

Thanks for sketching the dilemmas here. Me and Jun are talking to the
open source folks here at Google, so I am optimistic that we will find
some solution. Please give us a few days to sort this out.

> The first contributor to submit a fix to it under GPLv2 as opposed to
> "any GPL or LGPL version" or whatever will preclude its subsequent
> import into libgit2.
>
> Assigning copyright to Google is a way around that. They own your work,
> and then they re-license it under whatever license those two projects
> use.
>
> But as I pointed out in [1] it requires contributors to git.git's
> reftable/ directory & Junio to play along with that scheme, least the
> whole process come to a halt. Maybe that's worth it, maybe not. But
> seems like something the series should very explicitly highlight and
> document e.g. in Documentation/SubmittingPatches.

FWIW, the plan of record is still for this code to have its source of
truth in the Git project. Once it's there, there is no need for Google
to have CLAs for contributions to the reftable/ directory.

There is still the open question of how to set the license terms for
this code, so it is OK for it to be copied into libgit2. I picked the
current license (BSD) because it was the most liberal I could find.
(Maybe I should document that in the commit message.)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
