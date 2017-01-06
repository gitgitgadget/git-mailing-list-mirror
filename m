Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993EF20756
	for <e@80x24.org>; Fri,  6 Jan 2017 06:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbdAFGsL (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 01:48:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:35853 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752366AbdAFGsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 01:48:09 -0500
Received: (qmail 23024 invoked by uid 109); 6 Jan 2017 06:47:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 06:47:54 +0000
Received: (qmail 14961 invoked by uid 111); 6 Jan 2017 06:48:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 01:48:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 01:47:52 -0500
Date:   Fri, 6 Jan 2017 01:47:52 -0500
From:   Jeff King <peff@peff.net>
To:     Trygve Aaberge <trygveaa@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: Regression: Ctrl-c from the pager in an alias exits it
Message-ID: <20170106064752.iccrk656c6k2wrfy@sigill.intra.peff.net>
References: <20170105142529.GA15009@aaberge.net>
 <20170106064032.eqxxer5mx5hsh2md@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106064032.eqxxer5mx5hsh2md@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 01:40:32AM -0500, Jeff King wrote:

> On Thu, Jan 05, 2017 at 03:25:29PM +0100, Trygve Aaberge wrote:
> 
> > I'm experiencing an issue when using aliases for commands that open the pager.
> > When I press Ctrl-c from the pager, it exits. This does not happen when I
> > don't use an alias and did not happen before. It causes problems because
> > Ctrl-c is also used for other things, such as canceling a search that hasn't
> > completed.
> > 
> > To reproduce, create e.g. the alias `l = log` and run `git l`. Then press
> > Ctrl-c. The expected behavior is that nothing happens. The actual behavior is
> > that the pager exits.
> 
> That's weird. I can't reproduce at all here. But I also can't think of a
> thing that Git could do that would impact the behavior. For example:

I take it back. I could not reproduce under my normal config, which sets
the pager to "diff-highlight | less". But if I drop that config, I can
reproduce easily. And bisect it to that same commit, 86d26f240f
(setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..,
2015-12-20).

-Peff
