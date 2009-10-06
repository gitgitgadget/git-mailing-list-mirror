From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 6 Oct 2009 11:16:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910061112570.4985@pacific.mpi-cbg.de>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de> <20091005225611.GB29335@coredump.intra.peff.net> <200910060932.24377.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 06 11:20:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv6Di-0004xG-UY
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 11:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723AbZJFJPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 05:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756719AbZJFJPW
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 05:15:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:58367 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756715AbZJFJPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 05:15:21 -0400
Received: (qmail invoked by alias); 06 Oct 2009 09:14:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 06 Oct 2009 11:14:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YCaADbGtYQbuTFE+iQRJLP2ObdWUj3l5h4fO8f+
	bByIMkQKl6j9Os
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200910060932.24377.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129613>

Hi,

On Tue, 6 Oct 2009, Thomas Rast wrote:

> Jeff King wrote:
> > On Mon, Oct 05, 2009 at 11:17:09PM +0200, Johannes Schindelin wrote:
> > 
> > > > $ git checkout next
> > > > error: pathspec 'next' did not match any file(s) known to git.
> > > 
> > > Actually, we should really think long and hard why we should not 
> > > automatically check out the local branch "next" in that case.  I mean, 
> > > really long and hard, and making sure to take user-friendliness into 
> > > account at least as much as simplicity of implementation.
> > 
> > Some devil's advocate questions:
> > 
> >   1. How do we find "origin/next" given "next"? What are the exact
> >      lookup rules? Do they cover every case? Do they avoid surprising
> >      the user?
> > 
> >   2. What do we do if our lookup is ambiguous (e.g., "origin/next" and
> >      "foobar/next" both exist)?
> > 
> >   3. If our lookup does have ambiguities or corner cases, is it better
> >      to simply be suggesting to the user, rather than proceeding with an
> >      action?
> 
> If I may add another:
> 
> 4. Are there any (scripted?) use-cases where git-checkout should fail
>    because it was given an invalid branch name?
> 
> The following gives a hint, though they could of course be fixed and
> the ^0 case doesn't really count:
> 
>   $ git grep 'git checkout .*||' -- "*.sh"
>   git-bisect.sh:          git checkout "$start_head" -- || exit
>   git-rebase--interactive.sh:                     output git checkout $first_parent 2> /dev/null ||
>   git-rebase--interactive.sh:                     output git checkout "$1" ||
>   git-rebase.sh:git checkout -q "$onto^0" || die "could not detach HEAD"
>   t/t2007-checkout-symlink.sh:git checkout -f master || exit

Actually, in said cases (with exception of the test case, which should be 
fine, however, having no remote branches), I would expect the user to be 
grateful if the DWIMery would happen.

I have to clarify something here: I am not proposing to include a patch 
that does that DWIMery.  We need to discuss the downsides and upsides 
until we can be pretty certain that it does more good than harm.

Unfortunately, this list does not seem to be very inviting to pure users, 
who I hoped would chime in on this issue.

Ciao,
Dscho
