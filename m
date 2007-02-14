From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] add install-lib target to install libgit.a library plus headers.
Date: Wed, 14 Feb 2007 14:57:25 +0000
Message-ID: <20070214145725.2827.qmail@0b3a4e2ad592dc.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 15:57:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHLZP-00064Z-Rt
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbXBNO5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbXBNO5K
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:57:10 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:49295 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932319AbXBNO5J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:57:09 -0500
Received: (qmail 2828 invoked by uid 1000); 14 Feb 2007 14:57:25 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39654>

Patch from Luca Falavigna to install git static library and header files
into $(prefix)/lib/, $(prefix)/include/git/, see

 http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=407722

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Makefile |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ebecbbd..19fe3d5 100644
--- a/Makefile
+++ b/Makefile
@@ -123,6 +123,8 @@ STRIP ?= strip
 prefix = $(HOME)
 bindir = $(prefix)/bin
 gitexecdir = $(bindir)
+headerdir = $(prefix)/include/git
+libdir = $(prefix)/lib
 template_dir = $(prefix)/share/git-core/templates/
 # DESTDIR=
 
@@ -588,6 +590,8 @@ SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+headerdir_SQ = $(subst ','\'',$(headerdir))
+libdir_SQ = $(subst ','\'',$(libdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 prefix_SQ = $(subst ','\'',$(prefix))
 
@@ -863,7 +867,11 @@ install-doc:
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-
+install-lib: $(LIB_FILE)
+	$(INSTALL) -d -m0755 '$(DESTDIR_SQ)$(headerdir_SQ)'
+	$(INSTALL) -d -m0755 '$(DESTDIR_SQ)$(libdir_SQ)'
+	$(INSTALL) -m0644 $(LIB_H) '$(DESTDIR_SQ)$(headerdir_SQ)'
+	$(INSTALL) -m0644 $(LIB_FILE) '$(DESTDIR_SQ)$(libdir_SQ)'
 
 ### Maintainer's dist rules
 
-- 
1.5.0
