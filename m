From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-seek messed me up
Date: Tue, 31 May 2005 20:39:08 +0200
Message-ID: <20050531183907.GE7013@pasky.ji.cz>
References: <20050531143318.GB27047@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 20:39:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdBdL-0000AH-QY
	for gcvg-git@gmane.org; Tue, 31 May 2005 20:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVEaSkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 14:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVEaSkm
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 14:40:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22698 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261180AbVEaSjL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 14:39:11 -0400
Received: (qmail 1039 invoked by uid 2001); 31 May 2005 18:39:08 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050531143318.GB27047@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 31, 2005 at 04:33:18PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> Hi folks,

Hi,

> I'm not positive, but I *think* I shot myself in the foot by doing a cg-seek
> when there were uncommitted changes in my working file set. The patching process
> created duplicate areas in the files, while losing other areas and giving
> patch rejects. Before I figured out the problem, I wasn't even able to seek to a
> known state because of this, so I ended up having to recreate the files as best
> as I could from the mess I was left with in the working directory. I realize I
> could have gotten a clean tree by cloning, but this didn't occur to me at the
> time. It seemed like the whole repository was just corrupt.
> 
> I think I recovered everything, and I know it was my own mistake, but it
> seems like this will be a common blunder by users. Maybe cg-seek should
> first do a comparison between the working tree and the most recent known
> state. If the two differ, it should exit with an error.

I've rewritten cg-seek to use the magical tree_timewarp function. So
what it will do now is that it will save the local changes, then just
overwrite the tree with the seeked-to target and then it will reapply
the local changes. This should give much better (although still far from
perfect) results and reduce the inconsistencies popping up.

Anyway, anytime you are in trouble, cg-cancel is the way out! ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
