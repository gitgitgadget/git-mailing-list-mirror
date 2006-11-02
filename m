X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: weird strncmp usage?
Date: Thu, 2 Nov 2006 12:04:50 +0100
Message-ID: <20061102110450.GK20017@pasky.or.cz>
References: <eibhga$tpg$1@sea.gmane.org> <45494D84.2060402@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 11:05:00 +0000 (UTC)
Cc: hanwen@xs4all.nl, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45494D84.2060402@shadowen.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30718>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaNU-0002dh-Dl for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752834AbWKBLEx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbWKBLEw
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:04:52 -0500
Received: from w241.dkm.cz ([62.24.88.241]:63930 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752834AbWKBLEw (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:04:52 -0500
Received: (qmail 5854 invoked by uid 2001); 2 Nov 2006 12:04:50 +0100
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Dear diary, on Thu, Nov 02, 2006 at 02:44:36AM CET, I got a letter
where Andy Whitcroft <apw@shadowen.org> said that...
> Han-Wen Nienhuys wrote:
> > 
> > Hi,
> > 
> > the git source seems full of calls similar to
> > 
> >   strncmp (x, "constant string", 15)
> > 
> > is there a reason not to use something like
> > 
> >   int
> >   strxmp (char const *x, char const *y)
> >   {
> >     return strncmp (x, y, strlen (y));
> >   }
> > 
> > everywhere?
> 
> If you are doing these a _lot_ then there is a significant additional
> cost to using strlen on a constant string.
> 
> That said if you know its constant you can also use sizeof("foo") and
> that is done at compile time.  Something like:
> 
> #define strxcmp(x, y)	strncmp((x), (y), sizeof((y))

At least in the #define, reasonable compilers should optimize out
strlen("foo"). Hopefully as well if you would make strxmp() inlinable
though I'm not so sure there.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
