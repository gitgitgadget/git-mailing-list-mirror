From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git rebase to move a batch of patches onto the current branch
Date: Fri, 25 Jul 2008 22:00:49 +0200
Message-ID: <20080725200049.GA6611@blimp.local>
References: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com> <20080724201333.GA3760@blimp.local> <32541b130807241316x4f85bcdfw12857be575fb3289@mail.gmail.com> <20080724203049.GC3760@blimp.local> <32541b130807241342h483169d7we955512879075161@mail.gmail.com> <alpine.LNX.1.00.0807251509390.19665@iabervon.org> <20080725192500.GB13539@leksak.fem-net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 22:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTUT-0001ya-Ic
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 22:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbYGYUA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 16:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbYGYUA4
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 16:00:56 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:32005 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYGYUAz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 16:00:55 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44h+5V
Received: from tigra.home (Fa915.f.strato-dslnet.de [195.4.169.21])
	by post.webmailer.de (mrclete mo38) (RZmta 16.47)
	with ESMTP id j0734ck6PGfPv5 ; Fri, 25 Jul 2008 22:00:49 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C3DA3277BD;
	Fri, 25 Jul 2008 22:00:49 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id CB74836D18; Fri, 25 Jul 2008 22:00:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080725192500.GB13539@leksak.fem-net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90108>

Stephan Beyer, Fri, Jul 25, 2008 21:25:00 +0200:
> Daniel Barkalow wrote:
> > > On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > > Avery Pennarun, Thu, Jul 24, 2008 22:16:06 +0200:
> > > > > On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > >
> > > > > >     gcp3 ()
> > > >  > >     {
> > > >  > >         git format-patch -k --stdout --full-index "$@" | git am -k -3 --binary
> > > >  > >     }
> > > >  >
> > > >  > But that'll give up when there are conflicts, right?  git-rebase lets
> > > >  > me fix them in a nice way.
> > > >
> > > > No, it same as in rebase. You'll fix them and do "git am --resolved".
> > > >  See manpage of git am.
> > > 
> > > Hmm, cool.
> > > 
> > > So that command isn't too easy to come upon by accident.  If I wanted
> > > to submit a patch to make this process a bit more obvious, would it
> > > make sense to simply have git-cherry-pick call that sequence when you
> > > give it more than one commit?
> > 
> > Before terribly long, we'll have "git sequencer", which should be easy to 
> > get to do the "rebase -i" thing with cherry-pick-style usage (somebody 
> > would just need to write code to generate the correct series of pick 
> > statements).
> 
> For simple cases this code could be something like:
> git rev-list --reverse --cherry-pick --no-merges --first-parent <from>..<to> |
> 	sed 's/^/pick /' | git sequencer
> 
> (At least this is what I use relatively often.)
> 
> But as long as git sequencer is not in official git, this is not an
> option. :)

Besides, that's longer than format-patch + am for the same from..to
range.
