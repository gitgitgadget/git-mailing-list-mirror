From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Segfault in xdl_merge is back
Date: Wed, 27 Dec 2006 03:24:40 -0500
Message-ID: <20061227082440.GC23022@spearce.org>
References: <20061227041644.GA22449@spearce.org> <Pine.LNX.4.64.0612262245250.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 09:24:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzU5k-0003tz-Kf
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 09:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbWL0IYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 03:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbWL0IYt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 03:24:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56095 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbWL0IYt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 03:24:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzU5i-0005ok-9x; Wed, 27 Dec 2006 03:24:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 149F420FB65; Wed, 27 Dec 2006 03:24:40 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612262245250.4473@woody.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35455>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 26 Dec 2006, Shawn Pearce wrote:
> > 
> > I'm suspecting this is actually some sort of memory corruption in
> > the heap (due to a bad malloc/free) as the bug seems to rear its
> > head only based on the data we are allocating/have allocated.
> 
> Can you try to reproduce it under Linux and use "valgrind" to run the 
> thing that SIGSEGV's? That tends to be a pretty good way to debug bad 
> allocations..
> 
> So instead of bisecting it on cygwin, try to use the build that broke on 
> Linux too (ie undo the 5caf9232 "fix") and when you can reproduce it under 
> Linux, compiel withour -O2 and with debug information, and gdb will be a 
> lot more useful, but also run it with valgrind..

Good advice.  Unfortunately it may be difficult to get valgrind onto
a Linux system where I can also put that repository which is failing.

Junio suggested that I try running git-merge-file on the three
blobs that I'm segfaulting on.  That's a pretty quick test.

Failing that I may have to find a way to get valgrind onto a Linux
system - but that could take a month or more.  (The UNIX admins
are overworked and don't care much about Linux, and I don't have
my own Linux system there.)

I'd really like to get this segfault fixed before 1.5.0 ships. Its
a rather nasty bug and I suspect the culprit is already in 1.5.0-rc0.

-- 
Shawn.
