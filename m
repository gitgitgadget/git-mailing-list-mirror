Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2981FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 05:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935276AbdJRFeQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 01:34:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:56256 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754983AbdJRFeP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 01:34:15 -0400
Received: (qmail 9301 invoked by uid 109); 18 Oct 2017 05:34:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 05:34:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29493 invoked by uid 111); 18 Oct 2017 05:34:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 01:34:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2017 01:34:13 -0400
Date:   Wed, 18 Oct 2017 01:34:13 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171018053413.j2h63tq2qpkfev3x@sigill.intra.peff.net>
References: <20171012021007.7441-2-gitster@pobox.com>
 <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
 <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
 <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
 <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
 <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
 <xmqqshemtoth.fsf@gitster.mtv.corp.google.com>
 <20171016215311.m72jarmqhjagy6o6@sigill.intra.peff.net>
 <xmqqo9p6r3ai.fsf@gitster.mtv.corp.google.com>
 <20171017065101.ismnplaynumt5bdh@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171017065101.ismnplaynumt5bdh@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 11:51:01PM -0700, Jonathan Nieder wrote:

> > OK, so it seems we both have slight preference for the "peel back"
> > approach.  Adding Jonathan to Cc:
> 
> Which approach is "harder but right" / "peel back"?

"peel back" is reverting back to the pre-v2.14.2 state (Junio has the
patches queued in jk/ref-filter-colors-fix).

> I agree with the goal of making color.ui=always a synonym for auto in
> file-based config.  Peff found some problems with the warning patch
> (scripted commands produce too many warnings), which are not an issue
> for $dayjob but may be for upstream, so I see the value of holding off
> on the warning for now.
> 
> I'm also fine with "revert the proximate cause of the latest
> complaints" as a stepping stone toward making color.ui=always a
> synonym for auto in file-based config in a later release.

I do think "color.ui=always" is a foot-gun, but I wasn't happy with the
number of weird hacks we ended up with in trying to fix that (like "it
means one thing in the on-disk config and another thing with "git -c").

We can take it up as a topic post-release. At the very least, I think we
will want to change the documentation to make it more clear that you
almost certainly _don't_ want to use "always".

-Peff
