Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24FFC1F856
	for <e@80x24.org>; Thu,  8 Sep 2016 20:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbcIHUCG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 16:02:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:40358 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752115AbcIHUCF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 16:02:05 -0400
Received: (qmail 14324 invoked by uid 109); 8 Sep 2016 20:02:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 20:02:05 +0000
Received: (qmail 17868 invoked by uid 111); 8 Sep 2016 20:02:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 16:02:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 16:02:02 -0400
Date:   Thu, 8 Sep 2016 16:02:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH 2/3] t0001: work around the bug that reads config file
 before repo setup
Message-ID: <20160908200202.gmvpqrwwjavxmojb@sigill.intra.peff.net>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
 <20160908134719.27955-1-pclouds@gmail.com>
 <20160908134719.27955-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160908134719.27955-3-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 08:47:18PM +0700, Nguyễn Thái Ngọc Duy wrote:

> git-init somehow reads '.git/config' at current directory and sets
> log_all_ref_updates based on this file. Because log_all_ref_updates is
> not unspecified (-1) any more. It will not be written to the new repo's
> config file (see create_default_files() function).
> 
> This will affect our tests in the next patch as we will compare the
> config file and expect that core.logallrefupdates is already set to true
> by "git init main-worktree".

This is a bug for more than worktrees, and is something I'm working on
fixing (what I'd like to do is kill off the lazy fallback to ".git/" as
the repo name, which is almost always the wrong thing to do).

I'm not opposed to your workaround, but just FYI.

-Peff
