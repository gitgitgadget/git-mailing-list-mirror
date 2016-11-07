Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF78C2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 21:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbcKGVUH (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 16:20:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:39913 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752656AbcKGVUH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 16:20:07 -0500
Received: (qmail 11004 invoked by uid 109); 7 Nov 2016 21:20:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 21:20:06 +0000
Received: (qmail 16132 invoked by uid 111); 7 Nov 2016 21:20:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 16:20:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 16:20:04 -0500
Date:   Mon, 7 Nov 2016 16:20:04 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
Message-ID: <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-3-larsxschneider@gmail.com>
 <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 06, 2016 at 10:42:36PM +0100, Lars Schneider wrote:

> > From: Lars Schneider <larsxschneider@gmail.com>
> > 
> > TravisCI changed their default macOS image from 10.10 to 10.11 [1].
> > Unfortunately the HTTPD tests do not run out of the box using the
> > pre-installed Apache web server anymore. Therefore we enable these
> > tests only for Linux and disable them for macOS.
> [...]
> Hi Junio,
> 
> the patch above is one of two patches to make TravisCI pass, again.
> Could you queue it?

I don't really mind disabling tests if they don't run on a platform. But
the more interesting question to me is: why don't they run any more? Is
there some config tweak needed, or is it an insurmountable problem?

Using Apache in the tests has been the source of frequent portability
problems and configuration headaches. I do wonder if we'd be better off
using some small special-purpose web server (even a short perl script
written around HTTP::Server::Simple or something).

On the other hand, testing against Apache approximates a more real-world
case, which has value. It might be nice if our tests supported multiple
web servers, but that would mean duplicating the config for each
manually.

-Peff
