From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 24 Sep 2006 03:37:57 -0700
Message-ID: <7vd59lbldm.fsf@assigned-by-dhcp.cox.net>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net>
	<7vu035u4c3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 24 12:38:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRRN7-0004z6-SY
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 12:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWIXKh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 06:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWIXKh7
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 06:37:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38865 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751914AbWIXKh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 06:37:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924103757.XQPA13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Sep 2006 06:37:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id SAdz1V00M1kojtg0000000
	Sun, 24 Sep 2006 06:38:00 -0400
To: git@vger.kernel.org
X-maint-at: f2b5792564754d5ba812a0d3eaec2440dfc0652a
X-master-at: ed1795fcc5f2aa3f105630429bcbed49c50053fa
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27651>

* The 'maint' branch has these fixes since the last announcement.

   t3403-rebase-skip failed when run while its standard input is
   connected to /dev/null.  It turns out that an earlier safety
   check to prevent git-am to be fed a new patch while there is
   a leftover .dotest/ directory was incorrect.  Fixed.

   There was an unnecessary xmalloc() in builtin-add.  Removed.

* The 'master' branch has these since the last announcement.

   Recent change to http-fetch.c did not play well with older
   curl releases.  Fixed.

   Clean-up of gitweb continues.  Notably, generation the
   summary page makes fewer call to git executable.

   Receive-pack has an added safety check that lets the
   repository owner to forbid non-fast-forward push into a
   shared repository by setting receive.denyNonFastforwards
   configuration variable.

   Output from git-describe can now be used as an abbreviated
   object name.

   git-resolve is now officially deprecated.  The next "master"
   release (1.4.3) will ship with a version that gives an
   annoying "deprecation warning" message, and the command will
   be removed from the release after that.

   There was a build problem in upload-archive on OpenBSD.  Fixed.

   git-zip-tree is now superseded by "git-archive --format=zip".

   Miscellaneous clean-ups and documentation updates.

* The 'next' branch, in addition, has these.

   A new command git-show-ref was added to list and verify local
   references.

   A new command git-for-each-ref was added to help Porcelains
   to make smaller number of calls to git binary to obtain
   summary information for refs.

   cvsimport was updated to use git-for-each-ref.

   Git.pm topic lost Git.xs for now.

   The resolve_ref() internal API was straightened out to work
   solely on refname (i.e. string that begins with "refs/"),
   instead of pathnames.  To deal with many refs efficiently,
   there is now a "packed-ref" format where many refs are stored
   in a single flat file instead of the traditional
   one-ref-per-file format.

   git-diff --color highlights trailing whitespaces and SP
   followed by TAB in indentation as common whitespace errors.

   git-daemon now has a virtual host support.

   upload-pack stops the fetch-pack on the other side when
   downloader has more roots than uploader; otherwise the
   downloader would send "have" from a development line that
   the uploader does not know about til its root.

   git-log learned --author=, --committer= and --grep= options
   to filter commits.

   pack-objects now creates version 3 packs; this allows a copy
   of larger block of data to be expressed.

   Per branch configuration items branch."branchname".remote can
   specify what remotes/ file instead of usual "origin" should
   be used when no option is given to "git fetch" while on the
   named branch.  Similarly, branch."branchname".merge can
   specify which remote branches to be merged while on the named
   branch.

   git-svnimport learned a new trick to parse log message for
   Signed-off-by: lines and pick authorship information from
   there.  I haven't heard Ack nor Nack from any subversion
   users, but we will hopefully hear somebody scream if it
   breaks things after pushing it out to "master".

* The 'pu' branch, in addition, has these.

   git-apply --whitespace learned to notice SP before TAB in
   indent as a common whitespace error, in addition to the
   trailing whitespaces it already knew about.

   git-diff output is unfriendly to GNU patch when the filename
   contained a SP.  Appending a TAB after filename in this case
   works the problem around.  However, git-apply needs to learn
   about it as well, so it did.

   There is one new data type in the pack format that records
   delta base object by offset in the stream instead of 20-byte
   object name.  This reduces the resulting packsize by 3 to 5%.

   One additional test for git-branch is in, but the current
   implementation of git-branch fails it.
