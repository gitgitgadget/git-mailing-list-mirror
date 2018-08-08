Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55051F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeHIBPS (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 21:15:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:47690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729997AbeHIBPS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 21:15:18 -0400
Received: (qmail 17637 invoked by uid 109); 8 Aug 2018 22:53:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 22:53:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4087 invoked by uid 111); 8 Aug 2018 22:53:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 18:53:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 18:53:28 -0400
Date:   Wed, 8 Aug 2018 18:53:28 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] chainlint: improve robustness against "unusual"
 shell coding
Message-ID: <20180808225327.GD3902@sigill.intra.peff.net>
References: <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180807082135.60913-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180807082135.60913-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 07, 2018 at 04:21:30AM -0400, Eric Sunshine wrote:

> This series improves chainlint's robustness when faced with the sort of
> unusual shell coding in contrib/subtree/t7900 which triggered a
> false-positive, as reported by Jonathan[1]. Jonathan has already
> rewritten[2] that code to be cleaner and more easily understood (and,
> consequently, to avoid triggering the false-positive), thus the
> improvements in this series are not strictly necessary.
> 
> Nevertheless, it seems prudent to make chainlint more robust against
> such unusual coding as an aid to future less-experienced test writers,
> making it less likely for them to trigger a false-positive and waste
> time trying to decipher a non-existent problem (in their code).
> 
> In [3], I said that 'sed' couldn't "be coerced" into dealing with nested
> here-docs with arbitrary tag names (explaining why it recognized only a
> "blessed" set of hard-coded names). However, I put a bit of thought into
> it and figured out how to do it. Patch 1/5 is the result.
> 
> This applies atop 'master'.

I had two minor comments on the first patch. I'll admit my eyes glazed
over looking at the rest of them, and to make any kind of intelligent
review I'd need to spend an hour understanding how the sed script works.
Which frankly, I'm not sure is worth it. Given the empirical results
(both on the real code base and the new tests you add) and the low-risk
nature (it's linting our tests, after all, not code users run), I'd be
inclined to say it's not making anything worse, and probably making
things better. We can find out about any further short-comings in the
wild.

-Peff
