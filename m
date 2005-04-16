From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re: Re: write-tree is pasky-0.4
Date: Sat, 16 Apr 2005 17:34:01 +0200
Message-ID: <20050416153401.GD19099@pasky.ji.cz>
References: <20050414223039.GB28082@64m.dyndns.org> <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org> <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org> <20050415185624.GB7417@pasky.ji.cz> <Pine.LNX.4.58.0504151212160.7211@ppc970.osdl.org> <20050415223648.GP7417@pasky.ji.cz> <Pine.LNX.4.58.0504151709180.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 17:31:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMpFm-0005A5-Vc
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 17:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVDPPeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 11:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVDPPeM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 11:34:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14720 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262684AbVDPPeD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 11:34:03 -0400
Received: (qmail 27491 invoked by uid 2001); 16 Apr 2005 15:34:01 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504151709180.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 02:22:45AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Sat, 16 Apr 2005, Petr Baudis wrote:
> > 
> > But otherwise it is great news to me. Actually, in that case, is it
> > worth renaming it to Cogito and using cg to invoke it? Wouldn't be that
> > actually more confusing after it gets merged? IOW, should I stick to
> > "git" or feel free to rename it to "cg"?
> 
> I'm perfectly happy for it to stay as "git", and in general I don't have
> any huge preferences either way. You guys can discuss names as much as you
> like, it's the "tracking renames" and "how to merge" things that worry me.

:-)

> I think I've explained my name tracking worries.  When it comes to "how to 
> merge", there's three issues:
> 
>  - we do commonly have merge clashes where both trees have applied the 
>    exact same patch. That should merge perfectly well using the 3-way
>    merge from a common parent that Junio has, but not your current "bring
>    patches forward" kind of strategy.

My current "bring patches forward" strategy is only very interim, to
have something working well enough for me to merge with you. I will
gladly change it to use merge-tree*, when it is done. (Or read-tree -m -
I will yet have to have a look, but it looks extremely promising.)

>  - I _do_ actually sometimes merge with dirty state in my working 
>    directory, which is why I want the merge to take place in a separate 
>    (and temporary) directory, which allows for a failed merge without 
>    having any major cleanup. If the merge fails, it's not a big deal, and 
>    I can just blow the merge directory away without losing the work I had 
>    in my "real" working directory.

Ok. But still, especially when you do some nontrivial conflicts
resolving, how do you check if it even compiles after the merge? Or do
you just commit it and possibly fix the compilation in another commit?

>  - reliability. I care much less for "clever" than I care for "guaranteed 
>    to never do the wrong thing". If I have to fix up some stuff by hand, 
>    I'll happily do so. But if I can't trust the merge and have to _check_ 
>    things by hand afterwards, that will make me leery of the merges, and
>    _that_ is bad.
> 
> The third point is why I'm going to the ultra-conservative "three-way 
> merge from the common parent". It's not fancy, but it's something I feel 
> comfortable with as a merge strategy. For example, arch (and in particular 
> darcs) seems to want to try to be "clever" about the merges, and I'd 
> always live in fear. 

I agree and I would like to achieve the same. I too think the three-way
merge from the common parent is the best way to go for now.

> And, finally, there's obviously performance. I _think_ a normal merge with
> nary a conflict and just a few tens of files changed should be possible in
> a second. I realize that sounds crazy to some people, but I think it's
> entirely doable. Half of that is writing the new tree out (that is a
> relative costly op due to the compression). The other half is the "work".

Being written in shell, there is plenty of space for optimization - from
using bash internals instead of textutils to rewriting parts of it in C.
My priority now is to get it right first, though. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
