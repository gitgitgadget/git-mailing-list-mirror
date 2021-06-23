Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02EAC48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 03:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D90611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 03:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFWDcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 23:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhFWDcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 23:32:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCC2C06175F
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 20:29:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u11so987135ljh.2
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 20:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dvx//5oq56idsMXiZ8Cx3Jg3ikHD05jY53zow+D332w=;
        b=oW9oiYKBZ9tm+8E5vB4UGnLGZEtAaA9Uoyny5YJjr11QtfA2HrDGpAIpVSIbC31mDT
         YodMYnt971j5/7X9VbgRR5EXsdyXHC40KiNJjcLfhThI8t3cFoph62CrhIwV4QK3P7iJ
         Es1ss4xnYGw1wSY11LAapkf3s17JXQA68eLbunhK/SdSHhlPmVZc9Zt6J2pOEJd+2d4v
         eAx5IBqXkDnPzkDdaPExQEY/WqPDKnVQngRkkIaaIUKa/jj00bujf0L0z1J7O6hc9huk
         rbnfZb2tq8prrq8+kWFVLTbaFcMFurnI1p9JT2IZiYHUlygOb/P7hnEi0GiqYfFAimqv
         Fc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dvx//5oq56idsMXiZ8Cx3Jg3ikHD05jY53zow+D332w=;
        b=N8QKqyHNOOBjUZlSxOIsp7LsHrTr7LSlRdj8QRvG0P4ITfcScd1sC53I88fRqjkP71
         QMNrvN7F28qZ7tblTAfvIzNuKMb8+y61TXsNsw5Oj/AY7mO5knoBBYXbTz5uXCRe90qI
         InmjMwdSBsSLZf7KsP0SUSVasOOrq5VC4VBKRd+11fnb6NsC0COOvi58CIz9kf5tgric
         sRWPxdKEV1Uw3g9YFGMlTwNzCjMF6LfAkYAKDNimUYVRUbFEpl2TQ4J9eG1ensJ80WBR
         5LcR6PsTvKd8GRO29Ka1GWy3WI/UgCH4etpha+AOtwranpy8sxkY3NA2Mxdy7NmMelV/
         lsBQ==
X-Gm-Message-State: AOAM530p0EGzhWcDkZYq9G7q3+HZoXk51M6XexQuzxhN7I6S5/ZowXWq
        cqXY4s/1RMt624AsNQoDw9pud5o/HfQXtYhfs3o=
X-Google-Smtp-Source: ABdhPJzZ2RiGjWdoIJdSx7EozjdAvjiHQa8SoLqopwN+0fbztyiwQJk0wgv0eyv8/DBUWO1zEgyHl1i3pk9/JrOGnkY=
X-Received: by 2002:a2e:890c:: with SMTP id d12mr6267881lji.25.1624418986276;
 Tue, 22 Jun 2021 20:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200512214420.36329-1-emilyshaffer@google.com>
 <871r8w3sxu.fsf@evledraar.gmail.com> <YNKiv2Ar77xAxixz@nand.local>
In-Reply-To: <YNKiv2Ar77xAxixz@nand.local>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 22 Jun 2021 20:29:35 -0700
Message-ID: <CAPx1Gve_KqzQHanDDTSJ_2QywzNybq-J3wkG8xBC_DUhwVB5Fg@mail.gmail.com>
Subject: Re: [PATCH] trace2: log progress time and throughput
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 7:56 PM Taylor Blau <me@ttaylorr.com> wrote:
>... I was going to comment on the fact that "(*p_progress)->total" could
> be written simply as "*p_progress->total", but I'm (a) not sure that I
> actually prefer the latter to the former, and (b) I find that kind of
> style comment generally useless.

Also, it can't. :-) The binding order is wrong; *p_progress->total binds as
*(p_progress->total), and `p_progress` has to be followed first, so this
just doesn't work.

(Go does precedence and operator syntax a bit better than does C, but
even in Go one must still parenthesize certain pointer-following operations.)

> But it may make sense to sidestep the whole thing and have a "struct
> progress *progress = *p_progress" (that is assigned after we check
> p_progress to make sure it's non-NULL) like in stop_progress_msg, which
> would clean up a lot of this.

This is the way to go.

Chris
