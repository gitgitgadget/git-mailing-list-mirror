Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62ED1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 20:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756147AbcJNU6r (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 16:58:47 -0400
Received: from ikke.info ([178.21.113.177]:53050 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753866AbcJNU6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 16:58:45 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id F24F94401D4; Fri, 14 Oct 2016 22:58:42 +0200 (CEST)
Date:   Fri, 14 Oct 2016 22:58:42 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Automagic `git checkout branchname` mysteriously fails
Message-ID: <20161014205842.GA6350@ikke.info>
References: <CACPiFC+8+wVEcDt9JZgTW1dwCCFKszyXD6ysDxNQorcNkom7Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPiFC+8+wVEcDt9JZgTW1dwCCFKszyXD6ysDxNQorcNkom7Lw@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 04:25:49PM -0400, Martin Langhoff wrote:
> In a (private) repo project I have, I recently tried (and failed) to do:
> 
>   git checkout v4.1-support
> 
> getting a "pathspec did not match any files known to git" error.
> 
> There's an origin/v4.1-support, there is no v4.1-support "local"
> branch. Creating the tracking branch explicitly worked.
> 
> Other similar branches in existence upstream did work. Autocomplete
> matched git's own behaviour for this; where git checkout foo woudn't
> work, autocomplete would not offer a completion.
> 
> Why is this?
> 
> One theory I have not explored is that I have other remotes, and some
> have a v4.1-support branch. If that's the case, the error message is
> not very helpful, and could be improved.
> 
> git --version
> 2.7.4
> 
> DWIM in git is remarkably good, even addictive... when it works :-)
> 
> cheers,
> 

Correct, this only works when it's unambiguous what branch you actually
mean.

if remote_a/branch and remote_b/branch exists, git cannot guess which
one you actually mean.

The message you get is because git checkout can be followed by several
things. Either a branch/commit or a file. Git complaining it cannot find
a file with that name is because it has exhausted all other options.

I do agree that message could be a bit more clear.
