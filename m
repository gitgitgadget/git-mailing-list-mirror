From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Thu, 05 Oct 2006 17:59:52 -0700
Message-ID: <7v8xju45tj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Oct 06 03:07:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVe4C-0007HU-If
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 02:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWJFA7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Oct 2006 20:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWJFA7x
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 20:59:53 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52914 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932542AbWJFA7x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 20:59:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061006005952.BROC2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 20:59:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wozv1V0081kojtg0000000
	Thu, 05 Oct 2006 20:59:55 -0400
To: git@vger.kernel.org
X-maint-at: 6fe5b7ff6cafcc94415deba2f3d611770d8e6b1e
X-master-at: abd6970acad5d758f48c13f7420367ae8216038e
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28382>

* The 'maint' branch has produced the third maintenance release
  1.4.2.3 a few days ago.

* The 'master' branch is at 1.4.3-rc1; we are in stabilization
  cycle.  I do not think I have made any formal announcement on
  the merge policy during -rc; I am planning to play by the
  following rules:

  * no new features nor interface change should hit "master"
    after -rc1, but I am a human and smaller things could seep
    through ;-).

  * fixes for "master" are encouraged and very much appreciated;

  * fixes for "next" are also encouraged and appreciated, but
    perfecting a topic that was still in "next" after -rc1 will
    not make the topic for a candidate in the upcoming "master"
    release.  It will make the topic merged as part of the first
    wave of merges after the release.

  * For totally new topics, I reserve the right to drop them on
    the floor during the stabilization period, but they might
    get lucky and land on "next" or "pu" depending on my mood.
    Please re-send them after the next release if you care
    deeply enough.

  contrib/ is exempt from the above rules for obvious reasons.

Here are what was added since 1.4.3-rc1 and will be in 1.4.3.
By the above definition, they should mostly be fixes:

Alan Chandler:
      Update the gitweb/README file to include setting the GITWEB_CONFI=
G environment
      git.c: Fix usage string to match that given in the man page

Alexandre Julliard:
      git.el: Fixed inverted "renamed from/to" message.
      vc-git.el: Switch to using git-blame instead of git-annotate.

Dennis Stosberg:
      lock_ref_sha1_basic does not remove empty directories on BSD

=46ranck Bui-Huu:
      Add git-upload-archive to the main git man page

Junio C Hamano:
      Makefile: install and clean merge-recur, still.
      git-mv: invalidate the removed path properly in cache-tree
      git-push: .git/remotes/ file does not require SP after colon
      escape tilde in Documentation/git-rev-parse.txt
      tar-tree deprecation: we eat our own dog food.
      gitweb: Make the Git logo link target to point to the homepage
      git-send-email: avoid uninitialized variable warning.
      cherry-pick: make -r the default

Luben Tuikov:
      gitweb: Escape ESCAPE (\e) character
      gitweb: Do not print "log" and "shortlog" redundantly in commit v=
iew
      gitweb: blame: Minimize vertical table row padding

Martin Waitz:
      gitweb: document webserver configuration for common gitweb/repo U=
RLs.
      git-commit: cleanup unused function.

Robin Rosenberg:
      Error in test description of t1200-tutorial


* The 'next' branch, in addition, has these.  They will not be
  in 1.4.3 (except one):

  - git-pack-refs, git-for-each-ref, git-show-ref by Linus and
    me, with help in updating the documentation, test scripts,
    and updates to the tools to use them from Andy Whitcroft,
    Christian Couder, Dennis Stosberg, Jeff King, Johannes,
    Jonas, Pasky,

    I think this is in testable shape and I started to use
    packed refs in one of my test repositories to see what are
    still broken.  Hopefully be in "master" soon after 1.4.3.

  - git-receive-pack uses the common ref-locking code, and as a
    side effect git-push will add ref-log entries on the remote
    end if enabled.

    This depends on the first item and should be considered a
    part of it.

  - git log --summary without any other options now look into
    subdirectories, thanks to Johannes.

    This is a small backward-incompatible change, but I think it
    falls into "fix a broken behaviour" category (same as making
    "cherry-pick -r" the default).  If nobody objects I'll merge
    it to "master" before 1.4.3-rc2.

  - "git log --all-match --author=3DFoo --committer=3DBar".

  - "git apply" is prepared for planned output format change for
    "git diff" when a file with SP in its name is involved.  We
    will add a trailing TAB on "+++/---" lines.

    Merge to "master" immediately after 1.4.3

  - Santi B=E9jar tidied up output from fetch and merge.

    Merge to "master" immediately after 1.4.3

  - Robert Shearman taught git-rebase (sans --merge) to use
    --ignore-if-in-upstream to reduce obvious conflicts, and
    taught it to show upstream changes with -v option.

    Merge to "master" immediately after 1.4.3

  - Assorted gitweb updates by Alan Chandler, me, Luben Tuikov,
    Martin Waitz

    Notable enhancements are:

    - blame page output got a facelift.
    - the URL gitweb generates can use PATH_INFO.

    Merge to "master" sometime after 1.4.3

  - Nico's pack format optimization.

    I've been using this for my pulls and haven't seen a
    problem.  I'll enable it for repository packing in one of my
    test repository soon to see if I get burned ;-) but I do not
    expect breakage from Nico's code.  Soon after dust settles
    from other ones graduating to "master" post 1.4.3.

  - "git blame --show-name" tells it to always output filename.

    After dust settles from other ones graduating to "master"
    post 1.4.3.

* The 'pu' branch, in addition, has these.

  - "git diff"'s output format change for a file with SP in its
    name, as described above.  This will be merged after the
    matching change to "git apply" graduates to "master" and
    matures.

  - "git blame --porcelain" gives richer information on revs
    that are involved for scripted use.

  - "gitweb" is updated to use the above "git blame --porcelain"

  - My WIP of parallel tree walker hasn't made any progress.
=20
