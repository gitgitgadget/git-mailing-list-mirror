From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] resend/cleanup: Fix up subproject support
Date: Fri, 13 Apr 2007 09:23:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704130919070.28042@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 18:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcOYt-0008SD-U0
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 18:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbXDMQXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 12:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbXDMQXp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 12:23:45 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40181 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061AbXDMQXo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 12:23:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3DGNeIs024595
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Apr 2007 09:23:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3DGNdCs004008;
	Fri, 13 Apr 2007 09:23:40 -0700
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44419>


This series of three patches is a *replacement* for the patch series of 
two patches (plus one-liner fixup) I sent yesterday.

It fixes the issue I noted with "git status" incorrectly claiming that a 
non-checked out subproject wasn't clean - that was just a total thinko in 
the code (we were checking the filesystem mode against S_IFDIRLNK, which 
obviously cannot work, since S_IFDIRLINK is a git-internal state, not a 
filesystem state).

It then re-sends the two patches on top of that, with the fix for checking 
out superprojects (we should *not* mess up any existing subproject 
directories, certainly not remove them - if we already have a directory in 
the place where we now want a subproject, we should leave it well alone!)

If you already applied the patches from yesterday (and my small fix), you 
already have the two latter ones - the only reason I added 1/3 to the 
front of the patch-queue is that it really is a fix, and it makes the 
commit commentary about a remaining bug in the patch I sent out yesterday 
go away.

		Linus
