Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822422018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbcF0QQU (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:16:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:33294 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751749AbcF0QQU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 12:16:20 -0400
Received: (qmail 27826 invoked by uid 102); 27 Jun 2016 16:16:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 12:16:19 -0400
Received: (qmail 8862 invoked by uid 107); 27 Jun 2016 16:16:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 12:16:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 12:16:17 -0400
Date:	Mon, 27 Jun 2016 12:16:17 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Lukas Fleischer <lfleischer@lfos.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
Message-ID: <20160627161616.GA4430@sigill.intra.peff.net>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <20160614210038.31465-1-lfleischer@lfos.de>
 <20160624153121.GA2494@sigill.intra.peff.net>
 <alpine.DEB.2.20.1606241942220.12947@virtualbox>
 <20160624181414.GA25768@sigill.intra.peff.net>
 <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
 <146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de>
 <xmqqr3bibpap.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr3bibpap.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 08:54:22AM -0700, Junio C Hamano wrote:

> It's just you used xwrite() there that introduced a different issue.
> Wouldn't replacing it with fwrite(stderr) without changing anything
> else solve that?

I am having trouble actually seeing how the ANSI-emulation code gets
triggered, but the comment in color.h implies that it is only printf,
fprintf, and fputs that have the desired effect. So fwrite() may not be
sufficient, and we may need fprintf("%.*s", len, buf) or something.

-Peff
