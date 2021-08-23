Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DCC432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8EA46136F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhHWR5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:57:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:56846 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhHWR5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:57:15 -0400
Received: (qmail 12579 invoked by uid 109); 23 Aug 2021 17:56:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Aug 2021 17:56:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31038 invoked by uid 111); 23 Aug 2021 17:56:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Aug 2021 13:56:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Aug 2021 13:56:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] multi-pack-index: fix *.rev cleanups with --object-dir
Message-ID: <YSPhTw6biUCxNrq6@coredump.intra.peff.net>
References: <20210823094049.44136-1-johannes@sipsolutions.net>
 <YSPHdofrDOQk3xmy@coredump.intra.peff.net>
 <be882704d7cf2a96a78c5c745c0bca2c53150a28.camel@sipsolutions.net>
 <YSPWQtOjKVgIKqsd@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSPWQtOjKVgIKqsd@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 01:09:22PM -0400, Taylor Blau wrote:

> On Mon, Aug 23, 2021 at 07:05:31PM +0200, Johannes Berg wrote:
> > On Mon, 2021-08-23 at 12:06 -0400, Jeff King wrote:
> > > I'm not entirely convinced that writing a midx when not "inside" a repo
> > > is something that we want to support. But if we do, then...
> >
> > Seemed like that was the point of --object-dir?
> 
> Stolee (cc'd) would know more as the original author, but as I recall
> the point of `--object-dir` was to be able to write a midx in
> directories which were acting as Git repositories, but didn't contain a
> `.git` directory.
> 
> It's kind of a strange use-case, but I recall that it was important at
> the time. Maybe he could shed more light on why. (Either way, we're
> stuck with it ;)).

And the point was that those directories would also be alternates of the
current repo (and that there is a current repo). That's one of the
things that your midx-bitmap series tightens.

-Peff
