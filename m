From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 14 May 2005 17:02:00 +0200
Message-ID: <20050514150200.GJ3905@pasky.ji.cz>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org> <20050513224529.GF32232@pasky.ji.cz> <7vhdh691gs.fsf@assigned-by-dhcp.cox.net> <20050513233354.GK32232@pasky.ji.cz> <7vmzqy7k47.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 17:02:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWy9f-0002bF-J2
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVENPCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVENPCK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:02:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64409 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262776AbVENPCB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 11:02:01 -0400
Received: (qmail 9440 invoked by uid 2001); 14 May 2005 15:02:00 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzqy7k47.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 01:59:36AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> Dear diary, on Sat, May 14, 2005 at 12:59:31AM CEST, I got a letter
> PB> where Junio C Hamano <junkio@cox.net> told me that...
> >> Created: t/t2000-diff.sh (mode:100755)
> >> +Mode changed: path0 (100644->100755)
> 
> PB> Great, so it's even worse than before. :/
> 
> Depends on the definition of "before".  At the beginning, we did
> not do anything special and always said l/foo k/foo even when
> create/delete was involved.  Then we did a misguided attempt to
> minimally be cg-diff compatible, which Linus complained that it
> was too distracting for human consumption.  The current one is
> something in between, a lot more human side.

By "before" I meant the Linus proposal I was originally replying too.
It seems I'm still missing part of the history. :-)

> You have seen what the current "something in between" does.
> What I think is that in order not to distract human (read:
> Linus) who reads patches, they should not share the same special
> characters like "@".  Which unfortunately completely contradicts
> what you are attempting to do.

I don't think it discards humans, actually. I'd rather say it makes them
aware that this is something special. And if you show it only when the
mode changes, it will always be a special thing, not only something
which clutters the view.

So I'd say it's better for humans too, since it is clear for them that
this is not part of the commit message, and it carries special meaning
for the tool they will feed it to.

> Another thing we did while you were looking other way ;-) was that we
> say mode changed only when things change, so in that sense it is
> "inconsistent" from the scripting point of view.

I have no issue with that.

> I do not think nobody uses that current textual "comment"
> information in automated tools (I do not), so changing them
> should not be a problem.  How about we do something like this:
> 
>   1. Invent an environment variable you can define.  Let's say
>      GIT_DIFF_SHOW_MODES.  It could alternatively a flag you
>      pass from git-diff-{files,cache,tree,tree-helper} to the
>      internal diff engine but then you need to add the necessary
>      command line parameter for all these commands.  I can be
>      persuaded in either way.

I think this completely misses the point. You are viewing what I'm
suggesting as trying to just aid Cogito's internals using cg-diff |
cg-patch, but that's actually not my major reason for doing this at all.
I view that as a hack anyway and it should eventually do a three-way
merge too at those places.

What I'm trying to do is to figure out a good encapsulation for mode
changes which can be put in *all* the patches. So when you are sending
me some new testcases, I don't have to chmod them manually. That's the
main point of doing this. I could deal with mode changes completely
separately if it was only about Cogito's internal stuff.

> BTW, what do you think about renaming git-diff-tree-helper to
> just git-diff-helper?  It used to be for grokking diff-tree's
> output but now the family have the same raw output format it
> does not make much sense to keep "tree" in its name.

No issue with that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
