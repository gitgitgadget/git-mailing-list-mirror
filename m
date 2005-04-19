From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 17:41:57 -0600
Message-ID: <200504191741.57626.elenstev@mesatop.com>
References: <20050419043938.GA23724@kroah.com> <200504191704.48976.elenstev@mesatop.com> <Pine.LNX.4.58.0504191627420.2274@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:42:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO2Lu-00057E-5d
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDSXqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVDSXqH
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:46:07 -0400
Received: from nacho.zianet.com ([216.234.192.105]:33808 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S261202AbVDSXp6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 19:45:58 -0400
Received: (qmail 28582 invoked from network); 19 Apr 2005 23:45:56 -0000
Received: from 216-31-65-7.zianet.com (216.31.65.7)
  by 0 with SMTP; 19 Apr 2005 23:45:56 -0000
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.6.1
In-Reply-To: <Pine.LNX.4.58.0504191627420.2274@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 19 April 2005 05:38 pm, Linus Torvalds wrote:
> 
> On Tue, 19 Apr 2005, Steven Cole wrote:
> > 
> > I wasn't complaining about the 4 minutes, just the lack of feedback
> > during the majority of that time.  And most of it was after the last
> > patching file message.
> 
> That should be exactly the thing that the new "read-tree -m" fixes.
> 
> Before, when you read in a new tree (which is what you do when you update
> to somebody elses version), git would throw all the cached information
> away, and so you'd end up doing a "checkout-cache -f -a" that re-wrote
> every single checked-out file, followed by "update-cache --refresh" that
> then re-created the cache for every single file.
> 
> With the new read-tree, the same sequence (assuming you have the "-m"  
> flag to tell read-tree to merge the cache information) will now only write
> out and re-check the files that actually changed due to the update or
> merge.
> 
> So that last phase should go from minutes to seconds - instead of checking
> 17,000+ files, you'd end up checking maybe a few hundred for most "normal"
> updates.
> 
> For example, updating all the way from the git root (ie plain 2.6.12-rc2)  
> to the current head, only 577 files have changed, and the rest (16,740)
> should never be touched at all.
> 
> You can see why doing just the 577 instead of the full 17,317 might speed
> things up a bit ;)
> 
> 		Linus

Cool.  Petr, I hope this works like this with your tools tomorrow.

> 
> PS. Of course, right now it probably does make sense to waste some time
> occasionally, and run "fsck-cache $(cat .git/HEAD)" every once in a while.
> Just in case..
> 
> 
Sounds like a good thing to schedule for $WEEHOUR.

Steven
