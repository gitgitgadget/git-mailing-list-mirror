From: Theodore Tso <tytso@mit.edu>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 12:12:01 -0400
Message-ID: <20080313161201.GA31653@mit.edu>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org> <alpine.LSU.1.00.0803131254580.1656@racer.site> <20080313121644.GD2414@genesis.frugalware.org> <20080313125853.GA12927@mit.edu> <20080313155322.GA30847@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 17:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZq3g-0005oe-Co
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 17:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbYCMQMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 12:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756904AbYCMQMm
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 12:12:42 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:41959 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756897AbYCMQMl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 12:12:41 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1JZq3q-000081-AT; Thu, 13 Mar 2008 12:13:42 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JZq2I-00009v-FX; Thu, 13 Mar 2008 12:12:06 -0400
Content-Disposition: inline
In-Reply-To: <20080313155322.GA30847@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77101>

On Thu, Mar 13, 2008 at 11:53:22AM -0400, Jeff King wrote:
>   - encrypting whole packfiles is a bit better for transport. The
>     key-holding repo does the deltas and just treats the remote repo as
>     dumb storage (it can't be smart, since that would involve looking at
>     the data). Storage overhead is minimal if packfiles are a reasonable
>     size.
> 
> So I think the last makes the most sense, where your local repo is
> totally unprotected, but you efficiently push git objects to a remote
> untrusted repo.

If the main goal is primarily backup of your repository to an
untrusted remote server, yes, that makes perfect sense.  

If you assume multiple trusted developers would actually be
*operating* on an encrypted repo, the life gets much harder, as you've
pointed out.

>   - encrypting before git sees content sucks, because you are either
>     sacrificing security (content X always encrypts to Y) or system
>     stability (git doesn't know that Y and Y' are really the same thing)

It's not clear that "content X always encrypts to Y" is a fatal flaw,
by the way.  Yes, it leaks a bit of information, but in a source code
management situation, it may not matter.  If you do absolutely care,
tough, it might be that the simplest solution is to store the entire
repository and working tree under cryptofs.  After all, what's the
point of encrypting the local repo if the checked-out working tree is
unprotected for all to see?  :-)

						- Ted
