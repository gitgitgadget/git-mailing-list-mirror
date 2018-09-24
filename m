Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5194B1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 23:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeIYFTb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 01:19:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:58084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725843AbeIYFTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 01:19:31 -0400
Received: (qmail 16110 invoked by uid 109); 24 Sep 2018 23:14:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Sep 2018 23:14:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 799 invoked by uid 111); 24 Sep 2018 23:14:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 24 Sep 2018 19:14:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2018 19:14:56 -0400
Date:   Mon, 24 Sep 2018 19:14:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180924231455.GA7702@sigill.intra.peff.net>
References: <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
 <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
 <20180921213753.GA11177@sigill.intra.peff.net>
 <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
 <20180921221832.GC11177@sigill.intra.peff.net>
 <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
 <20180924181011.GA24781@sigill.intra.peff.net>
 <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
 <20180924205022.GA26936@sigill.intra.peff.net>
 <xmqqva6ur24y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqva6ur24y.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 02:55:57PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Do you have an opinion on whether for_each_alternate_refs() interface
> > should stop passing back refnames? By the "they may not even exist"
> > rationale in this sub-thread, I think it's probably foolish for any
> > caller to actually depend on the names being meaningful.
> 
> I personally do not mind they were all ".have" or unnamed.
> 
> The primary motivatgion behind for-each-alternate-refs was that we
> wanted to find more anchoring points to help the common ancestry
> negotiation and for-each-*-ref was the obvious way to do so; the
> user did not care anything about names.

Right, I think that is totally fine for the current uses. I guess my
question was: do you envision cutting the interface down to only the
oids to bite us in the future?

I was on the fence during past discussions, but I think I've come over
to the idea that the refnames actively confuse things.

-Peff
