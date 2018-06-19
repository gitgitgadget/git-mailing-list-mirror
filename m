Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E8D1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 19:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030296AbeFSTL7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 15:11:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:48834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S967134AbeFSTL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 15:11:58 -0400
Received: (qmail 5111 invoked by uid 109); 19 Jun 2018 19:11:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Jun 2018 19:11:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16446 invoked by uid 111); 19 Jun 2018 19:12:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Jun 2018 15:12:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2018 15:11:56 -0400
Date:   Tue, 19 Jun 2018 15:11:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180619191156.GA21641@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
 <20180619174846.GA27820@sigill.intra.peff.net>
 <6ab94453-84ef-e269-c320-e102b02d6f3b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ab94453-84ef-e269-c320-e102b02d6f3b@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 08:50:16PM +0200, René Scharfe wrote:

> Negation causes the whole non-matching line to match, with --column
> reporting 1 or nothing in such a case, right?  Or I think doing the
> same when the operator is applied a second time is explainable.

Yes to your first question.

Regarding the final sentence, yes, I agree it's explainable. But I
thought that handling negation like this was one of the main complaints
of earlier iterations?

> When ORing multiple expressions I don't pay attention to their order
> as that operator is commutative.  Having results depend on that
> order would at least surprise me.

OK. Let's just disable the short-circuit for --column then (i.e., what
Taylor posted earlier). That's explainable, and I doubt the performance
implications are going to be all that noticeable.

-Peff
