Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4149C2BA19
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C2E2076D
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dG9RKqJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbgDPBzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388434AbgDPBzp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 21:55:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA87C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 18:55:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id 71so15194383qtc.12
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 18:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Kto18+3nGqHJAgpAUr2qoIZYVj51MS4JUEcZk1bAYI=;
        b=dG9RKqJBOL4d/SogQ9tJgMPOaTQrDPhSQodnwkdc0zLsODlDRv8rl9rq97VI856YC9
         O6eCx3058kTipZ5Y0Tm5nciYlGLdGJEHTuapDZRZfY+YJE/WNnpVSDlekI2Wr7a/TAcY
         mAbgcjiC62RlnglL4a9b8HJfTg/S1CQW3M7rIeVbk6chO7vYNApg9D2Aop4r4EZ84bpl
         MeSiOgBNXcLSn53rpbnqVLjd17fKNKuBOgOTHUELN02XcqdW1aFU76yqcuIEmEB1fVKw
         KBze0yVmNAEydA7+o5JC0+PdnXlt7glCclkS8xJcrCTyH/jqKbU6tQ3LY5yHdLxydh5S
         0MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Kto18+3nGqHJAgpAUr2qoIZYVj51MS4JUEcZk1bAYI=;
        b=TxJ7jHh4lyrHWeVlx4p3dnS37MntLdWNx9g+DGng3yYIeoIkZnzLmYaeROHvkutfxc
         /ckXlCixmGr/Dxc/Sky7g9G2jx6nqUslFO9XWiE7JgEHDrOsm7JO8MGgRRjwd9FhLUTV
         8FQfo2+u2LiDsqlDupfi8PrWArziiYpJg6IMZLH4gxQ9hLFfviHbsUSDafLLme9sh7es
         5yZ1uhLBCNplaK62b+l4rRwvVX/Z2kLFYmdBO6IAPh9HkvXZH5ROnCYPYtOenMJpbnBw
         pFjHxxRrlBt+abTiomuSibi/8uccdcHmPZaEdkR2voYe90pSrWWGciRTcR9F09YMmW1V
         jv/Q==
X-Gm-Message-State: AGi0PuY7ZaH//br9oe3pDJveZQA69EJVxwa2wOJ6QE4no0ymcg8yhGkn
        cV6kIdT+raQCJBe5pkZZU0xLWqBma1SDq/2P9+/NXA==
X-Google-Smtp-Source: APiQypIqf0D59c5qRGFV1djDrwKeYa++c0ikww2PKhDiABL6Xvnc96WY2Mbw50CxPMkwbV6QTCWFc5HOMftKgQ4jRDs=
X-Received: by 2002:ac8:2921:: with SMTP id y30mr23646740qty.161.1587002142509;
 Wed, 15 Apr 2020 18:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586309211.git.congdanhqx@gmail.com> <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet> <xmqq1rovl54d.fsf@gitster.c.googlers.com>
 <20200410174141.GB27699@danh.dev> <xmqqh7xk45l4.fsf@gitster.c.googlers.com> <xmqq1roo43sp.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqq1roo43sp.fsf_-_@gitster.c.googlers.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 15 Apr 2020 18:55:31 -0700
Message-ID: <CAJoAoZk9Y9rc7ssfZ6S3pYepK6LpapoSzBAQjL+f7uHXv79HWg@mail.gmail.com>
Subject: Re: fixing ci failure of 'pu' with the es/bugreport topic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 6:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Danh Doan <congdanhqx@gmail.com> writes:
> >
> >> Excerpt from build log:
> >>
> >>> fatal error C1083: Cannot open include file: 'config-list.h'
> >>
> >> It's from bugreport topic.
> >> I've seen this failure in the past (when testing with pu),
> >> then I saw it disappear.
> >>
> >> I thought it was fixed during my testing for v4.
> >
> > Is the issue something similar to 976aaedc (msvc: add a Makefile
> > target to pre-generate the Visual Studio solution, 2019-07-29)?
> >
> > If that is the case, perhaps something like this would help?  I'll
> > tentatively queue it on top of es/bugreport and merge the result to
> > 'pu' to see what happens.
>
> The build just passed: https://github.com/git/git/runs/590781044
>
> Emily, you may need to squash in something along the line of this
> change to the commit in your series that starts building and using
> the config-list.h file (was it the first one?).  I've queued mine
> as a follow-up "oops, it was wrong" patch, but that would not be
> kosher from bisectability's point of view.

Hm, ok. I'll send a reroll squashing this in verbatim tomorrow unless
I hear otherwise from Dscho? Looks like it's indeed the first one
(dd763e).
I'm curious to know how I can check this build method for myself for next time.

(If I misunderstood and I should send a reroll ASAP, please let me
know; otherwise I already switched off for the evening.)

 - Emily
