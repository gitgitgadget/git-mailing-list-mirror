Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F22D20899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbdHBWPP (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:15:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:56228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751600AbdHBWPO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:15:14 -0400
Received: (qmail 2599 invoked by uid 109); 2 Aug 2017 22:15:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 22:15:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13859 invoked by uid 111); 2 Aug 2017 22:15:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 18:15:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 18:15:12 -0400
Date:   Wed, 2 Aug 2017 18:15:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Richard Jones <richardj@backbase.com>, git@vger.kernel.org
Subject: Re: Git log --tags isn't working as expected
Message-ID: <20170802221512.zvhaow326jq4vucc@sigill.intra.peff.net>
References: <CACq05g+4HH9L_fiFLR8php=w5JkqB0792SzR9EZU-o+QHuoM8A@mail.gmail.com>
 <20170802083200.3rmnz6mx2wfoarng@sigill.intra.peff.net>
 <xmqqa83idjlj.fsf@gitster.mtv.corp.google.com>
 <20170802173411.tu7wyuehcktxge6o@sigill.intra.peff.net>
 <xmqqd18dsoi1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd18dsoi1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2017 at 01:28:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > By the way, I noticed something funny that I forgot to mention:
> >
> >   git log --tags=does-not-exist
> >
> > shows HEAD, because the logic to kick in the default only asks "were we
> > given any refs to start the traversal?". I think it probably should
> > consider a wildcard with no matches to override the default, and show
> > nothing.
> >
> > I haven't decided if it should be empty-but-success, or give an error.
> 
> I agree.  The same for --branches, --glob, etc.  I'd say it should
> behave just like "git log HEAD..HEAD".

Thanks for confirming. That's the way I lean, too. And I found some
related tests for rev-list in t6018 that expect that, too (but are
currently marked to fail).

I'll send some patches in a minute, but I'll start a new thread, as
we've drifted off-topic for this one.

-Peff
