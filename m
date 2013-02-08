From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use __VA_ARGS__ for all of error's arguments
Date: Fri, 8 Feb 2013 10:54:16 -0500
Message-ID: <20130208155416.GA20874@sigill.intra.peff.net>
References: <20130208043915.GB4525@ftbfs.org>
 <1360336168-27740-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Max Horn <max@quendi.de>,
	Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 16:54:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3qHj-0002KP-H4
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 16:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946671Ab3BHPyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 10:54:20 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42283 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946644Ab3BHPyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 10:54:19 -0500
Received: (qmail 29784 invoked by uid 107); 8 Feb 2013 15:55:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 10:55:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 10:54:16 -0500
Content-Disposition: inline
In-Reply-To: <1360336168-27740-1-git-send-email-kraai@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215777>

On Fri, Feb 08, 2013 at 07:09:28AM -0800, Matt Kraai wrote:

> From: Matt Kraai <matt.kraai@amo.abbott.com>
> 
> QNX 6.3.2 uses GCC 2.95.3 by default, and GCC 2.95.3 doesn't remove the
> comma if the error macro's variable argument is left out.
> 
> Instead of testing for a sufficiently recent version of GCC, make
> __VA_ARGS__ match all of the arguments.
>
> [...]
>
>  /*
>   * Let callers be aware of the constant return value; this can help
> - * gcc with -Wuninitialized analysis. We have to restrict this trick to
> - * gcc, though, because of the variadic macro and the magic ## comma pasting
> - * behavior. But since we're only trying to help gcc, anyway, it's OK; other
> - * compilers will fall back to using the function as usual.
> + * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
> + * because some compilers may not support variadic macros. Since we're only
> + * trying to help gcc, anyway, it's OK; other compilers will fall back to
> + * using the function as usual.
>   */
>  #if defined(__GNUC__) && ! defined(__clang__)
> -#define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
> +#define error(...) (error(__VA_ARGS__), -1)

Acked-by: Jeff King <peff@peff.net>

Thanks.

-Peff
