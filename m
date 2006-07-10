From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Mon, 10 Jul 2006 01:22:55 -0400
Message-ID: <20060710052255.GA15173@spearce.org>
References: <20060708183402.GA17644@spearce.org> <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net> <20060708190327.GA17763@spearce.org> <20060709073155.GP22573@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 07:23:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzoEf-0007AE-SZ
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 07:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWGJFXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 01:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWGJFXD
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 01:23:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:30443 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751338AbWGJFXC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 01:23:02 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FzoET-0000NS-Ib; Mon, 10 Jul 2006 01:22:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B62C020E482; Mon, 10 Jul 2006 01:22:55 -0400 (EDT)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20060709073155.GP22573@lug-owl.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23590>

> On Sat, 2006-07-08 15:03:27 -0400, Shawn Pearce <spearce@spearce.org> wrote:
> > Monday I'll look to see if there's an option that can be given to
> > the Solaris compiler to make it accept these constructs.  Maybe a
> > simple CFLAGS change in my config.mak would resolve what this patch
> > was trying to do.

So Monday turned out to be today.  The compiler version:

  $ cc -V                                                        
  cc: Forte Developer 7 C 5.4 2002/03/09
  usage: cc [ options] files.  Use 'cc -flags' for details

and from `man cc`:

  -xc99  enables C99 features:

          The following is a list of the implemented features of
          the ISO/IEC 9899:1999, Programming Language - C stan-
          dard. See the C User's Guide for a detailed explanation
          of the compiler's support for these featuers:

          o  Idempotent Qualifiers
          o  _Pragma
          o  Mixed Declarations and Code
          o  static and Other Type Qualifiers Allowed in Array
             Declarators
          o  Flexible Array Members
          o  Declarations Using Implicit int
          o  Disallowed Implicit int and Implicit Function
             Declarations
          o  Declaration in for-Loop Statement
          o  C99 Keywords
          o  __func__ Support
          o  Macros With A Variable Number of Arguments
          o  Variable Length Arrays
          o  inline Specifier For Static Functions
          o  Commenting Code with //

So neither of the constructs my patch removes are supported in this
(old) compiler, although a newer one might accept them with -xc99.
Yes, I tried building a pristine git-1.4.1 with -xc99.  It barfed,
as one would expect given the description above.

Since we don't have a newer version of cc available (not sure why)
I'm stuck with needing to make the code changes in my patch just
to get GIT to compile.

-- 
Shawn.
