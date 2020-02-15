Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E412C352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 06:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEB42081E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 06:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgBOGsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 01:48:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:44140 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725822AbgBOGsU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 01:48:20 -0500
Received: (qmail 25657 invoked by uid 109); 15 Feb 2020 06:48:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 15 Feb 2020 06:48:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26768 invoked by uid 111); 15 Feb 2020 06:57:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Feb 2020 01:57:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Feb 2020 01:48:18 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/15] rev-list: make --count work with --objects
Message-ID: <20200215064818.GB1633703@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182220.GF150965@coredump.intra.peff.net>
 <20200215004216.GA15192@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200215004216.GA15192@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 04:42:16PM -0800, Taylor Blau wrote:

> On Fri, Feb 14, 2020 at 01:22:20PM -0500, Jeff King wrote:
> > The current behavior from "rev-list --count --objects" is nonsensical:
> > we enumerate all of the objects except commits, but then give a count of
> > commits. This wasn't planned, and is just what the code happens to do.
> >
> > Instead, let's give the answer the user almost certainly wanted: the
> > full count of objects.
> 
> This makes sense: I've often worried about introducing
> backwards-incompatible changes in newer versions of Git, even for
> behavior that didn't make sense to begin with.
> 
> Of course, backwards-incompatible changes *are* something worth worrying
> about, but I don't find that the behavior was sensible to begin with, so
> I don't have a problem "breaking" it if "breaking" means making
> something nonsensical behave correctly.

Yeah, I admit I'm guessing that nobody cares about the current behavior,
or that it was unplanned. But it seems sufficiently insane to me to take
a chance on.

> > +	if (revs->count) {
> > +		revs->count_right++;
> > +		return;
> > +	}
> > +
> 
> Hmm. This puzzled me at first. Do you think that it could benefit from a
> comment?

What would it say (i.e., I'm not sure what confused you)?

-Peff
