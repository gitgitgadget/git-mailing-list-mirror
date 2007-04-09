From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Mon, 09 Apr 2007 01:17:48 -0700
Message-ID: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 10:18:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hap4o-0008Ir-Nz
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 10:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbXDIIRv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 04:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbXDIIRv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 04:17:51 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63536 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbXDIIRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 04:17:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409081748.MSME27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 04:17:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kwHo1W0051kojtg0000000; Mon, 09 Apr 2007 04:17:49 -0400
X-master-at: 5bcbc7ff1014c58e7296713926206bf6a69e0f4c
X-next-at: ebd333fb4d5064745c274d16d7181e1adb23dfce
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44046>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/checkout (Sun Apr 8 22:08:31 2007 -0700) 7 commits
 + Teach git-reset to use index BASE extension.
 + git-read-tree --set-base=<sha1>
 + Use BASE index extension in git-am.
 + Move check_base() shell function to git-sh-setup
 + Use BASE index extension in git-commit and git-merge.
 + update-index --{set,get}-base
 + Add BASE index extension.

This series is primarily to make it safer when somebody else
updates the tip of the branch you have currently checked out.
As I said in previous messages, I think the series covers basic
operations fine but there probably are gaps in the coverage.
Motivated volunteers are needed to fill them.

* fl/cvsserver (Sat Apr 7 16:58:10 2007 +0200) 8 commits
 - cvsserver: Add asciidoc documentation for new database backend
   configuration
 + cvsserver: Corrections to the database backend configuration
 + cvsserver: Use DBI->table_info instead of DBI->tables
 + cvsserver: Abort if connect to database fails
 + cvsserver: Make the database backend configurable
 + cvsserver: Allow to override the configuration per access method
 + cvsserver: Handle three part keys in git config correctly
 + cvsserver: Introduce new state variable 'method'

Although the code looked sane, I do not interact with git
repositories over CVS protocol in real life, so I haven't
personally tested it.  I cannot push this out to 'master'
without positive feedbacks.  Testing needed.

* jc/read-tree-df (Sat Apr 7 07:17:35 2007 -0700) 5 commits
 - t3030: merge-recursive backend test.
 - merge-recursive: handle D/F conflict case more carefully.
 - merge-recursive: do not barf on "to be removed" entries.
 - Treat D/F conflict entry more carefully in unpack-
   trees.c::threeway_merge()
 - t1000: fix case table.

This is a follow-up to "my branch has foo/bar and I cannot
switch to another branch that has foo as a file" series.  It
deals with three-way merges that involve D/F conflicts.  Again,
heavy testing and reporting is needed until it graduates to
'master'.

* jc/quickfetch (Thu Apr 5 03:22:55 2007 -0700) 2 commits
 - git-fetch: use fetch--tool pick-rref to avoid local fetch from
   alternate
 - git-fetch--tool pick-rref

This is to alleviate Linus's worries about "git fetch" from a
repository whose object store is your alternate consuming too
much cycles in the new "SHA-1 collision detection" code, at the
same time avoiding to create a pack that has duplicate objects
in the repository due to the recent "keep" behaviour of
fetch-pack.

* js/wrap-log (Sun Apr 8 01:28:00 2007 -0700) 2 commits
 - shortlog -w: make wrap-line behaviour optional.
 - Use print_wrapped_text() in shortlog

This teaches "git shortlog" to wrap lines that are too long (by
default, 76 columns) when "-w" option is given.

This was resurrected from my held-box.  I do not have an
immediate need for it but somebody might.  Cheering-on and
documentation updates are needed for it to go anywhere.

* jc/the-index (Sun Apr 1 23:26:07 2007 -0700) 2 commits
 - Make read-cache.c "the_index" free.
 - Move index-related variables into a structure.

This libifies the "cache" part of the system.  Parked in 'pu' as
there is no immediate need, at least for me.

* jc/blame (Tue Mar 27 01:58:01 2007 -0700) 3 commits
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
* jc/pathattr (Thu Mar 1 01:20:21 2007 -0800) 5 commits
 - pathattr: allow piping to external program.
 - pathattr: read from git_config().
 - git-show: use pathattr to run "display"
 - pathattr: path based configuration of various attributes.
 + convert: add scaffolding for path based selection of conversion
   routines.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

These are stalled...
