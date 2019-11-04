Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722051F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfKDTuz (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:50:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:38552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728321AbfKDTuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:50:55 -0500
Received: (qmail 3889 invoked by uid 109); 4 Nov 2019 19:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Nov 2019 19:50:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6067 invoked by uid 111); 4 Nov 2019 19:54:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2019 14:54:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Nov 2019 14:50:53 -0500
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191104195053.GA20900@sigill.intra.peff.net>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
 <8b9021fa-f60c-a2e0-1174-a2fc1f11c476@gmail.com>
 <nycvar.QRO.7.76.6.1910311229150.46@tvgsbejvaqbjf.bet>
 <9aa1cefc-daeb-e702-95ba-1e83f8f7dcfe@iee.email>
 <20191031154217.GA30187@sigill.intra.peff.net>
 <49625b39-61dc-f702-eeba-9bdec60a42d1@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49625b39-61dc-f702-eeba-9bdec60a42d1@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 03, 2019 at 05:56:04PM +0000, Philip Oakley wrote:

> > Then upstream comparisons, "git rebase" etc without arguments, do what I
> > want: compare against master. And "git push" without arguments does what
> > I want: push this branch to my fork. And if I need to refer to the
> > pushed version for some reason (e.g., comparing what I just changed to
> > what I last sent out, "git range-diff @{u} @{push} HEAD" does the right
> > thing.
> 
> I am trying to write myself some 'user' based notes covering the
> publish-backup-collaborate-upstream viewpoints of the different repo
> settings as the config pages rarely give that viewpoint (hence my bad
> setup).
> 
> There's also still the 'triangle' workflow to clarify - does it refer to
> patch based flow, or to a three-way repo config?

I think it's solely about the three-way repo config. The key thing is
that "somehow" the commits I push to my fork end up in the upstream
repository. In git.git, that happens via the mailing list workflow. But
in projects based on GitHub, it's cross-fork pull requests. I guess in a
project like linux.git, it could even via real "git pull" commands.

But in any of those cases, the config I showed would be what you want.
(I forgot to show that I also set push.default to "current", since the
default "simple" wouldn't make much sense).

> I suspect there are more configs that need setting up for a proper stable
> user experience (e.g. the merge setting of '--ff-only' when the local branch
> "--follow"s the upstream but should never have local changes).

Possibly. I don't actually keep a regular "master" branch in my local
clone. I use "origin/master" as the upstream base for my branches, and
for when I need to test the current vanilla behavior to reproduce a bug
(I just "git checkout origin/master" and work on a detached HEAD).

If you did keep such a branch, though, then yeah, I think you'd want to
use --ff-only, because it's just tracking upstream.

-Peff
