Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE7C30654
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGCSqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCSqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086EAE6B
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3141c3a7547so4943665f8f.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409966; x=1691001966;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o63RomnzmNxA3DU2tI6V9hbmIzeolgnsK9dWlohK8I=;
        b=BuR0hUiPqpzUDg5S2wWha6Oj1bWX7AHu4drRpV7tk1cgncnGAizW49d5rn+yA17oso
         yIjKgtAdFr1lUKdP8VRS2eoZXHJF/lHq9/g0pjZSs7mqJlggn/2Qv1zlFW3L1Y81vRfN
         4NosFEwFOLQiUbQxykcy8k3hlqA3XFlZ+Op/tg7g9GK0q2Dp+Lf4lmlfQAfi5zjVT2aj
         VV66p9za+vcn7BMO5l5qeSeVAxkGIcPG9pjQa7sjVS8y3pFwBXXk54lrs61CxGBL2KCw
         wh3aBqM/NyzuAkmtS3y5fhdYp1/CdI0yB+cfc+D6+uxl5QP45xsEXKWi8yY2KwScLBOC
         rU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409966; x=1691001966;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o63RomnzmNxA3DU2tI6V9hbmIzeolgnsK9dWlohK8I=;
        b=U5W+VpwYele0zcdgibWUl4+ZZAQCnFdsDF2AhWq2U6ZMjg40PpA5C/Mjvs8WS4ShQI
         EHeSfq9xznVCi4T92lDNL1QRtVkqFotpjKOdwUznry84H9Cy9XJSssoLeTMuVOzZ84A1
         eC3f0dYImQD2bQ2vKkC2nI4lE/keAX96D+gZljTPCHVDPoBoJHnTw2o11h4vCyNyZMUc
         GxHOejilPF4FApyxtClSGIzarNIksg2nBqU4HydjmnPBJGNNapd88fqNcRrvlJlBj3+W
         muxi8ejC+ziOtfhdi2A+4ksPvm7ePck6lb4WMiy9wpxIBhg9aH/APFeuiXRcViIzIER2
         B+lw==
X-Gm-Message-State: ABy/qLZcyww4qJGQyqcjvt4OpPv9Hyc4CtJ5JUz5J90nYbyHRdBEbPxE
        f9mCN6V8M4lzbadVzVDMpLJYQ2zaT6A=
X-Google-Smtp-Source: APBJJlGEWTrMapmkItPSaW7yxktFV1Jw2jKoFddDFpe8kFffvOje1C+ukM8MSmFHkw3jCwV8ELAIvw==
X-Received: by 2002:a5d:456a:0:b0:314:1c89:8118 with SMTP id a10-20020a5d456a000000b003141c898118mr9611898wrc.52.1688409966298;
        Mon, 03 Jul 2023 11:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020adff481000000b003113ed02080sm26066298wro.95.2023.07.03.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:05 -0700 (PDT)
Message-Id: <bd261e702f6ad96d11641306900a8a624ccb1931.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:52 +0000
Subject: [PATCH v2 04/10] gitk: show branch name in reset dialog
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
 gitk-git/gitk | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 3d4bfa5f1d8..642cd7f652a 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1351,6 +1351,21 @@ proc selected_line_heads {} {
     }
 }
 
+# If any branch is associated with the argument ID then return that. Otherwise
+# return the ID itself. Useful for displaying the best name of a commit.
+proc commit_name {id should_shorten_id} {
+    global idheads idtags
+    if {[info exists idheads($id)]} {
+        return [lindex $idheads($id) 0]
+    } elseif {[info exists idtags($id)]} {
+        return [lindex $idtags($id) 0]
+    } elseif {$should_shorten_id} {
+        return [string range $id 0 7]
+    } else {
+        return $id
+    }
+}
+
 proc closevarcs {v} {
     global varctok varccommits varcid parents children
     global cmitlisted commitidx vtokmod curview numcommits
@@ -9875,7 +9890,7 @@ proc resethead {reset_target_id} {
     make_transient $w .
     wm title $w [mc "Confirm reset"]
     ${NS}::label $w.m -text \
-        [mc "Reset branch %s to %s?" $mainhead [string range $reset_target_id 0 7]]
+        [mc "Reset branch %s to %s?" $mainhead [commit_name $reset_target_id 1]]
     pack $w.m -side top -fill x -padx 20 -pady 20
     ${NS}::labelframe $w.f -text [mc "Reset type:"]
     set resettype mixed
-- 
gitgitgadget

