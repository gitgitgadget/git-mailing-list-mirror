From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Mon, 27 Mar 2006 17:15:24 -0800
Message-ID: <13226.1143508524@lotus.CS.Berkeley.EDU>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 28 03:15:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO2oE-0001ab-5c
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 03:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWC1BP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 20:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWC1BP1
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 20:15:27 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:11417 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751012AbWC1BP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 20:15:27 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k2S1FPgH013228
	for <git@vger.kernel.org>; Mon, 27 Mar 2006 17:15:25 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k2S1FP94013227
	for <git@vger.kernel.org>; Mon, 27 Mar 2006 17:15:25 -0800 (PST)
To: git@vger.kernel.org
In-reply-to: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18098>

For some reason, I need ALL_LDFLAGS in the git target only on
AIX.  Once it builds, only one test "fails" on AIX 5.1 with 
1.3.0.rc1, t5500-fetch-pack.sh, but it looks like it's some
odd tool problem in the tester + my setup and not a real bug.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

diff --git a/Makefile b/Makefile
index 4edb383..d945546 100644
--- a/Makefile
+++ b/Makefile
@@ -455,7 +455,8 @@ strip: $(PROGRAMS) git$X
 
 git$X: git.c common-cmds.h $(LIB_FILE)
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
-		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) $(LIB_FILE) $(LIBS)
+		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) $(LIB_FILE) \
+		$(ALL_LDFLAGS) $(LIBS)
 
 common-cmds.h: Documentation/git-*.txt
 	./generate-cmdlist.sh > $@
