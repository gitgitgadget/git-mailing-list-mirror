Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85AB2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 23:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758353AbdCUXcM (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 19:32:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:49117 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758347AbdCUXcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 19:32:11 -0400
Received: (qmail 613 invoked by uid 109); 21 Mar 2017 23:32:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 23:32:04 +0000
Received: (qmail 22433 invoked by uid 111); 21 Mar 2017 23:32:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 19:32:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 19:32:00 -0400
Date:   Tue, 21 Mar 2017 19:32:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] prefix_filename: return newly allocated string
Message-ID: <20170321233159.usottyq56ygo26kf@sigill.intra.peff.net>
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
 <20170321012847.yebhpdmk5zrizgmj@sigill.intra.peff.net>
 <xmqqinn2qyyo.fsf@gitster.mtv.corp.google.com>
 <20170321182335.3yrjkhk4mxhso73j@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321182335.3yrjkhk4mxhso73j@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 02:23:35PM -0400, Jeff King wrote:

> > worktree.c:265:6: error: to_free may be used uninitialized in this function
> 
> Doh. I had originally written it without the "if (prefix)" and added it
> as a micro-optimization at the end.
> 
> Still, the whole thing compiles fine for me. I find it odd that neither
> gcc nor clang notices the problem on my system. It's quite obviously
> wrong.

Ah, I found it; it is only triggered with -O2. I usually compile with
-O0 during my edit/compile/test cycles.

-Peff
