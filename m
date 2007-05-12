From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: kernel cherry UN-picking?
Date: Sat, 12 May 2007 10:01:17 -0400
Message-ID: <20070512140117.GF12121@delft.aura.cs.cmu.edu>
References: <4644E0A2.90008@garzik.org> <7vhcqj9g8r.fsf@assigned-by-dhcp.cox.net> <7vbqgr9fn9.fsf@assigned-by-dhcp.cox.net> <20070512133951.GE12121@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 12 16:01:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hms9z-0003FH-MD
	for gcvg-git@gmane.org; Sat, 12 May 2007 16:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbXELOBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 10:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbXELOBS
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 10:01:18 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:39997 "EHLO
	delft.aura.cs.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbXELOBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 10:01:18 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.67)
	(envelope-from <jaharkes@cs.cmu.edu>)
	id 1Hms9t-0002At-Ir
	for git@vger.kernel.org; Sat, 12 May 2007 10:01:17 -0400
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070512133951.GE12121@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47047>

On Sat, May 12, 2007 at 09:39:51AM -0400, Jan Harkes wrote:
> On Fri, May 11, 2007 at 03:09:14PM -0700, Junio C Hamano wrote:
> > Suppose you have something like this (you may have more than one
> > such merge but the principle is the same):
> > 
> >   U---o---o---o---M---x---o---o---o---T
> >                  /
> >    Linville o---o
> > 
> > Up to 'U' you have already sent upstream and no need for
> > resending.  'M' is merge with Linville tree.  'x' is the bad
> > one, and 'o' are good ones.  'T' is the tip of your net driver
> > branch.
> 
> There are even more ways to fix this up, they both start with
> identifying the commit 'y' that was committed after 'x',
> 
>     git rebase --onto x^ y T
> 
> The other solution is to use .git/info/grafts,
> 
>     Add a line with the sha1 of 'y' with the parents of 'x'. You can
>     visually inspect with gitk if it looks right and then use a script
>     that rewrites the history. Either cg-admin-rewrite or the one I
>     posted to the list a while ago.
> 
> The history rewriting solution will work even if 'x' was introduced
> before the merge commit.

My brain must be fried. history rewriting is not a good solution here.
Although it removes the commit message, it would leave the bad change
around because it leaves the actual trees intact.

Jan
