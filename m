Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09291F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDCS2E (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:28:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:52412 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753048AbeDCS2D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:28:03 -0400
Received: (qmail 11744 invoked by uid 109); 3 Apr 2018 18:28:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 18:28:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30005 invoked by uid 111); 3 Apr 2018 18:29:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 14:29:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 14:28:00 -0400
Date:   Tue, 3 Apr 2018 14:28:00 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
Subject: Re: [PATCH 2/6] commit: add generation number to struct commmit
Message-ID: <20180403182800.GA8377@sigill.intra.peff.net>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403165143.80661-3-dstolee@microsoft.com>
 <20180403180536.GB100220@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403180536.GB100220@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 11:05:36AM -0700, Brandon Williams wrote:

> On 04/03, Derrick Stolee wrote:
> > The generation number of a commit is defined recursively as follows:
> > 
> > * If a commit A has no parents, then the generation number of A is one.
> > * If a commit A has parents, then the generation number of A is one
> >   more than the maximum generation number among the parents of A.
> > 
> > Add a uint32_t generation field to struct commit so we can pass this
> 
> Is there any reason to believe this would be too small of a value in the
> future?  Or is a 32 bit unsigned good enough?

The linux kernel took ~10 years to produce 500k commits. Even assuming
those were all linear (and they're not), that gives us ~80,000 years of
leeway. So even if the pace of development speeds up or we have a
quicker project, it still seems we have a pretty reasonable safety
margin.

-Peff
