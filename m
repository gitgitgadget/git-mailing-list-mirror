Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5DA1FAD6
	for <e@80x24.org>; Sun, 10 Sep 2017 07:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdIJHjb (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 03:39:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:33666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751279AbdIJHja (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 03:39:30 -0400
Received: (qmail 20830 invoked by uid 109); 10 Sep 2017 07:39:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Sep 2017 07:39:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18195 invoked by uid 111); 10 Sep 2017 07:40:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Sep 2017 03:40:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Sep 2017 03:39:28 -0400
Date:   Sun, 10 Sep 2017 03:39:28 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/12] Clean up notes-related code around `load_subtree()`
Message-ID: <20170910073928.ys4nbap76tmiurjh@sigill.intra.peff.net>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
 <20170909103131.pppm346qbj2cdxuo@sigill.intra.peff.net>
 <2b7c0053-bf7a-fbdd-3cf9-39b5d9a962c3@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b7c0053-bf7a-fbdd-3cf9-39b5d9a962c3@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 06:45:08AM +0200, Michael Haggerty wrote:

> > So nothing to see here, but since I spent 20 minutes scratching my head
> > (and I know others look at Coverity output and may scratch their heads
> > too), I thought it was worth writing up. And also if I'm wrong, it would
> > be good to know. ;)
> 
> Thanks for looking into this. I agree with your analysis.
> 
> I wonder whether it is the factor of two between path lengths and byte
> lengths that is confusing Coverity. Perhaps the patch below would help.
> It requires an extra, superfluous, check, but perhaps makes the code a
> tad more readable. I'm neutral on whether we would want to make the change.

Yeah, I do agree that it makes the code's assumptions a bit easier to
follow.

> Is there a way to ask Coverity whether a hypothetical change would
> remove the warning, short of merging the change to master?

You can download and run the build portion of the coverity tools
yourself. IIRC, that pushes the build up to their servers which then do
the analysis (you can make your own "project", or use the existing "git"
project -- I checked and you are already listed as an admin). I recall
it being a minor pain to get it set up, but not too bad.

Stefan runs it against "pu" on a regular basis, which is where the
emailed results come from. So just having Junio merge it to "pu" would
be enough to get results.

I noticed that they now have some GitHub/Travis integration:

  https://scan.coverity.com/github

I'm not sure if that is new, or if we just didn't notice it before. ;)
But that probably makes more sense to use than ad-hoc uploading (and
maybe it would make it easy for you to test personal branches, too).

-Peff
