Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE551F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbcHAR5J (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:57:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:52632 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753996AbcHAR5H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:57:07 -0400
Received: (qmail 7665 invoked by uid 102); 1 Aug 2016 17:28:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:28:54 -0400
Received: (qmail 15020 invoked by uid 107); 1 Aug 2016 17:29:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:29:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 13:28:51 -0400
Date:	Mon, 1 Aug 2016 13:28:51 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] pager: implement core.pagerEnv in config
Message-ID: <20160801172851.k2vtqwik2hkblr4e@sigill.intra.peff.net>
References: <20160801010557.22191-1-e@80x24.org>
 <20160801010557.22191-3-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160801010557.22191-3-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 01:05:57AM +0000, Eric Wong wrote:

> This allows overriding the build-time PAGER_ENV variable
> at run-time.
> 
> Inspired by part 1 of an idea from Kyle J. McKay at:
> https://public-inbox.org/git/62DB6DEF-8B39-4481-BA06-245BF45233E5@gmail.com/

This commit message is missing the "why" (I tried to get it from the
referenced email, but I am still confused).

What does this buy you over:

  GIT_PAGER='less -whatever-options-you-like'

? Sure, you have to say "less" there and not just "if we happen to be
using less, use these options with it". But that distinction is
important for a build-time default, not for a run-time one. And by
pointing people to GIT_PAGER, they can do a lot _more_ than they can
with PAGER_ENV, including the full power of the shell (brian gave an
example of "par | less" earlier; I use "diff-highlight | less").

-Peff
