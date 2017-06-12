Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88F020401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbdFLWCq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:02:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:38569 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752386AbdFLWCq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:02:46 -0400
Received: (qmail 5241 invoked by uid 109); 12 Jun 2017 22:02:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 22:02:46 +0000
Received: (qmail 17101 invoked by uid 111); 12 Jun 2017 22:02:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 18:02:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 18:02:44 -0400
Date:   Mon, 12 Jun 2017 18:02:44 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH 0/4] config.h
Message-ID: <20170612220244.dcndhmxpnsz2tg5d@sigill.intra.peff.net>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612214502.xynyfswj2ipf25ah@sigill.intra.peff.net>
 <20170612215352.GE154599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170612215352.GE154599@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 02:53:52PM -0700, Brandon Williams wrote:

> > These all seem reasonable to me. Patch 3 made me shrug a little, because
> > it seems like the majority of C files end up including it anyway. I
> > suspect you could break config.h down into two files: the few things
> > that everybody needs (git_config() and the few parsing functions needed
> > in callbacks) and the ones for commands that actually manipulate the
> > config.
> > 
> > That would reduce the surface area of the module that most callers look
> > at, but I don't think there's a huge benefit to doing so (mostly it just
> > makes re-compiling faster by decreasing the chance that a dependent
> > header has changed for each file).
> 
> Yes, ultimately I think it would be a good thing to break config.c down
> into at least 2 more files (the file parsing logic and the config_set
> logic) but that can be done at a later point.  I started looking at
> doing that now but that logic is a little more entangled than I thought
> it was.

To be clear, I don't mind that sort of module refactoring and like the
results.  But it almost certainly isn't the biggest bang-for-buck in
terms of the time it takes versus the benefit it brings. So take my
comment as "we could also do..." but not "we should not take your patch
because it does not go far enough".

-Peff
