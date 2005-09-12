From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: [PATCH] There are several undocumented dependencies
Date: Sun, 11 Sep 2005 20:00:49 -0400
Message-ID: <200509120000.j8C00n9M012603@inti.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Mon Sep 12 07:11:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEgZw-0005Qn-4g
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 07:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVILFJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 01:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVILFJy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 01:09:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42186 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751169AbVILFJy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 01:09:54 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8C00n9M012603
	for <git@vger.kernel.org>; Sun, 11 Sep 2005 20:00:49 -0400
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8367>

There are several undocumented dependencies in the .spec and in the
INSTALL files. The following is from Fedora, perhaps other RPM
distributions call the packages differently.

Also, the manpages aren't always installed gzipped.

Updates to git-core.spec.in file:
 - Some git scripts use Perl
 - gitk needs wish, which is part of TCL/Tk.
 - curl is used all over
 - Need the ssh program from openssh-clients

Updates to INSTALL:
 - Mention wish
 - Mention ssh

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>


---

 INSTALL          |    5 +++++
 git-core.spec.in |   12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

0a0c8b97bcab58e2b70c0eb76a83bd7c5b6fd1bc
diff --git a/INSTALL b/INSTALL
--- a/INSTALL
+++ b/INSTALL
@@ -64,3 +64,8 @@ Issues of note:
 	  You'll only need the merge program if you do development using
 	  git, and if you only use git to track other peoples work you'll
 	  never notice the lack of it. 
+
+        - "wish", the TCL/Tk windowing shell is used in gitk to show the
+          history graphically
+
+	- "ssh" is used to push and pull over the net
diff --git a/git-core.spec.in b/git-core.spec.in
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -2,7 +2,7 @@
 Name: 		git-core
 Version: 	@@VERSION@@
 Release: 	1
-Vendor: 	Junio C Hamano <junkio@cox.net>
+Vendor: 	Junio C. Hamano <junkio@cox.net>
 Summary:  	Git core and tools
 License: 	GPL
 Group: 		Development/Tools
@@ -10,7 +10,7 @@ URL: 		http://kernel.org/pub/software/sc
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-root
-Requires: 	sh-utils, diffutils, rsync, rcs, python >= 2.4
+Requires: 	sh-utils, curl, diffutils, rsync, rcs, openssh-clients, perl, python >= 2.4, tk
 
 %description
 This is a stupid (but extremely fast) directory content manager.  It
@@ -40,10 +40,14 @@ rm -rf $RPM_BUILD_ROOT
 %{_datadir}/git-core/templates/*
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html }
-%{!?_without_docs: %{_mandir}/man1/*.1.gz}
-%{!?_without_docs: %{_mandir}/man7/*.7.gz}
+%{!?_without_docs: %{_mandir}/man1/*.1*}
+%{!?_without_docs: %{_mandir}/man7/*.7*}
 
 %changelog
+* Sun Sep 11 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
+- Updated dependencies
+- Don't assume manpages are gzipped
+
 * Sun Aug 07 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
 - Redid the description
 - Cut overlong make line, loosened changelog a bit
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
