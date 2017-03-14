Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04A3201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 17:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdCNRb4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 13:31:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:44034 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbdCNRby (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 13:31:54 -0400
Received: (qmail 18726 invoked by uid 109); 14 Mar 2017 17:31:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 17:31:53 +0000
Received: (qmail 31999 invoked by uid 111); 14 Mar 2017 17:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 13:32:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Mar 2017 13:31:50 -0400
Date:   Tue, 14 Mar 2017 13:31:50 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>,
        Mislav =?utf-8?B?TWFyb2huacSH?= <mislav.marohnic@gmail.com>
Subject: Re: [PATCH] add--interactive: do not expand pathspecs with ls-files
Message-ID: <20170314173150.2triogunl4af4d6z@sigill.intra.peff.net>
References: <20170314163024.et2cp5e3imrrrf7k@sigill.intra.peff.net>
 <20170314172504.GA102212@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170314172504.GA102212@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 10:25:04AM -0700, Brandon Williams wrote:

> On 03/14, Jeff King wrote:
> >   b. If the repository contains filenames with literal wildcard
> >      characters (e.g., "foo*"), the original code expanded
> >      them via "ls-files" and then fed those wildcard names
> >      to "diff-index", which would have treated them as
> >      wildcards. This was a bug, which is now fixed (though
> >      unless you really go through some contortions with
> >      ":(literal)", it's likely that your original pathspec
> >      would match whatever the accidentally-expanded wildcard
> >      would anyway).
> > 
> >      So this takes us one step closer to working correctly
> >      with files whose names contain wildcard characters, but
> >      it's likely that others remain (e.g., if "git add -i"
> >      feeds the selected paths to "git add").
> 
> It definitely makes things more difficult when people use wildcard
> characters in filenames.  Is there any reason people use wildcards as
> literal characters in filenames other than them not knowing any better?

The philosophers of the ages have struggled with the question of why
users do anything.

I suspect that wildcards in filenames are pretty uncommon, just judging
from the lack of complaints. But they do come up. The most recent one
was:

  http://public-inbox.org/git/c9876671-6252-5dfa-18df-a6719dc6834c@gmail.com/

It's unclear if that was stimulated by a real-world case, or just
mucking around.

-Peff
