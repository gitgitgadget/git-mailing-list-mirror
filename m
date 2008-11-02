From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] Makefile: add install-man rules (quick and normal)
Date: Sun, 2 Nov 2008 18:53:03 +0100
Message-ID: <200811021853.03718.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 02 18:54:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwh9g-0008T8-Hv
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 18:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYKBRxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 12:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753866AbYKBRxE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 12:53:04 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:45070 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbYKBRxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 12:53:01 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 55087F5BEBFE;
	Sun,  2 Nov 2008 18:53:00 +0100 (CET)
Received: from [91.19.10.71] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1Kwh8G-0007fY-00; Sun, 02 Nov 2008 18:53:00 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18B87DmpcObYq1uC1IwCp/Jy1DprSi/W7qQblFN
	G5IGsyo77BUDWlVGdr0opHtyp8XVEjEWTPq8CqHg/T8J9Vegub
	B03xvqUcrGwVYo+G5aSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99857>

---
 Documentation/Makefile |    8 ++++++--
 INSTALL                |    5 +++--
 Makefile               |    6 ++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e33ddcb..c34c1ca 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -87,7 +87,9 @@ man7: $(DOC_MAN7)
 
 info: git.info gitman.info
 
-install: man
+install: install-man
+
+install-man: man
 	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
 	$(INSTALL) -d -m 755 $(DESTDIR)$(man5dir)
 	$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir)
@@ -220,7 +222,9 @@ $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 install-webdoc : html
 	sh ./install-webdoc.sh $(WEBDOC_DEST)
 
-quick-install:
+quick-install: quick-install-man
+
+quick-install-man:
 	sh ./install-doc-quick.sh $(DOC_REF) $(DESTDIR)$(mandir)
 
 quick-install-html:
diff --git a/INSTALL b/INSTALL
index a4fd862..d1deb0b 100644
--- a/INSTALL
+++ b/INSTALL
@@ -126,8 +126,9 @@ Issues of note:
 
 	http://www.kernel.org/pub/software/scm/git/docs/
 
-   There are also "make quick-install-doc" and "make quick-install-html"
-   which install preformatted man pages and html documentation.
+   There are also "make quick-install-doc", "make quick-install-man"
+   and "make quick-install-html" which install preformatted man pages
+   and html documentation.
    This does not require asciidoc/xmlto, but it only works from within
    a cloned checkout of git.git with these two extra branches, and will
    not work for the maintainer for obvious chicken-and-egg reasons.
diff --git a/Makefile b/Makefile
index 4b54416..cc7959e 100644
--- a/Makefile
+++ b/Makefile
@@ -1411,6 +1411,9 @@ endif
 install-doc:
 	$(MAKE) -C Documentation install
 
+install-man:
+	$(MAKE) -C Documentation install-man
+
 install-html:
 	$(MAKE) -C Documentation install-html
 
@@ -1420,6 +1423,9 @@ install-info:
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
+quick-install-man:
+	$(MAKE) -C Documentation quick-install-man
+
 quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
 
-- 
1.6.0.3.536.gb5136
