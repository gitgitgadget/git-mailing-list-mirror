From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Include Makefile.localdef in Makefile, if it exists.
Date: Fri, 02 Dec 2005 15:11:42 -0800
Message-ID: <28417.1133565102@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Sat Dec 03 00:12:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiK4A-0001Fu-B8
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 00:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVLBXLo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 18:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVLBXLo
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 18:11:44 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:40854 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750998AbVLBXLn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 18:11:43 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB2NBh6d028419
	for <git@vger.kernel.org>; Fri, 2 Dec 2005 15:11:43 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB2NBhoX028418
	for <git@vger.kernel.org>; Fri, 2 Dec 2005 15:11:43 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13134>

Makefile.localdef is just a hook for local definitions.  Users
can track their definitions in a branch and not worry about
merge conflicts.

Signed-off-by: E. Jason Riedy <ejr@cs.berkeley.edu>

---

 Makefile |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

applies-to: b93e1c78095bf4ace0806ab70295931f6da28174
65e5d3d6d31af3dda6d5cfd4e0745f34118955c3
diff --git a/Makefile b/Makefile
index df3c6eb..dc7581d 100644
--- a/Makefile
+++ b/Makefile
@@ -64,18 +64,21 @@ LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
-prefix = $(HOME)
-bindir = $(prefix)/bin
-template_dir = $(prefix)/share/git-core/templates/
-GIT_PYTHON_DIR = $(prefix)/share/git-core/python
-# DESTDIR=
-
 CC = gcc
 AR = ar
 TAR = tar
 INSTALL = install
 RPMBUILD = rpmbuild
 
+# Include local definitions, if any.
+-include Makefile.localdef
+
+prefix ?= $(HOME)
+bindir ?= $(prefix)/bin
+template_dir ?= $(prefix)/share/git-core/templates/
+GIT_PYTHON_DIR ?= $(prefix)/share/git-core/python
+# DESTDIR=
+
 # sparse is architecture-neutral, which means that we need to tell it
 # explicitly what architecture to check for. Fix this up for yours..
 SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
---
0.99.9h
