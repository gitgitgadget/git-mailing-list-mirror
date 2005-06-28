From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Cogito vs. Git (was: Mercurial vs Updated git HOWTO for kernel hackers)
Date: Tue, 28 Jun 2005 22:54:22 +0200
Message-ID: <20050628205422.GI1275@pasky.ji.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624130604.GK17715@g5.random> <42BC112C.1040009@qualitycode.com> <20050628150752.GC1275@pasky.ji.cz> <42C1800C.7040506@qualitycode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 22:53:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnN3y-0000th-76
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 22:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVF1U6G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 16:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVF1U4K
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 16:56:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59045 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261668AbVF1Uy0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 16:54:26 -0400
Received: (qmail 31031 invoked by uid 2001); 28 Jun 2005 20:54:22 -0000
To: Kevin Smith <yarcs@qualitycode.com>
Content-Disposition: inline
In-Reply-To: <42C1800C.7040506@qualitycode.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jun 28, 2005 at 06:51:24PM CEST, I got a letter
where Kevin Smith <yarcs@qualitycode.com> told me that...
> Petr Baudis wrote:
> >Cogito's only unusual requirement (well, expectation) is that HEAD is a
> >symlink to .git/refs/heads/master, and .git/refs/heads/master should
> >reflect your current head. I will try to ease up this restriction so
> >that things will mostly work even if you just have HEAD. I think that
> >most auxiliary commands (e.g. cg-log - you just have to love it) should
> >work on any sensible git tree (but I didn't test it - yet).
> 
> So you're saying that aside from that one solveable issue, I could use 
> low-level git tools, third-party over-git tools, and cogito, 
> interchangebly on a single repo without the tools becoming confused? 

Yes, given that you use the toolset "atomically" - if you start doing
some large-scale operation using one tool, you should finish it using
the same tool. That is, if you start merging by Cogito and then try to
commit by Linus' git plumbing, it won't work (and vice versa). cg-seek
combined with third-party over-git tools might have unknown consequences
as well.

> That's cool, and should be made more clear in the cogito readme. I was 
> under the impression that cogito was tracking all kinds of extra meta 
> magic stuff that git tools wouldn't keep updated.

It is tracking only seeks and merges in way the git tools wouldn't keep
updated. I will try to actually make it use ~/.git/MERGE_HEAD instead of
~/.git/merging as well, to make people's live even easier.

> If I were using cogito, I probably wouldn't want to use the low-level 
> git stuff directly, but I might want to use (or maybe even write) some 
> other over-git tools.
> 
> You might also consider removing the "Core GIT" section from the README, 
> because I think it increases the confusion between the two.

I might consider throwing away Git from Cogito distribution altogether,
but that would require Git to have some actual release cycle. ;-)

FYI, I will merge the pile of queued Cogito
patches during the weekend and next week, preparing 0.11.4 or 0.12
(depends on how I feel about it). I will also merge the Linus' stuff,
but only up to:

7323aa11af1527d5a786d93ee34401c72c5df051
	Jan Harkes  2005-06-25 13:41
	[PATCH] git-write-tree doesn't check alternate directories

The next patch is

c323ac7d9c573c5ee8b45b9b9def92a4d4d8204d
	Linus Torvalds  2005-06-25 14:42
	git-pack-objects: create a packed object representation

and I'm not sure if I'm ready to already take the packed stuff; I will
see how tested it gets (and if fsck will get taught about it etc). If it
won't be ready by the time I'm ready for the release, I will merge the
rest right after the release.


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
