From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: [PATCH 1/2] allow installation of man and html doc from the man and html branches
Date: Tue, 9 Sep 2008 22:44:17 +0200
Message-ID: <1082ea29216aba63f5d2b13763eeceebe46e0691.1221035620.git.michaeljgruber+gmane@fastmail.fm>
References: <cover.1221035620.git.michaeljgruber+gmane@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 11:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdLej-0001Rc-Oo
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 11:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbYIJJF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 05:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbYIJJFZ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 05:05:25 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57119 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751508AbYIJJFV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 05:05:21 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 405EC15FB72
	for <git@vger.kernel.org>; Wed, 10 Sep 2008 05:05:21 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 10 Sep 2008 05:05:21 -0400
X-Sasl-enc: Dqzp38T65BAMLaDxkiZ6fV3PJWD8lBraAfb25GSieo+p 1221037520
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D469028807
	for <git@vger.kernel.org>; Wed, 10 Sep 2008 05:05:20 -0400 (EDT)
X-Mailbox-Line: From 1082ea29216aba63f5d2b13763eeceebe46e0691 Mon Sep 17 00:00:00 2001
In-Reply-To: <cover.1221035620.git.michaeljgruber+gmane@fastmail.fm>
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95501>

This patch introduces a make target "quick-install-html" which installs
the html documentation from the branch origin/html, without the need for
asciidoc/xmlto. This is analogous to the existing "quick-install-doc"
target for the man pages.

We advertise these targets in the INSTALL file now.

Signed-off-by: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
---
 Documentation/Makefile |    4 ++++
 INSTALL                |    5 +++++
 Makefile               |    3 +++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 62269e3..ded0e40 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -44,6 +44,7 @@ MANPAGE_XSL = callouts.xsl
 INSTALL?=install
 RM ?= rm -f
 DOC_REF = origin/man
+HTML_REF = origin/html
 
 infodir?=$(prefix)/share/info
 MAKEINFO=makeinfo
@@ -222,4 +223,7 @@ install-webdoc : html
 quick-install:
 	sh ./install-doc-quick.sh $(DOC_REF) $(DESTDIR)$(mandir)
 
+quick-install-html:
+	sh ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
+
 .PHONY: .FORCE-GIT-VERSION-FILE
diff --git a/INSTALL b/INSTALL
index 2bae53f..7c13473 100644
--- a/INSTALL
+++ b/INSTALL
@@ -117,6 +117,11 @@ Issues of note:
 
 	http://www.kernel.org/pub/software/scm/git/docs/
 
+   There is also "make quick-install-doc" and "make quick-install-html"
+   which installs man pages resp. html documentation from these branches.
+   This does not require asciidoc/xmlto, but it works from within
+   a checkout of git.git only.
+
    It has been reported that docbook-xsl version 1.72 and 1.73 are
    buggy; 1.72 misformats manual pages for callouts, and 1.73 needs
    the patch in contrib/patches/docbook-xsl-manpages-charmap.patch
diff --git a/Makefile b/Makefile
index f4c31c8..eeaf6d4 100644
--- a/Makefile
+++ b/Makefile
@@ -1401,6 +1401,9 @@ install-info:
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
+quick-install-html:
+	$(MAKE) -C Documentation quick-install-html
+
 
 
 ### Maintainer's dist rules
-- 
1.6.0.1.285.g1070
