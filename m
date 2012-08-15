From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v3 02/16] Integrate remote-svn into svn-fe/Makefile.
Date: Wed, 15 Aug 2012 10:54:39 +0200
Message-ID: <2098867.sfVpB1786h@flomedio>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com> <7vd32t9qp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 10:54:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1ZNQ-0003xU-6L
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 10:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab2HOIyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 04:54:51 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61919 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab2HOIyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 04:54:49 -0400
Received: by bkwj10 with SMTP id j10so427622bkw.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=Gs7znJxbSzwcuK7wnDXfguC+CcK4y5nzV5ZAesX6vlw=;
        b=zad3sLHfYJxE9nDzsLTHTpf4EXhbMrYaBmFn5tbC9V09t11LPmS5rqQV7iN3nkjTdf
         D/1Ds/HbnbJ3hEqy4CITMvvT0lhBMVwAJT3bqc/HyV1mC4UM6o78nL5Yekoj/NM4tsjy
         BDAP/xwRDlpeepX7N2ZHGZktz+/qCuUIRjuFTij8CrloME3QkhhDhVyi7L24nBDdr3B2
         NHuGhRpH0Rf8xdonUOyoiT+d/OptAtIXndDuNVPIb13cSosnEuezumnW5IOyosDqjyu3
         NZ6JQuKrdRP0xiCLSzsp6t3oo/h9TmN5XzGwjLpO22HdWiXqo3MZBCdwHdxqs/C8IAP7
         j03g==
Received: by 10.204.152.75 with SMTP id f11mr7555659bkw.83.1345020886261;
        Wed, 15 Aug 2012 01:54:46 -0700 (PDT)
Received: from flomedio.localnet (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id t23sm390453bks.4.2012.08.15.01.54.41
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Aug 2012 01:54:43 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vd32t9qp7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203465>

On Tuesday 14 August 2012 13:14:12 Junio C Hamano wrote:
> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
> > Requires some sha.h to be used and the libraries
> > to be linked, this is currently hardcoded.
> > 
> > Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> > ---
> > 
> >  contrib/svn-fe/Makefile |   16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
> > index 360d8da..8f0eec2 100644
> > --- a/contrib/svn-fe/Makefile
> > +++ b/contrib/svn-fe/Makefile
> > @@ -1,14 +1,14 @@
> > -all:: svn-fe$X
> > +all:: svn-fe$X remote-svn$X
> > 
> >  CC = gcc
> >  RM = rm -f
> >  MV = mv
> > 
> > -CFLAGS = -g -O2 -Wall
> > +CFLAGS = -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'
> > -Wdeclaration-after-statement> 
> >  LDFLAGS =
> >  ALL_CFLAGS = $(CFLAGS)
> >  ALL_LDFLAGS = $(LDFLAGS)
> > 
> > -EXTLIBS =
> > +EXTLIBS = -lssl -lcrypto -lpthread ../../xdiff/lib.a
> 
> I haven't looked carefully, but didn't we have to do a bit more
> elaborate when linking with ssl/crypto in our main Makefile to be
> portable across various vintages of OpenSSL libraries?
> 
> Does contrib/svn-fe/ already depend on OpenSSL by the way?  It needs
> to be documented somewhere in the same directory.
> 
> If one builds the main Git binary with NO_OPENSSL, can this still be
> built and linked?
> 
> What does this use xdiff/lib.a for?
> 
> The above are just mental notes; I didn't read the later patches in
> the series that may already address these issues.

For the makefile, I've to say that this is just a hack to make it work. I'm not 
sure how it would be correctly integrated into git's makefile hierarchy.
The OPENSSL header and the xdiff/lib.a are here because it doesn't work 
otherwise. I need to dig into that to find out why. Any tips how to do it 
right?
 
> >  GIT_LIB = ../../libgit.a
> >  VCSSVN_LIB = ../../vcs-svn/lib.a
> > 
> > @@ -37,8 +37,12 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
> > 
> >  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
> >  	
> >  		$(ALL_LDFLAGS) $(LIBS)
> > 
> > -svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
> > -	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
> > +remote-svn$X: remote-svn.o $(VCSSVN_LIB) $(GIT_LIB)
> > +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ remote-svn.o \
> > +		$(ALL_LDFLAGS) $(LIBS)
> > +
> > +%.o: %.c ../../vcs-svn/svndump.h
> > +	$(QUIET_CC)$(CC) -I../../vcs-svn -I../../ -o $*.o -c $(ALL_CFLAGS) $<
> > 
> >  svn-fe.html: svn-fe.txt
> >  
> >  	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
> > 
> > @@ -58,6 +62,6 @@ svn-fe.1: svn-fe.txt
> > 
> >  	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
> >  
> >  clean:
> > -	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
> > +	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1 remote-svn.o
> > 
> >  .PHONY: all clean FORCE
