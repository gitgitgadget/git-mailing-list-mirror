Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823F2203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 08:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbcLJI4T (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 03:56:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:54570 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbcLJI4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 03:56:19 -0500
Received: (qmail 1451 invoked by uid 109); 10 Dec 2016 08:55:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 08:55:58 +0000
Received: (qmail 25113 invoked by uid 111); 10 Dec 2016 08:56:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 03:56:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2016 03:55:56 -0500
Date:   Sat, 10 Dec 2016 03:55:56 -0500
From:   Jeff King <peff@peff.net>
To:     Ariel <asgit@dsgml.com>
Cc:     git@vger.kernel.org
Subject: Re: git add -p with new file
Message-ID: <20161210085556.nwg3pbay367jqin5@sigill.intra.peff.net>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
 <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
 <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 01:43:24PM -0500, Ariel wrote:

> > It's contrary to the rest of git-add for specifying pathspecs to
> > actually make things _more_ inclusive rather than less.
> 
> Is it? Because git add without -p is happy to add new files.

I was just speaking there of whether the presence of the file on the
command-line was relevant. In other words, "git add -u untracked-file"
does not countermand the "-u" to say "also add this file".

> > Historically "add -p" has been more like "add -u" in updating tracked
> > files.
> 
> But it doesn't have to be that way. You could make add -p identical to add
> without options, except the -p prompts to review diffs first.

The question is whether you would annoy people using "-p" if you started
including untracked files by default. I agree because it's inherently an
interactive process that we can be looser with backwards compatibility.

Perhaps a config option would be the best path forward (even if we were
to switch the default to "true", it leaves an escape hatch for people
who do not like the new behavior).

> > We have "-A" for "update everything _and_ new files". It doesn't
> > seem unreasonable to me to have a variant of "-p" that is similar.
> 
> That seems unnecessarily complex because -p asks about each file, so you
> will never find new files added without realizing it.

If you care about adding new files, wouldn't you just always use "-P"
instead of "-p"?

-Peff
