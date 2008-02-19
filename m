From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH(TIC)] push: annoy all users by deprecating the default
 semantics
Date: Tue, 19 Feb 2008 16:54:14 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191651550.30505@racer.site>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com> <20080219150826.GA24499@sigill.intra.peff.net>
 <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com> <20080219152549.GC24499@sigill.intra.peff.net> <alpine.LSU.1.00.0802191610480.30505@racer.site> <20080219163743.GA31668@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jason Garber <jgarber@ionzoft.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVkJ-0003kY-6M
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYBSQyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYBSQyb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:54:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:56413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753700AbYBSQya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:54:30 -0500
Received: (qmail invoked by alias); 19 Feb 2008 16:54:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 19 Feb 2008 17:54:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18h6lUTc/8hfkFBKdJjZm3t1DpHnGpDZOne76auDW
	vP9iCMA9hOQfxj
X-X-Sender: gene099@racer.site
In-Reply-To: <20080219163743.GA31668@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74437>

Hi,

On Tue, 19 Feb 2008, Jeff King wrote:

> On Tue, Feb 19, 2008 at 04:14:35PM +0000, Johannes Schindelin wrote:
> 
> > Subject: [PATCH(TIC)] push: annoy all users by deprecating the default
> 
> Heh. It is a good sign that git has made the patch-generation workflow 
> so pleasant to use that we are willing to make patches for the sake of 
> humor. :)

Yeah, code talks... even humourously ;-)

> > 	FWIW I would resist, just because that config option would change
> > 	the _semantics_ of a git program.
> > 
> > 	Just think about the IRC channel.  "How do I update only HEAD?" --
> > 	"Just say 'git push'" -- "No, that updates nothing" -- "Well, 
> > 	works here" -- "But not here!" ... "Can _nobody_ help me?"
> 
> Just say "git push origin HEAD"?

The point is: if that becomes the default (with a certain config option), 
people will get used to typing "git push".  They will not even _know_ 
about the explicit form.

> > diff --git a/builtin-push.c b/builtin-push.c
> > index c8cb63e..7bcb141 100644
> > --- a/builtin-push.c
> > +++ b/builtin-push.c
> > @@ -134,6 +134,14 @@ int cmd_push(int argc, const char **argv, const char *prefix)
> >  		flags |= TRANSPORT_PUSH_ALL;
> >  	if (mirror)
> >  		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
> > +	if (!all && argc < 2)
> > +		warning("Pushing without branch names is deprecated.\n"
> > +			"Too many users just assumed what it should do\n"
> > +			"according to them, got burned, and blamed us,\n"
> > +			"the good git developers.\n\n"
> > +			"So everybody has to suffer now, and get used to\n"
> > +			"new semantics.\n\n"
> > +			"Thank you for your time.\n");
> >  
> >  	if (argc > 0) {
> >  		repo = argv[0];
> 
> You forgot to add a "--matching" option in case people want to
> explicitly request the old behavior. ;P

See followup.

BTW if that is really the way to go, we will have to have a _long_ period 
(I am talking about 6-12 _months_ if not more) where there _must not_ be a 
default action for git-push.  Otherwise people _will_ get more confused 
than necessary.

Ciao,
Dscho
