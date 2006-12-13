X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git
Date: Wed, 13 Dec 2006 13:38:00 -0800
Message-ID: <7vwt4veatj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 21:38:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34233>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gubni-0001Jp-RD for gcvg-git@gmane.org; Wed, 13 Dec
 2006 22:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750992AbWLMViD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 16:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWLMViD
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 16:38:03 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:50831 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750992AbWLMViB (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 16:38:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213213801.SBLZ25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Wed, 13
 Dec 2006 16:38:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yMeC1V00F1kojtg0000000; Wed, 13 Dec 2006
 16:38:12 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I think the last issue in "consolidated topic listing" format
was a success, so this is in the same format.  In the following
listing, a commit in 'next' has '+' in front, and the ones only
in 'pu' have '-' in front.  The date after each topic name is
the last time the topic was touched.

* jc/diff--cached (Wed Dec 13 01:33:43 2006 -0800) 1 commit
 + Revert "git-diff: Introduce --index and deprecate --cached."

Will merge to 'master' shortly and will be in v1.5.0.

* jc/git-add--interactive (Mon Dec 11 17:09:26 2006 -0800) 2 commits
 - git-add --interactive: hunk splitting
 - git-add --interactive

Undecided.  Either drop it altogether or merge it to 'next'
after adding 'edit' interface to the index contents.

* jn/web (Sun Dec 10 13:25:49 2006 +0100) 5 commits
 + gitweb: SHA-1 in commit log message links to "object" view
 + gitweb: Hyperlink target of symbolic link in "tree" view (if
   possible)
 + gitweb: Add generic git_object subroutine to display object of any
   type
 + gitweb: Show target of symbolic link in "tree" view
 + gitweb: Don't use Content-Encoding: header in git_snapshot

Haven't looked at them fully, but likely to be in v1.5.0.

* jc/blame-boundary (Fri Dec 1 20:45:45 2006 -0800) 1 commit
 + git-blame: show lines attributed to boundary commits differently.

This does not break gitweb nor git-cvsserver because they have
no way to specify boundary commits.  Likely to be in v1.5.0.

Later we can update gitweb to allow specifying the range and
handle 'boundary' annotations in a special way.

* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain

We probably should come up with a unified way to allow various
commands that can leave the working tree into special states to
communicate with each other first.  Will NOT be in v1.5.0.

* jc/patch-inline-comments (Fri Dec 8 21:03:52 2006 -0800) 1 commit
 - mailinfo: hack to accept in-line annotations in patches.

Will drop.

* sv/git-svn (Tue Dec 5 16:17:38 2006 +1100) 5 commits
 - git-svn: re-map repository URLs and UUIDs on SVK mirror paths
 - git-svn: collect revision properties when fetching
 - git-svn: collect SVK source URL on mirror paths
 - git-svn: let libsvn_ls_fullurl return properties too
 - git-svn: make test for SVK mirror path import

Sam Villain's SVN fixes are queued in 'pu' but the series hasn't
seen updates after Eric commented on them.  Still on hold.

* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward

This does the magic unconditionally which I am not 100% happy
about, because the resulting mess could be too large to handle.
On the other hand, the user deserves what he gets if he starts a
merge from wildly unclean state, so it may not be too much of an
issue.  Undecided.

* jc/leftright (Sun Oct 22 17:32:47 2006 -0700) 1 commit
 - rev-list --left-right

I think this needs a better UI integration into 'git log' and
friends, not just rev-list.  Currently, I can say:

  $ git rev-list --no-merges --left-right --pretty v1.4.4.2...master

but that still misses --stat and --patch output.  If people find
this useful, maybe we would want to merge it to 'next' after
adding the option to log and friends (or turn it on
automatically when symmetric difference is used).

* js/shallow (Fri Nov 24 16:00:13 2006 +0100) 15 commits
 + fetch-pack: Do not fetch tags for shallow clones.
 + get_shallow_commits: Avoid memory leak if a commit has been
   reached already.
 + git-fetch: Reset shallow_depth before auto-following tags.
 + upload-pack: Check for NOT_SHALLOW flag before sending a shallow
   to the client.
 + fetch-pack: Properly remove the shallow file when it becomes
   empty.
 + shallow clone: unparse and reparse an unshallowed commit
 + Why didn't we mark want_obj as ~UNINTERESTING in the old code?
 + Why does it mean we do not have to register shallow if we have
   one?
 + We should make sure that the protocol is still extensible.
 + add tests for shallow stuff
 + Shallow clone: do not ignore shallowness when following tags
 + allow deepening of a shallow repository
 + allow cloning a repository "shallowly"
 + support fetching into a shallow repository
 + upload-pack: no longer call rev-list

The 'shallow clone'.  Most likely post v1.5.0.

* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org

If somebody steps up to maintain the gitweb installation at
kernel.org, merging this would make one less thing to customize
there.  Undecided.

* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.

This is developer-only; will hold.

* jc/diff (Mon Sep 25 23:03:34 2006 -0700) 1 commit
 - para-walk: walk n trees, index and working tree in parallel

Backburnered and will continue to hold.  I suspect unpack-trees
logic that is used by read-tree would turn out to be too
cumbersome to optimize and at that point this might become
useful.

* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

Will hold until February.
