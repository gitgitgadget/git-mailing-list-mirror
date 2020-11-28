Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D0C8301B
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B280021D40
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvAp7xsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbgK1Vtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbgK1SxE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 13:53:04 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A6C02B8E9
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 00:40:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m16so8112803edr.3
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPGYj7V5PlCtqDlMoLmwwgOWaT9qES96bsjC9RyAWfI=;
        b=kvAp7xsvTwf71dttg9JIs9Kb90CuHamLODr9Y2aqm1C711C0D2qHFGwHiXdkA7Kb58
         wFB0zFHU4joRR/uC9SBum6HWkzZ1L4oTABJV0fBuMynOaCxHDQgxuqHc/ULyCy40FCop
         qXs8hPKyeYfrH9EFH+5Sthv4pvO6mSc3aY6s2ILQgbie+TUgE0KBxNJ+PkBNSgD8jlNG
         qCBF3CG+fyVAl2IaOSCInoB3QFKdyv2GTcVP1e3Q0zvZSbp/fTokBylkysKvJ0t18P+Z
         XWeRsrKuWZ4MTZ7S24lslS9ScN4SGYNiQl0VzeOzaWSpoQFn2eqC3RdfR9N6Mwj844eX
         5t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPGYj7V5PlCtqDlMoLmwwgOWaT9qES96bsjC9RyAWfI=;
        b=LEAq3uJYtsjyQgV57HJw/lbpELk0HJ/BZ/xRMpyLDDap0jKReGExrGitVwx32Xd+Jl
         r9TwVMhNrRfkoy7rcqa9tRqfG/ZFL8lk2YpGSydkyyDyX7HT1Rske+FdkcuipfdBB2s1
         ARMLxiH8/K9RM38pbUljxahR0akS5mvgruRsqnWTy470XpB0US8iyy4/3fQ0zZ/KkaYP
         IKGy4NZFxGcmi5DQ509wthoQ/GbYVSkE/MWrl8RJNv5rXvcAt3MkmES11av7v6BIWFiM
         DDjL0c4EoIRwh/EcLSjS0kTDop9ZjvX9lPQnvMzpbSuZ+kL8hastVGeoce+R5271MLdm
         PrNw==
X-Gm-Message-State: AOAM5312mz2ZpaM3Yb/bMhtpuwa2W5XBn1LjW5Dy0b9JPdvAqo4joJIj
        qv4zV5z6dcfaCm+zFz8G+4Oei2EJ5wSRhk46fqA=
X-Google-Smtp-Source: ABdhPJy0UUcs4kPt3JpPuS3WIJGWJcShifdrq8+dB0MxqzvrodSZBbT4+l2kgtMYuf/pOF+7eXbFrvWQsbLlYddjwTg=
X-Received: by 2002:a50:af65:: with SMTP id g92mr11976600edd.273.1606552840077;
 Sat, 28 Nov 2020 00:40:40 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD0xoqVh=1BweBqNOt4_9xg4GvDd7Jf5f5_5z4H+PCVt8g@mail.gmail.com>
 <CAMP44s28HEUUvW8hs5PxrW5NwwDdpou-qsNm8nx3kMk_g0brNw@mail.gmail.com>
In-Reply-To: <CAMP44s28HEUUvW8hs5PxrW5NwwDdpou-qsNm8nx3kMk_g0brNw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 28 Nov 2020 09:40:28 +0100
Message-ID: <CAP8UFD32sjT_nttQrxknr=4EYUQLMebg=KhdGmMJ7j+YUmTjwg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 69
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Victor Engmark <victor@engmark.name>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Tarun Batra <tarun.batra00@gmail.com>,
        Semyon Kirnosenko <semyon.kirnosenko@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 28, 2020 at 9:27 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> A nit-pick that has bothered me for years...
>
> The font seems to be the same as git-scm.com, which is horrendous [1]
> in Linux.

I agree that the fonts haven't looked great to me either.

> After investigating all the different fonts specified in the list
> (present in macOS and Windows), I sent a fix [2] to pick similar fonts
> for Linux.

Thanks for your pull request! I hope we can merge it soon.

> The best one is Roboto Slab [3], which looks very similar
> to Adelle, and it's free. Alternatively, DejaVu Serif [4] is a good
> second option present in many (most?) Linux systems, plus it's how it
> looks on Windows with Georgia. And lastly, plain old (but not 90s old)
> sans-serif [5].

Thanks for the screenshots too. Yeah, it seems that the fonts you
suggest look better.

Best,
Christian.
