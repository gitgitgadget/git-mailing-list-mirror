From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Thu, 28 Sep 2006 00:39:11 -0700
Message-ID: <7vodt0zbhc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 28 09:39:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSqUG-0001Gs-Sx
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 09:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWI1HjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 03:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWI1HjN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 03:39:13 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14548 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751756AbWI1HjM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 03:39:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928073911.CJRD16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 03:39:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TjfD1V00o1kojtg0000000
	Thu, 28 Sep 2006 03:39:14 -0400
To: git@vger.kernel.org
X-maint-at: f2b5792564754d5ba812a0d3eaec2440dfc0652a
X-master-at: 2d5b459107cf07bbb307cfb196c2007c497a6dd2
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27994>

* The 'master' branch has these since the last announcement.
  There are some small bits I'd like to merge still brewing in
  'next' before the -rc1, but please expect a real 1.4.3-rc1
  soon.

  - git-daemon virtual hosting.

  - With git-branch, deleting branch a/b and then creating
    branch a did not work.  Fixed.

  - Updated git-archive documentation.

  - git-repack can be run from project subdirectory.

  - git-log and friends can limit output with --author,
    --committer and --grep options.

  - Minor git-runstatus by Johannes Schindelin.

  - git-diff --color highlights whitespace errors.

  - git-apply --whitespace={warn,error,strip} notices whitespace
    errors in indentation.

  - git-tar is now a thin wrapper to "git-archive --format=tar";
    "git-tar --remote" talks with "git-upload-archive" on the
    other end.

  - Python-based merge-recursive is deprecated.  It is still
    available as "recursive-old" strategy, but "recursive"
    strategy now uses the C implementation.  The earlier synonym
    "recur" still available.

  - "git-grep --fixed-strings" with boolean expression did not
    work; fixed.

  - git-pack-objects generates packfile version 3 that can
    express copying of larger block from delta base.

  - Many internal routines that deal with using packfiles have
    been cleaned up.

  - Many updates to gitweb by the usual suspects.

  - Default repository to fetch from, and the remote branches to
    merge, can be specified by per-branch configuration items.

  - git-svnimport gets the full author name from Signed-off-by:
    line when available.

  - git-svn got a few updates.

  - git-checkout while not on a branch (e.g. git-init-db
    followed by git-fetch to create branches from remotes) did
    not work; fixed.

  - Even when core.filemode is set to false (i.e. the filesystem
    does not have reliable mode bits), git-update-index still
    registered new paths with random mode bits obtained from the
    filesystem.  Fixed.


* The 'next' branch, in addition, has these.  I think the ones
  marked with + could be 1.4.3-rc1 material:

  - Triggered by the packed-ref series from Linus, we have
    accumulated a few topics, but I decided to consolidate them
    into one topic branch.  It contains:

    - resolve_ref() API cleanup;

    - for_each_ref() API cleanup;

    - git-show-ref helper;

    - git-for-each-ref helper;

    - ref locking fix-up to tighten races for ref creation and
      deletion cases;

    - packed refs and pruning of refs;

    - git-receive-pack now uses lock_ref_sha1() API and updates
      ref-log like other programs;

    The series still has a few problems I listed in my earlier
    message:

	Subject: What will happen to git.git in the near future
	Message-ID: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net>

    I do not plan to include this in the next release; hopefully
    soon after the next release we can have it in 'master'.  

  - cvsimport was updated to use for-each ref.  This obviously
    depends on the above.

  + Git.pm lost Git.xs; its remnant still remains, though.
    Notably, we still compile x86_64 with -fPIC, and the top
    level Makefile has {BASIC,ALL}_{CFLAGS,LDFLAGS} distinction
    and INSTALL talks about perl/blib/arch/auto.  I am torn
    between removing these and keeping them; on one hand, they
    are not needed and makes new developers wonder what the
    distinction between BASIC and ALL are.  On the other hand,
    we may eventually would want to reintroduce Git.xs in the
    future and keeping them might help us.  But on the third
    hand ;-), we can always resurrect it from the repository and
    that is the point of using git to keep track of the project,
    so removing them might not be such a big deal.  I'd like to
    decide between this two and push it out to 'master' before
    doing the -rc1.

  + More gitweb updates from usual suspects.

  + "git-diff --stat" can now be told to use custom output width
    with --stat-width=N option instead of the default 80.

  + "git-diff --stat --color" shows the graph in colors.

  - "git-grep --all-match" limits output to files that have all
    the top-level ORed expressions.  I suck at documentation and
    the description I added to the manual needs rewriting.
    Help?

  - git-log and friends learned the same --all-match flag.  With
    it:

    	git log --all-match --author=Linus --committer=Junio --grep=list

    would show only changes written by Linus and committed by me
    and talks about "list".

  - updates to packfile format that allows delta base objects to
    be expressed by offset in the stream, not by 20-byte object
    name.  Just completed and started cooking in 'next'.

  - upload-pack: stop the other side when they have more roots than we do.


* The 'pu' branch, in addition, has these.

  - change "git-diff" output for paths with embedded SP a bit
    friendlier to "GNU patch".  This is done by appending an
    extra TAB after "--- a/file name" and "+++ b/file name"
    lines.  This needs to be done in two steps:

    - prepare git-apply to take the new output format.

    - update git-diff to produce such, after people's git-apply
      has been updated.

    Do people have objection to the output format change?
    Otherwise I'd like to merge the first stage to 'next', and
    perhaps soon after 1.4.3 to 'master'.

  - two git-cvsexportcommit improvements, which unfortunately
    fails with certain combination of patch/perl/cvs; breakage
    under investigation by the author.
