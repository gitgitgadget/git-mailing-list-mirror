Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F7B201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964933AbdBQXsI (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:48:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:57683 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964923AbdBQXsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:48:08 -0500
Received: (qmail 32404 invoked by uid 109); 17 Feb 2017 23:48:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 23:48:08 +0000
Received: (qmail 8963 invoked by uid 111); 17 Feb 2017 23:48:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 18:48:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 18:48:05 -0500
Date:   Fri, 17 Feb 2017 18:48:05 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/6] stash: refactor stash_create
Message-ID: <20170217234805.glvhyfbxab6nwgb7@sigill.intra.peff.net>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170217224141.19183-4-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170217224141.19183-4-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 10:41:38PM +0000, Thomas Gummerer wrote:

> Refactor the internal stash_create function to use a -m flag for
> specifying the message and -u flag to indicate whether untracked files
> should be added to the stash.
> 
> This makes it easier to pass a pathspec argument to stash_create in the
> next patch.
> 
> The user interface for git stash create stays the same.

Sounds good, but...

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 2e9cef06e6..d93c47446a 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>  	     [-u|--include-untracked] [-a|--all] [<message>]]
>  'git stash' clear
>  'git stash' create [<message>]
> +'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
>  'git stash' store [-m|--message <message>] [-q|--quiet] <commit>

Should this hunk be dropped from the manpage, then?

I think there is a similar one in the next patch that adds the
"pathspec" argument, and should be dropped, too.

-Peff
