From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 16:43:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101640570.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz> <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Holesovsky <kendy@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOFHN-0001EW-AV
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYBJQnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbYBJQnF
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:43:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:34547 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751386AbYBJQnD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:43:03 -0500
Received: (qmail invoked by alias); 10 Feb 2008 16:43:01 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp040) with SMTP; 10 Feb 2008 17:43:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18mBuAnOPomxnZFSpNMSoltnzzfxs1esVr33aw5dr
	d380KtVLagX0Kj
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73370>

Hi,

On Sat, 9 Feb 2008, Nicolas Pitre wrote:

> On Sat, 9 Feb 2008, Jan Holesovsky wrote:
> 
> > On Friday 08 February 2008 20:00, Jakub Narebski wrote:
> > 
> > > Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
> > > you would need machine with large amount of memory to repack it
> > > tightly in sensible time!
> > 
> > As I answered elsewhere, unfortunately it goes out of memory even on 8G 
> > machine (x86-64), so...  But still trying.
> 
> Try setting the following config variables as follows:
> 
> 	git config pack.deltaCacheLimit 1
> 	git config pack.deltaCacheSize 1
> 	git config pack.windowMemory 1g
> 
> That should help keeping memory usage somewhat bounded.

I tried that:

$ git config pack.deltaCacheLimit 1
$ git config pack.deltaCacheSize 1
$ git config pack.windowMemory 2g
$ #/usr/bin/time git repack -a -d -f --window=250 --depth=250
$ du -s objects/
2548137 objects/
$ /usr/bin/time git repack -a -d -f --window=250 --depth=250
Counting objects: 2477715, done.
fatal: Out of memory, malloc failed411764)
Command exited with non-zero status 1
9356.95user 53.33system 2:38:58elapsed 98%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (31929major+18088744minor)pagefaults 0swaps

Note that this is on a 2.4GHz Quadcode CPU with 3.5GB RAM.

I'm retrying with smaller values, but at over 2.5 hours per try, this is 
getting tedious.

Ciao,
Dscho
