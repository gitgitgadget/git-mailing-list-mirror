Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488FEC636CC
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 01:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBNBkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 20:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBNBkj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 20:40:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28009E3B1
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 17:40:39 -0800 (PST)
Received: (qmail 24098 invoked by uid 109); 14 Feb 2023 01:40:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 01:40:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27729 invoked by uid 111); 14 Feb 2023 01:40:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Feb 2023 20:40:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Feb 2023 20:40:37 -0500
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] fetch: support hideRefs to speed up connectivity
 checks
Message-ID: <Y+rmlcRoP1aMioTC@coredump.intra.peff.net>
References: <20230209122857.M669733@dcvr>
 <20230212090426.M558990@dcvr>
 <Y+qjRZTn7DNib1uB@coredump.intra.peff.net>
 <13cef8e7-71af-27a5-77a3-a08f75720d1a@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13cef8e7-71af-27a5-77a3-a08f75720d1a@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 11:30:35PM +0000, Philip Oakley wrote:

> On 13/02/2023 20:53, Jeff King wrote:
> > On Sun, Feb 12, 2023 at 09:04:26AM +0000, Eric Wong wrote:
> >
> >>  Sidenote: I'm curious about the reason $(pwd) is used in some
> >>  places while $PWD seems fine in others, so it doesn't seem to be
> >>  a portability problem.  I chose $PWD since it's faster.
> > It sometimes matters; one is a Windows path (with "C:\", etc) and one is
> > a Unix-style path. Many spots are happy with either type, but it
> > sometimes bites us when doing string comparisons, or in a few specific
> > cases. See
> >
> >   https://lore.kernel.org/git/d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org/
> >
> > for an example.
> >
> There is guidance in t/README L680-684 though it maybe not that easy to
> spot.
> 
> A more recent patch was
> https://lore.kernel.org/git/4f5c5633-f5a2-3c99-329e-3057b8d447d2@kdbg.org/
> with slightly more details.

Thanks, both explanations are much better than the one I found (my
digging in the archive consisted of "I know JSixt has corrected me on
this at least once...").

-Peff
