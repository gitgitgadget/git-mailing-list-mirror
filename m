From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 20:23:27 -0400
Message-ID: <20060928002327.GA22593@spearce.org>
References: <Pine.LNX.4.64.0609271606050.3952@g5.osdl.org> <20060928001241.62887.qmail@web51013.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 02:23:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjgh-00043x-G7
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWI1AXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031283AbWI1AXg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:23:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33228 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965173AbWI1AXf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 20:23:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSjgN-00043n-PX; Wed, 27 Sep 2006 20:23:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A77D020FB28; Wed, 27 Sep 2006 20:23:27 -0400 (EDT)
To: Matthew L Foster <mfoster167@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060928001241.62887.qmail@web51013.mail.yahoo.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27955>

Matthew L Foster <mfoster167@yahoo.com> wrote:
> 
> Ignoring the separate issue of replication for a momment, can someone respond to my time integrity
> question about whether a future version of git could trust/prefer its local time rather than a
> remote/sub/parent (non replicated) git server's timestamp? How do we fix gitweb.cgi, ref-log? How
> useful is gitweb.cgi if timestamps are all over the place? It does not make sense that commit
> order is currently out of sync with time order in the main linux kernel tree git repo on
> kernel.org. Why must each and every repo be dependent on time being set properly on all other git
> servers? How useful is change history or commit order without some concept of (local) time order?

Dependency order is all that matters.

It doesn't matter if K. Hacker makes a bug fix at 8 am his local
time or 3 days ago.  All that matters is that K. Hacker made it by
changing version A to version B.  Therefore commit B (containing
the bug fix) depends on commit A and only commit A (which may in
turn depend on commit A^, etc.).

That dependency in turn implies that you can't have bug fix B without
whatever feature/bug fix was A, and what that dependend on, etc.
Thus you know you have some particular chain of events as a result
of having B.  That's all that's interesting.


It _may_ matter to me that I received commit B (and maybe commit A)
at 3 pm my local time.  It may not.

In general I don't care too much about when a commit comes to me and
when it doesn't or when it was written, though I do look at

	git log next@{yesterday}..next

to see what Junio has pushed out recently.  Since I tend to
fetch only once per day (and usually around the same time of day)
this works reasonably well.

-- 
Shawn.
