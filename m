From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: git and gitweb inconsistencies
Date: Sun, 23 Oct 2005 13:30:55 -0400
Message-ID: <20051023173055.GA3019@pe.Belkin>
References: <20051023001412.GA22679@pe.Belkin> <20051023115939.GG8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Oct 23 19:31:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETjgj-0004Vi-NW
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 19:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVJWRa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 13:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVJWRa5
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 13:30:57 -0400
Received: from eastrmmtao06.cox.net ([68.230.240.33]:43478 "EHLO
	eastrmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750770AbVJWRa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 13:30:57 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051023173015.LGMK21663.eastrmmtao06.cox.net@localhost>;
          Sun, 23 Oct 2005 13:30:15 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1ETjgN-0000nS-Ng; Sun, 23 Oct 2005 13:30:55 -0400
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051023115939.GG8383MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10494>

On Sun, Oct 23, 2005 at 01:59:39PM +0200, Sven Verdoolaege wrote:
> On Sat, Oct 22, 2005 at 08:14:12PM -0400, Chris Shoemaker wrote:
> > A few days later, I ran git-cvsimport again, with -i.  This imported
> > just the recent changes, but the view from gitweb didn't change.  :(
> 
> Are you sure you didn't just create a new import *inside* the old import ?
> Do you have, say, both an 'objects' and a '.git/objects' directory ?

OH!  You, sir, DO have a crystal ball.  :) 

I foolishly assumed that the second time I ran git-cvsimport, with -C
/pub/scm/project/ it would be able to detect that I was using the
stand-alone GIT-DIR.  But, it obviously didn't.  I guess the solution
is use specify GIT_DIR everytime I run git-cvstimport.

So, it seems that git-web.cgi detects and prefers the stand-alone
directory structure, because I specify it in the projects_list file,
while git-cat-file, and git-update-ref default to using .git.

> 
> > $ echo `git-rev-list tip --max-count=1` > refs/heads/mytest
> > $ git-cat-file -t `cat refs/heads/mytest`
> 
> That should be
> 
> git-update-ref refs/heads/mytest tip
> (the new head will appear in .git/refs/heads/mytest, 
> unless you've set GIT_DIR)
> git-cat-file -t mytest

Ah, and if I'd used that command, I would have realized something was
wrong when mytest *didn't* appear in refs/heads, but rather
.git/refs/heads.

Thanks for thinking creatively about how I could have messed it up!

-chris

> 
> 
> skimo
