From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Sat, 9 Aug 2008 02:16:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808090212060.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <200808080148.27384.trast@student.ethz.ch> <200808081614.44422.trast@student.ethz.ch> <alpine.DEB.1.00.0808081632580.24820@pacific.mpi-cbg.de.mpi-cbg.de> <200808082037.49918.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Wielemaker <J.Wielemaker@uva.nl>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 09 02:12:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRc4h-00024f-Nx
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 02:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbYHIALt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 20:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbYHIALt
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 20:11:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:34872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754604AbYHIALs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 20:11:48 -0400
Received: (qmail invoked by alias); 09 Aug 2008 00:11:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 09 Aug 2008 02:11:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3sSh1CYm38crWCkp4yNJJ46zjSMhe9IcU/AmA8t
	3VlX+9LNcyXTJ/
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <200808082037.49918.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91730>

Hi,

On Fri, 8 Aug 2008, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > On Fri, 8 Aug 2008, Thomas Rast wrote:
> > 
> > > I think a more careful use of rev-list -1 is actually a correct and 
> > > easy way to figure out an ancestor.
> > 
> > I have not looked at your patch closely, or at your explanation, but I 
> > am really certain that every attempt to replace the --boundary with a 
> > -1 must fail.
> > 
> > Let me show you why I think that.  Just look at this history:
> > 
> > A - B - C
> >   /
> > D
> >
> > > > Where all commits except B touch the inside directory.  Two 
> > > > options:
> 
> 'rev-list' "solves" this problem for us.  At the point where we are 
> rewriting the branch pointers, commits have already been rewritten to 
> whatever 'git rev-list --parents -- $subdir' told us to make them.  I 
> think there are only two cases for its output:
> 
> (a) Both A and D bring the same subdirectory contents.  'rev-list
>     --parents -- $subdir' drops one side of the merge during pruning. It 
>     does not look past the merge to see whether the contents were 
>     arrived at via different changesets.  Thus the history becomes
> 
>       A' -- C'
> 
>       D'
> 
>     and even that only if D was reachable by a different ref,
>     otherwise D' is simply dropped.

And this is what I call wrong.  Simply dropping one side of the equation 
is not what I call "sane".

If you drop information, you are disagreeing with "content is king".

But hey, if other people agree with you, and this kind of thinking ends 
up in Git proper, I can still resort to other DVCSes.

Ciao,
Dscho
