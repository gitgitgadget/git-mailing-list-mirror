From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] TopGit v0.3
Date: Wed, 10 Sep 2008 01:10:09 +0200
Message-ID: <20080909231009.GD10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 01:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCMi-00009n-3r
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbYIIXKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbYIIXKM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:10:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38387 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbYIIXKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:10:11 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3918F393A6C5; Wed, 10 Sep 2008 01:10:09 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95458>

  Hi!

  After awfully long delay, here comes v0.3 of TopGit - we hopefully
begin to approach some kind of practical usability by now.

  TopGit is meant as a fresh start in the steps of StGIT, quilt-in-git
and others, of course in an attempt to Get It Right this time around.
TopGit is absolutely minimal porcelain layer that will manage your
patch queue for you using topic branches, one patch per branch,
never rewriting the history in order to enable fully distributed
workflow.  You can get TopGit at

	http://repo.or.cz/w/topgit.git

and read up on its design, usage and implementation at:

	http://repo.or.cz/w/topgit.git?a=blob;f=README


  Aside of few minor changes, the major point of this release is remotes
handling; you can elevate any remote to a TopGit-tracked status using
'tg remote', then git fetch / push will haul around the TopGit bases
as well, and 'tg update' can update your local branches based on
the remote ones. Each repository has one "default" TopGit remote and
the local branches are supposed to reflect this one; that is the remote
'tg update' and all the other commands consider by default. Normally,
this remote is the last one you called 'tg remote --populate' on, but
you can change it in .git/config or switch it for a particular tg call
using the 'tg -r REMOTE command' parameter.

  The other major improvement is new 'tg import' command by Aneesh Kumar
that lets you transform a series of commits to a topic branch sequence.
I decided not to consider the 'tg depend' work by Jan Nieuwenhuiz for
this release yet, since it will probably take me a bit of time yet to
fully understand his approach; so far, I have an uneasy feel about it.

  Note that this release, as usual, received only very light testing -
please come back with any bugs you find. If someone would feel like
adding at least a simple testsuite, that would be really nice.


Aneesh Kumar K.V (1):
      topgit: Implement tg-import

Bert Wesarg (1):
      Makefile: Use $(wildcard) for commands_in

David Brown (1):
      Force adding the .topmsg and .topdep files.

Jan Nieuwenhuizen (1):
      TOPGIT: [PATCH] Use standard prefix and DESTDIR rather than explain

Jonathan Nieder (2):
      supply template argument to mktemp
      tg-info: fix sed typo

Petr Baudis (35):
      tg-export: Ensure we don't overwrite a branch by git update-ref
      tg create: Set up refs/top-bases/ after conflict resolution
      README: Sketch of my current ideas on remotes handling
      tg summary: Fix confusing variable name
      tg remote: New command
      tg-update.sh: Better explain base update
      Factor out rev-parse --verify calls to new ref_exists() function
      tg.sh: Set $base_remote to topgit.remote config value
      recurse_deps+branch_needs_update(): Deal with remote branches
      tg update: Support updating from remote branches
      has_remote(): Introduce to check if branch has remote counterpart
      tg info: Show information about remote branches
      tg info: Asterisk-prefix 'out-of-band' warnings
      tg summary: Show info about remote mates
      tg summary: 'L' denotes that push will update remote mate
      tg info: Note if local head is ahead of remote mate
      tg summary: Mark current branch with '>'
      tg -r REMOTE: Support for switching base remote
      tg summary: Fix spurious errors on tg-inconsistent remotes
      Fix recursive tg calls: Pass tg parameters through properly
      Account for direct-tg arguments in Usage strings
      tg import: Better description
      tg import: Standard script header
      tg import: Standard options parsing
      tg import: Remove tg_ prefixes from functions
      tg import: Change default prefix from tp/ to t/
      README: Add synopsis for working with remotes
      tg create -r BRANCH: Create branch based on a remote one
      tg import -p PREFIX: Custom prefix instead of t/
      tg import: Fix up process_commit() progress reporting
      branch_contains(): More explicit call to git rev-list
      tg import: Make the progress reporting stand out more
      Merge branch 'tg-import'
      README: Remove stale TODO
      TopGit-0.3

martin f. krafft (2):
      Add tg-export to gitignore
      Add various todos/wishlists


  Have fun,

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
