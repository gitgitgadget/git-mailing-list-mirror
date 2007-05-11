From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel cherry UN-picking?
Date: Fri, 11 May 2007 15:11:35 -0700
Message-ID: <7v7irf9fjc.fsf@assigned-by-dhcp.cox.net>
References: <4644E0A2.90008@garzik.org>
	<7vhcqj9g8r.fsf@assigned-by-dhcp.cox.net>
	<7vbqgr9fn9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Sat May 12 00:11:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmdL3-0007pt-Q9
	for gcvg-git@gmane.org; Sat, 12 May 2007 00:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759841AbXEKWLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 18:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759952AbXEKWLh
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 18:11:37 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49754 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759841AbXEKWLg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 18:11:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511221136.EYBG24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 18:11:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xyBb1W00B1kojtg0000000; Fri, 11 May 2007 18:11:35 -0400
In-Reply-To: <7vbqgr9fn9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 11 May 2007 15:09:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46992>

Junio C Hamano <junkio@cox.net> writes:

> Suppose you have something like this (you may have more than one
> such merge but the principle is the same):
>
>   U---o---o---o---M---x---o---o---o---T
>                  /
>    Linville o---o
>
> Up to 'U' you have already sent upstream and no need for
> resending.  'M' is merge with Linville tree.  'x' is the bad
> one, and 'o' are good ones.  'T' is the tip of your net driver
> branch.
>
> First find out 'x'.  Then
>
>         git format-patch -o ./outdir x..T
>
> would format everything starting from (but excluding) 'x' up to
> 'T'.
>
> Then
>
>         git reset --hard x^
>         git am ./outdir/*.patch
>
> would rebuild:
>
>   U---o---o---o---M---x---o'--o'--o'--T'
>                  /
>    Linville o---o

Correction.  This would rebuild:

    U---o---o---o---M-------o'--o'--o'--T'
                   /
     Linville o---o

as if 'x' did not happen.
