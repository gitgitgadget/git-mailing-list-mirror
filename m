From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] Clean up work-tree handling
Date: Fri, 27 Jul 2007 20:32:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707272029140.14781@racer.site>
References: <Pine.LNX.4.64.0707260729150.14781@racer.site>
 <20070726220949.GA4420@moooo.ath.cx> <Pine.LNX.4.64.0707271146290.14781@racer.site>
 <7v8x911wn6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVYN-0001Wf-9p
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763339AbXG0Tcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763192AbXG0Tcl
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:32:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:59181 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762757AbXG0Tch (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:32:37 -0400
Received: (qmail invoked by alias); 27 Jul 2007 19:32:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 27 Jul 2007 21:32:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18N78Y7jj4Ne45fTQTVEvwhV83wFEzCXj6lcztXOL
	PIK/iYW6haRtBi
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x911wn6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53955>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > But there is a fundamental question I have to ask: Is there any reason why 
> >
> > 	$ git --git-dir=/some/where/else.git bla
> >
> > should pretend that the repo is bare if core.bare == 1?  I mean, we are 
> > implicitely setting the work tree to the cwd, no?
> 
> I have two repositories at the primary k.org machine.
> 
>  - /home/junio/git.git --- this is with a worktree so that I can
>    build and test on a FC machine (my primary development
>    machine at home is a Debian).
> 
>  - /pub/scm/git/git.git/ --- this is a bare repository that is
>    mirrored out to git://git.kernel.org/ and friends.
> 
> And I usually am in the former.  From time to time, I do this:
> 
>  $ GIT_DIR=/pub/scm/git/git.git/ git fsck
>  $ GIT_DIR=/pub/scm/git/git.git/ git repack
> 
> because I am old fashioned, but I would expect these to be
> equivalent to the above:
> 
>  $ git --git-dir=/pub/scm/git/git.git/ fsck
>  $ git --git-dir=/pub/scm/git/git.git/ repack
> 
> I do not think these imply that the repository is with worktree.

But in your use cases it does not matter, since neither fsck nor repack 
need a worktree.

Here is one of _my_ scenarios: I want to track a directory I have no write 
access to (or better put: I should have no write access to).  So I created 
a bare repository, and when I add new files I use the "GIT_DIR=... git..." 
mantra.

But you're right, I could just set core.worktree=... and unset core.bare.

I can change that easily enough.  Other comments on the series?

Ciao,
Dscho
