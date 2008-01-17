From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: FYI: Reply from HP-UX
Date: Thu, 17 Jan 2008 18:14:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171811480.5731@racer.site>
References: <20080117141143.38a88c7a@pc09.procura.nl> <alpine.LSU.1.00.0801171655570.5731@racer.site> <20080117185514.621525a6@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZG6-0000GN-Md
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbYAQSOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbYAQSOG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:14:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:46723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752235AbYAQSOE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 13:14:04 -0500
Received: (qmail invoked by alias); 17 Jan 2008 18:14:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 17 Jan 2008 19:14:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SHURFUYeSWYk2GAtd6KWBDHz0zdpionNoe04+H6
	XDyEOFxnY5gdfz
X-X-Sender: gene099@racer.site
In-Reply-To: <20080117185514.621525a6@pc09.procura.nl>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70890>

Hi,

On Thu, 17 Jan 2008, H.Merijn Brand wrote:

> On Thu, 17 Jan 2008 16:58:36 +0000 (GMT), Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Thu, 17 Jan 2008, H.Merijn Brand wrote:
> > 
> > > * Have to force use of /usr/local/bin/perl, otherwise it picks up 
> > > /usr/bin/perl which the build system doesn't like.
> > 
> > This should be handled in your patch to Makefile IMHO.
> 
> You mean this: ?
> --8<---
> --- Makefile.orig       2007-12-17 07:03:21 +0100
> +++ Makefile    2007-12-17 18:04:37 +0100
> @@ -401,6 +401,19 @@ EXTLIBS =
>  # because maintaining the nesting to match is a pain.  If
>  # we had "elif" things would have been much nicer...
> 
> +ifeq ($(uname_S),HP-UX)
> +       # HP-UX
> +       BASIC_LDFLAGS  += -L/usr/local/ssl/lib -L/usr/local/lib
> +#      EXTLIBS        += -lc_r -lgcc
> +       NO_HSTRERROR    = YesPlease
> +       NO_ICONV        = YesPlease
> +       NO_INET_NTOP    = YesPlease
> +       NO_INET_PTON    = YesPlease
> +       NO_UNSETENV     = YesPlease
> +       NO_STRTOULL     = YesPlease
> +       NO_STRTOUMAX    = YesPlease
> +       NO_PREAD        = YesPlease
> +endif

Almost:

+	PERL_PATH = /usr/local/bin/perl

> -->8---
> 
> Note that this was on HP-UX 11.00/32. A 64bit env on 11.23/64 IPF will be
> different.
> 
> I had no problem with my perl, as I specifically told that on the configure
> line:
> 
> $ ./configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl

I guess that my suggestion doesn't work... Your perl is not in 
/usr/local/bin...

Ciao,
Dscho
