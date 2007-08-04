From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 08:02:43 -0400
Message-ID: <20070804120243.GB9716@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 14:03:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHILW-0008VD-Dd
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 14:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbXHDMCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 08:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755876AbXHDMCq
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 08:02:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2064 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754810AbXHDMCp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 08:02:45 -0400
Received: (qmail 29455 invoked from network); 4 Aug 2007 12:02:48 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 4 Aug 2007 12:02:48 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2007 08:02:43 -0400
Content-Disposition: inline
In-Reply-To: <854pjfin68.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54831>

On Sat, Aug 04, 2007 at 12:55:43PM +0200, David Kastrup wrote:

> A local branch is one with a local branch head.  In contrast, checking
> out a remote branch, while possible, leaves one with a detached head.

Yes, if by "remote branch" you mean a "remote tracking branch".

> "remote-tracking" basically means that git-pull will update the branch
> according to changes in the remote repository.

A "remote tracking branch" is a branch in refs/remotes/* that is updated
by _git-fetch_ (which is in turn called by git-pull) to track a remote's
position of a branch.

A local branch which tracks a remote branch (I don't recall seeing the
phrase "remote-tracking" -- where did this come from?) has the correct
magic in .git/config to pull from a specific remote branch when
'git-pull' is given without arguments.

> Creating a branch using git-branch or git-checkout will always create
> a local branch which may or may not be remote-tracking according to
> the --no-track or --track options.

Yes, although again, I think calling it a "remote-tracking branch" to
mean "a local branch that tracks a remote branch" is confusingly similar
to the more common "remote tracking branch" to mean "a branch in
refs/remotes that track's a remote repository's idea of a branch".

> So there are basically three types of branches in a repository that I
> can see:
> 
> local branch, not remote-tracking
> local branch, remote-tracking
> remote branch, remote-tracking

No, the remote branch is not remote-tracking in the sense that you
defined above; it is not meant to be pulled into.

I think you are confused by two uses of the word "track". In one case,
we mean that git-fetch will remember the remote's idea of a branch in
refs/remotes/<remote>/<branch>. In another, we mean that a local branch
will default to pulling from a particular (remote,branch) combination.

> So the terminology seems fuzzy at the moment, and my attempt to clear
> it up might not be the preferred way of doing it.

Yes, it is very fuzzy. Using "track" for the concept of a local branch
defaulting to a particular (remote,branch) pair for git-pull is, I
think, more recent and less used. If there were another term for this,
it might be more clear.

-Peff
