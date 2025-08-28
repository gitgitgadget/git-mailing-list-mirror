Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BC3128B0
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388022; cv=none; b=WB5fAeO8tf+PpZBkd4kUOYcZQhXiJu3RsPiQB9kcVUstcRK8fRb/uVaM4SnqYMQQqskB2PN9YWceDGL+96+MjtRxjLDOb8zYBgsUt7j2Jz7uuZi8hWLKRJUORw7S0QQivWRBt2Sno43ZCk5brB9ByUvzeBOBl8vEsD8RfwDYKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388022; c=relaxed/simple;
	bh=278xRccU1NuahYsQIDN/WXJdWOXnSH6mEBQDXvMS94w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flZAP56/qounNqbu6ejj/x+CGqU54ZDvwGK96vKyckcvzpONIRL/gPAaMlcyfbKhJSNlJIhjuXCnvlE3Fc+tAD7veaVo3+O3CipGwrpBp5reFgOtSTLrQmQw9E1K8NWdfG923qodL5lH7gYF2Xq8s1jOTHIGo5XDu+WIy1M2fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkRQmTZi; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkRQmTZi"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70bb007a821so12567806d6.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756388020; x=1756992820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZVM2noQkvmsMnnJ1gtUS+N9lHfKD4r8zMBIw5xAhJw=;
        b=RkRQmTZiix02dUxkt20Slm1JKDYN8y5YqSCFw6w02pWsUvrY/+iIjyJSOQf96BHdVZ
         iWOPLqCN8S0x6bL9EXm6fhNdi+g8fbCiyA0JnQ5Zavvum2qV4jXEl0HOQ5SI2jCB8eYa
         i9Hbb6D+zzSk8yahXaOFmUQnEOB99VAudEmAvSJUpKfM/nlxXaKalxHuC2pOl3j/yxRy
         aGIMD7Sn1YHDB6RKtiGtvDHH7lPk2CJSfuwKB97sf3dacC1MNYMGSAo8yRKUNY98O8It
         ySOk1yrzLjBToWFLBlAojoF6OYc9DUeiBJ1A0x1GOHPCLtzRAPUN+b6qdvdw6ux0GaCq
         ub7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388020; x=1756992820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZVM2noQkvmsMnnJ1gtUS+N9lHfKD4r8zMBIw5xAhJw=;
        b=REP1rVDA7VKLB+BSc+kMVRkzF86LZYKO9YT3UvfBmUqJLcFKZ6P/KOzGeyoVfImiji
         SfWRX+SbmgeXHek1CukNHWhy1jmwAjxLOIk0WuNatCvdu52ZJeHNK4+q2aFPazGRGzWx
         Ucw9W8T3OHjQ56LS3d8+i24A4UbisAWUPUJICI4w+uLLQw23mo8tTyzgRlxdsiwsNrMg
         SvMPwwhbG9W9NICijZ0FGhDjvh3SBtUSJA+L5FAw5EVDz+lKT50BqjTubBToXCJxuzbk
         +Q/m6szSAy2KTBNobQoMoysGt6CcawtPuaaOqD6PjnpXqBt0mWrezg6tX5Atu/ywW4kM
         f1Rg==
X-Gm-Message-State: AOJu0YwiacF+0L6ez99lFq1xFZlDNJpJ0zysKVqZk8ynrcXq2jMgBVmp
	9Nzfc9bQYM2M1AyztNO+KmPgxSGG3boA6k1HcBdbfkGAstWekHpjXLOh
X-Gm-Gg: ASbGncvSuYbIfzZ89MHd0MKda5Fk0wdRFj9Vqx39COli7tWq0YrSyHxQDx+I/Von7mV
	5qzx4kzgc+I7xaxmk4EJuczGo/wf2GzObCr67ND3Zsl8Olg4ZmlnzziqjpRYCV3VYMlEUQthVzr
	ZsM6dnMkRrICARc9kd4uYEPR1CKUgMNaj81DyaGu9NALR6W5Bh0AiOw9zGggINH0ub/oJvhvOpY
	IZoQbv/Zjh30yxoVEbGlOoWF+9lTT8CSVf/VBjr/Py21zP23tmOCj43iyMhPx1BsyXxYJl3ifB+
	td6Y2TrXqZRpEN8hD2Zkwp+F/b7GGHKGv1lwXNN55H05Dq2k4e2EQ+zaqmqnSXK13BVWikn/COG
	blWX01SXnnuQius15E39cviT0/ySgoHPwh7ag4wYgUNiatePViaOD+r/SQppIjaDHHNMXkk4UKI
	+8wbs=
X-Google-Smtp-Source: AGHT+IFIgBUjpyCf0xm3zvbc0JqHpeWiNC6c3t3kQZGnOF8FPePJJGSkExHaaJZL9jaVn7VPKz+qNQ==
X-Received: by 2002:ad4:5f4e:0:b0:70d:e88f:ec36 with SMTP id 6a1803df08f44-70de88ff242mr59612736d6.60.1756388017664;
        Thu, 28 Aug 2025 06:33:37 -0700 (PDT)
Received: from markl5i.lan (pool-173-73-185-17.washdc.fios.verizon.net. [173.73.185.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da7173220sm107271066d6.27.2025.08.28.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:33:37 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: johannes.schindelin@gmx.de
Cc: git@vger.kernel.org,
	j6t@kdbg.org,
	me@yadavpratyush.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-gui: use tk_messageBox for ask yes/no
Date: Thu, 28 Aug 2025 09:33:01 -0400
Message-ID: <20250828133301.74328-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.51.0.99.15
In-Reply-To: <4b04832c0b8119b784806f54a2354d910965a523.1756371530.git.gitgitgadget@gmail.com>
References: <4b04832c0b8119b784806f54a2354d910965a523.1756371530.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui includes git-gui--yesno that relies upon Tk 8.5 constructs, and
this dialog box is not supported with Tk 9.0.  Tk provides tk_messagebox
for this same purpose, fully supported in Tk 8.5+, so use tk_messagebox
instead.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui--askyesno | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/git-gui--askyesno b/git-gui--askyesno
index 142d1bc..cd986f2 100755
--- a/git-gui--askyesno
+++ b/git-gui--askyesno
@@ -10,12 +10,6 @@ exec wish "$0" -- "$@"
 # overridden via the optional `--title` command-line
 # option.
 
-set NS {}
-set use_ttk [package vsatisfies [package provide Tk] 8.5]
-if {$use_ttk} {
-	set NS ttk
-}
-
 set title "Question?"
 if {$argc < 1} {
 	puts stderr "Usage: $argv0 <question>"
@@ -28,25 +22,7 @@ if {$argc < 1} {
 	set prompt [join $argv " "]
 }
 
-${NS}::frame .t
-${NS}::label .t.m -text $prompt -justify center -width 40
-.t.m configure -wraplength 400
-pack .t.m -side top -fill x -padx 20 -pady 20 -expand 1
-pack .t -side top -fill x -ipadx 20 -ipady 20 -expand 1
-
-${NS}::frame .b
-${NS}::frame .b.left -width 200
-${NS}::button .b.yes -text Yes -command {exit 0}
-${NS}::button .b.no  -text No  -command {exit 1}
-
-pack .b.left -side left -expand 1 -fill x
-pack .b.yes -side left -expand 1
-pack .b.no -side right -expand 1 -ipadx 5
-pack .b -side bottom -fill x -ipadx 20 -ipady 15
-
-bind . <Key-Return> {exit 0}
-bind . <Key-Escape> {exit 1}
-
+set dlgicon {question}
 if {$::tcl_platform(platform) eq {windows}} {
 	set icopath [file dirname [file normalize $argv0]]
 	if {[file tail $icopath] eq {git-core}} {
@@ -55,9 +31,12 @@ if {$::tcl_platform(platform) eq {windows}} {
 	set icopath [file dirname $icopath]
 	set icopath [file join $icopath share git git-for-windows.ico]
 	if {[file exists $icopath]} {
-		wm iconbitmap . -default $icopath
+		set dlgicon $icopath
 	}
 }
 
-wm title . $title
-tk::PlaceWindow .
+wm withdraw .
+
+option add *Dialog.msg.font {Sans 10}
+set ans [tk_messageBox -icon $dlgicon -message $prompt -title $title -type yesno]
+exit [expr $ans eq {no}]
-- 
2.51.0.99.15

