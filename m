Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69251F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 21:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932661AbcHXVe4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 17:34:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:60769 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932115AbcHXVez (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 17:34:55 -0400
Received: (qmail 27737 invoked by uid 109); 24 Aug 2016 21:34:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 21:34:54 +0000
Received: (qmail 7245 invoked by uid 111); 24 Aug 2016 21:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 17:34:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 17:34:50 -0400
Date:   Wed, 24 Aug 2016 17:34:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #08; Wed, 24)
Message-ID: <20160824213450.eo6hlmt4oly6gwih@sigill.intra.peff.net>
References: <xmqqy43lookt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy43lookt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 02:16:02PM -0700, Junio C Hamano wrote:

> * jk/pack-objects-optim-mru (2016-08-11) 4 commits
>   (merged to 'next' on 2016-08-11 at c0a7dae)
>  + pack-objects: use mru list when iterating over packs
>  + pack-objects: break delta cycles before delta-search phase
>  + sha1_file: make packed_object_info public
>  + provide an initializer for "struct object_info"
> 
>  "git pack-objects" in a repository with many packfiles used to
>  spend a lot of time looking for/at objects in them; the accesses to
>  the packfiles are now optimized by checking the most-recently-used
>  packfile first.
> 
>  Will hold to see if people scream.

Just a note that we've been running with this at GitHub on all of our
servers for a bit over a week, and no screaming yet. That's not
necessarily proof of anything, but it does make the audience of "people"
a bit bigger than just "next", as we run quite a few invocations of
pack-objects in a day.

I don't think that changes anything in the near future, since this is
obviously not for v2.10, but barring any complaints, it's probably a
reasonable topic to consider for the version after (and of course I'll
relay any issues we come across on our servers).

I'm planning to deploy the delta-cache topic soon, too, so that should
give it some good exercise.

-Peff
