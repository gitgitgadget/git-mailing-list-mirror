From: Jeff King <peff@peff.net>
Subject: Re: pthread_sigmask() on windows (wine actualy)
Date: Sun, 1 May 2016 13:45:36 -0400
Message-ID: <20160501174535.GB17321@sigill.intra.peff.net>
References: <CACsJy8BrKsasiXZcc3=mm9Pq=qz_h6pi8edzpmT_7mKxwjnAqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	git-for-windows <git-for-windows@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 19:45:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awvRF-0000n4-Ea
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 19:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbcEARpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 13:45:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:60058 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752043AbcEARpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 13:45:39 -0400
Received: (qmail 28489 invoked by uid 102); 1 May 2016 17:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 May 2016 13:45:38 -0400
Received: (qmail 8300 invoked by uid 107); 1 May 2016 17:45:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 May 2016 13:45:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 May 2016 13:45:36 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BrKsasiXZcc3=mm9Pq=qz_h6pi8edzpmT_7mKxwjnAqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293200>

On Sun, May 01, 2016 at 06:06:07PM +0700, Duy Nguyen wrote:

> I got this while compiling master today using mingw32 cross toolchain
> 
>     CC run-command.o
> run-command.c: In function 'run_thread':
> run-command.c:596:3: warning: implicit declaration of function
> 'pthread_sigmask' [-Wimplicit-function-declaration]
> run-command.c:596:23: error: 'SIG_BLOCK' undeclared (first use in this function)
> run-command.c:596:23: note: each undeclared identifier is reported
> only once for each function it appears in
> 
> This is added in c792d7b (run-command: teach async threads to ignore
> SIGPIPE - 2016-04-19). From the look of it, wrapping #ifndef
> GIT_WINDOWS_NATIVE is probably enough? I checked gfw/master too to see
> how gfw deals with it, but the commit has not been merged there yet.

I think the fix should go into compat/. See

  http://git.661346.n2.nabble.com/PATCH-0-5-fix-deadlock-in-git-push-tp7653666p7653818.html

(sorry, gmane seems down).

-Peff
