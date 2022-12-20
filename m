Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05EDC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiLTAgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiLTAfy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:35:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B930F6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:35:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso7685671wmo.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRyKBtVFUSsZz+7gjwjpM753NymGAbljoWelkpcw22E=;
        b=NGQ8H3Hfb6+61G8nvYM41RfFtIJMuKWsWGQT9zrSYMt5Rwsz48q27oT1sGUQwzUmhl
         befWtmRhaqAgG3KCFuByTm24oe6P/oDyvVrI9P9GXgLtpdMFhwmrHcfvapDTzkD5qR9p
         sPtElgjcYDCzk5rZh4AZPp+miukuythhmLpfZ72UTjXmPFtKBgvRSnYW3dp+4QfKMxpe
         69NoCraEsO6IkPtI0DzW8Ka8J0EcDxhosPDGGDUtJZBnGp/9WmQGC+5rosGiqTMqn9fc
         zGOnACkBo+1K9aA8PT86Y0nlTx+gAXVd3XCvPwSWOpPUvYMPm5rio9G2tYN3LijolWUp
         YhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRyKBtVFUSsZz+7gjwjpM753NymGAbljoWelkpcw22E=;
        b=CEmfukNpe2gEVuOXv49+qHT3TcFh5skVdu1QevsfuKfkA1uvgkQuCpth6g0WogDO2A
         BeTwk0bPP21ARV44Ih84XZz7lZz6iDZU1Rap5W47BVVJvBF1dcIc/rqV3crCYqZe+GWr
         GENmaFsOVIwLhrTiDnbLWDN44XfYCqTs1uttF/kwUHl8qFJMtmieman93gs1oUXUdVC1
         IQHno/6fmj0IMPAo0v7huw3udvYHRf/aCmEl7CDph7uVuT+p0eNoSn4RLD1VBuIcgE0L
         A9pEGC5vWkujhp600iURtqCAiP1Yfp0mvqUEJ4OZz9rI8eI7B7aO4h3yHYo7MRaVDmip
         6pzg==
X-Gm-Message-State: ANoB5pmJgyrQwgYLA8xOxshwVHjjRxn1IhJ0hqdkXKYOXpMkuJakFUUj
        bxa+f6+oYUsD1vMib62aScclXy+qcOU=
X-Google-Smtp-Source: AA0mqf5Z/l+5r04Tx71lQGvZg5kInjYII3dcLi3J3TiK1UFWYOyyedwf/uNU5optDjwvr5nUkG4miQ==
X-Received: by 2002:a05:600c:3512:b0:3d1:fcb4:4074 with SMTP id h18-20020a05600c351200b003d1fcb44074mr45316816wmq.22.1671496551471;
        Mon, 19 Dec 2022 16:35:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003d237d60318sm15114777wms.2.2022.12.19.16.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:35:51 -0800 (PST)
Message-Id: <aa8cd9409401a6407eb6f92bd161ba0562ff3fc8.1671496548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
        <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 00:35:47 +0000
Subject: [PATCH v2 3/3] ci (check-whitespace): move to actions/checkout@v3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Chris. Webster" <chris@webstech.net>,
        "Chris. Webster" <chris@webstech.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Chris. Webster" <chris@webstech.net>

Get rid of deprecation warnings in the CI runs.  Also gets the latest
security patches.

Signed-off-by: Chris. Webster <chris@webstech.net>
---
 .github/workflows/check-whitespace.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index 552894f736a..da557fd5914 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -13,7 +13,7 @@ jobs:
   check-whitespace:
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
       with:
         fetch-depth: 0
 
-- 
gitgitgadget
