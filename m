From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 17:56:12 -0400
Message-ID: <20060927215612.GB21839@spearce.org>
References: <Pine.LNX.4.64.0609271354480.3952@g5.osdl.org> <20060927214417.36420.qmail@web51002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 23:56:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GShOD-00036I-2l
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 23:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030909AbWI0V4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 17:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030910AbWI0V4W
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 17:56:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:6330 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030909AbWI0V4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 17:56:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GShNu-0001OZ-0E; Wed, 27 Sep 2006 17:56:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0293D20FB28; Wed, 27 Sep 2006 17:56:12 -0400 (EDT)
To: Matthew L Foster <mfoster167@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060927214417.36420.qmail@web51002.mail.yahoo.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27938>

Matthew L Foster <mfoster167@yahoo.com> wrote:
> --- Linus Torvalds <torvalds@osdl.org> wrote:
> 
> >  - so I replicate my home machine tree to the one on master.kernel.org, 
> >    and now others can see it.
> > 
> > When did the merge happen? It happened at 8:30 on my machine, and that's 
> > what is recorded. End of story. No ifs, buts, maybes about it. That's the 
> > only time you can _ever_ see for that merge.
> 
> Ok, so it's more complex because of the workflow issue of delayed/pseudo mirroring/replication
> between private and public repos?

No.  Its no different than anything else.  Linus' personal repository
is just as visible to you as say Andrew Morton's personal repository
(read: neither one is visible to you).  Therefore the date/time
that a given commit hits either one of those repositories is only
of interest to the people with direct access to it.  Which is Linus
and Andrew respectively.  And probably nobody else.

When Linus pushes all of those merges out to kernel.org those
commits are arriving at "his" kernel.org repository at a date/time
that is absolutely after when they first arrived in Linus' personal
repository.  Note that the kernel.org repository is a completely
different repository from Linus' personal work repository!

But due to clock skew, time zone differences, etc. between systems
those commits may actually appear to arrive at kernel.org before,
at the same time as, or after they arrived on Linus' personal system.
:-)

> This cloning/replication is not done through git?

I don't know.  I'd wager Linus is probably using Git to push changes
to some repository on a master system behind the kernel.org domain
name, and that master then gets replicated out to mirror systems
through some form of replication.

> Are you saying it's impossible for master.kernel.org's git to track the local time of each
> commit/merge/replication? Perhaps replication time is precisely what should/could be tracked
> (locally)? 

I don't think the replication time is really important here.  If it
was then Git should be used for the replication of Git repositories
being mirrored on kernel.org.  I doubt you'd get every mirror
operator to do that however.

> From an integrity or at least gitweb.cgi's viewpoint it seems very important to me that commit
> order also be per repo consistent with time order.

I'm not sure I follow you.  Time order has nothing to do with
anything.  That's largely been the entire point of this thread.

Because of the potentical for clock skew even on a single system
you can't take much stock in a timestamp.  But with Git you can at
least completely trust the commit graph, provided that you trust
those who made commits before your own commit.  Of course this
trust is only possible because the commit graph cannot be altered
once a node has been added into it.

As such the commit graph is consistent between repositories (assuming
they have the same head commits), but the timestamps of the reflogs
within each will widely differ.  They could widely differ even on
the same system due to ntpd updating the clock at the exact wrong
moment for example.  :)

-- 
Shawn.
