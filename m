From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Thu, 9 Aug 2007 02:58:10 -0400
Message-ID: <20070809065810.GC24573@spearce.org>
References: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com> <Pine.LNX.4.64.0708082141170.21916@wbgn129.biozentrum.uni-wuerzburg.de> <85lkclrdpr.fsf@lola.goethe.zz> <20070809032610.GA24573@spearce.org> <85odhhntmb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>,
	Git Mailing List <git@vger.kernel.org>, paulus@samba.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 08:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ1yQ-0004NX-8H
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 08:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761258AbXHIG6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 02:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759025AbXHIG6S
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 02:58:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39180 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760024AbXHIG6R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 02:58:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IJ1yF-0001oI-EM; Thu, 09 Aug 2007 02:58:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 93D7520FBAE; Thu,  9 Aug 2007 02:58:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <85odhhntmb.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55418>

David Kastrup <dak@gnu.org> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >> Well, yes.  But git-gui only works on a single branch head at a time,
> >> and that is not enough for rebasing.
> >
> > Sure.  But so does git's command line tools.  They tend to only
> > work on a single branch at time, the one called `HEAD`.
> 
> "tend", and many accept an explicit override: rebase accepts three
> commit names, for example.  Those that _write_ into the repository
> usually _end_ up at HEAD, but most need not start there.
> 
> And git-gui does not have any operation either looking at or working
> other than on the current HEAD.  No diff, no file view, no rebase,
> nothing.

Uh, "Repository->Browse Browse Branch Files..." will let you look
at files from any commit-ish, not just HEAD or an existing branch.
You can open many file browsers at once against the same commit or
different commits.  Double clicking a file opens it in the blame
viewer, which itself can move around history a little bit.

"Merge->Local Merge..." will let you select any another commit to
merge with this current branch.  That's two commits.

So your assertion that git-gui only works with one commit, HEAD,
is wrong.

And git-rebase taking three arguments?  Its actually two; if it
is given the optional final argument of the branch to rebase it
first switches to that branch, then does the rebase.  In other
words these are identical:

  # this...
  git checkout to-rebase &&
  git rebase --onto upstreamA upstreamB

  # is the same as this...
  git rebase --onto upstreamA upstreamB to-rebase
 
> >> Could git-gui perhaps be merged with giggle at some point of time?
> >
> > Unlikely.  A while ago I considered "Stay in Tcl/Tk or move to
> > something more 'powerful/better/faster/Linus friendly'" and stayed
> > in Tcl/Tk.  I doubt git-gui will leave Tcl/Tk.  giggle is Gtk based.
> 
> My bad: git-gui has a nice polished look on my systems (Ubuntu Feisty)
> while gitk has an ugly retro-blockish old-font Tk look; so not looking
> at the innards, I had assumed they were implemented using different
> systems.

Nope.  Myself and a few others have just spent some time making
git-gui look somewhat sane by default.  It doesn't always; there are
at least a few places where it still has too much of a Tk-ish look
to it.  This is especially true in a few of the dialog boxes that
git-gui might open when you are about to do something potentially
bad.

> User interfaces are really not what I am good at, and I don't even
> have enough time to deal with the things I am good at.

Hah.  Me neither.  Yet git-gui exists.

-- 
Shawn.
