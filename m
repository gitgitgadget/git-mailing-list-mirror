From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Thu, 21 Jun 2007 00:20:04 -0700
Message-ID: <7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	<7virac547s.fsf@assigned-by-dhcp.cox.net>
	<7v6466oygl.fsf@assigned-by-dhcp.cox.net>
	<7vfy54tt3l.fsf@assigned-by-dhcp.cox.net>
	<7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 09:20:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Gxf-0007ZH-9d
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 09:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbXFUHUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 03:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbXFUHUH
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 03:20:07 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57607 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbXFUHUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 03:20:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621072005.UBOU1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 03:20:05 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E7L41X0041kojtg0000000; Thu, 21 Jun 2007 03:20:04 -0400
X-master-at: 45fd8bd32dd68ce6b14a406d0abbd6f56490131c
X-next-at: 51a8ba376307c599c9c76b01a298fbc623d2013b
In-Reply-To: <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Wed, 13 Jun 2007 13:29:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50604>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* lt/follow (Tue Jun 19 14:22:46 2007 -0700) 1 commit
 + Finally implement "git log --follow"

Has leaks, and it won't graduate to 'master' without
documentation.

Also I am not convinced its handling of merges is sane.  If you
have an ancestry graph like this, and the commit A renames the
followed path, it would show the file _before_ rename, which is
very good.

      o-------B---A---o----o
                     /  
        o----C------'
    
But the code changes pathspec globally, so when we are looking
at C, it may or may not have that (before-renamed) path there.

At least, the patch is small and would not affect codepath that
does not use this option, so in that sense it is relatively safe
change, though.

* jc/oneline (Fri Jun 15 13:19:07 2007 +0100) 4 commits
 + pp_header(): work around possible memory corruption
 + Fix ALLOC_GROW off-by-one
 + Extend --pretty=oneline to cover the first paragraph,
 + Lift 16kB limit of log message output
* jk/add-empty (Tue Jun 12 23:42:14 2007 +0200) 2 commits
 + builtin-add: simplify (and increase accuracy of) exclude handling
 + dir_struct: add collect_ignored option

Will merge this weekend.

* ns/clone (Sat Jun 16 15:26:08 2007 -0700) 1 commit
 + Cloning from a repo without "current branch"

Will merge this weekend.

* js/filter (Fri Jun 8 23:28:50 2007 +0200) 11 commits
 + filter-branch: subdirectory filter needs --full-history
 + filter-branch: Simplify parent computation.
 + Teach filter-branch about subdirectory filtering
 + filter-branch: also don't fail in map() if a commit cannot be
   mapped
 + filter-branch: Use rev-list arguments to specify revision ranges.
 + filter-branch: fix behaviour of '-k'
 + filter-branch: use $(($i+1)) instead of $((i+1))
 + chmod +x git-filter-branch.sh
 + filter-branch: prevent filters from reading from stdin
 + t7003: make test repeatable
 + Add git-filter-branch

Will merge this weekend.

* ew/svn (Wed Jun 13 02:23:28 2007 -0700) 1 commit
 + git-svn: allow dcommit to retain local merge information

Haven't heard major breakage report, so hopefully can merge by
the end of the month.

* ml/worktree (Fri Jun 8 22:57:55 2007 +0200) 9 commits
 + make git barf when an alias changes environment variables
 + setup_git_directory: fix segfault if repository is found in cwd
 + test GIT_WORK_TREE
 + extend rev-parse test for --is-inside-work-tree
 + Use new semantics of is_bare/inside_git_dir/inside_work_tree
 + introduce GIT_WORK_TREE to specify the work tree
 + test git rev-parse
 + rev-parse: introduce --is-bare-repository
 + rev-parse: document --is-inside-git-dir

I've been resisting this but I think its definition of is-bare
is a bit saner than what we have in 'master', and I think it is
the right direction in the longer term.  HOWEVER, I am not sure
about the implementation and corner cases, e.g. what should it
do in receive-pack?  You cannot rely on user setting GIT_WORK_TREE
environment -- rather, receive-pack is responsible for setting
up a sane environment for other commands to work in.

* jo/init (Thu Jun 7 07:50:30 2007 -0500) 2 commits
 - Quiet the output from git-init when cloning, if requested.
 - Add an option to quiet git-init.
