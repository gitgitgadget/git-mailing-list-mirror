From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Fri, 22 Dec 2006 09:04:50 +0100
Message-ID: <20061222080450.GB9595@fiberbit.xs4all.nl>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org> <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <46a038f90612181502y3e2a41cds7f16113ad0270f31@mail.gmail.com> <991F50E2-2C98-4710-84C5-3D7348E00B64@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 09:05:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxfP1-0003LC-JM
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945963AbWLVIFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945959AbWLVIFF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:05:05 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:46166 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945963AbWLVIFD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:05:03 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1GxfOc-0002dY-LI; Fri, 22 Dec 2006 09:04:50 +0100
To: Kyle Moffett <mrmacman_g4@mac.com>
Content-Disposition: inline
In-Reply-To: <991F50E2-2C98-4710-84C5-3D7348E00B64@mac.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35139>

On Thursday December 21st 2006 at 20:44 Kyle Moffett wrote:

> I've actually also seen filesystem operation latency double or triple  
> if you start trying to do operations from multiple threads at once.   
> Suddenly the already dog-slow single-CPU operations start bouncing  
> caches and the Mac OS X mostly-whole-of-BSD-BKL across CPUs and it  
> just crawls.  I can definitely see the local disk IO taking 100x  
> longer than the network I/O, especially with an 8-megabit internet link.

The mmap() implementation on Mac OS X ate 85% percent of system time on
the old version for git-index-pack. Of that time nearly all was spent on
some Mach locking function. So yes the BKL like locking inside the Mach
message passing seems to be the big culprit, perhaps Andy Tanenbaum can
explain this on LCA 2007. <ducks>

As most developers now run multicore CPU's we notice these differences
even better now! ;-)
-- 
Marco Roeland
