From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Simplify building of programs
Date: Sun, 24 Apr 2005 01:59:56 +0200
Message-ID: <20050423235956.GA7437@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 01:56:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUT5-0006CP-4l
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVDXAAC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVDXAAC
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:00:02 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:13026 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262188AbVDWX75 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:59:57 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 5E7C16E26AA; Sun, 24 Apr 2005 01:59:06 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 328356E2653; Sun, 24 Apr 2005 01:59:06 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id C507561FDD; Sun, 24 Apr 2005 01:59:56 +0200 (CEST)
To: torvalds@osdl.org
Mail-Followup-To: torvalds@osdl.org, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00,UPPERCASE_25_50 
	autolearn=no version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Don't list libgit.a twice when compiling programs and make them depend
on the .c files so .o files are not left behind.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

--- 66b3fa5bde838935121a2eb7cf4b67587c32de13/Makefile  (mode:100644 sha1:e26b7c3695bf7ee88a75dcb6fd1953ce8b33c748)
+++ uncommitted/Makefile  (mode:100644)
@@ -49,8 +49,7 @@
 LIB_H=cache.h object.h
 
 
-LIBS = $(LIB_FILE)
-LIBS += -lz
+LIBS = -lz
 
 ifdef MOZILLA_SHA1
 	SHA1_HEADER="mozilla-sha1/sha1.h"
@@ -70,7 +69,7 @@
 
 all: $(PROG) $(GEN_SCRIPT)
 
-$(PROG):%: %.o $(LIB_FILE)
+$(PROG):%: %.c $(LIB_FILE)
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)

-- 
Jonas Fonseca
