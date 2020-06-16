Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F75C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D525F20B1F
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbgFPQAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:00:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:33442 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732614AbgFPQAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 12:00:06 -0400
Received: (qmail 23482 invoked by uid 109); 16 Jun 2020 16:00:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 16:00:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14199 invoked by uid 111); 16 Jun 2020 16:00:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 12:00:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 12:00:05 -0400
From:   Jeff King <peff@peff.net>
To:     Oleg <lego_12239@rambler.ru>
Cc:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616160005.GB667151@coredump.intra.peff.net>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200616145207.GA13998@legohost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616145207.GA13998@legohost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 05:52:52PM +0300, Oleg wrote:

> On Tue, Jun 16, 2020 at 10:31:07AM -0400, Jeff King wrote:
> > stopping at configurability is the least risky thing there. But it's
> > clear that a lot of projects are interested in changing their names, so
> 
> Jeff, where do you get your statistics? github, for example, have around
> 100 million repos. How many of them want to do it?

Not statistics, but anecdotally, many major projects and communities
have expressed interest in switching. Some of them are listed here:

  https://www.zdnet.com/article/github-to-replace-master-with-alternative-term-to-avoid-slavery-references/

I don't think 100 million is the right number to think about. Many of
those aren't active, or aren't collaborative. A project like Chrome
changing their branch name has a much bigger impact than somebody's
homework repo with three commits.

I was curious about some raw numbers, though, so I picked a random
sample of ~25k GitHub repositories that had been pushed to in the last
30 days.  About 6% have a default branch name besides "master". There's
a long tail of names. "develop", "dev", and "development" were the most
common (and likely have been that way for a while due to documents like
git-flow). Only about ~0.12% were "main" right now, but that name has
also only been discussed for about a week.

But it seems to me that with 6% non-master names, most tools are going
to run into these cases sooner or later, and have to deal with it. I'd
be much more worried about one-off scripts that see a small, non-uniform
set of repositories.

I'm also worried about documentation. There's 15 years of information
floating around the Internet that mention "master". But it would
certainly not be the first time that documentation has bit-rotted.
There's a human cost there. On the other hand, some people have
expressed that "main" might be more clear than "master", baggage aside,
so it could be an improvement in that sense. I don't have an opinion
there, having internalized Git's terminology many years ago.

> I have a better suggestion, imho. Let's make "master" a default name. Thus:
> 
> 1. we willn't break utilities and user hopes; this is a backward compatibility.
> 2. we will see how many projects really need this "feature".
> 
> I think backward compatibility is a reasonable and useful thing. And if this is
> not a political-driven changes, i see no technical reason to not do so.

I think it's clear that this _is_ a politically-driven change. It is not
helping the software in any technical way to change the name. The
question is whether the more abstract benefits to people are worth the
potential costs.

But I don't think anybody has been able to quantify the benefits in a
meaningful way. Or at least a way that everyone agrees on.

-Peff
