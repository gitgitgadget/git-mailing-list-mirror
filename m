From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-checkout-index, flag ordering and --prefix kludgy handling
Date: Mon, 17 Oct 2005 18:28:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510171814430.3369@g5.osdl.org>
References: <200510162114.27429.blaisorblade@yahoo.it>
 <Pine.LNX.4.64.0510171546580.3369@g5.osdl.org> <7v8xwry88u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 03:29:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERgH1-0004YN-Rx
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 03:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVJRB2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 21:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVJRB2M
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 21:28:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751436AbVJRB2M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2005 21:28:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9I1S7FC028886
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Oct 2005 18:28:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9I1S5Zn022162;
	Mon, 17 Oct 2005 18:28:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xwry88u.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10201>



On Mon, 17 Oct 2005, Junio C Hamano wrote:
>
> The patch looks good.  Thanks.

Btw, I'd really like a "git checkout" that can do the per-file thing, 
instead of always using the equivalent of git-checkout-index with "-a".

It's actually one of the few places where I still use the raw git 
commands, doing things like

	git-checkout-index -u -f filename

and I suspect that a lot of people would prefer that

	git checkout filename

would just do that. Instead, we error out ("no such branch"). Which 
isn't even what I want, and almost certainly not what most CVS users want 
(they're used to checking out individual files).

Of course, in the generic case, that would require git-read-tree to take a 
list of filenames (which would act as a "mask" for any activity against 
the old index if one was loaded), but that's a pretty big thing. Even if 
it's admittedly also potentially very useful too..

But even just a total special case (giving a filename would force the 
checkout, no read-tree, no nothing, just force the old index contents) 
might be acceptable and would only require some script hackery.

		Linus
