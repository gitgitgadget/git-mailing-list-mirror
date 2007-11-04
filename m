From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 9/5] Migrate git-checkout.sh to use git-rev-parse --parseopt
 --keep-dashdash
Date: Sun, 4 Nov 2007 13:48:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041343470.4362@racer.site>
References: <1194043193-29601-5-git-send-email-madcoder@debian.org>
 <1194112219-19968-1-git-send-email-madcoder@debian.org>
 <1194112219-19968-2-git-send-email-madcoder@debian.org>
 <1194112219-19968-3-git-send-email-madcoder@debian.org>
 <1194112219-19968-4-git-send-email-madcoder@debian.org>
 <7v7ikytpz0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 14:49:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IofrE-000620-0l
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 14:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbXKDNt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 08:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755614AbXKDNt2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 08:49:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:50866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755503AbXKDNt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 08:49:27 -0500
Received: (qmail invoked by alias); 04 Nov 2007 13:49:25 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp002) with SMTP; 04 Nov 2007 14:49:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rrqF1yOZrpi+e5FN44hgYKoQu5gfXys+lVcsbA6
	g9d4N3MWLXJ7H+
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7ikytpz0.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63401>

Hi,

On Sun, 4 Nov 2007, Junio C Hamano wrote:

> Pierre Habouzit <madcoder@debian.org> writes:
> 
> > Also fix some space versus tabs issues.
> > ---
> >  git-checkout.sh |   99 +++++++++++++++++++++++++++----------------------------
> >  1 files changed, 49 insertions(+), 50 deletions(-)
> >
> > diff --git a/git-checkout.sh b/git-checkout.sh
> > index 8993920..5424745 100755
> > --- a/git-checkout.sh
> > +++ b/git-checkout.sh
> > @@ -1,6 +1,16 @@
> >  #!/bin/sh
> >  
> > -USAGE='[-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
> > +PARSEOPT_OPTS=--keep-dashdash
> > +OPTIONS_SPEC="\
> > +git-branch [options] [<branch>] [<paths>...]
> > +--
> > +b=          create a new branch started at <branch>
> > +l           create the new branchs reflog
> > +track       tells if the new branch should track the remote branch
> > +f           proceed even if the index or working tree is not HEAD
> > +m           performa  three-way merge on local modifications if needed
> > +q,quiet     be quiet
> > +"
> 
> Ok, so this is how PARSEOPT_OPTS gets used.

I also read in the docs:

> It takes on the standard input the specification of the options to parse
> and understand, and echoes on the standard ouput a line suitable for 
> `sh(1)` `eval` to replace the arguments with normalized ones.

Why not go the full nine yards and output something which when eval'ed 
sets the variables correctly (taking the variable names from the option 
names; long name if available, otherwise short one)?  It can also set the 
command line arguments to what's left after option parsing, with a "set" 
call.

And to prevent funny games with "PARSEOPT_OPTS=blabla git xyz", why not 
provide a function in git-sh-setup which takes the string as argument, and 
is called _after_ sourcing git-sh-setup?

Ciao,
Dscho
