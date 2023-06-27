Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639F8EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjF0Omo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjF0OmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:42:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3F3582
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so6481959e87.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876892; x=1690468892;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht+rV4DcAqrleOOAnzY385skI4mRGjd7B+agaw/btfM=;
        b=MWk7sW92c68dbWnuj9W1mnxQlioHEG+Uv7xQeRwrmWQ4djwXgvftCkzR0gBsqs0NZK
         WvRDxaWf2PRHEc/x+HKWhChzPPXlRQZa1spWO9e+d9Ca8+PnhySwWylBCEf/HYKETwga
         xWBSzLcsfJRyexSeZgKQMqvGL0wB1I4DtbjNgO7GDUTcwEAvNJ7nRhxAA9yo0rRc3xIo
         dzrII2Tk5kIHfcWO7BmX3MhdOc0Qa8j5FSi0TPfKuFuk6RV184ArjzZlCPiRNlYQXDPD
         H6/4401Cpx8MHKv8Sbyw5Dw3toTsaUGoR2fM7HknsvGe5m+oksU0vYEzbQkvHr5HTvtr
         hukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876892; x=1690468892;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht+rV4DcAqrleOOAnzY385skI4mRGjd7B+agaw/btfM=;
        b=Q6K/7n3vAaWmVjyDFod7ljgZsvsDQV5pwQsMWra0y9/TpRE4WK9vqVdjPfuzczurlD
         Ozl52K1UJPEiK0hqvsMSEo/VwXYLK6k7foxFpKSJ/FUYUV5KRomb7kDGKdiOe4gcwe9s
         q40AMKPAoYVnJfHyNvyc+a2Sz8jiGqDnuGtejN2SFQXmnz//I43n5WLR6mCg7muwMIeF
         hC7tAnS98FwXxqXAQ4F8zXZ2XIpi0lcjVeb0oV7RrwTg0rM0+9O2V2MjCnvWb4DeoBYf
         L6/n8Da8Nhskz5nsrZ3bywzbEAkEUAL4cYc8sk5NG+KCxyZnUPt+SwxysYWt9FBQxjTL
         ysBQ==
X-Gm-Message-State: AC+VfDyqHTfTN79haaF7D9y7IbCfGt1YYWzBFTWJkN5+fHRfajATaHRR
        I2JpBEXo0jSmo/7Z1xHCibzD45pmld8=
X-Google-Smtp-Source: ACHHUZ426BXfw3Zli8yCsC3KRb0jjt8EqoIFrQ+HHikqvtESWkvARRxs7vFXAE67cE7viy9Ayo/8DA==
X-Received: by 2002:a19:500f:0:b0:4f8:6533:3341 with SMTP id e15-20020a19500f000000b004f865333341mr16619853lfb.20.1687876892086;
        Tue, 27 Jun 2023 07:41:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fb225d414fsm4621719wma.21.2023.06.27.07.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:31 -0700 (PDT)
Message-Id: <49cdbff270f30f91418dde5c704836f51e1e4f61.1687876885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:23 +0000
Subject: [PATCH 8/9] gitk: focus ok button in reset dialog
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

This is more convenient for users, especially when using keyboard
commands.

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5b01d1902a5..9d93053e360 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9922,7 +9922,7 @@ proc resethead {reset_target_id} {
     ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
     bind $w <Key-Escape> [list destroy $w]
     pack $w.cancel -side right -fill x -padx 20 -pady 20
-    bind $w <Visibility> "grab $w; focus $w"
+    bind $w <Visibility> "grab $w; focus $w.ok"
     tkwait window $w
     if {!$confirm_ok} return
     if {[catch {set fd [open \
-- 
gitgitgadget

