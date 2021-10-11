Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F782C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 11:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E92E60E0B
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 11:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhJKLtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhJKLtk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 07:49:40 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D6CC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 04:47:40 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t16so3895882qto.5
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRGF8sp+Xju4QjUKaA6DT9ScFmPFYz2Deyp7xfh6q00=;
        b=gSfOndvZrz/cH/O4vxELuKB/idr6vvnQMBcv6/WiuM/KIqA+eIoasyKXNEDBf72wzP
         ZxF20bcO/u0swWU7a6/dEwx/0XmHfi0IeFTA9LRnT3GlWRQ5+ye7bTCxq/Qa6qMglxUb
         REK/90ttjb3nkuxZml8qjRADNOywChP0dL4iflRmxfV5jZlg2kd4qPv+Ejfcm1BD7ZAw
         9y7DksbHIJg7YVJ9IN83qoLjcGes9PxV3oAqUqSYP6ErUsSdA7E/O1NDqx5HNzFW+XxL
         Uq3ef5Mv8Wn2giqK+Lv0DTUfPerhOqYG0aFX6bFEY55RL0kCZAw6ejngJn+b5SXzVGk+
         zDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRGF8sp+Xju4QjUKaA6DT9ScFmPFYz2Deyp7xfh6q00=;
        b=mF2GPJKmEkzS/i7JXc0LtbmSmju1VNkffY+ocAg5VusAwBDDSIJBUYi1qL1mJhPoa3
         wgHAB1wz8oxSx3vQO+XlFUa9OuE+qRcZM9lIZj3/UB83iJTfq050jqSN9Veh2Fz0LXG/
         P528N7HFfWcSTi69I7kGRVNaXChI/Jh6D+vhRElALIYMOb+reUutMnLfi0uJzRKQuMdQ
         NaG+CvdN/VlNdYSj5al+qTWWzXtY3vQ8tFUHOssZSyDVMgw7yvPIwgJf7m6T3tLccmBE
         mcVMDae49obt/bW749IrfjP8bYtio/AX6aPYhu/nNsnZab0N18hV3BC8k4Tapmdq+oFi
         ggWA==
X-Gm-Message-State: AOAM530AWNmqXeA0EtN/Luc9UC5Q4bzkWExmrXK3nblcAUf5E1L7bOuH
        ox0FHa6Ocb5wescrKgxXv9TldyN1zk964g==
X-Google-Smtp-Source: ABdhPJwXl9O4S1LwIff7e7bUlcDhzaHdGUHzLrFwl+0vMRpueiyll2ocSWhUWbrUQ44rWfCa6+WIFw==
X-Received: by 2002:a05:622a:14cb:: with SMTP id u11mr14332954qtx.218.1633952859731;
        Mon, 11 Oct 2021 04:47:39 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r13sm4127389qkk.73.2021.10.11.04.47.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 04:47:39 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org, paulus@samba.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH] gitk: avoid hardcoded 40 characters for oid
Date:   Mon, 11 Oct 2021 04:47:23 -0700
Message-Id: <20211011114723.204-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1081.g099423f5b7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current git could return ids larger than 40 characters if using
SHA-256.

Detect if the current repository does and set the oid_size to 64
instead, but fallback to 40 for backward compatibility, as well
as matching ids in a hash agnostic way.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
With this patch, I was able to open gitk in a SHA-256 repository
without an error, and still do the same in a regular one.

Sending it as an RFC, since I am not a gitk user and haven't done
much testing of it, and because it is likely incomplete, as they
are still variables and other labels referring to SHA1 which would
need to be updated as well.

There is also a related set of changes needed for git-gui that
will be send independently.

 gitk | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/gitk b/gitk
index 23d9dd1..5087543 100755
--- a/gitk
+++ b/gitk
@@ -1418,6 +1418,7 @@ proc getcommitlines {fd inst view updating}  {
     global parents children curview hlview
     global idpending ordertok
     global varccommits varcid varctok vtokmod vfilelimit vshortids
+    global oid_size
 
     set stuff [read $fd 500000]
     # git log doesn't terminate the last commit with a null...
@@ -1500,7 +1501,7 @@ proc getcommitlines {fd inst view updating}  {
             }
             set ok 1
             foreach id $ids {
-                if {[string length $id] != 40} {
+                if {[string length $id] != $oid_size} {
                     set ok 0
                     break
                 }
@@ -3925,7 +3926,7 @@ proc stopblaming {} {
 }
 
 proc read_line_source {fd inst} {
-    global blamestuff curview commfd blameinst nullid nullid2
+    global blamestuff curview commfd blameinst nullid nullid2 oid_size
 
     while {[gets $fd line] >= 0} {
         lappend blamestuff($inst) $line
@@ -3946,7 +3947,7 @@ proc read_line_source {fd inst} {
     set line [split [lindex $blamestuff($inst) 0] " "]
     set id [lindex $line 0]
     set lnum [lindex $line 1]
-    if {[string length $id] == 40 && [string is xdigit $id] &&
+    if {[string length $id] == $oid_size && [string is xdigit $id] &&
         [string is digit -strict $lnum]} {
         # look for "filename" line
         foreach l $blamestuff($inst) {
@@ -5094,7 +5095,7 @@ proc shortids {ids} {
     foreach id $ids {
         if {[llength $id] > 1} {
             lappend res [shortids $id]
-        } elseif {[regexp {^[0-9a-f]{40}$} $id]} {
+        } elseif {[regexp {^[0-9a-f]{40}(?:[0-9a-f]{24})?$} $id]} {
             lappend res [string range $id 0 7]
         } else {
             lappend res $id
@@ -5269,13 +5270,14 @@ proc get_viewmainhead {view} {
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
@@ -7070,13 +7072,14 @@ proc appendwithlinks {text tags} {
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
@@ -8715,8 +8718,8 @@ proc incrfont {inc} {
 }
 
 proc clearsha1 {} {
-    global sha1entry sha1string
-    if {[string length $sha1string] == 40} {
+    global sha1entry sha1string oid_size
+    if {[string length $sha1string] == $oid_size} {
         $sha1entry delete 0 end
     }
 }
@@ -9445,11 +9448,11 @@ proc mktaggo {} {
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
@@ -9459,7 +9462,7 @@ proc copyreference {} {
 }
 
 proc writecommit {} {
-    global rowmenuid wrcomtop commitinfo wrcomcmd NS
+    global rowmenuid wrcomtop commitinfo wrcomcmd NS oid_size
 
     set top .writecommit
     set wrcomtop $top
@@ -9469,7 +9472,7 @@ proc writecommit {} {
     ${NS}::label $top.title -text [mc "Write commit to file"]
     grid $top.title - -pady 10
     ${NS}::label $top.id -text [mc "ID:"]
-    ${NS}::entry $top.sha1 -width 40
+    ${NS}::entry $top.sha1 -width $oid_size
     $top.sha1 insert 0 $rowmenuid
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
@@ -9548,7 +9551,7 @@ proc mvbranch {} {
 }
 
 proc branchdia {top valvar uivar} {
-    global NS commitinfo
+    global NS commitinfo oid_size
     upvar $valvar val $uivar ui
 
     catch {destroy $top}
@@ -9557,7 +9560,7 @@ proc branchdia {top valvar uivar} {
     ${NS}::label $top.title -text $ui(title)
     grid $top.title - -pady 10
     ${NS}::label $top.id -text [mc "ID:"]
-    ${NS}::entry $top.sha1 -width 40
+    ${NS}::entry $top.sha1 -width $oid_size
     $top.sha1 insert 0 $val(id)
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
@@ -12565,8 +12568,18 @@ if {$i >= [llength $argv] && $revtreeargs ne {}} {
     }
 }
 
-set nullid "0000000000000000000000000000000000000000"
-set nullid2 "0000000000000000000000000000000000000001"
+if {[catch {exec git config --get extensions.objectformat} hash]} {
+    set oid_size 40
+} else {
+    if { $hash eq "sha256" } {
+        set oid_size 64
+    } else {
+        set oid_size 40
+    }
+}
+
+set nullid %-0*s $oid_size 0
+set nullid2 %-0*s $oid_size 1
 set nullfile "/dev/null"
 
 set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
-- 
2.33.0.1081.g099423f5b7

