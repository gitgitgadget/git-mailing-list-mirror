X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sat, 25 Nov 2006 02:12:38 -0800
Message-ID: <7vzmaf3kdl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 25 Nov 2006 10:13:00 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: f73da29fa2be2f4bbda86e006b743b8121bdbf19
X-master-at: f64d7fd267c501f501e18a888e3e1e0c5b56458f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32274>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnuWj-0002oI-52 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 11:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966377AbWKYKMl convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006 05:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966384AbWKYKMl
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 05:12:41 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44218 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S966377AbWKYKMk
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006
 05:12:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125101240.DTNN5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Sat, 25
 Nov 2006 05:12:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qyCn1V00X1kojtg0000000; Sat, 25 Nov 2006
 05:12:48 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Executive Summary
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The 'maint' branch still has a handful more post v1.4.4.1
fixes.

Aside from the usual gitweb and git-svn updates, the 'master'
branch has one notable change that everybody should hopefully
welcome.  separate-remote layout is now the default for newly
cloned repositories.  We would be needing documentation updates
and probably some more minor fixes for fallout from this, but I
do not expect anything majorly broken.

Cooking in 'next' are handful topics:

 * "git shortlog bottom..top" can be used instead of a pipeline
   "git log bottom..top | git shortlog".

 * "git merge -m message <commit>" is another natural way to
   perform a local merge, in addition to the traditional
   "git pull . <localbranch>".  The former is more powerful in
   that it can take arbitrary <committish>, not just a ref.

 * The new "--depth $n" parameter to git clone/fetch tries to
   limit the commit ancestry depth to $n.  This still has known
   issues (for example, shallowly cloning the git.git repository
   and then deepening the result with large --depth parameter
   later does not seem to make the resulting repository fully
   connected, and fsck-objects reports corruption), so please
   handle it with care.

 * "git show-ref", especially the "-d" variant, is much more
   efficient when used in a repository with pack-pruned refs.

 * "git fetch" can fetch from a repository with pack-pruned refs
   over dumb protocol transports.

 * "git push $URL '':$ref" can be used to delete an existing ref
   from the remote side.

 * A glob pattern "Pull: refs/heads/*:refs/remotes/origin/*" is
   allowed in the remotes file.  The fetch can be forced by
   prefixing the specification with a '+'.

Currently 'pu' does not have much to speak of.

This update has rather large impact so the kernel list is CC'ed.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

   Andy Parkins (1):
      Increase length of function name buffer

   Eric Wong (3):
      git-svn: error out from dcommit on a parent-less commit
      git-svn: correctly handle revision 0 in SVN repositories
      git-svn: preserve uncommitted changes after dcommit

   Ren=E9 Scharfe (1):
      archive-zip: don't use sizeof(struct ...)


* The 'master' branch has these since the last announcement.

   Andy Parkins (3):
      Improve git-prune -n output
      Add support to git-branch to show local and remote branches
      Increase length of function name buffer

   Eric Wong (6):
      git-svn: error out from dcommit on a parent-less commit
      git-svn: correctly handle revision 0 in SVN repositories
      git-svn: preserve uncommitted changes after dcommit
      git-svn: handle authentication without relying on cached tokens o=
n disk
      git-svn: correctly access repos when only given partial read perm=
issions
      git-svn: exit with status 1 for test failures

   I=F1aki Arenaza (1):
      git-cvsimport: add support for CVS pserver method HTTP/1.x proxyi=
ng

   Jakub Narebski (8):
      gitweb: Protect against possible warning in git_commitdiff
      gitweb: Buffer diff header to deal with split patches + git_patch=
set_body refactoring
      gitweb: Default to $hash_base or HEAD for $hash in "commit" and "=
commitdiff"
      gitweb: New improved formatting of chunk header in diff
      gitweb: Add an option to href() to return full URL
      gitweb: Refactor feed generation, make output prettier, add Atom =
feed
      gitweb: Finish restoring "blob" links in git_difftree_body
      gitweb: Replace SPC with &nbsp; also in tag comment

   Junio C Hamano (9):
      upload-pack: stop the other side when they have more roots than w=
e do.
      apply --numstat: mark binary diffstat with - -, not 0 0
      pack-objects: tweak "do not even attempt delta" heuristics
      refs outside refs/{heads,tags} match less strongly.
      Typefix builtin-prune.c::prune_object()
      gitweb: (style) use chomp without parentheses consistently.
      git-clone: stop dumb protocol from copying refs outside heads/ an=
d tags/.
      git-branch -D: make it work even when on a yet-to-be-born branch
      git-fetch: exit with non-zero status when fast-forward check fail=
s

   Lars Hjemli (1):
      Add -v and --abbrev options to git-branch

   Peter Baumann (1):
      config option log.showroot to show the diff of root commits

   Petr Baudis (1):
      Make git-clone --use-separate-remote the default

   Ren=E9 Scharfe (1):
      archive-zip: don't use sizeof(struct ...)


* The 'next' branch, in addition, has these.

   Alexandre Julliard (6):
      Shallow clone: do not ignore shallowness when following tags
      fetch-pack: Properly remove the shallow file when it becomes empt=
y.
      upload-pack: Check for NOT_SHALLOW flag before sending a shallow =
to the client.
      git-fetch: Reset shallow_depth before auto-following tags.
      get_shallow_commits: Avoid memory leak if a commit has been reach=
ed already.
      fetch-pack: Do not fetch tags for shallow clones.

   Jakub Narebski (1):
      gitweb: Do not use esc_html in esc_path

   Johannes Schindelin (10):
      Build in shortlog
      shortlog: do not crash on parsing "[PATCH"
      shortlog: read mailmap from ./.mailmap again
      shortlog: handle email addresses case-insensitively
      shortlog: fix "-n"
      upload-pack: no longer call rev-list
      support fetching into a shallow repository
      allow cloning a repository "shallowly"
      allow deepening of a shallow repository
      add tests for shallow stuff

   Junio C Hamano (19):
      Store peeled refs in packed-refs file.
      remove merge-recursive-old
      git-merge: make it usable as the first class UI
      merge: allow merging into a yet-to-be-born branch.
      git-diff/git-apply: make diff output a bit friendlier to GNU patc=
h (part 2)
      Store peeled refs in packed-refs (take 2).
      git-fetch: reuse ls-remote result.
      git-fetch: fix dumb protocol transport to fetch from pack-pruned =
ref
      git-fetch: allow glob pattern in refspec
      Allow git push to delete remote ref.
      We should make sure that the protocol is still extensible.
      Why does it mean we do not have to register shallow if we have on=
e?
      Why didn't we mark want_obj as ~UNINTERESTING in the old code?
      shallow clone: unparse and reparse an unshallowed commit
      git-shortlog: fix common repository prefix abbreviation.
      git-shortlog: make common repository prefix configurable with .ma=
ilmap
      git-commit: show --summary after successful commit.
      git-fetch: allow forcing glob pattern in refspec
      fetch-pack: do not barf when duplicate re patterns are given

   Nicolas Pitre (1):
      builtin git-shortlog is broken


* The 'pu' branch, in addition, has these.

   Junio C Hamano (4):
      para-walk: walk n trees, index and working tree in parallel
      rev-list --left-right
      blame: --show-stats for easier optimization work.
      gitweb: steal loadavg throttle from kernel.org

