Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA855C433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 08:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0DC64D9F
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBSIsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 03:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBSIsM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 03:48:12 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A28AC061756
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 00:47:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id n1so8402698edv.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 00:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKgHkU0YAFSLTAdchRXMgpWQn3k/6Oaxss3Rf65e+qU=;
        b=XP2ubA4elskVIivJo5IokuT6JY0En/kpI1sW+BkfuTy4FGir3hLTtMbF0/X68konD+
         gdCkVIaFCQTwc8W2cmkGMPyVET/+uva/KwGi646e4x484uGPCDLle681QM78s1bGH451
         LZdIX0F+/GnEtgTpsteyXMKRiVFWB+G+kKVWgKmQlgTVA82MSDtl1qcB+Xgyh2+YoJ+w
         3K1j+2ZPHYaaHkZaL0PYidItjgbZASBQ7gQK1BXaDymKD3axTrTXD05EQvmdQ06t00lO
         kDiGMg5iQfjxWLfjiol3a4Q5tSzslhvB3QFQMjaQizQeC0he1O9nJ6AfhNkr4i+VjyI0
         rPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKgHkU0YAFSLTAdchRXMgpWQn3k/6Oaxss3Rf65e+qU=;
        b=WgwYqdC5UFdrjLTdjHWNhiuSg7Rnh450ZlFs3QCLUnXHmZfeaTBSXygSy6C+mlLHKU
         Benb9tBF27p8eMVIc97sYlAJkKg2aLcEnPdpxCyMptY2Cd89IDQMebjq6zieNMcPhhJn
         Q9rtWVQtvlYr9AJFAczSQXHfL4bA7HDIsEDNPeMppVt+EiB8KA9PjDGoh6ggRLf/ejxG
         ptRkaSj4LHuYDAQ1QJhOboLeyYAB9c1heEm7ZwJjAnPuqX/jfHRz6JcC98lWIbvf+AZY
         bRtbrb6afyrgfLLOf9zOASACR7mjtbvA2wv+kAPBVy1kxB7oEMErYlibV/eTtqbJUzxP
         IhQw==
X-Gm-Message-State: AOAM530co8KAD1ZGICAkkU82DUW5n9IDJ3WPrzGyjI8+8RklOrBH7O6M
        jY1IMAZME1dEIWgdEmF3CZUOsT46O4LJ0oTZexs=
X-Google-Smtp-Source: ABdhPJxI/sVT3xToQk/jhzyrHEmQbuNGkl/yEsFSz9wsMU7tgL/nC8qJiHy1U7lDJr/VqVM+saKg5wuiv0MKLqrxGus=
X-Received: by 2002:a05:6402:1d39:: with SMTP id dh25mr7995724edb.142.1613724450064;
 Fri, 19 Feb 2021 00:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
 <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com> <CA+CkUQ97+Afr9TUtKnb4LE1tK8z=UfSkJY2JYb5RJKTMJXQ-Bg@mail.gmail.com>
In-Reply-To: <CA+CkUQ97+Afr9TUtKnb4LE1tK8z=UfSkJY2JYb5RJKTMJXQ-Bg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Feb 2021 09:47:19 +0100
Message-ID: <CAP8UFD3ivxTzrUxCARopyFBsarvxTSdTeQpdQahDDtsELjy1AA@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Feb 19, 2021 at 7:01 AM Hariom verma <hariom18599@gmail.com> wrote:
> On Fri, Feb 19, 2021 at 5:32 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > I have just created an Idea page with 2 project ideas:
> >
> > https://git.github.io/SoC-2021-Ideas/
>
> I just saw the "Use ref-filter formats in `git cat-file`" in the ideas list.
> I would love to co-mentor this one, if possible.

Yeah, great! I just added you as a "possible mentor" on the page.

Thanks,
Christian.
