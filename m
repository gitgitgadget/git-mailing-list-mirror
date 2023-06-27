Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A5EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjF0OmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjF0OmO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:42:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C5D35BE
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fa70ec8d17so50395555e9.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876890; x=1690468890;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmRGhfTFTgyv3gCMw9rHpmBd4iEYbjd9YzwQacRDRtQ=;
        b=sb4WxIGj2M/G5aB6cyeaVUcx+oaUXQXODEuE/bQJRPmtDInoHz3OjL6fhgIGG9HYY5
         iE7iZKckT2O7mr3xhWbLSyJOBjK8ICEKRNKxfgxavnUnyUcmOoiisabttR1zwvlc7elf
         0wwIeC5kAHTeKLM8KNCPcRQI2Xz/v61Cv/vSC4jSTI+e44UnwNQ/PyptHvtlkgOjGzsU
         +Tds8QkYX/Tu5tf/ki35Wpeg2HU7VCuidJP4KmtHVOaYsOnCoElksK1hyeoAfTbaQYud
         QjlCp9INr1HwRUEV+yukm+CF/xdFvt8I6KJo95WJ1NoLNnRsS09Zz6KTn0E/ev5WZ+ei
         qZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876890; x=1690468890;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmRGhfTFTgyv3gCMw9rHpmBd4iEYbjd9YzwQacRDRtQ=;
        b=FEqBqiY8jKX7YTNUzfWzdguuNat0icNt/lxzHvI56IrdTeTPhgLkB4hipffiklG1J9
         p56UfOvPLp/7+pgVjEysXfqDfij5fE1qpx2H9IxoRFkfEg2KF1OBU4pIIAixQcPszEd+
         XHSmUSC5HABhqg282GEJEQtv2ERadAE3ciZ3JqPZ5Z9yj1ceiUp3gLK1GRTlVdRKHKE2
         AF8Q24jOqmrcmQGEIMlnmuP7fu0LVvPko4ZIqLUaQsgICeOzy8aEQUOt0+Uk4jiMwaQk
         SpNOXi+L+thPe0jGqV8HSSRdT5m40RkKDDp6nLlE4Mv8esFpW9UBXZ6PsgOTLNZSGY65
         KLmQ==
X-Gm-Message-State: AC+VfDxp8xCi9LE/W+QkgpI99OO6/qwNyBsHRclBmeT1ST1X9xOtpo1x
        dOAXN9qz1rRcg9agJheq5K6toXGB+a4=
X-Google-Smtp-Source: ACHHUZ755JS2KZou1pMo4Xixrb7Bn5LCc6U0kUciieS0BW3HNdNs3wJHpXuT+Pi8stLM88mU9ybGfw==
X-Received: by 2002:a1c:f616:0:b0:3f6:d90:3db with SMTP id w22-20020a1cf616000000b003f60d9003dbmr29686213wmc.3.1687876890181;
        Tue, 27 Jun 2023 07:41:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcd15000000b003f8140763c7sm10965942wmj.30.2023.06.27.07.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:29 -0700 (PDT)
Message-Id: <53e5a2e40abbf81e5577b2f79588bd8b0be6e923.1687876885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:20 +0000
Subject: [PATCH 5/9] gitk: add keyboard bind for checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
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
 gitk-git/gitk | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index bfe912983f4..596977abe89 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2691,6 +2691,7 @@ proc makewindow {} {
     bind $ctext <Button-1> {focus %W}
     bind $ctext <<Selection>> rehighlight_search_results
     bind . <$M1B-t> {resethead [selected_line_id]}
+    bind . <$M1B-o> {checkout [selected_line_head] [selected_line_id]}
     for {set i 1} {$i < 10} {incr i} {
         bind . <$M1B-Key-$i> [list go_to_parent $i]
     }
@@ -2707,7 +2708,7 @@ proc makewindow {} {
         {mc "Create tag" command mktag}
         {mc "Copy commit reference" command copyreference}
         {mc "Write commit to file" command writecommit}
-        {mc "Create new branch" command mkbranch}
+        {mc "Create new branch" command {mkbranch $rowmenuid}}
         {mc "Cherry-pick this commit" command cherrypick}
         {mc "Reset current branch to here" command {resethead $rowmenuid}}
         {mc "Mark this commit" command markhere}
@@ -2732,7 +2733,7 @@ proc makewindow {} {
 
     set headctxmenu .headctxmenu
     makemenu $headctxmenu {
-        {mc "Check out this branch" command cobranch}
+        {mc "Check out this branch" command {checkout $headmenuhead $headmenuid}}
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
@@ -9978,25 +9980,26 @@ proc headmenu {x y id head} {
     tk_popup $headctxmenu $x $y
 }
 
-proc cobranch {} {
-    global headmenuid headmenuhead headids
+proc checkout {newhead newheadid} {
+    global headids
     global showlocalchanges
 
     # check the tree is clean first??
-    set newhead $headmenuhead
+
+    # The ref is either the head, if it exists, or the ID
+    set newheadref [expr {$newhead ne "" ? $newhead : $newheadid}]
+
     set command [list | git checkout]
     if {[string match "remotes/*" $newhead]} {
         set remote $newhead
         set newhead [string range $newhead [expr [string last / $newhead] + 1] end]
-        # The following check is redundant - the menu option should
-        # be disabled to begin with...
         if {[info exists headids($newhead)]} {
             error_popup [mc "A local branch named %s exists already" $newhead]
             return
         }
         lappend command -b $newhead --track $remote
     } else {
-        lappend command $newhead
+        lappend command $newheadref
     }
     lappend command 2>@1
     nowbusy checkout [mc "Checking out"]
@@ -10011,11 +10014,11 @@ proc cobranch {} {
             dodiffindex
         }
     } else {
-        filerun $fd [list readcheckoutstat $fd $newhead $headmenuid]
+        filerun $fd [list readcheckoutstat $fd $newhead $newheadref $newheadid]
     }
 }
 
-proc readcheckoutstat {fd newhead newheadid} {
+proc readcheckoutstat {fd newhead newheadref newheadid} {
     global mainhead mainheadid headids idheads showlocalchanges progresscoords
     global viewmainheadid curview
 
@@ -10034,12 +10037,13 @@ proc readcheckoutstat {fd newhead newheadid} {
         return
     }
     set oldmainid $mainheadid
-    if {! [info exists headids($newhead)]} {
+
+    if {$newhead ne "" && ! [info exists headids($newhead)]} {
         set headids($newhead) $newheadid
         lappend idheads($newheadid) $newhead
         addedhead $newheadid $newhead
     }
-    set mainhead $newhead
+    set mainhead $newheadref
     set mainheadid $newheadid
     set viewmainheadid($curview) $newheadid
     redrawtags $oldmainid
-- 
gitgitgadget

