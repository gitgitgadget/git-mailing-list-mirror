From: Alan Hourihane <alanh@fairlite.co.uk>
Subject: Re: new platform & S_IFGITLINK problem
Date: Wed, 05 May 2010 09:36:34 +0100
Message-ID: <1273048594.13488.1343.camel@jetpack.demon.co.uk>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
	 <20100505022907.GA17743@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 10:37:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9a6M-0002YX-Lg
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 10:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933757Ab0EEIgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 04:36:50 -0400
Received: from fairlite.demon.co.uk ([80.176.228.186]:60003 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933515Ab0EEIgt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 04:36:49 -0400
Received: from localhost (unknown [127.0.0.1])
	by fairlite.demon.co.uk (Postfix) with ESMTP id 84AC83D4002;
	Wed,  5 May 2010 08:36:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at demon.co.uk
Received: from fairlite.demon.co.uk ([127.0.0.1])
	by localhost (server.demon.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CP9i36-iIBmK; Wed,  5 May 2010 09:36:46 +0100 (BST)
Received: from [192.168.0.226] (unknown [192.168.0.226])
	by fairlite.demon.co.uk (Postfix) with ESMTP id EBE9D220317;
	Wed,  5 May 2010 09:36:46 +0100 (BST)
In-Reply-To: <20100505022907.GA17743@progeny.tock>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146383>

On Tue, 2010-05-04 at 21:29 -0500, Jonathan Nieder wrote:
> Hi,
> 
> Alan Hourihane wrote:
> 
> > Additionally, attached is a patch that I currently need to apply in
> > order to compile git successfully on the FreeMiNT platform (which is
> > m68k based).
> > 
> > Comments appreciated.
> 
> While wiser people discuss the hard part, here are some tiny nitpicks. :)
> 
> > --- /dev/null	2008-12-07 20:01:52.000000000 +0000
> > +++ compat/mint.h	2008-12-23 11:52:10.000000000 +0000
> > @@ -0,0 +1,2 @@
> > +#define SA_RESTART 0
> > +#define ss_family sa_family
> 
> Does MiNT restart interrupted system calls by default?  Are most
> operations generally not interruptible anyway?

Most operations are generally not interruptible.

> > --- Makefile	2009-01-29 12:12:01.000000000 +0000
> > +++ Makefile	2009-01-29 12:13:39.000000000 +0000
> > @@ -1618,7 +1613,7 @@
> >  
> >  git-imap-send$X: imap-send.o $(GITLIBS)
> >  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> > -		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
> > +		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
> 
> NEEDS_CRYPTO_WITH_SSL = YesPlease

O.k.

> [...]
> >  git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
> >  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> > -		$(LIBS) $(CURL_LIBCURL)
> > +		$(LIBS) $(CURL_LIBCURL) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
> [...]
> 
> CURL_LIBCURL = -lcurl $(OPENSSL_LIBSSL)

O.k.

Alan.
