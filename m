Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0551A83ED
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067690; cv=none; b=axUek/zniNoD+6FWZjOSgAbVxKrwLm7MXr6EYfzAUJb6glfcRr932R0bAdSC+mvtL9gP3ituDFvHAH1sN3de5INJ6Mp1CVoV0GjTmd1QWBzOE8/WekdY2XJJtWy77yTYVE1uGylhOdU6mi0DCLVtRPETQyZ5MuWqpsqJqtUhWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067690; c=relaxed/simple;
	bh=qnYMqrQB65BM7EbRQV73bs4dJL6YRmsxMtxXmGBVbu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srQ7OjFANZM6IkmPp1U9+kLN/up6eY9Jenp7+wJVU/qDWTnYY1AXA/+Z2Pqx4yxH22hLimVEfi/U8QSqrTuWXmy6CBbalSBMAHo8XuCXtbM/QYgDfjdiEsa1zFGoICJOP8Keu3L5fhEEKAYp4VR6KhqusB0JLObm+xRdvNDAsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S95ukp62; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S95ukp62"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-85780d76b48so397190185a.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759067686; x=1759672486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQZnEbEekfxK6STvmPIcxAeSH1fjUFLzKlAoNt+ap5I=;
        b=S95ukp62AZ8WObrVrIXLdUxxVrLzLPKiq4CCv+SSaLSdC9u4MDGAvnplBOSvsvi77V
         /35GJDZxYhk7UlJCma1fEHfhHvEJu6MjDOV0VcnNOBc8oPtxH9fqkl2BGpnuZiokzs68
         s46nu6r5E/Vto9Ym91vmIw13eTTty28tTfV7psoHRvpPqPvOGuZYpmFCisOShXxheJKa
         bPX4Y9wsSeAeLXFJ5Tt7hkxiFFdIRaMboB3wldI/1gcmI+m+CpjgqSZnkfdcdYRx28nm
         LaQGLhbzOoWIcbd83dhrm7A+KptJwympO1MNu1Mdzz0C7EvkxZX4L367e7kIEcHxTPMp
         SiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759067686; x=1759672486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQZnEbEekfxK6STvmPIcxAeSH1fjUFLzKlAoNt+ap5I=;
        b=nSEWLHfNiwgxDBJ4Tw6AQuaq/EqhNwgCT+T+Da+KLJUBEsD+V3T4EyOvsKkFAHOjWs
         F/FGcMFZWYEqcngPZM4m+jfMZXa+easTTwK3jBd6mYAlEDqqkn21tn50tNPsWqfBWyAD
         Jt3wAtqCDvv7+TcT7Og3OlIAmk5+O2aeSkoCrepXlUaN6xC4RB3r7mlLH7rOzGb95cPK
         ecf6Av/rIkboLZ0SAc6XJrFRw2feHPAO+5voJWFhZaGhqPWVCEq4ZiYgBDBEt5NPmCoX
         51JgYuL4B855/TS2Xra8Qe8dUc8Aj97FP7qOkp4OchhAUoT8gnBYLDTI23ukAeStWbu2
         KpIA==
X-Gm-Message-State: AOJu0YxRJhxtsiFqGireYEQKxLgacnuAUdLH1ywIjRG5GcAs1pCPqUYk
	frT1NH3OFse1PkCq8e8Cn38bqcV0lRxXwzhKOwZdQKuwD4W3S6fTIymUKYDHY4eL
X-Gm-Gg: ASbGncue4xnJrp+j5H1N4aWUclfQ8nj/8ZX7MWzw8o4X8YctdAMxaeFu0ZNoqEpMhO9
	1o+MpDVvnaWGT0DaQLQSVQGzH6nrQh8IRBmYZrMaAX70X2TNjqo+bIPZc8XARPgoapMxLQG9kj0
	u5QZtG2Van56ZKcesNLpyBEDXYWVpWN4CTxagD7BeUIiexyFdTs12KNxURpyYHeCh1zZz+LYE0X
	TDQ9VsC1isTc8nwtuioqdkoWrAaHn7B2zbH5cGlUS9FQ3zBwzbiRuN48pfZRuBUJAiWsu+ADMhr
	6b96OJTJnoq/LlUshdAffXLmSyBYB6cbOF7ziuadvfkayzlGH7YiAqor1y1kPokOEljvoLMCXqI
	0JKr8a5aANnr2FrQeXOAeFa1sVrqu3ad9XuL3WkXkhhphbbCb18JUq2D/qG8F4l2X45zHTfyv55
	7Ez6e+nGlRsHQakNpSwD60mX5o/ZBQdA==
X-Google-Smtp-Source: AGHT+IFKj/3bO7MOLPP7pQsFZPSodNpBpzqO4jHdlafA3OtTbDeWbRRGJztBw5ivsDLQ0tECVycBrg==
X-Received: by 2002:a05:620a:2a01:b0:84e:3c02:810e with SMTP id af79cd13be357-85ae033cbe4mr1716195985a.19.1759067685804;
        Sun, 28 Sep 2025 06:54:45 -0700 (PDT)
Received: from USROMMRAPPAZZ01.rappazzo.network (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c307ad101sm590426985a.36.2025.09.28.06.54.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 06:54:45 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 2/2] gitk: make Tags and Heads window geometry sticky
Date: Sun, 28 Sep 2025 09:54:35 -0400
Message-ID: <20250928135435.59623-3-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928135435.59623-1-rappazzo@gmail.com>
References: <20250928135435.59623-1-rappazzo@gmail.com>
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
 gitk | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 275f353811..79a6dcdb4c 100755
--- a/gitk
+++ b/gitk
@@ -3106,6 +3106,11 @@ proc savestuff {w} {
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
@@ -10199,11 +10204,13 @@ proc showrefs {} {
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
@@ -10229,8 +10236,8 @@ proc showrefs {} {
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
@@ -10239,6 +10246,9 @@ proc showrefs {} {
     bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
     set reflist {}
     refill_reflist
+    # Restore geometry after the window is fully created and mapped
+    # Delay Configure binding to avoid overwriting restored geometry
+    bind $top <Map> [list after idle [list setup_showrefs_geometry_tracking $top]]
 }
 
 proc sel_reflist {w x y} {
@@ -10271,6 +10281,31 @@ proc reflistfilter_change {n1 n2 op} {
     after 200 refill_reflist
 }
 
+proc save_showrefs_geometry {top} {
+    global geometry
+    if {[winfo exists $top]} {
+        set geometry(showrefs) [wm geometry $top]
+    }
+}
+
+proc restore_showrefs_geometry {top} {
+    global geometry
+    if {[info exists geometry(showrefs)] && [winfo exists $top]} {
+        wm geometry $top $geometry(showrefs)
+    }
+}
+
+proc setup_showrefs_geometry_tracking {top} {
+    restore_showrefs_geometry $top
+    bind $top <Configure> [list save_showrefs_geometry $top]
+}
+
+proc destroy_showrefs {top} {
+    save_showrefs_geometry $top
+    savestuff .
+    destroy $top
+}
+
 proc refill_reflist {} {
     global reflist reflistfilter showrefstop headids tagids otherrefids sortrefsbytype
     global curview upstreamofref
-- 
2.51.0

