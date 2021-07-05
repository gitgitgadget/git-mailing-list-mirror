Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78ACC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5693613FC
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhGEODL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 10:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhGEODK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 10:03:10 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11C0C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 07:00:33 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id m12so1321104vst.8
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s1zAeUf9JMMDWv7blynrVY7RuCqmSg4E7Nivy9HOjms=;
        b=HTZypr+b51VD8ltVsNpnUeB3s2UCybVd/RgG6nLR0DmMrhClsV18k2nEaEqBwYi3y/
         FnBbW9UhQVhMGJ/iMBzTv364ThjR0jL9bzlNKltPF/0/8alR8mCcPR5BEzAV07BmqfOv
         Y/HJEeqk5gTf4ILc9isuCWpihYyZ13eHlTgKexWEkhWLmC8VXMjQFQsD8tcJIA3Gtim/
         IUhGLx653XWVD1qBSicGStzTvskO+5uvLVMiLwV8zgLuh9dAVpMyUyYjau+8ZqHLuZQg
         sBB5Y5qGU2OfkTttNtQm0idMMZFJzVJ21QzYV2vB18S0krgs+ndgPvX8Te/usnC+F/AL
         by4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s1zAeUf9JMMDWv7blynrVY7RuCqmSg4E7Nivy9HOjms=;
        b=SWz2oOdokhj6nGd9my+ui76tTrqP4ZkzBNjjy4mGtYg/SXiKoh2aBWp/Ozc6dFLBe4
         qHemsbv2XJMKMrXDyIqCkpsjBFEJuWmaRfahvGHFrzkPM5klP3g06btBIVWSIkxElfDC
         FknYi4CiGKamyXXDv9Jx3XC0rUnN1sFVRTb4lUXKyq3YN9noK5vr6uSHqTjgSztYr4OM
         ohz7Lkravzgdlnsv5xV+Iuy5IYloMmv7G96kz6luBoNPCL4YPXx4Jqff+FqdP7TnE+6s
         Te1S7AR7iLNFlR7aYAeeVAifB8aDkxw5zBy6LtRtUpdCrgMbvEx2alkjR3awr0B0u0r6
         xKSA==
X-Gm-Message-State: AOAM530Ng5QWNd8Qz1ljf3MbWyRz/EUCdoOnt549vo1Da7qqVqffqWlQ
        kFzyRrjsjSrJolg9VMqHXChTWEUedqQtjK+isIOU4w==
X-Google-Smtp-Source: ABdhPJzIpaXIdE2pmySUIjDkU5UQWPu6SAx8U5a7Jxz2X30AhwvQ3ICgSytvVyNeje7OfgBPiP0v5Dd1Etp2SiOMZOM=
X-Received: by 2002:a05:6102:949:: with SMTP id a9mr9123384vsi.54.1625493632536;
 Mon, 05 Jul 2021 07:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <patch-8.8-9fd6138aa62-20210628T191634Z-avarab@gmail.com>
In-Reply-To: <patch-8.8-9fd6138aa62-20210628T191634Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 5 Jul 2021 16:00:20 +0200
Message-ID: <CAFQ2z_MmpisHcYqXd0=V8NCNxxsXn=MijX747V_oxnMV1bBFaA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] upload-pack.c: convert to new serve.c "startup"
 config cb
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 9:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Convert the config reading code in upload-pack.c to use the new
> "startup_config" callback when we're using the v2 protocol, and
> lightly fake up the same when we're using v0 and v1.


I'm not a fan creating more global variables rather, but I'll it leave
to someone else to decide what's best. This change looks consistent
with its predecessor, and OK modulo a few nits below.

> Thus it's clear that the "allow_uor" passed to functions like
> "is_our_ref()" is constant after startup (usually it'll never change
> for a given server's configuration, or change once).
>
> This requires a very light compatibly layer with the serve.c callback

typo.

> +/*
> + * "Global" configuration that won't be affected by the type of
> + * request we're doing, or by other request data in "struct
> + * upload_pack_data" below.
> + */
> +static int v1_have_startup_config;
> +static int config_keepalive =3D 5;

could this include a unit? config_keepalive_secs , I think?

> +       int ret;
> +       ret =3D upload_pack_startup_config(var, value, data);
> +       if (ret)
> +               return ret;
> +       ret =3D upload_pack_startup_config_v2_only(var, value, data);
> +       if (ret)
> +               return ret;

Neither of these config readers ever return -1. Do you foresee this
ever happening? Or could this return void?

> +       if (!v1_have_startup_config++)
> +               git_config(upload_pack_startup_config, NULL);

See comment in previous patch about ++ for boolean values.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
