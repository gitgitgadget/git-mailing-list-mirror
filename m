From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Thu, 21 Dec 2006 20:44:12 -0500
Message-ID: <991F50E2-2C98-4710-84C5-3D7348E00B64@mac.com>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org> <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <46a038f90612181502y3e2a41cds7f16113ad0270f31@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 02:51:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxZZ1-0001LJ-BI
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 02:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945913AbWLVBvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 20:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945915AbWLVBvI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 20:51:08 -0500
Received: from smtpout.mac.com ([17.250.248.181]:53751 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945913AbWLVBvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 20:51:07 -0500
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 20:51:07 EST
Received: from mac.com (smtpin05-en2 [10.13.10.150])
	by smtpout.mac.com (Xserve/8.12.11/smtpout11/MantshX 4.0) with ESMTP id kBM1iKAh005669;
	Thu, 21 Dec 2006 17:44:20 -0800 (PST)
Received: from [10.0.0.4] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin05/MantshX 4.0) with ESMTP id kBM1iFHN009549
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 21 Dec 2006 17:44:18 -0800 (PST)
In-Reply-To: <46a038f90612181502y3e2a41cds7f16113ad0270f31@mail.gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35115>

On Dec 18, 2006, at 18:02:07, Martin Langhoff wrote:
> On 18 Dec 2006 14:26:36 -0800, Randal L. Schwartz  
> <merlyn@stonehenge.com> wrote:
>> Linus Torvalds wrote:
>>> You're running this under OS X, aren't you? It's a pig of an OS,  
>>> but "almost one hour" vs "25 seconds" is still unreasonable.
>>
>> I agree!
>
> Me too -- but entirely possible. Disk IO is specially painful on  
> OSX.  Stat calls are horrid. Using Arch (which abused stat calls to  
> no end) many ops would take 50x-100x longer on OSX than on Linux. A  
> large unpacked repo with git is a real pain -- and packing it can  
> take hours.

I've actually also seen filesystem operation latency double or triple  
if you start trying to do operations from multiple threads at once.   
Suddenly the already dog-slow single-CPU operations start bouncing  
caches and the Mac OS X mostly-whole-of-BSD-BKL across CPUs and it  
just crawls.  I can definitely see the local disk IO taking 100x  
longer than the network I/O, especially with an 8-megabit internet link.

> Once you are packed it's sweet, but large repos are a pain to deal  
> with. You won't impress anyone with performance over a linux kernel  
> repo -- starting up gitk can take a long time. Stat-heavy stuff  
> like git-diff is noticeably slower under OSX.

Just as an example, it takes my OS-X-running Quad-2.5GHz G5 ten times  
as long to do a "grep -rl foo linux/" as my Linux-running dual-1GHz  
G4 with 400MHz system bus.  This is disk-cache-hot too.  And that's  
not even a stat-heavy workload.  There's more than one reason I'm  
trying to make a Mac OS X ABI emulation layer on top of Linux :-D.

Cheers,
Kyle Moffett
