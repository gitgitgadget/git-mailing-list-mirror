From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn tags and branches
Date: Thu, 30 Aug 2007 03:21:15 -0700
Message-ID: <20070830102115.GA17620@muzzle>
References: <faulrb$483$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 12:21:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQh9j-0003ed-R1
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 12:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbXH3KVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 06:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbXH3KVR
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 06:21:17 -0400
Received: from hand.yhbt.net ([66.150.188.102]:60841 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbXH3KVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 06:21:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BAF652DC08D;
	Thu, 30 Aug 2007 03:21:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <faulrb$483$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57019>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> Currently, git-svn imports svn tags as lightweight git tags.
> I was susprised when I discovered this (from 'git describe'
> failing and some helpful assistance on the IRC channel), so
> I'm now wondering: is there a technical reason why they
> aren't converted to annotated tags? If not, would it be
> possible to implement this in git-svn, possibly with some
> way to 'fix' existing git-svn repository?

As noted by other repliers, SVN tags can be moving targets just like
branches, and are treated as such by git-svn.

I should note that tags in git can actually be updated like a branch
just the same way, too, it's just not as easy to "accidentally" do.

So I'll add the ability to modify refs under the refs/tags/ namespace to
my git-svn TODO list (which is getting rather large).  I also plan to
support branches outside of the refs/remotes/ namespace so it's easier
to use (clone, browse from gitweb) from bare repositories.

> My second question concerns the uses of branche in git-svn,
> but it might come from a not perfect understanding of the
> branching mechanism in git (and yes, I've read the
> documentation and Wiki pages).
> 
> If I understand correctly, svn branches are imported in
> git-svn as remote branches (refs/remote/*) and are
> automatically updated on git-svn fetch or git-svn fetch-all.
> 
> In my experiments, however, I've noticed the following
> behaviour.
> 
> git branch --track trunk remote/trunk
> <do some changes and git commit them, while still on branch master>
> git svn dcommit
> 
> Now, master and remote/trunk point to the new roundtripped
> changes, but the branch 'trunk' (in git) remains pointing to
> the old remote/trunk head. I would have expected the --track
> option to keep trunk in sync with remote/trunk ...
> 
> Or am I missing something obvious?

The author of git-svn (myself) hasn't gotten around to supporting
(or even looking at) git branch --track.

Right now, dcommit only knows about HEAD and the remote it's committing
to, nothing else.  The config set by --track doesn't do anything
for git-svn.

I really have a lot of catching up to do with all the new(er) things
happening in git.  I learned git (what seems like) aeons ago have been
more or less content with what the plumbing offered back then.  The past
six months of my life hasn't exactly left me with a lot of time or
energy for git, either; hopefully I'll have more time soon...

-- 
Eric Wong
