X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 12:50:17 +0100
Message-ID: <455C5079.3010701@op5.se>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <200611151858.51833.andyparkins@gmail.com> <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org> <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com> <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home> <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <20061116042639.GA23026@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 11:50:36 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061116042639.GA23026@thunk.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31575>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkflC-0003W1-76 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 12:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031176AbWKPLuX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 06:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031178AbWKPLuX
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 06:50:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:15588 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1031176AbWKPLuW (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 06:50:22 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id A40736BD65; Thu,
 16 Nov 2006 12:50:20 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 9B8356BD53; Thu, 16 Nov 2006 12:50:17 +0100 (CET)
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

Theodore Tso wrote:
> On Wed, Nov 15, 2006 at 12:40:43PM -0800, Linus Torvalds wrote:
>> And yes, this is why you should NOT try to use the same naming as "hg", 
>> for example. Last I saw, hg still didn't even have local branches, To 
>> mercurial, repository == branch, and that's it. It was what I came from 
>> too, and I used to argue for using git that way too. I've since seen the 
>> error of my ways, and git is simply BETTER. 
> 
> Actually, that's not true.  Mercurial has local branches, just as git
> does.  Some people choose not to *use* this particular feature, and
> use the BK style repository == branch, but that's mainly because it's
> conceptually easy for them, and a number of BK refugees are very
> happily using Hg.  
> 
> It's probably because of the BK refugee population that after you do
> an hg pull, it will warn you that you need to do an "hg update" in
> order to merge the working directory up to the latest version that was
> just pulled --- and this change was made precisely because Hg supports
> local branches, and merging with the current branch isn't always the
> right thing, unlike with BK.
> 
>> And the concept of local branches is exactly _why_ you have to have 
>> separate "fetch" and "pull", but why you do _not_ need a separate "merge" 
>> (because "pull ." does it for you).
> 
> It's just that the semantics are different, and many developers have
> to use multiple DSCM's, depending on what project they happen to be
> developing on.  So the reality is that there are people who have to
> use bzr, git, and hg, all at the same time.  And while eventually
> newbies will figure out and remember that "git pull ." == "merge", the
> naming is simply confusing, that's all.  (What does "pull" have to do
> with "merge"?  It's not at all obvious.)  
> 
> For somoene who uses git full-time, and to the exclusion of all other
> systems, I'm sure it's not a problem at all.


It seems we should, cheaply, be able to avoid a large part of the 
confusion by

* Mentioning git-fetch before git-pull in all documentation newborn 
gitizens are likely to come across. Most git-users aren't Linus, and for 
every successful project the maintainers are outnumbered 100 to 1 by the 
contributors. Those projects successful *because* maintainers are 
heavily outnumbered so we should make it easier for contributors by 
teaching them the right things from the start and possibly have a 
separate man-page for maintainer (git-{maintainer,developer} man-pages, 
anyone?).
* Creating "git update" which might possibly be an internal alias to 
"git pull", except that it should read .git/remotes/* by default unless 
a specific remotes-file is specified.
* Renaming git-merge to git-merge-driver
* Implementing a git-merge that actually does what its name implies, 
possibly by making it an internal alias to pull, but with these differences:
   - It always merges into your current branch.
   - It understands "git merge branch" as well as "git merge . branch".

This is just the very low-hanging fruit. If we take these steps and let 
things cool down a bit, it would probably be proper to take a fresh look 
at this in a couple of months.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
