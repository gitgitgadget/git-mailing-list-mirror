From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 12:22:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706031216560.23741@woody.linux-foundation.org>
References: <20070603114843.GA14336@artemis>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 21:23:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuvfO-0003KZ-HB
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 21:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXFCTW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 15:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbXFCTW7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 15:22:59 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:44814 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbXFCTW6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2007 15:22:58 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l53JMPjw014695;
	Sun, 3 Jun 2007 12:22:27 -0700
In-Reply-To: <20070603114843.GA14336@artemis>
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-4.547 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49024>



On Sun, 3 Jun 2007, Pierre Habouzit wrote:
> 
>   Though there is a few design issues I have, that block me from doing
> first decisions about how to implement some kind of Proof of Concept. My
> main problem is: should I put this bug tracking system in the repository
> it tracks bugs for, or not.

Make it a separate (and independent) branch of the repository you track, 
and then you can do it - or not do it - as you want later.

See as an example the git "todo" branch, ie you can always look at what 
Junio may or may not be planning with a

	git show remotes/origin/todo:TODO

which just shows the "TODO" file in the "remotes/origin/todo" branch.

The same approach could be done for bug tracking: you *could* check out 
the bug-tracking branch separately (and you can create a repository that 
has _only_ that bug tracking branch, or _only_ the actual development 
branch in it), but you could also access it without even checking it out 
at all, and mix the two projects in the same repository.

>   I mean, the immediate idea is to have some .bugs/ directories (or
> alike). This has many good properties, e.g. for projects like the linux
> kernel with its many subsystems or driver, it would make sense to have
> per driver/subsystems/... bug packs, and move bugs from one pack to
> another would be the way of assigning bugs to different modules.

I would suggest _not_ doing this kind of mixing. I think it might be 
appropriate for some cases, but I don't think it's appropriate in general. 
Partly because I don't think the people who change the bugs are at all 
necessarily at all the same people who actually do development.

IOW, bug-reporters obviously have to have write access to *some* 
bug-tracking thing, and I don't think you want to try to merge the 
bug-tracking together with the real development. 

		Linus
