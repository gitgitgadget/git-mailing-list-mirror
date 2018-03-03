Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1511F404
	for <e@80x24.org>; Sat,  3 Mar 2018 05:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeCCF5S (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 00:57:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:45344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750924AbeCCF5R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 00:57:17 -0500
Received: (qmail 8100 invoked by uid 109); 3 Mar 2018 05:57:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 05:57:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3421 invoked by uid 111); 3 Mar 2018 05:58:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 00:58:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 00:57:15 -0500
Date:   Sat, 3 Mar 2018 00:57:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
Message-ID: <20180303055715.GH27689@sigill.intra.peff.net>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
 <20180302070434.GG238112@aiede.svl.corp.google.com>
 <20180302104608.GB11074@sigill.intra.peff.net>
 <xmqq1sh2e7w1.fsf@gitster-ct.c.googlers.com>
 <20180302165543.GA4616@sigill.intra.peff.net>
 <xmqqo9k6csan.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9k6csan.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 02, 2018 at 09:15:44AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That's probably a reasonable sanity check, but I think we need to abort
> > and not just have a too-small DISPLAY array. Because later code like the
> > hunk-splitting is going to assume that there's a 1:1 line
> > correspondence. We definitely don't want to end up in a situation where
> > we show one thing but apply another.
> 
> Yes, agreed completely.

Let's add this sanity check while we're thinking about it. Here's a
series.

  [1/2]: t3701: add a test for interactive.diffFilter
  [2/2]: add--interactive: detect bogus diffFilter output

 git-add--interactive.perl  |  8 ++++++++
 t/t3701-add-interactive.sh | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

-Peff
