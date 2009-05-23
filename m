From: Jeff King <peff@peff.net>
Subject: Re: git merge remote branch says "Merge commit ..."?
Date: Sat, 23 May 2009 05:17:12 -0400
Message-ID: <20090523091711.GB20416@coredump.intra.peff.net>
References: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com> <loom.20090522T172429-73@post.gmane.org> <20090522175401.GB11640@coredump.intra.peff.net> <200905222030.34301.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Raible <raible@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat May 23 11:17:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7nM4-0005zz-3Z
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 11:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbZEWJRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 05:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbZEWJRO
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 05:17:14 -0400
Received: from peff.net ([208.65.91.99]:54203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891AbZEWJRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 05:17:12 -0400
Received: (qmail 23364 invoked by uid 107); 23 May 2009 09:17:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 23 May 2009 05:17:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 23 May 2009 05:17:12 -0400
Content-Disposition: inline
In-Reply-To: <200905222030.34301.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119768>

On Fri, May 22, 2009 at 08:30:34PM +0200, Johannes Sixt wrote:

> On Freitag, 22. Mai 2009, Jeff King wrote:
> > No, it is not terribly expensive. But you do have to talk to the server,
> > which may mean making an ssh connection, or the server may be overloaded
> > and slow. So it can take a few seconds instead of a few microseconds.
> 
> It's certainly doable without a remote connection with some digging in the 
> configuration.

Er, I think we have gotten a bit off track.

Yes, it's clearly possible to pretend you fetched but not actually do so
when doing "git merge origin/master" (and the patch I posted does
something close, but doesn't fill in the actual remote name; you just
get "remote branch origin/master").

All the other part of this thread was just me claiming that:

  git fetch origin
  git log origin...
  git merge origin

Is a totally valid workflow, and that the answer should not be "those
people should just run pull".

> Git-gui has some magic to find out the remote when you request to merge a 
> remote tracking branch. That is, even though you clickety-click through to do 
> the equivalent of 'git merge origin/master', it comes up with a merge message 
> that is the same as if you had said 'git pull origin master' on the command 
> line. It doesn't need a connection to do that.

Right. We could probably use similar logic in "git merge". I'm not sure
if it is worth the trouble to end up with "Merge branch 'master' of
origin" instead of "Merge remote branch 'origin/master'".

-Peff
