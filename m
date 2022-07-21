Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FDFC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 14:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiGUO6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiGUO57 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 10:57:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4BF85D6C
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:57:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ez10so3545648ejc.13
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3GRE1fA7113dcdmR1jqTl/IAct4LzSAh1bMuxk+znM4=;
        b=SJuSsUVo9wO/EzM+8RyY0/+obMpDIaC1GkZkEXLSLnEUb51wB5KAiYnuaP5Oiy3SDN
         sRRo8dGC2ncRaOQZo80Ds7LcLEW/jJqxDoatgEjQgpF5NglBrAW9t5yRiqfi+drEY5Ff
         8ZMimW4m6bgxpQhsWUai2zj7M5o38ZuqTA0TALSar7JJ5Hoa4Bq//r6IEcBlAaBlOyE4
         xRQftU6+owBgr3NSAiP3kd+spEOZhZR8D2dZxH+MUnzzzwqjd+j8ikfkECtcPTD5HlgT
         7x9KpJmEuFhPuznCdCtMyuAvI3FcqjyvX3vilDLRsJHPRWfdGzWZBtD8Ce0OAbUtG+AV
         3gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3GRE1fA7113dcdmR1jqTl/IAct4LzSAh1bMuxk+znM4=;
        b=olF2QfM65mkq2+ul7CcZAm3o1v2twjXn9a99P7NU8TsMXPraZlEOwkOnLGt6nHKkes
         LR33L97otY/6rOYByFcoYYM/dt8vXpffjXRepDL3vP1YqnvtUyhaHOD4RPUWUwY+w8dr
         DSCZvbsbY/JQLvKU0Lvj9Q9KlR86++GWQfFqN1H76c0FzCVQNVoEBw7+blZGMGGTCXlf
         j8vMSnpXas38fYnDFK1iWl4uvdt8rad9HmD6CVPmO/kuLMkeqlk6kY4vWKqO+50KTHBl
         /HumsgZMHiE1F0ddIW9lk9rcWbASPK+WuuJUeX/ZBr28Mx6jtV/hIoUwRJv+TBlqVBkD
         D1kA==
X-Gm-Message-State: AJIora/f/waUBGxB/s/xmijquis1T8EjNDFoz8TAdMVGM7MtXmDaPrOh
        Fz/tsBhGFSgv3qmspP0nE+ojpLMYQUJh/NALdHZ5bXi5KYVxBA==
X-Google-Smtp-Source: AGRyM1s/LvpNExL2sC9bJel+Pf7Akmf403oXgSb4LezJ4ppYW0TmDJwG3DllCh4sLQ1Dnz0KxN3qr9aFJlhb/hn7BhQ=
X-Received: by 2002:a17:906:8a79:b0:72b:871a:57b7 with SMTP id
 hy25-20020a1709068a7900b0072b871a57b7mr39194800ejc.602.1658415474547; Thu, 21
 Jul 2022 07:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <CAPOJW5yJDq046nhq0V-syAg4ttoy++rBtq_RHSXPAKhtDDw6jQ@mail.gmail.com>
 <xmqq7d47m1t2.fsf@gitster.g> <304fd857-db62-7a1a-a9a9-cbfa93c2a00c@github.com>
 <220721.86r12etvly.gmgdl@evledraar.gmail.com>
In-Reply-To: <220721.86r12etvly.gmgdl@evledraar.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Thu, 21 Jul 2022 20:27:43 +0530
Message-ID: <CAPOJW5zA1FnLDWXgRza3WLCHK0ER7ZUkdyq-kcPm4-TsW9U2nA@mail.gmail.com>
Subject: Re: Can I use CRoaring library in Git?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 7:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> It's great that the primary author of the library wants to release it
> under a compatible license.
>
> But I feel like I'm missing something here, don't we still need the
> other contributors to that code to sign off on such a license change,
> and for us to be comfortable with integrating such code?

As far as I see their commits, they don't use sign-off in any of their comm=
its.
I know what you want to mean but the license text uses "The CRoaring
authors" rather than "Daniel Lemire". Below is the text -

    /*
    * MIT License
    *
    * Copyright 2016-2022 The CRoaring authors
   *
   * Permission is hereby granted, free of charge, to any
   * person obtaining a copy of this software and associated
     ...
   */

So, isn't it enough for us?

> My understanding (again, not a lawyer and all that) is that such
> transitions happen one of a few ways:
>
>  A. One entity had been assigned copyright in the first place, and can
>     re-license the work. E.g. the FSF requiring copyright assignments
>     for anything non-trivial.
>
>  B. The license itself has an "upgrade" clause (e.g. GPLv2 "or later"
>     projects being GPLv3 compatible).
>
>  C. All copyright holders (or near enough) agree to
>     relicense. E.g. OpenStreetMap went through this process at some
>     point.

I got your point here. I am sure that "All copyright holders" have no
problem with this relicensing.

Daniel already said in his comment[1] that they do not have any problem wit=
h it.

[1] https://groups.google.com/g/roaring-bitmaps/c/0d7KoA79k3A/m/t8e09-wPAgA=
J

Thanks :)
