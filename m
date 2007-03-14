From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Tue, 13 Mar 2007 18:34:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703131831390.9690@woody.linux-foundation.org>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703140216480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 14 02:34:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRINa-0007kf-Kw
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933369AbXCNBeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933387AbXCNBeL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:34:11 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48069 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933369AbXCNBeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:34:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2E1Y3Ob013510
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Mar 2007 18:34:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2E1Y2Uk014860;
	Tue, 13 Mar 2007 17:34:02 -0800
In-Reply-To: <Pine.LNX.4.63.0703140216480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.487 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42168>



On Wed, 14 Mar 2007, Johannes Schindelin wrote:
> 
> So, big master to hom everybody bows, how to return the correct value when 
> executing a pager? Because this _has_ to be done if we go that way.

Why? If you execute the pager, nobody cares about the error value anyway. 

I don't see why you would mix in a pager here. If you do

	diff -u file1 file2 | less -S

the return value of the pipe will not only generally be totally 
uninteresting and never used, but it will be the return value of "less" 
anyway. Which is what we'd get quite naturally.

The return value of "git diff" really only is sensibly and meaningful when 
you use it in a script *without* a pager (whether built-in or not).

		Linus
