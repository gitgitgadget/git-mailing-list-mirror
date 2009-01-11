From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 17:27:01 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901111646040.19665@iabervon.org>
References: <200901111602.53082.borntraeger@de.ibm.com> <20090111194258.GA4840@uranus.ravnborg.org> <alpine.LFD.2.00.0901111200330.6528@localhost.localdomain> <200901112239.20306.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:28:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8nD-00063F-4z
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbZAKW1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbZAKW1G
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:27:06 -0500
Received: from iabervon.org ([66.92.72.58]:56964 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbZAKW1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:27:04 -0500
Received: (qmail 4293 invoked by uid 1000); 11 Jan 2009 22:27:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2009 22:27:01 -0000
In-Reply-To: <200901112239.20306.borntraeger@de.ibm.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105241>

On Sun, 11 Jan 2009, Christian Borntraeger wrote:

> Am Sonntag 11 Januar 2009 schrieb Linus Torvalds:
> > Well, you don't actually have to mark that semi-random one as good either. 
> > What you can do is to just mark anything that _only_ contains fs/btrfs as 
> > good. IOW, you don't have to know the magic number - you just have to be 
> > told that "oh, if you only have btrfs files, and you're not actively 
> > bisecting a btrfs bug, just do 'git bisect good' and continue".
> 
> That should work.
> 
> <rant>
> Still, I am a bit frustrated. During this weekend I reported 2 regressions 
> (wlan and ata)  and I still try to find out why suspend/resume stopped 
> working. In the meantime I have identified 2 patches (one was already known, 
> I reported the 2nd to the usb maintainers) after 2.6.28 that caused suspend 
> to ram regressions. In rc1 S2R was broken again. So I tried bisecting the 
> third patch - which finally brought me to the btrfs bisect problem.
> 
> For me, this was the most annoying  merge window ever.
> 
> In my opinion we should really avoid subtree merges in the future as a curtesy 
> to people who do the uncool work of testing, problem tracking and bisecting. 
> </rant>

I think hitting a version without the actual kernel source in it should 
actually make bisecting easier, not harder; you can say without even 
building the kernel that that version doesn't have the problem you're 
trying to find, because it doesn't have anything in it.

The alternative to having that part of the tree empty would be to stick in 
some kernel version there (probably 2.6.28), and then you'd build and test 
2.6.28 again, completely wasting a bunch of time.

Probably the bisect documentation or messages need to make it clear what 
you should do when you land on this sort of commit.

	-Daniel
*This .sig left intentionally blank*
