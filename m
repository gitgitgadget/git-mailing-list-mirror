From: Junio C Hamano <junkio@cox.net>
Subject: Re: The coolest merge EVER!
Date: Thu, 23 Jun 2005 17:44:29 -0700
Message-ID: <7v64w4d1n6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 02:41:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlcFi-0006j3-KE
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 02:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVFXArI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 20:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbVFXArI
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 20:47:08 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:7643 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262956AbVFXAob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 20:44:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050624004429.UKM550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Jun 2005 20:44:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 22 Jun 2005 14:46:51 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Now, the advantage of this kind of merge is that Paul's original gitk
LT> repository is totally unaffected by it, yet because I now have his history
LT> (and the exact same objects), the normal kind of git merge should work
LT> fine for me to continue to import Paul's work - we have the common parent
LT> needed to resolve all differences.

This clearly shows that you are in the "project lead" integrator
mindset.  Making it easy for you, the integrator, to pull
changes made in Paul's tree is what this "coolest merge ever" is
all about, but I suspect there would be a massive additional
support needed if you want to make it easy for Paul to pull
changes made to gitk in your tree.

I am not saying I do not like it, however, to make it easy for
Paul to pull changes made in your tree relevant only to gitk
part, off the top of my head:

 - If a contributor to GIT wants to make a change to gitk that
   adds a new file that is used by gitk (say, some common tcl
   library thing to be included), we either need to feed them to
   Paul and get the changes propagate to you through him, or we
   need a way to mark that file somehow belonging to the
   development history rooted at gitk root, not GIT root.

 - Similarly, if a contributor to GIT wants to make a change to
   gitk file itself, feeding the change through Paul to you
   would lesson both your burden and Paul's.

 - Alternatively Paul can keep track of which files are relevant
   to gitk, slurp and merge commits while ignoring the files the
   gitk package does not care about.  This one would involve
   interesting scripting somebody may want to tackle (hint,
   hint).

Long time ago I had a discussion with somebody (I vaguely recall
it was with Dan Barkalow but I am not sure) about this exact
issue.  He wanted to have a way to distinguish Cogito-only part
and core GIT part in a Cogito source tree, and help developers
feed core changes to you and Cogito changes to Petr.

Back then I dismissed that approach by saying that what is
broken was Cogito's source tree structure, which overlays two
projects that are theoretically separable and practically
managed separately, and it is not worth supporting such a broken
source tree structure.  Now you are making GIT source tree such
an overlayed one.

