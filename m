Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E925DC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 14:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbiBCOY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbiBCOYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 09:24:25 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0E0C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 06:24:25 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id c36so5382558uae.13
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 06:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EoZFUw4kKgoiBAnF0D7/YS7qFwEScZ9p+g7ZUkw64yY=;
        b=J02IH6c8fBYX1fxsh5TbEdm5RnV7XQV/H6SVNkBfzA5MiV0LBBEFEE9V4PEMQD5UDK
         85vJy69hVG43AKv50y6ff7UQV9A3LSp9iBwRNIk9Oqeb62A5khK+1mg8Uet/4p7zieVB
         5BsG1tc+6LvK7XnFNUoegVRtkBcUKNNM0dzGh2hbLaUmCvz9ufnNfDMmvM3u2ncReXhk
         /duLlfb4YGcPq0cJ0sQoVRS24lvMVpyuqJayMRJw5SceA57rd8D4cENB4TNQYgeag2Yo
         hg+MnXN7gEbKvhSmvWK1WDwkELUKFoltjA47MgNQFmT2d5n0xNm51znyIjm8gJLLgfls
         2fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EoZFUw4kKgoiBAnF0D7/YS7qFwEScZ9p+g7ZUkw64yY=;
        b=hG87K8elkTIdZGVKpX9UHci6vaJ3GCGj/j2y5S4xB3eC0pwsPmLaSuZwdYwxhfKFxW
         sWylDZFNCgTdDZAdI810/zA/vubPRUekCnbTW48YdI/n3CMq8rzvK1q4+XYEe9+9YWG2
         6YwAjQQ5+4Y+T+0nywHsBZ0nPFg5ruH23o/945k/ucxiVvOLC/SgtL4Q9iV2V4Le25lr
         ODxitk/xoinjP1lzE140Rt3qEq/if99SaObHFvgYRo7wcu+lHwaswD7XpK1vqLVR8M+X
         KkFTuyMJuH4us+mBvxj8zhki6KHodWh0R5fwnOSR81fixWn/qUl4j2P873juBbl+yclh
         4dDQ==
X-Gm-Message-State: AOAM531HlZe2XBj/0gZnx1CsRt2E2dtcr4+7mK5T5N8gaUThMpCAFD+M
        oyyZE21Hz0GOeW9o+byuQymI5ky/gtnKeOVuFmShLQ==
X-Google-Smtp-Source: ABdhPJysSZ3Hu3YlrfFyup1pKaL0C54/yClUdDWZUPYAxJJxSJ9qJRXbXLyZbNUurOTJMJgn3+bRVjOYKC5hdzapJfQ=
X-Received: by 2002:ab0:2a07:: with SMTP id o7mr14517589uar.39.1643898264074;
 Thu, 03 Feb 2022 06:24:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
 <b2c6e14c7e7752c9e42cb38372edc8971895932f.1643651420.git.gitgitgadget@gmail.com>
 <220201.865ypy9te7.gmgdl@evledraar.gmail.com>
In-Reply-To: <220201.865ypy9te7.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 3 Feb 2022 15:24:12 +0100
Message-ID: <CAFQ2z_OUqMx7WiTYHGrb5A0K1d_zNVTspM+6trw+u2rqRPjYwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] t5312: prepare for reftable
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 1, 2022 at 10:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> > -test_expect_success 'pack-refs does not drop broken refs during deleti=
on' '
> > +test_expect_success REFFILES  'pack-refs does not drop broken refs dur=
ing deletion' '
> >       git update-ref -d refs/heads/other &&
> >       git rev-parse refs/heads/main >actual &&
> >       test_cmp expect actual
>
> The setup for these is reffiles-specific, but it seems to me this is
> something we'd really like to test with reftable rather than skipping it
> entirely.
>
> I.e. the scenario described in the "we create..." comment in this file
> is something that might happen with reftable too, no?

That is tested in the 3 tests right above the ones I marked with
REFFILES ('pack-refs does not silently delete broken loose ref'). The
tests at the bottom check what happens if you have a missing SHA1 in a
packed-refs file. The reftable backend does not have a packed-refs, so
there is nothing to test.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
