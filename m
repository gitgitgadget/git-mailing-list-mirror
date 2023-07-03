Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460DEC30654
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGCSqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGCSqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717C8E6B
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3143798f542so1397867f8f.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409967; x=1691001967;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4JvxBrwYaFh1yT3A/0cUBoc5bh49ztZI4q2F+mtRUY=;
        b=duZ+1qyV2BTUP/ImPc/5XkHCzuJYtcpw6TrbxycVaVE+21z1ren8jvQzyULePdufB0
         67nlU1iwggQ929Guaj6Pgm2i5XO1sxhr+DkWIW+ZVr1BOkYkybfO2xm+fGDacXSxmZj3
         queBCIYLm7oLStzzQzoVFdCdcs+JCYJTdkiCbJmdComSP2w7XXAB9oP7PIUp9NmU/m7A
         4A3pRUAD9fzIyB0IwO9fTYLLSSxZkQNXdab9FOmXDnH+Y24jXfi205K/R1P4f+H6wKSa
         ynsElaDJJeB+iAsAN7+FRcP+WgiSpmoeRYHYYmvPlJ/ahFOQ1G28DfZE81dL0V39ik5q
         NSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409967; x=1691001967;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4JvxBrwYaFh1yT3A/0cUBoc5bh49ztZI4q2F+mtRUY=;
        b=NF2f1Kpv4hZOhoiDGyng0cwiNpzILbs1ictgdHRZQDIgK1duHBTnFEJlG6j99/r+M9
         iAF+1KxMc3DZmA3zLLCqqrRHF6ixtzbW07AJkszeQFJjj1fSOkoeDdQb44NaxZ7MPlm4
         +38570ScxpecRiuf83d3Fybta0Ko7iIolyaUKDwBylxeKW35zJyO7piZJLiGHuZpTrEI
         Ps5E/BbD8d+vKGR1DrrykiRMRIuWXut/L29HrzUasD6d2zHwWX0sfKfQT22fvefZtsTR
         7Z+9iZ9VQ/tM/5XOaD7qXeEqrXAzaBMJ/s9lHp3JPNOMKVn4OD4RMYBYgjY3ve2Rwv1W
         UqSw==
X-Gm-Message-State: ABy/qLYjdkOvrih0tIEG8WOcfCuCwlKR9Ns4y7v8H8cabkZi5OgKKbsw
        wkYkD4QSuIOT9U12rEMi+lXihlMNyDs=
X-Google-Smtp-Source: APBJJlEH6t4fbScexLbbyUexxT7MxJk4Fi5IblJkJzPjczvHwef5YNt1Preb71THLwfaKY2JzpJlKw==
X-Received: by 2002:a5d:61d1:0:b0:314:12c:4322 with SMTP id q17-20020a5d61d1000000b00314012c4322mr8460189wrv.4.1688409967568;
        Mon, 03 Jul 2023 11:46:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003fba94c9e18sm17772746wmj.4.2023.07.03.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:06 -0700 (PDT)
Message-Id: <aaca07db597d9eb870f3253887d30b3b38a9ea0c.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:53 +0000
Subject: [PATCH v2 05/10] gitk: add keyboard bind for checkout command
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

This also introduces the ability to check out detatched heads. This
shouldn't result any problems, because gitk already works with
detatched heads if they are checked out using the terminal.

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 125 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 27 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 642cd7f652a..8364033ad58 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2691,6 +2691,7 @@ proc makewindow {} {
     bind $ctext <Button-1> {focus %W}
     bind $ctext <<Selection>> rehighlight_search_results
     bind . <$M1B-t> {resethead [selected_line_id]}
+    bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
     for {set i 1} {$i < 10} {incr i} {
         bind . <$M1B-Key-$i> [list go_to_parent $i]
     }
@@ -2732,7 +2733,7 @@ proc makewindow {} {
 
     set headctxmenu .headctxmenu
     makemenu $headctxmenu {
-        {mc "Check out this branch" command cobranch}
+        {mc "Check out this branch" command {checkout [list $headmenuhead] $headmenuid}}
         {mc "Rename this branch" command mvbranch}
         {mc "Remove this branch" command rmbranch}
         {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
@@ -3183,6 +3184,7 @@ proc keys {} {
 [mc "<%s-minus>	Decrease font size" $M1T]
 [mc "<F5>		Update"]
 [mc "<%s-T>		Reset current branch to selected commit" $M1T]
+[mc "<%s-O>		Check out selected commit" $M1T]
 " \
             -justify left -bg $bgcolor -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
@@ -9978,25 +9980,93 @@ proc headmenu {x y id head} {
     tk_popup $headctxmenu $x $y
 }
 
-proc cobranch {} {
-    global headmenuid headmenuhead headids
+proc checkout {heads_on_commit id_to_checkout} {
+    global headids mainhead
     global showlocalchanges
+    global sel_ix confirm_ok NS
 
     # check the tree is clean first??
-    set newhead $headmenuhead
+
+    # Filter out remote branches if local branch is also present
+    foreach remote_ix [lsearch -all $heads_on_commit "remotes/*"] {
+        set remote_head [lindex $heads_on_commit $remote_ix]
+        set local_head [string range $remote_head [expr [string last / $remote_head] + 1] end]
+        if {$local_head in $heads_on_commit} {
+            set heads_on_commit [lreplace $heads_on_commit $remote_ix $remote_ix]
+        }
+    }
+
+    if {[llength $heads_on_commit] == 1 && [lindex $heads_on_commit 0] eq $mainhead} {
+        # Only the currently active branch
+        return
+    }
+
+    # Filter out mainhead
+    set mainhead_ix [lsearch $heads_on_commit $mainhead]
+    if {$mainhead_ix != -1} {
+        set heads_on_commit [lreplace $heads_on_commit $mainhead_ix $mainhead_ix]
+    }
+    set nr_heads_on_commit [llength $heads_on_commit]
+
+    # The number of heads on the commit determines how to select what to checkout
+    if {$nr_heads_on_commit == 0} {
+        set head_to_checkout ""
+        set ref_to_checkout $id_to_checkout
+    } elseif {$nr_heads_on_commit == 1} {
+        set head_to_checkout [lindex $heads_on_commit 0]
+        set ref_to_checkout $head_to_checkout
+    } else {
+        # Branch selection dialog
+
+        set confirm_ok 0
+
+        set w ".selectbranch"
+        ttk_toplevel $w
+        make_transient $w .
+        wm title $w [mc "Check out branch"]
+        ${NS}::label $w.m -text [mc "Check out which branch?"]
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
+
+        if {!$confirm_ok} return
+
+        set head_to_checkout [lindex $heads_on_commit $sel_ix]
+        set ref_to_checkout $head_to_checkout
+    }
+
+    # Handle remote branches
     set command [list | git checkout]
-    if {[string match "remotes/*" $newhead]} {
-        set remote $newhead
-        set newhead [string range $newhead [expr [string last / $newhead] + 1] end]
-        # The following check is redundant - the menu option should
-        # be disabled to begin with...
-        if {[info exists headids($newhead)]} {
-            error_popup [mc "A local branch named %s exists already" $newhead]
+    if {[string match "remotes/*" $head_to_checkout]} {
+        set remote $head_to_checkout
+        set head_to_checkout [string range $head_to_checkout [expr [string last / $head_to_checkout] + 1] end]
+        set ref_to_checkout $head_to_checkout
+        if {[info exists headids($head_to_checkout)]} {
+            error_popup [mc "A local branch named %s exists already" $head_to_checkout]
             return
         }
-        lappend command -b $newhead --track $remote
+        lappend command -b $head_to_checkout --track $remote
     } else {
-        lappend command $newhead
+        lappend command $ref_to_checkout
     }
     lappend command 2>@1
     nowbusy checkout [mc "Checking out"]
@@ -10011,11 +10081,11 @@ proc cobranch {} {
             dodiffindex
         }
     } else {
-        filerun $fd [list readcheckoutstat $fd $newhead $headmenuid]
+        filerun $fd [list readcheckoutstat $fd $head_to_checkout $ref_to_checkout $id_to_checkout]
     }
 }
 
-proc readcheckoutstat {fd newhead newheadid} {
+proc readcheckoutstat {fd head_to_checkout ref_to_checkout id_to_checkout} {
     global mainhead mainheadid headids idheads showlocalchanges progresscoords
     global viewmainheadid curview
 
@@ -10033,18 +10103,19 @@ proc readcheckoutstat {fd newhead newheadid} {
         error_popup $err
         return
     }
-    set oldmainid $mainheadid
-    if {! [info exists headids($newhead)]} {
-        set headids($newhead) $newheadid
-        lappend idheads($newheadid) $newhead
-        addedhead $newheadid $newhead
-    }
-    set mainhead $newhead
-    set mainheadid $newheadid
-    set viewmainheadid($curview) $newheadid
-    redrawtags $oldmainid
-    redrawtags $newheadid
-    selbyid $newheadid
+    set old_main_id $mainheadid
+
+    if {$head_to_checkout ne "" && ! [info exists headids($head_to_checkout)]} {
+        set headids($head_to_checkout) $id_to_checkout
+        lappend idheads($id_to_checkout) $head_to_checkout
+        addedhead $id_to_checkout $head_to_checkout
+    }
+    set mainhead $ref_to_checkout
+    set mainheadid $id_to_checkout
+    set viewmainheadid($curview) $id_to_checkout
+    redrawtags $old_main_id
+    redrawtags $id_to_checkout
+    selbyid $id_to_checkout
     if {$showlocalchanges} {
         dodiffindex
     }
-- 
gitgitgadget

