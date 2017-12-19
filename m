Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48461F406
	for <e@80x24.org>; Tue, 19 Dec 2017 16:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbdLSQZb (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 11:25:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:43214 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750763AbdLSQZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 11:25:30 -0500
Received: (qmail 14411 invoked by uid 109); 19 Dec 2017 16:25:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Dec 2017 16:25:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3738 invoked by uid 111); 19 Dec 2017 16:25:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 19 Dec 2017 11:25:56 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Dec 2017 11:25:28 -0500
Date:   Tue, 19 Dec 2017 11:25:28 -0500
From:   Jeff King <peff@peff.net>
To:     Jakub Zaverka <jakub.zaverka@deutsche-boerse.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: difftool uses hardcoded perl shebang
Message-ID: <20171219162528.GA5804@sigill.intra.peff.net>
References: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 01:28:09PM +0000, Jakub Zaverka wrote:

> When running git difftool:
> 
> >git difftool
> Perl lib version (5.10.0) doesn't match executable version (v5.16.3)
> Compilation failed in require at <path>/git-difftool line 2.
> 
> First line in my git-difftool is:
> #!/usr/bin/perl
> 
> I am using a specific perl that I cannot change. Similarly, I cannot change the git-difftool file. I would like the difftool to use the perl form my PATH. 
> 
> Maybe it would be better to use #!/usr/bin/env perl?

This is a build-time knob. When you build git, try:

  make PERL_PATH='/usr/bin/env perl'

(If you don't build your own git, then you might raise the issue with
whomever packages your binary).

As an aside, git-difftool is now a C builtin these days, so the problem
might also go away if you upgrade. ;)

-Peff
