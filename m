Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FA501FCA9
	for <e@80x24.org>; Mon, 12 Sep 2016 00:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755671AbcILAwe (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 20:52:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:41689 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754563AbcILAwe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 20:52:34 -0400
Received: (qmail 21933 invoked by uid 109); 12 Sep 2016 00:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 00:52:33 +0000
Received: (qmail 9577 invoked by uid 111); 12 Sep 2016 00:52:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 11 Sep 2016 20:52:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Sep 2016 20:52:30 -0400
Date:   Sun, 11 Sep 2016 20:52:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] ls-files: adding support for submodules
Message-ID: <20160912005229.6njhgfq7h6cb34s4@sigill.intra.peff.net>
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
 <xmqqh99o8ypm.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaWNykEAZcjZ2Y19j2_3TF+qcz+vb8zSi1U+me3k+06LA@mail.gmail.com>
 <xmqqmvje6qbe.fsf@gitster.mtv.corp.google.com>
 <20160912005106.fj7adhmtfklv4vir@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160912005106.fj7adhmtfklv4vir@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2016 at 08:51:06PM -0400, Jeff King wrote:

> On Sun, Sep 11, 2016 at 03:10:13PM -0700, Junio C Hamano wrote:
> 
> > So a "ls-files" that is done internally in the end-user facing "git
> > grep --recurse-submodules" needs to be run _without_ recursing
> > itself at least once to learn "lib/" is a submodule.  A flat "here
> > are everything we have" does not sound like a good building block.
> 
> I do not use submodules myself, but I could imagine that you may have
> scripts outside of git that do not care about the submodule divisions at
> all, and would be happy with the flat block. E.g., our "make tags"
> target uses "git ls-files" so find all of the source files. I could
> imagine projects with submodules that would want to do so recursively (I
> could also imagine projects that do _not_ want to do so; it would depend
> on your workflow and how tightly bound the submodules are). Another
> plausible example would be something grep-like that has features
> git-grep does not (I don't use "ack", but perhaps "git ls-files
> --recurse-submodules -z | xargs --null ack ..." is something people
> would want to do).

None of that negates your point, btw, which is that this does not seem
like a great building block for "git grep --recurse-submodules". Just
that it seems plausible to me that people could find recursive
"ls-files" useful on its own.

-Peff
