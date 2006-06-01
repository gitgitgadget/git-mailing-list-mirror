From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/10] re-based and expanded tree-walker cleanup patches
Date: Wed, 31 May 2006 23:11:43 -0400
Message-ID: <20060601031143.GA13392@spearce.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org> <7virno79a7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605291739430.5623@g5.osdl.org> <7vmzd05i25.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605292112530.5623@g5.osdl.org> <7vpshtyffk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 01 05:12:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FldbF-00073O-Tz
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 05:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWFADLv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 23:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWFADLv
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 23:11:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38291 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751280AbWFADLu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 23:11:50 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fldaw-0005yu-6a; Wed, 31 May 2006 23:11:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D00D420E445; Wed, 31 May 2006 23:11:43 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpshtyffk.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21102>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> >  (a) git-rev-list --pretty=oneline "$upstream"..ORIG_HEAD > rev-list
> >
> >  (b) edit the rev-list, moving the single lines around, deleting them, etc
> >
> >  (c) cat rev-list |
> >      git-format-patch -k --stdout --stdin --full_index |
> >      git-am
> >
[snip]
> What this means is:
> 
> 	git-format-patch $revargs
> 
> is not equivalent to
> 
> 	git-rev-list $revargs | git-format-patch --stdin
> 
> but is equivalent to
> 
> 	git-rev-list $revargs | tac | git-format-patch --stdin
> 
> 
> Thoughts from the list?

Aside from not knowing what tac is I agree with the latter.
It is what the user would expect to happen.  Except maybe add a
--ancestors-first option to git-rev-list to do what tac does before
outputting the revisions?

	git-rev-list --ancestors-first $revargs | git-format-patch --stdin

-- 
Shawn.
