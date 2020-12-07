Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D46EC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 03:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292E122D06
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 03:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgLGDTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 22:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGDTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 22:19:10 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E5CC0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 19:18:30 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so11342635wrt.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7AGZW5UvxFGPUhZEncz3YQz2hBLHvtJF5OfTBBZj5I=;
        b=qoJCNZrbdhqJq5zvTe8Zh2xWUmhYGayoxu84fB6Bj2U+YxrmHDKxNmWONSzcABq9Tq
         93aK16/sjHZY3SHbHouVg9WeJWVW5n1ur4Gpj4jsQArUtcG/kMsifbUtxsac9miNhesC
         tMys3KLNVc4Ayosv5LoCia0hUoTsOf0bptgynJYDFrqCHi0zteTlvB2wgNiuS7PBfkvM
         RdwlCHodqfufeH20GS/iEKf3giOsncxTKKD9/61pbkBj3eFCSJuI7J3rG/yE0yU4GOQw
         xruTZXRV7jEDi3g1cTlxSlVbebwLrQzEViLintsbzt4rF4KkB5r09ZOQqmKsViYMm803
         BWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7AGZW5UvxFGPUhZEncz3YQz2hBLHvtJF5OfTBBZj5I=;
        b=jP/+TNl8pLdAeMmKpLaA2mrkorOrR+4LbdLfpdutuszFsuf7cisu8ohFPWVXi9tOD+
         Fxl8pbHiunn+TMwhi/Th6jhYi77TbG29Mh+8c+HoZEWRa5ujhViuaXNJLjiYY74mX5+I
         mkevJoP+6lNgU3BpdC9LttlagycPNFxCH4LN2rDWkzBVvaVo37lUUFmjY+MG0lvMJLNT
         eUKU5FeE56O94um4Dq+x/otZUVCjhoqL3OhefZ00vIwShjLP7NNd9LTVjZ5LUJMZdsiJ
         yR0eagDSxZCX6V3xckny7YvU1BtAsvLdydk1ZAkTBsYhl4Vauo2q2/PZO99hleqLUTzR
         KXQQ==
X-Gm-Message-State: AOAM530EeU013Z3uyoUJfOGuXXRbygHtKu4J/fRfe8M0bFsx31QwG8BH
        bhuqSje2IQ382TlnE7n204UWTznIkXi/a96SkNI=
X-Google-Smtp-Source: ABdhPJz2Jap50iPbL0TLcdp6ZrOqRq+M+4ibriVEOB9FRUIsVit3WXd96wxi7wmqFmyoI+OxCODEuZZW866NArHGp1E=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr17439198wrv.255.1607311109189;
 Sun, 06 Dec 2020 19:18:29 -0800 (PST)
MIME-Version: 1.0
References: <a8e1bc9d-ce6c-d065-5a20-fee15967364d@ramsayjones.plus.com>
In-Reply-To: <a8e1bc9d-ce6c-d065-5a20-fee15967364d@ramsayjones.plus.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 6 Dec 2020 21:18:18 -0600
Message-ID: <CAMP44s1eb7O+bYXFyYm7BLCP37r1k80XY4MOC8RRL4nY61CMDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] Documentation/Makefile: conditionally include doc.dep
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 6, 2020 at 6:35 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>
>
> The 'clean' target is noticeably slow on cygwin, even for a 'do-nothing'
> invocation of 'make clean'. For example, the second 'make clean' below:
>
>   $ make clean >/dev/null 2>&1
>   $ make clean
>   GIT_VERSION = 2.29.0
>   ...
>   make[1]: Entering directory '/home/ramsay/git/Documentation'
>       GEN mergetools-list.made
>       GEN cmd-list.made
>       GEN doc.dep
>   ...
>   $
>
> has been timed at 23.339s, using git v2.29.0, on my laptop (on old core
> i5-4200M @ 2.50GHz, 8GB RAM, 1TB HDD).
>
> Notice that, since the 'doc.dep' file does not exist, make takes the
> time (about 8s) to generate several files in order to create the doc.dep
> include file. (If an 'include' file is missing, but a target for the
> said file is present in the Makefile, make will execute that target
> and, if that file now exists, throw away all its internal data and
> re-read and re-parse the Makefile). Having spent the time to include
> the 'doc.dep' file, the 'clean' target immediately deletes those files.
>
> In order to eliminate such wasted effort, use the value of the internal
> $(MAKECMDGOALS) variable to only '-include doc.dep' when the target is
> not 'clean'. (This drops the time down to 12.364s, on my laptop, giving
> an improvement of 47.02%).

All this makes sense, but I had to do "make doc.dep" and take a look
at that file to understand why:

doc.dep contains make rules with targets and dependencies that will
not be used in "make clean".

This is in my opinion the important information. Maybe mention
something like that in the commit message?

Cheers.

-- 
Felipe Contreras
