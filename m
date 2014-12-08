From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] transport-helper: initialize debug flag before
 starting threads
Date: Mon, 8 Dec 2014 05:36:24 -0500
Message-ID: <20141208103624.GA11737@peff.net>
References: <20141208082206.GA28302@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 11:36:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxvg5-0004So-He
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 11:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbaLHKg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 05:36:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:49864 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752144AbaLHKgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 05:36:25 -0500
Received: (qmail 8841 invoked by uid 102); 8 Dec 2014 10:36:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 04:36:25 -0600
Received: (qmail 21891 invoked by uid 107); 8 Dec 2014 10:36:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 05:36:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Dec 2014 05:36:24 -0500
Content-Disposition: inline
In-Reply-To: <20141208082206.GA28302@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261005>

On Mon, Dec 08, 2014 at 03:22:06AM -0500, Jeff King wrote:

>  /* Print bidirectional transfer loop debug message. */
>  __attribute__((format (printf, 1, 2)))
>  static void transfer_debug(const char *fmt, ...)
>  {
>  	va_list args;
>  	char msgbuf[PBUFFERSIZE];
> -	static int debug_enabled = -1;
>  
> -	if (debug_enabled < 0)
> -		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
> -	if (!debug_enabled)
> +	if (!transport_debug_enabled)
>  		return;

I think in my cover letter I made clear that this was not really meant
for inclusion as-is, but just in case: this obviously is missing "()" at
the end of the function call (interestingly gcc -Wall complains, but
clang does not).

-Peff
