From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 10:25:35 -0700
Organization: Hewlett Packard
Message-ID: <20051216172535.GA25856@hpsvcnb.fc.hp.com>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com> <7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net> <7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 18:28:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnJKv-00035S-C7
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 18:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVLPRZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 12:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVLPRZi
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 12:25:38 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:31692 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932289AbVLPRZi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 12:25:38 -0500
Received: from smtp2.fc.hp.com (smtp2b.fc.hp.com [15.15.136.253])
	by atlrel8.hp.com (Postfix) with ESMTP id 61F96346BB;
	Fri, 16 Dec 2005 12:25:35 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 3183341EF10; Fri, 16 Dec 2005 17:25:35 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 1E66748CB4; Fri, 16 Dec 2005 10:25:35 -0700 (MST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13740>

Hello,

Here are my two cents.  I'll try my best to make a case for those poor
souls who get into this sort of mess.

Whenever I give a colleage an introduction to git I emphatically
recommend that they start with using git fetch and git merge
independantly of each other and stay away for git pull at least until
they know what they're doing.  This is because I have found that people
are really surprised at what happens when they type git pull until it
really sinks in that 'pull = fetch + merge to current branch, whatever
that may be'.

The difference between the words fetch and pull is much more subtle than
the difference between remove and list which are the basis for the
commands rm and ls.  I see nothing in the English dictionary to suggest
that pull means fetch + merge.  This is a gitism.  Even after reading
documentation clearly and even using git for a while the difference
really takes some time to sink in.

I think a great degree of understanding should be shown toward those who
dig themselves into this kind of thing.  I also recommend that some
extra care should be taken in the tutorials and documentation to warn
about this difference up front and possibly suggest avoiding the use of
pull for those new to git.

Carl

PS The issue was exacerbated when cogito and git were inconsistent on
their respective usages of pull and fetch.  I think this has gone away,
hasn't it?  I haven't used cogito in some time so I really don't know.

On Thu, Dec 15, 2005 at 03:53:38PM -0800, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Don Zickus <dzickus@gmail.com> writes:
> >
> >> I notice if I create a branch (and switch to it) in the linux kernel
> >> off of say version 2.6.14, then later do a git pull, things get ugly. 
> >> It seems like all the upstream changes are being merged into the
> >> 2.6.14 branch (instead of the latest kernel tag).
> >>
> >> Is this a user error because the tool is still fragile?
> >
> > I do not understand the question.
> >
> > The user wanted all the good developments from the mainline into
> > the fork he created starting at 2.6.14, and the tool did what
> > was asked.  Why would you want to forbid that from happening,
> > and what did you want to happen instead?
> 
> Actually I think I do understand the question.  You have a clone
> of linux-2.6 repository, and your "origin" branch tracks the
> bleeding edge from Linus.  You also have "myhack" branch that
> was forked off from 2.6.14, and wanted to see what new things
> Linus has by updating "origin", and perhaps merge those changes
> into your "master" which keeps track of your hacks based on
> Linus tip, but unfortunately you were on "myhack" branch.
> 
> Ouch.
> 
> So what you wanted to do was probably:
> 
> 	$ git fetch ;# this updates "origin" to Linus tip
> 
> instead of
> 
> 	$ git pull ;# this updates "origin" to Linus tip *and*
>                     # merges that into the current branch
> 
> As you may probably know, you can recover by
> 
> 	$ git reset --hard
> 
> While I am sympathetic, this "Oops, I said pull when I meant
> fetch" sounds remotely similar to "oops, I said 'rm -r' when I
> meant to say 'ls -r'".  Is it that the tool is too fragile?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
