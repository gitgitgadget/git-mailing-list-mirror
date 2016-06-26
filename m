Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E327B1FF40
	for <e@80x24.org>; Sun, 26 Jun 2016 23:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbcFZXvd (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 19:51:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:32987 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751557AbcFZXvc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 19:51:32 -0400
Received: (qmail 18719 invoked by uid 102); 26 Jun 2016 23:51:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jun 2016 19:51:32 -0400
Received: (qmail 4719 invoked by uid 107); 26 Jun 2016 23:51:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jun 2016 19:51:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Jun 2016 19:51:29 -0400
Date:	Sun, 26 Jun 2016 19:51:29 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Message-ID: <20160626235129.GC21668@sigill.intra.peff.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-2-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160626232112.721-2-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 11:21:11PM +0000, Eric Wong wrote:

> We should continue to loop after EAGAIN/EWOULDBLOCK as the
> intent of xread is to read as much as possible until an
> EOF or real error occurs.

BTW, a minor nit here. xread() does _not_ read as much as possible until
EOF. It tries until it gets a real error or at least one byte.

I know you inherited this mistaken text from 1079c4be0b, but we should
probably not repeat it.

-Peff
