Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E826F1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeC1R7x (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:59:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:46366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753079AbeC1R7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:59:53 -0400
Received: (qmail 14600 invoked by uid 109); 28 Mar 2018 17:59:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 17:59:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11301 invoked by uid 111); 28 Mar 2018 18:00:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 14:00:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 13:59:51 -0400
Date:   Wed, 28 Mar 2018 13:59:51 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Rast <trast@student.ethz.ch>,
        Phil Haack <haacked@gmail.com>
Subject: Re: [PATCH] t1300: document some aesthetic failures of the config
 editor
Message-ID: <20180328175950.GE16274@sigill.intra.peff.net>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
 <20130329170032.GA3552@sigill.intra.peff.net>
 <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
 <20130329172307.GA11099@sigill.intra.peff.net>
 <20130329175058.GA13506@sigill.intra.peff.net>
 <7vobe2nins.fsf@alter.siamese.dyndns.org>
 <20130329195155.GA19994@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803281220100.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803281220100.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 06:33:55PM +0200, Johannes Schindelin wrote:

> On Fri, 29 Mar 2013, Jeff King wrote:
> 
> > Subject: [PATCH] t1300: document some aesthetic failures of the config editor

This is an old one. :) I had to go look up the old thread to refresh
myself.

> [...]
> Obviously, your example gives the impression that `git config --unset
> core.key` shoud *delete* that comment (that obviously is intended to
> document the section, not the `key` value).
> 
> And this is bad, really bad. And this comment does not make it better:
> 
> 	I think we may not attain that ideal without some natural language
> 	processing of the comments. But hey, no reason not to shoot for the
> 	stars. :)
> 
> There *is* a reason, a very good reason *not* to shoot for the stars.

I think you are reading more into my comment than was intended. No, I
don't think we plan to implement a sufficiently advanced AI to cover all
these cases. But as I said in the thread:

  It makes sense to me to document both via tests; even if we end up
  tweaking the expected behavior when the fix is actually implemented,
  the presence of the test still serves as a reminder of the issue.

So it was always intended for this test to give a general sense of the
problem, from which somebody interested could dig further and work on
it.

Probably the commit message could have made this more clear (or even an
in-code comment).

> Think about it. The `test_expect_failure` function is intended to
> demonstrate bugs, and once those bugs are fixed, the _failure should be
> turned into _success. And if somebody looks for work, they can look for
> test_expect_failure and find tons of micro-projects.
> 
> What you did there was to change some valid demonstration of a bug that
> can be fixed to something that cannot be fixed. So if an occasional lurker
> comes along, sees what you expect to be fixed, they would have said
> "Whoa!" and you lost a contribution.

Hypothetically, you may be right. But don't all bugs have some element
of this? People can find an expect_failure as a starting point, but
they'll have to dig into the background and history of the bug if they
want to know the subtleties. This one is just more subtle than some
others.

> On a positive note: I just finished work on a set of patches addressing
> this:
> https://github.com/git/git/compare/master...dscho:empty-config-section (I
> plan on submitting this tomorrow)

Great. If your series throws away my test and replaces it with something
more attainable (preferably with expect_success ;) ), I think that is
certainly a positive change.

-Peff
