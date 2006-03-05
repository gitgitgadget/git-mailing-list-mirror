From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] contrib/emacs/Makefile: Provide tool for byte-compiling files.
Date: Sun, 05 Mar 2006 16:14:31 +0000
Message-ID: <20060305161431.23622.20032.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sun Mar 05 17:14:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFvsd-0000iY-38
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 17:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWCEQOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 11:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWCEQOo
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 11:14:44 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:28572 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932194AbWCEQOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 11:14:43 -0500
Received: (qmail 23646 invoked from network); 5 Mar 2006 16:14:31 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 5 Mar 2006 16:14:31 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17232>

From: Mark Wooding <mdw@distorted.org.uk>

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 contrib/emacs/.gitignore |    1 +
 contrib/emacs/Makefile   |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/.gitignore b/contrib/emacs/.gitignore
new file mode 100644
index 0000000..c531d98
--- /dev/null
+++ b/contrib/emacs/.gitignore
@@ -0,0 +1 @@
+*.elc
diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile
new file mode 100644
index 0000000..d3619db
--- /dev/null
+++ b/contrib/emacs/Makefile
@@ -0,0 +1,20 @@
+## Build and install stuff
+
+EMACS = emacs
+
+ELC = git.elc vc-git.elc
+INSTALL = install
+INSTALL_ELC = $(INSTALL) -m 644
+prefix = $(HOME)
+emacsdir = $(prefix)/share/emacs/site-lisp
+
+all: $(ELC)
+
+install: all
+	$(INSTALL) -d $(emacsdir)
+	$(INSTALL_ELC) $(ELC) $(emacsdir)
+
+%.elc: %.el
+	$(EMACS) --batch --eval '(byte-compile-file "$<")'
+
+clean:; rm -f $(ELC)
