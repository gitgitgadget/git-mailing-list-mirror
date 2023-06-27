Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D984EB64DD
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjF0OmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjF0OmF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:42:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEFE35BD
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e2fdd186so4027666f8f.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876890; x=1690468890;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWXefmHQ4saLUx3VcnUQf83Pww53JFkH6r2lyDyWbJA=;
        b=bPFtGmJUajI2ipn0cR14ke/MxOQM19iyz2U1hjK6w7qoLHlzGuWZASVbKW1Jiy6j8T
         k0d7ZS5ft0DLNUyCKoXXHlkuRVa5ENMDqEO9BbT9t2OrONy44ChoRhyt0f/WJKTBIRjA
         5OitxgtC6qd1l3PSBFC30K8RSUqndQpPOaw3gcl02KYPwTLp191qgkjPjVlJNpXJmvFP
         IlQV6g+gqo9omjOwOrUhwotY1m5HN9Gn6pCjZQFhcpqMe5DRktaLDvBr1t8BBkwIwoBO
         Ka2fW5fG36zx9oCFAyLDGONqmJDtV8+nfqPG1dyQvphaxiVQX0T/DEwaph3P6lOcZHEK
         t/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876890; x=1690468890;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWXefmHQ4saLUx3VcnUQf83Pww53JFkH6r2lyDyWbJA=;
        b=cmDJGoVGrv4a/dqRGYM2HW3ryfx7vMzoG+rYlfO0focsPPSrwa7XKzNpLM3bsEOPjR
         CPxQX7/kUg8AbgJHRUhlVkV4i3RuGhqRpT6BMdgjSrQ8H2P9fJRi22AX+BGm/P++C3RC
         IuEuo4gDIWpkBf/cob7bJ89mMbxoysnhGlkBT+bGjdPvWX8l1Y/NdyhiMPuUOoDZUAK7
         7n49S9a2IuI+EqaiWajQh8jEj57fsRbHuU4Ko4rykM00GHs2eZZqInjexXGAFe5DQtZs
         bqF/mc3aPkdSBzyasn9LKZ3MAy4ckRCHNvqLceFI9GVvM+ZL4qex8Afpzu/2evkCB7uK
         7Ddg==
X-Gm-Message-State: AC+VfDxduNNxZv+JWLS+mxsDq9aQO/Uc8M7bqlBdnEDOqAqRaU2eRsFq
        PtPWDAgyq6KVqYxSJZC4H3bL347x/+U=
X-Google-Smtp-Source: ACHHUZ7fkspctYY02KMOd/GL/+JniKgBEx69EjmpAwtC7HAZ0v1QVczM/NcNJD7Fxvegq/gOgGxHvQ==
X-Received: by 2002:a5d:424d:0:b0:313:f2c6:a4f1 with SMTP id s13-20020a5d424d000000b00313f2c6a4f1mr4713640wrr.36.1687876889691;
        Tue, 27 Jun 2023 07:41:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11-20020adfdd8b000000b00313ecd3714csm7768968wrl.19.2023.06.27.07.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:29 -0700 (PDT)
Message-Id: <8594e2cc68a9b2d3dad1832dbc46d3718c68f84e.1687876885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:19 +0000
Subject: [PATCH 4/9] gitk: show branch name in reset dialog
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
 gitk-git/gitk | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 99c6fb6a848..bfe912983f4 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1351,6 +1351,21 @@ proc selected_line_head {} {
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

