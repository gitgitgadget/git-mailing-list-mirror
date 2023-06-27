Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3992EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjF0Omq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjF0Oma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:42:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA233596
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:42:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fa96fd7a01so27819705e9.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876892; x=1690468892;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qaYi+K5OhF4RahYkxc/5xaenw/adsZGzEPGSyzzc8Q=;
        b=bUIUfsP9zN+lnstICCxS5azx8hYGZGEvut1F6q0FJ7q+ZdjJdCwQcCz8BDiQMpl9KM
         TnLJ7J35NKR1gadMC7LSWFyo98hooQqomCP3iGknEgtn+EJsVVyWPPYsQRKCcjQ8YBaG
         27VwPrlYCg7v9qJqxcFp04Mo/y0mszz8UgbGMRyiBJXJYL93R19BCIy2isN6qKzdSj9c
         GOACZkux3CxFg8RhObtaEbqqsvztDQX/kFX41sZZJzHmcBtvPeJnXUpNvOyXI/gUGLdw
         ZWk2uTbKVFvkzkZw5K/DPBW2YLOMWj5v/azvlnJAXJ91s/ms8G+A7My1o8CHsPqcZadT
         LKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876892; x=1690468892;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qaYi+K5OhF4RahYkxc/5xaenw/adsZGzEPGSyzzc8Q=;
        b=W0LEIsZ4EMhcW+sx5EKpZ2PMXx0BQJVYhqQ0ib5kWIARFYw6XiLbMNIhKbzbvT84A1
         NEmrYd1/83AjoTwDECXrbVV7qy8HUR2HL+rLkU1c2u9C5kB4zkIc5Gbf60wW1dOGHo3e
         1g0I0YJs2vujCcu20b4X3sQY3sklZXnYXPLM3q094oN2Vow0Zb0ySHVH9F94Gt8XjW8t
         oAe9f9f5Vlgq1o0YlRgYcMkBenuBZyia35IVM/Ye+pEE70GxcNhXSVYhYJf49P5Cw+Sj
         vGe6/Q5z2VfsWKouz2MheUYSXd77Z2/7bTIZ5VcvfVSasUQNCwxJVObNM03041iYjGjR
         dNBQ==
X-Gm-Message-State: AC+VfDzxq4w/sFdZSuJrXgW3+58alyr+LDIMuva8slHtCEYNbbNjPflm
        rMf1hou2rCXiauRKTjWawKoAq8rbjgc=
X-Google-Smtp-Source: ACHHUZ7XuuvG+NbQGNN0leLdABueot+WzqRQKzDvuBMw/piPCaXZf7XIvSBBM/SVJCSbObD+PVR7Lg==
X-Received: by 2002:a05:6000:1008:b0:30f:c1f5:e91e with SMTP id a8-20020a056000100800b0030fc1f5e91emr27542416wrx.27.1687876892549;
        Tue, 27 Jun 2023 07:41:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a056000011200b00313f9085119sm3329855wrx.113.2023.06.27.07.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:32 -0700 (PDT)
Message-Id: <97857c3509fb4b45e1bc2d29588374a2631a7c2d.1687876885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:24 +0000
Subject: [PATCH 9/9] gitk: default select reset hard in dialog
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

Reset hard is dangerous but also the most common reset type, and not
having it pre-selected in the dialog is annoying to users.

It is also less dangerous in the GUI where there is a confirmation
dialog. Also, dangling commits remain in the GUI and can be recovered.

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9d93053e360..5b0a0ea46be 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9906,7 +9906,9 @@ proc resethead {reset_target_id} {
         [mc "Reset branch %s to %s?" $mainhead [commit_name $reset_target_id 1]]
     pack $w.m -side top -fill x -padx 20 -pady 20
     ${NS}::labelframe $w.f -text [mc "Reset type:"]
-    set resettype mixed
+    # Reset hard is dangerous but also the most common reset type, and not
+    # having it pre-selected in the dialog is annoying to users.
+    set resettype hard
     ${NS}::radiobutton $w.f.soft -value soft -variable resettype \
         -text [mc "Soft: Leave working tree and index untouched"]
     grid $w.f.soft -sticky w
-- 
gitgitgadget
