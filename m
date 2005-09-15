From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][PATCH] Rewriting revs in place in push target repository
Date: Thu, 15 Sep 2005 19:16:41 +0200
Message-ID: <20050915171641.GA23259@pasky.or.cz>
References: <20050813214725.GM5608@pasky.ji.cz> <7vwtmpjq17.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 19:19:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFxLr-0000cC-8u
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 19:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbVIORQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 13:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbVIORQo
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 13:16:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40321 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030543AbVIORQn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 13:16:43 -0400
Received: (qmail 28956 invoked by uid 2001); 15 Sep 2005 19:16:41 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtmpjq17.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8617>

Dear diary, on Sun, Aug 14, 2005 at 02:55:16AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Rewrite refs in place in receive-pack & friends
> >
> > When updating a ref, it would write a new file with the new ref and
> > then rename it, overwriting the original file. The problem is that
> > this destroys permissions and ownership of the original file, which is
> > troublesome especially in multiuser environment, like the one I live in.
> 
> Hmph.  If a repo is _really_ used multiuser then you should not
> have to care about ownership.  If you can write into a
> repository for a project (implying that you are a member of that
> project group), and if your umask is set up correctly (meaning
> it is 002 or looser), and with g+s bit on the directory at the
> repository root level when it was created, shouldn't your newly
> created ref file be also writable by others in that project?

Hmm, but how do you actually set the umask correctly just for git
pushing? I'm sorry but it doesn't occur to me.

I like Linus' solution, but have no time to do the patch now, so I did
just a quick dirty fix and added a chmod to hooks/update. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
