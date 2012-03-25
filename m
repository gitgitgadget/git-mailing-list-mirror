From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 2/2] remote-curl: send the refs to fetch-pack on stdin
Date: Sat, 24 Mar 2012 21:24:33 -0400
Message-ID: <20120325012432.GD27651@sigill.intra.peff.net>
References: <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net>
 <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net>
 <4F6A33C5.2080909@gmx.net>
 <20120321201722.GA15021@sigill.intra.peff.net>
 <4F6E3478.3090505@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 03:24:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBcCG-0002uT-1g
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 03:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab2CYBYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 21:24:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58775
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab2CYBYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 21:24:35 -0400
Received: (qmail 30076 invoked by uid 107); 25 Mar 2012 01:24:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Mar 2012 21:24:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Mar 2012 21:24:33 -0400
Content-Disposition: inline
In-Reply-To: <4F6E3478.3090505@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193855>

On Sat, Mar 24, 2012 at 09:54:16PM +0100, Ivan Todoroski wrote:

> From 723a561946824ee367f57f0d9b9d336a6bc28d13 Mon Sep 17 00:00:00 2001
> From: Ivan Todoroski <grnch@gmx.net>
> Date: Sat, 24 Mar 2012 15:53:36 +0100
> Subject: [PATCH/RFC 2/2] remote-curl: send the refs to fetch-pack on stdin
> 
> ---

Same comments as patch 1. Drop this stuff, and add in more commit
message. :)

>  remote-curl.c |   18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Overall the code looks sane to me. One minor comment:

> -static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
> +static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
> +		int nr_fetch, struct ref **to_fetch)

I was curious why you needed to add new arguments for this, since we
surely must be passing the information into rpc_service already (since
it has to put them on the command line). And the answer is that they are
already in the argv member of the struct rpc_state. I wonder if it would
fit the existing style of the code to pass the arguments through a
member in the rpc_state in the same way. I don't feel strongly about it,
though.

-Peff
