X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 06 Dec 2006 13:19:06 -0800
Message-ID: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 21:19:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33522>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs4Aj-0000h1-6Y for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937653AbWLFVTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 16:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937655AbWLFVTJ
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:19:09 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:41304 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937653AbWLFVTH (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 16:19:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206211907.UMEZ3525.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 16:19:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vZKH1V0031kojtg0000000; Wed, 06 Dec 2006
 16:19:17 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Here is a list of topics that are cooking; the commits marked
with '+' are in 'next', '-' are in 'pu'.  Dates are when the
topic was last touched [*1*].

----------------------------------------------------------------

* ap/clone-origin (Wed Dec 6 12:07:23 2006 +0000)
 + Explicitly add the default "git pull" behaviour to .git/config on clone

 This makes 'git clone' to mark the local 'master' to explicitly
 merge with the corresponding remote branch, which would be a
 sensible default.

 As discussed on the list earlier, I think it also would make
 sense to forbid 'git pull' to make a merge when:

 (1) branch.*.merge entries exist in $GIT_DIR/config (which
     signals that the user is using this new mechanism), and
 (2) branch.<current-branch>.merge entry does not exist for the
     current branch.

 I think it is sensible to merge to 'master' after that change.

* jc/3way (Wed Nov 29 18:53:13 2006 -0800)
 + git-merge: preserve and merge local changes when doing fast forward

 This allows you to run a 'git merge' (or 'git pull') that
 results in a fast-forward merge that updates a path your
 working tree has modified locally; it merges your local changes
 into the updated version, in the same way the branch switching
 'git checkout -m' works.  It has been in next for some time and
 unless we hear somebody scream I think it is Ok to merge to
 'master'.
 
* jc/blame-boundary (Fri Dec 1 20:45:45 2006 -0800)
 - git-blame: show lines attributed to boundary commits differently.

 This was discussed in a thread on grouping the short-log entries
 differently and measuring the importance of each commit.  While
 it does not break things per-se, nobody seems to want to use it
 for scripting yet, so it is staying in 'pu'.

* jc/commit-careful (Tue Oct 24 21:48:55 2006 -0700)
 + git-commit: show --summary after successful commit.

 I think this is safe to merge to 'master'.

* jc/diff (Mon Sep 25 23:03:34 2006 -0700)
 - para-walk: walk n trees, index and working tree in parallel

 This has been backburnered for a long time.  No time to work on
 and no immediate need to use it for scripts myself yet.

* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700)
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch (part 2)

 This changes the output of "git diff" for a filename with
 embedded SP and requires everybody to switch to its predecessor
 commit ce74618d (which is in v1.4.4 but not in v1.4.3 series)
 which prepared for this change.  Perhaps sometime in February.

* jc/explain (Mon Dec 4 19:35:04 2006 -0800)
 - git-explain

 This was just a discussion starter.  I tried to reuse existing
 status markers various existing command leaves, but it might be
 a good idea to invent a unified status marker to help 'git
 explain' (or 'git wtf') command, so that everybody can write
 into the same file and 'explain' has to know only about that
 file.  I dunno.

* jc/fpc (Sun Nov 26 16:29:07 2006 -0800)
 - (experimental) per-topic shortlog.

 This was my attempt to give a different grouping of the
 short-log entries.  Will drop soon from 'pu'.

* jc/leftright (Sun Oct 22 17:32:47 2006 -0700)
 - rev-list --left-right.

 When reviewing "git log --merge" I often wish which side each
 of the commits comes from, and this is to achieve that.  I
 haven't met with an enthusiastic support for it, though.
 Perhaps people do not find need for that, or do not do
 complicated merges, or have other tools that I do not regularly
 use that is better than this approach; in which case I should
 probably drop this.

* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800)
 - blame: --show-stats for easier optimization work.

* jc/read-tree-ignore (Tue Dec 5 23:44:23 2006 -0800)
 + read-tree: document --exclude-per-directory
 + Loosen "working file will be lost" check in Porcelain-ish
 + read-tree: further loosen "working file will be lost" check.

 I think this is a 'master' material modulo bugs.  Will cook
 further in 'next'.

* jc/web (Wed Nov 8 14:54:09 2006 -0800)
 - gitweb: steal loadavg throttle from kernel.org

* js/merge (Wed Dec 6 16:45:42 2006 +0100)
 + merge-file: support -p and -q; fix compile warnings
 + Add builtin merge-file, a minimal replacement for RCS merge
 + xdl_merge(): fix and simplify conflict handling
 + xdl_merge(): fix thinko
 + xdl_merge(): fix an off-by-one bug
 + merge-recursive: use xdl_merge().
 + xmerge: make return value from xdl_merge() more usable.
 + xdiff: add xdl_merge()

 merge-recursive that does not rely on RCS "merge".  I use this
 exclusively these days.  Perhaps cook a little further and
 merge to 'master'.

* js/shallow (Fri Nov 24 16:00:13 2006 +0100)
 + fetch-pack: Do not fetch tags for shallow clones.
 + get_shallow_commits: Avoid memory leak if a commit has been reached already.
 + git-fetch: Reset shallow_depth before auto-following tags.
 + upload-pack: Check for NOT_SHALLOW flag before sending a shallow to the client.
 + fetch-pack: Properly remove the shallow file when it becomes empty.
 + shallow clone: unparse and reparse an unshallowed commit
 + Why didn't we mark want_obj as ~UNINTERESTING in the old code?
 + Why does it mean we do not have to register shallow if we have one?
 + We should make sure that the protocol is still extensible.
 + add tests for shallow stuff
 + Shallow clone: do not ignore shallowness when following tags
 + allow deepening of a shallow repository
 + allow cloning a repository "shallowly"
 + support fetching into a shallow repository
 + upload-pack: no longer call rev-list

 The shallow clone.  I do not use it myself but it does not seem
 to break the system for users that do not use shallow
 repositories.  Probably with a better documentation of its
 limitations and caveats, this should be mergeable to 'master'.

* lh/branch-rename (Thu Nov 30 03:16:56 2006 +0100)
 + git-branch: let caller specify logmsg
 + rename_ref: use lstat(2) when testing for symlink
 + git-branch: add options and tests for branch renaming

 I do not rename branches myself and do not see a need for this
 nor I have tested it in real-world setting.  The code seemed
 clean and may be 'master' material.

* np/addcommit (Mon Dec 4 11:13:39 2006 -0500)
 + make 'git add' a first class user friendly interface to the index

* sv/git-svn (Tue Dec 5 16:17:38 2006 +1100)
 - git-svn: re-map repository URLs and UUIDs on SVK mirror paths
 - git-svn: collect revision properties when fetching
 - git-svn: collect SVK source URL on mirror paths
 - git-svn: let libsvn_ls_fullurl return properties too
 - git-svn: make test for SVK mirror path import

 Eric already commented on them but no progress since then.
 Parked in 'pu' only for discussion and these will be replaced
 when resubmitted.


[Footnote]

*1* I am trying out an alternative to short-log.  I think the
above format is easier to see what is going on than separate
short-log for 'next' and 'pu'.  It is based on the "TO" script
found in 'todo' branch but hand edited.

