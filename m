Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354D51F859
	for <e@80x24.org>; Mon, 29 Aug 2016 05:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756144AbcH2FFx (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 01:05:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:34563 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750888AbcH2FFw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 01:05:52 -0400
Received: (qmail 17265 invoked by uid 109); 29 Aug 2016 05:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 05:05:51 +0000
Received: (qmail 16784 invoked by uid 111); 29 Aug 2016 05:05:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 01:05:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2016 01:05:47 -0400
Date:   Mon, 29 Aug 2016 01:05:47 -0400
From:   Jeff King <peff@peff.net>
To:     "Jean-Marc B. van Schendel" <jeanmarc.vanschendel@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Suspected Bug in git install procedure [ git-daemon-run (version
 1:2.9.3-1) ]
Message-ID: <20160829050547.sv4rslwp2ocehvgx@sigill.intra.peff.net>
References: <CAKUcBEDwbZ7aLsa2w4dqNCRg3QQMo_2hm7-O-6o0Fg58ANYv=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKUcBEDwbZ7aLsa2w4dqNCRg3QQMo_2hm7-O-6o0Fg58ANYv=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 06:29:04AM +0200, Jean-Marc B. van Schendel wrote:

> Symptoms:
> On a fresh new install of Debian "Stretch" (8.5 alpha7, dated 2016-06-30),
> Trying to install a subset of Git packages (roughly, all those listed
> in git-all, except CVS-related packages)
> Install of package git-daemon-run (version 1:2.9.3-1) fails, dpkg
> reporting error

The git-daemon-run package is entirely a Debian creation, and has more
to do with "runit" than it does with "git daemon" itself. In particular,
your problem:

> Assumed cause:
> The directory /etc/service does not exist, and the install procedure
> does not create it, subsequently fails to create a symlink (git-daemon
> --> /etc/sv/git-daemon)

looks like it's about the system runit setup. I didn't dig, but it's
probably related to:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=834087

-Peff
