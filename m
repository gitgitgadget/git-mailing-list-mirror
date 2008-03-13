From: Jeff King <peff@peff.net>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 12:19:19 -0400
Message-ID: <20080313161919.GA2050@coredump.intra.peff.net>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org> <alpine.LSU.1.00.0803131254580.1656@racer.site> <20080313121644.GD2414@genesis.frugalware.org> <20080313125853.GA12927@mit.edu> <20080313155322.GA30847@coredump.intra.peff.net> <20080313161201.GA31653@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 13 17:20:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZq9x-0008SL-US
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 17:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbYCMQTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 12:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbYCMQTW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 12:19:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1758 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbYCMQTW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 12:19:22 -0400
Received: (qmail 11265 invoked by uid 111); 13 Mar 2008 16:19:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 12:19:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 12:19:19 -0400
Content-Disposition: inline
In-Reply-To: <20080313161201.GA31653@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77102>

On Thu, Mar 13, 2008 at 12:12:01PM -0400, Theodore Tso wrote:

> If the main goal is primarily backup of your repository to an
> untrusted remote server, yes, that makes perfect sense.  
> 
> If you assume multiple trusted developers would actually be
> *operating* on an encrypted repo, the life gets much harder, as you've
> pointed out.

Well, it depends on the meaning of "operate". :) I think you could still
use it as a rendezvous point as you would any bare repository.  Pushing
and pulling would have a little larger network overhead, and a lot more
CPU overhead.

But yes, that scheme is horrible for a working repo.

> >   - encrypting before git sees content sucks, because you are either
> >     sacrificing security (content X always encrypts to Y) or system
> >     stability (git doesn't know that Y and Y' are really the same thing)
> 
> It's not clear that "content X always encrypts to Y" is a fatal flaw,
> by the way.  Yes, it leaks a bit of information, but in a source code

Agreed (I actually recommended in Dscho's original thread "you can do it
by eliminating the salt, if you accept the consequences...").

So after my saying "no formal threat analysis is necessary" you have
clearly called me on making a bunch of usage assumptions. Oops. :)

> management situation, it may not matter.  If you do absolutely care,
> tough, it might be that the simplest solution is to store the entire
> repository and working tree under cryptofs.  After all, what's the
> point of encrypting the local repo if the checked-out working tree is
> unprotected for all to see?  :-)

Yes. And it doesn't involve any git-specific code at all. :)

-Peff
