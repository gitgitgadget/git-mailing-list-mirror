From: Petr Baudis <pasky@suse.cz>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Mon, 26 Sep 2005 21:10:37 +0200
Message-ID: <20050926191037.GD26340@pasky.or.cz>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net> <87psqwzs3x.fsf@ualberta.net> <7v7jd4n22i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 21:12:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJyOV-0008Ay-Hm
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 21:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVIZTKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 15:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVIZTKk
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 15:10:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62924 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932481AbVIZTKj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 15:10:39 -0400
Received: (qmail 1993 invoked by uid 2001); 26 Sep 2005 21:10:37 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jd4n22i.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9322>

Dear diary, on Mon, Sep 26, 2005 at 01:46:13AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Tom Prince <tom.prince@ualberta.net> writes:
> 
> >> When you already have a repository to track git.git, I would
> >> recommend to have something like this in .git/remote/origin:
> >>
> >>     URL: http://kernel.org/pub/scm/git/git.git
> >>     Pull: master:origin maint:maint +pu:pu
> >>
> >
> > A warning when you do this. If you say 
> >
> >   git pull origin
> >
> > then your master will be updated with an octopus merge of the three heads.
> 
> Ahhhhhhhh.  That is true.  I always do "git fetch" and never do
> "git pull" against anything but a local repository, heads
> explicitly specified.  You are right.  The defaulting behaviour
> is incredibly broken.
> 
> Do people agree it is a good idea to change the "git pull
> origin" to mean "fetch all the default refs specified on Pull:
> lines, and merge only the first one into the current branch"?

I don't like that, the notion that you are fetching different stuff that
you are merging then seems quite confusing to me. But fetching just the
first revision will be confusing too. Either way, git-pull won't be
equivalent to git-fetch && git-merge (or git-resolve or whatever is the
core porcelain command) anymore. Well, the remotes stuff never got close
to my heart.

One alternative I can think of is, in case there are multiple heads,
require the user to explicitly specify the head he wants (origin#maint).
This comes from the idea that multi-head remotes are there really
primarily for fetching, not for pulling. There is also no potential for
confusion. In addition, there might another line "Default" in the remote
file, which could specify the default choice. It's just that choosing
the first one implicitly makes me a bit nervous and has potential for
bad mistakes. At least for Cogito, I would be reluctant to use it.

git-pull --merge-all or something to still do the octopus merge might be
useful in some cases (or as well might not - perhaps the best strategy
is to let whoever cares make a patch ;).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
