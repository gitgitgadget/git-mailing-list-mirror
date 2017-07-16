Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCBE20357
	for <e@80x24.org>; Sun, 16 Jul 2017 11:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdGPLVD (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 07:21:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:42056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751087AbdGPLVD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 07:21:03 -0400
Received: (qmail 27647 invoked by uid 109); 16 Jul 2017 11:21:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 11:21:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25590 invoked by uid 111); 16 Jul 2017 11:21:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 07:21:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 07:21:01 -0400
Date:   Sun, 16 Jul 2017 07:21:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: handle EOF in test_copy_bytes()
Message-ID: <20170716112100.gktc2ipxbidj6ca6@sigill.intra.peff.net>
References: <20170716104532.zyni62mvzz6rglu6@sigill.intra.peff.net>
 <20170716104718.i4nyphyzqh2mzhxt@sigill.intra.peff.net>
 <c79eeaec-64e6-db27-d590-ab94a47394d1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c79eeaec-64e6-db27-d590-ab94a47394d1@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 01:10:50PM +0200, René Scharfe wrote:

> > And I was pleased to see that after setting OPENSSL_SHA1, the answer to
> > "how far" is "we are there". Yay.
> 
> True with GCC, but not with Clang 3.9.  A patch for alignment issues in
> dir.c is coming up..

Good to know that there are differences. I used clang for my sanitize
runs for the past few years (because of issues I had with gcc's version
in the 4.8 era), but just switched a week or two ago back to using gcc.

My impression is that clang is the primary platform for sanitizer
development, and so it would probably produce better results. We _could_
force "CC ?= clang" when SANITIZE is set, but that's probably a bit
unfriendly to people who only have gcc.

FWIW, I just did an UBSan run with clang-5.0, and it comes up with only
the dir.c problem.

-Peff
