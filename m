Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF051EB19F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485313; cv=none; b=bWdABOOTN0xZKh0u3eNv/wL6ocllGCMOxicwQU+362/R9O/PbRBcKkFZWGrc29eL6U8hIRq4pUFyyOVOWypGVMAO6w0sVqFBvHB/xFqBKL3pqiBMLAykAxJhQp5iHCRekTwkqj73VuBdvYHzTI5hUQwrSdkZKIfk9y9HNO8i5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485313; c=relaxed/simple;
	bh=BJs4UWHHiMz7ja2KKR3YUGNXGlnWKC0dcH/w1wLs3do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7pObdzwbFrdOe/JTxAhSwKdJovkqw2S15tWa6bScsO1Q086igP03qYljeQdcmrbeLfg246gca/n4FJAPqPVFOhDxNWnSdz7f2Ka6cSLqmF4e70DhVqTOoxoFcP8/ztnDQgN9MxmZ9cw/nleE7ici0zPvt++iV+QewphBIWiGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p9drWvLK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qLOGuGjk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p9drWvLK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qLOGuGjk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p9drWvLK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qLOGuGjk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p9drWvLK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qLOGuGjk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E7D91F7A2;
	Thu, 20 Mar 2025 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742485302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXomynaLdek5kpMsuIhKcqwvvB2Jnv43E2U13LyIUcQ=;
	b=p9drWvLKsNiwyLcADxSglhWJIp1XuxOWBSHRAhSB4sKJ9vonwzrdezOK9NM4fLjp+2yKJ4
	2MnnSJgVowN8OipWrP5G3iSwAxtg5NbT2iHJz8GeXXh/cmaE81oZaIxu2ifuELNIAIStS3
	2Kva3hWO7Qjh1hBSblUdOn3BX98p/c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742485302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXomynaLdek5kpMsuIhKcqwvvB2Jnv43E2U13LyIUcQ=;
	b=qLOGuGjk//rGpCPwAe9Zhhz7r05Xa27G6/3EcVWZYMN9b35iHt8X6ghXx6Z2hEllNh6wm+
	Akny3Y0GqF1ErZAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742485302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXomynaLdek5kpMsuIhKcqwvvB2Jnv43E2U13LyIUcQ=;
	b=p9drWvLKsNiwyLcADxSglhWJIp1XuxOWBSHRAhSB4sKJ9vonwzrdezOK9NM4fLjp+2yKJ4
	2MnnSJgVowN8OipWrP5G3iSwAxtg5NbT2iHJz8GeXXh/cmaE81oZaIxu2ifuELNIAIStS3
	2Kva3hWO7Qjh1hBSblUdOn3BX98p/c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742485302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXomynaLdek5kpMsuIhKcqwvvB2Jnv43E2U13LyIUcQ=;
	b=qLOGuGjk//rGpCPwAe9Zhhz7r05Xa27G6/3EcVWZYMN9b35iHt8X6ghXx6Z2hEllNh6wm+
	Akny3Y0GqF1ErZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5101D139D2;
	Thu, 20 Mar 2025 15:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oN+VEjY33GcueAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Mar 2025 15:41:42 +0000
From: Takashi Iwai <tiwai@suse.de>
To: git@vger.kernel.org
Cc: Denton Liu <liu.denton@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Eric Huber <echuber2@illinois.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avi Halachmi <avihpit@yahoo.com>,
	Christoph Sommer <sommer@cms-labs.org>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 1/2] gitk: Add a basic support of SHA256 repositories into Gitk
Date: Thu, 20 Mar 2025 16:41:33 +0100
Message-ID: <20250320154136.23262-2-tiwai@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320154136.23262-1-tiwai@suse.de>
References: <20250320154136.23262-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_CC(0.00)[gmail.com,kdbg.org,illinois.edu,gmx.de,yahoo.com,cms-labs.org,ozlabs.org];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,yahoo.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

From: Rostislav Krasny <rosti.bsd@gmail.com>

This PR makes Gitk working on both SHA256 and SHA1 repositories without
errors/crashes. I made it by changing and testing the gitk script of Git
for Windows [https://gitforwindows.org/] version 2.32.0.windows.1 that
is a little bit different than the mainstream 2.32.0 version.

Still not fixed functionality: [1] There is the "Auto-select SHA1
(length)" configuration preference that affects "Copy commit reference"
on both SHA1 and SHA256 repositories.

A new "Auto-select SHA256 (length)" configuration preference should be
added and used on SHA256 repositories instead of the old one. Since I'm
not familiar with Tcl/Tk and this issue isn't critical I didn't
implement it.

[ Changes from the original patch:
  * Discard the changes for generic words (e.g. "Commit ID"), so that
    translations can be still applied after this patch
  * Simplify the regexp check in gotocommit as suggested in the
    previous review
  -- tiwai ]

Signed-off-by: Rostislav Krasny <rosti.bsd@gmail.com>
Link: https://patchwork.kernel.org/project/git/patch/pull.979.git.1623687519832.gitgitgadget@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 gitk-git/gitk | 59 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index bc9efa18566f..1e85cfef2ee3 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -425,6 +425,7 @@ proc parseviewargs {n arglist} {
 
 proc parseviewrevs {view revs} {
     global vposids vnegids
+    global hashlength
 
     if {$revs eq {}} {
         set revs HEAD
@@ -438,7 +439,7 @@ proc parseviewrevs {view revs} {
         set badrev {}
         for {set l 0} {$l < [llength $errlines]} {incr l} {
             set line [lindex $errlines $l]
-            if {!([string length $line] == 40 && [string is xdigit $line])} {
+            if {!([string length $line] == $hashlength && [string is xdigit $line])} {
                 if {[string match "fatal:*" $line]} {
                     if {[string match "fatal: ambiguous argument*" $line]
                         && $badrev ne {}} {
@@ -655,6 +656,7 @@ proc updatecommits {} {
     global hasworktree
     global varcid vposids vnegids vflags vrevs
     global show_notes
+    global hashlength
 
     set hasworktree [hasworktree]
     rereadrefs
@@ -688,7 +690,7 @@ proc updatecommits {} {
             # take out positive refs that we asked for before or
             # that we have already seen
             foreach rev $revs {
-                if {[string length $rev] == 40} {
+                if {[string length $rev] == $hashlength} {
                     if {[lsearch -exact $oldpos $rev] < 0
                         && ![info exists varcid($view,$rev)]} {
                         lappend newrevs $rev
@@ -1573,6 +1575,7 @@ proc getcommitlines {fd inst view updating}  {
     global parents children curview hlview
     global idpending ordertok
     global varccommits varcid varctok vtokmod vfilelimit vshortids
+    global hashlength
 
     set stuff [read $fd 500000]
     # git log doesn't terminate the last commit with a null...
@@ -1655,7 +1658,7 @@ proc getcommitlines {fd inst view updating}  {
             }
             set ok 1
             foreach id $ids {
-                if {[string length $id] != 40} {
+                if {[string length $id] != $hashlength} {
                     set ok 0
                     break
                 }
@@ -1935,6 +1938,7 @@ proc readrefs {} {
     global selecthead selectheadid
     global hideremotes
     global tclencoding
+    global hashlength
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
         unset -nocomplain $v
@@ -1944,9 +1948,9 @@ proc readrefs {} {
         fconfigure $refd -encoding $tclencoding
     }
     while {[gets $refd line] >= 0} {
-        if {[string index $line 40] ne " "} continue
-        set id [string range $line 0 39]
-        set ref [string range $line 41 end]
+        if {[string index $line $hashlength] ne " "} continue
+        set id [string range $line 0 [expr {$hashlength - 1}]]
+        set ref [string range $line [expr {$hashlength + 1}] end]
         if {![string match "refs/*" $ref]} continue
         set name [string range $ref 5 end]
         if {[string match "remotes/*" $name]} {
@@ -2241,6 +2245,7 @@ proc makewindow {} {
     global have_tk85 have_tk86 use_ttk NS
     global git_version
     global worddiff
+    global hashlength
 
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
@@ -2366,7 +2371,7 @@ proc makewindow {} {
         -command gotocommit -width 8
     $sha1but conf -disabledforeground [$sha1but cget -foreground]
     pack .tf.bar.sha1label -side left
-    ${NS}::entry $sha1entry -width 40 -font textfont -textvariable sha1string
+    ${NS}::entry $sha1entry -width $hashlength -font textfont -textvariable sha1string
     trace add variable sha1string write sha1change
     pack $sha1entry -side left -pady 2
 
@@ -4093,6 +4098,7 @@ proc stopblaming {} {
 
 proc read_line_source {fd inst} {
     global blamestuff curview commfd blameinst nullid nullid2
+    global hashlength
 
     while {[gets $fd line] >= 0} {
         lappend blamestuff($inst) $line
@@ -4113,7 +4119,7 @@ proc read_line_source {fd inst} {
     set line [split [lindex $blamestuff($inst) 0] " "]
     set id [lindex $line 0]
     set lnum [lindex $line 1]
-    if {[string length $id] == 40 && [string is xdigit $id] &&
+    if {[string length $id] == $hashlength && [string is xdigit $id] &&
         [string is digit -strict $lnum]} {
         # look for "filename" line
         foreach l $blamestuff($inst) {
@@ -5436,13 +5442,14 @@ proc get_viewmainhead {view} {
 # git rev-list should give us just 1 line to use as viewmainheadid($view)
 proc getviewhead {fd inst view} {
     global viewmainheadid commfd curview viewinstances showlocalchanges
+    global hashlength
 
     set id {}
     if {[gets $fd line] < 0} {
         if {![eof $fd]} {
             return 1
         }
-    } elseif {[string length $line] == 40 && [string is xdigit $line]} {
+    } elseif {[string length $line] == $hashlength && [string is xdigit $line]} {
         set id $line
     }
     set viewmainheadid($view) $id
@@ -7206,10 +7213,11 @@ proc commit_descriptor {p} {
 # Also look for URLs of the form "http[s]://..." and make them web links.
 proc appendwithlinks {text tags} {
     global ctext linknum curview
+    global hashlength
 
     set start [$ctext index "end - 1c"]
     $ctext insert end $text $tags
-    set links [regexp -indices -all -inline {(?:\m|-g)[0-9a-f]{6,40}\M} $text]
+    set links [regexp -indices -all -inline [string map "@@ $hashlength" {(?:\m|-g)[0-9a-f]{6,@@}\M}] $text]
     foreach l $links {
         set s [lindex $l 0]
         set e [lindex $l 1]
@@ -8888,13 +8896,16 @@ proc incrfont {inc} {
 
 proc clearsha1 {} {
     global sha1entry sha1string
-    if {[string length $sha1string] == 40} {
+    global hashlength
+
+    if {[string length $sha1string] == $hashlength} {
         $sha1entry delete 0 end
     }
 }
 
 proc sha1change {n1 n2 op} {
     global sha1string currentid sha1but
+
     if {$sha1string == {}
         || ([info exists currentid] && $sha1string == $currentid)} {
         set state disabled
@@ -8911,6 +8922,7 @@ proc sha1change {n1 n2 op} {
 
 proc gotocommit {} {
     global sha1string tagids headids curview varcid
+    global hashlength
 
     if {$sha1string == {}
         || ([info exists currentid] && $sha1string == $currentid)} return
@@ -8920,11 +8932,11 @@ proc gotocommit {} {
         set id $headids($sha1string)
     } else {
         set id [string tolower $sha1string]
-        if {[regexp {^[0-9a-f]{4,39}$} $id]} {
+	if {[regexp {^[0-9a-f]{4,63}$} $id]} {
             set matches [longid $id]
             if {$matches ne {}} {
                 if {[llength $matches] > 1} {
-                    error_popup [mc "Short commit ID %s is ambiguous" $id]
+                    error_popup [mc "Short commit id %s is ambiguous" $id]
                     return
                 }
                 set id [lindex $matches 0]
@@ -9618,10 +9630,11 @@ proc mktaggo {} {
 
 proc copyreference {} {
     global rowmenuid autosellen
+    global hashlength
 
     set format "%h (\"%s\", %ad)"
     set cmd [list git show -s --pretty=format:$format --date=short]
-    if {$autosellen < 40} {
+    if {$autosellen < $hashlength} {
         lappend cmd --abbrev=$autosellen
     }
     set reference [eval exec $cmd $rowmenuid]
@@ -9632,6 +9645,7 @@ proc copyreference {} {
 
 proc writecommit {} {
     global rowmenuid wrcomtop commitinfo wrcomcmd NS
+    global hashlength
 
     set top .writecommit
     set wrcomtop $top
@@ -9641,7 +9655,7 @@ proc writecommit {} {
     ${NS}::label $top.title -text [mc "Write commit to file"]
     grid $top.title - -pady 10
     ${NS}::label $top.id -text [mc "ID:"]
-    ${NS}::entry $top.sha1 -width 40
+    ${NS}::entry $top.sha1 -width $hashlength
     $top.sha1 insert 0 $rowmenuid
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
@@ -9721,6 +9735,7 @@ proc mvbranch {} {
 
 proc branchdia {top valvar uivar} {
     global NS commitinfo
+    global hashlength
     upvar $valvar val $uivar ui
 
     catch {destroy $top}
@@ -9729,7 +9744,7 @@ proc branchdia {top valvar uivar} {
     ${NS}::label $top.title -text $ui(title)
     grid $top.title - -pady 10
     ${NS}::label $top.id -text [mc "ID:"]
-    ${NS}::entry $top.sha1 -width 40
+    ${NS}::entry $top.sha1 -width $hashlength
     $top.sha1 insert 0 $val(id)
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
@@ -12524,6 +12539,18 @@ if {$tclencoding == {}} {
     puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
 }
 
+set objformat [exec git rev-parse --show-object-format]
+if {$objformat eq "sha1"} {
+    set hashlength 40
+} elseif {$objformat eq "sha256"} {
+    set hashlength 64
+} else {
+    error_popup "[mc "Not supported hash algorithm:"] {$objformat}"
+    exit 1
+}
+set hashalgorithm [string toupper $objformat]
+unset objformat
+
 set gui_encoding [encoding system]
 catch {
     set enc [exec git config --get gui.encoding]
-- 
2.49.0

