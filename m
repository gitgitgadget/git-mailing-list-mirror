From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: test suite fails if sh != bash || tar != GNU tar
Date: Wed, 11 Jul 2007 22:56:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707112240120.4516@racer.site>
References: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com> 
 <Pine.LNX.4.64.0707110347580.4047@racer.site> 
 <alpine.LFD.0.999.0707102020020.3412@woody.linux-foundation.org> 
 <7154c5c60707102108g59280301pa5c3c0dc3911753d@mail.gmail.com> 
 <Pine.LNX.4.64.0707111209160.4516@racer.site>  <7v7ip64opa.fsf@assigned-by-dhcp.cox.net>
 <7154c5c60707111433r64ae5109o314778655cbc017e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: David Frech <david@nimblemachines.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:56:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8kAl-0005ha-L2
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763009AbXGKV42 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbXGKV42
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:56:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:39692 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751772AbXGKV41 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:56:27 -0400
Received: (qmail invoked by alias); 11 Jul 2007 21:56:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 11 Jul 2007 23:56:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186mYgIPMQ6xWNa7QOA5JJIqXX9/0/FFBN49UBQt3
	PiMWDJi/CJiu/F
X-X-Sender: gene099@racer.site
In-Reply-To: <7154c5c60707111433r64ae5109o314778655cbc017e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52216>

Hi,

On Wed, 11 Jul 2007, David Frech wrote:

> On 7/11/07, Junio C Hamano <gitster@pobox.com> wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > >> I'll see what I can do. As I'm planning on running git on both 
> > >> FreeBSD and DragonFly for the forseeable future, and plan to track 
> > >> git's evolution (running stable releases if not more bleeding-edge 
> > >> code), I can run the test suite every time I build a new git.
> > >
> > > If you want to, I can help you setting up a nightly cron job to 
> > > fetch what is the current "next", run the tests, and report failures 
> > > by email.
> > 
> > Wow.  Nightly builds of 'next' on various platforms would actually be 
> > quite useful, especially from non Linux and non bash world.
> 
> I found and fixed the shell issues. Once I've got a "fix" for tar I'll 
> send a patch. I think the BSD sh has a bug wrt to negating the return 
> code from a pipeline.

Cool!  Please be sure to give Documentation/SubmittingPatches a quick 
glance before sending, to avoid hassles for the reviewers.

> I'd be happy to do a nightly build on my DragonFly box, and that should 
> catch anything that also doesn't work for FreeBSD. The failure modes 
> were exactly the same - though the DFly box has an additional 
> iconv-related problem (with git-mailinfo) that I still haven't tracked 
> down...
> 
> Is there a canned script to get me started?

Well, I would have started from scratch, as in

5 0 * * *       (cd /xx/git && sh test-it.sh)

And in test-it.sh there could be something like

	(git pull origin next && make test > test-it.out 2>&1 ) || 
	some-script-that-sends-the-email.sh

> One issue is that my server is on dynamic IP, and my lame ISP (the local 
> telco) doesn't give me a proper SMTP relay - they want us to send our 
> mail via HTTP to MSN! Completely lame.

It is lame.

> So sending mail can be an issue, if the receiver blocks mail from 
> dynamic IPs.

But maybe you can just upload the status somewhere public?  Or ssh into a 
machine which allows you to send an email, with public key authentication?

Ciao,
Dscho
