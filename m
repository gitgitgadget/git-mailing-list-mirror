From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --stat: ensure at least one '-' for deletions, and one '+' for additions
Date: Thu, 28 Sep 2006 19:28:58 -0700
Message-ID: <7vd59fquc5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609281735040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wpvvrww.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609281942360.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 04:29:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT87h-0006aF-00
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 04:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWI2C3F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 22:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWI2C3E
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 22:29:04 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:35274 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030344AbWI2C27 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 22:28:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929022859.RYHB12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 22:28:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id U2V11V00W1kojtg0000000
	Thu, 28 Sep 2006 22:29:01 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28083>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, I would argue it's actually an improvement. If you have as many 
> additions as deletions, there should be an equal number of '-' and '+'.

That's one way to look at it.

Now how would you explain that a file that had 5 adds and 5
deletes gets three pluses and three minuses while another file
that had 10 adds and no delets gets seven pluses?

Compute total and add, make del=total-add:

	foo |   10 ++++---
        bar |   10 +++++++

Compute add and del independently:

	foo |   10 +++---
        bar |   10 +++++++

> After all, the integer number of symbols is just an approximation anyway.

Yes, and my guess is that the graph is usually much wider than 7
columns as depicted above, so 3 vs 4 inconsistency in the former
is less noticeable than 6 vs 7 inconsistency in the latter to
the eye.  If we have to make a compromise, I think getting the
lines for the files that have the same number of changes to line
up at the right end would be more important.

Another way is what I suggested earlier -- if the width is odd,
drop one to avoid this problem altogether.  That would also be
acceptable and probably be more consistent.
