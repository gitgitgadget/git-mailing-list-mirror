From: Andreas Ericsson <ae@op5.se>
Subject: Re: yet another workflow question...
Date: Thu, 11 Oct 2007 19:28:18 +0200
Message-ID: <470E5D32.7060306@op5.se>
References: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com> <200710111610.55364.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Patrick Doyle <wpdster@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 19:28:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig1pv-0004nX-32
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 19:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbXJKR23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbXJKR23
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 13:28:29 -0400
Received: from mail.op5.se ([193.201.96.20]:55802 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360AbXJKR22 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 13:28:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3625517306B5;
	Thu, 11 Oct 2007 19:28:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0eGGNVYzwdP5; Thu, 11 Oct 2007 19:28:26 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id EB28217306B2;
	Thu, 11 Oct 2007 19:28:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <200710111610.55364.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60616>

Andy Parkins wrote:
> On Thursday 2007 October 11, Patrick Doyle wrote:
> 
>> burning question, "What can git do for me?"  (So far, I have come to
>> the conclusion that, for my simple, single developer, branchless,
>> linear projects, there's not much that git can do for me that any
>> other SCM could do for me.  It appears to have been designed to solve
> 
> Here's a few things that are relevant to a simple, single, branchless, linear 
> developer:
> 
>  - Fast.  Git wipes the floor with everything else, so much so that the SCM
>    becomes a tool in itself, not just a recorder of history.  I keep my own
>    simple projects in git just as much as my complicated, branchy, team-based
>    projects just to get the following tools fast:
>     git-diff
>     git-status
>     git-commit
>     git-log
> 
>  - Small.  In every project I've converted from SVN to git, the diskspace
>    usage has gone down.  SVN peppers the working tree with .svn directories,
>    each of which contains a pristine copy of the last checked in version of
>    all the working files.  On top of that is the repository disk space itself.
> 
>    Git on the other hand keeps one .git directory at the top of the tree and
>    that stores the _entire_ repository.  It is, in my experience, smaller than
>    the working tree.  That means that git uses less diskspace than svn does
>    for a single checkout to store everything it needs.
> 
>  - Useful.  The following are so good, that even if you weren't doing any 
>    revision tracking you'd still want to use them:
>     git-grep
>     git-diff
> 
>  - Backup.  Backing up subversion repositories requires that you write
>    yourself a script that uses svnadmin dump.  With git I just write a couple
>    of lines in my .git/config and then git-push produces a highly compact
>    backup whenever I want.  Even better, if a disaster happens it's easy to
>    pull stuff out of that backup without any additional operations.
> 
>  - Mobility.  This one is a bit distributed, but I hope you'll let me have it. 
>    I often do work on my desktop at home, my desktop at work and my laptop. 
>    By setting my remotes up correctly in git it's really easy to walk to
>    another system and pick up exactly where I left off from the other
>    computer.  More importantly though, when you accidentally make changes in
>    two places, there is no danger of data loss.
> 
> Even if you aren't doing complicated stuff, git is the way to go.  I can't 
> count the number of ways it's made me more productive and enhanced the code I 
> write and the documentation of its development.  If I never worked on another 
> group project again I would still use git all day every day.
> 

I'm amazed nobody has mentioned git-bisect yet. Recently, I had an enormous amount
of benefit from it, so I'll just add it here as a success-story in case any OSS
support company comes along and wants to peddle git.


As it happens, I have a daemon that does some fairly clever scheduling. Somewhere
in a recent change, I had introduced a very subtle bug that made the latency times
for when the actions were actually happening diverge from 0s. I know I get a
latency spike just when I fire the daemon up, but it's supposed to normalize after
10 or so minutes and converge on zero-latency. Instead it was slowly increasing,
but the effects weren't really visible until after about 2 hours.

git bisect to the rescue. Since I didn't feel terribly inclined to walk over to
my computer every two hours to recompile, wipe logs and start the daemon all over
again, I hacked up a script to do it for me. The script also checked the latency
figures and re-ran git-bisect as necessary.

22 hours (or 7 bisects) later, git had, with a little help from my script, shown
me exactly the commit that introduced the latency issue. During the time, I was
enjoying a walk in the sun, dinner with my girlfriend and a good nights sleep.

Life is good when you have the proper tools.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
