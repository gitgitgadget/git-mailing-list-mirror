From: Petr Baudis <pasky@suse.cz>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Tue, 12 Jul 2005 09:48:01 +0200
Message-ID: <20050712074801.GD6363@pasky.ji.cz>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org> <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org> <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org> <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org> <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 09:48:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsFV0-00009y-6O
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 09:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVGLHsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 03:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVGLHsF
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 03:48:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44182 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261242AbVGLHsD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 03:48:03 -0400
Received: (qmail 9586 invoked by uid 2001); 12 Jul 2005 07:48:01 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jul 12, 2005 at 06:34:33AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Mon, 11 Jul 2005, Linus Torvalds wrote:
> > 
> >     Of course, if you want to create a new branch "my-branch" and _not_
> >     check it out, you could have done so with just
> > 
> >         git-rev-parse v2.6.12^0 > .git/refs/heads/my-branch
> > 
> >     which I think I will codify as "git branch".
> 
> And now we have that "git branch". It's a trivial one-liner, except with
> the setup and error checking it's actually more like six lines.

Could we please have the branch name written to .git/head-name in case
we switch the branch? The reason is that .git/HEAD may not be always a
symlink. Specifically, I do this - there's a command cg-seek, which will
seek your working tree to a given commit, while staying on the branch
(committing and some other operations are blocked). In that case, I
remove .git/HEAD and replace it with ID of the commit I'm seeked at, and
when I'm "unseeking" back to the top, I replace it with the symlink
again. With some heuristics, I could create .git/head-name at the time
of seek and hope, but I think it'd be cleaner to just always set it
(except when we are on the master branch), if you agree.

Note that even though Cogito won't let you create/change a local branch
yet, it will understand .git/head-name and hopefully behave properly
(although it's totally untested, of course).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
