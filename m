Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE9C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 08:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFF321852
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 08:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQNdX0Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfKTIGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:06:08 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38142 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKTIGI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 03:06:08 -0500
Received: by mail-ed1-f54.google.com with SMTP id s10so19507659edi.5
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 00:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5W8p4+ODgYEBKQokoynQLSCR6cQP47+Vt+GhaNTde7w=;
        b=QQNdX0LhGQMpZlE4k4VEosNSIN0aiqPSUfkgr0ILqLPbu3Gvwobrwvs6377XqEw0Jt
         KdjWrEC/EIXbU9YvSEy5XIKOFzxeQtyli5oU02T6YO5SrcXvLmVqT+kuHD/lebolidQ3
         CHPa5o++YOi0ciFw8FGHpXVrlOGbAKYQqLLiuQBry1IAh8AmbIfe3vE7nLD7k+zgqR5b
         58rl3iivfpTOH5TFNQ3ljZTHhq+JKsAcBzs8kxFkPvKRkdC1COvsLtZ+Og4tWQl3Xds3
         UnyeM0wyPUTxnpxqo77jLfttkWlf36QTjENaqzw3xQLGTThR24Aa13VZE3In5XSpk7tl
         etCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5W8p4+ODgYEBKQokoynQLSCR6cQP47+Vt+GhaNTde7w=;
        b=J5bFQ7fwGTwlhjaTDaRhqNkNAp5L8uqchChJ4biPUMhhb6pXrLDQlufua9Ha8QgqvL
         kzJFGlYxj16NRTPcvjXXo2lLmwHbTC5VPrsA1UBTN5k9wVlha2XoAOVH8RgQ3IU2GToW
         A8YlZYzckuXQ7GPlDGAeyHFI/O+gIVCVTUH1INo2TLq8YH1bSSlBOr4IoTot12LRMFgY
         UdJjpvU2IaFkwwrH0901f7gM2SKkOU8CrtaqA/S2rpfIPr7h4fyrVeCx1Rnl6IOZiNMP
         9kfZ9GIXoFF3XeZfn7CHKi1yCIIi63hrf3btCBr1FnMogR9PTuzNUE/nDs2VpebsKcQM
         dBGQ==
X-Gm-Message-State: APjAAAUnm6g6iwN5Vi045XT/ke080FztUSuc87bKhD5F8UztrNbNrNS/
        vVZWt63uJolnWBo56OZe7SITBMKov/HPbWHz1zm+Cpff
X-Google-Smtp-Source: APXvYqyCj6qXa6MMUTtolrw7o2tmyLBDh6RROfosVkfEUOcZbh/WPxp4TsZLIGN1cSeSurR7+sM4nfjvwGJQ2d3otpQ=
X-Received: by 2002:a17:907:447b:: with SMTP id oo19mr3417888ejb.81.1574237166252;
 Wed, 20 Nov 2019 00:06:06 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_OMr4J-gF1HXXkSQFheiDkf+7WBbn-oLYeDydmuLSfN1w@mail.gmail.com>
 <20191120053011.GA41291@syl.local>
In-Reply-To: <20191120053011.GA41291@syl.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 20 Nov 2019 09:05:54 +0100
Message-ID: <CAP8UFD27ReXZ_pA3v6iwHebNBfwxuEKy4dAhPyTu0Ey=TzvCkA@mail.gmail.com>
Subject: Re: your mail
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor and Han-Wen,

On Wed, Nov 20, 2019 at 6:30 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Nov 19, 2019 at 07:49:17PM -0800, Han-Wen Nienhuys wrote:
> >
> > I spent the last few weeks cobbling together an implementation of the
> > reftable format in C and in Go. I thought this would be cool to add to
> > git-core, but I doubt whether I will have enough time to see such an
> > effort through. Maybe some of you would want to try integrating it
> > into the Git-core code base?  Example code is here:
> >
> >   https://github.com/google/reftable/blob/master/c/api.h#L153

Interesting!

> Very exciting, and thanks for your work on this. I haven't taken a
> close look at the code yet, so I'm sure taking this further involves a
> much more careful examination.
>
> I know that Christian Couder (who you CC-d on this thread) was also
> working on this for either GitLab or Booking.com.
>
> Christian -- are you still working on this for either one of those
> entities? If so, is there some way to unify these two efforts?

Yeah, I started working on this last year for Booking.com, and I am
now slowly working on it for GitLab. It is not yet finished because it
has been low priority work.

I took a very quick look at Han-Wen's implementation and it looks very
different from mine from the outside. It seems more complete, but
might be less integrated into the Git code base.

Best,
Christian.
