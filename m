Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E9CC433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 11:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D9A207BC
	for <git@archiver.kernel.org>; Sat, 30 May 2020 11:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj9lnESI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgE3LRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3LRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 07:17:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6E4C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 04:17:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so22945pgo.9
        for <git@vger.kernel.org>; Sat, 30 May 2020 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCRzbM3/tOR+MfPzMqqXGE/koF6KFq9YCu2PAv182SQ=;
        b=Yj9lnESISOAvFUkUtKg6rVR/ObqXIH5mWhWOS9OMzL+54ANgciLvBuzEseZrVaeeFn
         mrhIjblD7z4biXBOgwJrbMq91Z9FtxeB2CCO9xgiXVbV4PBaj9SqPtBcAJ4ieKqS1Ua7
         8Ifzz4A6KWcVhsZsOOXm8gr1/5kkOW/CnLfwak4qmlLDQzhgkB9CMafeFnBfsOdSyjO+
         vRtjSpHfC4l1lwM4Ms0DWYPnhCIF4sEtqdHckKzsxWjrMbdbDweoCiSf+268JwvGxRSF
         sslPz0zOTlRNvpH0IMjh0UIwFcwn352u3PL7YXexfsXOWrMb3p070EMdOhRZynoSH1KU
         kTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCRzbM3/tOR+MfPzMqqXGE/koF6KFq9YCu2PAv182SQ=;
        b=DfxsOYBAFlgmij7mHn7BswQbU/elcbqAleM6alIUvypL7qvTh7Lj/zpUIOPLr6DN3Z
         X9bJiCvl0LcMUMNNC2yNpWjfNsH/ApWrRgjbJE40JHSZ6MPoRpBbNhD/TSYNlKiGkRmQ
         ppnmlQbYPAzp9uaB8xKS05L4lI21IPuTj4oVPjm20BOPcSb8u7kY6UJII5TtCe8xCZHA
         bB1jLWu3XiqYqpp9p6mCSHPo2mRnXh2OYvMB5ICtLzw5zkKNAYuceqEst7n7UiyWGc4I
         voDHIsBTb/4N7gv6cTFSdMXJ9UGPgI0BOPdVx2pdoh4aHuLZMXYVmmYIRUWeUhvC3bkp
         QKDg==
X-Gm-Message-State: AOAM532XOsnwEVBFtZtpSA3Kj4hHAbvVT2AxRfKjXG5PR9cLX/FRKt+I
        OBJyYhgaJNZMB6I8FfjBZ1ocNlwUuecYJ1CA1Og=
X-Google-Smtp-Source: ABdhPJy39Wo/+pGXQ02NSx69lGl4jCLgKcjw6VfN4vWRBS/QNGNU2TkWI8SxdTWJgjVrD7QVyacE4Etf79aF1vhyxFo=
X-Received: by 2002:a63:c109:: with SMTP id w9mr5831533pgf.203.1590837435646;
 Sat, 30 May 2020 04:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ves8x9_1=fVo_+dB92GpAGLcbGVqeo2gjRbBnzTzM0uzg@mail.gmail.com>
 <20200529172955.GA123244@google.com> <CAHp75VdTX=pJw6r=H=qfaDcv07n69uGQQ0TwrR0bACAx-OQAXQ@mail.gmail.com>
 <20200529192023.GC123244@google.com>
In-Reply-To: <20200529192023.GC123244@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 May 2020 14:16:59 +0300
Message-ID: <CAHp75VcQWJNJ2cmKjzqepLvhtynDSYi+Cvp1e7k4kn06pAb6gQ@mail.gmail.com>
Subject: Re: Git fetches whole repository and not just latest
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Joseph Smidt <josephsmidt@gmail.com>,
        Anders Kaseorg <andersk@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 29, 2020 at 10:20 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Andy Shevchenko wrote:
> > On Fri, May 29, 2020 at 8:29 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

...

> >>  Can you test 2.27.0-rc2?
> >
> > Is there any deb package?
>
> Yes, you can use the package from Debian unstable or experimental
> (https://tracker.debian.org/pkg/git).

I run old version, noticed the bug, Ctrl+C immediately. Then I have
installed rc2 and re-run without noticing the bug. Since it's only one
run, I can't be sure, but I'll definitely monitor the situation for a
long run. Thanks!

-- 
With Best Regards,
Andy Shevchenko
