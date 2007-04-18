From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 20:31:56 +0200
Message-ID: <20070418183156.GF5913@xp.machine.xx>
References: <20070417161720.GA3930@xp.machine.xx> <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk> <20070418055215.GA32634@xp.machine.xx> <7v7isajfl1.fsf@assigned-by-dhcp.cox.net> <20070418081122.GB32634@xp.machine.xx> <Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk> <7vfy6xird9.fsf@assigned-by-dhcp.cox.net> <20070418174350.GB5913@xp.machine.xx> <7vlkgph7i0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeEwh-0008OG-Ka
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 20:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbXDRSb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 14:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbXDRSb4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 14:31:56 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54277 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1754182AbXDRSbz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 14:31:55 -0400
Received: (qmail 10600 invoked by uid 0); 18 Apr 2007 18:31:54 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 18 Apr 2007 18:31:54 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Julian Phillips <julian@quantumfyre.co.uk>
Content-Disposition: inline
In-Reply-To: <7vlkgph7i0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44926>

On Wed, Apr 18, 2007 at 11:17:43AM -0700, Junio C Hamano wrote:
> Peter Baumann <waste.manager@gmx.de> writes:
> 
> > On Wed, Apr 18, 2007 at 09:23:14AM -0700, Junio C Hamano wrote:
> >> 
> >> Recursively dereferencing the symbolic link by hand to a limit
> >> to avoid infinite recursion (error out when we reach the limit)
> >> would be a more elaborate solution that probably is the right
> >> thing to do.
> >>
> > I thought about the case where packed-refs is a symlink to another symlink
> > and then decided that it's not worth to implement this because a workdir
> > should be linked to a _repo_ and not another workdir.
> 
> That's incredibly weak, as the initial motivation of this patch
> is that you did not want to say "you should run gc only in the
> _repo_ not in workdir".
> 

Yes. That's my motivation and it works right now

	git init a
	<hack, hack, hack,>
	git commit -a

	git-new-workdir a b 	# allowed
	git-new-workdir a c	# allowed

	git-new-workdir b d	# NOT ALLOWED

The user should only create new work dirs which refere to the repo and not
to another workdir.

But *iff* thats the only point for keeping my patch out I'll fix it, but
not tonight. (Leaving now ...)

-Peter
