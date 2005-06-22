From: Junio C Hamano <junkio@cox.net>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 02:08:54 -0700
Message-ID: <7vmzpihi6x.fsf@assigned-by-dhcp.cox.net>
References: <1119284365.3926.15.camel@localhost.localdomain>
	<7vbr61j631.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 11:57:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dl1yC-0001hc-Mt
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 11:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVFVJVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 05:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVFVJST
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 05:18:19 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34763 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262874AbVFVJJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 05:09:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050622090854.FGYO12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Jun 2005 05:08:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 21 Jun 2005 15:09:13 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> and here the "git-cherry-pick" thing is just a script that basically takes
LT> an old commit ID, and tries to re-apply it as a patch (with author data
LT> and commit messages, of course) on top of the current head. It would 
LT> basically be nothing more than a "git-diff-tree $1" followed by tryign to 
LT> figure out whether it had already been applied or whether it can be 
LT> applied now.

LT> What do you think?

What you outlined is essentially what I already do by using
jit-rewind, followed by a repeated use of (jit-patch and
jit-commit with -m flag).  The reason I have not automated the
"repeat" part is _not_ because I am lazy, but because typically
the rejected things really need manual intervention, not for
mechanical (read: merge conflict) reasons, but for semantic
reasons, when some patches are accepted while some others are
not.  Especially if I am not the sole supplier of patches to
your tree, my older patches usually need not just rebasing but
_rethinking_, so I myself do not find need for automating things
further that much from what I already have.

Having said that, one automation I would benefit from is to
automatically find patches that _have_ been accepted and drop
them from my snapshot pool --- that part should be very easy to
automate and I have not done so primarily because I _am_ lazy.
I could call it git-cherry-drop ;-).


