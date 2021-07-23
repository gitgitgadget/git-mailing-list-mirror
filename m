Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD240C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A153660EE2
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhGWGuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:50:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:55362 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhGWGuI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 02:50:08 -0400
Received: (qmail 10146 invoked by uid 109); 23 Jul 2021 07:30:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 07:30:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22857 invoked by uid 111); 23 Jul 2021 07:30:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 03:30:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 03:30:41 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
Message-ID: <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
 <xmqqy29z9r94.fsf@gitster.g>
 <xmqqtukn9p0g.fsf@gitster.g>
 <60f8c8c92a215_1d0abb20859@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60f8c8c92a215_1d0abb20859@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 08:24:25PM -0500, Felipe Contreras wrote:

> I'm not trashing the current behavior, I'm explaining what the consensus
> is. I spent several man-days re-reading old threads, and this is the
> consensus of what should happen:
> 
>   1. git pull              # merge HEAD into upstream
>   2. git pull origin topic # merge topic into HEAD
> 
> Of the people that expressed an opinion, 100% of them stated that what
> `git pull` does in the first case today is not desirable.

I did not participate in the threads you linked earlier, so I am
probably not in that 100%. But you did use my name below:

> Yes, you are correct that if *everyone* followed the topic branch
> workflow, everything would work correctly, but that's not what happens
> in reality, in reality people do all kinds of workflows, and wrong
> merges are pervasive.
> 
> Everyone--including Linus, Jeff, and you--agree that there's two
> different ways of using `git pull`: integrator versus developer.
> 
> When a user is doing `git pull` to synchronize changes to push to the
> same branch, that's a centralized two-way workflow, so he is acting both
> as an integrator and as a developer, and it's in that particular case
> that the order of the parents should be reversed. Everyone agrees on
> that.
> 
> When the user the opposite explicitely: `git pull origin master`
> Linus calls it a "back-merge" [1], and in that case the order of the
> parents should not be reversed.

So I feel compelled to say now that I do not think that changing the
order of parents for "git pull" is the obviously correct thing to do.
And likewise, in the one thread I do remember participating in, I
expressed something similar:

  https://lore.kernel.org/git/20140502214817.GA10801@sigill.intra.peff.net/

-Peff
