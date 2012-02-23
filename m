From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] mingw: work around stat-limitation
Date: Thu, 23 Feb 2012 16:37:39 -0600 (CST)
Message-ID: <alpine.DEB.1.00.1202231636310.3340@s15462909.onlinehome-server.info>
References: <1330028744-5280-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1202231525320.3340@s15462909.onlinehome-server.info> <CABPQNSZ+=no5PKkaa8_44FbOzh_W4A5knoxKgDQ2wTvOaeKdew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
	msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 23:37:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0hIJ-0007uu-UU
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 23:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab2BWWhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 17:37:42 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:35650 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752784Ab2BWWhl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 17:37:41 -0500
Received: (qmail invoked by alias); 23 Feb 2012 22:37:39 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp001) with SMTP; 23 Feb 2012 23:37:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18446FvbiU4w0D9vDkb2BYmNSYaiMts/0iMUke8/0
	G4My8WwX4iwGaY
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSZ+=no5PKkaa8_44FbOzh_W4A5knoxKgDQ2wTvOaeKdew@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191402>

Hi kusma,

On Thu, 23 Feb 2012, Erik Faye-Lund wrote:

> On Thu, Feb 23, 2012 at 10:26 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 23 Feb 2012, Erik Faye-Lund wrote:
> >
> >> Our stat implementation for Windows always sets st_ino to 0. This
> >> means that checking if isatty(0) and comparing the reported inodes
> >> of stdout and stdin is not sufficient to detect that both are
> >> pointing to the same TTY.
> >>
> >> Luckily, there's only one console on Windows, so adding a check for
> >> isatty(1) should do the trick. For platforms where inodes are
> >> reported correctly, this should still be correct.
> >
> > Sorry to ask so stupidly, but why does isatty(1) work and isatty(0) does
> > not? Should they not access the very same console object?
> >
> 
> The point is that they might not. The old test would draw the wrong
> conclusion if isatty(0) was true, but isatty(1) was not because it
> used st_ino to verify that stdin and stdout pointed to the same
> terminal. The reason it did that was to catch cases where stdin and
> stdout pointed to different terminals, AFAICT. Not checking isatty(1)
> was simply an optimization, which works when st_ino is filled out
> correctly.
> 
> On Windows there is only one terminal, so it's sufficient to check if
> both are connected.

Ah, okay. Thanks for answering so patiently!

ACK.

Ciao,
Dscho
