Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60FAD1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 05:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbeFKF4m (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 01:56:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:41024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753866AbeFKF4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 01:56:41 -0400
Received: (qmail 5389 invoked by uid 109); 11 Jun 2018 05:56:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 05:56:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13542 invoked by uid 111); 11 Jun 2018 05:56:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 01:56:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 01:56:39 -0400
Date:   Mon, 11 Jun 2018 01:56:39 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
Message-ID: <20180611055639.GA28598@sigill.intra.peff.net>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
 <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
 <87bmck4gip.fsf@evledraar.gmail.com>
 <20180609065635.GE30224@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1806092200490.77@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1806092200490.77@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 10:05:49PM +0200, Johannes Schindelin wrote:

> > E.g., could we have a flag or environment variable to have the existing
> > traces output JSON? I guess right now they're inherently free-form via
> > trace_printf, so it would involve adding some structured interface
> > calls. Which is more or less what I guess JeffH's proposed feature to
> > look like.
> 
> I think that is a much larger project than what JeffHost proposed, and
> would unfortunately put too much of a brake on his project.

I definitely don't want to stall somebody else's momentum with a bunch
of what-if's. But I also don't want to end up down the road with two
nearly-identical systems for tracing information. That's confusing to
users, and to developers who must choose which system to use for any new
tracing information they add.

So I think it's worth at least giving a little thought to how we might
leverage similarities between the trace system and this. Even if we
don't implement it now, it would be nice to have a vague sense of how
they could grow together in the long run.

-Peff
