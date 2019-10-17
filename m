Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFDB1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 06:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404747AbfJQGYf (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 02:24:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:50504 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727653AbfJQGYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 02:24:35 -0400
Received: (qmail 21096 invoked by uid 109); 17 Oct 2019 06:24:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 06:24:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6215 invoked by uid 111); 17 Oct 2019 06:27:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 02:27:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 02:24:34 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     stolee@gmail.com, git@vger.kernel.org, mh@glandium.org
Subject: Re: [PATCH 3/6] index-pack: remove redundant child field
Message-ID: <20191017062433.GC10862@sigill.intra.peff.net>
References: <67ca2f70-361a-bebd-7590-37337959552c@gmail.com>
 <20191010190229.100750-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010190229.100750-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 12:02:29PM -0700, Jonathan Tan wrote:

> > On 10/9/2019 7:44 PM, Jonathan Tan wrote:
> > > Instead, recompute ancestry if we ever need to reclaim memory.
> > 
> > I find this message lacking in important details:
> > 
> > 1. Where do we recompute ancestry?
> > 2. What are the performance implications of this change?
> > 3. Why is it important that you construct a stack of deltas in prune_base_data()?
> 
> Thanks for taking a look at this. My original plan (as I perhaps badly
> explained in the cover letter [1]) was to show the individual small
> steps that I took to reach the end goal, each step still passing all
> tests, in the hope that small steps are easier to understand than one
> big one. Hence why I didn't explain much in this commit message (and
> others), because I thought that I might have to squash them later. But
> perhaps that is too confusing and I should have just squashed them in
> the first place (and explain all the changes in the commit message -
> it's +177 -198, which is not too big anyway).

FWIW, I like the breakdown. These are tricky cleanups, and seeing them
individually makes it easy to verify that they don't themselves break
anything. I think they just need more explanation.

-Peff
