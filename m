From: Jeff King <peff@peff.net>
Subject: Re: bearer token authorization with HTTPS transport
Date: Tue, 30 Dec 2014 20:57:39 -0500
Message-ID: <20141231015738.GA9590@peff.net>
References: <CACejzECGUnH6B2Leq+H6u0Joo1SQmMCZ5UoHja_fK99+6a_iEA@mail.gmail.com>
 <20141230235610.GC10649@vauxhall.crustytoothpaste.net>
 <20141231014209.GA8789@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: David Renshaw <david@sandstorm.io>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 02:57:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y68Xh-0003TC-GE
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 02:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbaLaB5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 20:57:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:58088 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751531AbaLaB5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 20:57:40 -0500
Received: (qmail 17446 invoked by uid 102); 31 Dec 2014 01:57:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Dec 2014 19:57:40 -0600
Received: (qmail 9479 invoked by uid 107); 31 Dec 2014 01:57:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Dec 2014 20:57:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Dec 2014 20:57:39 -0500
Content-Disposition: inline
In-Reply-To: <20141231014209.GA8789@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261966>

On Tue, Dec 30, 2014 at 08:42:09PM -0500, Jeff King wrote:

> Both should be pretty trivial. This approach seems conceptually cleaner
> to me, though it does mean you could not specify a bearer via the
> terminal prompt for a password (e.g., by cutting and pasting from
> elsewhere). I don't know if that is a problem or not. You could override
> it with:
> 
>   [credential]
>   helper = '!f() {
>     test "$1" = "get" || return
>     echo >/dev/tty "No, really, give me a bearer token: "
>     read token </dev/tty
>     echo "bearer=$token"
>   }; f'
> 
> or similar.

And by the way, I'm not advocating that as something people would do on
the fly. I mean only that it would be easy to write a drop-in helper to
prompt people for a bearer token _before_ git makes it to the
username/password prompt.

-Peff
