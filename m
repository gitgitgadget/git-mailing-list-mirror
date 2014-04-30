From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] wincred: add install target and avoid overwriting
	configured variables
Date: Wed, 30 Apr 2014 08:46:10 +0200
Organization: <)><
Message-ID: <20140430064610.GA22094@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 08:46:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfOHZ-0006fF-6d
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 08:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbaD3GqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 02:46:13 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58842 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbaD3GqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 02:46:12 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 81F911C00D4
	for <git@vger.kernel.org>; Wed, 30 Apr 2014 08:46:11 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3U6kBXK022132
	for <git@vger.kernel.org>; Wed, 30 Apr 2014 08:46:11 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3U6kAZp022131
	for git@vger.kernel.org; Wed, 30 Apr 2014 08:46:10 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247679>

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Date: Wed, 24 Oct 2012 00:15:29 +0100

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
Another one from msysGit project.
Original subject by Pat; I would suggest:
    wincred: improve Makefile
 contrib/credential/wincred/Makefile | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
index bad45ca..3ce6aba 100644
--- a/contrib/credential/wincred/Makefile
+++ b/contrib/credential/wincred/Makefile
@@ -1,14 +1,20 @@
-all: git-credential-wincred.exe
-
-CC = gcc
-RM = rm -f
-CFLAGS = -O2 -Wall
-
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
-git-credential-wincred.exe : git-credential-wincred.c
+prefix ?= /usr/local
+libexecdir ?= $(prefix)/libexec/git-core
+
+INSTALL ?= install
+
+GIT_CREDENTIAL_WINCRED := git-credential-wincred.exe
+
+all: $(GIT_CREDENTIAL_WINCRED)
+
+$(GIT_CREDENTIAL_WINCRED): git-credential-wincred.c
 	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
 
+install: $(GIT_CREDENTIAL_WINCRED)
+	$(INSTALL) -m 755 $(GIT_CREDENTIAL_WINCRED) $(libexecdir)
+
 clean:
-	$(RM) git-credential-wincred.exe
+	$(RM) $(GIT_CREDENTIAL_WINCRED)
-- 
1.9.2.msysgit.0.158.g6070cee
