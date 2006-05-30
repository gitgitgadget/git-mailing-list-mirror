From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/10] re-based and expanded tree-walker cleanup patches
Date: Mon, 29 May 2006 21:17:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605292112530.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
 <7virno79a7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605291739430.5623@g5.osdl.org>
 <7vmzd05i25.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 30 06:17:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkvfO-0004em-5q
	for gcvg-git@gmane.org; Tue, 30 May 2006 06:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWE3ERL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 00:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWE3ERL
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 00:17:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751480AbWE3ERL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 00:17:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4U4H72g005319
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 21:17:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4U4H6L5028103;
	Mon, 29 May 2006 21:17:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzd05i25.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21009>



On Mon, 29 May 2006, Junio C Hamano wrote:
>
> > Pretty powerful, although at one point I was wondering about having a "git 
> > rebase" that could switch commits around or drop unwanted ones (ie let the 
> > user edit the cherry-picking list before the actual rebase).
> 
> I think true power users would just do the last two lines of
> git-rebase.sh by hand in two steps.  By stashing away the
> format-patch output, and using git-am interactively, you can
> easily drop unwanted ones, and then re-run git-am on the same
> format-patch output to apply the ones you dropped on the first
> run practically amounts to reordering the patches ;-).

Having to move around whole patches in the editor is not what you want to 
do. I was thinking more along the lines of

 (a) git-rev-list --pretty=oneline "$upstream"..ORIG_HEAD > rev-list

 (b) edit the rev-list, moving the single lines around, deleting them, etc

 (c) cat rev-list |
     git-format-patch -k --stdout --stdin --full_index |
     git-am

because the "--pretty=oneline" format is actually very nice as a way to 
re-order things and select single commits to be deleted or whatever..

		Linus
