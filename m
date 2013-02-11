From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Include xmlparse.h instead of expat.h on QNX
Date: Mon, 11 Feb 2013 16:06:21 -0500
Message-ID: <20130211210621.GC32740@sigill.intra.peff.net>
References: <1360616395-18912-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:06:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U50aN-000275-UV
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759809Ab3BKVGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:06:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44600 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759711Ab3BKVGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:06:24 -0500
Received: (qmail 26981 invoked by uid 107); 11 Feb 2013 21:07:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 16:07:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 16:06:21 -0500
Content-Disposition: inline
In-Reply-To: <1360616395-18912-1-git-send-email-kraai@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216089>

On Mon, Feb 11, 2013 at 12:59:55PM -0800, Matt Kraai wrote:

> From: Matt Kraai <matt.kraai@amo.abbott.com>
> 
> QNX 6.3.2 through 6.5.0 include Expat 1.1, which provides xmlparse.h
> instead of expat.h, so include the former on QNX systems.

So it is not just QNX, but rather older versions of expat?

> diff --git a/http-push.c b/http-push.c
> index 9923441..55c575e 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -11,7 +11,11 @@
>  #include "list-objects.h"
>  #include "sigchain.h"
>  
> +#ifndef __QNX__
>  #include <expat.h>
> +#else
> +#include <xmlparse.h>
> +#endif

If that is the case, should this #ifdef look for EXPAT_NEEDS_XMLPARSE_H,
and that macro triggered externally? Either in the QNX section of the
Makefile, or potentially by an autoconf macro?

-Peff
