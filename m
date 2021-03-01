Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC40C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 10:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEC664E40
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 10:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhCAKDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 05:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCAKDX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 05:03:23 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886ABC061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 02:02:41 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id jx13so7300418pjb.1
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 02:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gT8StNSBVZCPfebHowvG1ppXoIqYtPpp7Dz/Uoh8yrw=;
        b=DTcf8SDsyhd6OIuEyT/2DqShkMs9kvZXxAgROs0g2NefiTTacLT/K5fW3Y0I9+dr4C
         NmS2EfwGJ7gjZxHo23RSnlzf/iXob3Jua91BOvXigVttpdOyoad/+xoBYhh25Tpvp2HV
         K7G+3SKJ7rEpzwQT2XUmazxXt5jXkr4bquoXpc5GnYcZnJ8uUI1eE9HpXSQANXcgfMS9
         FnE1Srd7mpS8yaV9yi6wpnycVTha6wsLlvBS71gHWey2KQqjtm7SoBPgv9ZzoG4137VK
         0mGqtqFnsQt2lwjnUZ5n6ZJPV/L3RvLlEHViWekslXPDVTBvgNhsUeCwBL1ulhaurlg5
         h5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gT8StNSBVZCPfebHowvG1ppXoIqYtPpp7Dz/Uoh8yrw=;
        b=QcytwPvVkBs7Z7fG0q9ZDd6Y9s7emcxroOWqkj/3gMwvFGt4GJ10TSXVqW2ej6qbH4
         xl74lX2y5J4gdHiYP4EV7eQHO1usyZgZpwx71QQUqA4qknJ8nNe6bmbNi1NYc7ZPUbdY
         m3uAeaJT+3Fsrf7E/bqlXGYhuDMY37ylxuQmhEvyDBhUalt6HDM/KoM3FuoGWQz/fpaf
         vCR1tpWHAkkSUgHqKJ4TIIxMd4dqdEYwQV8uWmQwydXxJ2OMcGehl4QqiWN309V2skWE
         7qrZo5ErK1sovT4SRfzHlbcAB9Y01I0p2O1SsSpVRGOc3KfE+g/WinBXFm/3g6xBvaXb
         7F1g==
X-Gm-Message-State: AOAM530BvLivAPk4jVvcpxCHzyhUvV0513V58ugcbYch3ij4xWQUwhI8
        D/RQO2sgZQGYRp92wvLeRl7Gnn3/BbI9uPxX915B/6kLck/brg==
X-Google-Smtp-Source: ABdhPJwXcd9y4cDWVd6bB8jSbVKXLRmspaETdIcFVBrfjSVUivwjuDpcKn3t3d5G2y0agcZReR8rsZbTOHB2y7x2z74=
X-Received: by 2002:a17:90a:8c08:: with SMTP id a8mr16126083pjo.136.1614592960905;
 Mon, 01 Mar 2021 02:02:40 -0800 (PST)
MIME-Version: 1.0
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net> <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
 <YDa/EupbrNa62r+D@coredump.intra.peff.net> <YDc3dinQ37FY8fhD@ncase>
 <YDiOXDbN/JtUWgWu@coredump.intra.peff.net> <CAGgn8PdYsfbSE2vRunOXO1JqXoM8LxoD+5Zn74jmb9vpqDXh+Q@mail.gmail.com>
 <YDyt6h3dphnG8kwk@coredump.intra.peff.net>
In-Reply-To: <YDyt6h3dphnG8kwk@coredump.intra.peff.net>
From:   Yaron Wittenstein <yaron.wittenstein@gmail.com>
Date:   Mon, 1 Mar 2021 12:02:05 +0200
Message-ID: <CAGgn8Pcnxu6vQbkpgBf=A-tBdhP5npne-dZpFv9MzdEUuuRYgQ@mail.gmail.com>
Subject: Re: [QUESTION] Tracking HEAD changes?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cool, thanks!

On Mon, Mar 1, 2021 at 11:03 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Feb 26, 2021 at 10:58:37PM +0200, Yaron Wittenstein wrote:
>
> > I'd like to make sure I understand the way things are right now:
> >
> > 1. The reference-transaction hook as it's today doesn't intercept
> > symbolic-references changes. It means that when HEAD changes due to
> > branch-switching the hook won't
> > get called.
> >
> > Are there any other cases that today the transaction won't execute? (I
> > couldn't think of one)
>
> No, I don't think so.
>
> > 2. The mechanisms that handle the changes to index and working-dir are
> > isolated from the one that manages the refs updates.
> >
> > A side-effect to that is the post-index-change hook running before the
> > reference-transaction one.
> > Future code changes to the way git operates could result in the
> > reference-transaction hook running before the post-index-change one.
> >
> > Is that correct?
>
> Yes, that matches my understanding.
>
> -Peff
