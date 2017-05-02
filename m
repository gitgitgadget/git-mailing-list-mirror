Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC46C207D6
	for <e@80x24.org>; Tue,  2 May 2017 03:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdEBDLg (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 23:11:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:43606 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbdEBDLf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 23:11:35 -0400
Received: (qmail 16791 invoked by uid 109); 2 May 2017 03:11:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 May 2017 03:11:34 +0000
Received: (qmail 8756 invoked by uid 111); 2 May 2017 03:12:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 23:12:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 23:11:32 -0400
Date:   Mon, 1 May 2017 23:11:32 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] credential doc: make multiple-helper behavior more
 prominent (Re: [PATCH] clone: handle empty config values in -c)
Message-ID: <20170502031131.tbdhpak7g65twjxp@sigill.intra.peff.net>
References: <20170502000515.GU28740@aiede.svl.corp.google.com>
 <20170502000856.GI39135@google.com>
 <20170502002114.GV28740@aiede.svl.corp.google.com>
 <20170502003010.GW28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170502003010.GW28740@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 05:30:10PM -0700, Jonathan Nieder wrote:

> > @@ -162,6 +152,16 @@ helper::
> >  	shell (so, for example, setting this to `foo --option=bar` will execute
> >  	`git credential-foo --option=bar` via the shell. See the manual of
> >  	specific helpers for examples of their use.
> > ++
> > +If there are multiple instances of the `credential.helper` configuration
> > +variable, each helper will be tried in turn, and may provide a username,
> > +password, or nothing. Once Git has acquired both a username and a
> > +password, no more helpers will be tried.
> > ++
> > +If `credential.helper` is configured to the empty string, this resets
> > +the helper list to empty (so you may override a helper set by a
> > +lower-priority config file by configuring the empty-string helper,
> 
> It's not necessarily obvious to a new user what "lower-priority" means.
> 
> Since this text is an example, maybe it should say something like "so,
> for example, you can override a helper set in /etc/gitconfig by
> configuring the empty-string helper followed by whatever set of
> helpers you would like in ~/.gitconfig".
> 
> That's orthogonal to this patch but it should be straightforward to
> roll in if it makes sense.

I'm not sure we want to get into explaining last-one-wins versus lists
versus list-resets for each option. The "FILES" section of git-config(1)
does cover this, though I could well believe it doesn't go into enough
detail or is too hard to find (my mind is sufficiently poisoned that it
all makes sense to me, but that says little about an average Git user).

The phrase "lower-priority config file" is used for push.gpgSign, too
(though there it really does seem like repeating things that are true
for all the config).

-Peff
