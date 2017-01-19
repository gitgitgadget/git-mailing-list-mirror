Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8B020A17
	for <e@80x24.org>; Thu, 19 Jan 2017 17:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbdASRHu (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 12:07:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:41584 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753191AbdASRHc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 12:07:32 -0500
Received: (qmail 30974 invoked by uid 109); 19 Jan 2017 17:00:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 17:00:01 +0000
Received: (qmail 6692 invoked by uid 111); 19 Jan 2017 17:00:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 12:00:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 11:59:59 -0500
Date:   Thu, 19 Jan 2017 11:59:59 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC 0/2] grep: make output consistent with revision syntax
Message-ID: <20170119165958.xtotlvdta7udqllb@sigill.intra.peff.net>
References: <20170119150347.3484-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170119150347.3484-1-stefanha@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 03:03:45PM +0000, Stefan Hajnoczi wrote:

> git-grep(1)'s output is not consistent with git-rev-parse(1) revision syntax.
> 
> This means you cannot take "rev:path/to/file.c: foo();" output from git-grep(1)
> and expect "git show rev:path/to/file.c" to work.  See the individual patches
> for examples of command-lines that produce invalid output.

I think this is a good goal.

I couldn't immediately think of any cases where your patches would
misbehave, but my initial thought was that the "/" versus ":"
distinction is about whether the initial object is a tree or a commit.

You do still have to special case the root tree (so "v2.9.3:" does not
get any delimiter). I think "ends in a colon" is actually a reasonable
way of determining that.

> This series is an incomplete attempt at solving the issue.  I'm not familiar
> enough with the git codebase to propose a better solution.  Perhaps someone is
> interested in a proper fix?

Are there cases you know that aren't covered by your patches?

-Peff
