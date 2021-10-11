Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B0C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF4661076
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhJKT6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbhJKT6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 15:58:22 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BA5C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:56:22 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id g125so19348727oif.9
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VE3K7sEA2FbdW5hHysgejLxeii154ipsQClaG5Dzviw=;
        b=IDsY/q7E2CMbkq0j2q69+PQHMl4Mo0FvuiGUumOX65yVKc0p3Ur1+JojiNWp5R0dfY
         jPo7IkUgnBlxMPSGMRETyLYqdG+FcNnXsjfSe2x+WdB2J8jsvZmZOGNZB+IKpflbKaEv
         6P8jiPOsTzlEPe0UM6P/7WBj34hMj02CX5x2qp5f3XWOWvl7pEyAUVdQELbtXPz3bwoe
         58x0p9KO4lKYM+dT8f7TWbd/T23UMJII7QTIdWnyV8uZE+o5pvP+o5KhKUwV76TYsp3n
         hszHPLP8OmXdNCS2/XP3ANgC9YW4LIvgWspI2+Z+zyLYeF4xUOPhGKHlBENZwLa2fxyh
         +2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VE3K7sEA2FbdW5hHysgejLxeii154ipsQClaG5Dzviw=;
        b=4yjxGlcHuSO5lAeYlp/mdZ8wXwMwx8eQ28Wt34DbP2wXc1ZzqrlF1pES3CiJ/kW1BZ
         VgBK07VfPP2SpIM1TXD3m/erFTbys6evcdh87pHuaxXMBlo4FPJkcMeeuMxHo1EPgfW5
         2jCgcz+xyjdwhnCqKoXYhbq+xVf1ddsDTlnzXXBCELD8EbI8/WNQiXbuJQQuEWk9kzA4
         B8fg3LG+ce9Vpk0K9MgD6N+Yywnhzq5yeUMuWLHqAqSVfSuTv8sNFgvr6NHVA4Vl6hZD
         7leBNGRj1AFzyQw3JYrkCrbbEYDu4S1XS44XjzRfqiXqDSOZyN6whxLgalJAX3z9Szww
         brlQ==
X-Gm-Message-State: AOAM5337WGioov6BZzKpLvYgI9czc43mOElIpdfJ6OqYSH2j7ZChp9Ji
        61usBBPXXC/HNQlPsojlc2q9RwpjTK6AfQ==
X-Google-Smtp-Source: ABdhPJwH2lJ5kBchdedX3zxbLRhTSn9BR1x4M1BMycXdLQaTIuE3f00mGQ1aZZKEi5junp1B4Syz9A==
X-Received: by 2002:aca:eb15:: with SMTP id j21mr698349oih.59.1633982181258;
        Mon, 11 Oct 2021 12:56:21 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id n7sm1867030oij.46.2021.10.11.12.56.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 12:56:20 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org, paulus@samba.org
Cc:     avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Rostislav Krasny <rosti.bsd@gmail.com>
Subject: [PATCH] gitk: avoid hardcoded 40 character length for oid
Date:   Mon, 11 Oct 2021 12:55:50 -0700
Message-Id: <20211011195550.3355-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1081.g099423f5b7
In-Reply-To: <20211011114723.204-1-carenas@gmail.com>
References: <20211011114723.204-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current git could return ids larger than 40 characters if using
SHA-256.

Detect if the current repository does and set the oid_size to 64
instead, but fallback to 40 for backward compatibility.

Helped-by: Rostislav Krasny <rosti.bsd@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 gitk | 91 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/gitk b/gitk
index 23d9dd1..22b3cd5 100755
--- a/gitk
+++ b/gitk
@@ -289,7 +289,7 @@ proc parseviewargs {n arglist} {
 }
 
 proc parseviewrevs {view revs} {
-    global vposids vnegids
+    global vposids vnegids oid_size
 
     if {$revs eq {}} {
         set revs HEAD
@@ -303,7 +303,8 @@ proc parseviewrevs {view revs} {
         set badrev {}
         for {set l 0} {$l < [llength $errlines]} {incr l} {
             set line [lindex $errlines $l]
-            if {!([string length $line] == 40 && [string is xdigit $line])} {
+            if {!([string length $line] == $oid_size
+                && [string is xdigit $line])} {
                 if {[string match "fatal:*" $line]} {
                     if {[string match "fatal: ambiguous argument*" $line]
                         && $badrev ne {}} {
@@ -507,6 +508,7 @@ proc updatecommits {} {
     global hasworktree
     global varcid vposids vnegids vflags vrevs
     global show_notes
+    global oid_size
 
     set hasworktree [hasworktree]
     rereadrefs
@@ -540,7 +542,7 @@ proc updatecommits {} {
             # take out positive refs that we asked for before or
             # that we have already seen
             foreach rev $revs {
-                if {[string length $rev] == 40} {
+                if {[string length $rev] == $oid_size} {
                     if {[lsearch -exact $oldpos $rev] < 0
                         && ![info exists varcid($view,$rev)]} {
                         lappend newrevs $rev
@@ -1418,6 +1420,7 @@ proc getcommitlines {fd inst view updating}  {
     global parents children curview hlview
     global idpending ordertok
     global varccommits varcid varctok vtokmod vfilelimit vshortids
+    global oid_size
 
     set stuff [read $fd 500000]
     # git log doesn't terminate the last commit with a null...
@@ -1500,7 +1503,7 @@ proc getcommitlines {fd inst view updating}  {
             }
             set ok 1
             foreach id $ids {
-                if {[string length $id] != 40} {
+                if {[string length $id] != $oid_size} {
                     set ok 0
                     break
                 }
@@ -1780,6 +1783,7 @@ proc readrefs {} {
     global selecthead selectheadid
     global hideremotes
     global tclencoding
+    global oid_size
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
         unset -nocomplain $v
@@ -1789,9 +1793,9 @@ proc readrefs {} {
         fconfigure $refd -encoding $tclencoding
     }
     while {[gets $refd line] >= 0} {
-        if {[string index $line 40] ne " "} continue
-        set id [string range $line 0 39]
-        set ref [string range $line 41 end]
+        if {[string index $line $oid_size] ne " "} continue
+        set id [string range $line 0 [expr {$oid_size - 1}]]
+        set ref [string range $line [expr {$oid_size + 1}] end]
         if {![string match "refs/*" $ref]} continue
         set name [string range $ref 5 end]
         if {[string match "remotes/*" $name]} {
@@ -2082,6 +2086,7 @@ proc makewindow {} {
     global have_tk85 use_ttk NS
     global git_version
     global worddiff
+    global oid_size
 
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
@@ -2203,11 +2208,12 @@ proc makewindow {} {
     set sha1entry .tf.bar.sha1
     set entries $sha1entry
     set sha1but .tf.bar.sha1label
-    button $sha1but -text "[mc "SHA1 ID:"] " -state disabled -relief flat \
-        -command gotocommit -width 8
+    button $sha1but -text "[mc "SHA ID:"] " -state disabled -relief flat \
+        -command gotocommit -width 7
     $sha1but conf -disabledforeground [$sha1but cget -foreground]
     pack .tf.bar.sha1label -side left
-    ${NS}::entry $sha1entry -width 40 -font textfont -textvariable sha1string
+    ${NS}::entry $sha1entry -width $oid_size -font textfont \
+        -textvariable sha1string
     trace add variable sha1string write sha1change
     pack $sha1entry -side left -pady 2
 
@@ -3925,7 +3931,7 @@ proc stopblaming {} {
 }
 
 proc read_line_source {fd inst} {
-    global blamestuff curview commfd blameinst nullid nullid2
+    global blamestuff curview commfd blameinst nullid nullid2 oid_size
 
     while {[gets $fd line] >= 0} {
         lappend blamestuff($inst) $line
@@ -3946,7 +3952,7 @@ proc read_line_source {fd inst} {
     set line [split [lindex $blamestuff($inst) 0] " "]
     set id [lindex $line 0]
     set lnum [lindex $line 1]
-    if {[string length $id] == 40 && [string is xdigit $id] &&
+    if {[string length $id] == $oid_size && [string is xdigit $id] &&
         [string is digit -strict $lnum]} {
         # look for "filename" line
         foreach l $blamestuff($inst) {
@@ -5094,7 +5100,7 @@ proc shortids {ids} {
     foreach id $ids {
         if {[llength $id] > 1} {
             lappend res [shortids $id]
-        } elseif {[regexp {^[0-9a-f]{40}$} $id]} {
+        } elseif {[regexp {^[0-9a-f]{40,}$} $id]} {
             lappend res [string range $id 0 7]
         } else {
             lappend res $id
@@ -5269,13 +5275,14 @@ proc get_viewmainhead {view} {
 # git rev-list should give us just 1 line to use as viewmainheadid($view)
 proc getviewhead {fd inst view} {
     global viewmainheadid commfd curview viewinstances showlocalchanges
+    global oid_size
 
     set id {}
     if {[gets $fd line] < 0} {
         if {![eof $fd]} {
             return 1
         }
-    } elseif {[string length $line] == 40 && [string is xdigit $line]} {
+    } elseif {[string length $line] == $oid_size && [string is xdigit $line]} {
         set id $line
     }
     set viewmainheadid($view) $id
@@ -7034,15 +7041,16 @@ proc commit_descriptor {p} {
     return "$p ($l)\n"
 }
 
-# append some text to the ctext widget, and make any SHA1 ID
+# append some text to the ctext widget, and make any SHA ID
 # that we know about be a clickable link.
 # Also look for URLs of the form "http[s]://..." and make them web links.
 proc appendwithlinks {text tags} {
-    global ctext linknum curview
+    global ctext linknum curview oid_size
 
     set start [$ctext index "end - 1c"]
     $ctext insert end $text $tags
-    set links [regexp -indices -all -inline {(?:\m|-g)[0-9a-f]{6,40}\M} $text]
+    set links [regexp -indices -all \
+        -inline [string map "@@ $oid_size" {(?:\m|-g)[0-9a-f]{6,@@}\M}] $text]
     foreach l $links {
         set s [lindex $l 0]
         set e [lindex $l 1]
@@ -7070,13 +7078,14 @@ proc appendwithlinks {text tags} {
 proc setlink {id lk} {
     global curview ctext pendinglinks
     global linkfgcolor
+    global oid_size
 
     if {[string range $id 0 1] eq "-g"} {
       set id [string range $id 2 end]
     }
 
     set known 0
-    if {[string length $id] < 40} {
+    if {[string length $id] < $oid_size} {
         set matches [longid $id]
         if {[llength $matches] > 0} {
             if {[llength $matches] > 1} return
@@ -8715,8 +8724,8 @@ proc incrfont {inc} {
 }
 
 proc clearsha1 {} {
-    global sha1entry sha1string
-    if {[string length $sha1string] == 40} {
+    global sha1entry sha1string oid_size
+    if {[string length $sha1string] == $oid_size} {
         $sha1entry delete 0 end
     }
 }
@@ -8733,7 +8742,7 @@ proc sha1change {n1 n2 op} {
     if {$state == "normal"} {
         $sha1but conf -state normal -relief raised -text "[mc "Goto:"] "
     } else {
-        $sha1but conf -state disabled -relief flat -text "[mc "SHA1 ID:"] "
+        $sha1but conf -state disabled -relief flat -text "[mc "SHA ID:"] "
     }
 }
 
@@ -8748,11 +8757,11 @@ proc gotocommit {} {
         set id $headids($sha1string)
     } else {
         set id [string tolower $sha1string]
-        if {[regexp {^[0-9a-f]{4,39}$} $id]} {
+        if {[regexp {^[0-9a-f]{4,}$} $id]} {
             set matches [longid $id]
             if {$matches ne {}} {
                 if {[llength $matches] > 1} {
-                    error_popup [mc "Short SHA1 id %s is ambiguous" $id]
+                    error_popup [mc "Short SHA id %s is ambiguous" $id]
                     return
                 }
                 set id [lindex $matches 0]
@@ -8769,7 +8778,7 @@ proc gotocommit {} {
         return
     }
     if {[regexp {^[0-9a-fA-F]{4,}$} $sha1string]} {
-        set msg [mc "SHA1 id %s is not known" $sha1string]
+        set msg [mc "SHA id %s is not known" $sha1string]
     } else {
         set msg [mc "Revision %s is not in the current view" $sha1string]
     }
@@ -9445,11 +9454,11 @@ proc mktaggo {} {
 }
 
 proc copyreference {} {
-    global rowmenuid autosellen
+    global rowmenuid autosellen oid_size
 
     set format "%h (\"%s\", %ad)"
     set cmd [list git show -s --pretty=format:$format --date=short]
-    if {$autosellen < 40} {
+    if {$autosellen < $oid_size} {
         lappend cmd --abbrev=$autosellen
     }
     set reference [eval exec $cmd $rowmenuid]
@@ -9459,7 +9468,7 @@ proc copyreference {} {
 }
 
 proc writecommit {} {
-    global rowmenuid wrcomtop commitinfo wrcomcmd NS
+    global rowmenuid wrcomtop commitinfo wrcomcmd NS oid_size
 
     set top .writecommit
     set wrcomtop $top
@@ -9469,7 +9478,7 @@ proc writecommit {} {
     ${NS}::label $top.title -text [mc "Write commit to file"]
     grid $top.title - -pady 10
     ${NS}::label $top.id -text [mc "ID:"]
-    ${NS}::entry $top.sha1 -width 40
+    ${NS}::entry $top.sha1 -width $oid_size
     $top.sha1 insert 0 $rowmenuid
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
@@ -9548,7 +9557,7 @@ proc mvbranch {} {
 }
 
 proc branchdia {top valvar uivar} {
-    global NS commitinfo
+    global NS commitinfo oid_size
     upvar $valvar val $uivar ui
 
     catch {destroy $top}
@@ -9557,7 +9566,7 @@ proc branchdia {top valvar uivar} {
     ${NS}::label $top.title -text $ui(title)
     grid $top.title - -pady 10
     ${NS}::label $top.id -text [mc "ID:"]
-    ${NS}::entry $top.sha1 -width 40
+    ${NS}::entry $top.sha1 -width $oid_size
     $top.sha1 insert 0 $val(id)
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
@@ -11565,9 +11574,9 @@ proc prefspage_general {notebook} {
     ${NS}::checkbutton $page.showlocal -text [mc "Show local changes"] \
         -variable showlocalchanges
     grid x $page.showlocal -sticky w
-    ${NS}::checkbutton $page.autoselect -text [mc "Auto-select SHA1 (length)"] \
+    ${NS}::checkbutton $page.autoselect -text [mc "Auto-select SHA (length)"] \
         -variable autoselect
-    spinbox $page.autosellen -from 1 -to 40 -width 4 -textvariable autosellen
+    spinbox $page.autosellen -from 1 -to 64 -width 4 -textvariable autosellen
     grid x $page.autoselect $page.autosellen -sticky w
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
         -variable hideremotes
@@ -12338,6 +12347,18 @@ catch {
     set log_showroot [exec git config --bool --get log.showroot]
 }
 
+if {![catch {exec git config --get extensions.objectformat} oid_type]
+    && $oid_type eq "sha256" } {
+    set oid_size 64
+} else {
+    set oid_type "sha1"
+    set oid_size 40
+}
+
+set nullid [format "%0*s" $oid_size 0]
+set nullid2 [format "%0*s" $oid_size 1]
+set nullfile "/dev/null"
+
 if {[tk windowingsystem] eq "aqua"} {
     set mainfont {{Lucida Grande} 9}
     set textfont {Monaco 9}
@@ -12372,7 +12393,7 @@ set showlocalchanges 1
 set limitdiffs 1
 set datetimeformat "%Y-%m-%d %H:%M:%S"
 set autoselect 1
-set autosellen 40
+set autosellen $oid_size
 set perfile_attrs 0
 set want_ttk 1
 
@@ -12565,10 +12586,6 @@ if {$i >= [llength $argv] && $revtreeargs ne {}} {
     }
 }
 
-set nullid "0000000000000000000000000000000000000000"
-set nullid2 "0000000000000000000000000000000000000001"
-set nullfile "/dev/null"
-
 set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
 if {![info exists have_ttk]} {
     set have_ttk [llength [info commands ::ttk::style]]
-- 
2.33.0.1081.g099423f5b7

