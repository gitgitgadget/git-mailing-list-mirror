Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E692208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdHIVTc (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:19:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:33846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751890AbdHIVTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:19:31 -0400
Received: (qmail 28428 invoked by uid 109); 9 Aug 2017 21:19:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 21:19:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31333 invoked by uid 111); 9 Aug 2017 21:19:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 17:19:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 17:19:29 -0400
Date:   Wed, 9 Aug 2017 17:19:29 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] http: drop support for curl < 7.19.4
Message-ID: <20170809211928.ubmhjuraguodcs7u@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
 <CAGZ79kZ-Ra6MCvvq-dqnsXowmykBt9ghqUgHgzSC_zt=Q1_=CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ-Ra6MCvvq-dqnsXowmykBt9ghqUgHgzSC_zt=Q1_=CA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 10:34:09AM -0700, Stefan Beller wrote:

> On Wed, Aug 9, 2017 at 5:02 AM, Jeff King <peff@peff.net> wrote:
> > Since v2.12.0, Git does not compile with versions of curl
> > older than 7.19.4. That version of curl is about 8 years
> > old. This means it may still be used in some distributions
> > with long-running support periods. But the fact that we
> > haven't received a single bug report about the compile-time
> > breakage implies that nobody cares about building recent
> > releases on such platforms.
> 
> I would not state it as bland, see how
> https://public-inbox.org/git/20170806233850.14711-1-avarab@gmail.com/
> came here to the mailing list.

Heh, I almost added "Or they are happy patching Git themselves". This
_does_ make patching Git harder for them, because now there are a lot
more spots to patch.

> > As discussed in the previous two commits, this cleans up the
> > code and gives a more realistic signal to users about which
> > versions of Git are actually tested (in particular, this
> > moves us past the potential use-after-free issues with curl
> > older than 7.17.0).
> 
> This is a good reason for this patch, though, so maybe just elide
> the "nobody cares" part?

I think I'd rather elaborate than elide. One of the reasons to split
this into multiple patches is that it's a ready-made patch for a
distributor to apply (in reverse) if they really want to.

-Peff
