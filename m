From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Wed, 19 Dec 2007 12:01:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712191150240.23902@racer.site>
References: <20071217110322.GH14889@albany.tokkee.org> 
 <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> 
 <7vk5nd53lp.fsf@gitster.siamese.dyndns.org>  <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
  <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>  <20071218154211.GB12549@alea.gnuu.de>
  <46a038f90712181541x781c3ebcq6d85b88dbf5cbe23@mail.gmail.com> 
 <38C1471E-0927-4B43-AF73-70735820F8F9@wincent.com>
 <46a038f90712182346t5309448egebfd3726f4d493c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 13:02:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xdF-000257-Ne
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 13:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbXLSMCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 07:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbXLSMCN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 07:02:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:58581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752743AbXLSMCM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 07:02:12 -0500
Received: (qmail invoked by alias); 19 Dec 2007 12:02:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 19 Dec 2007 13:02:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TJiA41LkTzjcXni3/kGADwo++2CTGN+p1u6qwJa
	GBhFkrA6LDKYs1
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90712182346t5309448egebfd3726f4d493c5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68897>

Hi,

On Wed, 19 Dec 2007, Martin Langhoff wrote:

> On Dec 19, 2007 8:33 PM, Wincent Colaiuta <win@wincent.com> wrote:
> > El 19/12/2007, a las 0:41, Martin Langhoff escribi?:
> >
> > > On Dec 19, 2007 4:42 AM, J?rg Sommer <joerg@alea.gnuu.de> wrote:
> > >> I vote for stash print the list, because I dropped in the pitfall.
> > >
> > > I've dropped there myself, and work with a large team where we are 
> > > both fans of stash, and scarred by it. Any newcomer to git that 
> > > "discovers" stash gets hit by it a dozen times, this is completely 
> > > unnecesary.
> >
> > I may be missing something here, but what's the danger here? An
> 
> Surprise. Your working directory has *just* changed under your feet. 
> Maybe you have an editor with further unsaved changes that is about to 
> act confused whether you undo the stash or not.

The funny thing: why do you call stash with unsaved changes anyway?  I 
mean, come on, even if you were planning to see the usage of stash (which 
you would get with -h), you undoubtedly wanted to either stash or unstash 
some changes.  Otherwise you would not _need_ to see the usage to begin 
with.

> > unexpected stash is incredibly easy to revert, unless I'm missing
> 
> Once you know about it, yes it is. Once you know about the reflog, you
> can sing and dance and never be worried. But for starting users, it's
> a dangerous command.

No.

Reflogs have nothing to do with it.

If you want to stash changes, you _got_ to know how to unstash those 
changes.  Otherwise "git reset --hard" would have been your friend.

And so, I cannot help but believe that all users of stash -- even the new 
ones -- know about the fundamental concept of stashing/unstashing, and 
therefore it is more something like this:

	$ git stash
	[no usage?  What the heck... Oh, it stashed the changes.  I did 
	 not want to stash them just yet.  Okay:]
	$ git unstash
	No such command
	[Oh, maybe I should have read the man page.  Oh, well, the usage 
	 should do...]
	$ git stash -h
	...

Yes, if you start "git stash" blindly, believing that it does what "git 
stash -h" does, you will be bitten by it once.

But as I said, you will be bitten by a plenty commands if you are not 
familiar with the concept that "-h" shows the synopsis, "--help" the man 
page, and that there is a default action where possible.

But stash really is about things like

	$ git stash
	$ git pull
	$ git stash apply

I do not _want_ to see the stash list in _most_ cases, because I do not 
stash away million dirty changes.

And that workflow was what "git stash" was designed for.

> > And nobody commented on the idea I posted earlier which seems to 
> > address the concerns about newbies not knowing what "git stash" with 
> > no params does:
> 
> I agree with making stash more verbose -- if the unlucky new user is
> paying close attention, they'll have instructions on to how to get out
> of trouble. But I agree more with making it "just verbose, no action"
> by default. There are two strong hints:
> 
>  - all other state-changing commands take parameters

What about "git commit", "git reset", "git fetch"?  These definitely 
change state of the repository.

>  - quite a few people in this list have gotten burned with it

Okay, let's have a little calculation: IIRC 3 people (let's make it 10, to 
be conservative) have said that they had this problem.  I must assume that 
all other people did not have the problem, or at least saw why the default 
action of "git stash" is what it is.

That said, if you _have_ to have the default changed, then I'll probably 
implement a "git push" and "git pop" alias here, so that I cannot get 
annoyed by stash's "new and improved" behaviour.

Ciao,
Dscho
