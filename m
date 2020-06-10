Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ACBC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 19:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD4A2072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 19:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZ3htrNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFJTE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgFJTE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 15:04:26 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D1DC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 12:04:26 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id m25so1920066vsp.8
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qHRm0mFLmD0ao6Kr2Judw4nZg6XbyHvxJH0pQ5rNy1k=;
        b=pZ3htrNELNqi21G45CYXjIa9GJ19omjBkkw7db2piCp4IBDY4QbipsEtbmdEXsbVz+
         mUOy0KryOCiCAiaM4s/HQKt+NikXRX9VOZnuTmWNjhgSEN/NPvtGcGzHUfBaGobtSrI+
         PyIIsO3Vtt6gVOqjbrzRs3ZScJ+6nNCPUoOq0+S54uk4+dvQaIQleH6Bevk7fJViR7YN
         yZrdlJb+Ih+B0jOXE64ZcBzdREBq3hXQqJYh7b/3SlGzwbNqkjlbKhtRxcIzVVGzreUf
         Mcn0TePg5e70F9Ee++Z4GFgD4taWT0sNL5QtEQUi7FWCxt4mFVExjupkoR3MF/1Of0iT
         DHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qHRm0mFLmD0ao6Kr2Judw4nZg6XbyHvxJH0pQ5rNy1k=;
        b=SdX+JdfgHh89vkBJ2WMMsUXb1HUcQdwfyTjfbNZIMRVI6yiCWv7Vc/LA6ID2E3rSns
         dcmj5UhP1C3K1w8GE/Xue044LG4L4TliC2KX8/c6tdAgS27yd/5NJFpw8tHq5blmGV99
         Uw25jnJ7Mba9tSEDpGKOZE1LVt4ARtf/4yiwSOWw0FPZ8TEwuaTZKQQ9oIRt5lGcTdr1
         7QgQpXj7umR4IfWCi9madvztcUXjlRIg6UO5o+v6aRbiB+JlE56xKVMwszBozLIAfWDB
         cn5E2usnQfRKVTMM8sSg3aEWBum5Q0EmmI9+wxw8qZWKjZ8SWhNXuehr2+0AnzrcEtkq
         vd5g==
X-Gm-Message-State: AOAM53299zOUBT07upN0vqncwQ8mzd89+XHfqigNuug0KnOcaa79lgNK
        6eVv4l7LtBfzHZTHdNk7xLT+iCpzYmiiB0+CDkf8OA==
X-Google-Smtp-Source: ABdhPJw2u//jLev2zHh/0ywiSnPIzxiH1L4wWYezo2xwQdHG9/uBsaReMrgn8L+PcCaEf2cb7K49VKQdp54T0P/dp/I=
X-Received: by 2002:a67:3211:: with SMTP id y17mr4205949vsy.56.1591815865650;
 Wed, 10 Jun 2020 12:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
 <pull.539.v16.git.1591380199.gitgitgadget@gmail.com> <xmqq7dwfhlwt.fsf@gitster.c.googlers.com>
 <CAOw_e7ZzEyb+21QHcNGcj5A8N501-a5fF3HNL0Jq6uD8S37G6A@mail.gmail.com>
 <xmqqimfyg84j.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006102056530.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2006102056530.56@tvgsbejvaqbjf.bet>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 10 Jun 2020 21:04:13 +0200
Message-ID: <CAFQ2z_M5ffb1O4R1wMxMH7qxDog+pZwDJX1Nd_ujBr+_nChupg@mail.gmail.com>
Subject: Re: [PATCH v16 00/14] Reftable support git-core
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 8:59 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> > I am reasonably sure we use opendir() to iterate over existing files
> > and subdirectories in a directory (e.g. in the codepaths to
> > enumerate loose object files in .git/objects/??/ directories).
> >
> > I do not offhand know we also use fdopendir() elsewhere.  I strongly
> > suspect we do not.  Perhaps some platforms do POSIX.1-2001 but not
> > ready for POSIX.1-2008 or something silly like that?
>
> We don't. We also do not use `unlinkat()`. And we generally use
> `remove_dir_recursively()` instead of implementing a separate version of
> it that only handles one directory level ;-)
>
> This is what I needed in Git for Windows' `shears/pu` branch to make it
> compile again:

Thanks Dscho. Last time I folded a fix into
github.com/google/reftable, you seemed quite upset. How should I
proceed with this fixup?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
