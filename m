From: Mathias Megyei <mathias@mnet-mail.de>
Subject: [PATCH] Do not remove distributed configure script
Date: Thu, 4 Oct 2007 23:49:19 +0200
Message-ID: <18181.24543.548090.990543@gargle.gargle.HOWL>
Reply-To: mathias@mnet-mail.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 23:49:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdYZY-0005xZ-Nh
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757930AbXJDVtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757694AbXJDVtX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:49:23 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33436 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545AbXJDVtW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:49:22 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 909FE22500C;
	Thu,  4 Oct 2007 23:49:20 +0200 (CEST)
Received: from champfer (ppp-82-135-81-218.dynamic.mnet-online.de [82.135.81.218])
	by mail.mnet-online.de (Postfix) with ESMTP id 2B8E890543;
	Thu,  4 Oct 2007 23:49:20 +0200 (CEST)
X-Mailer: VM 8.0.2-487 under Emacs 22.1.2 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60013>

Before this patch the clean target has removed the
configure script that comes with Git tar file.
That made compiling Git for different architectures
inconvenient.
This patch excludes configure from the files to be
deleted by 'make clean' and adds new target 'distclean'
to preserve old functionality.

Signed-off-by: Mathias Megyei <mathias@mnet-mail.de>
---
 Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8db4dbe..dbe68bc 100644
--- a/Makefile
+++ b/Makefile
@@ -1088,6 +1088,9 @@ dist-doc:
 
 ### Cleaning rules
 
+distclean: clean
+	$(RM) configure
+
 clean:
 	$(RM) *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
@@ -1095,7 +1098,7 @@ clean:
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
 	$(RM) -r autom4te.cache
-	$(RM) configure config.log config.mak.autogen config.mak.append config.status config.cache
+	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-- 
1.5.3.4.203.gcc61a-dirty
