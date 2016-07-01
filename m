Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456D420FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 07:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbcGAHOO (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 03:14:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:38803 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752043AbcGAHOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 03:14:14 -0400
Received: (qmail 27095 invoked by uid 102); 1 Jul 2016 07:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 03:14:15 -0400
Received: (qmail 14184 invoked by uid 107); 1 Jul 2016 07:14:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 03:14:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 03:14:10 -0400
Date:	Fri, 1 Jul 2016 03:14:10 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, dwwang@google.com
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
Message-ID: <20160701071410.GG5358@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com>
 <20160630005951.7408-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160630005951.7408-2-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 05:59:48PM -0700, Stefan Beller wrote:

> The environment variable GIT_PUSH_OPTION_FILE is set to the push options
> separated by new line.
> 
> The code is not executed as the push options are set to NULL, nor is the
> new capability advertised.
> 
> The rationale for keeping the actual options inside a file instead of
> putting them directly into an environment variable has multiple reasons:

Thanks for including this rationale; my first thought on seeing the
patch was "wouldn't this be much more convenient for a hook if each
value had its own environment variable?".

Putting the data into a file does alleviate some issues. But it also
makes parsing annoying, and opens up new issues (like what happens
to content that has a newline in it?). Wouldn't multiple files be a bit
more convenient? Especially for your example of eventually carrying
larger binary content like images.

-Peff
