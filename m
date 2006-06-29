From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] Rename man1 and man7 variables to man1dir and man7dir
Date: Thu, 29 Jun 2006 23:26:54 +0200
Organization: At home
Message-ID: <e81gim$cf7$1@sea.gmane.org>
References: <200606292211.28352.jnareb@gmail.com> <200606292213.00726.jnareb@gmail.com> <7v1wt7ra1h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 29 23:27:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw42d-0006xy-Ey
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbWF2V1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWF2V1M
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:27:12 -0400
Received: from main.gmane.org ([80.91.229.2]:29133 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932718AbWF2V1L (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 17:27:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fw42R-0006vs-Mi
	for git@vger.kernel.org; Thu, 29 Jun 2006 23:27:03 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 23:27:03 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 23:27:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22908>

This patch renames man1 and man7 variables to man1dir and man7dir,
according to "Makefile Conventions: Variables for Installation
Directories" in make.info of GNU Make.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

Junio C Hamano wrote:

> Doesn't this break "make dist-doc" by _REMOVING_ make variables
> man1 and man7, which I mentioned earlier?

This is corrected patch. I think I catched all occurences, but I cannot
do 'make dist-doc' because I haven't got asciidoc installed.

Could some kind soul check changes introduced by this patch, please?


P.S. This patch is sent from newsreader, not mail program. I hope
it doesn't mangle whitespaces in patch.

 Documentation/Makefile   |   10 +++++-----
 Makefile                 |    4 ++--
 contrib/git-svn/Makefile |    4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ca6b77d..cc83610 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -27,8 +27,8 @@ DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT
 prefix?=$(HOME)
 bindir?=$(prefix)/bin
 mandir?=$(prefix)/man
-man1=$(mandir)/man1
-man7=$(mandir)/man7
+man1dir=$(mandir)/man1
+man7dir=$(mandir)/man7
 # DESTDIR=
 
 INSTALL?=install
@@ -52,9 +52,9 @@ man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
 install: man
-       $(INSTALL) -d -m755 $(DESTDIR)$(man1) $(DESTDIR)$(man7)
-       $(INSTALL) $(DOC_MAN1) $(DESTDIR)$(man1)
-       $(INSTALL) $(DOC_MAN7) $(DESTDIR)$(man7)
+       $(INSTALL) -d -m755 $(DESTDIR)$(man1dir) $(DESTDIR)$(man7dir)
+       $(INSTALL) $(DOC_MAN1) $(DESTDIR)$(man1dir)
+       $(INSTALL) $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
 
 #
diff --git a/Makefile b/Makefile
index b8fe669..ccd7c62 100644
--- a/Makefile
+++ b/Makefile
@@ -714,8 +714,8 @@ dist-doc:
        rm -fr .doc-tmp-dir
        mkdir .doc-tmp-dir .doc-tmp-dir/man1 .doc-tmp-dir/man7
        $(MAKE) -C Documentation DESTDIR=./ \
-               man1=../.doc-tmp-dir/man1 \
-               man7=../.doc-tmp-dir/man7 \
+               man1dir=../.doc-tmp-dir/man1 \
+               man7dir=../.doc-tmp-dir/man7 \
                install
        cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar .
        gzip -n -9 -f $(manpages).tar
diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
index 1a6585e..8cac688 100644
--- a/contrib/git-svn/Makefile
+++ b/contrib/git-svn/Makefile
@@ -3,7 +3,7 @@ all: git-svn
 prefix?=$(HOME)
 bindir?=$(prefix)/bin
 mandir?=$(prefix)/man
-man1=$(mandir)/man1
+man1dir=$(mandir)/man1
 INSTALL?=install
 doc_conf=../../Documentation/asciidoc.conf
 -include ../../config.mak
@@ -17,7 +17,7 @@ install: all
        $(INSTALL) git-svn $(DESTDIR)$(bindir)
 
 install-doc: doc
-       $(INSTALL) git-svn.1 $(DESTDIR)$(man1)
+       $(INSTALL) git-svn.1 $(DESTDIR)$(man1dir)
 
 doc: git-svn.1
 git-svn.1 : git-svn.xml
-- 
1.4.0
