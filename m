Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6E2DF3F8
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893845; cv=none; b=Fhwmi8yxPNLNpheB34EpMaQ0+xGMnI1u1DQtfpnfFwKKm1DxHoPNaeKeKpbB90djDB+uF5z0wNCNKM3XE52V9pg3nlh5gbRteXUAMvNlAS7JVHyPHBmdka0BEt0cNdTLfWN+HYH4qvWXtCR/5mNWC7uzurovqvp2IAIQUqYzrwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893845; c=relaxed/simple;
	bh=+mQgi50f6fpZxM3lt2TCfCHKzhthtEMObBSp/ImBDPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqjkTaqVWpyaydkZX0OV7oCvEXrVGoC+5/eZGdeBl9Ol4thjKGUCuv4bGRWSTVVe9OSv2MIH1PAVaIrpQ1ZKsg6ZhoQ+47E0DuEC6s0fltdKht40fgqU12hcF9/z7yH8pwkJYs0XSoYmA8cXRLhjCrxmi/XI1rcdGcfZHhZnxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5vFGfJt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5vFGfJt"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76b8d289f73so12602b3a.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893843; x=1754498643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+90uw5m/PaNijAo86Ebbtm4/KASfZoS7Fr6pFDZkNc=;
        b=l5vFGfJtcymLkme775E5duUoGN6BVGsJxgW0Kssv8ZvB07bmPPBml216WUaLMXkM6M
         m/xyOaEUNPs6CrQnkoTDXpXnWs4fbJLC+wY+md+okcLI1qrUMRxIMlrFRS830B++0lVa
         +q8FvMe4WJDDpZYTomCRUINUcgU/UXlzdBS3Zqb2M+EvzeFYo3sPzkNd3bZ69fxzD99g
         HLKLLKO+Ma7IoeFxNkOQl6OyXc5KS+/y0mO1GPUcEIfy7tkoAOI6iVxCoFoAF27jLBPw
         xReDqOWl+mluiYL9o2X5TrUC4dnlprPqtO294pWPMeGex3TLTn+0nA4E4Y3TVHRT6mCR
         jDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893843; x=1754498643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+90uw5m/PaNijAo86Ebbtm4/KASfZoS7Fr6pFDZkNc=;
        b=KYEXLT90wOYuNI/6orOvijC5YXQL2kL5Fol/764e+mtr2Cn9fa0sJecT/J/sPMCos1
         voIJYuvX9yv8x46yNVIIMCSXMj7dwXzzPkeL2/tl8SNpO8bnIn68aq5EUQXdeDDCIrWB
         3SDbI2902sPf3/ObkyQoxHzX9gYxlQtO8RI6yOPYOzLxIAVd7cc8U4+MJkMPekVTlqFJ
         injrXvzvVZygxlKcoP9bKR/65GWRz72YOqdrrDhx5rf286g2ngArA2Ny3nlvpsIK1ERx
         AFrC386z6y+xfAVvNgymecfP+t0keTUnUNIg6z+6ku+fV8iY49bLMNbPfUQ9NiHSBV8U
         pjNQ==
X-Gm-Message-State: AOJu0YwLe/lQIDGdRPX68Ku/xYM98laA/iNQ7JExcjEXlUJQcQUdftmr
	joSaf9USLvW8Wne2q6yqg/HgeZPLxgPZ4zkws32qmiVZFJhMziE9fW+02QvP8w==
X-Gm-Gg: ASbGncsOR1d6mKh1mvMEhyri9vi91TCPgj5RamlM+/q6/fiiQMBVspjr5ga721XVKib
	2FS1HwMUZpUcfpdQv4/02C4YMF4vmCilUPh2z6a7xQp30e2sXsOitxwlmV6flCIeE6a1/culU81
	ltfWkWISYIas5a3nXzO3u1fGQXANqPfEXKFfdmdPSdYqDQMsJylMVy2jO0etJbNW05f/etUAbBT
	d1ClqU/RbAWKxOgUg185q3TbDNzIA9v9fhWsatBsVV+m3Ky+kBnEGIhQTOdXpGZ50LcFnhkCrpV
	5we8k6XyM0Yuc0i2HFNYVVw4dnPN3foP5gupXTrSrJv7eVrmYCyhAL57469ZHe7mO99Na+LGHqI
	rjnWIit3D6oXGUddmgj4lyNUDagr4z9ZNHjhqzB1qYjHumfoihKY4pFlPj/49NBXrHz2euTFx
X-Google-Smtp-Source: AGHT+IEfux0XzwvC5YTOdGnLgTHhE+lboCu2nYMFd4EygLe4Y511eMoB5i6gEqihduCQ/tAXiX5FsA==
X-Received: by 2002:a05:6a21:6d97:b0:230:ac08:27fd with SMTP id adf61e73a8af0-23dc0dcec0fmr6196140637.16.1753893842416;
        Wed, 30 Jul 2025 09:44:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58b95esm9671536a12.16.2025.07.30.09.44.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Jul 2025 09:44:01 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH 3/5] git-gui: retire Git Gui.app
Date: Wed, 30 Jul 2025 09:40:50 -0700
Message-ID: <20250730164052.15371-4-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.g795bb014d8
In-Reply-To: <20250730164052.15371-1-carenas@gmail.com>
References: <20250730164052.15371-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In a recent commit, the minimum version of Tcl/Tk was raised to
8.6, but the "app" relies on the system provided Framework that
is based on 8.5.

Remove it, and let git-gui use a third party version of Wish if
available.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .gitignore                |   1 -
 GIT-GUI-BUILD-OPTIONS.in  |   1 -
 Makefile                  |  51 ----------------------------------
 generate-macos-app.sh     |  30 --------------------
 generate-macos-wrapper.sh |  35 -----------------------
 macosx/AppMain.tcl        |  29 -------------------
 macosx/Info.plist         |  30 --------------------
 macosx/git-gui.icns       | Bin 28866 -> 0 bytes
 meson.build               |  57 --------------------------------------
 9 files changed, 234 deletions(-)
 delete mode 100755 generate-macos-app.sh
 delete mode 100755 generate-macos-wrapper.sh
 delete mode 100644 macosx/AppMain.tcl
 delete mode 100644 macosx/Info.plist
 delete mode 100644 macosx/git-gui.icns

diff --git a/.gitignore b/.gitignore
index ff6e0be..ba845f3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,6 +1,5 @@
 .DS_Store
 config.mak
-Git Gui.app*
 git-gui.tcl
 GIT-GUI-BUILD-OPTIONS
 GIT-VERSION-FILE
diff --git a/GIT-GUI-BUILD-OPTIONS.in b/GIT-GUI-BUILD-OPTIONS.in
index 5fd885c..3c112af 100644
--- a/GIT-GUI-BUILD-OPTIONS.in
+++ b/GIT-GUI-BUILD-OPTIONS.in
@@ -4,4 +4,3 @@ GITGUI_RELATIVE=@GITGUI_RELATIVE@
 SHELL_PATH=@SHELL_PATH@
 TCLTK_PATH=@TCLTK_PATH@
 TCL_PATH=@TCL_PATH@
-TKEXECUTABLE=@TKEXECUTABLE@
diff --git a/Makefile b/Makefile
index 179857d..2ac5f44 100644
--- a/Makefile
+++ b/Makefile
@@ -52,8 +52,6 @@ INSTALL_R0 = $(INSTALL) -m 644 # space is required here
 INSTALL_R1 =
 INSTALL_X0 = $(INSTALL) -m 755 # space is required here
 INSTALL_X1 =
-INSTALL_A0 = find # space is required here
-INSTALL_A1 = | cpio -pud
 INSTALL_L0 = rm -f # space is required here
 INSTALL_L1 = && ln # space is required here
 INSTALL_L2 =
@@ -78,8 +76,6 @@ ifndef V
 	INSTALL_R1 = && echo '   ' INSTALL 644 `basename $$src` && $(INSTALL) -m 644 $$src
 	INSTALL_X0 = src=
 	INSTALL_X1 = && echo '   ' INSTALL 755 `basename $$src` && $(INSTALL) -m 755 $$src
-	INSTALL_A0 = src=
-	INSTALL_A1 = && echo '   ' INSTALL '   ' `basename "$$src"` && find "$$src" | cpio -pud
 
 	INSTALL_L0 = dst=
 	INSTALL_L1 = && src=
@@ -100,18 +96,6 @@ else
 	TCL_PATH ?= $(dir $(TCLTK_PATH))$(notdir $(subst wish,tclsh,$(TCLTK_PATH)))
 endif
 
-ifeq ($(uname_S),Darwin)
-	TKFRAMEWORK = /Library/Frameworks/Tk.framework/Resources/Wish.app
-        ifeq ($(shell echo "$(uname_R)" | awk -F. '{if ($$1 >= 9) print "y"}')_$(shell test -d $(TKFRAMEWORK) || echo n),y_n)
-		TKFRAMEWORK = /System/Library/Frameworks/Tk.framework/Resources/Wish.app
-                ifeq ($(shell test -d $(TKFRAMEWORK) || echo n),n)
-			TKFRAMEWORK = /System/Library/Frameworks/Tk.framework/Resources/Wish\ Shell.app
-                endif
-        endif
-	TKEXECUTABLE = $(TKFRAMEWORK)/Contents/MacOS/$(shell basename "$(TKFRAMEWORK)" .app)
-	TKEXECUTABLE_SQ = $(subst ','\'',$(TKEXECUTABLE))
-endif
-
 ifeq ($(findstring $(firstword -$(MAKEFLAGS)),s),s)
 QUIET_GEN =
 endif
@@ -129,16 +113,10 @@ libdir_SQ  = $(subst ','\'',$(gg_libdir))
 exedir     = $(dir $(gitexecdir))share/git-gui/lib
 
 GITGUI_RELATIVE :=
-GITGUI_MACOSXAPP :=
 
 ifeq ($(exedir),$(gg_libdir))
 	GITGUI_RELATIVE := 1
 endif
-ifeq ($(uname_S),Darwin)
-        ifeq ($(shell test -d $(TKFRAMEWORK) && echo y),y)
-		GITGUI_MACOSXAPP := YesPlease
-        endif
-endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
 	NO_MSGFMT=1
@@ -147,20 +125,6 @@ endif
 	GITGUI_RELATIVE := 1
 endif
 
-ifdef GITGUI_MACOSXAPP
-GITGUI_MAIN := git-gui.tcl
-
-git-gui: generate-macos-wrapper.sh GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS
-	$(QUIET_GEN)$(SHELL_PATH) generate-macos-wrapper.sh "$@" ./GIT-GUI-BUILD-OPTIONS ./GIT-VERSION-FILE
-
-Git\ Gui.app: GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS \
-		macosx/Info.plist \
-		macosx/git-gui.icns \
-		macosx/AppMain.tcl \
-		$(TKEXECUTABLE)
-	$(QUIET_GEN)$(SHELL_PATH) generate-macos-app.sh . "$@" ./GIT-GUI-BUILD-OPTIONS ./GIT-VERSION-FILE
-endif
-
 ifdef GITGUI_WINDOWS_WRAPPER
 GITGUI_MAIN := git-gui.tcl
 
@@ -205,14 +169,10 @@ GIT-GUI-BUILD-OPTIONS: FORCE
 		-e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
 		-e 's|@TCLTK_PATH@|$(TCLTK_PATH_SQ)|' \
 		-e 's|@TCL_PATH@|$(TCL_PATH_SQ)|' \
-		-e 's|@TKEXECUTABLE@|$(TKEXECUTABLE_SQ)|' \
 		$@.in >$@+
 	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 
-ifdef GITGUI_MACOSXAPP
-all:: git-gui Git\ Gui.app
-endif
 ifdef GITGUI_WINDOWS_WRAPPER
 all:: git-gui
 endif
@@ -228,10 +188,6 @@ ifdef GITGUI_WINDOWS_WRAPPER
 endif
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(libdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_R0)lib/tclIndex $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)'
-ifdef GITGUI_MACOSXAPP
-	$(QUIET)$(INSTALL_A0)'Git Gui.app' $(INSTALL_A1) '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(QUIET)$(INSTALL_X0)git-gui.tcl $(INSTALL_X1) '$(DESTDIR_SQ)$(libdir_SQ)'
-endif
 	$(QUIET)$(foreach p,$(ALL_LIBFILES) $(NONTCL_LIBFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)' &&) true
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(msgsdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(foreach p,$(ALL_MSGFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
@@ -246,10 +202,6 @@ ifdef GITGUI_WINDOWS_WRAPPER
 endif
 	$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(libdir_SQ)'
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(libdir_SQ)'/tclIndex $(REMOVE_F1)
-ifdef GITGUI_MACOSXAPP
-	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(libdir_SQ)/Git Gui.app' $(REMOVE_F1)
-	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(libdir_SQ)'/git-gui.tcl $(REMOVE_F1)
-endif
 	$(QUIET)$(foreach p,$(ALL_LIBFILES) $(NONTCL_LIBFILES), $(REMOVE_F0)'$(DESTDIR_SQ)$(libdir_SQ)'/$(notdir $p) $(REMOVE_F1) &&) true
 	$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(msgsdir_SQ)'
 	$(QUIET)$(foreach p,$(ALL_MSGFILES), $(REMOVE_F0)'$(DESTDIR_SQ)$(msgsdir_SQ)'/$(notdir $p) $(REMOVE_F1) &&) true
@@ -265,9 +217,6 @@ dist-version: GIT-VERSION-FILE
 clean::
 	$(RM_RF) $(GITGUI_MAIN) lib/tclIndex po/*.msg $(PO_TEMPLATE)
 	$(RM_RF) GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS
-ifdef GITGUI_MACOSXAPP
-	$(RM_RF) 'Git Gui.app'* git-gui
-endif
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(RM_RF) git-gui
 endif
diff --git a/generate-macos-app.sh b/generate-macos-app.sh
deleted file mode 100755
index 71b9fa6..0000000
--- a/generate-macos-app.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh
-
-set -e
-
-SOURCE_DIR="$1"
-OUTPUT="$2"
-BUILD_OPTIONS="$3"
-VERSION_FILE="$4"
-
-. "$BUILD_OPTIONS"
-. "$VERSION_FILE"
-
-rm -rf "$OUTPUT" "$OUTPUT+"
-
-mkdir -p "$OUTPUT+/Contents/MacOS"
-mkdir -p "$OUTPUT+/Contents/Resources/Scripts"
-
-cp "$TKEXECUTABLE" "$OUTPUT+/Contents/MacOS"
-cp "$SOURCE_DIR/macosx/git-gui.icns" "$OUTPUT+/Contents/Resources"
-sed \
-	-e "s/@@GITGUI_VERSION@@/$GITGUI_VERSION/g" \
-	-e "s/@@GITGUI_TKEXECUTABLE@@/$(basename "$TKEXECUTABLE")/g" \
-	"$SOURCE_DIR/macosx/Info.plist" \
-	>"$OUTPUT+/Contents/Info.plist"
-sed \
-	-e "s|@@gitexecdir@@|$GITGUI_GITEXECDIR|" \
-	-e "s|@@GITGUI_LIBDIR@@|$GITGUI_LIBDIR|" \
-	"$SOURCE_DIR/macosx/AppMain.tcl" \
-	>"$OUTPUT+/Contents/Resources/Scripts/AppMain.tcl"
-mv "$OUTPUT+" "$OUTPUT"
diff --git a/generate-macos-wrapper.sh b/generate-macos-wrapper.sh
deleted file mode 100755
index 0304937..0000000
--- a/generate-macos-wrapper.sh
+++ /dev/null
@@ -1,35 +0,0 @@
-#!/bin/sh
-
-set -e
-
-if test "$#" -ne 3
-then
-	echo >&2 "usage: $0 <OUTPUT> <BUILD_OPTIONS> <VERSION_FILE>"
-	exit 1
-fi
-
-OUTPUT="$1"
-BUILD_OPTIONS="$2"
-VERSION_FILE="$3"
-
-. "$BUILD_OPTIONS"
-
-rm -f "$OUTPUT" "$OUTPUT+"
-
-(
-	echo "#!$SHELL_PATH"
-	cat "$BUILD_OPTIONS" "$VERSION_FILE"
-	cat <<-'EOF'
-	if test "z$*" = zversion ||
-	   test "z$*" = z--version
-	then
-		echo "git-gui version $GITGUI_VERSION"
-	else
-		libdir="${GIT_GUI_LIB_DIR:-$GITGUI_LIBDIR}"
-		exec "$libdir/Git Gui.app/Contents/MacOS/$(basename "$TKEXECUTABLE")" "$0" "$@"
-	fi
-	EOF
-) >"$OUTPUT+"
-
-chmod +x "$OUTPUT+"
-mv "$OUTPUT+" "$OUTPUT"
diff --git a/macosx/AppMain.tcl b/macosx/AppMain.tcl
deleted file mode 100644
index b6c6dc3..0000000
--- a/macosx/AppMain.tcl
+++ /dev/null
@@ -1,29 +0,0 @@
-set gitexecdir {@@gitexecdir@@}
-if { [info exists ::env(GIT_GUI_LIB_DIR) ] } {
-	set gitguilib $::env(GIT_GUI_LIB_DIR)
-} else {
-	set gitguilib {@@GITGUI_LIBDIR@@}
-}
-
-set env(PATH) "$gitexecdir:$env(PATH)"
-
-if {[string first -psn [lindex $argv 0]] == 0} {
-	lset argv 0 [file join $gitexecdir git-gui]
-}
-
-if {[file tail [lindex $argv 0]] eq {gitk}} {
-	set argv0 [lindex $argv 0]
-	set AppMain_source $argv0
-} else {
-	set argv0 [file join $gitexecdir [file tail [lindex $argv 0]]]
-	set AppMain_source [file join $gitguilib git-gui.tcl]
-	if {[info exists env(PWD)]} {
-		cd $env(PWD)
-	} elseif {[pwd] eq {/}} {
-		cd $env(HOME)
-	}
-}
-
-unset gitexecdir gitguilib
-set argv [lrange $argv 1 end]
-source $AppMain_source
diff --git a/macosx/Info.plist b/macosx/Info.plist
deleted file mode 100644
index 1ade121..0000000
--- a/macosx/Info.plist
+++ /dev/null
@@ -1,30 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
-<plist version="1.0">
-<dict>
-	<key>CFBundleDevelopmentRegion</key>
-	<string>English</string>
-	<key>CFBundleExecutable</key>
-	<string>@@GITGUI_TKEXECUTABLE@@</string>
-	<key>CFBundleGetInfoString</key>
-	<string>Git Gui @@GITGUI_VERSION@@ © 2006-2007 Shawn Pearce, et. al.</string>
-	<key>CFBundleIconFile</key>
-	<string>git-gui.icns</string>
-	<key>CFBundleIdentifier</key>
-	<string>cz.or.repo.git-gui</string>
-	<key>CFBundleInfoDictionaryVersion</key>
-	<string>6.0</string>
-	<key>CFBundleName</key>
-	<string>Git Gui</string>
-	<key>CFBundlePackageType</key>
-	<string>APPL</string>
-	<key>CFBundleShortVersionString</key>
-	<string>@@GITGUI_VERSION@@</string>
-	<key>CFBundleSignature</key>
-	<string>GITg</string>
-	<key>CFBundleVersion</key>
-	<string>@@GITGUI_VERSION@@</string>
-	<key>NSHighResolutionCapable</key>
-	<true/>
-</dict>
-</plist>
diff --git a/macosx/git-gui.icns b/macosx/git-gui.icns
deleted file mode 100644
index 77d88a77a7669667335cf6fd5767c8b40f3ce6e7..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 28866
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

diff --git a/meson.build b/meson.build
index cdae85e..1cedc82 100644
--- a/meson.build
+++ b/meson.build
@@ -19,17 +19,6 @@ build_options_config.set_quoted('GITGUI_LIBDIR', get_option('prefix') / get_opti
 build_options_config.set_quoted('SHELL_PATH', fs.as_posix(shell.full_path()))
 build_options_config.set_quoted('TCLTK_PATH', fs.as_posix(wish.full_path()))
 build_options_config.set_quoted('TCL_PATH', fs.as_posix(tclsh.full_path()))
-if target_machine.system() == 'darwin'
-  tkexecutables = [
-    '/Library/Frameworks/Tk.framework/Resources/Wish.app/Contents/MacOS/Wish',
-    '/System/Library/Frameworks/Tk.framework/Resources/Wish.app/Contents/MacOS/Wish',
-    '/System/Library/Frameworks/Tk.framework/Resources/Wish Shell.app/Contents/MacOS/Wish Shell',
-  ]
-  tkexecutable = find_program(tkexecutables)
-  build_options_config.set_quoted('TKEXECUTABLE', tkexecutable.full_path())
-else
-  build_options_config.set('TKEXECUTABLE', '')
-endif
 
 build_options = configure_file(
   input: 'GIT-GUI-BUILD-OPTIONS.in',
@@ -70,52 +59,6 @@ if target_machine.system() == 'windows'
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
-elif target_machine.system() == 'darwin'
-  gitgui_main = 'git-gui.tcl'
-  gitgui_main_install_dir = get_option('datadir') / 'git-gui/lib'
-
-  custom_target(
-    output: 'git-gui',
-    command: [
-      shell,
-      meson.current_source_dir() / 'generate-macos-wrapper.sh',
-      '@OUTPUT@',
-      meson.current_build_dir() / 'GIT-GUI-BUILD-OPTIONS',
-      meson.current_build_dir() / 'GIT-VERSION-FILE',
-    ],
-    depends: [
-      version_file,
-    ],
-    depend_files: [
-      build_options,
-    ],
-    install: true,
-    install_dir: get_option('libexecdir') / 'git-core',
-  )
-
-  custom_target(
-    output: 'Git Gui.app',
-    command: [
-      shell,
-      meson.current_source_dir() / 'generate-macos-app.sh',
-      meson.current_source_dir(),
-      meson.current_build_dir() / 'Git Gui.app',
-      meson.current_build_dir() / 'GIT-GUI-BUILD-OPTIONS',
-      meson.current_build_dir() / 'GIT-VERSION-FILE',
-    ],
-    depends: [
-      version_file,
-    ],
-    depend_files: [
-      build_options,
-      'macosx/AppMain.tcl',
-      'macosx/Info.plist',
-      'macosx/git-gui.icns',
-    ],
-    build_by_default: true,
-    install: true,
-    install_dir: get_option('datadir') / 'git-gui/lib',
-  )
 endif
 
 custom_target(
-- 
2.50.1.475.g795bb014d8

