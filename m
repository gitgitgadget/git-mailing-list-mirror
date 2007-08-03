From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-diff on touched files: bug or feature?
Date: Fri, 3 Aug 2007 04:40:10 -0400
Message-ID: <20070803084010.GM20052@spearce.org>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net> <7v1wemxnkk.fsf@assigned-by-dhcp.cox.net> <vpqzm1a2l72.fsf@bauges.imag.fr> <7vy7gtvhgc.fsf@assigned-by-dhcp.cox.net> <20070803070407.GA17287@coredump.intra.peff.net> <7vr6mlnj4g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 10:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGsiv-0002V4-EL
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 10:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbXHCIl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 04:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbXHCIl1
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 04:41:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36648 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbXHCIlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 04:41:25 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IGshd-0000eu-Rc; Fri, 03 Aug 2007 04:40:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 707B520FBAE; Fri,  3 Aug 2007 04:40:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vr6mlnj4g.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54692>

Junio C Hamano <gitster@pobox.com> wrote:
> > On Thu, Aug 02, 2007 at 12:56:19PM -0700, Junio C Hamano wrote:
> >
> >> Personally, I almost never run "git status".  The command is
> >> there primarily because other systems had a command called
> >> "status", and migrant wondered why we didn't.  We do not need
> >> it, and we do not have to use it.
> >
> > So what is the recommended command to summarize which files have been
> > modified, which files have been marked for commit, and which remain
> > untracked?

git-gui?  ;-)

I also use the following two aliases:

  [alias]
    dw = diff --stat --summary
    di = diff --stat --summary --cached

...
> I do not make partial commits myself, so
> distinction between staged and unstaged are not something I am
> usually interested in.

I never used to either.  Then git-gui got really useful at showing
the distinction and I started using the index for a staging ground.
I almost never make partial commits, unless it is completely trivial,
e.g. a comment fixup that isn't related to what I'm really doing
but that was too darn obvious to not fix _right now_.

But I always toss things into the index when I've read through the
diff a few times and am very happy with it.  I may not be done with
the overall commit, but I park the hunks into the index so I don't
have to look at them again.  I use a trackball so "tossing into the
index" is really just a flick of the wrist to select the menu item
from the pop-up menu on that hunk.  Quite like a toss.  ;-)

I tend to test only once I have everything staged into the index and
my working directory is clean (nothing changed that isn't staged).
Its at that point that I think my change is done and I'm happy with
how the diff looks.  Usually the code is correct at this point too;
but if its not I'll fix it, then commit.


So where does that leave me regarding the touched but not changed
files?  Usually they just get in my way in the end.  I don't much
care that I've undone the file back to what I had in the index.
It just doesn't provide any value to my workflow.  It is actually
incredible rare that I cause it to happen too.  Usually I won't
write the file back to disk if I'm just going to undo it.

If I do write it to disk I'm likely to stage it or at least some
hunks of it.  If I later change my mind and undo those changes I'm
going to effectively stage the reverse difference.  This is a very
nice hint showing me that yes in fact the older way was better.

Personally?  The index is a killer feature for me.  Totally.
I can't work without it anymore, it has become a total crutch to me.
You would have to pry the index from my cold dead fingers to get
me to stop using it.

Yea, that is a total about-face for me.  I used to think the index
was only useful for merges.  Boy was I wrong!

-- 
Shawn.
