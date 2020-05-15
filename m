Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E551C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E272A206D8
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeZkHa1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgEOSyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOSyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:54:00 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE0C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 11:54:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id x5so3858956ioh.6
        for <git@vger.kernel.org>; Fri, 15 May 2020 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6pngOq5LX6j9jId+sT2mvTtAPPAqUOG9GeAhQzN7t2Q=;
        b=VeZkHa1Luv6J4eRsF5GtEFXfDVy9HE7JfkibmPd0TdRMKOFWhMUEt1EdCdV/FYLEv/
         TBqbvtAAJGZEAF8gy3cI3uUwXBWfN7Cu/QYb4Peq8H/itXa2CZ9JVInrmoTZiK7FlSL2
         p2zMSdEDlzK7+1Pz2vMCgVDdQsSi1MXu7lmYrTjaL3wa11fRDKYys1/TkKeE1lLN+V+r
         4GV+UsHDv8OEG0cmJOVxAcuN/xG2bgLl8Noe3thrIQ6pysqgITWlp7nLvQuIOna9uDC4
         lOsnWT7DHnmrNuu5dB4E4Dlia3TYP0RaM4plvO3PM/SFMA2xbkx/+VPBHoxnulNYKJvS
         ToqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6pngOq5LX6j9jId+sT2mvTtAPPAqUOG9GeAhQzN7t2Q=;
        b=VT9hTTkOKq/v/JJLq4nqkAn4w9n9b7XoAWcBks6FlR/PdRkaVOdcL3is6TvdXIpedj
         kibjy/H0BJ4hOmsIjNK21qLVpvF5heSswHSguxOW+j25GJMAm1Ul6vZBJsAim7xE7Lgm
         n+zCWze6SrwkIubQv+SCyQR78Is7vb+Oc2A3W9PPNOHbrgDNLC3J/jERKdBt+5uDKcD5
         Vu/MYGwgmX2YkS5jKgI2A21kJ/hElpFanW6yiv7G8SKnBxCdwGsUh/KmL2gqq1uEmRLM
         6IX4I9Q29Rs4zqRy5BqOdA6Wc9u7IJ0+K/ArGCm8micku1rchrJJ2yX+Ei0+qNFbr/bO
         qLag==
X-Gm-Message-State: AOAM5310HDP+w0b39/j6fpF6hfK5vdCUTsff+q0eeP2FLIlBsiGQtjdz
        6cK6dogQpCQQfqkXp7bGeEbTN5KQngJF1jFGORM=
X-Google-Smtp-Source: ABdhPJy1JD7b7YKpWK7rHdRGGUEGPiVvnPIEGqt8kcAaaK47VyacfGplES6qYik+lrSZfjCOMgMFf7L7tBLu7+4BjRo=
X-Received: by 2002:a6b:5b05:: with SMTP id v5mr4296484ioh.37.1589568839996;
 Fri, 15 May 2020 11:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <20200510164424.GA11784@konoha> <CAOEXN9yyL8T8kDmpHKTjjaG9tVS1kh34B-=PuH1hRaA7jF_K6A@mail.gmail.com>
 <20200512141520.GA8133@konoha> <b45268b1-de5f-051c-f956-8a17c067f4c6@gmail.com>
 <xmqq7dxdm8qi.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dxdm8qi.fsf@gitster.c.googlers.com>
From:   Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Date:   Fri, 15 May 2020 20:53:51 +0200
Message-ID: <CAOEXN9yjd6r54K=5_Mdqr+cGJJ-ngaerfdbfD2m6RVZys-QmVQ@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Git List <git@vger.kernel.org>, christian.couder@gmail.com,
        liu.denton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le ven. 15 mai 2020 =C3=A0 19:03, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>
> Guillaume Galeazzi <guillaume.galeazzi@gmail.com> writes:
>
> > Goal here was to avoid magic number, but after looking to the code it
> > seem accepted that true is 1 and false is 0. To comply with that, in
> > next version it will be replace it with:
> >
> >       if (FOREACH_BOOL_FILTER_NOT_SET !=3D info->active_only) {
>
> It still is unusual to have a constant on the left hand side of the
> "!=3D" or "=3D=3D" operator, though.  Having a constant on the left hand
> side of "<" and "<=3D" is justifiable, but not for "!=3D" and "=3D=3D".

It is call Yoda condition. As it compare with a constant, the compiler
will throw an error if you write only =3D instead of !=3D or =3D=3D.

But after a quick check, this wasn't needed as compiler warn
    builtin/submodule--helper.c:570:2: error: suggest parentheses
around assignment used as truth value [-Werror=3Dparentheses]

And I am not a Yoda condition adept at all. So it will be removed.
