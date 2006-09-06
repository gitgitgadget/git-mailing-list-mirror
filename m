From: Junio C Hamano <junkio@cox.net>
Subject: Re: file rename causes history to disappear
Date: Wed, 06 Sep 2006 12:29:49 -0700
Message-ID: <7vmz9c7pzm.fsf@assigned-by-dhcp.cox.net>
References: <44FEE0BB.2060601@garzik.org>
	<Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
	<44FEED4B.30909@garzik.org>
	<Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
	<Pine.LNX.4.64.0609060922110.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 21:30:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL35t-0003wq-1A
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 21:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWIFT3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 15:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWIFT3n
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 15:29:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:52399 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932083AbWIFT3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 15:29:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906192941.CHRC21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 15:29:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K7Vi1V00E1kojtg0000000
	Wed, 06 Sep 2006 15:29:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609060922110.27779@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 6 Sep 2006 09:37:56 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26554>

Linus Torvalds <torvalds@osdl.org> writes:

> Side note: one thing that I wanted to do, but never got around to, is to 
> allow wildcards in the tree-parsing code. It might be too expensive, but 
> it's still occasionally something I'd like to do:
>
> 	git log -- 'mm/*.c'
>
> to track every single C file in the VM (even if they don't exist right 
> _now_).

I am happy to see we are in agreement.  I touched this in the
ending note to

	http://article.gmane.org/gmane.comp.version-control.git/26432

The only people who will get burnt by this change are the ones
with metacharacters in their pathnames, so it is relative safe
change.

I think 'git grep' pathspec code is probably the best to reuse
to convert diff-tree family.  It knows how to match globs while
traversing a tree down without descending into a subtree that
would never match, which is what we need for them.
