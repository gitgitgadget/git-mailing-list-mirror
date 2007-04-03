From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 17:53:42 -0400
Message-ID: <20070403215342.GL27706@spearce.org>
References: <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031625050.28181@xanadu.home> <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org> <20070403210319.GH27706@spearce.org> <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org> <20070403211709.GJ27706@spearce.org> <alpine.LFD.0.98.0704031730300.28181@xanadu.home> <20070403213710.GK27706@spearce.org> <7vvegduo9e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqx5-0006W3-GY
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945994AbXDCVyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945996AbXDCVyD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:54:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52458 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945994AbXDCVyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:54:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYqwZ-0005Am-OA; Tue, 03 Apr 2007 17:53:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2734E20FBAE; Tue,  3 Apr 2007 17:53:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vvegduo9e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43677>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Here's the rub:  in the missing object case we didn't find it
> > in the pack index, but it could be loose.  That's one failed
> > syscall per object if the object isn't loose.  If the object
> > isn't loose, it could be that it was *just* removed by a
> > running prune-packed, and the packfile that it was moved
> > to was created after we scanned for packfiles, so time to
> > rescan...
> 
> If that is the only reason we have these reprepare_packed_git()
> sprinkled all over in sha1_file.c (by 637cdd9d), perhaps we
> should rethink that.  Is there a cheap way to trigger these
> rescanning only when a prune-packed is in progress, I wonder...

Yea, it is the only reason.  So... if we could have some
magic to trigger that, it would be good.  I just don't
know what magic that would be.

-- 
Shawn.
