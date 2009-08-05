From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 5 Aug 2009 22:36:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052234470.8306@pacific.mpi-cbg.de>
References: <20090805181755.22765.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:36:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnDj-0007rx-Tv
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbZHEUgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZHEUgO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:36:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:37816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751903AbZHEUgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:36:14 -0400
Received: (qmail invoked by alias); 05 Aug 2009 20:36:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 05 Aug 2009 22:36:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4RHcCtWy4sKwmvzuVwSWDwrXMHDCO/dy1xW/fcR
	13ai1JrBhwhM4O
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090805181755.22765.qmail@science.horizon.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124971>

Hi,

On Wed, 5 Aug 2009, George Spelvin wrote:

> > Three classes of people compile git from the source:
> >
> > * People who want to be on the bleeding edge and compile git for
> >   themselves, even though they are on mainstream platforms where they
> >   could choose distro-packaged one;
> >
> > * People who produce binary packages for distribution.
> >
> > * People who are on minority platforms and have no other way to get git
> >   than compiling for themselves;
> >
> > We do not have to worry about the first two groups of people.  It won't
> > be too involved for them to install Perl on their system; after all they
> > are already coping with asciidoc and xmlto ;-)
> 
> Actually, I'd get rid of the perl entirely, but I'm not sure how
> necessary the other-assembler-syntax features are needed by the
> folks on MacOS X and Windows (msysgit).

Don't worry for MacOSX and msysGit (or Cygwin, for that matter): all of 
them use GCC.

> > We can continue shipping mozilla one to help the last group.
> 
> Of course, we always need a C fallback.  Would you like a faster one?

Is that a trick question?

:-)

> > In the Makefile, we say:
> >
> >    # Define NO_OPENSSL environment variable if you do not have OpenSSL.
> >    # This also implies MOZILLA_SHA1.
> >
> > and with your change, we would start implying STANDALONE_OPENSSL_SHA1
> > instead.  But if MOZILLA_SHA1 was given explicitly, we could use that.
> 
> Well, I'd really like to auto-detect the processor.  Current gcc's
> "gcc -v" output includes a "Target: " line that will do nicely.  I can,
> of course, fall back to C if it fails, but is there a significant user
> base using a non-GCC compiler?

Do you really want to determine which processor to optimize for at compile 
time?  Build system and target system are often different...

Ciao,
Dscho
