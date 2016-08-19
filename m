Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9ED71F859
	for <e@80x24.org>; Fri, 19 Aug 2016 21:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755625AbcHSVTs (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 17:19:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49356 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753990AbcHSVTp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 17:19:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F3A161F859;
        Fri, 19 Aug 2016 21:19:44 +0000 (UTC)
Date:   Fri, 19 Aug 2016 21:19:44 +0000
From:   Eric Wong <e@80x24.org>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 0/3] diff-highlight: add support for git log --graph
 output.
Message-ID: <20160819211944.GA16646@dcvr>
References: <20160810085635.GA1672@starla>
 <20160817153124.7770-1-henderson.bj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160817153124.7770-1-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> wrote:
> On Wed, Aug 10, 2016 at 08:56:35AM +0000, Eric Wong wrote:
> > "local" is not a portable construct.  It's common for
> > Debian/Ubuntu systems to use dash as /bin/sh instead of bash;
> > (dash is faster, and mostly sticks to POSIX)
> > 
> > The "devscripts" package in Debian/Ubuntu-based systems has a
> > handy "checkbashisms" tool for checking portability of shell
> > scripts.
> 
> checkbashisms didn't output anything, and I found other instances of
> local in some tests. but I removed anyway.

Ah, I guess "checkbashisms --posix" is required nowadays
since Debian policy deviated from POSIX, here
(we don't blindly follow POSIX, either).

Anyways, some people still care about ksh93 as of a few months
ago; so I think avoiding "local" is preferable:

  https://public-inbox.org/git/?q=ksh93&d:..20160801

I think all of our other "local" uses are limited
to bash-specific parts: bash completion, mingw tests

<snip>

> I've rebased my changes. Unfortunately, having 3 commits made this somewhat
> tedious. I also find it weird that my new patch set makes it difficult to see
> what changes I've made from my first set. What's the standard workflow here?

I check out a new branch with the same base as the previous series
and "git diff previous current"

(without git, I'd be using interdiff from the patchutils Debian package)

Sometimes I will rebase against both old+new against Junio's master
to avoid/reduce conflicts.
