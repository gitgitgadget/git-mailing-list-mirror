X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Wed, 13 Dec 2006 13:35:08 -0800
Message-ID: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 13 Dec 2006 21:35:21 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: 155bd0ce23144e5c7067965a22646523f1a38b51
X-master-at: 1d77043b005921cf7fcebfe680777df23ad10119
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34232>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gubl0-0000q1-0W for gcvg-git@gmane.org; Wed, 13 Dec
 2006 22:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751176AbWLMVfN convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWLMVfN
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 16:35:13 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49656 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751176AbWLMVfL convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 16:35:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213213509.RURN25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Wed, 13
 Dec 2006 16:35:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yMbL1V00L1kojtg0000000; Wed, 13 Dec 2006
 16:35:20 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

We have a handful fixes on 'maint'; I will be cutting v1.4.4.3 by
the end of the week.

On the 'master' front, this round has many topics (most of which
have been cooking in the 'next' branch) merged since the last
announcement.

 - Johannes Schindelin's built-in shortlog is in.

 - Johannes Schindelin's built-in 'RCS merge replacement' is
   in.  Hopefully this would make merge-recursive more portable
   and faster.

 - Shawn Pearce and Johannes Schindelin spotted and fixed a few
   corner cases in merge-recursive.

 - Updates to gitk from Paul Mackerras to fix longstanding menu
   issues on Mac OS X.

 - Eric Wong fixed use of rerere in many places.

 - Eric also has quite a few fixes to git-svn.

 - Nico updated 'git-add' to really mean 'add contents', not
   'add to the set of tracked paths'.  Also updated was the
   documentation for 'git commit' to make it easier to teach new
   people after a long discussion.

 - Lars Hjemli taught 'git-branch' to rename branches.

 - Andy Parkins taught 'git-branch' to be colorful.

 - Robin Rosenberg improved cvsexportcommit for unusual
   pathnames.

 - 'git push $URL :refs/tags/that' (notice the colon) can be
   used to delete 'that' tag from the remote repository; this
   needs the latest git on both ends.

 - branch."master".{remote,merge} configuration items are set up
   by 'git-clone', thanks to Andy Parkins.

 - 'git-commit' gives 'diff --summary' output to remind mode
   changes and added/deleted files.

 - 'git-diff --numstat' matches 'git-apply --numstat' when
   talking about binary changes.

 - 'git-merge' is now a first class UI, not just a mere driver
   for strategies.

I am hoping that we can start a stabilization cycle for v1.5.0
based on what we have in 'master'.  The theme is "usability and
teachability".

Things that need to be done to complete what have been merged to
'master' are:

 - 'git-rm' needs to be fixed up as Linus outlined; remove
   working tree file and index entry but have a sanity check to
   make sure the working tree file match the index and HEAD.

 - 'git-branch' may need to be taught about renaming the
   matching per-branch configuration at the same time.

 - 'git-merge-file' needs to be documented and linked from
   git.txt.

 - 'git-clone' probably should be updated to use wild-card in
   remote.origin.fetch, instead of listing all the branches it
   found when the clone was made.

 - tutorials and other Porcelain documentation pages need to be
   updated to match the updated 'git-add' and 'git-rm' (to be
   updated), and their description should be made much less
   about implementation; they should talk in terms of end-user
   workflows.  I will send a draft for 'git diff' out later, but
   somebody needs a full sweep on Porcelain-ish documentation.

 - 'git diff --index' patch should be reverted (already done in
   'next'), although we may have to come up with a better
   wording for --cached.

----------------------------------------------------------------
* The 'maint' branch has these fixes since v1.4.4.2.

   Alex Riesen (1):
      Clarify fetch error for missing objects.

   Brian Gernhardt (1):
      Move Fink and Ports check to after config file

   Chris Wright (1):
      no need to install manpages as executable

   Eric Wong (2):
      git-svn: exit with status 1 for test failures
      git-svn: correctly display fatal() error messages

   Jim Meyering (1):
      Don't use memcpy when source and dest. buffers may overlap

   Martin Langhoff (1):
      cvsserver: Avoid miscounting bytes in Perl v5.8.x

   Shawn O. Pearce (1):
      Make sure the empty tree exists when needed in merge-recursive.


* The 'master' branch has these since the last announcement.

   Alex Riesen (3):
      git-blame: fix rev parameter handling.
      Make perl/ build procedure ActiveState friendly.
      Clarify fetch error for missing objects.

   Andreas Ericsson (2):
      ls-files: Give hints when errors happen.
      git-diff: Introduce --index and deprecate --cached.

   Andy Parkins (6):
      Use .git/config for storing "origin" shortcut repository
      Document git-repo-config --bool/--int options.
      De-emphasise the symbolic link documentation.
      Explicitly add the default "git pull" behaviour to .git/config on=
 clone
      Colourise git-branch output
      Allow subcommand.color and color.subcommand color configuration

   Brian Gernhardt (1):
      Move Fink and Ports check to after config file

   Chris Wright (1):
      no need to install manpages as executable

   David Miller (1):
      Pass -M to diff in request-pull

   Eric Wong (21):
      git-svn: use ~/.subversion config files when using SVN:: librarie=
s
      git-svn: enable delta transfers during fetches when using SVN:: l=
ibs
      git-svn: update tests for recent changes
      git-svn: error out when the SVN connection fails during a fetch
      git-svn: fix output reporting from the delta fetcher
      git-svn: color support for the log command
      git-svn: documentation updates
      git-svn: fix multi-init
      git-svn: avoid fetching files twice in the same revision
      git-svn: avoid network timeouts for long-running fetches
      git-svn: extra error check to ensure we open a file correctly
      git-svn: use do_switch for --follow-parent if the SVN library sup=
ports it
      rerere: add clear, diff, and status commands
      rerere: record (or avoid misrecording) resolved, skipped or abort=
ed rebase/am
      git-svn: enable logging of information not supported by git
      git-svn: allow dcommit to take an alternate head
      git-svn: correctly display fatal() error messages
      git-svn: correctly handle packed-refs in refs/remotes/
      git-svn: exit with status 1 for test failures
      git-svn: correctly display fatal() error messages
      git-svn: correctly handle "(no author)" when using an authors fil=
e

   Han-Wen Nienhuys (1):
      ident.c: Trim hint printed when gecos is empty.

   J. Bruce Fields (4):
      cvs-migration: improved section titles, better push/commit explan=
ation
      Documentation: reorganize cvs-migration.txt
      Documentation: update git-clone man page with new behavior
      Documentation: simpler shared repository creation

   Jakub Narebski (4):
      gitweb: Fix Atom feed <logo>: it is $logo, not $logo_url
      git-clone: Rename --use-immingled-remote option to --no-separate-=
remote
      Document git-diff whitespace flags -b and -w
      gitweb: Allow PNG, GIF, JPEG images to be displayed in "blob" vie=
w

   Jeff King (1):
      shortlog: fix segfault on empty authorname

   Jim Meyering (2):
      Set permissions of each new file before "cvs add"ing it.
      Don't use memcpy when source and dest. buffers may overlap

   Johannes Schindelin (18):
      Build in shortlog
      shortlog: do not crash on parsing "[PATCH"
      shortlog: read mailmap from ./.mailmap again
      shortlog: handle email addresses case-insensitively
      shortlog: fix "-n"
      shortlog: use pager
      sha1_object_info(): be consistent with read_sha1_file()
      xdiff: add xdl_merge()
      xdl_merge(): fix an off-by-one bug
      xdl_merge(): fix thinko
      git-mv: search more precisely for source directory in index
      diff -b: ignore whitespace at end of line
      xdl_merge(): fix and simplify conflict handling
      cvs-migration document: make the need for "push" more obvious
      Add builtin merge-file, a minimal replacement for RCS merge
      merge-file: support -p and -q; fix compile warnings
      Get rid of the dependency on RCS' merge program
      merge-recursive: add/add really is modify/modify with an empty ba=
se

   Josef Weidendorfer (1):
      Add branch.*.merge warning and documentation update

   Junio C Hamano (45):
      Store peeled refs in packed-refs file.
      remove merge-recursive-old
      git-merge: make it usable as the first class UI
      merge: allow merging into a yet-to-be-born branch.
      Store peeled refs in packed-refs (take 2).
      git-fetch: reuse ls-remote result.
      git-fetch: fix dumb protocol transport to fetch from pack-pruned =
ref
      git-fetch: allow glob pattern in refspec
      Allow git push to delete remote ref.
      git-shortlog: fix common repository prefix abbreviation.
      git-shortlog: make common repository prefix configurable with .ma=
ilmap
      git-commit: show --summary after successful commit.
      git-fetch: allow forcing glob pattern in refspec
      fetch-pack: do not barf when duplicate re patterns are given
      git-merge: tighten error checking.
      git-merge: do not leak rev-parse output used for checking interna=
lly.
      cvsimport: style fixup.
      git blame -C: fix output format tweaks when crossing file boundar=
y.
      tutorial: talk about user.name early and don't start with commit =
-a
      git-merge: fix confusion between tag and branch
      xmerge: make return value from xdl_merge() more usable.
      merge-recursive: use xdl_merge().
      receive-pack: do not insist on fast-forward outside refs/heads/
      unpack-trees: make sure "df_conflict_entry.name" is NUL terminate=
d.
      read-tree: further loosen "working file will be lost" check.
      Loosen "working file will be lost" check in Porcelain-ish
      read-tree: document --exclude-per-directory
      git-reset to remove "$GIT_DIR/MERGE_MSG"
      git-merge: squelch needless error message.
      git-merge: fix "fix confusion between tag and branch" for real
      Fix perl/ build.
      git-rerere: add 'gc' command.
      Documentation/git-commit: rewrite to make it more end-user friend=
ly.
      git-commit: allow --only to lose what was staged earlier.
      shortlog: remove "[PATCH]" prefix from shortlog output
      shortlog: fix segfault on empty authorname
      diff --numstat: show binary with '-' to match "apply --numstat"
      add test case for recursive merge
      git-push: document removal of remote ref with :<dst> pathspec
      git merge: reword failure message.
      spurious .sp in manpages
      git-push: accept tag <tag> as advertised.
      send-pack: tighten checks for remote names
      branch --color: change default color selection.
      config documentation: group color items together.

   Lars Hjemli (3):
      git-branch: add options and tests for branch renaming
      rename_ref: use lstat(2) when testing for symlink
      git-branch: let caller specify logmsg

   Martin Langhoff (1):
      cvsserver: Avoid miscounting bytes in Perl v5.8.x

   Michael Loeffler (1):
      git-fetch: ignore dereferenced tags in expand_refs_wildcard

   Nicolas Pitre (4):
      builtin git-shortlog is broken
      pack-objects: remove redundent status information
      make 'git add' a first class user friendly interface to the index
      change the unpack limit treshold to a saner value

   Paul Mackerras (1):
      gitk: Fix enabling/disabling of menu items on Mac OS X

   Ren=E9 Scharfe (1):
      shortlog: remove range check

   Robin Rosenberg (1):
      Make cvsexportcommit work with filenames with spaces and non-asci=
i characters.

   Sean Estabrooks (1):
      Update documentation to remove incorrect GIT_DIFF_OPTS example.

   Shawn O. Pearce (17):
      Teach git-completion.bash how to complete git-merge.
      Hide plumbing/transport commands from bash completion.
      Teach bash how to complete options for git-name-rev.
      Add current branch in PS1 support to git-completion.bash.
      Teach bash how to complete git-format-patch.
      Teach bash how to complete git-cherry-pick.
      Teach bash how to complete git-rebase.
      Teach bash about git log/show/whatchanged options.
      Support bash completion of refs/remote.
      Teach bash about git-repo-config.
      Support --strategy=3Dx completion in addition to --strategy x.
      Cache the list of merge strategies and available commands during =
load.
      Teach bash about git-am/git-apply and their whitespace options.
      Teach bash how to complete long options for git-commit.
      Fix broken bash completion of local refs.
      Make sure the empty tree exists when needed in merge-recursive.
      Remove uncontested renamed files during merge.

   Uwe Zeisberger (1):
      Fix documentation copy&paste typo


