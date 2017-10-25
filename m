Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B762055E
	for <e@80x24.org>; Wed, 25 Oct 2017 21:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdJYVuT (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 17:50:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:36032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751902AbdJYVuS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 17:50:18 -0400
Received: (qmail 21887 invoked by uid 109); 25 Oct 2017 21:50:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 25 Oct 2017 21:50:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25637 invoked by uid 111); 25 Oct 2017 21:50:24 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 25 Oct 2017 17:50:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Oct 2017 14:50:15 -0700
Date:   Wed, 25 Oct 2017 14:50:15 -0700
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 4/3] t/Makefile: introduce TEST_SHELL_PATH
Message-ID: <20171025215015.irnyvk7kvmxqkniy@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
 <20171020225340.6qgybldewi7knxvz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1710231258451.6482@virtualbox>
 <20171024013130.5nuxmjlwnm2l3zrq@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1710252334000.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1710252334000.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 11:35:44PM +0200, Johannes Schindelin wrote:

> > > Or alternatively we could prefix the assignment by
> > > 
> > > 	test -n "$TEST_SHELL_PATH" ||
> > > 
> > > or use the pattern
> > > 
> > > 	TEST_SHELL_PATH="${TEST_SHELL_PATH:-[...]}"
> > 
> > I'm not quite sure what this is fixing.  Is there a case where we
> > wouldn't have TEST_SHELL_PATH set when running the tests? I think there
> > are already other bits that assume that "make" has been run (including
> > the existing reference to $SHELL_PATH, I think).
> 
> The way I read your patch, setting the environment variable differnently
> at test time than at build time would be ignored: GIT-BUILD-OPTIONS is
> sourced and would override whatever you told the test suite to use.
> 
> I guess it does not really matter all that much in practice.

Right. I find that behavior mildly irritating at times, but it's
consistent with other items like NO_PERL, etc. E.g., you cannot do:

  make NO_PERL=
  cd t
  NO_PERL=Nope ./t3701-*

and disable perl. It's testing what got built.

-Peff
