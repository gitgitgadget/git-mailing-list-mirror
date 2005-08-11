From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] update Debian packaging for cogito
Date: Thu, 11 Aug 2005 12:20:01 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.11.10.19.38.246921@smurf.noris.de>
References: <20050805020307.GP24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 11 12:24:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3ADB-0000zD-Tq
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 12:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVHKKWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 06:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVHKKWz
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 06:22:55 -0400
Received: from main.gmane.org ([80.91.229.2]:6335 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964877AbVHKKWy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 06:22:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E3ABM-0000fU-Gp
	for git@vger.kernel.org; Thu, 11 Aug 2005 12:21:04 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 12:21:04 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 12:21:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Cleaned up Debian files.
Conflict with cgvg instead of not installing cg.
Pass prefix=/usr to "make install".
---
diff --git a/debian/changelog b/debian/changelog
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,12 @@
+cogito (0.13-1) stable; urgency=low
+
+  * New version.
+  * Cleaned up Debian files.
+  * Conflict with cgvg instead of not installing cg.
+  * Pass prefix=/usr to "make install".
+
+ -- Matthias Urlichs <smurf@debian.org>  Thu, 11 Aug 2005 12:17:32 +0200
+
 cogito (0.12.1-1) stable; urgency=low
 
   * new version 0.12.1 (needed in order check out Linus' git trees).
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -9,7 +9,7 @@ Package: cogito
 Architecture: any
 Depends: git-core, ${shlibs:Depends}, patch, diff, rcs
 Recommends: rsync, curl, wget, rsh-client
+Conflicts: cgvg
 Description: version control system
  Cogito is the user-friendly front-end to the GIT directory content
- manager.  This package includes both the low-level GIT tools and the
- high-level Cogito programs.
+ manager.  This package includes the high-level Cogito programs.
diff --git a/debian/copyright b/debian/copyright
--- a/debian/copyright
+++ b/debian/copyright
@@ -1,3 +1,24 @@
-License: 
+This package was downloaded via git from
+master.kernel.org:/pub/scm/cogito/cogito.git.
+
+Upstream Author: Petr Baudis
+
+Copyright:
+
+   This package is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; version 2 dated June, 1991.
+
+   This package is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this package; if not, write to the Free Software
+   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+   02111-1307, USA.
+
+On Debian GNU/Linux systems, the complete text of the GNU General
+Public License can be found in `/usr/share/common-licenses/GPL'.
 
-GPL v2 (see COPYING for details)
diff --git a/debian/docs b/debian/docs
--- a/debian/docs
+++ b/debian/docs
@@ -1,3 +1 @@
 README
-COPYING
-
diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -64,8 +64,8 @@ install: build
 	dh_testroot
 	dh_clean -k 
 	dh_installdirs
-	$(MAKE) install DESTDIR=$(CURDIR)/debian/cogito
-	$(RM) $(DESTDIR)/usr/bin/cg
+	$(MAKE) install DESTDIR=$(CURDIR)/debian/cogito prefix=/usr
+	# $(RM) $(DESTDIR)/usr/bin/cg
 	install -m 0644 Documentation/*.html $(DESTDIR)/usr/share/doc/cogito/html
 	install -m 0644 Documentation/cogito.txt $(DESTDIR)/usr/share/doc/cogito/txt
 	install -m 0644 Documentation/*.7 $(DESTDIR)/usr/share/man/man7


-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Wide flush the fields; the softening air is balm; Echo the mountains round;
the forest smiles; And every sense and every heart is joy.
					-- Thomson
