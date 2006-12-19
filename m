X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 03:49:08 -0500
Message-ID: <20061219084908.GG2511@spearce.org>
References: <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org> <Pine.LNX.4.64.0612182248420.3479@woody.osdl.org> <20061219083242.GF2511@spearce.org> <20061219084017.GB30448@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 08:49:29 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Theodore Tso <tytso@mit.edu>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061219084017.GB30448@fiberbit.xs4all.nl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34802>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwaf3-0005pX-1c for gcvg-git@gmane.org; Tue, 19 Dec
 2006 09:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932684AbWLSItS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 03:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWLSItS
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 03:49:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58610 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932684AbWLSItR (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 03:49:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gwaeq-0007eb-KS; Tue, 19 Dec 2006 03:49:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6F32320FB65; Tue, 19 Dec 2006 03:49:08 -0500 (EST)
To: Marco Roeland <marco.roeland@xs4all.nl>
Sender: git-owner@vger.kernel.org

Marco Roeland <marco.roeland@xs4all.nl> wrote:
> On Tuesday December 19th 2006 at 03:32 Shawn Pearce wrote:
> 
> > > Anyway, try the pread() version first, see if that fixes the OS X problem.
> > 
> > It does.  Without pread() (aka stock 'next') it takes me over an
> > hour to index a pack of linux-2.6.  With pread() its 1m6s to run
> > index-pack on the same pack file.  The indexes are (of course)
> > identically produced.
> 
> I see the same here. From an (estimated) time of 37 minutes down to 52
> seconds with the pread() patch. Running the profiler (shark) on the old
> version showed that 85% of the time was spent in the Mac OS X mmap()
> system call.

More testing on Linux is probably needed, but if using pread()
on Linux is breakeven or slightly faster (as suggested by Johannes'
LilyPond test) this 60x performance improvement on initial clone
of largish projects on Mac OS X would be nice to have.

Not that I personally frequently clone large projects on Mac OS X.
But new users to Git might.  :-)

-- 
