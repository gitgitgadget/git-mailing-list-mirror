Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEFDEB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjF0OmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjF0OmP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:42:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263363A94
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9b4a71623so44851395e9.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876891; x=1690468891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtZwrPQ71zSACQlxu1MCT7jaXoY0dh6FWGHeBrjCUh0=;
        b=Rc2v3feW8yS8MAqi3yuYojKsjrC8plxCkyENfEJlzIt8hDyQwC+tfxsvLla956jOl9
         D0L8msw//31UAatjmgs2xWyscSTxHLFNQucFWaUOoqyxzE2GhZVVI+a8kMmoOvr7rGpX
         qCKTWQ5Kb7C+6XSsQzQICAtZ4cBEpoYKAveoviHAElXRUuGf8TA0iHrKj0+awpfZgGFv
         QQSXuRXQlWWCuerVd3ys4i+eY4k1BunNjNehkkeFOTY6AvM72ceMcQXm/kgi7cDpKL4n
         vIMljO6nOH33CqZF7CLUfLVvoDtqoglrunMO0KxBidnHH3zKtkK/wbyiiWpKMjlplzrJ
         a/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876891; x=1690468891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtZwrPQ71zSACQlxu1MCT7jaXoY0dh6FWGHeBrjCUh0=;
        b=RIcZgOnpPmXjWUfU2DPEWJVlDfBK5+V9O7bx6PMIkuAwbh2lTsywPXfhH+7bhM8S1h
         O1b9LsKA79Y78nxEsvN5if2701M6CldfwGrHU8Xy/cax7TLXJc0STaEGKjG+Jl8AJqzP
         wxIOssnjCFSmo9r0UIp5/Ks0lh7rtd5w+Ko+xp4ckV8vogeXju+cUIc9p3+TlbWIzFrt
         8UIWgAAtB6swxZdLv/cOC+wU6uDzGghEGzgPjvpY45CJ1ld8iJ8V97s3eOkrASzNXUgT
         comuGCNsQ/XJN2EOZfdpDQ7VDhL4hRHMSrdltRH/BLjsMvRQxni+5zN4bg6LCHjFKha8
         gkDA==
X-Gm-Message-State: AC+VfDwLNz2I2mvY1+Z72D0D/9GorBWaRuakjoNqnvujvLSXYXtUeOVd
        EVZAIIFoHHoib/4w/f552v6WWkBwHZo=
X-Google-Smtp-Source: ACHHUZ406lEeojlcgsnENBYOsIdCrJTRLq7h8NIm2BNOAWXWsTg4etAr/yVbX7BUomZw9ad8d5c4Ug==
X-Received: by 2002:a05:600c:ac1:b0:3fb:a5b3:4f02 with SMTP id c1-20020a05600c0ac100b003fba5b34f02mr1412000wmr.36.1687876890978;
        Tue, 27 Jun 2023 07:41:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12-20020a7bcd8c000000b003fa79af15c7sm14043778wmj.2.2023.06.27.07.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:30 -0700 (PDT)
Message-Id: <661f098d882e64391ff76647e3764d58c6cbb50a.1687876885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:21 +0000
Subject: [PATCH 6/9] gitk: add keyboard bind for create and remove branch
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

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 596977abe89..0d83a72a424 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2692,6 +2692,8 @@ proc makewindow {} {
     bind $ctext <<Selection>> rehighlight_search_results
     bind . <$M1B-t> {resethead [selected_line_id]}
     bind . <$M1B-o> {checkout [selected_line_head] [selected_line_id]}
+    bind . <$M1B-m> {rmbranch [selected_line_head] [selected_line_id] 1}
+    bind . <$M1B-b> {mkbranch [selected_line_id]}
     for {set i 1} {$i < 10} {incr i} {
         bind . <$M1B-Key-$i> [list go_to_parent $i]
     }
@@ -2735,7 +2737,7 @@ proc makewindow {} {
     makemenu $headctxmenu {
         {mc "Check out this branch" command {checkout $headmenuhead $headmenuid}}
         {mc "Rename this branch" command mvbranch}
-        {mc "Remove this branch" command rmbranch}
+        {mc "Remove this branch" command {rmbranch $headmenuhead $headmenuid 0}}
         {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
     }
     $headctxmenu configure -tearoff 0
@@ -3185,6 +3187,8 @@ proc keys {} {
 [mc "<F5>		Update"]
 [mc "<%s-T>		Reset current branch to selected commit" $M1T]
 [mc "<%s-O>		Check out selected commit" $M1T]
+[mc "<%s-C>		Create branch on selected commit" $M1T]
+[mc "<%s-M>		Remove selected branch" $M1T]
 " \
             -justify left -bg $bgcolor -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
@@ -9576,13 +9580,13 @@ proc wrcomcan {} {
     unset wrcomtop
 }
 
-proc mkbranch {} {
-    global NS rowmenuid
+proc mkbranch {id} {
+    global NS
 
     set top .branchdialog
 
     set val(name) ""
-    set val(id) $rowmenuid
+    set val(id) $id
     set val(command) [list mkbrgo $top]
 
     set ui(title) [mc "Create branch"]
@@ -10054,13 +10058,14 @@ proc readcheckoutstat {fd newhead newheadref newheadid} {
     }
 }
 
-proc rmbranch {} {
-    global headmenuid headmenuhead mainhead
+proc rmbranch {head id shouldComfirm} {
+    global mainhead
     global idheads
-
-    set head $headmenuhead
-    set id $headmenuid
     # this check shouldn't be needed any more...
+    if {$head eq ""} {
+        error_popup [mc "Cannot delete a detached head"]
+        return
+    }
     if {$head eq $mainhead} {
         error_popup [mc "Cannot delete the currently checked-out branch"]
         return
@@ -10070,6 +10075,8 @@ proc rmbranch {} {
         # the stuff on this branch isn't on any other branch
         if {![confirm_popup [mc "The commits on branch %s aren't on any other\
                         branch.\nReally delete branch %s?" $head $head]]} return
+    } elseif {$shouldComfirm} {
+        if {![confirm_popup [mc "Really delete branch %s?" $head]]} return
     }
     nowbusy rmbranch
     update
-- 
gitgitgadget

