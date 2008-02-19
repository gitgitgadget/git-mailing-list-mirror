From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/5] Improve message-id generation flow control for
 format-patch
Date: Tue, 19 Feb 2008 11:26:41 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802191108450.19024@iabervon.org>
References: <cover.1203392527.git.barkalow@iabervon.org> <alpine.LNX.1.00.0802182254110.5816@iabervon.org> <alpine.LSU.1.00.0802191300510.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVJP-0000me-14
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbYBSQ0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753227AbYBSQ0n
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:26:43 -0500
Received: from iabervon.org ([66.92.72.58]:47160 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbYBSQ0m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:26:42 -0500
Received: (qmail 9026 invoked by uid 1000); 19 Feb 2008 16:26:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 16:26:41 -0000
In-Reply-To: <alpine.LSU.1.00.0802191300510.30505@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74427>

On Tue, 19 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 18 Feb 2008, Daniel Barkalow wrote:
> 
> > diff --git a/revision.h b/revision.h
> > index 8572315..e3559d0 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -74,7 +74,7 @@ struct rev_info {
> >  	struct log_info *loginfo;
> >  	int		nr, total;
> >  	const char	*mime_boundary;
> > -	const char	*message_id;
> > +	char		*message_id;
> >  	const char	*ref_message_id;
> >  	const char	*add_signoff;
> >  	const char	*extra_headers;
> 
> Mini-nit: technically, ref_message_id should be "char *", too.

I'd intended ref_message_id to just reference the string owned by a 
different message's message_id, but that doesn't really work with struct 
rev_info. I bet you'd like me to not leak memory out through 
ref_message_id, too. I think I want to see how the code to collect the set 
of commits in the series (for more capable generation of cover letter 
contents) goes before changing this either way.

(It's incidentally kind of amusing that you managed to convey the way you 
thought the code should be designed, different from how I'd designed it, 
through a note on whether a struct field should be const or not.)

	-Daniel
*This .sig left intentionally blank*
