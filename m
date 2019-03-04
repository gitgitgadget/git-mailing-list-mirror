Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0768D20248
	for <e@80x24.org>; Mon,  4 Mar 2019 21:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfCDVl5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 16:41:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:38434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726038AbfCDVl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 16:41:57 -0500
Received: (qmail 29551 invoked by uid 109); 4 Mar 2019 21:41:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Mar 2019 21:41:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26313 invoked by uid 111); 4 Mar 2019 21:42:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 16:42:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 16:41:55 -0500
Date:   Mon, 4 Mar 2019 16:41:55 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
Message-ID: <20190304214155.GB3347@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
 <20190303171951.GD23811@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 12:08:41PM +0100, Johannes Schindelin wrote:

> -- snipsnap --
> From c13d9985284d4b452db0d95b6949e02c533db634 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Sat, 23 Feb 2019 20:38:40 +0100
> Subject: [PATCH] hdr-check: make it work on Windows
> 
> On Windows, we define a specific set of pre-processor macros, among
> other reasons: to avoid including syslog.h (which is not available on
> Windows).
> 
> The hdr-check target did not use those definitions, resulting in a
> failure to include said syslog.h.
> 
> To fix that, let's let the hdr-check target make use of ALL_CFLAGS,
> which does include the pre-processor macros that would e.g. skip the
> conditional block including syslog.h.

This makes sense to me, though as you noted elsewhere, it doesn't fix
the gcrypt problem, since that file unconditionally wants to look at the
system gcrypt.h (and we control at the Makefile level whether we
actually look at sha256/gcrypt.h).

-Peff
