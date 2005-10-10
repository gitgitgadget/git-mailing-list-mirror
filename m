From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Seeing various mode changes on cygwin
Date: Mon, 10 Oct 2005 13:59:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510101354520.23242@iabervon.org>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
 <20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org> <Pine.LNX.4.63.0510100220330.23242@iabervon.org>
 <7vu0fpbz43.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 19:56:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP1rP-0000uG-6s
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 19:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVJJRys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 13:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVJJRys
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 13:54:48 -0400
Received: from iabervon.org ([66.92.72.58]:40454 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751097AbVJJRys (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 13:54:48 -0400
Received: (qmail 30984 invoked by uid 1000); 10 Oct 2005 13:59:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Oct 2005 13:59:40 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0fpbz43.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9901>

On Mon, 10 Oct 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Perhaps have a bit in the index mode for the file to say that the mode in 
> > the filesystem is unreliable, which gets set if a stat of the 
> > newly-written file doesn't match the mode it was supposed to have, or if 
> > git chmod is used to change it; then, if the bit is set, ignore the mode 
> > in the filesystem and just use the mode in the index.
> 
> In effect, you are making the "per-repo configuration" Linus
> mentioned a non configuration but a property recorded in the
> index file.  I think this is a clever solution which is very
> helpful to the end user.  I have to think about this a bit, but
> my gut feeling tells me that it is the right direction if it
> works.
> 
> I do not think you have to necessarily record it in the "index
> mode" -- which implies this is per path -- nor even in the index
> file itself.  We might even be able to get away with doing this
> check at git-init-db time just once, and record it in a file,
> say ".git/fs-mode-unreliable".

Actually, you're right; it is information about the behavior of the 
working tree, and is also needed if you want to compare the working tree 
against a tree object, in which case you aren't using the index at all.

	-Daniel
*This .sig left intentionally blank*
