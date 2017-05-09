Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BBA120188
	for <e@80x24.org>; Tue,  9 May 2017 11:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbdEILC4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 07:02:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:48050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbdEILCz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 07:02:55 -0400
Received: (qmail 11066 invoked by uid 109); 9 May 2017 11:02:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 11:02:51 +0000
Received: (qmail 23877 invoked by uid 111); 9 May 2017 11:03:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 07:03:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 May 2017 07:02:50 -0400
Date:   Tue, 9 May 2017 07:02:50 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Script to rebase branches
Message-ID: <20170509110249.eluxns2zz5jqh42k@sigill.intra.peff.net>
References: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com>
 <20170509040943.j3n5li7fapiuvgbj@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705091244420.146734@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1705091244420.146734@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 12:50:22PM +0200, Johannes Schindelin wrote:

> > This is what I use:
> > 
> >   https://github.com/peff/git/blob/meta/rebase
> > 
> > There's no documentation in the script, but the commit message in its
> > history should give a good sense of what each part does.
> 
> That requires Meta/ to be checked out and up-to-date. I'd bet there are
> exactly two people who fall into that category.

Actually, it is not Junio's Meta that needs checked out, but rather the
"meta" branch where you will find that "rebase" script. If other people
find them useful, the set of scripts could perhaps be transitioned to a
namespace that is appropriate to go into people's $PATH.

I didn't really expect anybody to use it verbatim, though. I was
providing it more for inspiration.

> Also, I see that you do not use worktrees. Otherwise your script would
> fail.

Yes, the script predates the invention of worktrees by several years. I
have occasionally played with worktrees, but don't use them extensively
(I'd usually use them for a one-off change, and then remove the
worktree).

> When I still hoped to be able to get the rebase--helper related topic
> branches in by August last year, I had grandiose plans to teach the
> sequencer not only to perform the Git garden shears' trick (i.e. recreate
> merges), but also to optionally update local branches corresponding to the
> merge commits, including updates to the worktrees that checked them out
> (if any).

I don't think I need anything that fancy. But simply checking "is this
checked out in a worktree" for each branch and then doing "cd
/path/to/worktree && git rebase" instead of just "git rebase $branch"
would be enough, I think.

(I'm assuming the problem you see is just that the directory running
Meta/rebase cannot check out a branch that is checked out in another
worktree).

-Peff
