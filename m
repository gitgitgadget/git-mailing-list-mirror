From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Strange behavior of gitweb
Date: Fri, 27 Nov 2009 12:29:53 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911271221460.30903-100000@netrider.rowland.org>
References: <m24oogyh2o.fsf@igel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 18:30:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE4ds-0005Oj-V1
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 18:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbZK0R3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 12:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbZK0R3t
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 12:29:49 -0500
Received: from netrider.rowland.org ([192.131.102.5]:52999 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751422AbZK0R3s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 12:29:48 -0500
Received: (qmail 31574 invoked by uid 500); 27 Nov 2009 12:29:53 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Nov 2009 12:29:53 -0500
X-X-Sender: stern@netrider.rowland.org
In-Reply-To: <m24oogyh2o.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133910>

On Fri, 27 Nov 2009, Andreas Schwab wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > I recently ran across this strange behavior in the gitweb server at 
> > git.kernel.org.  The following URL:
> >
> > http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.27.y.git;a=commit;h=2d93148ab6988cad872e65d694c95e8944e1b62
> >
> > brings up a page containing commit 2d93148[...].  But that commit isn't
> > part of the 2.6.27.y tree!  It belongs to Linus's main tree, and it was
> > added long after 2.6.27.y was forked off.  The actual commit applied to
> > 2.6.27.y was 070bb0f3b6df167554f0ecdeb17a5bcdb1cd7b83.
> >
> > So what's going on here?
> 
> Nothing mysterious.  Every tree on kernel.org borrows from Linus' main
> tree via .git/objects/info/alternates, thus includes its whole object
> database by reference.

Hmm.  That's all fine, but it can produce very misleading results like
the one above.  I can imagine the same sort of thing happening in other
situations not involving alternates (e.g., orphaned commits).

Is there any way the web software can check whether the commit it found
is actually an ancestor of the tip node in the requested tree, and if
not add a big warning near the top of the page?

Alan Stern
