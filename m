Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D792A1FD99
	for <e@80x24.org>; Sun, 28 Aug 2016 10:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755296AbcH1KwC (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 06:52:02 -0400
Received: from ikke.info ([178.21.113.177]:42180 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755279AbcH1KwB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 06:52:01 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 68B144400BF; Sun, 28 Aug 2016 12:51:59 +0200 (CEST)
Date:   Sun, 28 Aug 2016 12:51:59 +0200
From:   Kevin Daudt <me@ikke.info>
To:     ryenus <ryenus@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Notation for current branch?
Message-ID: <20160828105159.GA5477@ikke.info>
References: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 28, 2016 at 05:58:18PM +0800, ryenus wrote:
> I wonder if there's an easy to use notation to refer to the current branch?
> which is expected be friendly to scripting.
> 
> For HEAD, there's @, which is short and concise.
> 
> But for the current branch, it seems one has to either use a not so friendly
> plumbing command, or grep/parse the output of `git branch`, since the latter
> doesn't even has any option to only print the plain name of the current branch,
> or maybe an option can be added to `git branch`?
> 
> Thoughts?

Scripts should always rely on plubming commands, never on porcelain, as
their output will change, and thus, break scripts.

To get the current branch name, the best is to use `git rev-parse
--symbolic-full-name`[1], which either returns you the current branch name
(eg refs/heads/master), or HEAD, when you have a detached HEAD. If you
only want the friendly name, add --abbrev-ref, which would then return
master.

[1]: git symbolic-ref HEAD would also work, but errors out when you're
not on a branch.
