Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEE6C83012
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0B6221FD
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHL22PJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbgK1Vtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732430AbgK1TAU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 14:00:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6450DC02B8E6
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 00:27:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e7so7919660wrv.6
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 00:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvYc3reEGD46g1r45WIrFRuJMriKMOgrTJ/KCbRfX2I=;
        b=WHL22PJRHVc2XdaV+5KsExBEeNVHT1WwlJ102fmoIHcmR1Oo7VlFcpUyevTz6pg97m
         eB5IShqzjU3cLVIteVB8iw9W34eGp3HtQF6pUgbulFYEiRD07J2BfSlya7cTee/IdQUM
         nVYigGNr2Dro8b56qfNMWHokVfjBOgYOf9N9412K8mbs/ZyRu/RKlmUsGWpttXj40f3K
         rpr/a+6a2N0y4A5hFNFdA6Dg+K3iNdnttQCNUbuPfR+mwPKUProdRGED1xEe0+pIbO6j
         tdr1WIBIsBUawcovslO20VDjtX2GatlEB2nqVIGlmGLDjR9F9k1MdCxA+t+8/49FiTtX
         ipXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvYc3reEGD46g1r45WIrFRuJMriKMOgrTJ/KCbRfX2I=;
        b=i85G6j5qNpJVY7peh9eMGKxADReAdptd6JizE9RFNMJq93x/spTgcOd9BgFxnn6DSs
         hNK0JRimXQZ3OKqscClIB0Zo8XzsjpzKJJORHpgsYrEB6adN3aISmp+qdYzeciEseXNX
         ldkRgrF9h1XBKCxb25wuzjot8AF4ROYZx/1nQleLScIA8SvYH9nyVAYNqRz0spEA61DS
         jckmhON+cDQdlkx6foybddfh9+vKEr2pzHoeSbgJwL4fo4N67FWA000FVszLI2u28Xov
         TwSykEAGf4pfLhdQ5tynL6Ok1IxUkza/6eecGYMq0Sl9XsDZXowh18AuT+YowcpiWhr3
         2Q9g==
X-Gm-Message-State: AOAM533SqYNpSRrryVnCW4aTw5+c8Lxb5YhkM/0/8wcAgG3c9VaB3qdA
        qevUCzv23JiV7qmVsayu1JvRfZ/uf/MsV4Ae8ZA=
X-Google-Smtp-Source: ABdhPJwOayxbyNEFujDhY7x++00Ae4y1JzTAqunxig1VzE8hA7ONoR18N90C6NdqoRqFoCYzg/+I+3a8fQiBOnwwmig=
X-Received: by 2002:adf:e788:: with SMTP id n8mr16243620wrm.84.1606552041069;
 Sat, 28 Nov 2020 00:27:21 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD0xoqVh=1BweBqNOt4_9xg4GvDd7Jf5f5_5z4H+PCVt8g@mail.gmail.com>
In-Reply-To: <CAP8UFD0xoqVh=1BweBqNOt4_9xg4GvDd7Jf5f5_5z4H+PCVt8g@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 28 Nov 2020 02:27:10 -0600
Message-ID: <CAMP44s28HEUUvW8hs5PxrW5NwwDdpou-qsNm8nx3kMk_g0brNw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 69
To:     Christian Couder <christian.couder@gmail.com>
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

On Fri, Nov 27, 2020 at 3:24 PM Christian Couder
<christian.couder@gmail.com> wrote:
> The 69th edition of Git Rev News is now published:
>
>   https://git.github.io/rev_news/2020/11/27/edition-69/

A nit-pick that has bothered me for years...

The font seems to be the same as git-scm.com, which is horrendous [1]
in Linux. The style was clearly developed by people in the Git
teaching industrial complex, who use macOS, not Linux.

The font-family list is Adelle, Georgia, Times New Roman. None of
which are present in Linux systems (and the first one costs $540 USD).
Then it falls back to "serif", which is already the default. So
basically on Linux there is no font. It has the same font as "<p>Hello
world<p>".

I was told in university that the best fonts to read on screens are
sans-serif (Arial), and in paper serif (Times New Roman). Which is why
the first thing I do in an HTML page is to add a style: body {
font-family: sans-serif; }. But somehow nobody in this lucrative
industry managed to do s/\<serif\>/sans-serif/ for Linux users.

Anyway, enough ranting.

After investigating all the different fonts specified in the list
(present in macOS and Windows), I sent a fix [2] to pick similar fonts
for Linux. The best one is Roboto Slab [3], which looks very similar
to Adelle, and it's free. Alternatively, DejaVu Serif [4] is a good
second option present in many (most?) Linux systems, plus it's how it
looks on Windows with Georgia. And lastly, plain old (but not 90s old)
sans-serif [5].

And now it finally looks readable to me.

Cheers.

[1] https://i.imgur.com/IGwT40T.png
[2] https://github.com/git/git.github.io/pull/470
[3] https://i.imgur.com/iD4rTv8.png
[4] https://i.imgur.com/hVu3VNS.png
[5] https://i.imgur.com/7KXVsQa.png

-- 
Felipe Contreras
