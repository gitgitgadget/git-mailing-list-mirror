From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 22:57:37 -0500
Message-ID: <20071212035737.GL14735@spearce.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 04:58:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2IjY-0003bl-Bs
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 04:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXLLD5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 22:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbXLLD5o
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 22:57:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38534 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbXLLD5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 22:57:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J2Iit-0002lr-Q6; Tue, 11 Dec 2007 22:57:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9DC0620FBAE; Tue, 11 Dec 2007 22:57:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67989>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
...
> is virtually useless because it's too expensive, but try doing
> 
> 	git gui blame gcc ChangeLog
> 
> instead, and doesn't that just seem nicer? (*)
> 
> The difference is that the GUI one does it incrementally, and doesn't have 
> to get _all_ the results before it can start reporting blame.
> 
> Not that I claim that the gui blame is perfect either (I dunno why it 
> delays the nice coloring so long ...

git-gui waits to color until after it gets the move/copy annotations
back from the -C -C -w second pass it does.  This way the coloring
is based on the original source location, not on the move/copy that
caused it to be placed where it is now.

I played around with this for a while and finally made it work the
way it does as I assumed most users would want to see where something
originally came from more than how it got moved to where it is now.

IOW the (very expensive) -C -C -w pass is usually much more
interesting than the default (fast) pass, so that is the line
annotation data we color with.  But it takes longer to get and
is run second, so yea, coloring takes a while.

-- 
Shawn.
