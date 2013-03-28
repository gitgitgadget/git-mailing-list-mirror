From: Jeff King <peff@peff.net>
Subject: Re: More detailed error message for 403 forbidden.
Date: Thu, 28 Mar 2013 14:45:30 -0400
Message-ID: <20130328184530.GA14691@sigill.intra.peff.net>
References: <CAFT+Tg_PwAS__AYCwQQZjy4LVvAMZFJuJ+ediDJpRnxx73qMMg@mail.gmail.com>
 <20130328183601.GA11914@sigill.intra.peff.net>
 <20130328184120.GQ28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 19:46:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULHpt-0007Uf-Cv
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 19:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022Ab3C1Sph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 14:45:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43851 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543Ab3C1Sph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 14:45:37 -0400
Received: (qmail 27717 invoked by uid 107); 28 Mar 2013 18:47:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 14:47:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 14:45:30 -0400
Content-Disposition: inline
In-Reply-To: <20130328184120.GQ28148@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219441>

On Thu, Mar 28, 2013 at 11:41:20AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > One problem is that the content body sent along with the error is not
> > necessarily appropriate for showing to the user (e.g., if it is HTML, it
> > is probably not a good idea to show it on the terminal). So I think we
> > would want to only show it when the server has indicated via the
> > content-type that the message is meant to be shown to the user. I'm
> > thinking the server would generate something like:
> >
> >    HTTP/1.1 403 Forbidden
> >    Content-type: application/x-git-error-message
> >
> >    User 'me' does not have enough permission to access the repository.
> >
> > which would produce the example you showed above.
> 
> Would it make sense to use text/plain this way?

Maybe. But I would worry somewhat about sites which provide a useless
and verbose text/plain message. Ideally an x-git-error-message would be
no more than few lines, suitable for the error message of a terminal
program. I would not want a site-branded "Your page cannot be found.
Here's a complete navigation bar" page to be spewed to the terminal.
Those tend to be text/html, though, so we may be safe. It's just that
we're gambling on what random servers do, and if we show useless spew
even some of the time, that would be a regression.

-Peff
