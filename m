From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 18:28:29 +0200
Message-ID: <20050417162829.GK1487@pasky.ji.cz>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417162448.A13233@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 18:25:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCaL-0000sj-Qv
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVDQQ2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVDQQ2w
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:28:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62354 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261352AbVDQQ2d (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:28:33 -0400
Received: (qmail 29086 invoked by uid 2001); 17 Apr 2005 16:28:29 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050417162448.A13233@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 05:24:48PM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> However, I've made a start to generate the necessary emails.  How about
> this format?
> 
> I'm not keen on the tree, parent, author and committer objects appearing
> in this - they appear to clutter it up.  What're your thoughts?

I think it would look nicer if you used git log format. Actually...

 
> #!/bin/sh
> prev=$(cat .git/heads/origin)
> to=$(cat .git/HEAD)

It is preferred to use the commit-id command instead; when git decides
to totally dig over its metametadata storage, you won't need to care.

> this=$to
> while [ "$this" != "$prev" ]; do
>   cat-file commit $this | sed 's,.*,\t&,'
>   this=$(cat-file commit $this | grep ^parent | cut -d ' ' -f 2)
> done

What about adding support to git log for not caring about side branches
(if there are multiple parents, go only over the first one; you might
add that as a switch to rev-tree, which would turn it to rev-line ;-)?

Then, you could also easily implement support for passing additional
commit ID to git log, and it would then print out the range between
these two.

That would do exactly what you want, and would be probably quite usable
for other uses too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
