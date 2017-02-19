Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E9F201B0
	for <e@80x24.org>; Sun, 19 Feb 2017 02:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdBSC17 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 21:27:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:58209 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbdBSC17 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 21:27:59 -0500
Received: (qmail 7806 invoked by uid 109); 19 Feb 2017 02:27:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Feb 2017 02:27:58 +0000
Received: (qmail 17657 invoked by uid 111); 19 Feb 2017 02:28:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Feb 2017 21:28:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Feb 2017 21:27:56 -0500
Date:   Sat, 18 Feb 2017 21:27:56 -0500
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Damien Regad <dregad@mantisbt.org>, git@vger.kernel.org
Subject: Re: [PATCH] git-check-ref-format: fix typo in man page
Message-ID: <20170219022756.pwxhjluxizuedf46@sigill.intra.peff.net>
References: <c27d7861-b161-a3eb-fcfc-bf766fc7b20b@gmail.com>
 <2116CBFFB78A482D8FA176BC680B3B9C@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2116CBFFB78A482D8FA176BC680B3B9C@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2017 at 12:20:33AM -0000, Philip Oakley wrote:

> >  Normalize 'refname' by removing any leading slash (`/`)
> >  characters and collapsing runs of adjacent slashes between
> > - name components into a single slash.  Iff the normalized
> > + name components into a single slash.  If the normalized
> >  refname is valid then print it to standard output and exit
> >  with a status of 0.  (`--print` is a deprecated way to spell
> >  `--normalize`.)
> > -- 
> 
> Could that be an 'iff' == 'If and only if' (which is common in mathematics)?
> Still could be spelling error though.

When we're not sure what the intent of a change is, a good first step is
to dig up the original commit via `git blame` or similar. In this case,
it comes from a40e6fb67 (Change check_refname_format() to reject
unnormalized refnames, 2011-09-15).

The commit message doesn't mention it (not that I really expected it
to), but it does tell you who the author is. And a good second step is
to cc them on the patch. :)

I suspect it _was_ intended as "iff" here. In my opinion, we probably
don't need to be so rigorous in this instance. However, I note that we
do not describe the "else" half of that "if". So maybe an overall
improvement would be something like:

  If the normalized refname is valid then print it to standard output
  and exit with a status of 0. Otherwise, exit with a non-zero status.

-Peff
