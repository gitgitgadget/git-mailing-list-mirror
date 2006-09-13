From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Merge strategy 'applyreject'
Date: Wed, 13 Sep 2006 17:50:43 -0400
Message-ID: <20060913215043.GE30782@spearce.org>
References: <20060913210817.GA30782@spearce.org> <20060913211617.GJ23891@pasky.or.cz> <7v1wqf789j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 23:51:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNcdA-0008CY-Ck
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWIMVut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWIMVut
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:50:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:62853 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751215AbWIMVut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 17:50:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNccu-00085Y-1t; Wed, 13 Sep 2006 17:50:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1F03D20E49A; Wed, 13 Sep 2006 17:50:43 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wqf789j.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26957>

Junio C Hamano <junkio@cox.net> wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Wed, Sep 13, 2006 at 11:08:17PM CEST, I got a letter
> > where Shawn Pearce <spearce@spearce.org> said that...
> >> Create merge strategy 'applyreject'.
> >> 
> >> The applyreject merge strategy is a two head merge strategy which performs
> >> the merge by obtaining the diff between the common base and the branch
> >> being merged and applies it to the current branch using git-apply --reject.
> >> Consequently any failures are written to .rej files, rather than using
> >> the RCS <<<<<<< ======= >>>>>>> format.
> >
> > So, it's essentially the same as the classic resolve strategy, just
> > handling rejects differently? I think that should be more obvious from
> > its name, perhaps resolve-rej?
> >
> > .rej files, what a nuisance to handle those... :)
> 
> You were who asked for "apply --reject", weren't you?
> 
> I am not interested in this merge strategy myself.  Having said
> that, if it is cleanly done, I do not have much objection adding
> it for other people's use, at least in principle.

I'll clean it up, document it and and resubmit the patch if others
want it as a top-level merge strategy.

But I don't really want this as a merge strategy in its own right.
I want it as part of merge-recur, so I can drop into my .git/config
file:

	[merge-recursive]
		conflictFormat = rejects

(for example) and not deal with the RCS merge program.  This however
will require some hacking in merge-recursive.c and apply.c but I
think its workable.

-- 
Shawn.
