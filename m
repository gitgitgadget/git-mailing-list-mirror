Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CA31FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 17:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbcKYRrd (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 12:47:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:47231 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933204AbcKYRrY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 12:47:24 -0500
Received: (qmail 21420 invoked by uid 109); 25 Nov 2016 17:47:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Nov 2016 17:47:24 +0000
Received: (qmail 19241 invoked by uid 111); 25 Nov 2016 17:47:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Nov 2016 12:47:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Nov 2016 12:47:22 -0500
Date:   Fri, 25 Nov 2016 12:47:22 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
References: <cover.1479938494.git.johannes.schindelin@gmx.de>
 <cover.1480019834.git.johannes.schindelin@gmx.de>
 <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de>
 <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611242211450.117539@virtualbox>
 <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251201580.117539@virtualbox>
 <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251841030.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611251841030.117539@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 25, 2016 at 06:41:23PM +0100, Johannes Schindelin wrote:

> > Ah, I didn't realize that was a requirement. If this is going to be part
> > of a release and real end-users are going to see it, that does make me
> > think the config option is the better path (than the presence of some
> > file), as it's our standard way of tweaking run-time behavior.
> 
> So how do you easily switch back and forth between testing the old vs the
> new difftool via the test suite?

If it's for a specific tool, I'd consider teaching the test suite to run
the whole script twice: once with the flag set and once without.

That is sometimes more complicated, though, if the script creates many
sub-repos. An environment variable might be more natural. If you already
support flipping the default via config, you can probably do:

  GIT_CONFIG_PARAMETERS="'difftool.usebuiltin=true'"
  export GIT_CONFIG_PARAMETERS

-Peff
