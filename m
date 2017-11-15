Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1403C202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 00:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbdKOATQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 19:19:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:58218 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753209AbdKOATO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 19:19:14 -0500
Received: (qmail 32138 invoked by uid 109); 15 Nov 2017 00:19:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Nov 2017 00:19:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4006 invoked by uid 111); 15 Nov 2017 00:19:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (107.19.190.10)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 14 Nov 2017 19:19:27 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Nov 2017 00:19:08 +0000
Date:   Wed, 15 Nov 2017 00:19:08 +0000
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Recovering from gc errors
Message-ID: <20171115001907.vno7fo4t4bglh35n@sigill.intra.peff.net>
References: <4f548c23-7bb5-a672-21bb-6c1dd6de6139@xiplink.com>
 <20171114055306.3tfi726wzmkcfluk@sigill.intra.peff.net>
 <3af0f8cc-09f3-bcf2-04c8-f076e0ddcea2@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3af0f8cc-09f3-bcf2-04c8-f076e0ddcea2@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 10:39:31AM -0500, Marc Branchaud wrote:

> >    rm -rf .git/logs
> 
> Unfortunately, removing the logs directory does not fix "git gc".  So I
> restored it.
> 
> However I did find all of the bad SHAs in the HEAD logs of four of my
> worktrees.

Ah, right. There are more logs than .git/logs these days. That makes
sense.

> I'm willing to chalk this up to bugs in the early worktree code, unless one
> of the CC'd worktree developers thinks otherwise.

Perhaps fixed by acd9544a8f (revision.c: --reflog add HEAD reflog from
all worktrees, 2017-08-23). I think before then that prune/repack would
consider those objects unreachable.

-Peff
