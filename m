From: jaysoffian+git@gmail.com
Subject: [PATCH] git-gui: support OS X 10.5
Date: Mon, 11 Feb 2008 14:21:31 -0500
Message-ID: <1202757691-20054-1-git-send-email-jaysoffian+git@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 20:22:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOeEF-0007ii-CU
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbYBKTVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:21:37 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbYBKTVh
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:21:37 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:25061 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbYBKTVg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:21:36 -0500
Received: by an-out-0708.google.com with SMTP id d31so1168155and.103
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 11:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:message-id:x-mailer:sender;
        bh=79qmi0X7BnB6o+eHGIyLELf2NfyREGHUwYgdY9b3ixw=;
        b=K3jS4mPGjGejvUU1kiWx4Tne6LQJ3PTdWd1oXP9Dwq063Dmb32gPx800jp9oQiUywR3zrVztCF6cdLuFQP+iS//DPtwqE/fKD+gdp27Y92TL476VNjGNUgUpke0eNzvPEMtouiBZ15/Viq2iPUySIlGq1Q0WMxK9Mucu+j7M1Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:sender;
        b=ZTAdWfGj9Bvmej+IUdxbwUuAzxxrL/OPkLgQk91Gf4ost+/qI3ak17VsuuAfBnMI+oxecc4Hj2iOC1ZPgV32+w6ciPj1Dkn+p3fbSIDRLkCfmrB/s2prjdmeWhJ+i2hGhGpuLXyZixGeW8s74u77pmHhZ5aE1nNWjseU9KSIZjk=
Received: by 10.100.247.14 with SMTP id u14mr683011anh.90.1202757694621;
        Mon, 11 Feb 2008 11:21:34 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d19sm32666235and.6.2008.02.11.11.21.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 11:21:34 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1231.g4e386
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73568>

The Tk Framework moved its location in 10.5 compared to 10.4

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-gui/Makefile          |   17 +++++++++++++----
 git-gui/macosx/Info.plist |    2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 34438cd..15f3718 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -13,6 +13,7 @@ GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
=20
 uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_O :=3D $(shell sh -c 'uname -o 2>/dev/null || echo not')
+uname_R :=3D $(shell sh -c 'uname -r 2>/dev/null || echo not')
=20
 SCRIPT_SH =3D git-gui.sh
 GITGUI_MAIN :=3D git-gui
@@ -93,7 +94,14 @@ endif
=20
 TCL_PATH   ?=3D tclsh
 TCLTK_PATH ?=3D wish
-TKFRAMEWORK =3D /Library/Frameworks/Tk.framework/Resources/Wish.app
+
+ifeq ($(uname_S),Darwin)
+	TKFRAMEWORK =3D /Library/Frameworks/Tk.framework/Resources/Wish.app
+	ifeq ($(shell expr "$(uname_R)" : '9\.'),2)
+		TKFRAMEWORK =3D /System/Library/Frameworks/Tk.framework/Resources/Wi=
sh\ Shell.app
+	endif
+	TKEXECUTABLE =3D $(shell basename "$(TKFRAMEWORK)" .app)
+endif
=20
 ifeq ($(findstring $(MAKEFLAGS),s),s)
 QUIET_GEN =3D
@@ -147,7 +155,7 @@ git-gui: GIT-VERSION-FILE GIT-GUI-VARS
 	echo then >>$@+ && \
 	echo '	'echo \'git-gui version '$(GITGUI_VERSION)'\' >>$@+ && \
 	echo else >>$@+ && \
-	echo '	'exec \''$(libdir_SQ)/Git Gui.app/Contents/MacOS/Wish'\' \
+	echo '	'exec \''$(libdir_SQ)/Git Gui.app/Contents/MacOS/$(subst \,,$(=
TKEXECUTABLE))'\' \
 		'"$$0" "$$@"' >>$@+ && \
 	echo fi >>$@+ && \
 	chmod +x $@+ && \
@@ -157,14 +165,15 @@ Git\ Gui.app: GIT-VERSION-FILE GIT-GUI-VARS \
 		macosx/Info.plist \
 		macosx/git-gui.icns \
 		macosx/AppMain.tcl \
-		$(TKFRAMEWORK)/Contents/MacOS/Wish
+		$(TKFRAMEWORK)/Contents/MacOS/Wish\ Shell
 	$(QUIET_GEN)rm -rf '$@' '$@'+ && \
 	mkdir -p '$@'+/Contents/MacOS && \
 	mkdir -p '$@'+/Contents/Resources/Scripts && \
-	cp '$(subst ','\'',$(TKFRAMEWORK))/Contents/MacOS/Wish' \
+	cp '$(subst ','\'',$(subst \,,$(TKFRAMEWORK)/Contents/MacOS/$(TKEXECU=
TABLE)))' \
 		'$@'+/Contents/MacOS && \
 	cp macosx/git-gui.icns '$@'+/Contents/Resources && \
 	sed -e 's/@@GITGUI_VERSION@@/$(GITGUI_VERSION)/g' \
+		-e 's/@@GITGUI_TKEXECUTABLE@@/$(TKEXECUTABLE)/g' \
 		macosx/Info.plist \
 		>'$@'+/Contents/Info.plist && \
 	sed -e 's|@@gitexecdir@@|$(gitexecdir_SQ)|' \
diff --git a/git-gui/macosx/Info.plist b/git-gui/macosx/Info.plist
index 99913ec..b3bf15f 100644
--- a/git-gui/macosx/Info.plist
+++ b/git-gui/macosx/Info.plist
@@ -5,7 +5,7 @@
 	<key>CFBundleDevelopmentRegion</key>
 	<string>English</string>
 	<key>CFBundleExecutable</key>
-	<string>Wish</string>
+	<string>@@GITGUI_TKEXECUTABLE@@</string>
 	<key>CFBundleGetInfoString</key>
 	<string>Git Gui @@GITGUI_VERSION@@ =C2=A9 2006-2007 Shawn Pearce, et.=
 al.</string>
 	<key>CFBundleIconFile</key>
--=20
1.5.4.1.1231.g4e386
