Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FAC020248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCCR7d (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:59:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35239 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCR7c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:59:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so2391083edp.2
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+4sjNUGTPSA4ew9y87rhfQ2C+QFzj5dRPMWIPPHQmg=;
        b=IkW/24cBh//6sUbIFyimCmKps2a4XKTPXTIrCo7D8ht8EUsFxBVyJQ5gMckquPLtI2
         9EYGL048mv5U5c9deNWgBs5u2pmLJpNe07WlxI2NNYlb8dDev5qX5NP1c3fewqXLriSk
         S24InTX+4FRFmtCD6ggLgfIJ7TdtnQWBY+tio5O1/MJh72mIK75Jir68ajmQ/Dqs48LW
         U9MxnkHp8haahNvruFmgvMx+f8Rn15vt6r8sfSPQP4BCWFhDlQhr1ZAkKtwPBJwAZyxv
         GfygWaKFi1WS/FFcKsxjj2uROOastydUa/QR96n6+Ih8ff9BF+UWVzM6155VvMigbhY0
         MyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+4sjNUGTPSA4ew9y87rhfQ2C+QFzj5dRPMWIPPHQmg=;
        b=b3Vc+M++fpm1CatdqbkL7S24rl1ytForV9XLj8EtPCV8bnymUT1Rh2XGkfYJ685igv
         So6Se02h7pgbozl2opyHj/Nfpxl8cveanzxU9zaD08Q0vqdBRPCZXeig/w/TV5BJiqUp
         QE4idZUXTgX09hJvWz0YiYmfBwLmQVX5giSqvcCzQwTi80jgH7jf9k8Tp0UjVwNkekvT
         QQQrzk85Sbknoe/WBUOR1ukGFyEhfPHiUZtEIMSBLOO2CmBTLCQfeNOxWAu5RRCNCZ2x
         ORvJN+UJh1ljNuSKREixIxxNLu5oLZPAKRSq0CcUFr4ap9YkiNvocOOWWIGNEYb0XTt4
         1oBA==
X-Gm-Message-State: APjAAAVi2Iow7+o5xmXQMqlrA4A+tg3u0yVeWv+WEzRLOYwnxZXMkTYR
        9h6Xh+CGVN+HCUI/2VF0AUdEQ5jnwC1mqxZwfhA=
X-Google-Smtp-Source: APXvYqxsEqK8q64pIIKxkRuYXX+HiwPG3m0WgI4Ntr9MXQizkezDncG917ydoypJjgdb2HgVow8KSz8qqvKzoHHP3Qw=
X-Received: by 2002:a50:9156:: with SMTP id f22mr12635031eda.131.1551635970581;
 Sun, 03 Mar 2019 09:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20190222061949.GA9875@sigill.intra.peff.net> <20190222062133.GB10248@sigill.intra.peff.net>
In-Reply-To: <20190222062133.GB10248@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 3 Mar 2019 18:59:19 +0100
Message-ID: <CAP8UFD0+MSaU4KmD_pfHnCDFoqr9H99Fp9tBP-Qw+vs+ambgFg@mail.gmail.com>
Subject: Re: [PATCH 2/3] bisect: fix internal diff-tree config loading
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bartosz Baranowski <bbaranow@redhat.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 7:21 AM Jeff King <peff@peff.net> wrote:
>
> When we run our internal diff-tree to show the bisected commit, we call
> init_revisions(), then load config, then setup_revisions(). But that
> order is wrong: we copy the configured defaults into the rev_info struct
> during the init_revisions step, so our config load wasn't actually doing
> anything.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It does feel a little weird loading config at all here, since it would
> potentially affect other in-process operations.

I like that this patch fixes a bug, but this still triggers some
wondering/comments.

Would it be better or at least less weird to load it at the beginning
of `git bisect`?

Or is the real problem a limitation of the config system, that prevent
us from temporarily loading, and then maybe unloading, some config?

> This is where an
> external process might be cleaner.

It depends on which definition of clean we use. Yeah, having many
global variables and not caring because we launch many external
processes that will "clean" things up when they exit can seem "clean"
for some time. But I think we are past this point now, and I still
wouldn't like us to go back to our previous way of doing things even
here. So thanks for not using an external process.

Thanks for working on this,
Christian.
