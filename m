From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Tue, 5 Jun 2007 03:56:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706050345250.4046@racer.site>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
 <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
 <alpine.LFD.0.98.0706040857380.23741@woody.linux-foundation.org>
 <20070604175751.GL19935@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.98.0706041336440.23741@woody.linux-foundation.org>
 <20070604212121.GA31852@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 04:58:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvPFx-0006hC-Md
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 04:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873AbXFEC6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 22:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757767AbXFEC6e
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 22:58:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:37228 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754340AbXFEC6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 22:58:33 -0400
Received: (qmail invoked by alias); 05 Jun 2007 02:58:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 05 Jun 2007 04:58:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DyfAPYg6DLUq1xQrw+tiyMGmnardjD0gSa7Bzjl
	fkd3DKId9nt6o7
X-X-Sender: gene099@racer.site
In-Reply-To: <20070604212121.GA31852@dspnet.fr.eu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49150>

Hi,

On Mon, 4 Jun 2007, Olivier Galibert wrote:

> On Mon, Jun 04, 2007 at 01:45:26PM -0700, Linus Torvalds wrote:
>
> > I'd like to point out some more upsides and downsides of "git rebase".
> > 
> > Downsides:
> > 
> >  - you're rewriting history, so you MUST NOT have made your pre-rebase 
> >    changes available publicly anywhere else (or you are in a world of 
> >    pain with duplicate history and tons of confusion)
> 
> Wouldn't it be possible to register the rebase somewhere (weak parent? 
> some kind of note not influencing the sha1 ?) that pull/merge could 
> follow?

Actually, with reflogs (if you did not explicitely disable them), you 
should have the information already.

> Rebases and cherry-picking are a special kind of merge, so maybe it can 
> be handled like one where it counts...

There is something I have to add as a real disadvantage in rebase:

Usually you are expected to test your commits. So, say that you work on 
some patch series, and produce 3 well tested patches. Then you fetch 
upstream and realize it advanced by some commits, and rebase your three 
patches.

However, _none_ of your patches is well tested, because there is a quite 
real chance that your patches interact _badly_ with the patches you just 
fetched.

And if that is the case, git-bisect can very well attribute it to a wrong 
patch, either because more than one patch is bad, or because the last 
patch in your series _exposes_ the bug (but does not _introduce_ it).

Ciao,
Dscho
