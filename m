Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159A18639
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667987; cv=none; b=ANg7AS7/sOR+D9gmwI/oaQBakmp2iec2H4TVIJ/y3+6SQ4ddzvMkNZ96womnR7892EB11h5QyS7SPBraSgXOYICPGZjOePQjQZBXt8iDIhn3bfcFEomnHa9aDpTjJn50HUxZt5Z4Aj5s8gwyMoFSJEaUV1fRyMwYbHmVo85m02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667987; c=relaxed/simple;
	bh=GNGb9gc1dZ0uKxpJKklVmWyr8OmTcZpla+3mrMPUPiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a4N6pMcA8uvPzaBnD1KnZQLu3snGzIDh8XLoDJI5G99qmrK2HKEzs3Zd20NsuUGErsLOzwrB9cbNqIxZycgEhyEA6RVIHYALBOuwTL3YLR5T+naFIfliwwCwXr77xL7AlQp0eSAKaZjUXf0H8cIutMPoSE2kKGMeMJFUtAgCp4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHLKPm0G; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHLKPm0G"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e1878e357so59082f8f.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 11:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709667984; x=1710272784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZFx+xPgxixA+738ZryZFXtLCsiOGw0pP2ivTjYroRQ=;
        b=JHLKPm0G3+oal5a0SZkt+TMp+femR0VpNhsTwqcH/pRjfKvac6Kk4cWDwP2cEJq+EX
         rEPlxfdc/nBEXcYgXelI5LKyrSGNTPlLJr1dRU/Dzm79Tn1wcS4aH//3Vg6u88UFVgdI
         OhPXq/DTeC0Bj/xaMpIPmI8PSa5G4Lv3CxbIFYJ+6Nfecg1ZDIQrHdYdusjIEGfQho1M
         +V86cBLreCalnDZtOQrIQVb6kGy2ceISLVOFu6upMj0dkP7NOfjLAWLr0eUq+imeFo+a
         hCM+tsA+f+D3p2pajgcPBZSiFwqV4mrQ9Md4INoU3F4WKj68HqwmtRrXLlYSncY/KKYS
         WAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709667984; x=1710272784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZFx+xPgxixA+738ZryZFXtLCsiOGw0pP2ivTjYroRQ=;
        b=vCLI8XlSMzOStqVa2RMA/u4D3Oh2v3XhFU1y4ideJPDfLA5yOQwLAmJowJZzx5kpO/
         cKA3SuvHcvymn08FZysJPDvg8/ZtgV4kpqEh2xUF7cWZRBdHwHj25KSzxgsI9aBDyw0p
         TZoRpfkX6vnNFas4jHz5OReX+puIZVisyRanHIDMJYs7HGIAqK+edXAyJumhhkzW7+Zf
         YdqmGgTWBVWHXJLiLSyFNqSr7YqEyDH99L0D1bVL0ywpNYD7PQvzIe+LICwCKu9SSCo7
         K9LboykBsIF6IW8yS18xhc7S+ka9o5HKJUnfwuaR/4TEHkBcRJhlDcPn0coRsCtIwG20
         sSYg==
X-Gm-Message-State: AOJu0YyS28VH0rOCjPFpFTiby3579lUwZKP8wxf7KS00V8A5RX+s83Lv
	aKSkbzUlYTpyqmf2mcnkn7Fhxb3QlIWU0eFn8BJL1HDnVG/1vTpIYTIpvf0R/B4cCQ==
X-Google-Smtp-Source: AGHT+IHaJFwhGr89lxjrytMkZHMmN1cfEyEMzRmGxZO1BgJSxdpN/j9LkT9bYfBPmtAfnIXFwCkW5Q==
X-Received: by 2002:a5d:4a05:0:b0:33d:f01e:bc38 with SMTP id m5-20020a5d4a05000000b0033df01ebc38mr9498325wrq.15.1709667983862;
        Tue, 05 Mar 2024 11:46:23 -0800 (PST)
Received: from localhost.localdomain (bzq-218-159-163.cablep.bezeqint.net. [81.218.159.163])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm3276785wry.66.2024.03.05.11.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:46:23 -0800 (PST)
From: Tal Kelrich <hasturkun@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	hasturkun@gmail.com,
	paulus@ozlabs.org
Subject: [PATCH v3] gitk: new option to hide prefetch refs
Date: Tue,  5 Mar 2024 21:45:59 +0200
Message-Id: <20240305194559.2373-1-hasturkun@gmail.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <pull.1023.git.1629807526939.gitgitgadget@gmail.com>
References: <pull.1023.git.1629807526939.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maintenance 'prefetch' task creates refs that mirror remote refs,
and in repositories with many branches this can clutter the commit list.

Add a new option to ignore any prefetch refs, enabled by default.

Signed-off-by: Tal Kelrich <hasturkun@gmail.com>
---
Changes since v1:
 - Patch rebuilt on gitk tree.
 gitk | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 0ae7d68..85315df 100755
--- a/gitk
+++ b/gitk
@@ -1780,6 +1780,7 @@ proc readrefs {} {
     global selecthead selectheadid
     global hideremotes
     global tclencoding
+    global hideprefetch
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
         unset -nocomplain $v
@@ -1814,6 +1815,7 @@ proc readrefs {} {
             }
             set tagids($name) $id
             lappend idtags($id) $name
+        } elseif {[string match "prefetch/*" $name] && $hideprefetch} {
         } else {
             set otherrefids($name) $id
             lappend idotherrefs($id) $name
@@ -11551,7 +11553,7 @@ proc create_prefs_page {w} {
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk maxrefs web_browser
+    global hideremotes want_ttk have_ttk maxrefs web_browser hideprefetch
 
     set page [create_prefs_page $notebook.general]
 
@@ -11575,6 +11577,9 @@ proc prefspage_general {notebook} {
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
         -variable hideremotes
     grid x $page.hideremotes -sticky w
+    ${NS}::checkbutton $page.hideprefetch -text [mc "Hide prefetch refs"] \
+        -variable hideprefetch
+    grid x $page.hideprefetch -sticky w
 
     ${NS}::label $page.ddisp -text [mc "Diff display options"]
     grid $page.ddisp - -sticky w -pady 10
@@ -11699,7 +11704,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes want_ttk have_ttk hideprefetch
 
     set top .gitkprefs
     set prefstop $top
@@ -11708,7 +11713,8 @@ proc doprefs {} {
         return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+                   hideprefetch} {
         set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
@@ -11834,7 +11840,8 @@ proc prefscan {} {
     global oldprefs prefstop
 
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+                   hideprefetch} {
         global $v
         set $v $oldprefs($v)
     }
@@ -11848,7 +11855,7 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
-    global hideremotes
+    global hideremotes hideprefetch
 
     catch {destroy $prefstop}
     unset prefstop
@@ -11894,7 +11901,8 @@ proc prefsok {} {
           $limitdiffs != $oldprefs(limitdiffs)} {
         reselectline
     }
-    if {$hideremotes != $oldprefs(hideremotes)} {
+    if {$hideremotes != $oldprefs(hideremotes) ||
+          $hideprefetch != $oldprefs(hideprefetch)} {
         rereadrefs
     }
 }
@@ -12368,6 +12376,7 @@ set cmitmode "patch"
 set wrapcomment "none"
 set showneartags 1
 set hideremotes 0
+set hideprefetch 1
 set maxrefs 20
 set visiblerefs {"master"}
 set maxlinelen 200
@@ -12480,7 +12489,7 @@ set config_variables {
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor diffbgcolors
-    web_browser
+    web_browser hideprefetch
 }
 foreach var $config_variables {
     config_init_trace $var
-- 
2.37.1.windows.1

