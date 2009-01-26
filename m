From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -i --root: fix check for number of
 arguments
Date: Mon, 26 Jan 2009 01:49:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260148290.14855@racer>
References: <alpine.DEB.1.00.0901260029480.14855@racer> <alpine.DEB.1.00.0901260032000.14855@racer> <200901260108.07402.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 26 01:50:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRFgZ-00009j-Ue
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 01:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbZAZAtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 19:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbZAZAtQ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 19:49:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:53102 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbZAZAtP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 19:49:15 -0500
Received: (qmail invoked by alias); 26 Jan 2009 00:49:13 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp011) with SMTP; 26 Jan 2009 01:49:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+U5c9cvMyUGSsiXrh4K60oRvoOuHGP7bUfN7LR5x
	pfhw4EV611lAxk
X-X-Sender: gene099@racer
In-Reply-To: <200901260108.07402.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107150>

Hi,

On Mon, 26 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  git-rebase--interactive.sh |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 6e2bf25..5df35b2 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -571,7 +571,8 @@ first and then run 'git rebase --continue' again."
> >  		;;
> >  	--)
> >  		shift
> > -		test ! -z "$REBASE_ROOT" -o $# -eq 1 -o $# -eq 2 || usage
> > +		test -z "$REBASE_ROOT" -a $# -ge 1 -a $# -le 2 ||
> > +		test ! -z "$REBASE_ROOT" -a $# -le 1 || usage
> >  		test -d "$DOTEST" &&
> >  			die "Interactive rebase already started"
> 
> Acked-by: Thomas Rast <trast@student.ethz.ch>
> 
> I'll postpone 1/2 till I've had enough sleep to check whether
> --continue ever needed to know about --root, and either remove or fix
> the remembering.  (Sorry for the noise.)

It does need to remember, as pick_one wants to look at the parent to be 
able to fast-forward.

But the sane fix is to add a file "$DOTEST"/root in case we're running 
under --root.

Ciao,
Dscho
