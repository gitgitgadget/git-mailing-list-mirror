From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 17:41:43 -0400
Message-ID: <20061018214143.GF19194@spearce.org>
References: <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org> <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org> <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:42:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJAi-0002Hh-L5
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423011AbWJRVlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423012AbWJRVlu
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:41:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:2978 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1423011AbWJRVlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:41:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GaJAV-0005Fi-Jx; Wed, 18 Oct 2006 17:41:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C100F20E42A; Wed, 18 Oct 2006 17:41:43 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29275>

Linus Torvalds <torvalds@osdl.org> wrote:
> There are bigger reasons to _never_ allow packs to contain deltas to 
> outside of themselves:
> 
>  - there's no point. 

Actually there is a point to storing thin packs.  When I pull from
a remote repo (or push to a remote repo) a huge number of objects
and the target disk that is about to receive that huge number of
loose objects is slooooooooow I would rather just store the thin
pack then store the loose objects.

Ideally that thin pack would be repacked (along with the other
existing packs) as quickly as possible into a self-contained pack.
But that of course is unlikely to happen in practice; especially
on a push.
 
>  - it's a bad design. 
> 
>    In other words, it has potentially _serious_ downsides.

Yes, it does.

But it could also be useful when you fetch 20k+ objects onto a
Windows system or push 1k+ objects onto the slowest NFS system I
have ever seen...  where writing file data (aka packs) is reasonable
but creating or deleting files takes nearly 1 second per file.
I don't want to kill the better part of an hour waiting for a push
to complete!

-- 
Shawn.
