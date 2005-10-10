From: Junio C Hamano <junkio@cox.net>
Subject: Re: Seeing various mode changes on cygwin
Date: Mon, 10 Oct 2005 00:38:36 -0700
Message-ID: <7vu0fpbz43.fsf@assigned-by-dhcp.cox.net>
References: <20051008180023.GC28875@diku.dk>
	<7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
	<20051008213612.GA5794@steel.home>
	<7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510081909250.31407@g5.osdl.org>
	<Pine.LNX.4.63.0510100220330.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 09:40:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOsFQ-0004dt-9w
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 09:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVJJHio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 03:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVJJHio
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 03:38:44 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46065 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932350AbVJJHin (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 03:38:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010073833.HXAV9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 03:38:33 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510100220330.23242@iabervon.org> (Daniel
	Barkalow's message of "Mon, 10 Oct 2005 02:48:18 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9876>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Perhaps have a bit in the index mode for the file to say that the mode in 
> the filesystem is unreliable, which gets set if a stat of the 
> newly-written file doesn't match the mode it was supposed to have, or if 
> git chmod is used to change it; then, if the bit is set, ignore the mode 
> in the filesystem and just use the mode in the index.

In effect, you are making the "per-repo configuration" Linus
mentioned a non configuration but a property recorded in the
index file.  I think this is a clever solution which is very
helpful to the end user.  I have to think about this a bit, but
my gut feeling tells me that it is the right direction if it
works.

I do not think you have to necessarily record it in the "index
mode" -- which implies this is per path -- nor even in the index
file itself.  We might even be able to get away with doing this
check at git-init-db time just once, and record it in a file,
say ".git/fs-mode-unreliable".
