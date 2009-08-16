From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git_remote_cvs: Honor DESTDIR in the Makefile
Date: Sun, 16 Aug 2009 23:21:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908162316030.8306@pacific.mpi-cbg.de>
References: <7v7hx35ym1.fsf@alter.siamese.dyndns.org> <1250455088-23457-1-git-send-email-davvid@gmail.com> <alpine.DEB.1.00.0908162251360.8306@pacific.mpi-cbg.de> <20090816210300.GB23522@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, johan@herland.net, git@vger.kernel.org,
	barkalow@iabervon.org, mhagger@alum.mit.edu
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 23:20:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcn9T-0005GQ-Lk
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 23:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbZHPVUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 17:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbZHPVUX
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 17:20:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:43164 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751789AbZHPVUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 17:20:22 -0400
Received: (qmail invoked by alias); 16 Aug 2009 21:20:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 16 Aug 2009 23:20:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19v+G97bTdvNKSyGyHjqFpywMy4vRg95X87W16jnO
	VEWaJpWgfnxRfH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090816210300.GB23522@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126077>

Hi,

On Sun, 16 Aug 2009, David Aguilar wrote:

> On Sun, Aug 16, 2009 at 10:55:29PM +0200, Johannes Schindelin wrote:
> 
> > On Sun, 16 Aug 2009, David Aguilar wrote:
> > 
> > > diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
> > > index 8dbf3fa..f52c096 100644
> > > --- a/git_remote_cvs/Makefile
> > > +++ b/git_remote_cvs/Makefile
> > > @@ -3,6 +3,15 @@
> > >  #
> > >  pysetupfile:=setup.py
> > >  
> > > +# Setup the DESTDIR for Python.
> > > +ifeq ($(DESTDIR),)
> > > +PYTHON_DESTDIR = /
> > 
> > Hmm.  I think this would break on msysGit.  Not that anybody worked on 
> > getting Python to compile on msysGit.
> > 
> > (Just to make sure you understand the issue: on msysGit, we set prefix to 
> > "" (and I think DESTDIR somehow ends up taking on the same value).  Now, 
> > when DESTDIR is set to "/" and something wants to be copied to 
> > $(DESTDIR)/something, the latter expands to //something, which tells MSys 
> > not to expand //something to the correct Windows path.
> 
> 
> I see.  Hmm.. setup.py is a real pain.
> 
> I'll see if we rework this so that we end up passing "" to
> --root instead of /.  I'm going to be gone for a few hours so
> probably won't be able to try it out until tonight.

Thinking about it a bit more: you might not need to do anything.   I think 
that msysGit should move to prefix = /mingw anyway.

I hesitated to do that earlier, as all .perl and .sh scripts need MSys.  
But the Git .exe files are MinGW programs, so technically they belong into 
/mingw/bin/ anyway.

But the issue would only really become relevant if anybody supported 
Python on msysGit (and thereby git-remote-cvs, before that, we cannot make 
use of it).

Just a thing to keep in mind.

Ciao,
Dscho
