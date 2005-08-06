From: Linus Torvalds <torvalds@osdl.org>
Subject: Make git-sh-setup-script do what it was supposed to do
Date: Sat, 6 Aug 2005 10:04:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508061002370.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 19:06:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1S6h-0004Cq-98
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 19:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbVHFRFC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 13:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbVHFRFB
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 13:05:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263268AbVHFRFA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 13:05:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j76H4pjA024425
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 Aug 2005 10:04:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j76H4oDn023064;
	Sat, 6 Aug 2005 10:04:51 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Duh. A missing && meant that half the tests that git-sh-setup-script were
_meant_ to do were actually totally ignored.

In particular, the git sanity checking ended up only testing that the 
GIT_OBJECT_DIRECTORY was sane, not that GIT_DIR itself was..

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-sh-setup-script b/git-sh-setup-script
--- a/git-sh-setup-script
+++ b/git-sh-setup-script
@@ -12,6 +12,6 @@ die() {
 }
 
 [ -d "$GIT_DIR" ] &&
-[ -d "$GIT_DIR/refs" ]
+[ -d "$GIT_DIR/refs" ] &&
 [ -d "$GIT_OBJECT_DIRECTORY" ] &&
 [ -d "$GIT_OBJECT_DIRECTORY/00" ]
