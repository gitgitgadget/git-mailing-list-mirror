From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 18:33:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511111806070.25300@iabervon.org>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
 <20051111075257.GA4765@c165.ib.student.liu.se> <20051111114511.GQ30496@pasky.or.cz>
 <7v64qzozyx.fsf@assigned-by-dhcp.cox.net> <20051111173239.GU16061@pasky.or.cz>
 <7v1x1nni78.fsf@assigned-by-dhcp.cox.net> <20051111215620.GX16061@pasky.or.cz>
 <7vy83ukdwf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 00:33:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaiOs-0003Mr-O3
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 00:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVKKXdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 18:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVKKXdb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 18:33:31 -0500
Received: from iabervon.org ([66.92.72.58]:47114 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751320AbVKKXda (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 18:33:30 -0500
Received: (qmail 17607 invoked by uid 1000); 11 Nov 2005 18:33:28 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2005 18:33:28 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy83ukdwf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11646>

On Fri, 11 Nov 2005, Junio C Hamano wrote:

> Petr Baudis <pasky@ucw.cz> writes:
> 
> > 	16    anc1/anc2 anc1    anc2      no merge
> >
> > What ends up in the index at this moment as "stage 1"? anc1? anc2?
> > Two stage 1 entries? And what does git-merge-index do about this?
> 
> I think we decided there is no single sensible resolution, and
> we leave stage 1 empty.
> 
> Come to think of it, we should signal that we are punting by
> either exiting non-zero, or stuffing 0{40} SHA1 in stage1, so
> that we can distinguish the case with two sides adding things
> differently.  Daniel, what do you think?

Probably don't want to exit non-zero, since we can deal with the rest of 
the paths sensibly. All 0 SHA1 would work, if we want to identify this 
case. On the other hand, I think the desired behavior at present is to 
tell the user to pick the correct version of the two, which is the same as 
if it's new in both sides, which is why I had it like that.

Someday, we ought to do a combined merge-base and read-tree, which would 
be able to correctly handle revert wars, but it's too very exciting 
currently, since the multi-base merge cases have generally turned out to 
be user error (i.e., the user didn't actually mean to merge those things).

	-Daniel
*This .sig left intentionally blank*
