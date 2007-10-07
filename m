From: Kristof Provost <Kristof@provost-engineering.be>
Subject: [PATCH] makefile: Add a cscope target
Date: Sun, 7 Oct 2007 22:45:43 +0200
Message-ID: <20071007204543.GC4635@luggage>
References: <20071005223336.GA4556@luggage> <20071006010437.GS31659@planck.djpig.de> <20071006142442.GA4635@luggage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Oct 07 22:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ied0n-0005lu-Bf
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 22:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXJGUpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 16:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbXJGUpw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 16:45:52 -0400
Received: from rhineheart.priorweb.be ([213.193.229.215]:60862 "HELO
	rhineheart.priorweb.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750779AbXJGUpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 16:45:51 -0400
Received: (qmail 7101 invoked by uid 1010); 7 Oct 2007 20:45:46 -0000
Received: from unknown (HELO rhineheart.priorweb.be) (127.0.0.1)
  by rhineheart.priorweb.be with SMTP; 7 Oct 2007 20:45:46 -0000
Received: from luggage (dD5767E05.access.telenet.be [213.118.126.5])
	by rhineheart.priorweb.be (Postfix) with SMTP;
	Sun,  7 Oct 2007 22:45:43 +0200 (CEST)
Received: by luggage (sSMTP sendmail emulation); Sun, 07 Oct 2007 22:45:44 +0200
Content-Disposition: inline
In-Reply-To: <20071006142442.GA4635@luggage>
X-PGP-Fingerprint: 6B6E 5EED 8ECF FAE7 1F61  7458 5046 7D0E 11B0 0EE8
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Virus-Scanned: Passed
X-Spam-Scanned: 2.0
X-Spam-Status: NO
X-Scanned-By: PriorWeb mailfilter
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60215>

The current makefile supports ctags but not cscope. Some people prefer
cscope (I do), so this patch adds a cscope target.

Signed-off-by: Kristof Provost <Kristof@provost-engineering.be>

---
This version of the patch includes the fix for the missing [ Frank spotted,
and adds 'cscope*' to the .gitignore list as Alex suggested. 
While I did that I noticed that 'tags' and 'TAGS' were also missing.

It's also in the (hopefully) right format. Thank to Johannes Schindelin
for pointing out my mistakes.

 .gitignore |    3 +++
 Makefile   |    8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index e0b91be..62afef2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,3 +171,6 @@ config.status
 config.mak.autogen
 config.mak.append
 configure
+tags
+TAGS
+cscope*
diff --git a/Makefile b/Makefile
index 8db4dbe..e2790c8 100644
--- a/Makefile
+++ b/Makefile
@@ -947,6 +947,10 @@ tags:
 	$(RM) tags
 	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
 
+cscope:
+	$(RM) cscope*
+	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
+
 ### Detect prefix changes
 TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)
@@ -1093,7 +1097,7 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
-	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
+	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) configure config.log config.mak.autogen config.mak.append config.status config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
@@ -1111,7 +1115,7 @@ endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS
 
 .PHONY: all install clean strip
-.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags .FORCE-GIT-CFLAGS
+.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS 
 
 ### Check documentation
 #
-- 
1.5.3.4.207.g1aae
