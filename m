Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23941FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbcFPJuF (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:50:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:55554 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751690AbcFPJuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:50:04 -0400
Received: (qmail 10623 invoked by uid 102); 16 Jun 2016 09:50:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:50:04 -0400
Received: (qmail 14595 invoked by uid 107); 16 Jun 2016 09:50:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:50:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:50:01 -0400
Date:	Thu, 16 Jun 2016 05:50:01 -0400
From:	Jeff King <peff@peff.net>
To:	Heiko Becker <heirecka@exherbo.org>
Cc:	git@vger.kernel.org, drafnel@gmail.com
Subject: Re: [PATCH] gnome-keyring: Don't hard-code pkg-config executable
Message-ID: <20160616095001.GI15851@sigill.intra.peff.net>
References: <20160614112705.7162-1-heirecka@exherbo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160614112705.7162-1-heirecka@exherbo.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 14, 2016 at 01:27:05PM +0200, Heiko Becker wrote:

> Helpful if your pkg-config executable has a prefix based on the
> architecture, for example.
> 
> Signed-off-by: Heiko Becker <heirecka@exherbo.org>

Sounds like a reasonable thing to want to do...

> diff --git a/contrib/credential/gnome-keyring/Makefile b/contrib/credential/gnome-keyring/Makefile
> index c3c7c98..22c19df 100644
> --- a/contrib/credential/gnome-keyring/Makefile
> +++ b/contrib/credential/gnome-keyring/Makefile
> @@ -4,12 +4,13 @@ all:: $(MAIN)
>  CC = gcc
>  RM = rm -f
>  CFLAGS = -g -O2 -Wall
> +PKG_CONFIG = pkg-config
>  
>  -include ../../../config.mak.autogen
>  -include ../../../config.mak
>  
> -INCS:=$(shell pkg-config --cflags gnome-keyring-1 glib-2.0)
> -LIBS:=$(shell pkg-config --libs gnome-keyring-1 glib-2.0)
> +INCS:=$(shell $(PKG_CONFIG) --cflags gnome-keyring-1 glib-2.0)
> +LIBS:=$(shell $(PKG_CONFIG) --libs gnome-keyring-1 glib-2.0)

...and the implementation looks obviously correct.

Thanks.

-Peff
