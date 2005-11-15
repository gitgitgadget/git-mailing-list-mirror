From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 0.99.9i aka 1.0rc2
Date: Mon, 14 Nov 2005 20:17:02 -0800
Message-ID: <7vr79isfy9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 05:17:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbsFu-0001pJ-F7
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 05:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVKOERF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 14 Nov 2005 23:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVKOERF
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 23:17:05 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29866 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932362AbVKOERE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 23:17:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115041633.CEHS20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 23:16:33 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11875>

GIT 0.99.9i aka 1.0rc2 is found at usual places.

I think the source-tree-wise almost everything is done except:

 - http-fetch file descriptor leak fix; I tried Nick's
   clean-ups, but haven't tried Pasky's patch yet.  Walt reports
   neither patch fixed the problem.  I wasted the weekend not
   being able to reproduce this myself, until Pasky reminded me
   that I have an old special code in git-clone, which was
   unrelated to this problem, but nevertheless was masking it.

 - Preparation for later dash-less "git frotz" installation
   scheme.  As I said earlier, I intend to do 1.0 with a
   Makefile that installs everything in one directory (either
   $HOME/bin or /usr/bin) by default, but at least we should
   encourage our users to get used to spelling the subcommands
   in dash-less form.  Andreas Ericsson's git wrapper
   implementation was reviewed favourably on the list, and I'd
   like to go with it.

 - archimport update by Eric Wong has not been reviewed yet;
   this is difficult for me since I do not use tla anymore, and
   I am asking help from Martin Langhoff.  I am hoping Eric and
   Martin would come up with an updated patch that satisfies the
   needs of both, at that time the update will happen.
   Personally I do not think 1.0 has to wait for this.

There is a bit of restructuring in the binary packaging for RPM
(and probably Debian side needs matching change as well) before
1.0 can happen.

Anyway, here is the short-log between 0.99.9g and 0.99.9i.
Please give it a good beating.

-- >8 -- cut here -- >8 --

Alex Riesen:
      allow git-update-ref create refs with slashes in names

Andreas Ericsson:
      git-clone: Keep remote names when cloning unless explicitly told =
not to.
      git-clone: Allow cloning into directories other than child of cur=
rent dir.
      git-branch: Mention -d and -D in man-page.

Chris Wright:
      specfile cleanups

=46redrik Kuivinen:
      merge-recursive: Indent the output properly
      merge-recursive: Add copyright notice
      merge-recursive: Use '~' instead of '_' to separate file names fr=
om branch names

Jim Radford:
      Add missing git-core and cvsps RPM dependencies.

Josef Weidendorfer:
      Let git-clone/git-fetch follow HTTP redirections
      Bugfix: stop if directory already exists
      Remove git-rename. git-mv does the same

Junio C Hamano:
      Documentation: "host:path/to/repo" is git native over ssh.
      Do not lose author name information to locale gotchas.
      Add --pretty=3Dfuller
      octopus: do not do AND'ed merge base.
      RPM: arch submodule needs tla.
      merge-base: fully contaminate the well.
      merge-base: avoid unnecessary postprocessing.
      Add test case for merge-base.
      git-show-branch: tighten merge-base computation.
      Fully detect uninteresting commits.
      t1200: use --topo-order to keep the show-branch output stable.
      INSTALL: duplicate python requirements from Makefile
      merge with /dev/null as base, instead of punting O=3D=3Dempty cas=
e
      merge-one-file: use common as base, instead of emptiness.
      Documentation: git-apply --no-add
      merge-one-file: use empty- or common-base condintionally in two-s=
tage merge.
      git-prune: prune redundant packs
      git-lost+found
      Rename .git/lost+found to .git/lost-found.
      Documentation: asciidoc sources are utf-8
      Ignore built git-lost+found.
      Debian: build-depend on libexpat-dev.
      Rename lost+found to lost-found.
      Separate LDFLAGS and CFLAGS.
      apply: fix binary patch detection.
      Update topo-order test.

Kai Ruemmler:
      Fix compilation warnings in pack-redundant.c

Linus Torvalds:
      Fix git-rev-list "date order" with --topo-order

Lukas_Sandstr=F6m:
      Change 'cache' to 'index' in the docs
      Add git-pack-intersect
      Add documentation for git-pack-intersect
      Add git-pack-intersect to .gitignore
      Make git-repack use git-pack-intersect.
      Rename git-pack-intersect to git-pack-redundant
      Make git-pack-redundant consider alt-odbs

Martin Langhoff:
      archimport: handle pika escaping

Matthias Urlichs:
      debian packaging: git-cvs needs cvsps
      Remove trailing slashes
      Depend on asciidoc 7 (at least).

Nick Hengeveld:
      Fix for multiple alternates requests in http-fetch
      Fix fd leak in http-fetch

Nikolai Weibull:
      Document the -n command-line option to git-unpack-objects
      Document a couple of missing command-line options.
      Documentation nitpicking

Pavel Roskin:
      Add --no-commit-id option for git-diff-tree, use it in gitk
      git-clone: quote destination directory name

Petr Baudis:
      Fix confusing git-update-ref error message
      Show URL in the "Getting <foo> list" http-fetch messages

Thomas Matysik:
      Add expat and expat-devel dependencies (for http-push) to RPM spe=
c.
      Split gitk into seperate RPM package
