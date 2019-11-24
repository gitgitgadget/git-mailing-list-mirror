Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F09C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E451E207FD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI10lSkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfKXUiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 15:38:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35514 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKXUiA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 15:38:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id n5so3255276wmc.0
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sbqQKPFLwqefjSeatY3TgmSApYsc1DIwXSJjnSoXqzg=;
        b=DI10lSkSTIn0aUIPgVTUC6DCCnCFq094U4AjRJg3osDeG1HdfXVHxY2CSamfzjKUt2
         aLidyQWMOOc19gBIxUlOYFAgIPMH4o4XjNUWsm63OdTBNyTmNccPkmEzaiYumE+RnW2j
         St+QfRqKfL8nDZ/2fXgUh59dKmoc05a1z2zvc9X8Ab2iDlfeCx1i488kc1H+Xs/0FR3u
         eJCn/MXBJA8t4KGeOJCwtKtZWWz4vWQiFcL0DWtoVTsMicGjA4lAd91PnRAnZh+AAWaP
         0NcyXMpg05P/TJdxWxxO/DtEbd/abQY7eMhOgACwetF460YmXB/qPhAU60hP5gkcc7oi
         M74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sbqQKPFLwqefjSeatY3TgmSApYsc1DIwXSJjnSoXqzg=;
        b=Dnp6B9BFmAS809+TFvj9ggoX3bQ2dKqHmgnoph3wDdsynR/eANpSmuGAVqfvkZrWhV
         FJcXr8LyXsS2Jhn+QQjwGp8UVIjCFIU2k6cqWZyXQ15e+2GQPhx/TA/DBOSm0bGk/VMh
         OW/YAKWic01U5NX7M9PNSg+PEWDStScAsqNxKn39TQOviVdlx8Q/y3kH/y1G84WWf5i9
         ntGI8nqUT2J9WsWh93V1xDV4vWU8CFWXFH+7vHrFZS1OXAnJ3SiSpv1xS0tvGYDqK2+0
         BxL5t4Z364fo3ZCMhJvFZDwYYDilqdVLYlEBp3kYyqjuYt8DW2R08s9/EOY4eN6SEDrs
         Y/qA==
X-Gm-Message-State: APjAAAUBj83YMKW4t5QVtHl76Sp/HLaDAtLceHC5qdSVq1wKpdl9WnO1
        8ERW/kcwLnESEpyYAKaq8DrYsM4g
X-Google-Smtp-Source: APXvYqyiCDZMeEc+zELlyk81baNZgtBQo7gq1kXiepwZGglsmXFfUUAX5uXM/reneouRufqtDGs7Uw==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr27213784wmi.124.1574627878058;
        Sun, 24 Nov 2019 12:37:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o187sm6262593wmo.20.2019.11.24.12.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 12:37:57 -0800 (PST)
Message-Id: <da1704c56e0bd3f1ac53af96b702e3777bb3eb37.1574627876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
References: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
        <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 20:37:53 +0000
Subject: [PATCH v5 1/3] git-gui: consolidate naming conventions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Gilbert <JonathanG@iQmetrix.com>

A few variables in this file use camelCase, while the overall standard
is snake_case. A consistent naming scheme will improve readability of
future changes. To avoid mixing naming changes with semantic changes,
this commit contains only naming changes.

Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
---
 lib/index.tcl | 92 +++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index e07b7a3762..28d4d2a54e 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -56,15 +56,15 @@ proc _close_updateindex {fd after} {
 	uplevel #0 $after
 }
 
-proc update_indexinfo {msg pathList after} {
+proc update_indexinfo {msg path_list after} {
 	global update_index_cp
 
 	if {![lock_index update]} return
 
 	set update_index_cp 0
-	set pathList [lsort $pathList]
-	set totalCnt [llength $pathList]
-	set batch [expr {int($totalCnt * .01) + 1}]
+	set path_list [lsort $path_list]
+	set total_cnt [llength $path_list]
+	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
 	$::main_status start $msg [mc "files"]
@@ -78,26 +78,26 @@ proc update_indexinfo {msg pathList after} {
 	fileevent $fd writable [list \
 		write_update_indexinfo \
 		$fd \
-		$pathList \
-		$totalCnt \
+		$path_list \
+		$total_cnt \
 		$batch \
 		$after \
 		]
 }
 
-proc write_update_indexinfo {fd pathList totalCnt batch after} {
+proc write_update_indexinfo {fd path_list total_cnt batch after} {
 	global update_index_cp
 	global file_states current_diff_path
 
-	if {$update_index_cp >= $totalCnt} {
+	if {$update_index_cp >= $total_cnt} {
 		_close_updateindex $fd $after
 		return
 	}
 
 	for {set i $batch} \
-		{$update_index_cp < $totalCnt && $i > 0} \
+		{$update_index_cp < $total_cnt && $i > 0} \
 		{incr i -1} {
-		set path [lindex $pathList $update_index_cp]
+		set path [lindex $path_list $update_index_cp]
 		incr update_index_cp
 
 		set s $file_states($path)
@@ -119,18 +119,18 @@ proc write_update_indexinfo {fd pathList totalCnt batch after} {
 		display_file $path $new
 	}
 
-	$::main_status update $update_index_cp $totalCnt
+	$::main_status update $update_index_cp $total_cnt
 }
 
-proc update_index {msg pathList after} {
+proc update_index {msg path_list after} {
 	global update_index_cp
 
 	if {![lock_index update]} return
 
 	set update_index_cp 0
-	set pathList [lsort $pathList]
-	set totalCnt [llength $pathList]
-	set batch [expr {int($totalCnt * .01) + 1}]
+	set path_list [lsort $path_list]
+	set total_cnt [llength $path_list]
+	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
 	$::main_status start $msg [mc "files"]
@@ -144,26 +144,26 @@ proc update_index {msg pathList after} {
 	fileevent $fd writable [list \
 		write_update_index \
 		$fd \
-		$pathList \
-		$totalCnt \
+		$path_list \
+		$total_cnt \
 		$batch \
 		$after \
 		]
 }
 
-proc write_update_index {fd pathList totalCnt batch after} {
+proc write_update_index {fd path_list total_cnt batch after} {
 	global update_index_cp
 	global file_states current_diff_path
 
-	if {$update_index_cp >= $totalCnt} {
+	if {$update_index_cp >= $total_cnt} {
 		_close_updateindex $fd $after
 		return
 	}
 
 	for {set i $batch} \
-		{$update_index_cp < $totalCnt && $i > 0} \
+		{$update_index_cp < $total_cnt && $i > 0} \
 		{incr i -1} {
-		set path [lindex $pathList $update_index_cp]
+		set path [lindex $path_list $update_index_cp]
 		incr update_index_cp
 
 		switch -glob -- [lindex $file_states($path) 0] {
@@ -190,18 +190,18 @@ proc write_update_index {fd pathList totalCnt batch after} {
 		display_file $path $new
 	}
 
-	$::main_status update $update_index_cp $totalCnt
+	$::main_status update $update_index_cp $total_cnt
 }
 
-proc checkout_index {msg pathList after} {
+proc checkout_index {msg path_list after} {
 	global update_index_cp
 
 	if {![lock_index update]} return
 
 	set update_index_cp 0
-	set pathList [lsort $pathList]
-	set totalCnt [llength $pathList]
-	set batch [expr {int($totalCnt * .01) + 1}]
+	set path_list [lsort $path_list]
+	set total_cnt [llength $path_list]
+	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
 	$::main_status start $msg [mc "files"]
@@ -221,26 +221,26 @@ proc checkout_index {msg pathList after} {
 	fileevent $fd writable [list \
 		write_checkout_index \
 		$fd \
-		$pathList \
-		$totalCnt \
+		$path_list \
+		$total_cnt \
 		$batch \
 		$after \
 		]
 }
 
-proc write_checkout_index {fd pathList totalCnt batch after} {
+proc write_checkout_index {fd path_list total_cnt batch after} {
 	global update_index_cp
 	global file_states current_diff_path
 
-	if {$update_index_cp >= $totalCnt} {
+	if {$update_index_cp >= $total_cnt} {
 		_close_updateindex $fd $after
 		return
 	}
 
 	for {set i $batch} \
-		{$update_index_cp < $totalCnt && $i > 0} \
+		{$update_index_cp < $total_cnt && $i > 0} \
 		{incr i -1} {
-		set path [lindex $pathList $update_index_cp]
+		set path [lindex $path_list $update_index_cp]
 		incr update_index_cp
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
@@ -253,7 +253,7 @@ proc write_checkout_index {fd pathList totalCnt batch after} {
 		}
 	}
 
-	$::main_status update $update_index_cp $totalCnt
+	$::main_status update $update_index_cp $total_cnt
 }
 
 proc unstage_helper {txt paths} {
@@ -261,7 +261,7 @@ proc unstage_helper {txt paths} {
 
 	if {![lock_index begin-update]} return
 
-	set pathList [list]
+	set path_list [list]
 	set after {}
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
@@ -269,19 +269,19 @@ proc unstage_helper {txt paths} {
 		M? -
 		T? -
 		D? {
-			lappend pathList $path
+			lappend path_list $path
 			if {$path eq $current_diff_path} {
 				set after {reshow_diff;}
 			}
 		}
 		}
 	}
-	if {$pathList eq {}} {
+	if {$path_list eq {}} {
 		unlock_index
 	} else {
 		update_indexinfo \
 			$txt \
-			$pathList \
+			$path_list \
 			[concat $after [list ui_ready]]
 	}
 }
@@ -305,7 +305,7 @@ proc add_helper {txt paths} {
 
 	if {![lock_index begin-update]} return
 
-	set pathList [list]
+	set path_list [list]
 	set after {}
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
@@ -321,19 +321,19 @@ proc add_helper {txt paths} {
 		?M -
 		?D -
 		?T {
-			lappend pathList $path
+			lappend path_list $path
 			if {$path eq $current_diff_path} {
 				set after {reshow_diff;}
 			}
 		}
 		}
 	}
-	if {$pathList eq {}} {
+	if {$path_list eq {}} {
 		unlock_index
 	} else {
 		update_index \
 			$txt \
-			$pathList \
+			$path_list \
 			[concat $after {ui_status [mc "Ready to commit."]}]
 	}
 }
@@ -393,7 +393,7 @@ proc revert_helper {txt paths} {
 
 	if {![lock_index begin-update]} return
 
-	set pathList [list]
+	set path_list [list]
 	set after {}
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
@@ -401,7 +401,7 @@ proc revert_helper {txt paths} {
 		?M -
 		?T -
 		?D {
-			lappend pathList $path
+			lappend path_list $path
 			if {$path eq $current_diff_path} {
 				set after {reshow_diff;}
 			}
@@ -420,12 +420,12 @@ proc revert_helper {txt paths} {
 	# as they have quite complex plural-form rules. Unfortunately,
 	# msgcat doesn't seem to support that kind of string translation.
 	#
-	set n [llength $pathList]
+	set n [llength $path_list]
 	if {$n == 0} {
 		unlock_index
 		return
 	} elseif {$n == 1} {
-		set query [mc "Revert changes in file %s?" [short_path [lindex $pathList]]]
+		set query [mc "Revert changes in file %s?" [short_path [lindex $path_list]]]
 	} else {
 		set query [mc "Revert changes in these %i files?" $n]
 	}
@@ -444,7 +444,7 @@ proc revert_helper {txt paths} {
 	if {$reply == 1} {
 		checkout_index \
 			$txt \
-			$pathList \
+			$path_list \
 			[concat $after [list ui_ready]]
 	} else {
 		unlock_index
-- 
gitgitgadget

