From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel cherry UN-picking?
Date: Fri, 11 May 2007 14:56:20 -0700
Message-ID: <7vhcqj9g8r.fsf@assigned-by-dhcp.cox.net>
References: <4644E0A2.90008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri May 11 23:56:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmd6B-00050Q-65
	for gcvg-git@gmane.org; Fri, 11 May 2007 23:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbXEKV4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 17:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbXEKV4W
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 17:56:22 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48070 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955AbXEKV4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 17:56:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511215620.IHEM1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 17:56:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xxwL1W00U1kojtg0000000; Fri, 11 May 2007 17:56:21 -0400
In-Reply-To: <4644E0A2.90008@garzik.org> (Jeff Garzik's message of "Fri, 11
	May 2007 17:31:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46988>

Jeff Garzik <jeff@garzik.org> writes:

> So, I merge the next batch of net driver patches.  After I merge a PPP
> patch, deep in the pile-o-patches, Andrew says "I shouldn't have sent
> that to you, don't apply it"  ;-)
>
> Right now, my process for reversing this damage is to start over:
> create a new branch, manually double-click the mouse on each commit in
> the "damaged" branch, and git-cherrypick it.  Very, very time
> consuming when you have more than a couple commits.

Do the commits on the branch being rebuilt form a single strand
of pearls without any merges?  If that is the case, what I would
do is:

	git heckout thatbranch
	git format-patch -o ./+outdir linus
        rm ./+outdir/0XXX-that-unwanted-patch.patch
        git reset --hard linus
        git am ./+outdir/????-*.patch
