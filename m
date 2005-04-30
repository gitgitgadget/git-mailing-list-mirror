From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 21:22:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
 <42730061.5010106@zytor.com> <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, Edgar Toernig <froese@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 06:15:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRjNn-0001mh-JX
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 06:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVD3EUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 00:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVD3EUi
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 00:20:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:36267 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262503AbVD3EUd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 00:20:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3U4KSs4012017
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 21:20:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3U4KRBe021725;
	Fri, 29 Apr 2005 21:20:28 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Linus Torvalds wrote:
> 
> I'll happily depend on libcurl, but I put my foot down on that tool of the 
> devil called "autoconf".

Btw, looking at curl's "getdate.c", it doesn't seem to be _that_ much more 
different from the date parsing we used to have. In particular, it 
actually uses "mktime()" twice and subtracts out the difference.

It also seems to do so in a particularly stupid way, and David Woodhouses 
suggestion of just using mktime() on Jan 1st, 1970, seems to be much 
simpler than what curl does.

(Actually, it might make sense to modify David's version to use "Jan 2nd,
1970" and subtract 24 hours, in case some mktime() implementation decides
that underflow is a problem...)

Of course, I think we might as well go with Edgars version after all. 

Edgar, willing to create a separate "parse-date.c" with your "my_mktime()" 
thing and move the old date parsing there? That way we'll just use that 
instead of libcurl..

		Linus
