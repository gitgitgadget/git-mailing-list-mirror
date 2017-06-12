Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEF120C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbdFLVaF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:30:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:38519 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752401AbdFLVaE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:30:04 -0400
Received: (qmail 2424 invoked by uid 109); 12 Jun 2017 21:30:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 21:30:04 +0000
Received: (qmail 16442 invoked by uid 111); 12 Jun 2017 21:30:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:30:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 17:30:02 -0400
Date:   Mon, 12 Jun 2017 17:30:02 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv2.1] revision.h: turn rev_info.early_output back into an
 unsigned int
Message-ID: <20170612213002.d3t2tamct3vkz7un@sigill.intra.peff.net>
References: <20170610064102.w4kp6omxdznfe7fa@sigill.intra.peff.net>
 <20170610114101.21026-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170610114101.21026-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 01:41:01PM +0200, SZEDER Gábor wrote:

> rev_info.early_output started out as an unsigned int in cdcefbc97 (Add
> "--early-output" log flag for interactive GUI use, 2007-11-03), but
> later it was turned into a single bit in a bit field in cc243c3ce
> (show: --ignore-missing, 2011-05-18) without explanation, though the
> code using it still expects it to be a regular integer type and uses
> it as a counter.  Consequently, any even number given via
> '--early-output=<N>', or indeed a plain '--early-output' defaulting to
> 100 effectively disabled the feature.
> 
> Turn rev_info.early_output back into its origin unsigned int data
> type, making '--early-output' work again.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> 
> > But the "users still expect" bit was a bit subtle to me, as I thought
> > you meant users of Git. But you mean that the feature itself is not a
> > boolean, but rather an integer count of how much early output to show.
> 
> Yeah, I wrote "callsites" first, but then realized it's not a
> function...
> 
> Here is the same patch with an updated commit message now saying "code
> using it" and "used as a counter" to make it clearer.  It also
> mentions that an argumentless '--early-output' turns off the feature,
> too.
> 
> I won't resend the rest of the series.

Thanks, this version is much more clear.

-Peff
