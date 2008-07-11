From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git
 repository
Date: Sat, 12 Jul 2008 00:33:37 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807120028280.8950@racer>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>  <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>  <alpine.DEB.1.00.0807112215050.8950@racer>  <bd6139dc0807111452x778759d4jd6ac71338974018e@mail.gmail.com> 
 <alpine.DEB.1.00.0807112257450.8950@racer> <bd6139dc0807111550w1f4a9e5fl636df73572bd27de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	David Symonds <dsymonds@gmail.com>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:34:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHS8L-0000Rk-Ae
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 01:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbYGKXdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 19:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbYGKXdj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 19:33:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:40138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482AbYGKXdi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 19:33:38 -0400
Received: (qmail invoked by alias); 11 Jul 2008 23:33:36 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp019) with SMTP; 12 Jul 2008 01:33:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18E7V5G7wsEFWoSLGfT61j1AbWCq8spJH/+ML5pB5
	xvTAz8TU+abbvv
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807111550w1f4a9e5fl636df73572bd27de@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88200>

Hi,

On Sat, 12 Jul 2008, Sverre Rabbelier wrote:

> On Sat, Jul 12, 2008 at 12:07 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> On Fri, Jul 11, 2008 at 11:22 PM, Johannes Schindelin Yeah, I wish 
> >> 'git log -C -C -M --numstat --sacrifice-chicken --pretty=format:%ae 
> >> --' would take care of that... That is, a git-blame like mechanism 
> >> that would detect such moves on a per-commit basis and report them 
> >> would be very useful to me.
> >
> > Well, the chicken (or better, a goat) should be sacrificed by you...  
> > The option I would call "--code-moves".
> 
> If you suggest I write up a patch to 'git log' I am afraid that would 
> require quite a bit more skill && knowledge of 'git log' than I have 
> (which is about Null :P).

If you were suspecting that I would write the patch once the semantics are 
finalized, you would be absolutely correct.

> > But the semantics of that need to be sorted out in a shell script 
> > first; maybe like I outlined (if that was not coherent, please say 
> > so).
> 
> Python is one big shell script :P, so if you meant that it should be 
> part of GitStats (instead of part of 'git log', which I commented on 
> above), python would be just fine :). The concept was clear enough 
> though, I think I understand what you mean.

Fair enough.  As long as you use a language that is easy to prototype 
quickly and dirtily in.  Such as Python.

> >> Very much so, but the former I figure can be easily done with 'git 
> >> log -C -C -M' I discovered (I need to parse it's output though, and 
> >> also determine what to do with moves statistics wise. Should changes 
> >> made due to moves just be ignored?)
> >
> > That is not very interesting, as we often move so small parts (think 
> > "one function") that -C -C -M does not trigger.
> 
> Right, why aim for the stuff when there's much more interesting fun out 
> there? If there was a --code-moves I agree with you that it would be a 
> lot more interesting to have than going with the current approach and 
> throwing in '-C -C -M'.

Let's go for it, then!

> >> That sounds interesting, I won't need to actually do that though, I 
> >> already have a diff parser that gives me the lines added VS lines 
> >> deleted on a hunk-by-hunk basis. If it is a true move (e.g., code 
> >> removed in file X and added in file Y) it should be trivial to detect 
> >> that.
> >>
> >> Something along the lines of:
> >>  for hunk in added:
> >>   if hunk in deleted:
> >>     print("Over here!!")
> >
> > I think that is not enough, as a code move can mean that part of a
> > function was refactored into a function.  The consequence is often a
> > reindent, and possibly rewrapping.
> 
> Mhhh, such would be beyond the scope of implementing manually indeed,
> and should be left to the likes of a diff tool instead in order to
> prevent reinventing the wheel :).

That is why I was suggesting using the diff tool with munged input to find 
out what works best.

When that is done, I'll turn it into C.

> > BTW I realized something else: your 
> > http://alturin.googlepages.com/full_activity.txt lists only 
> > "gitk-git/po/es.po" under git-git/po/.  And it has as many added as 
> > deleted lines.
> 
> Correct, that's because that is what 'git log' tells me.

I suspect that one big "git log" will not tell you enough.  You probably 
need to make your tool aware (at least a little) about merges, just as you 
probably made it aware about parent/child relationships (to track the 
changes along renames)...

Ciao,
Dscho
