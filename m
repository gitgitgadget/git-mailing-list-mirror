From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Support projects including other projects
Date: Wed, 11 May 2005 23:14:03 -0700
Message-ID: <7vvf5pj7is.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505120057250.30848-100000@iabervon.org>
	<7v8y2lknsp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 08:06:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW6qC-0001Fr-Py
	for gcvg-git@gmane.org; Thu, 12 May 2005 08:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVELGOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 02:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVELGOK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 02:14:10 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20198 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261184AbVELGOF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 02:14:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512061404.YERX26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 02:14:04 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7v8y2lknsp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 11 May 2005 22:37:10 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

Daniel, I am sorry but I realize I completely misunderstood what
you meant by "projects including other projects".  What you are
trying to solve is the problem of feeding core GIT changes and
pure Cogito changes separately to the upstream _within_ _the_
_current_ _source_ _tree_ _structure_ of Cogito, isn't it?
That's where your juggling index files and other complexity
comes from, and I did not realize that was what you were talking
about.  I should have realized it when you mentioned kbuild.

Well, personally I do not think such project _overlays_ are
worth supporting because it happens rarely, and to a certain
extent it is simply an undisciplined way to organize the source
tree.  Kbuild case may be justified, but I vaguely recall
something very similar build infrastructure was used by busybox
folks---it could be using just their own copy of kbuild for that
matter.

But as you said in a separate message, I agree that core GIT
layer is meant to be independent from what Porcelain you put on
it.  The relationship between Cogito and core GIT is not similar
to kbuild and the kernel.  It is more like a random X11
application and Xlib.  Having them in the same source tree,
intermixed, is less than optimal.

I would not be surprised when future, if not the next, Cogito
release has source tree organized more like JIT sources,
shipping git-pb and cogito in separate directories, managed by
separate GIT_DIR.  That would make Pasky's life a lot simpler.

And once the separation happens, the issue becomes just a simple
package version matching every distribution does (e.g. Debian's
binary package and library dependencies, or source Build-Depends
dependencies), which is something already has been solved.

