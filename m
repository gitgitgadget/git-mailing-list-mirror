Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F359320248
	for <e@80x24.org>; Thu, 21 Mar 2019 21:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfCUVsa (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 17:48:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:60030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725999AbfCUVsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 17:48:30 -0400
Received: (qmail 26410 invoked by uid 109); 21 Mar 2019 21:48:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 21:48:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13848 invoked by uid 111); 21 Mar 2019 21:48:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 17:48:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 17:48:28 -0400
Date:   Thu, 21 Mar 2019 17:48:28 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] t5551: delete auth-for-pack-but-not-refs test
Message-ID: <20190321214827.GA22582@sigill.intra.peff.net>
References: <20190321200231.GD19427@sigill.intra.peff.net>
 <20190321202435.19140-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321202435.19140-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 01:24:35PM -0700, Jonathan Tan wrote:

> > The test you're deleting is basically just verifying that our apache
> > config is indeed "half-auth". Because in v0, the server is never even
> > going to ask for credentials, so no interesting code paths in the client
> > are triggered. So it's not actually testing anything of interest.
> 
> If both of us want to drop this test, that's great :-) but for
> clarification: in addition to verifying that our apache config is
> "half-auth", this test also verifies that in a no-op fetch, we don't hit
> the path that is guarded by an authentication requirement. This seems
> significant to me in light of the link you provided in your prior email
> [1].

Yeah, I suppose it does. I just never really thought of that as a
plausible regression to introduce, given the way the v0 protocol works. :)

Although in a sense it is interesting, because it did reveal something
about v2 that we hadn't considered. I don't think it's worth addressing
(especially now), but had we been doing cross-protocol tests sooner, we
might have looked at it more in the design phase.

So I would also be OK with just marking it as as v0-only test.

-Peff
