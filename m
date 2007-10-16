From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 09:16:12 -0400
Message-ID: <E1IhmHM-0002hB-HR@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <Pine.LNX.4.64.0710160032020.7638@iabervon.org> <E1IhgT2-0000bg-O6@fencepost.gnu.org> <Pine.LNX.4.64.0710161335260.25221@racer.site>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: barkalow@iabervon.org, raa.lkml@gmail.com, ae@op5.se,
	tsuna@lrde.epita.fr, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmHb-0004JZ-VZ
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbXJPNQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756466AbXJPNQO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:16:14 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60292 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbXJPNQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:16:13 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1IhmHM-0002hB-HR; Tue, 16 Oct 2007 09:16:12 -0400
In-reply-to: <Pine.LNX.4.64.0710161335260.25221@racer.site> (message from
	Johannes Schindelin on Tue, 16 Oct 2007 13:39:12 +0100 (BST))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61166>

> Date: Tue, 16 Oct 2007 13:39:12 +0100 (BST)
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> cc: Daniel Barkalow <barkalow@iabervon.org>, raa.lkml@gmail.com, ae@op5.se, 
>     tsuna@lrde.epita.fr, git@vger.kernel.org
> 
> > As I wrote in my other message, using native APIs improves performance 
> > by at least a factor of two.
> 
> Somehow this does not appeal to my "portability is good" side.  You know, 
> if we had to do such trickeries for every platform we support, we'd soon 
> be as big as Subversion *cough*.

You have to decide whether you care about performance enough to do
that or not.  If you do, then introducing file I/O abstractions at
higher level than the normal ``use-library-functions'' method is not
such a hard problem, and doesn't make the binary larger because each
platform gets only its own backend.  In practice, I have found that in
most cases a few well-designed and strategically placed macros is all
you need.

> For me, this is the most annoying part about programming Win32.  They went 
> out of their way to make it incompatible with everything else, and as a 
> consequence it is a PITA to maintain crossplatform programs.

Portability is a two-way street.  A program that wasn't designed to be
portable will by definition be hard to port.  To me, what's annoying
is a program that was designed around a single-OS model of APIs.

Cross-platform programs are not that hard if you design them to be
like that from the ground up.  I'm working for a firm that does that
for a living: we develop software that compiles and runs on Windows
and Linux from the same source.

> Explorer often accesses files it should not lock.  
> On the machine I test msysGit on, this is the most common reason for a 
> test case to fail: it cannot delete the temporary directory, which 
> _should_ be unused.  Indeed, a second after that, it _is_ unused.

One more reason not to launch Explorer, if you ask me ;-)  But maybe
you have valid reasons to do that.  All I can say is that I never saw
such problems, but then I don't usually run programs that rewrite
files in a frenzy.
