Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A5820248
	for <e@80x24.org>; Tue, 26 Mar 2019 15:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfCZPS2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 11:18:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:36572 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731774AbfCZPS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 11:18:28 -0400
Received: (qmail 14730 invoked by uid 109); 26 Mar 2019 15:18:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 15:18:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19896 invoked by uid 111); 26 Mar 2019 15:18:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 11:18:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 11:18:25 -0400
Date:   Tue, 26 Mar 2019 11:18:25 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] fetch-pack: respect --no-update-shallow in v2
Message-ID: <20190326151825.GA26167@sigill.intra.peff.net>
References: <cover.1553546216.git.jonathantanmy@google.com>
 <c4d2f409e246cce02ebfdb8c7110e3700d066ec8.1553546216.git.jonathantanmy@google.com>
 <20190326052011.GB1933@sigill.intra.peff.net>
 <CACsJy8BHBR2OAHjr-LO4HEmwrmga++5RS1K76qKnh36Hsw9Chw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BHBR2OAHjr-LO4HEmwrmga++5RS1K76qKnh36Hsw9Chw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 05:14:11PM +0700, Duy Nguyen wrote:

> > That seems like the best we can do without the protocol change. And even
> > if we adjust the protocol, we need some fallback behavior for existing
> > v2 servers, so this is worth doing.
> 
> Are people actually doing this (i.e. cloning from or  pushing to a
> shallow repo)? I added this with the intention that a big shallow repo
> (e.g. one year long history) is served as the common source to reduce
> server loads and everything, while the full/big repo is available but
> rarely needed. I never saw anyone complain about it (so, likely not
> using it).

I don't think I've ever seen anybody serve fetches out of a shallow
clone in practice (I don't think we ever seriously considered them at
GitHub, but given their general incompatibility with reachability
bitmaps, I suspect it would cause more performance problems than it
solves).

I've always imagined people do it for one-offs. E.g., they have a
shallow clone, and fetch out of that to a temporary copy. That may be
less useful these days with the advent of separate worktrees.

-Peff
