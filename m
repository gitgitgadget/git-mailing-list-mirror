Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6712021E
	for <e@80x24.org>; Fri, 11 Nov 2016 08:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756182AbcKKIr2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 03:47:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:41647 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755792AbcKKIr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 03:47:28 -0500
Received: (qmail 20774 invoked by uid 109); 11 Nov 2016 08:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 08:47:27 +0000
Received: (qmail 12207 invoked by uid 111); 11 Nov 2016 08:47:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 03:47:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2016 03:47:25 -0500
Date:   Fri, 11 Nov 2016 03:47:25 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>, hvoigt@hvoigt.net
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
Message-ID: <20161111084725.jkdsdt4yslzsuh6d@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-3-larsxschneider@gmail.com>
 <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
 <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
 <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
 <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
 <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 09:22:51AM +0100, Lars Schneider wrote:

> There would be an alternative way to approach the problem:
> Someone (GitHub?, BitBucket?, GitLab?, ...) could setup a bunch of webservers
> with popular configurations and a way to reset a clean test environment. Then 
> the TravisCI client tests could go against these servers.
>
> I realize that this idea is probably unrealistic because too much setup and
> maintenance work would be required.

Yeah, it seems like it adds a lot of complexity for little gain. Plus it
creates a network dependency on running the tests. I know you care
mostly about Travis, but I am much more interested in all of the people
(developers and not) who run "make test" on their own platforms.

If you did want to have a more real-world network-based test, I think
the right solution is not for GitHub to set up a bunch of mock servers,
but to design client-side tests that hit the _real_ GitHub (or GitLab,
or whatever) and perform some basic operations. OTOH, people running
"master" (or "next", etc) are doing that implicitly every day.

-Peff
