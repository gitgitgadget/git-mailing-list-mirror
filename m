From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Improve message-id generation flow control for
 format-patch
Date: Tue, 19 Feb 2008 16:51:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191646570.30505@racer.site>
References: <cover.1203392527.git.barkalow@iabervon.org> <alpine.LNX.1.00.0802182254110.5816@iabervon.org> <alpine.LSU.1.00.0802191300510.30505@racer.site> <alpine.LNX.1.00.0802191108450.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVhN-0002cb-Ny
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbYBSQv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbYBSQv3
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:51:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:40090 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751578AbYBSQv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:51:28 -0500
Received: (qmail invoked by alias); 19 Feb 2008 16:51:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 19 Feb 2008 17:51:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9hJdjxda9JF7DOlK8aQxJHXMP68v/sXK/gymL28
	1UiSgYF3v6LfRJ
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802191108450.19024@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74435>

Hi,

On Tue, 19 Feb 2008, Daniel Barkalow wrote:

> On Tue, 19 Feb 2008, Johannes Schindelin wrote:
> 
> > On Mon, 18 Feb 2008, Daniel Barkalow wrote:
> > 
> > > diff --git a/revision.h b/revision.h
> > > index 8572315..e3559d0 100644
> > > --- a/revision.h
> > > +++ b/revision.h
> > > @@ -74,7 +74,7 @@ struct rev_info {
> > >  	struct log_info *loginfo;
> > >  	int		nr, total;
> > >  	const char	*mime_boundary;
> > > -	const char	*message_id;
> > > +	char		*message_id;
> > >  	const char	*ref_message_id;
> > >  	const char	*add_signoff;
> > >  	const char	*extra_headers;
> > 
> > Mini-nit: technically, ref_message_id should be "char *", too.
> 
> I'd intended ref_message_id to just reference the string owned by a 
> different message's message_id, but that doesn't really work with struct 
> rev_info. I bet you'd like me to not leak memory out through 
> ref_message_id, too. I think I want to see how the code to collect the 
> set of commits in the series (for more capable generation of cover 
> letter contents) goes before changing this either way.
> 
> (It's incidentally kind of amusing that you managed to convey the way 
> you thought the code should be designed, different from how I'd designed 
> it, through a note on whether a struct field should be const or not.)

Hehe!

You're right in that the revision machinery needs some cleaning up.  AFAIK 
there is no method yet to release the memory allocated during one revision 
walk (including the preparation).

And you're right that this should be done separately, so please kindly 
accept my apologies while I retract my comment.

Ciao,
Dscho
