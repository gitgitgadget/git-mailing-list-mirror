From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 11/19] Basic build infrastructure for Python scripts
Date: Thu, 29 Oct 2009 11:01:19 -0700
Message-ID: <1256839287-19016-12-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Johan Herland <johan@herland.net>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKn-0004ac-K3
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbZJ2SCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754464AbZJ2SCf
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:35 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:43668 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369AbZJ2SCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:32 -0400
Received: by mail-pz0-f188.google.com with SMTP id 26so1412783pzk.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GBB/IVo6BvWY3UHbfocCOwpIQNbBozINnEK1VR5K9es=;
        b=A/0VbgrlH7VTcSEeTvZ9H7mskgXpz4iZYy9HAJIMxGFL5hlrTLy9we5uSeQEx+cF2b
         LlzcdGwKjEqF5WHunjFAbzuXySmD/D40u4BqVlpGWQqO7aIKitqi57jiHAOqy1NTdrzB
         Kls3g2jKF6mXvjXoi5xyNZ2g4su+lGbr3Vm1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FhVMJZbkkAwj51KSKIoCsjVX7ed1jQmYamn25F8GLa8IxPOnalaZCU7yXEXHeRUOZt
         RWcifBtTDq7IwapAkxG/3SACd90oauTNXc6P2e2DXMLwjfcPVCRZTOf9FlAIjd5U8xmA
         pQBx4btwiaV5JH85gndLqYOJh5Lcke4uiR2aY=
Received: by 10.114.71.20 with SMTP id t20mr242218waa.205.1256839357666;
        Thu, 29 Oct 2009 11:02:37 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131625>

From: Johan Herland <johan@herland.net>

This patch adds basic boilerplate support (based on corresponding Perl
sections) for enabling the building and installation Python scripts.

There are currently no Python scripts being built, and when Python
scripts are added in future patches, their building and installation
can be disabled by defining NO_PYTHON.

Signed-off-by: Johan Herland <johan@herland.net>
---

	Unchanged.

 Makefile      |   13 +++++++++++++
 configure.ac  |    3 +++
 t/test-lib.sh |    1 +
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 268aede..b27a7d6 100644
--- a/Makefile
+++ b/Makefile
@@ -164,6 +164,8 @@ all::
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
+# Define NO_PYTHON if you do not want Python scripts or libraries at all.
+#
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
 # The TCL_PATH variable governs the location of the Tcl interpreter
@@ -308,6 +310,7 @@ LIB_H =
 LIB_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
+SCRIPT_PYTHON =
 SCRIPT_SH =
 TEST_PROGRAMS =
 
@@ -345,6 +348,7 @@ SCRIPT_PERL += git-svn.perl
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
+	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-instaweb
 
 # Empty...
@@ -398,8 +402,12 @@ endif
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
+ifndef PYTHON_PATH
+	PYTHON_PATH = /usr/bin/python
+endif
 
 export PERL_PATH
+export PYTHON_PATH
 
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
@@ -1308,6 +1316,10 @@ ifeq ($(PERL_PATH),)
 NO_PERL=NoThanks
 endif
 
+ifeq ($(PYTHON_PATH),)
+NO_PYTHON=NoThanks
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -1355,6 +1367,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
diff --git a/configure.ac b/configure.ac
index b09b8e4..84b6cf4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -233,6 +233,9 @@ GIT_ARG_SET_PATH(shell)
 # Define PERL_PATH to provide path to Perl.
 GIT_ARG_SET_PATH(perl)
 #
+# Define PYTHON_PATH to provide path to Python.
+GIT_ARG_SET_PATH(python)
+#
 # Define ZLIB_PATH to provide path to zlib.
 GIT_ARG_SET_PATH(zlib)
 #
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2ca536..0b991db 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -729,6 +729,7 @@ case $(uname -s) in
 esac
 
 test -z "$NO_PERL" && test_set_prereq PERL
+test -z "$NO_PYTHON" && test_set_prereq PYTHON
 
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
-- 
1.6.5.2.291.gf76a3
