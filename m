From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] undo and redo
Date: Thu, 25 Aug 2005 14:37:33 -0600
Organization: Hewlett Packard
Message-ID: <20050825203733.GA26539@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org> <20050824195615.GA693@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241634350.23242@iabervon.org> <20050824204736.GA13194@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241651420.23242@iabervon.org> <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net> <20050825024134.GA31886@hpsvcnb.fc.hp.com> <7v1x4izjtm.fsf@assigned-by-dhcp.cox.net> <20050825163201.GA3944@hpsvcnb.fc.hp.com> <20050825195918.GD7461@birddog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 22:39:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8OU0-0005z1-AI
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVHYUhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVHYUhx
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 16:37:53 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:15580 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932556AbVHYUhx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 16:37:53 -0400
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel6.hp.com (Postfix) with ESMTP id 224F6166F;
	Thu, 25 Aug 2005 16:37:38 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id B85823853D; Thu, 25 Aug 2005 20:37:33 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 9DD7F2B091; Thu, 25 Aug 2005 14:37:33 -0600 (MDT)
To: "Kirby C. Bohling" <kbohling@birddog.com>
Content-Disposition: inline
In-Reply-To: <20050825195918.GD7461@birddog.com>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7761>

On Thu, Aug 25, 2005 at 02:59:18PM -0500, Kirby C. Bohling wrote:
> On Thu, Aug 25, 2005 at 10:32:01AM -0600, Carl Baldwin wrote:
> <snip...>
> > Another example is if I'm working on a commit and suddenly get a
> > brilliant idea for some easy modification that I want to make and commit
> > by itself before making this commit.  I can do this easily with
> > 
> >         % git undo
> >         % carefully make easy change
> >         % git commit
> >         % git redo
> > 
> > Having a light-weight alternative like this could make the difference
> > between realizing the easy, brilliant idea and forgetting about it on
> > the back burner because it was just too cumbersome to make the context
> > switch.
> > 
> > The bottom line is that I don't argue against using the existing
> > work-flows.  I hope to add the flexibility to use various work-flows to
> > fit the job at hand.
> > 
> <snip...>
> 
> [Not much of a git user, but am evaluating it for possible future
> usage]... 
> 
> Why not just save the changes to a file via a patch.  Just like you
> would if you were sending a patch to someone else.  I have the work
> flow you are talking about when I use CVS.  I just create a patch,
> apply the patch in reverse (or run the command to get you a clean
> working tree in the SCM).  Make my unrelated changes commit it.
> Then apply the patch, possibly resolve merge conflicts,  and proceed
> with finishing my original work.

I used to do this with CVS too.  For you and me, people who are patch
savy veterans, this is great!  However, as easy as it is I knew very few
other developers who even thought about doing it.  In the real world,
many people see a huge difference between:

git diff-cache > $patchfile
cat $patchfile | patch -R -p1
do work
cat $patchfile | patch -p1

AND

git undo
do work
git redo

The first one simply never happens with most developers.  Most don't
really think of doing something outside the tool.  The second option
will likely get used.  Plus, I know at least one person here who is very
good with patches and working outside the tool and still would love to
have the second approach available.

Is there something wrong with having flexibility?  It seems most of the
criticism of this feature is that there is already a way to accomplish
what I want to do.  Tools that can't be used flexibly are not tools that
I like to use.  Heck, I'm on UNIX aren't I?

Oops, sorry for the rant.  I'm really not in a bad mood... really.  I
hope it didn't sound like that :-).  Oh, and I didn't mean to suggest
that git is not flexible in other regards.  I think its great!  Moving
along...

> Assuming your patch creation and application tools capture all the
> meta-data the SCM has (which I believe git does), it's pretty simple
> to simulate what you want manaully.  With only a handful of
> commands.

I can simulate git manually too with just a few more commands.  Where's
the cutoff?

> I see the appeal of not having manually deal with the files, but
> assuming you don't feel it's branch worthy, and you don't want to
> have it be something someone else can access externally, it doesn't
> seem like a feature I can't get almost as simply with existing git
> commands.  

Not having to manually manage a set of patches may seem small but it
reduces a barrier that may otherwise be just high enough to hurt
productivity in certain situations.

> I guess my final question is what does undo/redo have over saving
> stuff away in a patch assuming that the patch captures all of the
> SCM meta-data (the add/move/remove file type commands).  If git
> doesn't capture all the meta-data in a patch, it would seem better
> to make it do that and get this as a side-affect.
> 
>     Thanks,
>         Kirby

Thanks for your comments.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
