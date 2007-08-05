From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 07:52:08 -0400
Message-ID: <20070805115208.GA19734@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804092933.aaec6d52.seanlkml@sympatico.ca> <85ejijgzzg.fsf@lola.goethe.zz> <20070805100532.GG12507@coredump.intra.peff.net> <85172807-B7EB-47DD-813E-FAF5894E1190@zib.de> <20070805110200.GA18083@coredump.intra.peff.net> <85tzre8b4w.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 13:52:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHef0-0007B6-KK
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 13:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbXHELwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 07:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756632AbXHELwR
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 07:52:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3382 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808AbXHELwK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 07:52:10 -0400
Received: (qmail 17989 invoked from network); 5 Aug 2007 11:52:13 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 11:52:13 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 07:52:08 -0400
Content-Disposition: inline
In-Reply-To: <85tzre8b4w.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54999>

On Sun, Aug 05, 2007 at 01:38:07PM +0200, David Kastrup wrote:

> > I believe the --track setup uses the tracking branches to figure out
> > which remote/branch combo to track. To do it without a remote tracking
> > branch, you would have to add the lines to your .git/config manually.
> 
> Fascinating, really fascinating.  Is there actually _anybody_ who
> would not revert to phrases like "I believe" when describing git's
> interaction with remote branches?

By "I believe", I meant "I am pretty sure this is the way it is
implemented, but I have better things to do than read through
builtin-branch.c right now, so please don't take this as gospel and go
read the code yourself."

But the point of --track is that I don't _have_ to care, and that it
deduces the correct remote/branch combination itself.

> I don't find this particularly logical: origin/something basically
> boils down referring to a commit.

Really, "origin/something" refers to "refs/remotes/origin/something",
which we can deduce from the config to be populated by a particular
remote and branch (go read the code).

> Maybe git-branch --track should allow referring to remote:branch or
> URLs or something directly rather than a remote tracking branch?

It could, but at that point, you could just do:

  git-branch newbranch oldbranch
  git-config branch.newbranch.remote someremote
  git-config branch.newbranch.merge remotebranch

Perhaps it's slightly more convenient to be able to do

  git-branch --track someremote:remotebranch newbranch oldbranch

but the real convenience of --track is when it deduces those parameters
itself.

-Peff
