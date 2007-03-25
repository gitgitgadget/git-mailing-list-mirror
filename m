From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sun, 25 Mar 2007 01:46:47 -0700
Message-ID: <7vk5x54snc.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	<7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
	<7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 10:47:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVONQ-0001lE-Aq
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 10:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbXCYIqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 04:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbXCYIqt
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 04:46:49 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39714 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbXCYIqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 04:46:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325084648.LCXT28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Mar 2007 04:46:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ewmn1W0021kojtg0000000; Sun, 25 Mar 2007 04:46:47 -0400
X-master-at: 12d6697f3a9f07db0c437438804aec994fc34035
X-next-at: 4208f7c8d29ade88a1fb7e4352ab1f35a702bfc8
In-Reply-To: <7vps7dle8j.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 13 Mar 2007 01:49:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43041>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/bisect (Fri Mar 23 17:54:03 2007 -0700) 6 commits
 + make the previous optimization work also on path-limited rev-list
   --bisect
 + rev-list --bisect: Fix "halfway" optimization.
 + t6004: add a bit more path optimization test.
 + git-rev-list --bisect: optimization
 + git-rev-list: add --bisect-vars option.
 + t6002: minor spelling fix.

This improves "rev-list --bisect" performance, sometimes
significantly, especially in a repository with long lines of
single-parent commits.  This is only about performance, and as
we are already in -rc1, the topic will have to wait 1.5.1.

* fl/cvsserver (Mon Mar 19 16:56:01 2007 +0100) 5 commits
 + cvsserver: Abort if connect to database fails
 + cvsserver: Make the database backend configurable
 + cvsserver: Allow to override the configuration per access method
 + cvsserver: Handle three part keys in git config correctly
 + cvsserver: Introduce new state variable 'method'

This is a beginning of supporting use of different database
backends, other than sqlite, with git-cvsserver.  Will not be in
'master' until 1.5.1 is done.

* js/remote-show-push (Sun Mar 18 21:34:46 2007 +0100) 1 commit
 + Teach git-remote to list pushed branches.

This is a new feature but of very little risk of breaking
anything, so I'll merge it to 'master'.

* ml/workdir (Sat Mar 17 02:58:55 2007 +0100) 6 commits
 . git-init: set core.workdir when GIT_WORK_DIR is specified
 . test GIT_WORK_DIR
 . test git-rev-parse
 . core.workdir config variable
 . introduce GIT_WORK_DIR environment variable
 . rev-parse: --is-bare-repository option

Waiting for a resend without "oops", "ah this is better"
iterations, but in no hurry, as it won't be in 'master' until
1.5.1 is done.

* jc/fpl (Tue Mar 13 01:57:22 2007 -0700) 1 commit
 + git-log --first-parent: show only the first parent log

This makes viewing topic-heavy style of project history
pleasant, at least in my opinion.  With a bit of cheering up,
I'd merge it to 'master', as it has been cooking in 'next'
without causing problems, and is of low-impact kind.  But it can
wait until 1.5.1 is done.

* jc/read-tree-df (Thu Mar 15 23:25:22 2007 -0700) 1 commit
 . Fix switching to a branch with D/F when current branch has file D.

This is unfortunately way premature as it seems to expose other
breakages this too-strict safety measure prevents from
happening.  We need to rethink the whole unpack_trees() business
after 1.5.1.

* jc/pathattr (Thu Mar 1 01:20:21 2007 -0800) 5 commits
 . pathattr: allow piping to external program.
 . pathattr: read from git_config().
 . git-show: use pathattr to run "display"
 . pathattr: path based configuration of various attributes.
 + convert: add scaffolding for path based selection of conversion
   routines.

Stalled.  gitattributes support should be one of the focus in
the 1.5.2 cycle.

* jc/merge-subtree (Thu Feb 15 16:32:45 2007 -0800) 1 commit
 - A new merge stragety 'subtree'.
* js/fetch-progress (Sun Feb 25 13:13:17 2007 -0800) 1 commit
 + git-fetch: add --quiet
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 . test-para: combined diff between HEAD, index and working tree.
 . para-walk: walk n trees, index and working tree in parallel

The above are stalled.
