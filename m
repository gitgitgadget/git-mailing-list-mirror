Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75A1B4244
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371537; cv=none; b=KPUosfdxs69nAPlWCewxVNetqhVlMfr9lgGhIgvWpNnoqOXSldmZe1zzIkivTogjQXH4j866MuSsC7e5XRwZkQ42I4mqFPCJCqrlGOQREAtvi06DVYaaF2qkKhmAw0ryNePBIStqOB9i4u4lmczx+a401rqEZZNyd1mDJ2o1vRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371537; c=relaxed/simple;
	bh=QKwPTJXlCdBwg3md7y0/BsR0sqxR8PlDcSgQxj56ZY8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uJTs67UXZ0b0DYqXtCSmOPL3QRbWe05QBNoAJa+trbSVXgQP1C6GerLqOyLkpDTOCxUSCec17YHHYXYXgKMKGq9yJoeIWQRx8puXMvHHgKc/C9V8rzMkNA2liEB2wjOUTqrFy+gPg/3Rv5nuCSp452hT0YvMLVfDW8+M0HvklQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jez4SoIX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jez4SoIX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so3655575e9.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756371533; x=1756976333; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF5/7rbOphHBjxMe4KKbP1aQ5+EpBXiFJlh0q1v6pg8=;
        b=Jez4SoIXqC0Cn/bf/5CP2D3CLcT4gDH6zl4775VeKqNBZy9/6fWbK7kH0XaJbNmkB9
         /qFUwN7WJr7NiypZTOmRZAVPVD0xW6XEBDnzHP0cryYaMaJQ8Ci3xKHB+8CB/3bEbMvL
         1rzCf/WZqGPVNkWZm1wAfm0/b3rhwF6viRv4IrJIstEnyACmoGphMcVnYropVmdCwTjT
         qEIlmQnwAzpRqqANDTCKDNB7Vm8eAdhyAY/iUGTHR9KnKBKLXh9tCbdNZfTYxMAOK1qb
         Z6WXckNr2jgD9y+G3PoWAScQv4ijSvLGuXFqtpGveG/72VzSEKN9qA6ERfjtBj7hA9En
         hdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371533; x=1756976333;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF5/7rbOphHBjxMe4KKbP1aQ5+EpBXiFJlh0q1v6pg8=;
        b=bDqvZNv8GTr0fZ6hQ9VouPYmQvHnUeBHWRBWQsP618kFEVRJMIN1w4x8keQDbh/Jwm
         Upw1ap7wdStr6ZtzSMTS51kiwP6JdyuiZ+CPyaTqhhJXWw0KjRrazbfVhAnuHXdyrS62
         nF3ZVnSXaHqL4CR8yNdxOoz4c8gtYjUinPAsd0jYcmoOrCdtW0edKU/m+3+usUvAI7d/
         B6JtC8hmrNRk7LZwwAfXJfn4tCsh5clOv3SjrRyPfZqrroxELlx4Fa0CR3xBnJMnC3Bh
         WZ74gXcgClJkilSz01L0AMEHVr04f8gYyn1gzKj1mCOo3TE9D0Z0x0ngEMReOwMKSPZ/
         f8JQ==
X-Gm-Message-State: AOJu0YwTA1D16bmdSLGs6LfNZ7YyukywPukuIZbuXpuhIHhgTI+hsIQ6
	leCyDTdWayPFqVMup5IfWqrgHUrpROhjeiqRPrA8mqzt3+8M/YOMYchlnTSLRg==
X-Gm-Gg: ASbGnct0t+CW+B/Ndxbve1Janop2RoAN3hGzy1MU5hKeZhYyfCi7pRqhOB1hnBsRF2l
	f5ugbqFXSndw9R4E9DNky8BuULgEviJAb+HWBsLSHlNLZKRLwV3zUI6s0jjMhgGVgXqGc+FvFG5
	FeqB386p3W9Fvmg5ItbpvphRTiinb2DNY1RgWuKgt6yo7HYhZfT4sMGmKdOxYUTPZ4r5FNdvxjU
	7xINoy5dONhAMmcxwvkTRTWSOK7+2VcMPg2EgwfemR4tWEb1IJB3I7pC4d7G4TaSeH3uEhyg2Su
	qSEQcWfwEz7h2LMQ+FZBIjtxgjb4IlNnqjdP6fCLe0HH6C8/8IfE4U1UnbONBNXsJ+RXQABLuVO
	ITbwIFRhoM6W7/mpLbDqJKQBdXRWkYEBJG0S7VX5Kl2pa1Cev
X-Google-Smtp-Source: AGHT+IHXsCGv6ma6zvcVjuW+ZQwcI5c7u+vEanGQCwh8pkdaHN5hXVHaG3JtEbUkSkvERO4u7pP3Jg==
X-Received: by 2002:a05:600c:35cc:b0:45b:47e1:ef77 with SMTP id 5b1f17b1804b1-45b517ddc6amr148958645e9.34.1756371532955;
        Thu, 28 Aug 2025 01:58:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cd935931ebsm3284770f8f.55.2025.08.28.01.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:58:52 -0700 (PDT)
Message-Id: <08b106ebedb90c0e25b0d6802bf5aa81cc9f2da0.1756371530.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
	<pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
From: "Heiko Voigt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 08:58:47 +0000
Subject: [PATCH v2 1/4] git-gui: provide question helper for retry fallback on
 Windows
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Pratyush Yadav <me@yadavpratyush.com>,
    Heiko Voigt <hvoigt@hvoigt.net>

From: Heiko Voigt <hvoigt@hvoigt.net>

Make use of the new environment variable GIT_ASK_YESNO to support the
recently implemented fallback in case unlink, rename or rmdir fail for
files in use on Windows. The added dialog will present a yes/no question
to the the user which will currently be used by the windows compat layer
to let the user retry a failed file operation.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile          |  2 ++
 git-gui--askyesno | 42 ++++++++++++++++++++++++++++++++++++++++++
 git-gui.sh        |  3 +++
 3 files changed, 47 insertions(+)
 create mode 100755 git-gui--askyesno

diff --git a/Makefile b/Makefile
index 2cd160b05755..6385db443929 100644
--- a/Makefile
+++ b/Makefile
@@ -185,6 +185,7 @@ install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(INSTALL_X0)git-gui--askpass $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(INSTALL_X0)git-gui--askyesno $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(QUIET)$(INSTALL_R0)git-gui.tcl $(INSTALL_R1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
@@ -199,6 +200,7 @@ uninstall:
 	$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui $(REMOVE_F1)
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui--askpass $(REMOVE_F1)
+	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui--askyesno $(REMOVE_F1)
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/$p $(REMOVE_F1) &&) true
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui.tcl $(REMOVE_F1)
diff --git a/git-gui--askyesno b/git-gui--askyesno
new file mode 100755
index 000000000000..f7312c70c2ca
--- /dev/null
+++ b/git-gui--askyesno
@@ -0,0 +1,42 @@
+#!/bin/sh
+# Tcl ignores the next line -*- tcl -*- \
+exec wish "$0" -- "$@"
+
+# This is an implementation of a simple yes no dialog
+# which is injected into the git commandline by git gui
+# in case a yesno question needs to be answered.
+
+set NS {}
+set use_ttk [package vsatisfies [package provide Tk] 8.5]
+if {$use_ttk} {
+	set NS ttk
+}
+
+if {$argc < 1} {
+	puts stderr "Usage: $argv0 <question>"
+	exit 1
+} else {
+	set prompt [join $argv " "]
+}
+
+${NS}::frame .t
+${NS}::label .t.m -text $prompt -justify center -width 40
+.t.m configure -wraplength 400
+pack .t.m -side top -fill x -padx 20 -pady 20 -expand 1
+pack .t -side top -fill x -ipadx 20 -ipady 20 -expand 1
+
+${NS}::frame .b
+${NS}::frame .b.left -width 200
+${NS}::button .b.yes -text Yes -command {exit 0}
+${NS}::button .b.no  -text No  -command {exit 1}
+
+pack .b.left -side left -expand 1 -fill x
+pack .b.yes -side left -expand 1
+pack .b.no -side right -expand 1 -ipadx 5
+pack .b -side bottom -fill x -ipadx 20 -ipady 15
+
+bind . <Key-Return> {exit 0}
+bind . <Key-Escape> {exit 1}
+
+wm title . "Question?"
+tk::PlaceWindow .
diff --git a/git-gui.sh b/git-gui.sh
index a931d7f7c990..1a4b73a3373a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1130,6 +1130,9 @@ set argv0dir [file dirname [file normalize $::argv0]]
 if {![info exists env(SSH_ASKPASS)]} {
 	set env(SSH_ASKPASS) [file join $argv0dir git-gui--askpass]
 }
+if {![info exists env(GIT_ASK_YESNO)]} {
+	set env(GIT_ASK_YESNO) [file join $argv0dir git-gui--askyesno]
+}
 unset argv0dir
 
 ######################################################################
-- 
gitgitgadget

