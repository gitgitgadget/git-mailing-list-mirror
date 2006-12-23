From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/17] Sliding window mmap for packfiles.
Date: Sat, 23 Dec 2006 04:42:49 -0500
Message-ID: <20061223094249.GC9396@spearce.org>
References: <20061223073317.GA9837@spearce.org> <7vlkkzrm0w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 10:43:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy3P6-00065I-MJ
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 10:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbWLWJmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 04:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbWLWJmy
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 04:42:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42045 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbWLWJmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 04:42:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy3Oc-0000IA-Gd; Sat, 23 Dec 2006 04:42:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC59F20FB65; Sat, 23 Dec 2006 04:42:49 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkkzrm0w.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35308>

Junio C Hamano <junkio@cox.net> wrote:
> I have to say i am very much impressed (I've taken a look at
> only the first half up to #11, though).  How much has this been
> used in real projects?

None yet.  I just finished remerging it onto current git.git code.

> A couple of comments:
> 
> [3/17]
> 
> I think losing "p->next = NULL" does not matter with the callers
> we have right now, but somehow this part makes me feel uneasy.

That's a bug in that patch.  I removed it by mistake.  Good catch.
 
> [5/17]
> 
> I think it makes sense to exit(0) for the existing write_or_die
> upon EPIPE because that indicates we are the upstream of the
> pipe and the reading process has exit (i.e. user said 'q' to
> less while we still have more to say).  
> 
> I suspect the symmetry would not hold for read_or_die; when we
> are reading, EPIPE is not any different from any other errors
> (except for EAGAIN or EINTR which we already take care of in
> xread()) and the net effect is that we could not read what we
> wanted to.

Oh, good point.

-- 
Shawn.
