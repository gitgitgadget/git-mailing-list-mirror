Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB12F1FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 07:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbdCIHLa (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 02:11:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:41073 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752657AbdCIHL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 02:11:28 -0500
Received: (qmail 27251 invoked by uid 109); 9 Mar 2017 07:04:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 07:04:40 +0000
Received: (qmail 22016 invoked by uid 111); 9 Mar 2017 07:04:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 02:04:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 02:04:39 -0500
Date:   Thu, 9 Mar 2017 02:04:39 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        markbt@efaref.net, benpeart@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH 02/10] pack-objects: add --partial-by-size=n
 --partial-special
Message-ID: <20170309070438.r5g2h5vlmgzds4kp@sigill.intra.peff.net>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-3-git-send-email-jeffhost@microsoft.com>
 <xmqqh93338s2.fsf@gitster.mtv.corp.google.com>
 <1c38ffbc-e4a2-32e5-d324-506c2111043e@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c38ffbc-e4a2-32e5-d324-506c2111043e@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 03:21:11PM -0500, Jeff Hostetler wrote:

> > And not ."gitmodules"?
> > 
> > What happens when we later add ".gitsomethingelse"?
> > 
> > Do we have to worry about the case where the set of git "special
> > files" (can we have a better name for them please, by the way?)
> > understood by the sending side and the receiving end is different?
> > 
> > I have a feeling that a mode that makes anything whose name begins
> > with ".git" excempt from the size based cutoff may generally be
> > easier to handle.
> 
> I forgot about ".gitmodules".  The more I think about it, maybe
> we should always include them (or anything starting with ".git*")
> and ignore the size, since they are important for correct behavior.

I'm also in favor of staking out ".git*" as "this is special and belongs
to Git".

A while back when we discussed whether to allow symlinks for
.gitattributes, etc, I think the consensus was to treat the whole
".git*" namespace consistently. I haven't followed up with patches yet,
but my plan was to go that route.

-Peff
