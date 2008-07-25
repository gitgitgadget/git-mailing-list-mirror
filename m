From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git rebase to move a batch of patches onto the current branch
Date: Fri, 25 Jul 2008 21:25:00 +0200
Message-ID: <20080725192500.GB13539@leksak.fem-net>
References: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com> <20080724201333.GA3760@blimp.local> <32541b130807241316x4f85bcdfw12857be575fb3289@mail.gmail.com> <20080724203049.GC3760@blimp.local> <32541b130807241342h483169d7we955512879075161@mail.gmail.com> <alpine.LNX.1.00.0807251509390.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:26:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMSvd-00065b-7Y
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbYGYTZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbYGYTZL
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:25:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:36108 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752473AbYGYTZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:25:10 -0400
Received: (qmail invoked by alias); 25 Jul 2008 19:25:08 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp046) with SMTP; 25 Jul 2008 21:25:08 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/DXooag4jDNjaEPzib/t4nbsc7LEP8Tw8+c7YE3y
	kM16xeob22rBOD
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMSuS-0003ok-FJ; Fri, 25 Jul 2008 21:25:00 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0807251509390.19665@iabervon.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90093>

Hi,

Daniel Barkalow wrote:
> > On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > Avery Pennarun, Thu, Jul 24, 2008 22:16:06 +0200:
> > > > On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> > >
> > > > >     gcp3 ()
> > >  > >     {
> > >  > >         git format-patch -k --stdout --full-index "$@" | git am -k -3 --binary
> > >  > >     }
> > >  >
> > >  > But that'll give up when there are conflicts, right?  git-rebase lets
> > >  > me fix them in a nice way.
> > >
> > > No, it same as in rebase. You'll fix them and do "git am --resolved".
> > >  See manpage of git am.
> > 
> > Hmm, cool.
> > 
> > So that command isn't too easy to come upon by accident.  If I wanted
> > to submit a patch to make this process a bit more obvious, would it
> > make sense to simply have git-cherry-pick call that sequence when you
> > give it more than one commit?
> 
> Before terribly long, we'll have "git sequencer", which should be easy to 
> get to do the "rebase -i" thing with cherry-pick-style usage (somebody 
> would just need to write code to generate the correct series of pick 
> statements).

For simple cases this code could be something like:
git rev-list --reverse --cherry-pick --no-merges --first-parent <from>..<to> |
	sed 's/^/pick /' | git sequencer

(At least this is what I use relatively often.)

But as long as git sequencer is not in official git, this is not an
option. :)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
