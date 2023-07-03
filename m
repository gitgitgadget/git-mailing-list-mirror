Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D92C001DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjGCSqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjGCSqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2AEE7D
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso4536699f8f.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409969; x=1691001969;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GUrptHoVTFEgRhXabHiZK3OpHzPjidMc29mRakemE8=;
        b=AJB/OfxuEwGcxiYGnYnew7c7Y2PJ4kjp9jvuhfBJRAMV8LYC+zWpLoJY5//JgPbf76
         L/NvyNFTUA+0zeXCV1ezp4F/93WG6rPBGrk8xW01iIX5fjkBqMidb9J0ThF8ckKDF5ou
         W+UQZudQoBbIGvAqK7H+YkAJkuKoFuR/7S5T2i9tPnYnXIXWMiFLn4Mbd5eNEN84HHRz
         NyMRjYA7ysIfmsEjWYBc2CrlP6aTP7PNRdQeHIOCqrvQbC+NFauzpELMzjNZZNKEmOzu
         2rTfk0xBfZQgyfp3xkJvBw64J94w48fwYALjarv39CpSL7Tz694WLjoEkUK/WLHiBRF1
         TVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409969; x=1691001969;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GUrptHoVTFEgRhXabHiZK3OpHzPjidMc29mRakemE8=;
        b=g6o1yQTZZtRhAFcmHh+jvnILFiDY00HogUp6/OrjCfJ+qeKX0ZVCpzyCTyk/HI3JVB
         29Ul+ihyYTwle+cUhXT1FSeI91J2QNQYTm+x8mCI68uwrnuWilHH9kZlRE+lE+1HbeBe
         ryJ7yfINzZrdv4ix+hzOsY50ksl2OSXDtZnKuM4uB9lShCN1Q/CzjzIHezaV6107pQw1
         8RZp1NOAD1yfD1DYv/59nwEoporKJeqB59kjjL1fU4dE0B+wi6UJc1IUTSqF5KJlivOB
         +n5lOQBxyMo1MUIefW3DmY7vQjk2H9MZURNz8GhQPJg3v9822rlRV/c5tQcYQC5+h8kk
         bEig==
X-Gm-Message-State: ABy/qLZnV745VT+GSxo2C1FlfkJ+JCmFnY2Lhh8tJ6xNRJJ5QnPciGt+
        F3/aGbWU3kd8rz0H6Zxif+j2XLLs42c=
X-Google-Smtp-Source: APBJJlGI4NE+2a0vl7APPKnKCRjMxSHQ98ryO74pNm6juHX565sHzbHzut1LqfZgo8SaEwlS6BMVVA==
X-Received: by 2002:a5d:4989:0:b0:313:f61c:42b2 with SMTP id r9-20020a5d4989000000b00313f61c42b2mr9162255wrq.69.1688409969030;
        Mon, 03 Jul 2023 11:46:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d6dc1000000b00304adbeeabbsm26237092wrz.99.2023.07.03.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:07 -0700 (PDT)
Message-Id: <ad6617a7badfe1d3ac252d9faabbe21b2b0f65f8.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:54 +0000
Subject: [PATCH v2 06/10] gitk: add keyboard bind for remove branch command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom <jens@lidestrom.se>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jens Lidestrom <jens@lidestrom.se>

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 104 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 15 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 8364033ad58..65ca11becca 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2692,6 +2692,8 @@ proc makewindow {} {
     bind $ctext <<Selection>> rehighlight_search_results
     bind . <$M1B-t> {resethead [selected_line_id]}
     bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
+    bind . <$M1B-m> {rmbranch [selected_line_heads] [selected_line_id] 1}
+    bind . <$M1B-b> {mkbranch [selected_line_id]}
     for {set i 1} {$i < 10} {incr i} {
         bind . <$M1B-Key-$i> [list go_to_parent $i]
     }
@@ -2735,7 +2737,7 @@ proc makewindow {} {
     makemenu $headctxmenu {
         {mc "Check out this branch" command {checkout [list $headmenuhead] $headmenuid}}
         {mc "Rename this branch" command mvbranch}
-        {mc "Remove this branch" command rmbranch}
+        {mc "Remove this branch" command {rmbranch [list $headmenuhead] $headmenuid 0}}
         {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
     }
     $headctxmenu configure -tearoff 0
@@ -3185,6 +3187,8 @@ proc keys {} {
 [mc "<F5>		Update"]
 [mc "<%s-T>		Reset current branch to selected commit" $M1T]
 [mc "<%s-O>		Check out selected commit" $M1T]
+[mc "<%s-B>		Create branch on selected commit" $M1T]
+[mc "<%s-M>		Remove selected branch" $M1T]
 " \
             -justify left -bg $bgcolor -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
@@ -10121,32 +10125,102 @@ proc readcheckoutstat {fd head_to_checkout ref_to_checkout id_to_checkout} {
     }
 }
 
-proc rmbranch {} {
-    global headmenuid headmenuhead mainhead
+proc rmbranch {heads_on_commit id shouldComfirm} {
+    global mainhead
     global idheads
+    global confirm_ok sel_ix NS
 
-    set head $headmenuhead
-    set id $headmenuid
-    # this check shouldn't be needed any more...
-    if {$head eq $mainhead} {
+    if {[llength $heads_on_commit] == 0} {
+        error_popup [mc "Cannot delete a detached head"]
+        return
+    }
+
+    if {[llength $heads_on_commit] == 1 && [lindex $heads_on_commit 0] eq $mainhead} {
         error_popup [mc "Cannot delete the currently checked-out branch"]
         return
     }
-    set dheads [descheads $id]
-    if {[llength $dheads] == 1 && $idheads($dheads) eq $head} {
-        # the stuff on this branch isn't on any other branch
-        if {![confirm_popup [mc "The commits on branch %s aren't on any other\
-                        branch.\nReally delete branch %s?" $head $head]]} return
+
+    # Filter out mainhead
+    set mainhead_ix [lsearch $heads_on_commit $mainhead]
+    if {$mainhead_ix != -1} {
+        set heads_on_commit [lreplace $heads_on_commit $mainhead_ix $mainhead_ix]
+    }
+
+    # Filter out remote branches
+    foreach head_ix [lsearch -all $heads_on_commit "remotes/*"] {
+        set heads_on_commit [lreplace $heads_on_commit $head_ix $head_ix]
+    }
+
+    if {[llength $heads_on_commit] == 0} {
+        # Probably only current branch and its remote branch on commit
+        error_popup [mc "Cannot delete branch"]
+        return
     }
+
+    set nr_heads_on_commit [llength $heads_on_commit]
+    set first_head [lindex $heads_on_commit 0]
+
+    if {$nr_heads_on_commit == 1} {
+        # Only a single head, simple comfirm dialogs
+
+        set head_to_remove $first_head
+        set dheads [descheads $id]
+
+        if {[llength $dheads] == 1 && $idheads($dheads) eq $head_to_remove} {
+            # the stuff on this branch isn't on any other branch
+            if {![confirm_popup [mc "The commits on branch %s aren't on any other\
+                            branch.\nReally delete branch %s?" $head_to_remove $head_to_remove]]} return
+        } elseif {$shouldComfirm} {
+            if {![confirm_popup [mc "Really delete branch %s?" $head_to_remove]]} return
+        }
+    } else {
+        # Select branch dialog
+
+        set confirm_ok 0
+
+        set w ".selectbranch"
+        ttk_toplevel $w
+        make_transient $w .
+        wm title $w [mc "Delete branch"]
+        ${NS}::label $w.m -text [mc "Which branch to delete?"]
+        pack $w.m -side top -fill x -padx 20 -pady 20
+        ${NS}::frame $w.f
+
+        set sel_ix 0
+        for {set i 0} {$i < $nr_heads_on_commit} {incr i} {
+            ${NS}::radiobutton $w.f.id_$i -value $i -variable sel_ix \
+                -text [lindex $heads_on_commit $i]
+            bind $w.f.id_$i <Key-Up> "set sel_ix [expr ($i - 1) % $nr_heads_on_commit]"
+            bind $w.f.id_$i <Key-Down> "set sel_ix [expr ($i + 1) % $nr_heads_on_commit]"
+            grid $w.f.id_$i -sticky w -padx 20
+        }
+
+        pack $w.f -side top -fill x -padx 4
+        ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
+        bind $w <Key-Return> "set confirm_ok 1; destroy $w"
+        pack $w.ok -side left -fill x -padx 20 -pady 20
+        ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
+        bind $w <Key-Escape> [list destroy $w]
+        pack $w.cancel -side right -fill x -padx 20 -pady 20
+        bind $w <Visibility> "grab $w; focus $w.f.id_$sel_ix"
+
+        tkwait window $w
+        if {!$confirm_ok} return
+
+        set head_to_remove [lindex $heads_on_commit $sel_ix]
+    }
+
+    # Perform the command
+
     nowbusy rmbranch
     update
-    if {[catch {exec git branch -D $head} err]} {
+    if {[catch {exec git branch -D $head_to_remove} err]} {
         notbusy rmbranch
         error_popup $err
         return
     }
-    removehead $id $head
-    removedhead $id $head
+    removehead $id $head_to_remove
+    removedhead $id $head_to_remove
     redrawtags $id
     notbusy rmbranch
     dispneartags 0
-- 
gitgitgadget

