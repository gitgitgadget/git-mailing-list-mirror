Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E0B1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 15:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754229AbdBFP4J (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 10:56:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:49813 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752337AbdBFP4J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 10:56:09 -0500
Received: (qmail 11375 invoked by uid 109); 6 Feb 2017 15:56:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 15:56:08 +0000
Received: (qmail 14006 invoked by uid 111); 6 Feb 2017 15:56:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 10:56:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 16:56:06 +0100
Date:   Mon, 6 Feb 2017 16:56:06 +0100
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 4/5] stash: introduce new format create
Message-ID: <20170206155606.xgkmhg656vuc6uki@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-5-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170205202642.14216-5-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2017 at 08:26:41PM +0000, Thomas Gummerer wrote:

> git stash create currently supports a positional argument for adding a
> message.  This is not quite in line with how git commands usually take
> comments (using a -m flag).
> 
> Add a new syntax for adding a message to git stash create using a -m
> flag.  This is with the goal of deprecating the old style git stash
> create with positional arguments.
> 
> This also adds a -u argument, for untracked files.  This is already used
> internally as another positional argument, but can now be used from the
> command line.

How do we tell the difference between new-style invocations, and
old-style ones that look new-style? IOW, I think:

  git stash create -m works

currently treats "-m works" as the full message, and it would now become
just "works".

That may be an acceptable loss for the benefit we are getting. The
alternative is to make yet another verb for create, as we did with
save/push). I have a feeling that hardly anybody uses "create", though,
and it's mostly an implementation detail. So given the obscure nature,
maybe it's an acceptable level of regression. I dunno.

But either way, it should probably be in the commit message in case
somebody does have to track it down later.

-Peff
