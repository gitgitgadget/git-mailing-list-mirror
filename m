From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git and announcing v1.4.1-rc1
Date: Thu, 22 Jun 2006 12:49:47 -0700
Message-ID: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 21:50:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtVBk-0005br-Ig
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 21:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbWFVTtv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Jun 2006 15:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWFVTtv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 15:49:51 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23705 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1161211AbWFVTtt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 15:49:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622194948.NWKO19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 15:49:48 -0400
To: git@vger.kernel.org
X-maint-at: be0c7e069738fbb697b0719f2252107261c9340e
X-master-at: bf9e9542f94bc39e8bc653065d477bd25e79010e
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22363>

I've merged quite a bit of stuff and tagged the tip of "master"
as GIT 1.4.1-rc1.

As promised, 1.4.X series will be managed slightly differently,
and this is in preparation of the first installment of it.  The
releases will come from the "master" branch to contain both
fixes and enhancements from now on.  Hotfix releases when
necessary would have 1.4.X.Y revision numbers, but I am hoping
that we do not have to do that very often.

Since all the exciting and potentially risky developments are to
happen on the "next" branch and they are supposed to graduate to
"master" branch after they are reasonably well cooked, this
change will help the end-users to stay reasonably current
without hopefully not introducing unexpected problems.  The
older scheme left out all the enhancements if people followed
packaged versions, and gave big surprises when upgrading from
version X.Y.Z to X.(Y+1).0 which was not so nice.

Notable improvements since v1.4.0 are:

 - PPC SHA1 routine can grok more than half-gig of data (Paul
   Mackerras)

 - rev-list and object-layer in general is less (much less)
   space hungry (Linus).

 - the source is more friendly to stricter compilers such as
   Sun's (Florian Forster).

 - git rebase --merge (Eric Wong).  This uses the usual 3-way
   merge machinery while running rebase, and you can rebase
   across renames if you use the recursive strategy which is the
   default.

 - gitweb updates -- mostly cleanups (Jakub Narebski with help
   from Pasky and Timo Hirvonen).

 - diff --color (Johannes).

 - ~/.gitconfig and $ENV{GIT_CONFIG} (Pasky and Johannes).

 - core.sharedrepository can take umask, group or world (Linus
   and I)

 - "git checkout -f" removes files that becomes untracked from
   the working tree

 - "git clone/fetch" from a corrupt repository does not
   propagate brokenness to the downloaders.

 - "git clone/fetch" over the network gives better progress
   updates; this may also help TCP timeout problems for people
   behind NAT.

 - Many more commands are built-in (Lukas Sandstr=F6m)

 - git can now be used on Kiritimati (Paul Eggert)

----------------------------------------------------------------

* The 'master' branch has these since the last announcement.

   Andre Noll:
      object-refs: avoid division by zero

   David Woodhouse:
      Log peer address when git-daemon called from inetd

   Dennis Stosberg:
      Make t8001-annotate and t8002-blame more portable
      Fix t8001-annotate and t8002-blame for ActiveState Perl

   Eric W. Biederman:
      Fix git-format-patch -s
      Check and document the options to prevent mistakes.

   Eric Wong:
      git-svn: fix --rmdir when using SVN:: libraries
      rebase: Allow merge strategies to be used when rebasing
      rebase: error out for NO_PYTHON if they use recursive merge
      git-svn: fix commit --edit flag when using SVN:: libraries

   Florian Forster:
      Remove ranges from switch statements.
      Initialize FAMs using `FLEX_ARRAY'.
      Don't instantiate structures with FAMs.
      Cast pointers to `void *' when used in a format.
      Don't use empty structure initializers.
      Change types used in bitfields to be `int's.
      Remove all void-pointer arithmetic.

   Jakub Narebski:
      Move gitweb style to gitweb.css
      gitweb: safely output binary files for 'blob_plain' action
      gitweb: text files for 'blob_plain' action without charset by def=
ault
      Fix gitweb stylesheet
      Make CSS file gitweb/gitweb.css more readable
      gitweb: add type=3D"text/css" to stylesheet link
      Fix: Support for the standard mime.types map in gitweb
      gitweb: A couple of page title tweaking
      gitweb: style done with stylesheet
      gitweb: whitespace cleanup
      Add git version to gitweb output
      Move $gitbin earlier in gitweb.cgi
      gitweb: Make use of $PATH_INFO for project parameter
      gitweb: whitespace cleanup around '=3D'

   Johannes Schindelin:
      diff options: add --color
      Initialize lock_file struct to all zero.
      Fix setting config variables with an alternative GIT_CONFIG
      Read configuration also from $HOME/.gitconfig
      repo-config: Fix late-night bug
      git_config: access() returns 0 on success, not > 0

   Junio C Hamano:
      read-tree: --prefix=3D<path>/ option.
      write-tree: --prefix=3D<path>
      read-tree: reorganize bind_merge code.
      fetch-pack: give up after getting too many "ack continue"
      shared repository: optionally allow reading to "others".
      fix rfc2047 formatter.
      xdiff: minor changes to match libxdiff-0.21
      Restore SIGCHLD to SIG_DFL where we care about waitpid().
      checkout -f: do not leave untracked working tree files.
      upload-pack: avoid sending an incomplete pack upon failure
      upload-pack: prepare for sideband message support.
      Retire git-clone-pack
      upload-pack/fetch-pack: support side-band communication
      Add renaming-rebase test.
      daemon: send stderr to /dev/null instead of closing.
      rebase --merge: fix for rebasing more than 7 commits.
      Makefile: do not force unneeded recompilation upon GIT_VERSION ch=
anges

   Linus Torvalds:
      Shrink "struct object" a bit
      Move "void *util" from "struct object" into "struct commit"
      Some more memory leak avoidance
      Remove "refs" field from "struct object"
      Add specialized object allocator
      Add "named object array" concept
      Fix grow_refs_hash()

   Lukas Sandstr=F6m:
      Make git-write-tree a builtin
      Make git-mailsplit a builtin
      Make git-mailinfo a builtin
      Make git-stripspace a builtin
      Make git-update-index a builtin
      Make git-update-ref a builtin

   Paul Eggert:
      date.c: improve guess between timezone offset and year.

   Paul Mackerras:
      Fix PPC SHA1 routine for large input buffers

   Petr Baudis:
      Support for extracting configuration from different files
      Support for the standard mime.types map in gitweb

   Rene Scharfe:
      git-tar-tree: Simplify write_trailer()
      git-tar-tree: documentation update
      git-tar-tree: no more void pointer arithmetic
      Make release tarballs friendlier to older tar versions

   Timo Hirvonen:
      gitweb: Use $hash_base as $search_hash if possible

   Uwe Zeisberger:
      Fix possible out-of-bounds array access

   Yakov Lerner:
      auto-detect changed prefix and/or changed build flags
      Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used.


* The 'pu' branch, in addition, has these.

   Johannes Schindelin:
      Teach diff about -b and -w flags

   Lukas Sandstr=F6m:
      Make it possible to call cmd_apply multiple times
      Make git-am a builtin
