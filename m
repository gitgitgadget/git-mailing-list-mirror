From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFT] cvsserver: only allow checkout of branches
Date: Thu, 4 Oct 2007 17:32:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710041731550.4174@racer.site>
References: <200710031348.50800.wielemak@science.uva.nl>
 <46823.146.50.26.20.1191496739.squirrel@webmail.science.uva.nl>
 <Pine.LNX.4.64.0710041352480.4174@racer.site> <200710041506.13154.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0710041622070.4174@racer.site> <20071004161812.GA31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Wielemaker <wielemak@science.uva.nl>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 18:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdTcq-0000j9-5M
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 18:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934AbXJDQcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 12:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758055AbXJDQcX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 12:32:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:37416 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757501AbXJDQcW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 12:32:22 -0400
Received: (qmail invoked by alias); 04 Oct 2007 16:32:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 04 Oct 2007 18:32:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5Ul5jgxm5Ig7+Lv2afj48b6/XZMi5KG8GoOtbzf
	qD5xKUS5iuz3ZN
X-X-Sender: gene099@racer.site
In-Reply-To: <20071004161812.GA31659@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59980>

Hi,

On Thu, 4 Oct 2007, Frank Lichtenheld wrote:

> On Thu, Oct 04, 2007 at 04:29:04PM +0100, Johannes Schindelin wrote:
> > 	Cc'ed Frank, who is de-facto maintainer (according to shortlog) 
> > 	and Martin, who started it all IIRC.
> > 
> > diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> > index 13dbd27..869690c 100755
> > --- a/git-cvsserver.perl
> > +++ b/git-cvsserver.perl
> > @@ -770,6 +770,14 @@ sub req_co
> >  
> >      $log->debug("req_co : " . ( defined($data) ? $data : "[NULL]" ) );
> >  
> > +    if( system("git", "rev-parse", "--verify", "refs/heads/$module" ) != 0 )
> > +    {
> > +	$log->warn("Checkout failed: $module is not a branch");
> > +	print "error 1 Checkout failed: $module is not a branch\n";
> > +	chdir "/";
> > +	exit;
> > +    }
> > +
> >      $log->info("Checking out module '$module' ($state->{CVSROOT}) to '$checkout_path'");
> >  
> >      $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
> 
> Looks good, haven't tested it yet, though. Care to add a testcase
> or should I take care of that?

I would be eternally thankful if you could add the test case, since I am 
really short on time.

Ciao,
Dscho
