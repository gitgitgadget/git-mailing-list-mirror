Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B46B1F744
	for <e@80x24.org>; Mon, 27 Jun 2016 10:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbcF0K6L (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 06:58:11 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:38854 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbcF0K6K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 06:58:10 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id ae4c3450
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Mon, 27 Jun 2016 12:58:06 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:	Junio C Hamano <gitster@pobox.com>, "Jeff King" <peff@peff.net>
From:	Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
Cc:	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@fluxnic.net>, "Johannes Sixt" <j6t@kdbg.org>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <20160614210038.31465-1-lfleischer@lfos.de>
 <20160624153121.GA2494@sigill.intra.peff.net>
 <alpine.DEB.2.20.1606241942220.12947@virtualbox>
 <20160624181414.GA25768@sigill.intra.peff.net>
 <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
Message-ID: <146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de>
User-Agent: alot/0.3.7
Subject: Re: [PATCH v2] Refactor recv_sideband()
Date:	Mon, 27 Jun 2016 12:58:04 +0200
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, 24 Jun 2016 at 20:32:28, Junio C Hamano wrote:
> On Fri, Jun 24, 2016 at 11:14 AM, Jeff King <peff@peff.net> wrote:
> >
> > I do wonder about the ANSI_SUFFIX thing, though.
> 
> compat/winansi.c seems to have a provision for 'K' (and obviously 'm'
> for colors).

So we probably want to switch back to using fprintf() or fputs() and
rely on the assumption that these functions use atomic write()
operations internally when printing to stderr (on practically relevant
systems, i.e., libc implementations), right?

Another option is using write() on all systems but Windows and fall back
on fputs() but that feels a bit like over-engineering at this point.

I will prepare and submit v4 later today.
