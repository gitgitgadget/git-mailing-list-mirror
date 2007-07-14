From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: why does git perpetually complain about include/asm-blackfin/macros.h?
Date: Sat, 14 Jul 2007 09:45:58 +0200
Message-ID: <20070714074558.GA8047@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain> <4688EF9B.8020405@garzik.org> <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com> <4689073D.1020802@garzik.org> <81b0412b0707020722q25e8eb41t456e7316fe4a7b40@mail.gmail.com> <46890DA8.4070400@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 09:44:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9cJH-0006En-7N
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 09:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbXGNHor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 03:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbXGNHor
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 03:44:47 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:47309 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbXGNHoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 03:44:46 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 259EA800301;
	Sat, 14 Jul 2007 09:44:44 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 5A746580D2; Sat, 14 Jul 2007 09:45:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46890DA8.4070400@garzik.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52453>

On Mon, Jul 02, 2007 at 10:37:28AM -0400, Jeff Garzik wrote:
> Alex Riesen wrote:
> >Do some of your branches miss the commit by which it was removed?
> 
> git-clone followed by git-checkout master recreates the problem.
> 
> But to answer your question directly, I rebase, so they absolutely do 
> not miss any commits.
> 
> 
> >It is somewhat unclear what "reappear" means, though: do you mean
> 
> Attempts to give you precise output to answer your question yielded a 
> data point, the kernel's "make distclean" causes this:
> 
> [jgarzik@pretzel linux-2.6]$ make distclean && git checkout master && 
> git diff HEAD
> D       include/asm-blackfin/macros.h
> Switched to branch "master"
> diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
> deleted file mode 100644
> index e69de29..0000000
> 
> [jgarzik@pretzel linux-2.6]$ git checkout -f
> 
> [jgarzik@pretzel linux-2.6]$ make distclean && git checkout master && 
> git diff HEAD
> D       include/asm-blackfin/macros.h
> Switched to branch "master"
> diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
> deleted file mode 100644
> index e69de29..0000000
> 
> [jgarzik@pretzel linux-2.6]$ git checkout -f
> 
> [jgarzik@pretzel linux-2.6]$ git checkout master && git diff 
> HEADSwitched to branch "master"
> 
> [jgarzik@pretzel linux-2.6]$ git checkout master && git diff HEAD
> Switched to branch "master"
> 
> [jgarzik@pretzel linux-2.6]$
> 
> 
> So, not a git problem but a kernel Makefile problem.  Sorry for the git 
> noise.

distclean on purpose delete zero size files.
And the kernel tree shall not contain such files - if it does it is a bug.

So I do not see a 'problem' with the kernel makefile but instead a problem
with the kernel tree wich is about to be fixed.

Agree?

	Sam
