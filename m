From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [PATCH 2/2] Remove unused index tracking code.
Date: Thu, 19 Oct 2006 22:46:02 -0400
Message-ID: <20061020024602.GF7162@delft.aura.cs.cmu.edu>
References: <1168a0313ac1152d43731965fbbb6d4ccfd865a1.1161301889.git.jaharkes@cs.cmu.edu> <20061020002048.GC7162@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0610192058130.1971@xanadu.home> <20061020022723.GE7162@delft.aura.cs.cmu.edu> <7vd58nra64.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 04:46:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GakOi-0007t1-U2
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 04:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992432AbWJTCqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 22:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946846AbWJTCqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 22:46:09 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:35015 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1946845AbWJTCqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 22:46:07 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
	(envelope-from <jaharkes@cs.cmu.edu>)
	id 1GakOY-0002DG-9s; Thu, 19 Oct 2006 22:46:02 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd58nra64.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29403>

On Thu, Oct 19, 2006 at 07:30:27PM -0700, Junio C Hamano wrote:
> Jan Harkes <jaharkes@cs.cmu.edu> writes:
> 
> > I guess I'll grep through the mailinglists to try to figure out what
> > these OFS and REF deltas are and why they behave so differently
> > depending on their order in the pack.
> 
> It's been cooking in "next" branch for quite a while.

Ah yes, just went through the thread about the git-index-pack breaking on
64-bit systems and the back and forth about the possible complexity of
the new code.

> It is really simple:
>
>  - if the found union content matches with a reference union initialized
>    through the sha1 member then deltas[j].obj->type == OBJ_REF_DELTA
>    must be true.
>
>  - if the found union content matches with a reference union initialized
>    through the sha1 member then deltas[j].obj->type == OBJ_OFS_DELTA
>    must be true.
...

I guess one of these must be false.

But clearly this patch breaks those offset based delta's when we expand
random deltas in place.

Jan
