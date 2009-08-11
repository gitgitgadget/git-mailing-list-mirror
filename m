From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Tue, 11 Aug 2009 10:39:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908111033430.4638@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org> <7v1vnk79lt.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908092153520.27553@iabervon.org> <200908101032.12835.johan@herland.net> <7vmy67orwr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maqe4-0002Mm-9Y
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbZHKMjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbZHKMjy
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:39:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:45202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751509AbZHKMjv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:39:51 -0400
Received: (qmail invoked by alias); 11 Aug 2009 08:39:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp058) with SMTP; 11 Aug 2009 10:39:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cGpc2Ys/cUh8cpypspqbkf95aUNxuXcSqySLnug
	C1HSZ27hwmh/sf
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vmy67orwr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125539>

Hi,

On Mon, 10 Aug 2009, Junio C Hamano wrote:

> Johan Herland <johan@herland.net> writes:
> 
> > I'm somewhat agnostic on this issue. At the moment, I follow the P4 
> > cues, and use a config like this:
> >
> >     [remote "foo"]
> >         vcs = cvs
> >         cvsRoot = ":pserver:user@cvs.server.example.com/var/cvs/cvsroot"
> >         cvsModule = "bar"
> >         ...
> >
> > But I could just as well use a config like this instead:
> >
> >     [remote "foo"]
> >         url = "cvs::pserver:user@cvs.server.example.com/var/cvs/cvsroot#bar"
> >         ...
> >
> > Either is fine with me, although I suspect users might find the
> > current/first alternative easier to parse.
> 
> Ah, ok, that is a much better (rather, easier to understand for _me_) 
> example to illustrate what Daniel meant, and I can well imagine P4 
> counterpart of cvsRoot may resemble an URL even less than your cvsRoot 
> example does.
> 
> If the foreign system uses a single string as "the string to identify
> location", like the latter (which is a good example, even though I do not
> think a CVS folks write a reference to a module like you wrote), then I
> think it makes sense to use that form as remote.$name.url.  But if naming
> a location with a single simple string is an alien notion to the foreign
> system, I agree with Daniel that we do not gain much by trying to shoehorn
> them into a single remote.$name.url configuration.

Of course, it is always nice to be able to tell people: just clone the 
repository with

	git clone cvs::pserver:anonymous@cool.haxx.se:/cvsroot/curl#curl

Rather than telling them: "you know, it is really trivial once you 
understand the inner workings of Git.  Just follow this recipe for the 
moment, and you are all set up:

	1) mkdir curl
	2) cd curl
	3) git init
	4) git remote.origin.vcs cvs
	5) git remote.origin.cvsRoot :pserver:anonymous@cool.haxx.se:/cvsroot/curl
	6) git remote.origin.cvsModule curl
	7) git fetch origin
	8) git checkout --track origin/master

Oh, and please ignore that warning in the last step telling you that you 
are already on branch 'master', that is perfectly normal."

I don't know, but this sounds more and more like the complicator's glove 
to me (with the same reactions).

Ciao,
Dscho
