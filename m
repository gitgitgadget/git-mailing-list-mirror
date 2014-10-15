From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/2] subtree: Add an install-html target
Date: Wed, 15 Oct 2014 20:49:28 +0200
Message-ID: <543EC1B8.4050009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 20:49:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeTdt-00040M-2h
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 20:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbaJOStp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 14:49:45 -0400
Received: from plane.gmane.org ([80.91.229.3]:51694 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbaJOSto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 14:49:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XeTdm-0003vh-Ug
	for git@vger.kernel.org; Wed, 15 Oct 2014 20:49:42 +0200
Received: from p4ff44b8f.dip0.t-ipconnect.de ([79.244.75.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 20:49:42 +0200
Received: from sschuberth by p4ff44b8f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 20:49:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4ff44b8f.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also adjust ignore rules accordingly.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 contrib/subtree/.gitignore | 3 ++-
 contrib/subtree/Makefile   | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
index 91360a3..0b9381a 100644
--- a/contrib/subtree/.gitignore
+++ b/contrib/subtree/.gitignore
@@ -1,6 +1,7 @@
 *~
 git-subtree
-git-subtree.xml
 git-subtree.1
+git-subtree.html
+git-subtree.xml
 mainline
 subproj
diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index c2bd703..3071baf 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -5,9 +5,10 @@ all::
 -include ../../config.mak
 
 prefix ?= /usr/local
-mandir ?= $(prefix)/share/man
 gitexecdir ?= $(prefix)/libexec/git-core
+mandir ?= $(prefix)/share/man
 man1dir ?= $(mandir)/man1
+htmldir ?= $(prefix)/share/doc/git-doc
 
 ../../GIT-VERSION-FILE: FORCE
 	$(MAKE) -C ../../ GIT-VERSION-FILE
@@ -49,12 +50,16 @@ install: $(GIT_SUBTREE)
 	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
 	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(gitexecdir)
 
-install-doc: install-man
+install-doc: install-man install-html
 
 install-man: $(GIT_SUBTREE_DOC)
 	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
 
+install-html: $(GIT_SUBTREE_HTML)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
+	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
+
 $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
 	$(XMLTO) -m $(MANPAGE_XSL) man $^
 
-- 
1.9.4.msysgit.2
