From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How do I clear the directory cache
Date: Fri, 21 Oct 2005 14:00:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510211354440.10477@g5.osdl.org>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com> 
 <20051020085931.GW30889@pasky.or.cz>  <2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com>
  <7vmzl34ikl.fsf@assigned-by-dhcp.cox.net> <2b05065b0510211316j632c461apbb6f2f162e5fc7ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 23:02:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET403-0006ST-AR
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 23:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVJUVAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVJUVAS
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 17:00:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750977AbVJUVAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 17:00:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9LL02FC017591
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Oct 2005 14:00:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9LL00Cr022490;
	Fri, 21 Oct 2005 14:00:01 -0700
To: eschvoca <eschvoca@gmail.com>
In-Reply-To: <2b05065b0510211316j632c461apbb6f2f162e5fc7ef@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10448>



On Fri, 21 Oct 2005, eschvoca wrote:
> >
> > If that is what you want, then:
> >
> >         $ git-read-tree HEAD
> >         $ git-update-index --refresh >/dev/null
> 
> 
> Yes, this does exaclty what I want.  Thankyou.

Btw, if this ends up being something you do often (or more than once), 
it's best to use the "--reset" flag to git-read-tree.

That will cause git-read-tree to still try to use any old usable entries 
in the old index, which most of the time means that 99% of the index will 
be up-to-date, and that in turn makes the index refresh _much_ faster.

For small projects it doesn't matter, of course.

In fact, those two lines can also be written simply as

	git reset

which will do this, and more (in particular, it will also remove any sign 
of a partial merge-head).

			Linus
