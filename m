Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C774C30657
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGCSqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCSqU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362410E3
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so6717881f8f.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409972; x=1691001972;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDFB1jORtZqFJS+PJgbVTBw0Cf+tDMHMXYxy4dooTDk=;
        b=ktBB+cqbUoWVH0EzNgriBcAaeSK0n8kArLmQAUSVvjIQrlzOUDCpOtfn6Q6GBWOFHi
         WxNDKdJPgqQxtKcmN/kP9uoDQ+EsY/ouB6sqD62AcUEQt3dRayaR07Vmyk03NAVz76V4
         Zl9QbCFW55VIyqCTEErvSacBPhr1uNe5l6UY8yZXcBQeGVilP5p90ug/46iiVCJDL6rZ
         nwR0X5ypmse27/rFKIFWeuLqg8tEQLTBTWwb79bDvr+ZrZh6ANmZteKRSpdwiymirizt
         DkO5nIG7V9XyUkjMxaxHVbkFLjfzMPoazrLA9VixTmLsXnGiLTZquyj6/m7qQrX9GA4x
         Mw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409972; x=1691001972;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDFB1jORtZqFJS+PJgbVTBw0Cf+tDMHMXYxy4dooTDk=;
        b=fK6qOEmG+v9IvrdtyzjpcGel/mP29RXp//uBCysjk05XtMOZY9Kq5MWTdqyY21iR/D
         zmPGBnZALE8Ugtff1MjgcVMCkQCPXuCD94POIlkfI0etmOYRS6QyzK+sJfwpTqnX77/9
         euLxcaY5P6il6/Ktom7tjvv2GH+j6PXAcp3JmtEfZGx9K2Zvy76sFMh64f8Ax4XQCLqa
         +ALnJT3yv/25kWWQb0AZ1+Rk94g9pjxJyDECGw7WzQblxg8FxKln7Zmrby/Pex3UZ3I7
         JqJvFbjRRJrXZoUES5Hm/hyytoS3jq/t7HFgwJzQUjb9npKj/6eKvvH2E4fwqYWtJ/kK
         xTaQ==
X-Gm-Message-State: ABy/qLa/vtwq6TBkfbMd1IkIQXyJIlqhaNdyu3848lFmfZJ0g9tLp3S9
        pR/32SijoenoDSYGqo7jOtnwKopnReU=
X-Google-Smtp-Source: APBJJlFN6ngBUu4GOEdQW1VHG9WpxFGpodtUN6xvVvXrjXKQe92tXT3XxJrTbwg3z6l4tuFShB9Q+A==
X-Received: by 2002:adf:e4c1:0:b0:314:37ac:c896 with SMTP id v1-20020adfe4c1000000b0031437acc896mr4936353wrm.44.1688409972289;
        Mon, 03 Jul 2023 11:46:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe345000000b0030e5bd253aasm26232315wrj.39.2023.07.03.11.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:11 -0700 (PDT)
Message-Id: <a37a677036df9fd515201174897af4c16c69f45f.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:57 +0000
Subject: [PATCH v2 09/10] gitk: improve keyboard convenience in reset dialog
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

Make it more convenient to use the reset dialog using keyboard.

* Set focus to the combo box.
* Accept with Return key.
* Auto-select combo items when navigating in menu with up/down keys.

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f559e279b7a..fafff2b1a5b 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9902,27 +9902,40 @@ proc resethead {reset_target_id} {
     ttk_toplevel $w
     make_transient $w .
     wm title $w [mc "Confirm reset"]
+
     ${NS}::label $w.m -text \
         [mc "Reset branch %s to %s?" $mainhead [commit_name $reset_target_id 1]]
     pack $w.m -side top -fill x -padx 20 -pady 20
     ${NS}::labelframe $w.f -text [mc "Reset type:"]
+
     set resettype mixed
+
     ${NS}::radiobutton $w.f.soft -value soft -variable resettype \
         -text [mc "Soft: Leave working tree and index untouched"]
+    bind $w.f.soft <Key-Up> "set resettype hard"
+    bind $w.f.soft <Key-Down> "set resettype mixed"
     grid $w.f.soft -sticky w
+
     ${NS}::radiobutton $w.f.mixed -value mixed -variable resettype \
         -text [mc "Mixed: Leave working tree untouched, reset index"]
+    bind $w.f.mixed <Key-Up> "set resettype soft"
+    bind $w.f.mixed <Key-Down> "set resettype hard"
     grid $w.f.mixed -sticky w
+
     ${NS}::radiobutton $w.f.hard -value hard -variable resettype \
         -text [mc "Hard: Reset working tree and index\n(discard ALL local changes)"]
+    bind $w.f.hard <Key-Up> "set resettype mixed"
+    bind $w.f.hard <Key-Down> "set resettype soft"
     grid $w.f.hard -sticky w
     pack $w.f -side top -fill x -padx 4
+
     ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
+    bind $w <Key-Return> "set confirm_ok 1; destroy $w"
     pack $w.ok -side left -fill x -padx 20 -pady 20
     ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
     bind $w <Key-Escape> [list destroy $w]
     pack $w.cancel -side right -fill x -padx 20 -pady 20
-    bind $w <Visibility> "grab $w; focus $w"
+    bind $w <Visibility> "grab $w; focus $w.f.mixed"
     tkwait window $w
     if {!$confirm_ok} return
     if {[catch {set fd [open \
-- 
gitgitgadget

