Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191C154BFC
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767744; cv=none; b=NlPhlkDw1+XpIofj66gLFbJQLhYCP4jRqccu1rKbJrGraJYctXr9WeJCbJCfD6Om7eGRM/FjqUS7WV007RdfBmvkB0i6c/WsEQRmiFvCLqPde8OBCVBxjR0hqVS0WV7zyxENEafRnNbx9ldzQLApTF/DbtSXAdfoAtor7tmg3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767744; c=relaxed/simple;
	bh=68UhBKWfYkdhDfiIGVpkAHpXf28ooG/X/Q85D9wc5vw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wy6Iap9D018z/LYXuDecYObDxogxX8DXA9kjgwuajZUwzKu8xE3XPM0fdW94erGRlTEtlorsaqrZyIM4j+zBI/S2ydiiIzWhBnA1uTNJK5qLsC/cRAx8pAu37+C9yboOZTeNCC7AcNkaZt/MYhqo2OdQ3BWDSD62er1f20oDxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik8cO4q7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik8cO4q7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434fa6bf744so7381425e9.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 10:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733767741; x=1734372541; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfpc/mrtQw4tK0pEUm668R0cgD1hr+KGRPoFkyMTCAY=;
        b=ik8cO4q7BsBamFGwlPBBz4eImUZQ1v7PylyqQeg14MdnlELVvWa+VY2Omym4BLW3HA
         PwobWopEsh+IiYJZE/HkR4MI4qD634gTOvSwsOnj0T2a2NVMTxV6HtlJnN5TC5bJdL9w
         FNqiAcLlHsfgIJDyUXOJdg7ZnQn/WOt1eZ+o0GwgqVXn+CnQMVWb2vxuRKx7EqSVAQJg
         cjpHCCsOn/aTpCBohjWw6eLAPOwK4Va3k1a8gs7p+7hG58CO4mCTvHoG1SCIOoHDEJYb
         YIUPLt6CMqxzXoJyxmyN26hq3w9R3w1uU+Stqt1Zueqjzz6qkiZ7cLoPA/Xnr4jBYWBC
         w8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733767741; x=1734372541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfpc/mrtQw4tK0pEUm668R0cgD1hr+KGRPoFkyMTCAY=;
        b=viISAlc8+uak+bX4myoG/BdDivHD+4xT6PxHOmEENRBou6cDsjj60sqtshbFDSeKZa
         rgBTvRAA+vpRTXCnEqMsICkjYUJpTUZcUs4yv1XCG3G4u/UqmoGzQgdTKkLxvGgfLtS+
         T4NLYVFCydIR65ZfoLaMuZ16srcViGqXpQcGJuj4+a/Hm3wqTJVC63KfZ8n8EnVE3fR4
         ra05jN63XyAQ/IqyRse7LJFzZX5SKq3qqYO0Oim2fUOox1iSpafpSecfnCKGkvUpzP+u
         AaESz95y8eQnxTUwORkg6J9PW5hvhTVlZh6OgOuMhSK/xPJ4UrBNcGKQvvhL0IPDce5v
         KbXw==
X-Gm-Message-State: AOJu0Yw1DZ9wtq/q7BVEhHcU5ezm4NslP1u3uQ9Ic6He5IriVnGZ5Chd
	pdPqUe2ViiMnqQ4SYx8QTYiYHKxbWATfyJkcCn3X6aP/5EZcCjQnbAMGCA==
X-Gm-Gg: ASbGncvTsVudjc/44w7DfFwbwjCngOU+s4IzTXYmjAuy3HhxGDkTSohBhmosyQxm0vg
	TtyyeLIBQEkeZyZafEhDezk/gBNRYx68oNTOBA0Ml+MN9OVuwJrr3F2RR4QvRKNaC+IvXAw2xx4
	7BHRh7CO9tM423IFomZLyxjYGbyJLUBPXmvA+j03rchZ+x/eAu6XoqZ/b8N5br7wjGV6eK2FWOn
	conRG8P5VphtGMd05WZ4POFw4zga5yhnKpFCWwo97PMhFZlJtw=
X-Google-Smtp-Source: AGHT+IEgZpDq3VIsKx353ZgsoGMT1py4LNEU4B+x5o1ziyA70vdmNHeP8biyTYybC3R+Th9WQ39e9Q==
X-Received: by 2002:a05:600c:3484:b0:434:fa24:b84a with SMTP id 5b1f17b1804b1-434fffd03d5mr13374775e9.25.1733767740383;
        Mon, 09 Dec 2024 10:09:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f0d2c321sm81799045e9.12.2024.12.09.10.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:08:59 -0800 (PST)
Message-Id: <e116685568e4f1db3bc71985945f0ff4e40e12fc.1733767737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1835.git.1733767737.gitgitgadget@gmail.com>
References: <pull.1835.git.1733767737.gitgitgadget@gmail.com>
From: "Christoph Sommer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Dec 2024 18:08:57 +0000
Subject: [PATCH 2/2] gitk: add text wrapping preferences
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
Cc: Christoph Sommer <sommer@cms-labs.org>,
    Christoph Sommer <sommer@cms-labs.org>

From: Christoph Sommer <sommer@cms-labs.org>

Add a new preference "wrapdefault" which allows enabling char/word wrap.
Impacts all text in the ctext widget for which no other preference exists.

Also make the (existing) preference "wrapcomment" configurable graphically.
Its setting impacts only the "comment" part of the ctext widget.

Signed-off-by: Christoph Sommer <sommer@cms-labs.org>
---
 gitk-git/gitk | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d024e58d016..3bf9bc2edea 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2089,7 +2089,7 @@ proc makewindow {} {
     global diffcontextstring diffcontext
     global ignorespace
     global maincursor textcursor curtextcursor
-    global rowctxmenu fakerowmenu mergemax wrapcomment
+    global rowctxmenu fakerowmenu mergemax wrapcomment wrapdefault
     global highlight_files gdttype
     global searchstring sstring
     global bgcolor fgcolor bglist fglist diffcolors diffbgcolors selectbgcolor
@@ -2431,7 +2431,7 @@ proc makewindow {} {
     set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
         -state disabled -undo 0 -font textfont \
-        -yscrollcommand scrolltext -wrap none \
+        -yscrollcommand scrolltext -wrap $wrapdefault \
         -xscrollcommand ".bleft.bottom.sbhorizontal set"
     if {$have_tk85} {
         $ctext conf -tabstyle wordprocessor
@@ -11576,7 +11576,7 @@ proc create_prefs_page {w} {
 
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
-    global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
+    global tabstop wrapcomment wrapdefault limitdiffs autoselect autosellen extdifftool perfile_attrs
     global hideremotes want_ttk have_ttk maxrefs web_browser
 
     set page [create_prefs_page $notebook.general]
@@ -11607,6 +11607,17 @@ proc prefspage_general {notebook} {
     ${NS}::label $page.tabstopl -text [mc "Tab spacing"]
     spinbox $page.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
     grid x $page.tabstopl $page.tabstop -sticky w
+
+    ${NS}::label $page.wrapcommentl -text [mc "Wrap comment text"]
+    ${NS}::combobox $page.wrapcomment -values {none char word} -state readonly \
+        -textvariable wrapcomment
+    grid x $page.wrapcommentl $page.wrapcomment -sticky w
+
+    ${NS}::label $page.wrapdefaultl -text [mc "Wrap other text"]
+    ${NS}::combobox $page.wrapdefault -values {none char word} -state readonly \
+        -textvariable wrapdefault
+    grid x $page.wrapdefaultl $page.wrapdefault -sticky w
+
     ${NS}::checkbutton $page.ntag -text [mc "Display nearby tags/heads"] \
         -variable showneartags
     grid x $page.ntag -sticky w
@@ -11725,7 +11736,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes want_ttk have_ttk wrapcomment wrapdefault
 
     set top .gitkprefs
     set prefstop $top
@@ -11734,7 +11745,7 @@ proc doprefs {} {
         return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk wrapcomment wrapdefault} {
         set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
@@ -11860,7 +11871,7 @@ proc prefscan {} {
     global oldprefs prefstop
 
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk wrapcomment wrapdefault} {
         global $v
         set $v $oldprefs($v)
     }
@@ -11874,7 +11885,8 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
-    global hideremotes
+    global hideremotes wrapcomment wrapdefault
+    global ctext
 
     catch {destroy $prefstop}
     unset prefstop
@@ -11923,6 +11935,12 @@ proc prefsok {} {
     if {$hideremotes != $oldprefs(hideremotes)} {
         rereadrefs
     }
+    if {$wrapcomment != $oldprefs(wrapcomment)} {
+        $ctext tag conf comment -wrap $wrapcomment
+    }
+    if {$wrapdefault != $oldprefs(wrapdefault)} {
+        $ctext configure -wrap $wrapdefault
+    }
 }
 
 proc formatdate {d} {
@@ -12392,6 +12410,7 @@ set downarrowlen 5
 set mingaplen 100
 set cmitmode "patch"
 set wrapcomment "none"
+set wrapdefault "none"
 set showneartags 1
 set hideremotes 0
 set maxrefs 20
@@ -12497,7 +12516,7 @@ config_check_tmp_exists 50
 
 set config_variables {
     mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
-    cmitmode wrapcomment autoselect autosellen showneartags maxrefs visiblerefs
+    cmitmode wrapcomment wrapdefault autoselect autosellen showneartags maxrefs visiblerefs
     hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk
     bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors mergecolors
     markbgcolor diffcontext selectbgcolor foundbgcolor currentsearchhitbgcolor
-- 
gitgitgadget
