From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 21:06:52 -0500
Message-ID: <20070104020652.GB18206@spearce.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <chris133@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Sasha Khapyorsky <sashak@voltaire.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 03:07:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2I0i-0001VN-RM
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 03:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbXADCHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 21:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbXADCHE
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 21:07:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59310 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbXADCHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 21:07:01 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H2I0T-0000le-0v; Wed, 03 Jan 2007 21:07:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8BEFC20FB65; Wed,  3 Jan 2007 21:06:53 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35902>

Linus Torvalds <torvalds@osdl.org> wrote:
> Junio - I suspect "pack-check.c" really shouldn't try to do it as one 
> single humungous "SHA1_Update()" call. It showed one bug on PPC, I 
> wouldn't be surprised if it's implicated now on some other architecture. 

It used to do it as one big SHA1_Update() call...
 
> Shawn - does the pack-file-windowing thing already change that? I'm too 
> lazy to check..

But with the mmap window thing in `next` it does it in window
units only.  Which the user could configure to be huge, or could
configure to be sane.  The default when using mmap() is 32 MiB;
1 MiB when using pread() and git_mmap().

-- 
Shawn.
