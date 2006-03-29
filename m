From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull fails
Date: Wed, 29 Mar 2006 02:24:15 +0200
Message-ID: <20060329002415.GG27689@pasky.or.cz>
References: <20060328162831.af1bd4c0.tihirvon@gmail.com> <20060328141140.GC3113@linux-mips.org> <20060328173827.3d64d91e.tihirvon@gmail.com> <200603281700.17233.astralstorm@o2.pl> <20060328224807.GC27689@pasky.or.cz> <20060329031136.e0389c00.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: astralstorm@o2.pl, git@vger.kernel.org, ralf@linux-mips.org
X-From: git-owner@vger.kernel.org Wed Mar 29 02:24:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOOTw-0004iA-Q9
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 02:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWC2AYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWC2AYN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 19:24:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60640 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964879AbWC2AYM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 19:24:12 -0500
Received: (qmail 7553 invoked by uid 2001); 29 Mar 2006 02:24:15 +0200
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060329031136.e0389c00.tihirvon@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18149>

Dear diary, on Wed, Mar 29, 2006 at 02:11:36AM CEST, I got a letter
where Timo Hirvonen <tihirvon@gmail.com> said that...
> Exactly.  Maybe git-fetch should abort only if it could not update the
> currently checked out branch?

That should _never_ be the case. Any modern porcelain shouldn't let you
switch your current branch to a remote one, hopefully. It's just wrong.
The supported setup is that you have a remote branch reflecting where
the upstream is and a local branch reflecting where your current tree
is, and you update your local branch by git-pull (or git-merge if you
want to avoid fetching).

If your current branch would really be a remote branch and you simply
git-fetched, your HEAD would change but not your working tree, and at
that moment things would become very confusing. Cogito would start
showing nonsensical stuff for cg-status and cg-diff (as well as
git-diff-tree HEAD output), but your index would at least still be
correct so I'm not sure how much attention do tools like git-diff pay to
it, the level of messup would be proportional to that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
