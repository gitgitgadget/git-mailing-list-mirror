Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137F7211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 22:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeLEWAB (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 17:00:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:60264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727685AbeLEWAB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 17:00:01 -0500
Received: (qmail 11755 invoked by uid 109); 5 Dec 2018 22:00:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 22:00:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3403 invoked by uid 111); 5 Dec 2018 21:59:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 16:59:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 16:59:59 -0500
Date:   Wed, 5 Dec 2018 16:59:59 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 2/3] test-lib-functions: introduce the 'test_set_port'
 helper function
Message-ID: <20181205215958.GF19936@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-3-szeder.dev@gmail.com>
 <20181205051709.GD12284@sigill.intra.peff.net>
 <20181205122035.GL30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205122035.GL30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 01:20:35PM +0100, SZEDER Gábor wrote:

> On Wed, Dec 05, 2018 at 12:17:09AM -0500, Jeff King wrote:
> > On Tue, Dec 04, 2018 at 05:34:56PM +0100, SZEDER Gábor wrote:
> > 
> > > Several test scripts run daemons like 'git-daemon' or Apache, and
> > > communicate with them through TCP sockets.  To have unique ports where
> > > these daemons are accessible, the ports are usually the number of the
> > > corresponding test scripts, unless the user overrides them via
> > > environment variables, and thus all those tests and test libs contain
> > > more or less the same bit of one-liner boilerplate code to find out
> > > the port.  The last patch in this series will make this a bit more
> > > complicated.
> > > 
> > > Factor out finding the port for a daemon into the common helper
> > > function 'test_set_port' to avoid repeating ourselves.
> > 
> > OK. Looks like this should keep the same port numbers for all of the
> > existing tests, which I think is good.
> 
> Not for all existing tests, though: t0410 and the 'git p4' tests do
> get different ports.

Yeah, I should have said "most". The important thing is that they remain
static and predictable for normal non-stress runs, which they do.

-Peff
