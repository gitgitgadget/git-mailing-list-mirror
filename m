Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4EB21F406
	for <e@80x24.org>; Fri, 15 Dec 2017 10:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbdLOKIj (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 05:08:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:40512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752690AbdLOKIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 05:08:38 -0500
Received: (qmail 32235 invoked by uid 109); 15 Dec 2017 10:08:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Dec 2017 10:08:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8120 invoked by uid 111); 15 Dec 2017 10:09:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 15 Dec 2017 05:09:01 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Dec 2017 05:08:35 -0500
Date:   Fri, 15 Dec 2017 05:08:35 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Jameson Miller <jameson.miller81@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Question about the ahead-behind computation and status
Message-ID: <20171215100835.GC3567@sigill.intra.peff.net>
References: <030bf57c-7a23-3391-4fc0-93efee791543@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <030bf57c-7a23-3391-4fc0-93efee791543@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 14, 2017 at 04:49:31PM -0500, Jeff Hostetler wrote:

> I don't want to jump into the graph algorithm at this time,
> but was wondering about adding a --no-ahead-behind flag (or
> something similar or a config setting) that would disable
> the a/b computation during status.
> 
> For status V2 output, we could omit the "# branch.ab x y"
> line.  For normal status output, change the prose a/b
> message to say something like "are [not] up to date".

Is it actually "status --porcelain=v2" that you care about here? Or is
it normal "git status"?

Do you care about seeing the branch at all? I.e., would "--no-branch" be
a viable option (though I notice it seems to be a silent noop with the
long-form, which should probably be fixed).

If you really do want to see all branch details but just skip the
ahead/behind, then yeah, I'd agree that adding an option to do so makes
sense. Is "status" the only command that needs it? I think we do it
unconditionally with "git checkout", too.

> [*] Sadly, the local repo was only about 20 days out of
>     date (including the Thanksgiving holidays)....

Taking 20 seconds to traverse 20 days worth of history sounds pretty
awful. How many commits is it?

-Peff
