Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC871C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 02:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1D12073C
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 02:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMHq6yOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfLAC2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 21:28:38 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36921 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfLAC2i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 21:28:38 -0500
Received: by mail-wm1-f44.google.com with SMTP id f129so19048688wmf.2
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 18:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sbqQKPFLwqefjSeatY3TgmSApYsc1DIwXSJjnSoXqzg=;
        b=PMHq6yOt2YnSyrynKe+y22/Ku1xXXoaL3xMgxt5F8AjCPxqqkcDgocK3luMBhQ5GfA
         mHEvDJYHghQ/zy2/on5WCOx3++AFfnvdGJBK9ZoRfBcHJrcJqnWtMEid0wVTSEsV4+ge
         kc1KGw74eIq31cL3WTyqy433DvjbFkCemWMkCRuo27qWnUlI/MwO6Nj88TggpB1TuoKI
         tapIzkJu7MnfMu15gVPys92T6nClDIRkPC1Wu10i388HP2Nm5t/LNbOeAu6CLI2x4WJ/
         qdOzIULejVoBTTmJjF2aLuGuYeEOC0Glflvp++10gCDaTnoXMOXTDrbRtQGDCN6GKodn
         zGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sbqQKPFLwqefjSeatY3TgmSApYsc1DIwXSJjnSoXqzg=;
        b=Jise8KRMvAm1ALZ802Sw8nG8DpQ+rCZdfmpjWzavqg6YAccQ7O23Dniv6RwY+NSKX+
         tF8fMRsUZPQ1UBDuAEb5TfES602Eggq0OFXthdTvaRMxeDxGuMxAv8Vd401+PzcMW824
         vTX9TEIuQMuNAt4sdtFrdkuKVfimDwuzVZw9kIgi4ryp7PjLfAeAMRwYczxVDH4oFNSd
         qC+AgrBnF3Xgh9kj0X82oWOHrkgiQClr0mpWBmVtLE7lO0JnvZiKvodgDhRUKwy9lCW0
         NeD6GoTXSFOy7qll/r5kq5+lvH0zxJ9JtFMe/3W2pMFrwtwl6OnUCMaaJN0u1Y6va2LV
         pzqw==
X-Gm-Message-State: APjAAAU7hevt1HiqRh+Ytz+OQWr2jwkOvPAEdJjlxIK4utDynknJ+Ixc
        YNDASn1nerCYOQh59dKTiWaQF0P2
X-Google-Smtp-Source: APXvYqxJmR/gZ2twuuJyoCrmimz/iHZUjj0P2t8EIe8qVg4v+/UOhTlxt1MPwNwg9JTXgQd2tylZ6Q==
X-Received: by 2002:a1c:964f:: with SMTP id y76mr18470184wmd.62.1575167315304;
        Sat, 30 Nov 2019 18:28:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x125sm4476079wmx.43.2019.11.30.18.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2019 18:28:34 -0800 (PST)
Message-Id: <da1704c56e0bd3f1ac53af96b702e3777bb3eb37.1575167313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v7.git.1575167313.gitgitgadget@gmail.com>
References: <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
        <pull.436.v7.git.1575167313.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Dec 2019 02:28:31 +0000
Subject: [PATCH v7 1/3] git-gui: consolidate naming conventions
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

