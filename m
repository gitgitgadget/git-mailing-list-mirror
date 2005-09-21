From: Linus Torvalds <torvalds@osdl.org>
Subject: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Wed, 21 Sep 2005 13:15:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Wed Sep 21 22:18:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIB0c-00049b-9W
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 22:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVIUUQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 16:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVIUUQA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 16:16:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964801AbVIUUP7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 16:15:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8LKFiBo015682
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 13:15:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8LKFewI026637;
	Wed, 21 Sep 2005 13:15:42 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9073>


The new merge is totally unusable in real life.

I get 

	Need real merge but the working tree has local changes.

which is totally bogus. Sure, my working tree has local changes, but they 
have absolutely nothing to do with the stuff I merge. I almost _always_ 
keep local changes in my tree, and I worked hard to make sure that merging 
works well even despite that, and does the right thing.

Local changes are a problem ONLY IF THOSE LOCAL CHANGES INTERFERE WITH THE 
MERGE.

If the new merge policies do not allow that, then the new merge policies 
are incredibly broken. The old one did exactly the right thing for this 
case, and "git-read-tree -m" did

	Entry '%s' would be overwritten by merge. Cannot merge.

only if a file that actually needed merging was different.

			Linus
