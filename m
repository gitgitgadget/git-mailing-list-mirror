Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167B220899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbdHNXIc (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:08:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:38748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752816AbdHNXIc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:08:32 -0400
Received: (qmail 30391 invoked by uid 109); 14 Aug 2017 23:08:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 23:08:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6911 invoked by uid 111); 14 Aug 2017 23:08:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 19:08:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 19:08:30 -0400
Date:   Mon, 14 Aug 2017 19:08:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/2] format-patch: have progress option while
 generating patches
Message-ID: <20170814230829.4elsuvosezybw3qn@sigill.intra.peff.net>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170810183256.12668-2-kewillf@microsoft.com>
 <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
 <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
 <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
 <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net>
 <xmqqpobyw11t.fsf@gitster.mtv.corp.google.com>
 <xmqqshguuhe2.fsf@gitster.mtv.corp.google.com>
 <20170814222947.edvuz7b2hxuwcsqj@sigill.intra.peff.net>
 <xmqq8tilu5yx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tilu5yx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 03:42:14PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If it's smooth, the (50,1) case is slightly nicer in that it puts the
> > progress in front of the user more quickly. I'm not sure if that's
> > actually worth pushing an additional decision onto the person writing
> > the calling code, though (especially when we are just now puzzling out
> > the method for making such a decision from first principles).
> >
> > So I'd vote to drop that parameter entirely. And if 1 second seems
> > noticeably snappier, then we should probably just move everything to a 1
> > second delay (I don't have a strong feeling either way).
> 
> Sounds like a good idea to me.  
> 
> I've already locally tweaked Kevin's patch to use (0,2) instead of
> (0,1) without introducing the simpler wrapper.  It should be trivial
> to do a wrapper to catch and migrate all the (0,2) users to a
> start_delayed_progress() that takes neither percentage or time with
> mechanical replacement.

I was actually proposing to move (50,1) cases to the simpler wrapper,
too. IOW, drop the delayed_percent_treshold code entirely.

-Peff
