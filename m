Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4075D202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbdJTWqL (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 18:46:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:59490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752469AbdJTWqK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 18:46:10 -0400
Received: (qmail 26727 invoked by uid 109); 20 Oct 2017 22:46:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 22:46:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20739 invoked by uid 111); 20 Oct 2017 22:46:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 18:46:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 18:46:08 -0400
Date:   Fri, 20 Oct 2017 18:46:08 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/3] t5615: avoid re-using descriptor 4
Message-ID: <20171020224608.3ataitvdq5r33iih@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
 <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net>
 <CAGZ79kYTmUnM+fcf222-cvwB3Fg4+J_xy28E7A3AYryx4qDf_w@mail.gmail.com>
 <20171019232337.zfd7occtjboem7f4@sigill.intra.peff.net>
 <20171020055058.s5dgxyfjnqtlxv4d@sigill.intra.peff.net>
 <CAGZ79kaSu+nHHntFPWbkXk1TC4ys9htesRg9HHXcpK+Y6MwZeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaSu+nHHntFPWbkXk1TC4ys9htesRg9HHXcpK+Y6MwZeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 02:27:40PM -0700, Stefan Beller wrote:

> > So I dunno. It does solve the problem in a way that the individual test
> > scripts wouldn't have to care about. But it's a lot of eval trickery.
> 
> I agree. Maybe just stick with the original patch?

OK. Why don't we live with that for now, then. The only advantage of the
"999" trickery is that it's less likely to come up again. If it doesn't,
then we're happy. If it does, then we can always switch then.

I also noticed that our GIT_TRACE=4 trickery has the same problem (it
didn't trigger in the t5615 case because it doesn't actually run git
inside the subshell). If we end up doing a "999" descriptor eventually,
we should probably point GIT_TRACE at it, too.

-Peff
