From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: That improved git-gui blame viewer..
Date: Tue, 12 Jun 2007 09:53:03 -0400
Message-ID: <20070612135303.GT6073@spearce.org>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org> <20070611064203.GG6073@spearce.org> <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org> <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com> <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com> <7vbqflll55.fsf@assigned-by-dhcp.pobox.com> <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 15:53:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy6o9-0006GG-Fh
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 15:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945AbXFLNxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 09:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756144AbXFLNxL
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 09:53:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46053 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945AbXFLNxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 09:53:10 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hy6ns-0002HQ-Ti; Tue, 12 Jun 2007 09:53:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7C48120FBAE; Tue, 12 Jun 2007 09:53:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49963>

Marco Costalba <mcostalba@gmail.com> wrote:
> On 6/12/07, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > (1) Are you emulating CVS-like "a file has an identity, and we
> >     follow its changes" model?  How does it handle file split,
> >     merge, and code movement in general?
> >
> 
> It uses 'git rev-list HEAD -- <path>' to get the list of revisions
> that modified a path,

So apparently yes, qgit is emulating CVS.  And yet much better things
exist (git-blame).

> I really would like to keep it like that because it is the way 'git'
> works, and I would feel uncomfortable in filtering out git results, it
> seems quite fragile to me.

Its not "the way git works".  Its just one way of looking at the data
in the object database.  And its not as accurate or as interesting
as what git-blame does.

> This means that file splits, merges, renames etc.. are handled as much
> as they are handled in git. IOW *if* 'git rev-list HEAD -- <path>'
> returns a list of revisions taking in account all of the above, so it
> will, automatically, do qgit.
> 
> BTW _currentlly_ git-rev-list does not do that.

And it may never do it.  Most of the split/merge code is actually
in git-blame and is probably too CPU intensive to slam into the
middle of git-rev-list as a path limiter operator.  But renames
*might* someday be included.
 
> Going from oldest to newest has this advantage:

It is unclear why you aren't just using `git blame --incremental`.
git-blame running in two passes (with and without -M -C -C) can yield
some very interesting results on files, like Git's own revision.c.
And with the new -w flag that Junio just added, there's even more
interesting possibilities...

;-)

-- 
Shawn.
