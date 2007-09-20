From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/5] Refactor struct transport_ops inlined into struct
 transport
Date: Wed, 19 Sep 2007 22:33:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709192226150.21941@iabervon.org>
References: <20070919044931.GB17107@spearce.org> <Pine.LNX.4.64.0709191409590.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 04:33:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYBqt-0003Dk-SH
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 04:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbXITCdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 22:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbXITCdK
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 22:33:10 -0400
Received: from iabervon.org ([66.92.72.58]:41673 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbXITCdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 22:33:09 -0400
Received: (qmail 29567 invoked by uid 1000); 20 Sep 2007 02:33:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Sep 2007 02:33:08 -0000
In-Reply-To: <Pine.LNX.4.64.0709191409590.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58747>

On Wed, 19 Sep 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 19 Sep 2007, Shawn O. Pearce wrote:
> 
> > diff --git a/transport.c b/transport.c
> > index cc76e3f..d8458dc 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -44,8 +44,6 @@ static int disconnect_walker(struct transport *transport)
> >  	return 0;
> >  }
> >  
> > -static const struct transport_ops rsync_transport;
> > -
> >  static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
> >  	const char **argv;
> >  	int argc;
> > @@ -431,18 +406,31 @@ struct transport *transport_get(struct remote *remote, const char *url)
> >  	ret->url = url;
> >  
> >  	if (!prefixcmp(url, "rsync://")) {
> > -		ret->ops = &rsync_transport;
> > +		/* not supported; don't populate any ops */
> > +
> 
> That is sneaky.  What are the reasons to remove rsync support?  I know it 
> is deprecated, but I'd still like to have it, especially for initial 
> clones on small-RAMed machines.

It never got implemented in a way called from C. This is just removing the 
pointer to the empty struct where support would go. If anybody knows 
enough about interfacing with rsync to write the necessary functions, it 
can be restored.

	-Daniel
*This .sig left intentionally blank*
