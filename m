Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A9920248
	for <e@80x24.org>; Thu, 28 Mar 2019 02:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfC1CMT (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 22:12:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:38494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725948AbfC1CMT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 22:12:19 -0400
Received: (qmail 13351 invoked by uid 109); 28 Mar 2019 02:12:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Mar 2019 02:12:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2229 invoked by uid 111); 28 Mar 2019 02:12:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Mar 2019 22:12:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2019 22:12:17 -0400
Date:   Wed, 27 Mar 2019 22:12:17 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/5] progress: assemble percentage and counters in a
 strbuf before printing
Message-ID: <20190328021217.GC7887@sigill.intra.peff.net>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190325103844.26749-4-szeder.dev@gmail.com>
 <20190326054541.GD1933@sigill.intra.peff.net>
 <20190327102451.GC32732@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190327102451.GC32732@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 11:24:51AM +0100, SZEDER Gábor wrote:

> On Tue, Mar 26, 2019 at 01:45:41AM -0400, Jeff King wrote:
> > On Mon, Mar 25, 2019 at 11:38:42AM +0100, SZEDER Gábor wrote:
> > 
> > > The following patches in this series want to handle the progress bar's
> > > title and changing parts (i.e. the counter and the optional percentage
> > > and throughput combined) differently.
> > > 
> > > To prepare for those changes assemble the changing parts in a separate
> > > strbuf before printing.
> > 
> > Makes sense. Unlike the previous patch, we're already in the "slow path"
> > of the function here, so we don't need to worry about adding an extra
> > buffer (though do still think it's worth reusing the same buffer each
> > time, as you do here).
> 
> The commit message doesn't mention this, but the next patch needs the
> length of the previously displayed progress bar to properly clean up
> its remnants.  Or the length of its changing parts anyway.  So I could
> either add a 'prev_len' field to 'struct progress', or the whole
> strbuf.  The strbuf containing the throughput is already stored in
> there and reused, so I just followed suit.

Ah, right, that makes perfect sense. It is doubly a good idea, then. :)

-Peff
