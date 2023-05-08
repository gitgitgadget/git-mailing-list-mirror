Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E24C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjEHR2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjEHR14 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:27:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366B3125
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f19a80a330so31869055e9.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566873; x=1686158873;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJ9IddLFLfBJHdF5fhs+lemvgsA+gHJ00ne7pVHGufg=;
        b=O95Us8t3X00R3EkM/Qj1C1T2eoewnEdViy7hbUi6jghQorS98K26higGaMq11GTPdr
         QI9d7u/qjOnjx///PiDDjaASJTc/4RB4j7nMldbA4ibhWYdK2EO5/3YaS0oG2FdODojk
         GQg5EoPStFQqttfrtUOw3Eg9b1aWpCZSMeIK09/tARmmNmHZPmuIlNZ1oAAvhBMGAx7w
         gKkzCEv+3XCF2hXhky6NlvRxESrKbk8vt+9k+LGBa2Hy1TZiShlxU8vzWc1n27P6qO7L
         H/WYv7v02d09kGnVR+RPOUF5teQJuuqoqR1wL+GnuOqe2m/9F37LRrWehHW6rOYE8Gdd
         sPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566873; x=1686158873;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJ9IddLFLfBJHdF5fhs+lemvgsA+gHJ00ne7pVHGufg=;
        b=bFdIdAdIgNbeZk+dmMO3Vl0w53OmN/7ppfKPeOtSscy+HF73tJbobVJtRUu9VCuEyS
         zyWGRj0KBzoqMN4q3SrIUokjRCTulgPwOIMFIV80I5yvoYCs/MiTu/odNHEiYPTeri44
         3AHNT0bHYdIJqa5vrZ5qT87ya3RN/odoKJBDOkw0kZvxfLLr5rCg1AfUguAZrKWjdbCZ
         HwXrAjHl0/+cin7lHytxd0+RpehlLp4N9l39q3vU6DFUh3xbxqDYePFe98VXG/ibU7HQ
         GJLMSJ9BEbPRPk0ayKMCIWya1bAGhmlwy3KYTnV7G8UcZlwZVJSurbdjotJFFzNKpnbK
         YguQ==
X-Gm-Message-State: AC+VfDxsDm4hnGonpdJz/KRFlbH3Oq2ApI40dvbX6+i6/smEDZxU58uU
        Vu4PWJBGPY5TpI9K/FIQJU4lkwExNUU=
X-Google-Smtp-Source: ACHHUZ55+vgCCVW/xfkJYG0/7K5mTetz/pM8raz6kLQqC7KrH/aQR0WSBGNLb/uxbmRFWgJXOoTE1A==
X-Received: by 2002:a5d:460c:0:b0:2f2:9198:f0f with SMTP id t12-20020a5d460c000000b002f291980f0fmr8371953wrq.10.1683566873556;
        Mon, 08 May 2023 10:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17-20020a5d6051000000b002e5ff05765esm11877799wrt.73.2023.05.08.10.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:53 -0700 (PDT)
Message-Id: <ad2d669eb0a6ba1f98af064089ef981c50546958.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:42 +0000
Subject: [PATCH 03/11] doc: trailer: --no-divider: more precise language
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

This uses the phrase "commit message part" instead of "commit message".

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 593bc1a1f4e..3e60a6eaabc 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -131,7 +131,7 @@ OPTIONS
 
 --no-divider::
 	Do not treat `---` as the end of the commit message. Use this
-	when you know your input contains just the commit message itself
+	when you know your input contains only the commit message part
 	(and not an email or the output of `git format-patch`).
 
 CONFIGURATION VARIABLES
-- 
gitgitgadget

