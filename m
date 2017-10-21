Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85D8202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 03:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbdJUDNB (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 23:13:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:59636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751959AbdJUDNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 23:13:01 -0400
Received: (qmail 3499 invoked by uid 109); 21 Oct 2017 03:13:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 03:13:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21701 invoked by uid 111); 21 Oct 2017 03:13:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 23:13:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 23:12:59 -0400
Date:   Fri, 20 Oct 2017 23:12:59 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] t/Makefile: introduce TEST_SHELL_PATH
Message-ID: <20171021031258.m5skrtfk6nqlk567@sigill.intra.peff.net>
References: <20171020225340.6qgybldewi7knxvz@sigill.intra.peff.net>
 <20171020235001.5072-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171020235001.5072-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 21, 2017 at 01:50:01AM +0200, SZEDER Gábor wrote:

> > On Thu, Oct 19, 2017 at 05:01:40PM -0400, Jeff King wrote:
> > 
> > > I sometimes run git's test suite as part of an automated testing
> > > process. I was hoping to add "-x" support to get more details when a
> > > test fails (since failures are sometimes hard to reproduce).
> 
> Would it make sense (or be feasible) to enable "-x" on Travis CI?

Yes, after this series I think it may be workable to do so.

> > @@ -2350,6 +2357,7 @@ GIT-LDFLAGS: FORCE
> >  # and the first level quoting from the shell that runs "echo".
> >  GIT-BUILD-OPTIONS: FORCE
> >  	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@+
> > +	@echo TEST_SHELL_PATH=\''$(subst ','\'',$(TEST_SHELL_PATH_SQ))'\' >$@+
> 
> This redirection overwrites, loosing the just written SHELL_PATH.  It
> should append like the lines below.

Doh, thank you. It's interesting that nothing broke with this error. But
I think when run via Make that we end up with SHELL_PATH via the
environment (set to the default /bin/sh, which was suitable for my
system).

I'll fix it.

-Peff
