Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D4CC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D50208E4
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgEGTRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:17:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:40726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726320AbgEGTRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 15:17:16 -0400
Received: (qmail 1883 invoked by uid 109); 7 May 2020 19:17:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 19:17:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21020 invoked by uid 111); 7 May 2020 19:17:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 15:17:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 15:17:14 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
Message-ID: <20200507191714.GA25306@coredump.intra.peff.net>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
 <20200504213326.GA31037@coredump.intra.peff.net>
 <20200504220916.GF45250@syl.local>
 <xmqqv9la9lbn.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2005062334170.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2005062334170.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 11:35:48PM +0200, Johannes Schindelin wrote:

> > >> > +				next[i] = next[i2];
> > >> > +				next[i2] = i;
> > >> > +				continue;
> > >> > +			}
> > >>
> > >> I do have one question, though. What happens if we add a second
> > >> fixup-of-a-fixup?
> > >
> > > Thanks for asking this question, I was a little curious about it, too.
> >
> > Interesting that three people looked at the same patch and asked the
> > same question in different ways ;-)
> 
> Indeed!
> 
> I am very grateful, as I had missed that, and it helped me figure out a
> better way to do it, and v2 looks a lot nicer, too.

OK, so your v2 addresses that. Does that mean it was broken in v1? If
so, then why didn't my test reveal it?

I'm not really doubting that your v2 works so much as trying to
un-confuse myself about the whole situation (which in turn might lead to
a more intelligent review).

-Peff
