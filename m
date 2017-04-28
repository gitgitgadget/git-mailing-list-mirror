Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFBE3207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 15:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163007AbdD1PUc (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 11:20:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:41884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756688AbdD1PUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 11:20:30 -0400
Received: (qmail 29730 invoked by uid 109); 28 Apr 2017 15:20:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 15:20:28 +0000
Received: (qmail 23173 invoked by uid 111); 28 Apr 2017 15:20:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 11:20:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 11:20:25 -0400
Date:   Fri, 28 Apr 2017 11:20:25 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Watson <andwatsresearch@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: push fails with return code 22
Message-ID: <20170428152025.7lgkirbhpsccupt3@sigill.intra.peff.net>
References: <CAH6sfJUn99ezs-uZuYVj15qOeMv79ji7r0Ldvoreef0z3LzG8Q@mail.gmail.com>
 <20170427201804.3abt5ht6dkwwqo4r@sigill.intra.peff.net>
 <CAH6sfJX338f=WyEbCBXX_bzq=homhMs=cjPtzmH9cSvtBKPnaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH6sfJX338f=WyEbCBXX_bzq=homhMs=cjPtzmH9cSvtBKPnaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 11:09:55AM -0400, Andrew Watson wrote:

> Thanks for pointing me to git help http-backend. I confirmed the
> modules are loaded and the CGI environment variables. I've added
> "AcceptPathInfo On" to my httpd.conf just to be safe.
> 
> I'm not sure what /info/refs is supposed to look like, but it is
> empty. Could that be the issue?

No, that shouldn't matter. The on-disk file is used only for dumb-http
requests. In a working smart-http system, the info/refs request should
go to the CGI, which will generate the ref advertisement dynamically.

> Do you see anything in my apache configuration that looks wrong?

It looks reasonable to me, but I'm far from an expert on Apache config.

When you clone, is it using smart-http there? Try using GIT_CURL_VERBOSE
to see what the response is to the initial /info/refs fetch when you
clone.

-Peff
