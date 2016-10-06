Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A781F207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755638AbcJFTHY (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:07:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:53553 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755595AbcJFTHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:07:22 -0400
Received: (qmail 30102 invoked by uid 109); 6 Oct 2016 19:07:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 19:07:22 +0000
Received: (qmail 30560 invoked by uid 111); 6 Oct 2016 19:07:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 15:07:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 15:07:20 -0400
Date:   Thu, 6 Oct 2016 15:07:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
Message-ID: <20161006190720.4ecf3ptl6msztoya@sigill.intra.peff.net>
References: <20161006114124.4966-1-pclouds@gmail.com>
 <20161006190014.owmqr2eqyk5h5cau@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161006190014.owmqr2eqyk5h5cau@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 03:00:14PM -0400, Jeff King wrote:

> PS I think your "!!" syntax conflicts with something like:
> 
>     git -c alias.has-changes='!! git diff --quiet' has-changes
> 
>    I don't know if that is worth worrying about or not. I also notice
>    that using "!!git diff" with no space seems broken, as it seems to
>    skip using the shell. I wonder if that is a bug in run-command.

Nevermind this last bit. It is the shell that is complaining
(rightfully) about "!git"; the error message is just confusing because
it mentions $0, which contains the whole script:

  $ git -c alias.has-changes='!!git diff --quiet' has-changes
  !git diff --quiet: 1: !git diff --quiet: !git: not found

The "!! git diff" syntax sill has the conflict I mentioned (though note
I screwed up the quotes in what I wrote above).

-Peff
