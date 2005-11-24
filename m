From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] archimport improvements
Date: Wed, 23 Nov 2005 23:46:06 -0800
Message-ID: <20051124074605.GA4789@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 24 08:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBoE-00054w-Pv
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbVKXHqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbVKXHqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:46:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:56809 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030557AbVKXHqG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 02:46:06 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 257202DC033; Wed, 23 Nov 2005 23:46:06 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12681>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Eric,
> 
> I've merged and pushed out to
> http://locke.catalyst.net.nz/git/git-martinlanghoff.git/#tojunio
> 
>   [PATCH 1/5] remove shellquote usage for tags
>   [PATCH 2/5] archimport: don't die on merge-base failure
>   [PATCH 3/5] Disambiguate the term 'branch' in Arch vs git
>   [PATCH 1/2] archimport: allow for old style branch and public tag names
> 
> That last one had a small edit to rebase it to the top of the head --
> will probably have a small conflict for you on the usage line and
> getopts() line.
> 
> What is pending is...
> 
> *  [PATCH 4/5] Overhaul of changeset application
> 
> I am testing it right now. Finding it rather slow on an idle linux
> workstation with fast IDE disks, no X.org loaded and 1GB or RAM.
> iowait is pegged at 90%. Wonder what will happen on a system with slow
> disk access. tla/baz are unusable under any OS where the fs stack is
> not _that_ polished (OSX and friends).

Ok, I didn't expect you guys to have 12k of files in your trees.  None
of your source trees are remotely close to that size (but I have many
more changesets).  I'm surprised you guys were able to put up
with Arch in the first place!

125m58.431s with my method.
  8m24.504s with yours :)

All of my usual source trees imported 1k changesets in 10-15 minutes

> The early versions of the import also used $TLA for all ops, and I was
> forced to change it to get my repos transformed in a reasonable time.
> 
> Can you send me a patch that makes it optional, so users can choose
> fast or correct? I don't want to force glacial imports on anyone,
> specially me. Testing an import of a reasonably sized repo must be a
> quick operation or I won't do it ;-) And I do work on OSX too.

Patches on the way.

OTOH, the time spent importing the bulk of the history is a one-time
operation for most people and I'd much rather it get things as right as
possible and move on.

> On the other hand, I might just implement renamed directories tracking
> separately, specially if someone can point me to a public repo with
> some interesting cases of renamed directories.

IIRC, there are several nasty cases all of which are ordering-related,
especially with regard to nested directories or file renames inside
directories that are also renamed.  It should be noted that not even tla
gets all the possible directory rename cases right (baz seems better
from my observations). 

> These patches seem to hang from 4/5 so will need rebasing after a
> reworked. The first one seems to be 3 or 4 patches in one. It'd be
> good to break it up.

Sorry, I rushed through the initial overhaul and didn't generate neat
patches because I wanted to get some of my work moved to git ASAP.

> * [ PATCH 5/5] -D <depth> option to recurse into merged branches
> * Re: [PATCH 5/5] -D <depth> option to recurse into merged branches
> * [PATCH 2/2] archimport: sync_to_ps() messages for tracking tla methods

-- 
Eric Wong
