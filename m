From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: FYI: Reply from HP-UX
Date: Thu, 17 Jan 2008 16:58:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171655570.5731@racer.site>
References: <20080117141143.38a88c7a@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jan 17 17:59:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFY58-00031A-Ra
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 17:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbYAQQ6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 11:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYAQQ6m
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 11:58:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:33333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751292AbYAQQ6l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 11:58:41 -0500
Received: (qmail invoked by alias); 17 Jan 2008 16:58:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 17 Jan 2008 17:58:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NpIgaanUNLLvPImpN8Y+at5+ua+z1cst7NJhnW5
	zQ/0ityZCxjpZy
X-X-Sender: gene099@racer.site
In-Reply-To: <20080117141143.38a88c7a@pc09.procura.nl>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70873>

Hi,

On Thu, 17 Jan 2008, H.Merijn Brand wrote:

> > I got git running on HP-UX 11.00, which still is our base for our Version
> > Control System (VCS)s. Most of the changes I made were incorporated into
> > the git mainline.  
> 
> I've had a look at the git 1.5.3.8 source code and there are several
> HP-UX issues with it:
> 
> * Use of gcc-specific features. Doesn't seem to want to compile nicely
>   with HP's ANSI C compiler.

If that would be a bit more specific, we might very well be able to fix 
it.  After all, AFAIK we do support some non-gcc compilers.

> * Failure of the configure/make to handle the lack of unsetenv() in
>   pre-11.31 HP-UX releases. Bizarrely, it does handle the lack of setenv()
>   and also has a compat/unsetenv.c for use by non-unsetenv()-capable OS'es,
>   but then configure and config.mak.in completely fail to use a NO_UNSETENV
>   variable like they should!

Didn't you provide them with a patch to Makefile making a run of 
./configure unnecessary?

> * Use of "-include config.mak.autogen" in the top-level Makefile doesn't
>   seem to actually include that file. I had to remove the leading "-" to
>   include it. Also had to stop "gmake clean" from deleting config.mak.autogen
>   otherwise a second "gmake clean" would fail :-(

That is strange.  The "-" in front means that the exit status of this 
command is ignored.  So it is no surprise that it fails when you remove 
the "-".  OTOH it is quite a surprise that it does not work when leaving 
it alone...  What's the output?

> * Have to force use of /usr/local/bin/perl, otherwise it picks up /usr/bin/perl
>   which the build system doesn't like.

This should be handled in your patch to Makefile IMHO.

> * "gmake check" requires porting "sparse" at
>   http://www.kernel.org/pub/software/devel/sparse/ which could be "fun".

You don't need to make "check".  You need to make "test".

Ciao,
Dscho
