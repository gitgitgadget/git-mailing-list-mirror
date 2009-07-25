From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 22:53:11 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907242242310.2147@iabervon.org>
References: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <7vtz146mgr.fsf@alter.siamese.dyndns.org> <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain>
 <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <alpine.LFD.2.01.0907241505400.3960@localhost.localdomain> <alpine.DEB.1.10.0907241518120.28013@asgard.lang.hm>
 <alpine.LFD.2.01.0907241529420.3960@localhost.localdomain> <alpine.DEB.1.10.0907241545340.28013@asgard.lang.hm> <alpine.LFD.2.01.0907241934260.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 04:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUXQl-0007sA-UV
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 04:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbZGYCxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 22:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755029AbZGYCxN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 22:53:13 -0400
Received: from iabervon.org ([66.92.72.58]:44674 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbZGYCxM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 22:53:12 -0400
Received: (qmail 20130 invoked by uid 1000); 25 Jul 2009 02:53:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jul 2009 02:53:11 -0000
In-Reply-To: <alpine.LFD.2.01.0907241934260.3960@localhost.localdomain>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123990>

On Fri, 24 Jul 2009, Linus Torvalds wrote:

> On Fri, 24 Jul 2009, david@lang.hm wrote:
> 
> > On Fri, 24 Jul 2009, Linus Torvalds wrote:
> > 
> > > On Fri, 24 Jul 2009, david@lang.hm wrote:
> > > > 
> > > > what does the performance look like if you just do a static compile
> > > > instead?
> > > 
> > > I don't even know - I don't have a static version of curl. I could install
> > > one, of course, but since I don't think that's the solution anyway, I'm
> > > not going to bother.
> > 
> > I wasn't thinking a static version of curl, I was thinking a static version of
> > the git binaries. see how fast things could be if no startup linking was
> > nessasary.
> 
> Well, that's what I meant. If I add '-static' to the link flags, I get
> 
> 	/usr/bin/ld: cannot find -lcurl
> 	collect2: ld returned 1 exit status
> 
> because I simply don't have a static library version of curl (and if I do 
> NO_CURL, I fail the link due to not having a static version of zlib).
> 
> That's what I meant by "I could install a static version of curl" - I 
> could install the debug libraries, but it just isn't a normal thing to do 
> on any modern distribution. The right thing to do really would be to not 
> have -lcurl for the main git binary at all.
> 
> Preferably done by having http walking handled by an external process (the 
> way we already do rsync), but it's probably easier to just make all the 
> clone/fetch/ls-remote things be a separate binary.

I think it's actually easy enough to have a separate binary to handle the 
http walking, particularly since I've got code lying around to handle 
importing from a foreign VCS with a separate binary that I can just remove 
some of the features from.

	-Daniel
*This .sig left intentionally blank*
