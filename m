From: Theodore Tso <tytso@mit.edu>
Subject: Re: Conflict editing
Date: Sun, 4 Mar 2007 23:04:06 -0500
Message-ID: <20070305040406.GB26781@thunk.org>
References: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070304181044.GC8560@thunk.org> <46a038f90703041359w3cf5ff14n85445396c0ffc422@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 05:04:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO4Qs-0000xv-N7
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 05:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbXCEEEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 23:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbXCEEEQ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 23:04:16 -0500
Received: from thunk.org ([69.25.196.29]:43881 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbXCEEEP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 23:04:15 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HO4WH-0005jH-1A; Sun, 04 Mar 2007 23:09:53 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HO4Qg-0001ph-7d; Sun, 04 Mar 2007 23:04:06 -0500
Content-Disposition: inline
In-Reply-To: <46a038f90703041359w3cf5ff14n85445396c0ffc422@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41399>

On Mon, Mar 05, 2007 at 10:59:33AM +1300, Martin Langhoff wrote:
> I find xxdiff much better than meld, tkdiff and kdiff -- but maybe I
> just don't know how to use them, or they have gotten better in the
> last few months.

I wasn't familiar with xxdiff until just now, but having played with
it, kdiff3 is much easier for a beginner to use.  The toolbar makes it
a lot easier to select from one or the other, I find the keyboard
accellerators to be much more intuitive (although I suppose if you are
a vi or nethack fan the H, J, K keys will make sense to you :-).  

In addition, with xxdiff it gives the user way too many options about
whether you want to save the left, right, or center, or merged
windows.  That makes sense maybe if you are doing something completely
general, but too many options is a net negative, not a feature.  I
prefer kdiff3, where you simply hit the save icon, and it saves the
reconciled merged file to the specified output file (which the
git-mergetool specified to kdiff3 on the command-line).  So from the
workflow perspective, kdiff3 fits in much more cleanly than xxdiff.  

The one advantage xxdiff has that I can see (and maybe that's why you
like it?) is that it has the -U feature which allows it to pick apart
the merge conflict markers and so you can use it fairly easily simply
by saying "xxdiff -U hello.c".  With kdiff3 it's a lot more
complicated to invoke off the command-line, with something like:

	kdiff3 --auto hello.c.BASE hello.c.LOCAL hello.c.REMOTE -o hello.c

...but that's why you have a shell script to keep you away from such
nastyness.  All I need to do with my mergetool script is to type, "git
mergetool" to merge all unresolved merge conflicts, or "git mergetool
hello.c" if I only want to resolve conflicts in a single file.

> I had written (and posted) a git-xxdiff earlier. A (minor) concern is
> that from a packaging and dependencies perspective, the packager has
> to suggest *all* of them, and still a default install may not work at
> all -- it might be a good idea to suggest what to install in the error
> message. Or depend on all of them (yuck!).

Depending on all of them is definitely a bad idea.  Suggesting all of
them doesn't seem to be a big issue, and I don't see what's the
problem if git-mergetool can't find a graphical resolver; it can
always fall back to opening the file in an editor and asking the user
to resolve the conflict manually.

> One thing I _don't_ want as a user is to see the graphical mergers
> starting by default. Most merges are trivial, and I can just edit them
> in emacs or vi.

Well, git will handle most merges automatially for you anyway.  You
would only use git mergetool to handle the merge conflicts.

						- Ted
