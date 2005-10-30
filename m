From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.9
Date: Sat, 29 Oct 2005 18:29:12 -0700
Message-ID: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 02:30:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EW20i-0005zj-Uy
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 02:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbVJ3B3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 21:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbVJ3B3O
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 21:29:14 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41858 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932770AbVJ3B3N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 21:29:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030012823.HEES24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Oct 2005 21:28:23 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10811>

GIT 0.99.9 is found at usual places.

As I said in the 0.99.8 announcement, git already does
everything I want it to do, and from here on I'd like to see us
concentrate on fixes (both correctness and performance) until we
hit 1.0 which should happen shortly.

Many thanks to everybody who contributed the comments, extra set
of eyeballs, and code.


Done in 0.99.9
==============

Ports
~~~~~

* Cygwin port [HPA].

* OpenBSD build [Merlyn and others].


Fixes
~~~~~

* clone request over git native protocol from a repository with
  too many refs did not work; this has been fixed.

* git-daemon got safer for kernel.org use [HPA].

* Extended SHA1 parser was not enforcing uniqueness for
  abbreviated SHA1; this has been fixed.

* http transport does not barf on funny characters in URL.

* The ref naming restrictions have been formalized and the
  coreish refuses to create funny refs; we still need to audit
  importers.  See git-check-ref-format(1).


New Features and Commands
~~~~~~~~~~~~~~~~~~~~~~~~~

* .git/config file as a per-repository configuration mechanism,
  and some commands understand it [Linus].  See
  git(7).

* The core.filemode configuration item can be used to make us a
  bit more FAT friendly.  See git(7).

* The extended SHA1 notation acquired Peel-the-onion operator
  ^{type} and ^{}.  See git-rev-parse(1).

* SVN importer [Matthias].  See git-svnimport(1).

* .git/objects/[0-9a-f]{2} directories are created on demand,
  and removed when becomes empty after prune-packed [Linus].

* Filenames output from various commands without -z option are
  quoted when they embed funny characters (TAB and LF) using
  C-style quoting within double-quotes, to match the proposed
  GNU diff/patch notation [me, but many people contributed in
  the discussion].

* git-mv is expected to be a better replacement for git-rename.
  While the latter has two parameter restriction, it acts more
  like the regular 'mv' that can move multiple things to one
  destinatino directory [Josef Weidendorfer].

* git-checkout can take filenames to revert the changes to
  them.  See git-checkout(1)

* The new program git-am is a replacement for git-applymbox that
  has saner command line options and a bit easier to use when a
  patch does not apply cleanly.

* git-ls-remote can show unwrapped onions using ^{} notation, to
  help Cogito to track tags.

* git-merge-recursive backend can merge unrelated projects.

* git-clone over native transport leaves the result packed.

* git-http-fetch issues multiple requests in parallel when
  underlying cURL library supports it [Nick and Daniel].

* git-fetch-pack and git-upload-pack try harder to figure out
  better common commits [Johannes].

* git-read-tree -u removes a directory when it makes it empty.

* git-diff-* records abbreviated SHA1 names of original and
  resulting blob; this sometimes helps to apply otherwise an
  unapplicable patch by falling back to 3-way merge.

* git-format-patch now takes series of from..to rev ranges and
  with '-m --stdout', writes them out to the standard output.
  This can be piped to 'git-am' to implement cheaper
  cherry-picking.

* git-tag takes '-u' to specify the tag signer identity [Linus].

* git-rev-list can take optional pathspecs to skip commits that
  do not touch them (--dense) [Linus].

* Comes with new and improved gitk [Paulus and Linus].
