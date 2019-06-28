Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3621F461
	for <e@80x24.org>; Fri, 28 Jun 2019 10:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfF1KTB (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 06:19:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:53804 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726465AbfF1KTA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 06:19:00 -0400
Received: (qmail 14575 invoked by uid 109); 28 Jun 2019 10:19:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 10:19:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16488 invoked by uid 111); 28 Jun 2019 10:19:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 06:19:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 06:18:58 -0400
Date:   Fri, 28 Jun 2019 06:18:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips
 are valid
Message-ID: <20190628101858.GA23052@sigill.intra.peff.net>
References: <20190628101131.GA22862@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190628101131.GA22862@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 06:11:31AM -0400, Jeff King wrote:

> Subject: [PATCH] check_everything_connected: assume alternate ref tips...

Heh. This subject should just be "check_connected" these days. I wrote
this patch originally many years ago, before 7043c7071c
(check_everything_connected: use a struct with named options,
2016-07-15) gave the function a shorter name.

But the patch has been updated recently to match other updates to the
alternates code. In particular, in the original "rev-list
--alternate-refs" behaved as if all of the refs from the alternate were
mentioned on the command line, and you could use --exclude, etc as if
they were real refs. But we've since simplified the alternates interface
to just get a list of oids, so now it behaves more like
"--indexed-objects" in that it acts as if those oids were mentioned on
the command line.

I think "--alternate-refs" is still the right name, though, since we're
just giving the oids at the ref tips. And I think the included
documentation makes this clear.

-Peff
