Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB9C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F752071A
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgFPQrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:47:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:33532 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgFPQrR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 12:47:17 -0400
Received: (qmail 23895 invoked by uid 109); 16 Jun 2020 16:47:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 16:47:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14678 invoked by uid 111); 16 Jun 2020 16:47:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 12:47:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 12:47:15 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616164715.GA678873@coredump.intra.peff.net>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 12:10:01PM -0400, Konstantin Ryabitsev wrote:

> On Tue, Jun 16, 2020 at 10:31:07AM -0400, Jeff King wrote:
> > 
> > My biggest concern here was trying to understand what could break.
> > Having read the patches from Johannes and thought about it a lot, I have
> > a pretty good handle on where Git itself cares about the name. And I
> > feel pretty confident that we can make the change in a way that won't
> > cause problems there (and in fact, I think some of the code will be
> > made more robust by relying on HEAD more appropriately).
> > 
> > There's a more open question of what _else_ will break in the ecosystem.
> 
> What if we work on making this configurable for now, but stick with the 
> legacy name until we introduce breaking sha1 changes? Almost everything 
> will need to retool for those anyway (and all documentation rewritten), 
> so it is reasonable to bundle these changes to happen at the same time.

I think that's a potential timetable we might use. It would be easier to
consider if we actually had a timetable for the sha1 changes. :)

But I certainly agree that if the timing works out favorably, switching
both defaults at once, with a big version number bump, would be nice.

I do think that the branch name change will have more far-reaching
effects on documentation than a hash change. Mostly because hashes are
random-looking garbage from a user's perspective anyway. So aside from
people dealing with hash transitions, we'll mostly just need to update
any hard-coded values in tutorials, examples, etc. Whereas I think the
word "master" creeps into a lot of more substantive discussions as a
synonym for "the main branch".

-Peff
