X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 02:26:07 -0500
Message-ID: <20061219072607.GD2511@spearce.org>
References: <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org> <Pine.LNX.4.64.0612182248420.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 07:26:32 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612182248420.3479@woody.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34792>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwZMo-00013O-Bg for gcvg-git@gmane.org; Tue, 19 Dec
 2006 08:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932093AbWLSH0R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 02:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWLSH0R
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 02:26:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56062 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932093AbWLSH0Q (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 02:26:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwZMY-0003PC-PD; Tue, 19 Dec 2006 02:26:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 34D1120FB65; Tue, 19 Dec 2006 02:26:08 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Tue, 19 Dec 2006, Shawn Pearce wrote:
> > 
> > Why isn't git-index-pack doing the same?  Is there some hidden glitch
> > in some OS somewhere that has a problem with overmapping a file and
> > appending into it via write()?  I've done that on Mac OS X, Linux,
> > BSDi, Solaris...  never had a problem.
> 
> It works on modern systems, but at least old HPUX versions had 
> non-coherent mmap() and write(), and POSIX does not guarantee it. And if 
> you ever want to port to Windows, I don't think you should do it.
> 
> Anyway, try the pread() version first, see if that fixes the OS X problem.

I'll give your pread() version a shot.

But right now I'm in the middle of cloning your linux-2.6 git
repository.

It is done downloading the pack and my system is pegged at 100%
CPU while resolving deltas.

ActivityMonitor is showing that I'm spending 94% CPU in the kernel,
which is just insane.  Clearly Mac OS X's kernel cannot gracefully
handle what git-index-pack is currently doing.

-- 
