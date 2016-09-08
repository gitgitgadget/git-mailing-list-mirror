Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F96A2070F
	for <e@80x24.org>; Thu,  8 Sep 2016 08:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757566AbcIHIOu (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 04:14:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:40063 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751979AbcIHIOt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 04:14:49 -0400
Received: (qmail 3513 invoked by uid 109); 8 Sep 2016 08:14:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 08:14:48 +0000
Received: (qmail 13073 invoked by uid 111); 8 Sep 2016 08:14:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 04:14:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 04:14:46 -0400
Date:   Thu, 8 Sep 2016 04:14:46 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Use the newly-introduced regexec_buf() function
Message-ID: <20160908081446.zlcmz6ci4cw4vc2e@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <cover.1473319844.git.johannes.schindelin@gmx.de>
 <324ecba64eb0436988aca846fb444eafda290d13.1473319844.git.johannes.schindelin@gmx.de>
 <alpine.DEB.2.20.1609080954010.129229@virtualbox>
 <20160908081024.yku2xlb3jj4rplkp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160908081024.yku2xlb3jj4rplkp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 04:10:24AM -0400, Jeff King wrote:

> On Thu, Sep 08, 2016 at 09:54:51AM +0200, Johannes Schindelin wrote:
> 
> > >  diff.c             |  3 ++-
> > >  diffcore-pickaxe.c | 18 ++++++++----------
> > >  xdiff-interface.c  | 13 ++++---------
> > >  3 files changed, 14 insertions(+), 20 deletions(-)
> > 
> > I just realized that this should switch the test_expect_failure from 1/3
> > to a test_expect_success.
> 
> Yep. I wonder if we also would want to test that we correctly find
> regexes inside binary files.
> 
> E.g., given a mixed binary/text file like:
> 
>   printf 'binary\0text' >file &&
>   git add file &&
>   git commit -m file
> 
> then "git log -Stext" will find that file, but "--pickaxe-regex" will
> not (using stock git). Ditto for "-Gtext".
> 
> Your patch should fix that.

Of course if I had actually _looked carefully_ at your patch, I would
have seen that your test doesn't just check that we don't segfault, but
actually confirms that we find the entry.

Sorry for the noise.

-Peff
