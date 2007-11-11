From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-branch silently ignores --track on local branches
Date: Sun, 11 Nov 2007 19:23:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111919170.4362@racer.site>
References: <20071110174557.GC1036@blorf.net> <7vfxzelz5b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wayne Davison <wayne@opencoder.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:24:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIQ0-0003j8-8o
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbXKKTXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 14:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755874AbXKKTXx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:23:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:41992 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755873AbXKKTXw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:23:52 -0500
Received: (qmail invoked by alias); 11 Nov 2007 19:23:50 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 11 Nov 2007 20:23:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LN0Qi3emLA2PmaGPHQmOBjJ3amrrY2fYJ3NoFG+
	NoVU6046d6menx
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfxzelz5b.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64495>

Hi,

On Sat, 10 Nov 2007, Junio C Hamano wrote:

> Wayne Davison <wayne@opencoder.net> writes:
> 
> > ...  Is there
> > a problem with local branches being supported when explicitly
> > requested?
> 
> Maybe this one?
> 
> commit 6f084a56fcb3543d88d252bb49c1d2bbf2bd0cf3
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Tue Jul 10 18:50:44 2007 +0100
> 
>     branch --track: code cleanup and saner handling of local branches
>     
>     This patch cleans up some complicated code, and replaces it with a
>     cleaner version, using code from remote.[ch], which got extended a
>     little in the process.  This also enables us to fix two cases:
>     
>     The earlier "fix" to setup tracking only when the original ref started
>     with "refs/remotes" is wrong.  You are absolutely allowed to use a
>     separate layout for your tracking branches.  The correct fix, of course,
>     is to set up tracking information only when there is a matching
>     remote.<nick>.fetch line containing a colon.
>     
>     Another corner case was not handled properly.  If two remotes write to
>     the original ref, just warn the user and do not set up tracking.
>     
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> As a local branch does not have to be "fetched", the restriction
> on "remote.<nick>.fetch" is sort of pointless.

IIRC it was you, Junio, who complained first that the local branches have 
tracking set up.

> Also why remote.<nick>.fetch needs a colon, I begin to wonder. You can 
> be keep fetching and merging from the same branch of the same remote 
> without keeping a remote tracking branch for that, but the above 
> "correct fix" forbids that.

The point here was to find out what to track when we do a "git branch 
--track <name> <origname>".  So we definitely only want to find those 
remotes that fetch to a certain tracking branch.

Sure, you can set up branch.<x>.merge to a branch that is not tracked.  
But git cannot find out which one it is in the command "branch".

> Dscho, what were we smoking when we made this change?

Dude, I, uh, I think I, uh, don't remember.  Peace.

Ciao,
Dscho
