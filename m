Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8905C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96785207DA
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgHNOcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:32:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:59096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgHNOcc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:32:32 -0400
Received: (qmail 32724 invoked by uid 109); 14 Aug 2020 14:32:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 14:32:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25953 invoked by uid 111); 14 Aug 2020 14:32:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 10:32:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 10:32:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/5] Makefile: drop builtins from MSVC pdb list
Message-ID: <20200814143231.GA4167031@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145719.GA891370@coredump.intra.peff.net>
 <20200813150428.GA2244@syl.lan>
 <20200813150828.GA891963@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008141611490.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2008141611490.54@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 04:18:37PM +0200, Johannes Schindelin wrote:

> While all four methods work, the only one that is regularly used with the
> `make install` command is the first one.
> 
> The location you modified is in the `MSVC` part of `compat.mak.uname`,
> i.e. in the Visual C part.
> 
> We originally had a tentative plan to eventually, maybe, build Git for
> Windows using Visual C by default. However, it turned out that the
> standard malloc in Visual C's runtime was tuned for other workloads than
> Gits, and that nedmalloc performed better, and we originally could not get
> nedmalloc to compile with a modern Visual C, so we stopped that effort.
> 
> That's why you still have support for `make MSVC=1 install`.
> 
> Since it seems not to be too much trouble, I would prefer to keep it
> working for now, even if it is rarely exercised and regressions might
> creep in (like the ones you fixed).

Ah, thanks. That perfectly explains what is going on and why it might
not have been noticed. I agree it is not too much trouble to keep it
around for now.

-Peff
