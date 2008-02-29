From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/40] Compile some programs only conditionally.
Date: Fri, 29 Feb 2008 00:47:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290046180.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-3-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281146050.22527@racer.site> <200802282130.10225.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 01:49:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUtRG-0002OY-GE
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 01:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbYB2AsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 19:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763518AbYB2AsT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 19:48:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:60400 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763414AbYB2AsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 19:48:15 -0500
Received: (qmail invoked by alias); 29 Feb 2008 00:48:13 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp044) with SMTP; 29 Feb 2008 01:48:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tCZULULjtbfQZSkF2YheVKCM93adfLYHlA59mbc
	jgqyP5xXJD/VRu
X-X-Sender: gene099@racer.site
In-Reply-To: <200802282130.10225.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75477>

Hi,

On Thu, 28 Feb 2008, Johannes Sixt wrote:

> On Thursday 28 February 2008 12:57, Johannes Schindelin wrote:
>
> > On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > > On MinGW, we won't compile some programs.
> >
> > This explanation is good (even if I recall that we compile 
> > git-daemon.exe just fine now).
> >
> > > @@ -264,7 +263,7 @@ PROGRAMS = \
> > >  	git-update-server-info$X \
> > >  	git-upload-pack$X \
> > >  	git-pack-redundant$X git-var$X \
> > > -	git-merge-tree$X git-imap-send$X \
> > > +	git-merge-tree$X \
> >
> > We do not compile git-imap-send because MinGW lacks socketpair() and 
> > getpass().  Why not say it explicitely, and have a NO_SOCKETPAIR 
> > variable? Likewise, for git-daemon we should say NO_SYSLOG.
> 
> Where are NO_WNOHANG, NO_GETPASS, NO_SELECT, NO_SIGCHLD, NO_EXECVE etc 
> in your list? A condition on MINGW32 is certainly sufficient.

Just pick the most difficult one.  But just saying "this does not work on 
MinGW32" does not help people who want to help.

> > NOTE: I think that both programs are fixable, but only git-daemon is 
> > important enough that I would like to see patch of the "daemon" branch 
> > in 4msysgit.git cherry picked into this series (maybe we should 
> > implement a compat/syslog.c using the ReportEvent() function of the 
> > win32 API?).
> 
> openlog() etc. is only one problem in git-daemon. It also depends on 
> SIGCHLD, a non-blocking waitpid, and a lot more. The patch that is in 
> 4msysgit.git allows only a single connection, IIRC, after which it 
> terminates. But I also think that git-daemon can be made more complete 
> on Windows, but it certainly requires a major surgery.

Okay, I did not look closely enough.  But even a single-connection daemon 
is better than no daemon, no?

Ciao,
Dscho

