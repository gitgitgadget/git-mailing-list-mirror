Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E1313281
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758393642; cv=none; b=gNNSOO212tFf9Tr7QBlg12rHMCTn3xPy7Os64VpSBvFqIwXXrLWWQ+5fOCuoMCMirvYkY55rV11puN45u01lcW8VsTTc26Yt4PLAp6pSafSICXtBidrZZ9SAsGTYVynH4LTG/XwVBznS2KbogNrD8oSRWmzsCLjJ5mA7DVxoM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758393642; c=relaxed/simple;
	bh=2iDkQftGxHAY0NWWvQbXjrfqYlZ0WEBZyKWNLQhyL5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZSI7omY7kztDMBu81zKQEpdeqUD6YIQAAt7JO2EKJeebFJLcfSUPbzVoLEKrYac/+0kzYCS0C0gMC0dp1UoMMCV8US5IUFfz5naGevWAXcyjYG0N4A3Ysg6mYb02gbk6ub+iZNDiK0XeDH7jmpfOfVPFC7ajT/Lbjaauoq4/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7AefFUV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7AefFUV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d5fb5e34cso31137427b3.0
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758393639; x=1758998439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYaHYCeR0FFwV/GA/s+VzOXohyHaUgGoCmiYTb9Bms4=;
        b=K7AefFUVo4cjJlVs1PzWHb2dNhUS875p7txjFzozobjiAYFfMIgF3EjzQNxOflOJu7
         3fc25DN3T2rq1QY9KOsaStDyq3vink5yWB8jU+hCiHmLRStNQLByAed5yLVFtnjq6YW+
         gLjRhCFZRzmRuhXCMcKSczcwqduD958013JRvEwVDl6AjneMUScP0/XO4y38u1Zl4pK9
         9p0AGklCu7Dsnz6O7klohfZPwjriAHP4brH6ZbkuFZ6UoLnJZP89BGLfNV0x9feAPRnK
         Gj9uZ1tDj0Xkgz9X2+OLJgAWiZZhq0fQhmw+GNrs5t0cQq5rBBNccHBxCRNm2kZQTRKJ
         /k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758393639; x=1758998439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYaHYCeR0FFwV/GA/s+VzOXohyHaUgGoCmiYTb9Bms4=;
        b=ncr1Cgk26Sfz753rTu5OHKM+fTry1h9wgI5dZTKf1qZrNvh7daiAtwIYu3EdOjbA7g
         FkGKL9nP1bInh0Q/x1qhs+bkv8SV2tctU1mqbAqMf+Y0PNBTHzXUU8SVkn0E4s8bApxn
         S5RAefRFRrGKM/uU5z/J7Dh9JjKCw9br7GerRwYP2FLSLi5Q0zqqpVKXnUwaSHmNSAHK
         M5MtcXX9d+EnAeC4984elx3SphpHjThpOZjPWAHONOFNe5XXnmoeGyk8sYb4IuIG5dFh
         OAQRYM6S8zX+Pca+LdEm+GoJ1Sh0WVIv/EGKXFKOP/5oAN1Mf+hssEft0IwGt/9OdafP
         DbOg==
X-Gm-Message-State: AOJu0Yw9pcbfBvLgIWkbGzoBB4ukZYODRDw0mDWTIk3yXZ1hG1DI4zkE
	g/lsaKlU25Pca9U4RSQnCkXYZ8kygfUQ19h0pYyZbV4BDNefULdmQdD+mPn0UCQZ
X-Gm-Gg: ASbGncvg4EbsU1ZnUGJaj+bXrw8YNk1jn4FGEDeCL/G+UlhrmDioxxL4LeI6rGUAGCV
	eYQRLT26FIoYnbff9zfR0etHkdMVVjRrP2yUZh/j8PJfsv5a/0XJl0JLexNjobl169YcNe//N/x
	a8r0zEY0wXUkPAGJ9zj59wvKzhl1qSkjFt3ZbHGJd4zTUYk020AemHABLYvzOfmBtJPgHfe2SjL
	mJ/ncL/BCAz+329MaDRw/QFORwvYv1CCbIrj80YJvKutDjRkMFbWpHbYaNiQjkYabpsIcoo62af
	VEjRI14DvhnbO5r+bcgOtoTUByKqfGaC6/Gn4BxmR08yNvxZ0OlVDDuF/UjAiekEFdYsYaMe0Pf
	OrPgD5TuchBC3JMfNRn3+qz1XoOq2otTvJeojD1c3SHfXu7aqVq3dyEqngiS5GDjfzSB2wphxuW
	NI96bQqoJxPaNIXrxyhlrC
X-Google-Smtp-Source: AGHT+IGEED6SbG7XzZaNv3ptpHvY39DEto96PDjpa6GWAK4Zz44L1ZiwL8J1aKZGnPNDZ9JhFnY9cw==
X-Received: by 2002:a05:690c:6302:b0:731:1bc7:782d with SMTP id 00721157ae682-73ccdc8d15bmr64949327b3.18.1758393639274;
        Sat, 20 Sep 2025 11:40:39 -0700 (PDT)
Received: from USROMMRAPPAZZ01.infor.com (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7397188c02asm22814067b3.49.2025.09.20.11.40.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Sep 2025 11:40:38 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 2/2] gitk: make Tags and Heads window geometry sticky
Date: Sat, 20 Sep 2025 14:40:07 -0400
Message-ID: <20250920184007.26183-3-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920184007.26183-1-rappazzo@gmail.com>
References: <20250920184007.26183-1-rappazzo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the Tags and Heads window always opens at a default position
and size, requiring users to reposition it each time. This patch makes
the window remember its geometry between sessions.

This change saves and restores the Tags and Heads window size and position
relative to the main gitk window. The geometry is stored in the config file
as `geometry(showrefs)` and persists between gitk sessions. The window
position is stored relative to the main window, so it maintains the same
spatial relationship when the main window is moved or when gitk is restarted
on different monitors.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 95469a8fae..0393241c85 100755
--- a/gitk
+++ b/gitk
@@ -3116,6 +3116,11 @@ proc savestuff {w} {
         puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
         puts $f "set geometry(botwidth) [winfo width .bleft]"
         puts $f "set geometry(botheight) [winfo height .bleft]"
+        if {[winfo exists .showrefs]} {
+            puts $f "set geometry(showrefs) \"[wm geometry .showrefs]\""
+        } elseif {[info exists geometry(showrefs)]} {
+            puts $f "set geometry(showrefs) \"$geometry(showrefs)\""
+        }
 
         array set view_save {}
         array set views {}
@@ -10209,11 +10214,13 @@ proc showrefs {} {
     if {[winfo exists $top]} {
         raise $top
         refill_reflist
+        wm protocol $top WM_DELETE_WINDOW [list destroy_showrefs $top]
         return
     }
     ttk_toplevel $top
     wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
     make_transient $top .
+    wm protocol $top WM_DELETE_WINDOW [list destroy_showrefs $top]
     text $top.list -background $bgcolor -foreground $fgcolor \
         -selectbackground $selectbgcolor -font mainfont \
         -xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
@@ -10239,8 +10246,8 @@ proc showrefs {} {
     ttk::checkbutton $top.sort -text [mc "Sort refs by type"] \
         -variable sortrefsbytype -command {refill_reflist}
     grid $top.sort - -sticky w -pady 2
-    ttk::button $top.close -command [list destroy $top] -text [mc "Close"]
-    bind $top <Key-Escape> [list destroy $top]
+    ttk::button $top.close -command [list destroy_showrefs $top] -text [mc "Close"]
+    bind $top <Key-Escape> [list destroy_showrefs $top]
     grid $top.close -
     grid columnconfigure $top 0 -weight 1
     grid rowconfigure $top 0 -weight 1
@@ -10249,6 +10256,8 @@ proc showrefs {} {
     bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
     set reflist {}
     refill_reflist
+    after idle [list manage_showrefs_geometry $top restore]
+    bind $top <Configure> [list manage_showrefs_geometry $top save]
 }
 
 proc sel_reflist {w x y} {
@@ -10281,6 +10290,28 @@ proc reflistfilter_change {n1 n2 op} {
     after 200 refill_reflist
 }
 
+proc manage_showrefs_geometry {top action} {
+    global geometry
+    switch $action {
+        save {
+            if {[winfo exists $top]} {
+                set geometry(showrefs) [wm geometry $top]
+            }
+        }
+        restore {
+            if {[info exists geometry(showrefs)] && [winfo exists $top]} {
+                after 1 [list wm geometry $top $geometry(showrefs)]
+            }
+        }
+    }
+}
+
+proc destroy_showrefs {top} {
+    manage_showrefs_geometry $top save
+    savestuff .
+    destroy $top
+}
+
 proc refill_reflist {} {
     global reflist reflistfilter showrefstop headids tagids otherrefids sortrefsbytype
     global curview upstreamofref
-- 
2.51.0

