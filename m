From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [HALF A PATCH] Teach the '--exclude' option to 'diff
 --no-index'
Date: Fri, 20 Feb 2009 16:03:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902201555490.6302@intel-tinevez-2-302>
References: <499E92FD.8000900@alum.mit.edu> <cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de> <20090220145331.GA3515@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 16:05:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaWvy-0007PK-9x
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 16:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbZBTPDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 10:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbZBTPD3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 10:03:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:59877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752029AbZBTPD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 10:03:29 -0500
Received: (qmail invoked by alias); 20 Feb 2009 15:03:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp056) with SMTP; 20 Feb 2009 16:03:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fbrxLapafmtfMtrmYH7mlXoYqbH2be4aKbKAc+P
	wTRozG2WFsXSzd
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090220145331.GA3515@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110853>

Hi,

On Fri, 20 Feb 2009, Jeff King wrote:

> On Fri, Feb 20, 2009 at 03:12:28PM +0100, Johannes Schindelin wrote:
> 
> > 	Michael wrote:
> > 
> > 	> I can't think offhand of a more portable tool that could replace 
> > 	> "diff -r -x" here (suggestions, anyone?).
> > 
> > 	Maybe something like this?
> 
> Great. Using "git diff" was my first thought, too.

Heh :-)

I have to admit that I had something pretty ugly involving find and grep 
in mind at first, then something equally appalling using GIT_WORKTREE and 
GIT_INDEX_FILE.

> > 	Note: before it can be included in git.git, documentation and 
> > 	tests have to be added; also, it might be a good idea to extend it 
> > 	to the "non-no-index" case (maybe I can beat Peff in the number of 
> > 	double negations one day...)
> 
> Maybe a config option "diff.denyNonIndexExclude = false"? *ducks*

How about diffNoIndex.denyNonIndexNonExclude = !true?  *swans*

> But more seriously, how would a user expect this to interact with 
> .gitignore? I know gitignore is about ignoring untracked files, but I 
> can't help but feel the two have something in common. But maybe not. I'm 
> sick today and my brain is not working very well.

I think that the -x option with regular (not --no-index) diff would be 
a little different.  .gitignore is for "git add" time, while "git diff" 
happily ignores .gitignore.

Besides, the -x option only works on the basenames (as I implemented it; 
no idea if GNU diff works the same way, but from Michael's patch it looks 
like it does).

BTW I just realized that I forgot to add a die() when !no_index && 
basename_excludes.

Ciao,
Dscho
