From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 14:50:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091447110.4167@racer.site>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site>
 <20070509123205.GN4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>, kha@treskal.com,
	barkalow@iabervon.org, junio@cox.net, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 09 14:50:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hllcz-0004pQ-Kh
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbXEIMul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755241AbXEIMul
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:50:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:44025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753376AbXEIMuk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:50:40 -0400
Received: (qmail invoked by alias); 09 May 2007 12:50:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 09 May 2007 14:50:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19R++lclX5RI/S2a1j4UCvJKxF//p9A8JajWyRIYw
	+IEhQjiGvdcehc
X-X-Sender: gene099@racer.site
In-Reply-To: <20070509123205.GN4489@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46707>

Hi,

On Wed, 9 May 2007, Petr Baudis wrote:

> On Wed, May 09, 2007 at 02:19:03PM CEST, Johannes Schindelin wrote:
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> > index 2d58bb0..55934db 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -3197,7 +3197,15 @@ basically _the_ header file which is included by _all_ of Git's C sources.
> >  If you grasp the ideas in that initial commit (it is really small and you 
> >  can get into it really fast, and it will help you recognize things in the 
> >  much larger code base we have now), you should go on skimming `cache.h`, 
> > -`object.h` and `commit.h`.
> > +`object.h` and `commit.h` in the current version.
> > +
> > +In the early days, Git (in the tradition of UNIX) was a bunch of programs 
> > +which were extremely simple, and which you used in scripts, piping the 
> > +output of one into another. This turned out to be good for initial 
> > +development, since it was easier to test new things.  However, recently 
> > +many of these parts have become builtins, and some of the core has been 
> > +"libified", i.e. put into libgit.a for performance, portability reasons, 
> > +and to avoid code duplication.
> > 
> >  By now, you know what the index is (and find the corresponding data 
> >  structures in `cache.h`), and that there are just a couple of object types 
> 
> I disagree, especially with the past tense of the first half of the
> paragraph. Git is _still_ a bunch of programs you use in scripts, piping
> the output of one into another. Another point is that
> implementation-wise many of the code is currently shared in an internal
> library, etc.

No. Many parts are _not_ simple programs piped into each other. git-log, 
git-show, git-mv come to mind. That is why I wrote "many" and not "all".

> I'd be a bit careful to talk about libgit.a so leisurely since it might 
> give the reader an impression that there really _is_ "the git library", 
> with API and everything, that they can use externally. Of course you 
> need to mention libgit.a, but I'd also mention that it is so far meant 
> only for internal git's use and has no solidified API.

Frankly, this is just a birdview thing. If you want to go and make a 
hacker's manual, go ahead!

> > @@ -3300,8 +3321,10 @@ Two things are interesting here:
> >  
> >  - the variable `sha1` in the function signature of `get_sha1()` is `unsigned 
> >    char *`, but is actually expected to be a pointer to `unsigned 
> > -  char[20]`.  This variable will contain the big endian version of the 
> > -  40-character hex string representation of the SHA-1.
> > +  char[20]`.  This variable will contain the 160-bit SHA-1 of the given 
> > +  commit.  Note that whenever a SHA-1 is passed as "unsigned char *", it 
> > +  is the binary representation (big-endian), as opposed to the ASCII 
> > +  representation in hex characters, which is passed as "char *".
> >  
> >  You will see both of these things throughout the code.
> 
> To be honest, I wouldn't even be *thinking* about the endianity of SHA-1
> octet representation (you don't usually really deal with the hash as
> with a number, so expecting to have it in native endianity is not very
> natural; you just deal with it as with a data blob) and the
> "(big-endian)" would only confuse me and get me thinking about "huh, do
> they swap the bytes, or wait, they don't, ...?!".
> 
> But that's maybe just me.

But then, maybe it is just me? I got it completely wrong the first time, 
fully expecting the calculations to be carried out in host endianness for 
performance reasons.

Ciao,
Dscho
