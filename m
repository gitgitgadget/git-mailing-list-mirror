From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 02/13] Use an external program to implement fetching with
 curl
Date: Wed, 5 Aug 2009 11:52:22 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051145250.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050053580.2147@iabervon.org> <alpine.DEB.1.00.0908051206460.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 17:52:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYin5-0008RE-5U
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 17:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933992AbZHEPwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 11:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933751AbZHEPwX
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 11:52:23 -0400
Received: from iabervon.org ([66.92.72.58]:55897 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933326AbZHEPwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 11:52:22 -0400
Received: (qmail 14192 invoked by uid 1000); 5 Aug 2009 15:52:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 15:52:22 -0000
In-Reply-To: <alpine.DEB.1.00.0908051206460.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124919>

On Wed, 5 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> 
> > diff --git a/Makefile b/Makefile
> > index 504646a..35117fc 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -981,6 +981,7 @@ else
> >  		CURL_LIBCURL = -lcurl
> >  	endif
> >  	BUILTIN_OBJS += builtin-http-fetch.o
> > +	PROGRAMS += git-remote-http$X git-remote-https$X git-remote-ftp$X git-http-fetch$X
> >  	EXTLIBS += $(CURL_LIBCURL)
> >  	LIB_OBJS += http.o http-walker.o
> >  	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
> > @@ -1491,6 +1492,10 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
> >  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> >  		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> >  
> > +git-remote-http$X git-remote-https$X git-remote-ftp$X: remote-curl.o http.o http-walker.o $(GITLIBS)
> > +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> > +		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> > +
> 
> Ooops, I missed this part.  How about making git-remote-https and 
> git-remote-ftp hardlinks to git-remote-http?

Sure. Is "ln ... || ln -s ... || cp ..." the right way to do this 
cross-platform?

	-Daniel
*This .sig left intentionally blank*
