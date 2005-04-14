From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 22:20:16 +0200
Message-ID: <20050414202016.GC22699@pasky.ji.cz>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 22:18:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMAmY-0007YW-P5
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 22:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVDNUU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 16:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVDNUU7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 16:20:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49354 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261499AbVDNUUV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 16:20:21 -0400
Received: (qmail 32270 invoked by uid 2001); 14 Apr 2005 20:20:16 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 09:59:04PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> On Thu, 14 Apr 2005, Junio C Hamano wrote:
> 
> >> Sorry, I have not seen what you have been doing since pasky 0.3,
> >> and I have not even started to understand the mental model of
> >> the world your tool is building.  That said, my gut feeling is
> >> that telling this script about git-pasky's world model might be
> >> a mistake.  I'd rather see you consider the script as mere "part
> >> of the plumbing". 
> 
> LT> I agree. Having separate abstraction layers is good.  I'm actually very 
> LT> happy with Pasky's cleaned-up-tree, exactly because unlike the first one, 

(Just a side-note - functionally and even organizationally, the cleaned
up tree does not differ significantly from the original one.)

> LT> Pasky did a great job of maintaining the abstraction between "plumbing" 
> LT> and user interfaces.
> 
> Agreed, not just with your agreeing with me, but with the
> statement that Pasky did a good job (although I am ashamed to
> say I have not caught up with the "userland" tools).

Thanks. :-)

> LT> The plumbing should take user interface needs into account, but the more
> LT> conceptually separate it is ("does it makes sense on its own?") the better
> LT> off we'll be. And "merge these two trees" (which works on a _tree_ level)
> LT> or "find the common commit" (which works on a _commit_ level) look like 
> LT> plumbing to me - the kind of things I should have written, if I weren't 
> LT> such a lazy slob.
> 
> I am planning drop the ancestor computation from the script, and
> make it another command line parameter to the script.  Dan
> Barkalow's merge-base program should be used to compute it and
> his result should drive the merge.  That sounds more UNIXy to
> me.

Good move, I say!

> I even may want to make the script take three trees not
> commits, since the merge script does not need commits (it only
> needs trees).  As plumbing it would be cleaner interface to it
> to do so.  The wrapper SCM scripts can and should make sure it
> is fed trees when the user gives it commits (or symbolic
> representation of it like .git/tags/blah, or `cat .git/HEAD`).

Agreed.

> But one different thing to note here.
> 
> You say "merge these two trees" above (I take it that you mean
> "merge these two trees, taking account of this tree as their
> common ancestor", so actually you are dealing with three trees),
> and I am tending to agree with the notion of merging trees not
> commits.  However you might get richer context and more sensible
> resulting merge if you say "merge these two commits".  Since
> commit chaining is part of the fundamental git object model you
> may as well use it.

Could you be more particular on the richer context etc?

I think this script should stay strictly on the level of trees. When
someone invents it, there could be a merge-commits script which does
something very smart about two commits, traversing the graph between
them etc, and doing a set of merge-tree invocations, possibly preparing
the staging area for them etc.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
