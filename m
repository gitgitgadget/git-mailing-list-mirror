Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F4C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 09:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C600E20708
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 09:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnBmH+zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgIPJCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIPJCF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 05:02:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DC8C06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 02:02:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gr14so9287883ejb.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6EsPoL7OesGTPx08RMzXIM5oJrSQ1r+kSTYzlRqB0o=;
        b=ZnBmH+zjtvDhgyeGOVuKuPRz01b8lvQ2ahB7q7iBG/ci0D6swRtOOgE+vQRGRcA8l0
         I3ODRHnK94PIrMA543vHJJKVkAJDwx5lZmk93xzfQ+qluS3ssBzr8NbxloR+1gouWiuK
         ScZStEehpmRVhjb7irVWzaocVWVIW/fcS6euOj+m6MlGjOYeO/to0O8huyKXAz4MB1lZ
         IfSBgiFm6X8Z/z0Hm2X4jKDAIElVUeg7I22qwrkk1prniT3zeIdWZWxM+I6DAi5VxsIN
         XQiVx71mufvN/wir8YjEzt7oLHF/G9ActChaHpNs7UVwvw/6hc6JyN/04wmO6KPGrbTM
         y0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6EsPoL7OesGTPx08RMzXIM5oJrSQ1r+kSTYzlRqB0o=;
        b=Vu1gj02nlC/m9G0/vQ8Z/EJ50wLs8hGp76vc5iczqplOZ6CzRXtAVDhU1q18ihD1re
         djOJVSZvHtDvq4hc/8J2pOZ+OL6KFwmkRAsDcAHCHVmRNrkNA9rzWYsAdKmeoTFPrL7p
         zNfZAWkaVlFVFPaAJ44HpSlXWygm1zNe4/ku04hwsAu3A0xMm6IpVTI/2m6+HkhxiO0v
         YY82QgSOx3raNWLS194qIS4qLQLlPnNo1nrHJtA9H+MYdO4x+YdsjszQJJkA6a4i9mMh
         /Z8jKwfNGf41qHg9vftCpJ85GUnMVj2ufbVzPSl7xiodAR+/VFDE8m4UKonguzeAvihF
         +sHA==
X-Gm-Message-State: AOAM532c0ZtkjCTc4suYDVbUh2E4fOkjI2q2S0q69aeo9/Vwy6KFBJY4
        gz7fuEaA6G5yt937cfv+rbY9EN9O9jZM96PcnwI=
X-Google-Smtp-Source: ABdhPJzYaPFoCeH8iNx/bD/7XZ5BY9URJwPAyJhwBjT0rqfGvID6bZ4xpkHdditzXIfy/88VG2h3SijZSokf8UdZyHA=
X-Received: by 2002:a17:906:2354:: with SMTP id m20mr23662393eja.341.1600246923396;
 Wed, 16 Sep 2020 02:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Sep 2020 11:01:52 +0200
Message-ID: <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Sep 2, 2020 at 10:50 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> As to projects, I would like to believe that
> https://github.com/gitgitgadget/git/issues has grown into a useful
> resource.

Thanks for the useful resource!

I would be interested in mentoring, or better co-mentoring, the
following projects:

- Accelerate rename detection and range-diff
(https://github.com/gitgitgadget/git/issues/519): ideally I would
co-mentor with someone a bit familiar with the suggested algorithms.
- Add support for drop!/reword! commits to `git rebase -i`
(https://github.com/gitgitgadget/git/issues/259,
https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtualbox/)
- Invent a way to retain reflogs for a while after the ref was deleted
(https://github.com/gitgitgadget/git/issues/236): I guess this might
be implemented as part of the new `git maintenance` builtin.

Best,
Christian.
