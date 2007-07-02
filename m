From: Jeff Garzik <jeff@garzik.org>
Subject: Re: why does git perpetually complain about include/asm-blackfin/macros.h?
Date: Mon, 02 Jul 2007 10:37:28 -0400
Message-ID: <46890DA8.4070400@garzik.org>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain>	 <4688EF9B.8020405@garzik.org>	 <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com>	 <4689073D.1020802@garzik.org> <81b0412b0707020722q25e8eb41t456e7316fe4a7b40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Ravnborg <sam@ravnborg.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 16:37:44 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5N23-0000NN-Oj
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 16:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbXGBOhf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 10:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbXGBOhd
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 10:37:33 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52204 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbXGBOhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 10:37:32 -0400
Received: from cpe-065-190-165-210.nc.res.rr.com ([65.190.165.210] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I5N1t-0002aV-HB; Mon, 02 Jul 2007 14:37:30 +0000
User-Agent: Thunderbird 1.5.0.12 (X11/20070530)
In-Reply-To: <81b0412b0707020722q25e8eb41t456e7316fe4a7b40@mail.gmail.com>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.9 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51371>

Alex Riesen wrote:
> Do some of your branches miss the commit by which it was removed?

git-clone followed by git-checkout master recreates the problem.

But to answer your question directly, I rebase, so they absolutely do 
not miss any commits.


> It is somewhat unclear what "reappear" means, though: do you mean

Attempts to give you precise output to answer your question yielded a 
data point, the kernel's "make distclean" causes this:

[jgarzik@pretzel linux-2.6]$ make distclean && git checkout master && 
git diff HEAD
D       include/asm-blackfin/macros.h
Switched to branch "master"
diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
deleted file mode 100644
index e69de29..0000000

[jgarzik@pretzel linux-2.6]$ git checkout -f

[jgarzik@pretzel linux-2.6]$ make distclean && git checkout master && 
git diff HEAD
D       include/asm-blackfin/macros.h
Switched to branch "master"
diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
deleted file mode 100644
index e69de29..0000000

[jgarzik@pretzel linux-2.6]$ git checkout -f

[jgarzik@pretzel linux-2.6]$ git checkout master && git diff 
HEADSwitched to branch "master"

[jgarzik@pretzel linux-2.6]$ git checkout master && git diff HEAD
Switched to branch "master"

[jgarzik@pretzel linux-2.6]$


So, not a git problem but a kernel Makefile problem.  Sorry for the git 
noise.

	Jeff
