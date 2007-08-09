From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Thu, 9 Aug 2007 03:21:47 -0400
Message-ID: <20070809072147.GD24573@spearce.org>
References: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com> <Pine.LNX.4.64.0708082141170.21916@wbgn129.biozentrum.uni-wuerzburg.de> <85lkclrdpr.fsf@lola.goethe.zz> <20070809032610.GA24573@spearce.org> <85odhhntmb.fsf@lola.goethe.zz> <20070809065810.GC24573@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>,
	Git Mailing List <git@vger.kernel.org>, paulus@samba.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 09:22:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ2LG-00038E-1U
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 09:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917AbXHIHVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758039AbXHIHVy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 03:21:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39966 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbXHIHVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 03:21:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IJ2L6-0002fw-3e; Thu, 09 Aug 2007 03:21:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 77A9E20FBAE; Thu,  9 Aug 2007 03:21:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070809065810.GC24573@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55419>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> David Kastrup <dak@gnu.org> wrote:
> > other than on the current HEAD.  No diff, no file view, no rebase,
> > nothing.
> 
> So your assertion that git-gui only works with one commit, HEAD,
> is wrong.

Oh, and git-gui has some features that don't even really exist in the
shell porcelain.  E.g. you can do this all from the Branch->Create
dialog in git-gui:

  b=refs/heads/branch-to-create
  git fetch origin foof:refs/remotes/origin/foof &&
  if test git show-ref $b
  then
    git push . refs/remotes/origin/foof:$b
  else
    git branch $b refs/remotes/origin/foof
  fi &&
  git checkout foof

That's actually somewhat hard to do on the command line, but as
it turns out is just insanely handy to have for some workflows.
It amounts to "Always fetch the remote tracking branch, make sure
my local branch will fast-forward to it, do so, then checkout my
local branch; but if the local branch doesn't exist create it,
then do the checkout anyway".

I used git-push above just because its handy to do the fast-forward
check and update if successful; that's not what git-gui uses
internally because its actually a really stupid abuse of the
push command.  But it was shorter to write out the shell code for
this email.  Wow, OK, I just spent more time explaining why I used
git-push than to just write the damn fast-forward test.  Whatever.

I count 1-2 commits in that operation, depending on if your local
branch exists or not.  Oh, and this nifty thing called a remote.


But you are correct to some extent, there's no diff of a prior commit
available from within git-gui.  Or rebase.  I'd like to fix both.
But its time for sleep instead.  Oh, and I'm supposed to be fixing
some "features" of fast-import this week too...

-- 
Shawn.
