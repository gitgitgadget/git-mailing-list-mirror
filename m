Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4C31FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 22:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933618AbdBPW5O (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 17:57:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:56735 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933157AbdBPW5N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 17:57:13 -0500
Received: (qmail 31969 invoked by uid 109); 16 Feb 2017 22:57:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 22:57:12 +0000
Received: (qmail 28185 invoked by uid 111); 16 Feb 2017 22:57:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 17:57:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 17:57:10 -0500
Date:   Thu, 16 Feb 2017 17:57:10 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: There are too many unreachable loose objects
Message-ID: <20170216225710.6nnbw65qoeb6lrw5@sigill.intra.peff.net>
References: <CAE1pOi3bpL0zTS9w2QCOrXcWk5pHj=xthxo2nYi8KEwJ=TgXfA@mail.gmail.com>
 <CA+P7+xqWoUBOoFSiOTT5U-9aoqESUMnZeSGfvhGte2LqF18gmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqWoUBOoFSiOTT5U-9aoqESUMnZeSGfvhGte2LqF18gmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 02:36:10PM -0800, Jacob Keller wrote:

> > Whenever I run "git push --force(-with-lease)" I get a variation of
> >
> > Counting objects: 187, done.
> > Delta compression using up to 12 threads.
> > Compressing objects: 100% (126/126), done.
> > Writing objects: 100% (187/187), 21.35 KiB | 0 bytes/s, done.
> > Total 187 (delta 78), reused 71 (delta 20)
> > warning: There are too many unreachable loose objects; run 'git prune'
> > to remove them.
> > To git@git.company.com:project.git
> >  + 51338ea...b0ebe39 my-branch -> my-branch (forced update)
> >
> > So I'll run "git prune" and, for good measure, "git gc" (which even
> > includes "git prune"?). The first seems to do nothing, the latter does
> > its thing.
> >
> 
> It may be that it's the server side that needs to git-prune, and not
> your local side? I'm not really certain but you're doing a push which
> talks to a remote server.

Yes, certainly the position in the output implies that. These days you
should see:

  remote: warning: There are too many...

to make it more clear. Perhaps the server is too old to have 860a2ebec
(receive-pack: send auto-gc output over sideband 2, 2016-06-05).

-Peff
