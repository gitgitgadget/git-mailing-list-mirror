Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25FE207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 05:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032036AbdDUFDg (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 01:03:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:37538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945761AbdDUFDf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 01:03:35 -0400
Received: (qmail 30008 invoked by uid 109); 21 Apr 2017 05:03:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 05:03:33 +0000
Received: (qmail 13731 invoked by uid 111); 21 Apr 2017 05:03:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 01:03:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 01:03:30 -0400
Date:   Fri, 21 Apr 2017 01:03:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: optionally disable checkout DWIM
Message-ID: <20170421050330.ntnbri6qybi5i3pe@sigill.intra.peff.net>
References: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
 <xmqqzifa4amr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzifa4amr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 10:01:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When we complete branch names for "git checkout", we also
> > complete remote branch names that could trigger the DWIM
> > behavior. Depending on your workflow and project, this can
> > be either convenient or annoying.
> > ...
> > This is flexible enough for me, but it's possible somebody would want
> > this on a per-repo basis. I don't know that we want to read from `git
> > config`, though, because it's relatively expensive to do so. People who
> > want per-repo settings are probably better off with a hook that triggers
> > when they "cd" around, and sets up their preferences.
> 
> Sounds OK.  I am kind of surprised that --no-guess is the only way
> to turn off this dwimming (not in the completion side, but there
> does not seem to be a way to tell "git checkout" that you do not
> need that create-missing-branch-out-of-remote-tracking).

Yeah, I didn't even know about --no-guess until reading the completion
script (it's intentionally undocumented). I did consider teaching
checkout a config option for "do not DWIM". But I think it's really the
completion that bugs me. The DWIM is easy to avoid triggering if you
just don't feed it the remote branch names. It's the completion that
routinely leads me to doing that. :)

-Peff
