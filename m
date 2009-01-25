From: Serge van den Boom <svdb@stack.nl>
Subject: [PATCH] Makefile: Make 'configure --with-expat=path' actually work
Date: Sun, 25 Jan 2009 20:24:41 +0100 (CET)
Message-ID: <alpine.BSF.2.00.0901251938120.97940@toad.stack.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 20:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRAkF-0004ha-ED
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 20:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbZAYTb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 14:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbZAYTb1
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 14:31:27 -0500
Received: from meestal-mk5.stack.nl ([131.155.140.149]:56178 "EHLO
	mx1.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750935AbZAYTb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 14:31:26 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Jan 2009 14:31:26 EST
Received: from toad.stack.nl (toad.stack.nl [IPv6:2001:610:1108:5010::135])
	by mx1.stack.nl (Postfix) with ESMTP id C7AD13F64A
	for <git@vger.kernel.org>; Sun, 25 Jan 2009 20:24:41 +0100 (CET)
Received: by toad.stack.nl (Postfix, from userid 1106)
	id C0E1973F89; Sun, 25 Jan 2009 20:24:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by toad.stack.nl (Postfix) with ESMTP id B607D73F56
	for <git@vger.kernel.org>; Sun, 25 Jan 2009 20:24:41 +0100 (CET)
User-Agent: Alpine 2.00 (BSF 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107086>

The prefix specified with the --with-expat option of configure was not
actually used.

Signed-off-by: Serge van den Boom <svdb@stack.nl>
---
diff --git a/Makefile b/Makefile
index b4d9cb4..e7218cb 100644
--- a/Makefile
+++ b/Makefile
@@ -849,7 +849,12 @@ else
  		endif
  	endif
  	ifndef NO_EXPAT
-		EXPAT_LIBEXPAT = -lexpat
+		ifdef EXPATDIR
+			BASIC_CFLAGS += -I$(EXPATDIR)/include
+			EXPAT_LIBEXPAT = -L$(EXPATDIR)/$(lib) $(CC_LD_DYNPATH)$(EXPATDIR)/$(lib) -lexpat
+		else
+			EXPAT_LIBEXPAT = -lexpat
+		endif
  	endif
  endif
