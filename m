Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AEFD20282
	for <e@80x24.org>; Tue, 13 Jun 2017 06:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbdFMG3o (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 02:29:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:38827 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbdFMG3o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 02:29:44 -0400
Received: (qmail 10771 invoked by uid 109); 13 Jun 2017 06:29:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 06:29:43 +0000
Received: (qmail 20926 invoked by uid 111); 13 Jun 2017 06:29:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 02:29:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 02:29:41 -0400
Date:   Tue, 13 Jun 2017 02:29:41 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613062941.r22r64y5ymdpfhbx@sigill.intra.peff.net>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
 <20170613012337.GH154599@google.com>
 <20170613013817.GE133952@aiede.mtv.corp.google.com>
 <20170613055243.GI154599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613055243.GI154599@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 10:52:43PM -0700, Brandon Williams wrote:

> > >> curious: Why get_git_common_dir() instead of get_git_dir()?
> > >
> > > Needs to be commondir since the config is stored in the common git
> > > directory and not a per worktree git directory.
> > 
> > *puzzled* Why wasn't this needed before, then?  The rest of the patch
> > should result in no functional change, but this part seems different.
> 
> there is no functional change, this is what always happened.
> git_path("config") will replace gitdir with commondir under the hood.

Of the two callsites you removed, one is git_pathdup(), and the other
is get_git_dir(). So they weren't matched, though I suspect the one in
include_by_gitdir probably ought to have been commondir?

-Peff
