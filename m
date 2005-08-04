From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Use $DESTDIR instead of $dest
Date: Fri, 5 Aug 2005 01:56:38 +0200
Message-ID: <20050804235638.GL24479@pasky.ji.cz>
References: <20050804225529.GJ24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 05 02:00:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0pdJ-0006W4-Vi
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 02:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVHDX7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 19:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVHDX56
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 19:57:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30222 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262770AbVHDX4i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 19:56:38 -0400
Received: (qmail 16815 invoked by uid 2001); 4 Aug 2005 23:56:38 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050804225529.GJ24479@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

$DESTDIR is more usual during the build than $dest and is what is usually
used in the makefiles, so let's use it too.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---

	This updates the subdirectory Makefiles as well.

commit aef274d1fc04d848c7355a68c3e48c0b2b5400cb
tree 546c10ded595cf48473ce216b594607fd922836d
parent aa6f095b0cd57ab424f02695ccfc8168f5c3b981
author Petr Baudis <pasky@suse.cz> Fri, 05 Aug 2005 01:55:36 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 05 Aug 2005 01:55:36 +0200

 Documentation/Makefile |    6 +++---
 Makefile               |    6 +++---
 templates/Makefile     |   10 +++++-----
 tools/Makefile         |    6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -33,9 +33,9 @@ man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
 install:
-	$(INSTALL) -m755 -d $(dest)/$(man1) $(dest)/$(man7)
-	$(INSTALL) $(DOC_MAN1) $(dest)/$(man1)
-	$(INSTALL) $(DOC_MAN7) $(dest)/$(man7)
+	$(INSTALL) -m755 -d $(DESTDIR)/$(man1) $(DESTDIR)/$(man7)
+	$(INSTALL) $(DOC_MAN1) $(DESTDIR)/$(man1)
+	$(INSTALL) $(DOC_MAN7) $(DESTDIR)/$(man7)
 
 # 'include' dependencies
 git-diff-%.txt: diff-format.txt diff-options.txt
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -41,7 +41,7 @@ prefix=$(HOME)
 bindir=$(prefix)/bin
 etcdir=$(prefix)/etc
 etcgitdir=$(etcdir)/git-core
-# dest=
+# DESTDIR=
 
 CC?=gcc
 AR?=ar
@@ -197,8 +197,8 @@ check:
 ### Installation rules
 
 install: $(PROG) $(SCRIPTS)
-	$(INSTALL) -m755 -d $(dest)$(bindir)
-	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bindir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
+	$(INSTALL) $(PROG) $(SCRIPTS) $(DESTDIR)$(bindir)
 	$(MAKE) -C templates install
 
 install-tools:
diff --git a/templates/Makefile b/templates/Makefile
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -5,15 +5,15 @@ prefix=$(HOME)
 etcdir=$(prefix)/etc
 etcgitdir=$(etcdir)/git-core
 templatedir=$(etcgitdir)/templates
-# dest=
+# DESTDIR=
 
 all:
 clean:
 
 install:
-	$(INSTALL) -d -m755 $(dest)$(templatedir)/hooks/
+	$(INSTALL) -d -m755 $(DESTDIR)$(templatedir)/hooks/
 	$(foreach s,$(wildcard hooks--*),\
 		$(INSTALL) -m644 $s \
-		$(dest)$(templatedir)/hooks/$(patsubst hooks--%,%,$s);)
-	$(INSTALL) -d -m755 $(dest)$(templatedir)/info
-	$(INSTALL) -d -m755 $(dest)$(templatedir)/branches
+		$(DESTDIR)$(templatedir)/hooks/$(patsubst hooks--%,%,$s);)
+	$(INSTALL) -d -m755 $(DESTDIR)$(templatedir)/info
+	$(INSTALL) -d -m755 $(DESTDIR)$(templatedir)/branches
diff --git a/tools/Makefile b/tools/Makefile
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -8,7 +8,7 @@ INSTALL=install
 HOME=$(shell echo $$HOME)
 prefix=$(HOME)
 bindir=$(prefix)/bin
-# dest=
+# DESTDIR=
 
 PROGRAMS=git-mailsplit git-mailinfo
 SCRIPTS=git-applymbox git-applypatch
@@ -19,8 +19,8 @@ git-%: %.c
 all: $(PROGRAMS)
 
 install: $(PROGRAMS) $(SCRIPTS)
-	$(INSTALL) -m755 -d $(dest)$(bindir)
-	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(dest)$(bindir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
+	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(DESTDIR)$(bindir)
 
 clean:
 	rm -f $(PROGRAMS) *.o
