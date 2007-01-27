From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sat, 27 Jan 2007 00:05:56 -0800
Message-ID: <7vps90nbbv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 09:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAiZX-0005ov-0A
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 09:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbXA0IF7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 27 Jan 2007 03:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbXA0IF7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 03:05:59 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:55738 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbXA0IF6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jan 2007 03:05:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127080557.LHSQ20530.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 03:05:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G84z1W00M1kojtg0000000; Sat, 27 Jan 2007 03:05:00 -0500
X-maint-at: 6534141151f7fd4334f62827d9234acf3974ca4d
X-master-at: f127404c45eff139037834a6464b68fbe1798e16
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37930>

I am hoping that we can declare -rc3 and go into a deep freeze
after merging Shawn's "describe with accumulated commits since"
and Nico's "reflog on HEAD", perhaps by end of the month.

I haven't looked at the finishing touches from Shawn I received
tonight yet (it is parked in 'pu').  Nico's "reflog on HEAD"
looked good (also parked in 'pu'), but I think it needs to teach
the repack/prune/fsck/reflog-expire machinery about reflog
entries for HEAD -- otherwise a prune can make reflog useless
while your HEAD is detached (which may not be a big deal and
while I do not deeply care personally, it would be better to
consistently protect them like reflog entries for regular refs).

Although it is tempting to start futzing with prune and ancestry
traversal so that commits hidden by grafts are not lost by it,
which was brought up today, I think it should be better dealt
with after 1.5.0 (it is not a recent regression).

I'd like to take a look at JBF's manual and merge it early -- I
fed some small changes to him some time ago but did not have
chance to review its recent progress.  It deserves attention
from wider audience.

* The 'master' branch has these since v1.5.0-rc2.

  Alex Riesen (4):
    Insert ACTIVESTATE_STRING in Git.pm
    Force Activestate Perl to tie git command pipe handle to a handle c=
lass
    Cleanup uninitialized value in chomp
    Allow default core.logallrefupdates to be overridden with template'=
s
       config

  Alexandre Julliard (1):
    vc-git.el: Take into account the destination name in vc-checkout.

  Andy Parkins (2):
    New files in git weren't being downloaded during CVS update
    If abbrev is set to zero in git-describe, don't add the unique suff=
ix

  Eric Wong (1):
    git-svn: remove leading slash when printing removed directories

  Jakub Narebski (3):
    Documentation/config.txt: Document config file syntax better
    t/t1300-repo-config.sh: value continued on next line
    Documentation/config.txt: Correct info about subsection name

  Jason Riedy (1):
    Use inttypes.h rather than stdint.h.

  Jeff King (3):
    format-patch: fix bug with --stdout in a subdirectory
    contrib/vim: update syntax for changed commit template
    diffcore-pickaxe: fix infinite loop on zero-length needle

  Johannes Schindelin (2):
    annotate: use pager
    reflog inspection: introduce shortcut "-g"

  Junio C Hamano (25):
    Documentation/tutorial-2: Fix interesting typo in an example.
    Revert "prune: --grace=3Dtime"
    Make sure git_connect() always give two file descriptors.
    is_repository_shallow(): prototype fix.
    shallow repository: disable unsupported operations for now.
    git-gc: do not run git-prune by default.
    cvsimport: activate -a option, really.
    .mailmap: fix screw-ups in Uwe's name
    honor --author even with --amend, -C, and -c.
    reflog gc: a tag that does not point at a commit is not a crime.
    git-checkout -m: fix merge case
    git-daemon documentation on enabling services.
    ls-remote and clone: accept --upload-pack=3D<path> as well.
    Refactor the pack header reading function out of receive-pack.c
    Allow fetch-pack to decide keeping the fetched pack without explodi=
ng
    fetch-pack: remove --keep-auto and make it the default.
    Consolidate {receive,fetch}.unpackLimit
    Allow non-developer to clone, checkout and fetch more easily.
    parse-remote: do not barf on a remote shorthand without any refs to=
 fetch.
    show-branch -g: default to HEAD
    Documentation: pack-refs --all vs default behaviour
    Make sure we do not write bogus reflog entries.
    git-merge: leave sensible reflog message when used as the first lev=
el UI.
    create_symref: check error return from open().
    write_in_full: size_t is unsigned.

  Linus Torvalds (3):
    fsck-objects: refactor checking for connectivity
    Fix seriously broken "git pack-refs"
    Add dangling objects tips.

  Nicolas Pitre (1):
    fix suggested branch creation command when detaching head

  Peter Eriksen (2):
    sha1_file.c: Avoid multiple calls to find_pack_entry().
    Documentation: --amend cannot be combined with -c/-C/-F.

  Sam Vilain (1):
    contrib/emacs/vc-git.el: support vc-version-other-window

  Shawn O. Pearce (1):
    Remove unnecessary found variable from describe.

  Uwe Kleine-K=F6nig (2):
    rename --exec to --upload-pack for fetch-pack and peek-remote
    make --upload-pack option to git-fetch configurable
