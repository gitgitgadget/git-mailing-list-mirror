Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23211FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 10:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbcF1KGB (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 06:06:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:58173 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbcF1KGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 06:06:00 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lz3JU-1bMM4p1Fui-014Clr; Tue, 28 Jun 2016 12:05:39
 +0200
Date:	Tue, 28 Jun 2016 12:05:36 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
In-Reply-To: <alpine.DEB.2.20.1606281203000.12947@virtualbox>
Message-ID: <alpine.DEB.2.20.1606281204330.12947@virtualbox>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160614210038.31465-1-lfleischer@lfos.de> <20160624153121.GA2494@sigill.intra.peff.net> <alpine.DEB.2.20.1606241942220.12947@virtualbox> <20160624181414.GA25768@sigill.intra.peff.net>
 <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com> <146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de> <xmqqr3bibpap.fsf@gitster.mtv.corp.google.com> <20160627161616.GA4430@sigill.intra.peff.net>
 <alpine.DEB.2.20.1606281203000.12947@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eHc1Lhm1eS2Pg/ZXGN8eRRqbrE7XOmiFiHbsGyCZWJua8J/eLBs
 dbPPc7VWLmmg3iHdp5acFFcA4tJH7keQkHLt8/SeOTKiWEO7W6Gl2BU9OB8CMw5+ED52xHf
 qxz2dqOTeP/qpGqc+9zUrDhW2pZZW3ANRNSUX0xRlBEGc2rDVh2k+lUikMKYnyf2Tw7fO0u
 7SVWMs01TDZwaKe+ClcTg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:g0CpUFiN8A0=:lYkIb3Yp93wl+OkrXALvde
 n34XQMZHU7a9NyCUhAHMLUhCmTxYkYO3RnJNjgKWfjBR4WI9sqpRSHaK3A4LrbxC3apjDxzsz
 0F2yoKhoQULz9g8+cGQav2vDUxYBuyFwjMwXjBURRKfe2HqWeDVD2sB+AZN7/4I7ktAjHDpgp
 DnGS0k0zip5QTV8iayGztJcdXwbqgK+8+trIW4W6yb8HPphv1hIlFvpvmGThUW0i9FHn9qO8E
 NWb0x05S6kq8kuJIVcmcQi9hCWHkikI7amqYudV/0xBFJ16yMAfjVNkv6TilglwgQyhcxj+k0
 i1WL2flOaDIQRma/suH6iJEZ0zWj+AnCbP6SSc0+wzvDOOg01Kui/qs5f4+9X2wxyThpOlAA4
 OgcFynb/dzdXvG4jJcjoVngxGkTjRquRctpLc3mL17YyGdFQd+l1aDjFs+OU/6n9fCRf/p+w8
 KFXxLcnoRln5ZBwbxjyIqpmQ5oJyIr4xWhNhlLKzTHzpPF4mESkZOLhuVX3kKy7epR6vbJ5wV
 k4WSAgbNNBffzi75JuZ69y+V91Sj93DqxvjIAAcmgoiahQ+ViRKQ43xLq2VOHEWnezUNTGoEP
 RviZKD65/snQSkbB+mbmf1wVKZQyTZE5ih1vn99Q9VLjq3LwdeKYcume3kDTC8F/dhpjtPidk
 vcPCvgCKeDu+A57ackT4T+9xoSDn62jSVTeaed3ftERGFyMboInY/W0nxmAE2iX1oQk3gig2f
 V5RtVeJ7iUumWP2T95kjjo3yV0p9o/of5TzRtkMxNiYr0gKLjmd+BvJ8fZa1IR6qEWC8DhAQI
 KmlWWzY
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Erm, sorry...

On Tue, 28 Jun 2016, Johannes Schindelin wrote:

> [...] we actually do not override fprintf() at all anymore [*1*] [...]

... forgot the

Footnote *1*: In Git for Windows, we actually *do* override fprintf(),
thanks to using gettext, but it is *gettext* that is doing the overriding
now, not Git.
