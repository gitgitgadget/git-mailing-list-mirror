From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/6] Add 'diffcore.h' to LIB_H
Date: Thu, 25 Oct 2007 11:16:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251115250.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:27:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7Qb-0005My-5v
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbXJYS1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbXJYS1T
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:27:19 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55563 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885AbXJYS1S (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 14:27:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIGp8V017784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 11:16:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIGo8Q007551;
	Thu, 25 Oct 2007 11:16:50 -0700
In-Reply-To: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.219 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62352>


From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/6] Add 'diffcore.h' to LIB_H

The diffcore.h header file is included by more than just the internal
diff generation files, and needs to be part of the proper dependencies.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This caused me pain.

I spent way too much time trying to debug something that wasn't buggy to 
begin with (which made it really hard to see the bug ;).

We really should have a proper (automatic) dependency generation phase. 
This patch does *not* do that, it just fixes up the crappy stuff we have 
now.

 Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b728920..8a0082d 100644
--- a/Makefile
+++ b/Makefile
@@ -290,7 +290,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h transport.h
+	mailmap.h remote.h transport.h diffcore.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -917,7 +917,6 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
-$(DIFF_OBJS): diffcore.h
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
-- 
1.5.3.4.330.g1dec6
