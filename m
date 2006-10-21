From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 16:46:29 -0500
Message-ID: <20061021214629.GO75501@over-yonder.net>
References: <45357CC3.4040507@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org> <20061021130111.GL75501@over-yonder.net> <200610211608.18895.jnareb@gmail.com> <20061021181149.GM75501@over-yonder.net> <20061021191949.GA8096@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 23:47:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbOfu-00069Q-2I
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 23:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWJUVqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 17:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWJUVqc
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 17:46:32 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:27115 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1161089AbWJUVqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 17:46:31 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 736C62842F;
	Sat, 21 Oct 2006 16:46:30 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id DCB5661C57; Sat, 21 Oct 2006 16:46:29 -0500 (CDT)
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20061021191949.GA8096@coredump.intra.peff.net>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29678>

On Sat, Oct 21, 2006 at 03:19:49PM -0400 I heard the voice of
Jeff King, and lo! it spake thus:
> 
> I think the concept of "my" branch doesn't make any sense in git.
> [...]
> So don't think of it as "git throws away branch identity" as much as
> "git never cared about branch identity in the first place, and
> doesn't think it's relevant."

This is as I understand it.


But in my mind, it does make sense.  I fundamentally DO think of "my
commits" differently from "revisions I've merged", and I want the tool
to preserve that for me.  "My commits" tend to be steps along a path,
"merges" tend to be completed paths.  I usually use bzr's "log
--short" for looking at logs, which doesn't show merged revs at all.
That works, because most of the time I don't care about them; I know
if I merged something, it's a completed piece, which I described in
the log message; it's not a PART of a task like my commits usually
are.  So, just the message for my merge rev tells me what I need to
know, and if I need to drill down into it, I can use the regular
(--long) log output to look at the revision in it.  This lets me know,
for instance, that if I want to re-check something I did 3 commits
ago, and I just merged another branch, the commit I'm interested in is
the 4th commit back on the mainline; I don't need to grub through a
bunch of revisions that aren't mine to try and find it.

So, if me and Bob are working on different bits of the same project in
parallel, finish up, and merge back and forth to sync up (ignoring for
the moment the "empty merge commit" bit), even though we now both have
the 'same' stuff, we have the same head rev with all the same parents,
the parents are in a different order, and my 'mainline' (the path of
left-most parents, or 'first' as I understand git calls them) is
different than his; my mainline is my commits, his mainline is his.
If one of us were to 'pull' the other, our branch would become a
duplicate of his and so adopt his 'mainline', which we want to avoid
because then it doesn't fit the mental model of "what I did", which is
what I think of my branch as.


Obviously, this is a totally foreign mentality to git, and that's
great because it seems to work for you.  I can see advantages to it,
and I can conceive of situations where I might want that behavior.
But, in my day-to-day VCS use, I don't hit them, which is why I keep
typing 'bzr' instead of 'git' when I annoyingly need to type 'cvs'.


> The difference, I think, is that it's easier in git to move the
> upstream around: you simply start fetching from a different place.
> I'm not clear on how that works in bzr (if it invalidates revnos or
> has other side effects).

Depends on what you're fetching.  You can always tell 'bzr pull' a new
URL to look from.  If it's a later version of the 'same' branch, it'll
just update.  If it's a 'different' branch (a branch that's a superset
of your current branch/set-of-revisions, but with a different
'mainline' path through the revisions counts as 'different' here),
pull will complain and require a --overwrite to do the deed.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
