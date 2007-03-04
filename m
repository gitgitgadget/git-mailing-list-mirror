From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Remove use of git-rev-parse and replace git-rev-list
 --pretty with git-log
Date: Sun, 4 Mar 2007 13:44:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703041339070.3953@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org>
 <200703021929.20969.andyparkins@gmail.com> <7vbqjbdyxc.fsf@assigned-by-dhcp.cox.net>
 <200703030825.18378.andyparkins@gmail.com> <7virdiczn0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 22:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNyVk-0005ev-Fa
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 22:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbXCDVox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 16:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbXCDVow
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 16:44:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50277 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbXCDVow (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 16:44:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l24Lilq8028423
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Mar 2007 13:44:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l24Lik3V001836;
	Sun, 4 Mar 2007 13:44:47 -0800
In-Reply-To: <7virdiczn0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.451 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41371>



On Sat, 3 Mar 2007, Junio C Hamano wrote:
> 
> I do not think I've asked Linus about how he originally came up
> with "three dashes at the beginning of line" convention in the
> kernel circle, but my guess always have been that it would
> automatically allow us to accept patches prepared like this.

Indeed. The three dashes are just two different usage cases:

 - bare patches. So we stop on 

	--- Makefile.orig
	+++ Makefile

   exactly the same way we stop of "^diff -" and "Index: "

 - that then meant that I also extended it to ask people to add comments 
   after a "---" section.

That said, we could certainly require that it be:

 - either just three dashes on the line
OR
 - three dashes, exactly one whitespace, and what looks like a filename 
   (which in turn can have a date after it, that's what many versions of 
   GNU patch do)

but it won't remove the case where if somebody writes some text message 
that really *looks* like the beginning of a patch, it's what git 
"mailinfo" will use to split the patch from the top of the message. So we 
can tighten it up a bit, but people still need to be aware of this!

		Linus
