From: Junio C Hamano <junkio@cox.net>
Subject: Recent unresolved issues
Date: Fri, 14 Apr 2006 02:31:36 -0700
Message-ID: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 14 11:31:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUKeU-000052-C2
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 11:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWDNJbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 05:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWDNJbj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 05:31:39 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52689 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965118AbWDNJbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 05:31:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414093137.VHBT8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 05:31:37 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18687>

Here is a list of topics in the recent git traffic that I feel
inadequately addressed.  I've commented on some of them to give
people a feel for what my priorities are.  Somebody might want
to rehash the ones low on my priority list to conclusion with a
concrete proposal if they cared about them enough.  The list is
*not* ordered in any way.

Also please add whatever I missed (or dismissed).  I am hoping
this will be a good basis for 1.4 to-do list.

* Message-ID: <Pine.LNX.4.64.0604121828370.14565@g5.osdl.org>
  Common option parsing (Linus Torvalds)

* Message-ID: <Pine.LNX.4.64.0604050855080.2550@localhost.localdomain>
  Binary diff output? (Nicolas Pitre)

  I do not think this is needed for our primary audience (the
  kernel project), but I am sure it would be helpful for some
  other projects if we allowed them to exchange patches that
  describe binary file changes via e-mail, so I am not
  dismissing this.  Needs to wait "option parsing".

* Message-ID: <Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
  Colored diff? (Linus Torvalds)

  I am not opposed to it, but I'd like to do that internally if
  we go this route.  Needs to wait "option parsing".  Also
  Message-ID: <3536.10.10.10.24.1114117965.squirrel@linux1> is
  slightly related to this.

* Message-ID: <7vek02ynif.fsf@assigned-by-dhcp.cox.net>
  diff --with-raw, --with-stat? (me)

  I think "git diff" can be internalized next, after "option
  parsing" unification.  When that is done, --with-stat would
  help internalize format-patch's process_one(), and it would be
  trivial to do "git log --pretty=format-patch master..next".

* #irc 2006-04-10
  Shallow clones (Carl Worth).

  The experiment last round did not work out very well, but as
  existing repositories get bigger, and more projects being
  migrated from foreign SCM systems, this would become a
  must-have from would-be-nice-to-have.

  I am beginning to think using "graft" to cauterize history
  for this, while it technically would work, would not be so
  helpful to users, so the design needs to be worked out again.

* Message-ID: <E1FMH3o-0001B5-Dw@jdl.com>
  git status does not distinguish contents changes and mode
  changes; it just says "modified" (Jon Loeliger).

  Unconditionally changing the status letter would break
  Porcelains so we would need an extra option to do this.
  An outline patch has been already prepared -- this perhaps has
  to wait until we sort out the "option parsing" one.

* Message-ID: <tnxmzf9sh7k.fsf@arm.com>
  git could use diff3 instead of merge which is a wrapper around
  diff3. (Catalin Marinas)

  If having "diff3" is a lot more common than having "merge", I
  do not have problem with this; "merge" being a wrapper to
  "diff3", people who have been happy with the current code
  would certainly have "diff3" installed so changing to "diff3"
  would not break them.

* Message-ID: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com>
  Windows problems summary (Alex Riesen)

  A good list to keep in mind.

* Message-ID: <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
  Huge packfiles (Linus Torvalds)

  Because I do not think asking users to break up packs to
  manageable and mmap()able size is too much to ask, I would not
  be advocating for updating the pack idx to 64-bit offset and
  mmap()ing parts of a packfile, at least too strongly.

  However, we currently lack tool support or recepe for users
  with such a repository to easily break up packs.

* Message-ID: <1143856098.3555.48.camel@dv>
  Per branch property, esp. where to merge from (Pavel Roskin)

  This involves user-level "world model" design, which is more
  Porcelainish than Plumbing, and as people know I do not do
  Porcelain well; interested parties need to come up with what
  they want and how they want to use it.
