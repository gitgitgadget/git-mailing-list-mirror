From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Refactor struct transport_ops inlined into struct
 transport
Date: Thu, 20 Sep 2007 11:59:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709201159260.28395@racer.site>
References: <20070919044931.GB17107@spearce.org> <Pine.LNX.4.64.0709191409590.28395@racer.site>
 <Pine.LNX.4.64.0709192226150.21941@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 13:00:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYJm4-00088y-O1
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 13:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbXITLAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 07:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbXITLAn
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 07:00:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:35172 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750758AbXITLAm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 07:00:42 -0400
Received: (qmail invoked by alias); 20 Sep 2007 11:00:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 20 Sep 2007 13:00:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18loRl0TBcluYzq9+CWhVOJGuKtWQuO3HRcvnh5YF
	pADTxhUIlOdqtI
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709192226150.21941@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58768>

Hi,

On Wed, 19 Sep 2007, Daniel Barkalow wrote:

> On Wed, 19 Sep 2007, Johannes Schindelin wrote:
> 
> > On Wed, 19 Sep 2007, Shawn O. Pearce wrote:
> > 
> > > diff --git a/transport.c b/transport.c
> > > index cc76e3f..d8458dc 100644
> > > --- a/transport.c
> > > +++ b/transport.c
> > > @@ -44,8 +44,6 @@ static int disconnect_walker(struct transport *transport)
> > >  	return 0;
> > >  }
> > >  
> > > -static const struct transport_ops rsync_transport;
> > > -
> > >  static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
> > >  	const char **argv;
> > >  	int argc;
> > > @@ -431,18 +406,31 @@ struct transport *transport_get(struct remote *remote, const char *url)
> > >  	ret->url = url;
> > >  
> > >  	if (!prefixcmp(url, "rsync://")) {
> > > -		ret->ops = &rsync_transport;
> > > +		/* not supported; don't populate any ops */
> > > +
> > 
> > That is sneaky.  What are the reasons to remove rsync support?  I know it 
> > is deprecated, but I'd still like to have it, especially for initial 
> > clones on small-RAMed machines.
> 
> It never got implemented in a way called from C. This is just removing the 
> pointer to the empty struct where support would go. If anybody knows 
> enough about interfacing with rsync to write the necessary functions, it 
> can be restored.

Okay, will do once I find the time.

Ciao,
Dscho
