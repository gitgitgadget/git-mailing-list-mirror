Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446C81F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeDFT5C (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:57:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:56342 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751410AbeDFT5B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:57:01 -0400
Received: (qmail 25651 invoked by uid 109); 6 Apr 2018 19:57:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 19:57:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29081 invoked by uid 111); 6 Apr 2018 19:58:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 15:58:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 15:56:59 -0400
Date:   Fri, 6 Apr 2018 15:56:59 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Thierry Moreau <thierry.moreau@connotech.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Self-inflicted "abort" in a newbie attempt at read-only
 exploration of a cloned repository?
Message-ID: <20180406195659.GD11450@sigill.intra.peff.net>
References: <5AC67C43.9080500@connotech.com>
 <CAGyf7-E9=Mm1oJdhwHTmg2byrOxMRFVEjmYHCFGqqP8pvK=vJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-E9=Mm1oJdhwHTmg2byrOxMRFVEjmYHCFGqqP8pvK=vJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 04:18:23PM -0700, Bryan Turner wrote:

> The documentation for --work-tree says:
> 
> --work-tree=<path>
> 
> Set the path to the working tree. It can be an absolute path or a path
> relative to the current working directory. This can also be controlled
> by setting the GIT_WORK_TREE environment variable and the
> core.worktree configuration variable (see core.worktree in
> git-config(1) for a more detailed discussion).
> 
> So passing --work-tree tells Git where to store your _files_, but it's
> still using the same .git directory.
> 
> If your goal is to have worktrees for various versions, that implies
> the git worktree [1] command might be more along the lines of what
> you're looking for. An invocation based on above might look like this:
> $ git -C linux-stable/ worktree add $PWD/tmp/ checkout linux-4.15.y

Everything you've said here is completely accurate. But the original
report does make me wonder if we've set up users for failure by
overloading the term "worktree". Clearly it means two very different
things in:

  git --work-tree=foo

and

  git worktree add foo

I'm not sure what to do about it at this point, though. :(

-Peff
