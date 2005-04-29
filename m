From: Linus Torvalds <torvalds@osdl.org>
Subject: The big git command renaming..
Date: Fri, 29 Apr 2005 14:24:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Apr 29 23:21:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcuj-00059b-2d
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVD2VZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVD2VZe
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:25:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:32681 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262998AbVD2VWp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 17:22:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TLMis4009506
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 14:22:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TLMh6m005590
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 14:22:43 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, I hate to do this, since my fingers have already gotten used to the 
old names, but we clearly can't continue to use command names like 
"update-cache" or "read-tree" that are totally non-git-specific.

So I just pushed out a change that renames the commands to always have a 
"git-" prefix. In addition, I renamed "show-diff" to "diff-files", with 
together with the prefix means that it becomes "git-diff-files" when used.

Since I end up using tab-completion for almost all my work, and since
-within- the source directory there's no confusion, I didn't actually name
the source files with any git- prefix. Quite the reverse: I removed the
prefix from the two .c files that already had it (so git-mktag.c is now
just "mktag.c"), and the general rule for building the executable from a C 
file is now

	git-%: %.c $(LIB_FILE)
		$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)


this seemed to be a nice regular interface that means that binaries get 
installed with clear "git-" prefixes, but that I don't have to look at 
them when I edit the sources.

Sorry to everybody else whose fingers have already learnt the old names. 
The good news is that if you use cogito, you won't care.

		Linus
