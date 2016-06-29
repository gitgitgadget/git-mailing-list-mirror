Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B1220FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbcF2Voe (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:44:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:37977 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751590AbcF2Vod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 17:44:33 -0400
Received: (qmail 1327 invoked by uid 102); 29 Jun 2016 21:43:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Jun 2016 17:43:49 -0400
Received: (qmail 30991 invoked by uid 107); 29 Jun 2016 21:44:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Jun 2016 17:44:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Jun 2016 17:43:44 -0400
Date:	Wed, 29 Jun 2016 17:43:44 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
Message-ID: <20160629214343.GA3682@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZNnbrKFaKGchZ0r5wKCs7pz4RcyYq=0rnD5qSd8XDKXw@mail.gmail.com>
 <CAGZ79kbjntaTQPNdw9u07AJX3pTWdyKB1fiPqJZ=DZRzNvnKzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbjntaTQPNdw9u07AJX3pTWdyKB1fiPqJZ=DZRzNvnKzg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 02:37:17PM -0700, Stefan Beller wrote:

> On Wed, Jun 29, 2016 at 1:54 PM, Stefan Beller <sbeller@google.com> wrote:
> > Chances are that the 10 years of history may be correct time wise as long
> > as people don't introduce a bad date malevolently.
> >
> 
> To answer my own speculation:
> Even git.git violates the timing property, so there is no hope to find
> many projects
> to have "parents committer date < committer date"

It's expected and reasonable for there to be some skew. People's clocks
aren't all perfectly synced. The question is one of how _much_ skew
you're willing to tolerate (and any algorithms obviously need to allow
that much, too).

In some places we allow 24 hours of skew between any two commits. In
others we allow up to 5 skewed commits in a row.

That may not be enough in general, though. E.g.:

> 619a644d6daef56d70aeca85514e2d281eb483a5

This one is a 3-day skew.

-Peff
