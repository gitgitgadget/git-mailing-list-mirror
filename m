From: "Kirby C. Bohling" <kbohling@birddog.com>
Subject: Re: [RFC] undo and redo
Date: Thu, 25 Aug 2005 16:09:29 -0500
Message-ID: <20050825210929.GF7461@birddog.com>
References: <20050824195615.GA693@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241634350.23242@iabervon.org> <20050824204736.GA13194@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241651420.23242@iabervon.org> <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net> <20050825024134.GA31886@hpsvcnb.fc.hp.com> <7v1x4izjtm.fsf@assigned-by-dhcp.cox.net> <20050825163201.GA3944@hpsvcnb.fc.hp.com> <20050825195918.GD7461@birddog.com> <20050825203733.GA26539@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 23:18:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8P5Y-0000Qf-8K
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 23:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbVHYVQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbVHYVQd
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 17:16:33 -0400
Received: from hermes.birddog.com ([216.81.238.129]:61398 "EHLO
	hermes.birddog.com") by vger.kernel.org with ESMTP id S1751475AbVHYVQb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 17:16:31 -0400
Received: from hawk.birddog.com (hawk.birddog.com [10.15.4.100])
	by hermes.birddog.com (8.12.10/8.12.10) with ESMTP id j7PL9itn012795;
	Thu, 25 Aug 2005 16:09:44 -0500
Received: from hawk.birddog.com (localhost.localdomain [127.0.0.1])
	by hawk.birddog.com (8.12.11/8.12.11) with ESMTP id j7PL9Ydu011908;
	Thu, 25 Aug 2005 16:09:34 -0500
Received: (from kbohling@localhost)
	by hawk.birddog.com (8.12.11/8.12.11/Submit) id j7PL9T6l011906;
	Thu, 25 Aug 2005 16:09:29 -0500
To: Carl Baldwin <cnb@fc.hp.com>
Content-Disposition: inline
In-Reply-To: <20050825203733.GA26539@hpsvcnb.fc.hp.com>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.15 (www dot roaringpenguin dot com slash mimedefang)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7765>

On Thu, Aug 25, 2005 at 02:37:33PM -0600, Carl Baldwin wrote:
> On Thu, Aug 25, 2005 at 02:59:18PM -0500, Kirby C. Bohling wrote:
> > On Thu, Aug 25, 2005 at 10:32:01AM -0600, Carl Baldwin wrote:
> > <snip...>
> > > Another example is if I'm working on a commit and suddenly get a
> > > brilliant idea for some easy modification that I want to make and commit
> > > by itself before making this commit.  I can do this easily with
> > > 
> > >         % git undo
> > >         % carefully make easy change
> > >         % git commit
> > >         % git redo
> > > 
> > > Having a light-weight alternative like this could make the difference
> > > between realizing the easy, brilliant idea and forgetting about it on
> > > the back burner because it was just too cumbersome to make the context
> > > switch.
> > > 
> > > The bottom line is that I don't argue against using the existing
> > > work-flows.  I hope to add the flexibility to use various work-flows to
> > > fit the job at hand.
> > > 
> > <snip...>
> > 
> > [Not much of a git user, but am evaluating it for possible future
> > usage]... 
> > 
> > Why not just save the changes to a file via a patch.  Just like you
> > would if you were sending a patch to someone else.  I have the work
> > flow you are talking about when I use CVS.  I just create a patch,
> > apply the patch in reverse (or run the command to get you a clean
> > working tree in the SCM).  Make my unrelated changes commit it.
> > Then apply the patch, possibly resolve merge conflicts,  and proceed
> > with finishing my original work.
> 
> I used to do this with CVS too.  For you and me, people who are patch
> savy veterans, this is great!  However, as easy as it is I knew very few
> other developers who even thought about doing it.  In the real world,
> many people see a huge difference between:
> 
> git diff-cache > $patchfile
> cat $patchfile | patch -R -p1
> do work
> cat $patchfile | patch -p1
> 
> AND
> 
> git undo
> do work
> git redo
> 
> The first one simply never happens with most developers.  Most don't
> really think of doing something outside the tool.  The second option
> will likely get used.  Plus, I know at least one person here who is very
> good with patches and working outside the tool and still would love to
> have the second approach available.

I guess I can see that.  I just see it as much easier to manage
multiple undo-redo states manually.  I mean, I wouldn't make anyone
use git directly if the difference between the two commands bothers
them.  git seems too low a level.  I would think one of the
procelains would be be a better level.  However, having a unified
interface for all the porcelains seems a reasonable request.

> 
> Is there something wrong with having flexibility?  It seems most of the
> criticism of this feature is that there is already a way to accomplish
> what I want to do.  Tools that can't be used flexibly are not tools that
> I like to use.  Heck, I'm on UNIX aren't I?
> 
> Oops, sorry for the rant.  I'm really not in a bad mood... really.  I
> hope it didn't sound like that :-).  Oh, and I didn't mean to suggest
> that git is not flexible in other regards.  I think its great!  Moving
> along...
> 
> > Assuming your patch creation and application tools capture all the
> > meta-data the SCM has (which I believe git does), it's pretty simple
> > to simulate what you want manaully.  With only a handful of
> > commands.
> 
> I can simulate git manually too with just a few more commands.  Where's
> the cutoff?

Yes and no.  I meant the order and style of commands was nearly
identical.  I meant applying the command line in reverse was the
only additional step.  As a workflow, I'd just document it in the
HOWTO's.  I'm a minimalist in that sense.  Sure, I use more then
echo, redirection and netcat even though in theory I could send you
this e-mail with it.  IMHO, the above undo/redo doesn't seem to save
enough effort to me.  I wouldn't bother learning undo/redo unless it
was superior to the patch way, it's just one more thing I'd have to
remember.

> 
> > I see the appeal of not having manually deal with the files, but
> > assuming you don't feel it's branch worthy, and you don't want to
> > have it be something someone else can access externally, it doesn't
> > seem like a feature I can't get almost as simply with existing git
> > commands.  
> 
> Not having to manually manage a set of patches may seem small but it
> reduces a barrier that may otherwise be just high enough to hurt
> productivity in certain situations.

I don't mean to discourge it's implementation, I really questioned
it because I figured there had to be some more subtle implications I
didn't understand about undo/redo that patch couldn't capture.  It
also seems like multiple levels of undo/redo or undo/redo on
multiple branches could get tricky for the user to track and for git
to be able to display the information to the user sanely.

    Thanks,
        Kirby
