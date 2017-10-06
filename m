Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED8A1FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 06:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750883AbdJFGFq (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 02:05:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:34826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750791AbdJFGFp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 02:05:45 -0400
Received: (qmail 10797 invoked by uid 109); 6 Oct 2017 06:05:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 06:05:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2926 invoked by uid 111); 6 Oct 2017 06:05:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 02:05:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 02:05:43 -0400
Date:   Fri, 6 Oct 2017 02:05:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        t.gummerer@gmail.com, jrnieder@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/2] entry.c: check if file exists after checkout
Message-ID: <20171006060542.llx4golnkuxksy7z@sigill.intra.peff.net>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
 <20171005104407.65948-3-lars.schneider@autodesk.com>
 <20171005112355.lsoqxybgsovpqriy@sigill.intra.peff.net>
 <xmqqlgkoyk8n.fsf@gitster.mtv.corp.google.com>
 <20171006045640.vihagnlnuximzmjs@sigill.intra.peff.net>
 <xmqqd160x16i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd160x16i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 03:03:49PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't know if we wanted to capture any of the reasoning behind using
> > error() here or not. Frankly, I'm not sure how to argue for it
> > succinctly. :) I'm happy with letting it live on in the list archive.
> 
> Are you talking about the "philosophical" thing?

Right, whether we ought to just mark the entry as stat-dirty and return
success.

> Because we cannot quite tell between the two cases (one is error--we
> wrote or we thought we wrote, but we cannot find it, the other is
> dubious--somebody was racing with us in the filesystem), I think it
> is reasonable to err on the safer side, even though an error abort
> while doing "as we know we wrote the thing that match the index, we
> might as well lstat and mark the cache entry as up-to-date" might be
> a bit irritating.

OK. I can live with that line of thought.

-Peff
