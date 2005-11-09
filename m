From: Petr Baudis <pasky@suse.cz>
Subject: Re: Expected Behavior?
Date: Wed, 9 Nov 2005 12:24:52 +0100
Message-ID: <20051109112452.GD30496@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jon Loeliger <jdl@freescale.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 12:26:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZo4Y-0005xk-8M
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 12:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVKILYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 06:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVKILYz
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 06:24:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:51361 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751373AbVKILYz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 06:24:55 -0500
Received: (qmail 7241 invoked by uid 2001); 9 Nov 2005 12:24:52 +0100
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20051108210332.GB23265@c165.ib.student.liu.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11396>

Dear diary, on Tue, Nov 08, 2005 at 10:03:32PM CET, I got a letter
where Fredrik Kuivinen <freku045@student.liu.se> said that...
> On Mon, Nov 07, 2005 at 10:00:11PM -0800, Junio C Hamano wrote:
> > Jon Loeliger <jdl@freescale.com> writes:
> > 
> > > That is, after the merge, file3 appears to have simply kept
> > > the contents of the current, master branch.  Why wasn't the
> > > dev branch represented here?
> > >
> > > I _almost_ think I get it, and then *poof*...
> > 
> > Automerge completely punted for this path, and at this point, it
> > is still unmerged:
> > 
> > ------------
> > $ git ls-files --unmerged
> > 100644 c4da0eb.... 2       file3
> > 100644 fbc2aa4.... 3       file3
> > ------------
> > 
> > Three-way "git-read-tree -m -u O A B" (O is for old, A is ours
> > and B is hers) puts O in stage1, A in stage2 and B in stage3.
> > This path did not exist in O so we only have them in stage2 and
> > stage3.  You could compare the stages like this:
> > 
> 
> Jon: You could try to this merge with the recursive merge strategy
> (git merge -s recursive 'merge message' master dev) If you do, you
> _should_ get something like:
> 
>     CONFLICT (add/add): File file3 added non-identically in both
>     branches. Adding as file3_master and file3_dev instead.
> 
> You will then end up with file3_master and file3_dev in your working
> tree, which corresponds to file3 in the master branch and file3 in the
> dev branch, respectively.

The world would be so much better if there would be just a _single_
per-file automerger instead of three right now...

I'm planning to feed back the automerger stuff from Cogito to GIT like I
already did once, but it's not a priority right now so it may take some
time (unless someone else does it, which is something I certainly
wouldn't oppose).

But in the longer term even the recursive merge should use the same one,
so either we should enhance the shell one to handle all the cases, or
split out the python per-file automerger from recursive merge and make
it possible to use this one separately. This is probably more viable
option in the longer term, even though I personally don't grok python
very well - whatever, at least I'll have to get better. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
