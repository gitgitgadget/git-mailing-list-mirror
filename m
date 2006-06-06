From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (part #2)
Date: Tue, 6 Jun 2006 01:39:05 -0400
Message-ID: <20060606053905.GA9797@spearce.org>
References: <7v64jli66m.fsf@assigned-by-dhcp.cox.net> <20060602023545.GA5039@spearce.org> <7v3beodpqs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 07:39:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnUHc-0001vq-6c
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 07:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWFFFjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 01:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWFFFjL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 01:39:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:27591 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932110AbWFFFjK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 01:39:10 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FnUHU-0006qK-0E; Tue, 06 Jun 2006 01:39:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2D88420FB21; Tue,  6 Jun 2006 01:39:05 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3beodpqs.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21362>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I find it useful to track what I've sent to you just in case I
> > screw up some ref somewhere.  I like knowing that if I perform a
> > bad update-ref call (which I'm prone to do sometimes) that I can
> > recover quickly as the log exists.
> 
> I find it interesting to be able to say:
> 
> 	$ git log next@{yesterday}..next
> 
> I often find myself getting curious to see:
> 
> 	$ git reflog next
>         Wed May 31 14:23:58 2006 -0700
>                 62b693a... Merge branch 'master' into next
>         ...

Hmm, looks like nobody has actually implemented that - at least not
in 'next'.  :-)

Is that a serious feature request?  If so I'll do it.  BTW: we're
also still lacking reflog during receive-pack.  Much of the update()
function in receive-pack.c can be replaced with the new locking
functions, except that if reflog is enabled on the target ref then
GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL need to be set for the
update to succeed.

I've been busy at work but I really have been wanting to put
some time into this GIT Eclipse plugin that I've been neglecting.
Some folks at work are starting to become more interested in it.
I have gotten the really core functionality done; all that is
left is the hard stuff (directory synchronization, push, fetch,
non-delta pack generation for push[1], tree diff).


*1* Generating a simple pack with only deflate compression on the
objects should be trivial.  Since this is 100% pure Java code nobody
should be expecting great performance out of it from day 1 anyway.
Sure its not an optimal transport but if you were that worried about
the transfer byte costs to push then you probably would just prefer
to use the native tools code tools anyway.

-- 
Shawn.
