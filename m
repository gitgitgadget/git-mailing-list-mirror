Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C1EC77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjFFCId (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFFCI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B8B116
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso56220275e9.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017306; x=1688609306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue53EZBCMKFJaY0oPdIPR+2S73vx8SmmOg6dfRJBTj0=;
        b=TqWY7eE/vXWtA6ROf10i2aKO11V+YlE0M6A2n5K4vpYTkbWR8fo5KMZq8qiQYMF2qN
         1rwBeN+22JAWOpRhZkQVQNGy+Hrj1Cg8OXHVPOzRFJ+vKgfFudqo8Dt04DHi4rNukqye
         nIbAzI8vHJRRvEQAaFQ95HJOBknOAxpJqqgbCy0eOBUm6DFyoTspbV6Sdm2gi9xcC7H0
         JscNQ49+XkIWuM/7ptAq/qSOYKiDDL4F58V1Gsbvlk8YcMFoCsHnhdPiiZ73pG3gzUQO
         /xxtz6zyiTK1TEagYPp0fG6sz0lBxPeJuMjRrtRf9k3vZXGHzgMLhLIUNsJWp/7mopEF
         73tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017306; x=1688609306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue53EZBCMKFJaY0oPdIPR+2S73vx8SmmOg6dfRJBTj0=;
        b=D52BzLtAl9HU/g2BqzzSJ0Qo2exzYHuP/uFZu79pTR6xFpE1y3sGuET5vWHsWEaea+
         A5aqnea6mXPEJjPm2k3WneQN7FOH0VrCGJZE4JiN4gHACYZZduoUfhyRWvyF4xCPHxt5
         /p+rxZYm0gaZYycVABHkaDVG80HuP9zq8uhqx2KlLQk5AhzrACAKvXvC6gPFNlLGy/Iu
         J7avFSNs9/ZEcteKUp/VbcxOMgCG6iRQmkJ9QuJ3gEt9Voun8UxgAZ1iVKxxufHrAuub
         XtQNXSpb/GevTegaozkiyJlxvpjauj0w3BE1i91+Nrx62vGPTJLNBdNOy1rGSPFr8z3T
         IBYA==
X-Gm-Message-State: AC+VfDx6QrXqJl+11QjlfX9ucyirwxfjhDI3cU+IuSkPrULLvn5QxN+f
        NMkekYhEhehpPYuyvk7s+caBxnX8A5I=
X-Google-Smtp-Source: ACHHUZ4g2Z79Vhft2Jk7ve1CL2NOoyQvIAaz70EZYnh5yMA4TTJwEX1hrsTXPXinL5Yx2dcD0tZT2g==
X-Received: by 2002:a1c:750e:0:b0:3f7:a80a:c676 with SMTP id o14-20020a1c750e000000b003f7a80ac676mr796466wmc.39.1686017306323;
        Mon, 05 Jun 2023 19:08:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b003f7cb42fa20sm4586897wmi.42.2023.06.05.19.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:26 -0700 (PDT)
Message-Id: <65386432ca4a8a41acdb4f061a8ca6a8f02d289b.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:17 +0000
Subject: [PATCH v3 2/9] doc: trailer: swap verb order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

This matches the order already used in the NAME section.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 35faf837892..da8fec7d5fe 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Parse or add 'trailer' lines that look similar to RFC 822 e-mail
+Add or parse 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
-- 
gitgitgadget

