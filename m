From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] 0003 This patch is to allow 12 different OS's to compile
 and run git.
Date: Sat, 7 Jun 2008 21:46:48 -0600
Message-ID: <Pine.LNX.4.64.0806072143230.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
 <87bq2ez72u.fsf@jeremyms.com> <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
 <7vmylyrwkg.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806061718420.18454@xenau.zenez.com>
 <Pine.LNX.4.64.0806061822220.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806062043350.19665@iabervon.org>
 <Pine.LNX.4.64.0806061922290.18454@xenau.zenez.com> <7vzlpyouwf.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0806062015440.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806062316270.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 05:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Bse-00042k-NA
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 05:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbYFHDqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 23:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYFHDqu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 23:46:50 -0400
Received: from zenez.com ([166.70.62.2]:13558 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812AbYFHDqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 23:46:49 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 43CF8E543D; Sat,  7 Jun 2008 21:46:48 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 2F8DEE51DE;
	Sat,  7 Jun 2008 21:46:48 -0600 (MDT)
In-Reply-To: <alpine.LNX.1.00.0806062316270.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84250>

On Fri, 6 Jun 2008, Daniel Barkalow wrote:
> On Fri, 6 Jun 2008, Boyd Lynn Gerber wrote:
> > On Fri, 6 Jun 2008, Junio C Hamano wrote:
> > > Boyd Lynn Gerber <gerberb@zenez.com> writes:
> > > > diff --git a/git-compat-util.h b/git-compat-util.h
> > > > index 01c4045..b3cd7b3 100644
> > > > --- a/git-compat-util.h
> > > > +++ b/git-compat-util.h
> > > > @@ -39,7 +39,12 @@
> > > >  /* Approximation of the length of the decimal representation of this type. */
> > > >  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
> > > >  
> > > > -#if !defined(__APPLE__) && !defined(__FreeBSD__)
> > > > +/* Added for __USLC__ for any Novell devrived Compiler and Some Sys V 
> > > > +   Added _M_UNIX for any XENIX/SCO UNIX/OpenServer less than or equal
> > > > +   OpenServer 5.0.7  This is do avoided compiler hell like the other
> > > > +   OS's __APPLE__ and __FreeBSD__ */
> > > 
> > > We generally do not do changelog inside the code comment.
> > 
> > Where do you put your change log stuff, to explain why you made the 
> > change.  Maybe it is a bit left over from doing things for MySQL AB.
> 
> In the commit message. That is, if your commit message goes:
> 
>   Allow more systems to build git
> 
>   __USLC__ indicates a Novell-derived compiler or some SysV
>   __M_UNIX indicates XENIX/SCO UNIX/OpenServer before 5.0.7
>   Like Apple and BSD, both of these shouldn't have _XOPEN_SOURCE defined
> 
> then an interested user can use "git blame" on the file, and then read 
> that info in the commit message for the commit that introduced those 
> lines.
> 
> Also on the commit message: you should put the list of affected files 
> after a line with just "---", so it appears in the patch but not in the 
> commit; if we want to find out what the commit affects, we can use "git 
> log --stat" and find out for sure. The explanation of the sign-off can 
> probably go after the "---", too, although the "Signed-off-by" line should 
> be above it.

So I should have

---
Makefile

Add changes for System V, UnixWare, SCO OS's

---
git-compat-util.h

__USLC__ indicates UNIX System Labs Corperation (USLC), or a 
Novell-derived compiler and/or some SysV based OS's.

__M_UNIX indicates XENIX/SCO UNIX/OpenServer before 5.0.7 and prior 
release of and SCO OS.  It is used just like Apple and BSD, both of these 
shouldn't have _XOPEN_SOURCE defined.

---
progress.c

Changes for older OS's that do not support the current methods for 
allocation of memory.


--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
