Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038871FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756161AbcKVR46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:56:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:46196 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755827AbcKVR45 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:56:57 -0500
Received: (qmail 7729 invoked by uid 109); 22 Nov 2016 17:55:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 17:55:52 +0000
Received: (qmail 30788 invoked by uid 111); 22 Nov 2016 17:56:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 12:56:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Nov 2016 12:55:51 -0500
Date:   Tue, 22 Nov 2016 12:55:51 -0500
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: v2.11 new diff heuristic?
Message-ID: <20161122175550.mlxzt3kgw3hj52qh@sigill.intra.peff.net>
References: <CAHd499AjXh1YnVgBj_8j0fgvOgOn53y+sPBBy6y7mSM-+dCyVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499AjXh1YnVgBj_8j0fgvOgOn53y+sPBBy6y7mSM-+dCyVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 08:42:36AM -0600, Robert Dailey wrote:

> I dug into the git diff documentation here:
> 
> https://git-scm.com/docs/git-diff
> 
> It mentions a "--compaction-heuristic" option. Is this the new
> heuristic outlined by the release notes? If not, which is it?

No. The docs on git-scm.com are only for released versions, so that is
the "old" attempt at a similar feature from v2.9. The "new" one goes by
the name "--indent-heuristic" (and "diff.indentHeuristic" in the
config). It is not the default in v2.11, but it probably will become so
in a future version.

> Is the
> compaction heuristic compatible with the histogram diff algorithm? Is
> there a config option to turn this on all the time? For that matter,
> is this something I can keep on all the time or is it only useful in
> certain situations?
> 
> There's still so much more about this feature I would like to know.

Yes, you can keep it all the time. Yes, it's compatible with histogram
(and patience); it happens as a separate post-processing step after the
actual diff.

You can find more discussion about how it works in the commit message of
433860f3d0beb0c6f205290bd16cda413148f098.

-Peff
