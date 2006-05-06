From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #2
Date: Fri, 05 May 2006 22:58:05 -0700
Message-ID: <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605041627310.6713@iabervon.org>
	<Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 06 07:58:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcFo1-0001VC-6a
	for gcvg-git@gmane.org; Sat, 06 May 2006 07:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWEFF6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 01:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWEFF6I
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 01:58:08 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:42627 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750861AbWEFF6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 01:58:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060506055806.REES9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 01:58:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19647>

Linus Torvalds <torvalds@osdl.org> writes:

> I'm actually growing pretty fond of the config file interfaces that Dscho 
> is pushing. I really like the idea of "git pull" doing different things 
> depending on which branch is active at the time, because different 
> branches really can have different sources they come from.

> Always pulling from the same default source seems wrong,...

> So Johannes' patches seem to move into that direction, and having it all 
> in the config file actually seems to be quite readable.

I share the same reasoning and that is why I am carrying the
series in "next".  I think per branch attributes are wonderful
things.

> So I'd argue that (a) yes, we do want to have the "proto porcelain" that 
> sets remote branch information without the user having to know the magic 
> "git repo-config" incantation, or know which file in .git/remotes/ to 
> edit, but that (b) it's even more important to try to decide on what the 
> remote description format _is_.

Is it format you care about or the semantics?

> I personally have just two preferences:
>
>  - I'd like each branch I'm on to have a "default source" for pulling (and 
>    _maybe_ for pushing too). I'd like to just say "git pull", and it would 
>    automatically select the appropriate thing to pull from.
>
>  - maybe the same per-branch thing for "push", but more importantly for 
>    me, I like to push to multiple destinations, and I'd like the 
>    description format to be sane. I think it may already be sane in the 
>    form it is in now (supporting both config file _and_ .git/remotes/ 
>    formats), I'd just like us to decide on exactly what the meaning is, 
>    and hopefully get to the point where we can tell porcelain how to use 
>    that meaning to their advantage (and not change it)
>
> Others may disagree, or (equally importantly), may have additional 
> preferences. We should try to find something that works for everybody, and 
> that is easy to work with.

In my day job, I maintain a base code for a generic application
in "master", various topics, mostly branched from "master" but
sometimes from another topic branch, and one branch each per
customer installation, which pulls from the master, topics and
contains specific customizations.  While on master or any one of
generic topic branch, I need to remember not to pull from
installation branches.  For that matter, the installation
branches should not be pulled into anything else.  So not just
"this branch usually merges from there", but "this branch should
not be merged into others" (mark "installation branches" as
such), and "this branch should never merge from that one" (mark
"master" with "installation branches") would prevent mistakes.

One thing I noticed in "What's in libata.git" Jeff did by
mimicking my "What's in git.git" was that the description for
each topic branch included where it branched from (iow, what
other branch it builds on).  This is sometimes derivable, but
having it as a property for a branch is very handy.
