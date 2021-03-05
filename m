Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E3C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 12:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A716501B
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 12:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCEMAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 07:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCEMAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 07:00:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C892EC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 04:00:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b1so3167288lfb.7
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 04:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNgnGDClxai+FnROyn8gnVS1IC/xuUSv3ETgYtRppxs=;
        b=cPXV5Ru2Di89cg1YduZuxgOJQlWGsNwxHiJQdcAPe9tO/BkJt/CbObWpqe3V1W1mEQ
         geStTNyw3A8wugcVNB3sGKp/usuPZpDoQe2ZzOZ6OuyxqquMAkvhw/Nr6YozADlUF+rL
         t09dCaqNDFysrgJ48r+LD/tDj+iQ3yRhWynX2b7CTMP6F9+UCWv5kLuKZXnbwsuLi89L
         wH2tDzBDXoAouFNjGZtFHp9HB2EXd/3/CqmZ+4vwsNatpRRKpLZE5Wq/A/QJqECPwvvF
         BkFJgBQa/SoOD4w9XGDpeqqWPSkzWUhYAMpflzf14k17t3RQ39oJJYAls38T1MVp7ken
         QGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNgnGDClxai+FnROyn8gnVS1IC/xuUSv3ETgYtRppxs=;
        b=PXCiT2FT1U2Lj9fQ4bdmPt2iRxQ1qgwQJBgO3Q8vfDxNWoHXolRMoAhMSFC8PBMuiA
         rAJ+qMQkfMrnF7CoFCmd/Gq2SJU2fwzwww5L+9/VNA/3BkJhxfVnEfHgmM6X7dtSTjj9
         a6wvSq/T5maBeuO4bRYQeWm77A+CtiaoKsYG1qTcnhXkso4xzHy2vkA+poAF48dLZssh
         XSF3qMDN1qpK37O0M6Ljza7S0z/6nBdaxbvB0XLu4dlRLAAEgYiPI4aYHV3uK/QWg3sp
         pKdDOaDxx75WHsOok6wgBn4OcrdXB5OqR91wufWxAlDt5k6t8jBCa2yc0+0Sbukbw4pD
         ZKuw==
X-Gm-Message-State: AOAM532brtEAweHADFRr+0R9pClm7VnVuXW2r3SfAe7eOO/LIEJw+9XH
        Ib38Kyf4TmfQ66LSMo1FXQevfhge75Gb5aDr1X8=
X-Google-Smtp-Source: ABdhPJzKSa1ZKSjt8CATM5jpAF0TcriohQ/7P6TEJLgg+AmJN0G8wBHwOET6pqGA86HiDTJVv7v+qhpTBtrdg6uIAWY=
X-Received: by 2002:ac2:4d9b:: with SMTP id g27mr5417663lfe.113.1614945608400;
 Fri, 05 Mar 2021 04:00:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com> <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
 <xmqqblbzj1cs.fsf@gitster.c.googlers.com> <YED1DmLWd+ciySNa@coredump.intra.peff.net>
 <xmqqa6riejyp.fsf@gitster.c.googlers.com> <xmqqtupqbij4.fsf@gitster.c.googlers.com>
 <YEHzmIOYgRtI1Ak1@coredump.intra.peff.net> <YEH5AUxgFxWTxb6u@coredump.intra.peff.net>
In-Reply-To: <YEH5AUxgFxWTxb6u@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 5 Mar 2021 03:59:57 -0800
Message-ID: <CAPx1GvfXO9Xd+9Fqp-M13WUUNWVtemWm__O4N5WUk7=s4up1Gg@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating unix
 domain sockets
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, Mar 05, 2021 at 04:02:16AM -0500, Jeff King wrote:
>
> > I don't know offhand if this [bind in a child] trick actually works. ...

On Fri, Mar 5, 2021 at 1:29 AM Jeff King <peff@peff.net> wrote:
> I was curious, but this does indeed work:
[working example snipped]

Yes, it definitely works.  The bind() call, on a Unix domain socket,
creates a file system entity linked to the underlying socket instance.
The file descriptors, in whatever processes have them, provide
read/write/send/recv/etc linkage to the underlying socket instance
(and also a refcount or other GC protection: with the ability to
send sockets over sockets, simple refcounts stop working and we
need real GC in the kernel...).

Of course, once all the file descriptor references are gone, the
socket (eventually, depending on GC) evaporates.  The file system
entity does not count for keeping the underlying socket alive.  At
this point the file system entity is "dead".  Unfortunately there's no
way to test and clean out the dead entity atomically.  The whole
thing is kind of a mess.

Chris
