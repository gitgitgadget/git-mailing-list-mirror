From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Use parseopts in builtin-fetch
Date: Mon, 5 Nov 2007 12:14:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711051155330.7357@iabervon.org>
References: <Pine.LNX.4.64.0711042233590.7357@iabervon.org>
 <20071105084333.GA25574@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 18:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip5YX-0003bc-TT
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 18:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758591AbXKEROx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 12:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758017AbXKEROw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 12:14:52 -0500
Received: from iabervon.org ([66.92.72.58]:55593 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759535AbXKEROt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 12:14:49 -0500
Received: (qmail 14215 invoked by uid 1000); 5 Nov 2007 17:14:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2007 17:14:47 -0000
In-Reply-To: <20071105084333.GA25574@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63528>

On Mon, 5 Nov 2007, Pierre Habouzit wrote:

> On Mon, Nov 05, 2007 at 03:35:34AM +0000, Daniel Barkalow wrote:
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > I mostly did this and the next one for practice with the API. I'm 
> > impressed that "git fetch -vv" is even handled correctly without anything 
> > special. Now that I've done it, assuming I did it right, it might as well 
> > get added to the series.
> 
>   I believe the same patches (or very similar ones) are in pu but are
> not in next yet because they conflict with the builtin-fetch recent
> series.
>
>   see http://git.madism.org/?p=git.git;a=blobdiff;f=builtin-fetch.c;h=12b1c4;hp=6b1750d;hb=7407915;hpb=61610e6

Ah, okay, forgot to look there. In any case, I was mostly looking for what 
mistakes I shouldn't make in future conversions.

> > +		OPT_BOOLEAN('q', "quiet", &quiet, "fetch silently"),
> 
>   there is an OPT__QUIET(&quiet) for this one.
> 
> > +	i = 1;
> >  	if (i < argc) {
> >  		int j = 0;
> >  		refs = xcalloc(argc - i + 1, sizeof(const char *));
> 
>   this is wrong, you meant i = 0, and frankly, it's better to just strip
> i altogether.

I didn't consume the remote name's slot, and started at the next one. But 
you're right that it's probably nicest to do to *argv++, argc-- thing and 
be zero-based for the list afterwards. I think I need the 'i' in this 
case, because the names get somewhat converted from the exact list given.

	-Daniel
*This .sig left intentionally blank*
