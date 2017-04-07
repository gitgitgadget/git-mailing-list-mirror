Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AFF91FAFB
	for <e@80x24.org>; Fri,  7 Apr 2017 04:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbdDGEyb (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 00:54:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:57884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbdDGEya (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 00:54:30 -0400
Received: (qmail 22706 invoked by uid 109); 7 Apr 2017 04:54:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 04:54:30 +0000
Received: (qmail 31948 invoked by uid 111); 7 Apr 2017 04:54:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 00:54:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Apr 2017 00:54:27 -0400
Date:   Fri, 7 Apr 2017 00:54:27 -0400
From:   Jeff King <peff@peff.net>
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170407045427.rqrqdt5mxzudonzo@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
 <20170406092122.titsfyxpucj6xoe4@sigill.intra.peff.net>
 <ef64656b-12d7-a041-e1b9-ce83f8cbd2fc@jupiterrise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef64656b-12d7-a041-e1b9-ce83f8cbd2fc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 06:43:06PM +0200, Tom G. Christensen wrote:

> On 06/04/17 11:21, Jeff King wrote:
> > On Wed, Apr 05, 2017 at 11:33:37AM +0200, Tom G. Christensen wrote:
> > > I don't use the el3 and el4 versions much any more and el5 use will also
> > > drop of now as I'm busy converting machines from el5 to el7.
> > 
> > Thanks for sharing, that's a really interesting data point.
> > 
> > I'm not quite sure what to take away from it, though. Either "yes,
> > somebody really is using Git with antique versions of curl". Or "even
> > the antique people are giving up el4, and it might be reasonable to
> > start requiring curl >= 7.11.0".

[Aside: re-reading my second paragraph above, it sounds like I am
 complaining that your comment wasn't clear. But you were perfectly
 clear. It's just that with your data point I am more conflicted than
 ever].

> I know of no users of the packages that I make available other than myself
> and my work place (only el5 and later, soon just el6 and later).
> 
> There is not currently any patches needed to use git on el5 with curl
> 7.15.5. The only thing not working out of the box in 2.12.2 would be the
> emacs integration.

I think I'm leaning towards the very first patch I posted, that assumes
7.11.0 and later. And then hold off on the others for a few years. In
terms of "number of ifdefs removed" we could go further, but I think it
was the first patch that removes a lot of the really questionable bits
(like silently ignoring security-related features).

> If you must drop support for old curl releases then from my perspective the
> cutoff should be 7.19.7 at the latest since that is what ships with RHEL 6
> and that is still supported by Red Hat.

Yeah, I think 7.19.7 would be the next reasonable cutoff (it shipped in
RHEL6, which is a reasonable standard for long-term support; and it
catches quite a few ifdefs in our code). But I think we can give RHEL5 a
bit more time. It just left its support window a few days ago.

-Peff
