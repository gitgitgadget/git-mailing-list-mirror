From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: take the first populated line of the
 description
Date: Wed, 5 Mar 2008 17:51:02 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803051750030.15786@racer.site>
References: <1204727050.0@pinky> <alpine.LSU.1.00.0803051544160.15786@racer.site> <20080305164316.GH17931@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 17:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWwqX-0007ve-NP
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 17:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957AbYCEQvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 11:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757050AbYCEQvF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 11:51:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:37334 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756957AbYCEQvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 11:51:02 -0500
Received: (qmail invoked by alias); 05 Mar 2008 16:50:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 05 Mar 2008 17:50:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8A1VDLki8FyVmoVGU/SMBoMcZOkykSh/MbspAl8
	UqDotwyVOjTIPJ
X-X-Sender: gene099@racer.site
In-Reply-To: <20080305164316.GH17931@shadowen.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76244>

Hi,

On Wed, 5 Mar 2008, Andy Whitcroft wrote:

> On Wed, Mar 05, 2008 at 03:48:00PM +0100, Johannes Schindelin wrote:
> 
> > On Wed, 5 Mar 2008, Andy Whitcroft wrote:
> > 
> > > diff --git a/builtin-shortlog.c b/builtin-shortlog.c
> > > index af31aba..b22b0ed 100644
> > > --- a/builtin-shortlog.c
> > > +++ b/builtin-shortlog.c
> > > @@ -70,11 +70,12 @@ static void insert_one_record(struct shortlog *log,
> > >  	else
> > >  		free(buffer);
> > >  
> > > +	/* Skip any leading whitespace, including any blank lines. */
> > > +	while (*oneline && isspace(*oneline))
> > > +		oneline++;
> > >  	eol = strchr(oneline, '\n');
> > >  	if (!eol)
> > >  		eol = oneline + strlen(oneline);
> > > -	while (*oneline && isspace(*oneline) && *oneline != '\n')
> > > -		oneline++;
> > >  	if (!prefixcmp(oneline, "[PATCH")) {
> > >  		char *eob = strchr(oneline, ']');
> > >  		if (eob && (!eol || eob < eol))
> > 
> > Why do you move the code around?  Makes it harder to read your patch.  
> > Besides, you now strip empty lines at the beginning of the commit 
> > messages, right?  Who produces such a thing?
> 
> I've not moved the code as such.

Well, it sure looks like that.  Maybe you want to make it look like that 
even more?

> The point of the patch is to strip the empty lines at the start of the 
> commit.  I am ending up with them in my repo mostly due to imcompetant 
> users of SVN I suspect.  The main driver is that I have those and the 
> original non-C version coped and the builtin does not.
> 
> Now if people think that its a stupid idea I might suggest it could be 
> optional?

No, I think with an explanation like this in the commit message, it is 
good as-is.

Ciao,
Dscho

