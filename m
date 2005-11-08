From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Expected Behavior?
Date: Tue, 8 Nov 2005 22:03:32 +0100
Message-ID: <20051108210332.GB23265@c165.ib.student.liu.se>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 22:05:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZacy-0002E3-DC
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 22:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVKHVDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 16:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbVKHVDe
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 16:03:34 -0500
Received: from [85.8.31.11] ([85.8.31.11]:38031 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030270AbVKHVDd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 16:03:33 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A6E454102; Tue,  8 Nov 2005 22:11:55 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EZacu-00065Z-00; Tue, 08 Nov 2005 22:03:32 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11356>

On Mon, Nov 07, 2005 at 10:00:11PM -0800, Junio C Hamano wrote:
> Jon Loeliger <jdl@freescale.com> writes:
> 
> > That is, after the merge, file3 appears to have simply kept
> > the contents of the current, master branch.  Why wasn't the
> > dev branch represented here?
> >
> > I _almost_ think I get it, and then *poof*...
> 
> Automerge completely punted for this path, and at this point, it
> is still unmerged:
> 
> ------------
> $ git ls-files --unmerged
> 100644 c4da0eb.... 2       file3
> 100644 fbc2aa4.... 3       file3
> ------------
> 
> Three-way "git-read-tree -m -u O A B" (O is for old, A is ours
> and B is hers) puts O in stage1, A in stage2 and B in stage3.
> This path did not exist in O so we only have them in stage2 and
> stage3.  You could compare the stages like this:
> 

Jon: You could try to this merge with the recursive merge strategy
(git merge -s recursive 'merge message' master dev) If you do, you
_should_ get something like:

    CONFLICT (add/add): File file3 added non-identically in both
    branches. Adding as file3_master and file3_dev instead.

You will then end up with file3_master and file3_dev in your working
tree, which corresponds to file3 in the master branch and file3 in the
dev branch, respectively.


- Fredrik
