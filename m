From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'upstream' branches.
Date: Sat, 05 May 2007 23:36:48 -0700
Message-ID: <7v3b2ah30f.fsf@assigned-by-dhcp.cox.net>
References: <1178368166.11851.60.camel@pmac.infradead.org>
	<20070505174416.GA2898@steel.home>
	<1178387429.17680.35.camel@shinybook.infradead.org>
	<20070505225249.GE2898@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 08:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkaMb-0003iQ-D0
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbXEFGgu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 02:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbXEFGgu
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:36:50 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57177 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696AbXEFGgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 02:36:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506063649.YODE24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 02:36:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vico1W0051kojtg0000000; Sun, 06 May 2007 02:36:48 -0400
In-Reply-To: <20070505225249.GE2898@steel.home> (Alex Riesen's message of
	"Sun, 6 May 2007 00:52:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46302>

Alex Riesen <raa.lkml@gmail.com> writes:

> David Woodhouse, Sat, May 05, 2007 19:50:28 +0200:
>> > > 
>> > > Is there a better way?
>> > 
>> > I would just remove the pluses. git-fetch will say that the branch is
>> > already up-to-date, if the local branch already has everything the
>> > remote has.
>> 
>> Then after I pull from Linus' tree, I can't pull from the mtd tree -- it
>> complains that the 'linus' branch there can't be fast-forwarded, and
>> refuses to pull the 'master' branch.
>
> Which got me by surprise (just tried). I though it'd notice that all
> the commits are already present...
>
> Experts, is it really supposed to be that way?

I am not sure what the issue is here.  If the copy of Linus's
tip mtd tree has is behind the current Linus's tip, after you
fetch from Linus's tree to obtain its tip, if you allowed the
fetch from mtd tree to update the remote tracking ref that you
use to keep track of where Linus is, it would _rewind_ it, so I
think it is natural to warn/prevent that mistake.

I think David's use of linus ref is bogus.  What is he really
trying to "track"?  If he is trying to track where the tip of
Linus's tree is, he should not let fetch from mtd to muck with
that remote tracking ref that he uses to track Linus's tree.

On the other hand, I think it is perfectly reasonable thing to
want to track where the tip of Linus's tree is "from mtd tree's
point of view".  Then diff between "mtd's idea of Linus's tip"
and "mtd's tip" would represent what mtd people did, regardless
of what Linus did in his tree, before mtd people had a chance to
sync again with Linus.
