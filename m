From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] user-manual: run xsltproc without --nonet option
Date: Sun, 18 Mar 2007 23:17:56 -0400
Message-ID: <522.111988584761$1174274339@news.gmane.org>
References: <117427428145-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:18:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8Oa-0000J6-DR
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933794AbXCSDSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933788AbXCSDSG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:18:06 -0400
Received: from mail.fieldses.org ([66.93.2.214]:45758 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933794AbXCSDSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:18:04 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HT8Nl-0003JV-H3; Sun, 18 Mar 2007 23:18:01 -0400
X-Mailer: git-send-email 1.5.0.3.g6c05
In-Reply-To: <117427428145-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42569>

From: J. Bruce Fields <bfields@citi.umich.edu>

The --nonet option prevents xsltproc from going to the network to find
anything.  But it always tries to find them locally first, so for a
user with the necessary docbook stylesheets installed the build will
work just fine without xsltproc attempting to use the network; all
--nonet does is make it fail rather than falling back on that.  That
doesn't seem particularly helpful.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7c1c9e1..48d41c5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -106,7 +106,7 @@ user-manual.xml: user-manual.txt user-manual.conf
 	$(ASCIIDOC) -b docbook -d book $<
 
 XSLT = http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
-XSLTOPTS = --nonet --xinclude --stringparam html.stylesheet docbook-xsl.css
+XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
 user-manual.html: user-manual.xml
 	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
-- 
1.5.0.3.31.ge47c
