Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9451F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeH3B3A (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:29:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:32906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727324AbeH3B3A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:29:00 -0400
Received: (qmail 21124 invoked by uid 109); 29 Aug 2018 21:30:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 21:30:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19042 invoked by uid 111); 29 Aug 2018 21:30:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 17:30:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 17:30:12 -0400
Date:   Wed, 29 Aug 2018 17:30:12 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180829213012.GA32400@sigill.intra.peff.net>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net>
 <CAGZ79kZv4BjRq=kq_1UeT2Kn38OZwYFgnMsTe6X_WP41=hBtSQ@mail.gmail.com>
 <20180829210348.GA29880@sigill.intra.peff.net>
 <CAGZ79kYJTWROYSGjEbdVBsEAkWkNE4QVCiPVfuMf75d13fXN6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYJTWROYSGjEbdVBsEAkWkNE4QVCiPVfuMf75d13fXN6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 02:10:37PM -0700, Stefan Beller wrote:

> > Yes, that makes even the capitalized "CON" issues go away. It's not a
> > one-to-one mapping, though ("foo-" and "foo_" map to the same entity).
> 
> foo_ would map to foo__, and foo- would map to something else.
> (foo- as we do not rewrite dashes, yet?)

Ah, OK, I took your:

>   [A-Z]  -> _[a-z]

to mean "A-Z becomes a-z, and everything else becomes underscore".

If you mean a real one-to-one mapping that allows a-z and only a few
safe metacharacters, then yeah, that's what I was thinking, too.

> > If we want that, too, I think something like url-encoding is fine, with
> > the caveat that we simply urlencode _more_ things (i.e., anything not in
> > [a-z_]).
> 
> Yeah I think we need more than url encoding now.

If you take "url encoding" to only be the mechanical transformation of
quoting, not the set of _what_ gets quoting, we can still stick with it.
We don't need to, but it's probably no worse than inventing our own
set of quoting rules.

-Peff
