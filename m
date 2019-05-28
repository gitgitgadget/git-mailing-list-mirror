Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE4C1F462
	for <e@80x24.org>; Tue, 28 May 2019 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfE1VjP (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 17:39:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:40556 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726812AbfE1VjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 17:39:15 -0400
Received: (qmail 5924 invoked by uid 109); 28 May 2019 21:39:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 21:39:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18575 invoked by uid 111); 28 May 2019 21:39:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 17:39:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 17:39:13 -0400
Date:   Tue, 28 May 2019 17:39:13 -0400
From:   Jeff King <peff@peff.net>
To:     Brendan Boerner <bboerner.biz@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: 'git stash list' => Segmentation fault
Message-ID: <20190528213912.GH24650@sigill.intra.peff.net>
References: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905272046250.47@tvgsbejvaqbjf.bet>
 <20190528063451.GG7946@sigill.intra.peff.net>
 <CAKkfZL30QuBM6vT69OSS_keNuGi1U-bJ+jDiyDfhZmnr9L9xvA@mail.gmail.com>
 <20190528204051.GA24650@sigill.intra.peff.net>
 <CAKkfZL3ZNgNFzxrYbjbhCF5BR12vQPy2sNuYdxmQgmuG+mo9Gw@mail.gmail.com>
 <20190528205608.GC24650@sigill.intra.peff.net>
 <CAKkfZL1BmOjzJ1QrQ43gJx89si3-M_1KMz=EWXN=pK6HSjCEkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKkfZL1BmOjzJ1QrQ43gJx89si3-M_1KMz=EWXN=pK6HSjCEkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 04:29:13PM -0500, Brendan Boerner wrote:

> To answer your previous question I'm using git v2.21.0. I'm using the
> Ubuntu 14.04 PPA as well as Linuxbew (also v2.21.0).
> 
> Your help helped me narrow this down to linuxbrew. Take it out of my
> path no segfault.
> 
> Uninstall linuxbrew git, linuxbrew still in PATH, use PPA git, segfault.
> 
> Narrowed down further to be the "gettext" package - remove it from
> linuxbrew and PPA git stash list => no segfault.
> 
> I'll ping the Linuxbrew folks.

Ah, that makes sense. You're indeed running the shell version, and it's
invoking "gettext" for messages, which is probably what's segfaulting.
And that explains the multiple segfaults and the fact that they didn't
actually cause the overall operation to fail.

So probably nothing here for Git to fix. Thanks for following up with
the resolution!

-Peff
