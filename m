Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730F220756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdAQVr2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:47:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:40546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbdAQVrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:47:25 -0500
Received: (qmail 29057 invoked by uid 109); 17 Jan 2017 21:47:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 21:47:25 +0000
Received: (qmail 22299 invoked by uid 111); 17 Jan 2017 21:48:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 16:48:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 16:47:23 -0500
Date:   Tue, 17 Jan 2017 16:47:23 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote
 was configured
Message-ID: <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
 <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 10:19:24PM +0100, Johannes Schindelin wrote:

> One of the really nice features of the ~/.gitconfig file is that users
> can override defaults by their own preferred settings for all of their
> repositories.
> 
> One such default that some users like to override is whether the
> "origin" remote gets auto-pruned or not. The user would simply call
> 
> 	git config --global remote.origin.prune true
> 
> and from now on all "origin" remotes would be pruned automatically when
> fetching into the local repository.
> 
> There is just one catch: now Git thinks that the "origin" remote is
> configured, as it does not discern between having a remote whose
> fetch (and/or push) URL and refspec is set, and merely having
> preemptively-configured, global flags for specific remotes.
> 
> Let's fix this by telling Git that a remote is not configured unless any
> fetch/push URL or refspect is configured explicitly.

Hmm. Old versions of GitHub for Windows used to set fetch refspecs in
the system gitconfig, for a similar purpose to what you want to do with
remote.origin.prune.

I notice here that setting a refspec _does_ define a remote. Is there a
reason you drew the line there, and not at, say, whether it has a URL?

-Peff
