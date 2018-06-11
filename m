Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08ED31F403
	for <e@80x24.org>; Mon, 11 Jun 2018 08:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeFKIbC (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 04:31:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:41148 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754010AbeFKIbB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 04:31:01 -0400
Received: (qmail 11068 invoked by uid 109); 11 Jun 2018 08:31:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 08:31:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14089 invoked by uid 111); 11 Jun 2018 08:31:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 04:31:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 04:30:58 -0400
Date:   Mon, 11 Jun 2018 04:30:58 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
Message-ID: <20180611083058.GA1592@sigill.intra.peff.net>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
 <900a34bb-4d8b-4a22-a0f5-1d2f6df84945@kdbg.org>
 <20180610000056.GD38834@genre.crustytoothpaste.net>
 <20180611061441.GC28598@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611061441.GC28598@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 02:14:41AM -0400, Jeff King wrote:

> On Sun, Jun 10, 2018 at 12:00:57AM +0000, brian m. carlson wrote:
> 
> > I also have to look at this issue from the interests of what is best for
> > the FLOSS community and for users as a whole.  Adding in functionality
> > that sends off usage data from a command-line tool, especially one that
> > is as widely used as Git is, is not in the interests of users as a
> > whole, nor is it common practice in FLOSS tools.
> 
> I'm not sure if this last statement is true. For instance, many tools
> have crash-reporting functionality, and some contain more advanced
> telemetry. E.g.:
> 
>   https://wiki.mozilla.org/Telemetry
> 
> Personally I do not like this sort of data collection at all, and never
> enable it. And I would be highly suspicious of any FLOSS tool that
> shipped with it enabled by default. But it seems like at least some
> projects _do_ find it useful, and enough people enable it to make it
> worth carrying as a feature.

Re-reading what I wrote, I really want to emphasize something so that it
isn't missed. I think the important feature here is user consent, and
that seems to be the line that projects like Mozilla use (default to
off, and require explicit consent before sending anything off-host).

We don't have to use that line. I think "do not collect even locally" is
a reasonable line, because even collecting has performance and storage
management implications. And I don't think anybody is proposing to even
collect local telemetry without the user turning it on.

The line under discussion seems to be "implement code to collect
anything at all". That's a valid line, too, but IMHO it ends up blocking
useful features (and I think we already violate it with things like
GIT_TRACE!).

-Peff
