Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B271C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 16:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1244B206D5
	for <git@archiver.kernel.org>; Fri, 22 May 2020 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivlFDRYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgEVQzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgEVQzL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 12:55:11 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E1C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 09:55:11 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j145so9883202oib.5
        for <git@vger.kernel.org>; Fri, 22 May 2020 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnfIM0/r/IByPiCDxZSFZERNcGVgxIPyajdGSEzKLRU=;
        b=ivlFDRYDSQ3FYRFuXH1v7l5X/OeJSDO8hDyWKWbEF4gf/CUxT/4zNO/x+QZl+68HHI
         ougyELW5QAg1DHakkmrV5Tpc3iynl2CrvEgN+vGezshqlNYb2pB20x2NNJ1QEwSe7ATw
         HmG5zCot1MlnQtX2qKTxWSwj7TD0IL99LjKix03rDPeOz1EHzj439ejrMVvYc9LzbTSl
         Z+3oKeLVQQ5PeJ5EL9cUC9Wan/aRMxvMq3eUeHUavMDpVRAYu806Xm51/aEg8QmNhrti
         dnSBbaperMJEYlICPgkYn0RcFvmicprXjm11hxis4Xr1QB9BLe/DuE+o1nBvXy995rvD
         2PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnfIM0/r/IByPiCDxZSFZERNcGVgxIPyajdGSEzKLRU=;
        b=SYIoCSKBYg3usp1O0fZOQejfquSkx4nIOpufUMIec/BSmHfEo/KrGMG0Lys6gWoCEI
         ZvzqER986q6KC7yI0iQWv0dBGnnwYc0k9RKEvl1XcPa2tKqRcJ+7CxNVL3bVK0Sitr8Q
         Enky+p9KARq5VTT8FhbqJfj/YgBMFunwKHcgkGRmLQR3qQWLtbjKETfFBbWZxNwQ4U7j
         O6kutNLh+BnTb5qx8R5ajMQaI4WSC+oFrSYgDsEH7qmtbFnXxhEvrivN9ryj4FgtBwvS
         jCvvfpemUZM/XN+WnlEegkUaGipk4DvwhqshTP6pGrN/PKUHKwQgbUD5LEjVnYFFPpo8
         t9TA==
X-Gm-Message-State: AOAM530YEpwqbI0v9JBa5znG31Y4iW0L9VF6xQitGpaqEwFy7s0fRLW1
        1Jk4YGkqjin6x4K7YUDJNInerqXZim/St0/ajr4=
X-Google-Smtp-Source: ABdhPJzzeL/t9ToNzXKz4poRqxlHt4YD6YpZJ8PAOSsSMZwJThmorFYBSNLZChVGF3UdSCllmQo27R26tzwjoArvzY0=
X-Received: by 2002:aca:2b04:: with SMTP id i4mr3376904oik.39.1590166510602;
 Fri, 22 May 2020 09:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGa9yXqOY0onB4cg4rjCY+RCL7qqxtYDBT+B9DoJ3nwpKh5_Hg@mail.gmail.com>
 <CAGa9yXq1FwLJdFqnnino-34pMtTcvu8pZWhgHPoBY6mJBd=yfQ@mail.gmail.com>
In-Reply-To: <CAGa9yXq1FwLJdFqnnino-34pMtTcvu8pZWhgHPoBY6mJBd=yfQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 May 2020 09:54:59 -0700
Message-ID: <CABPp-BEjrViPSXVg9h_1wCHzRSB3uG-93_nsjOOgLQ4mVhnkRA@mail.gmail.com>
Subject: Re: Git stable releases
To:     John Carlissi <johncarlissi@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 22, 2020 at 8:38 AM John Carlissi <johncarlissi@gmail.com> wrote:
>
> On Thu, May 14, 2020 at 4:25 PM John Carlissi <johncarlissi@gmail.com> wrote:
> >
> > I noticed that with 2.16.6 development stopped whereas with the latest
> > security update, everything 2.17 and newer got the fix. Is there any
> > formal definition as to when a minor version is EOL and no longer gets
> > security updates?
> > Thanks!
>
> Does the silence mean there is no formal definition or did this
> message just get lost in the pile?

These mails from the maintainer may be of interest to you, though I
think they lean towards there being no formal definition:

https://lore.kernel.org/git/xmqqwo5luj6r.fsf@gitster.c.googlers.com/

https://lore.kernel.org/git/xmqq8t8bvz6x.fsf@gitster-ct.c.googlers.com/
