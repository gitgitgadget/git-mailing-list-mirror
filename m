From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 17:11:49 -0400
Message-ID: <20070403211149.GI27706@spearce.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqIo-0007bJ-Kv
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945942AbXDCVM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945943AbXDCVM0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:12:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51270 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945942AbXDCVMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:12:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYqI2-0002fo-9d; Tue, 03 Apr 2007 17:11:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7CEFC20FBAE; Tue,  3 Apr 2007 17:11:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43665>

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 3 Apr 2007, Linus Torvalds wrote:
> 
> > All that extra memory is just for SHA1 commit ID information. 
> 
> I don't see where that might be.  The only thing that the paranoia check 
> triggers is:
> 
> 	foo = read_sha1_file(blah);
> 	memcmp(foo with bar);
> 	free(foo);
> 
> So where is that commit ID information actually stored when using 
> read_sha1_file()?

That might just be the mmap code in sha1_file.c.  We are mmaping
the existing packfile, to fetch the object.  That counts as virtual
memory.  ;-)

-- 
Shawn.
