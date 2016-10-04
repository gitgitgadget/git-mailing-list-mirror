Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE39A207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 00:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbcJDAww (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 20:52:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:51656 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbcJDAwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 20:52:51 -0400
Received: (qmail 2622 invoked by uid 109); 4 Oct 2016 00:52:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 00:52:51 +0000
Received: (qmail 32115 invoked by uid 111); 4 Oct 2016 00:53:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:53:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 20:52:48 -0400
Date:   Mon, 3 Oct 2016 20:52:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #01; Mon, 3)
Message-ID: <20161004005247.sgeqgw3accn3whgi@sigill.intra.peff.net>
References: <xmqqtwct3w0p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwct3w0p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 03:31:02PM -0700, Junio C Hamano wrote:

> * lt/abbrev-auto (2016-10-03) 3 commits
>   (merged to 'next' on 2016-10-03 at bb188d00f7)
>  + abbrev: auto size the default abbreviation
>  + abbrev: prepare for new world order
>  + abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing
>  (this branch uses jk/ambiguous-short-object-names.)
> 
>  Allow the default abbreviation length, which has historically been
>  7, to scale as the repository grows.  The logic suggests to use 12
>  hexdigits for the Linux kernel, and 9 to 10 for Git itself.
> 
>  Will merge to 'master'.

I kind of expected this one to cook in next for a bit while people
decided whether the larger hashes were irritating or not. Despite
working on the implementation, I'm on the fence myself.

I'd kind of hoped people would play with core.disambiguate and the hints
and see if they still actually wanted to bump the default abbrev (and
how aggressively to do so; if core.disambiguate means most of the
ambiguity is just between commits, that cuts the number of
collision-interesting objects by an order of magnitude).

> * jk/pack-objects-optim-mru (2016-08-11) 4 commits
>   (merged to 'next' on 2016-09-21 at 97b919bdbd)
>  + pack-objects: use mru list when iterating over packs
>  + pack-objects: break delta cycles before delta-search phase
>  + sha1_file: make packed_object_info public
>  + provide an initializer for "struct object_info"
> 
>  Originally merged to 'next' on 2016-08-11
> 
>  "git pack-objects" in a repository with many packfiles used to
>  spend a lot of time looking for/at objects in them; the accesses to
>  the packfiles are now optimized by checking the most-recently-used
>  packfile first.
> 
>  Will hold to see if people scream.

This has been in next for 6 weeks. Is it time to consider graduating it?

-Peff
