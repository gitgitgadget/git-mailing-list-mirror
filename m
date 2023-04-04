Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B26C76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjDDBXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjDDBWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:22:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E8E2D53
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so20536156wmq.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoMJ9cVwb/ZvflFcl5pAhOAsWQBn3D0Pm7GwOWGmO2I=;
        b=l4Qap++IiravqWHSlq12WAqR0Afeyl/w78b5x1BjqcL3tq22JuPCoshKVKYb8t2uLn
         bKesNG1utMhjVGvfdiOzQJgamd3HOv20fWK63EGtkU1KFrZtfLSQFzxdJiLvM1ZT99Jb
         Nyndaw56sAZlD2bLxTkKnV6OMx3u9ylZlTcX4dMgk4vyoLHa49CE/4bSi6RkY3kEv9dB
         Zn/XAa1s9dNeLSZK+47Clejk3J8/jXjR9ShTaEb2op1rADNwWcPZCSQyxKsVSTHYHjZ5
         5cx9T0k8IGvPWXrPSpa/apmp4w9l7fn7dYjSe5hsN/bhEem4Wfv2pok8FDKBw94da+4Q
         kpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoMJ9cVwb/ZvflFcl5pAhOAsWQBn3D0Pm7GwOWGmO2I=;
        b=lTjkA5jq/v6GMHQXochPcrPZ2yBbFmKaJuAy5TjSBHjouHi/Q+XTmEpxwVr6gySd6v
         1SkIEX9eF1O8FBVbcp8HIAcZ3KPJHulWKagO/KwZNErnMZKzwvwnG3N5sS/XlpeaWfci
         xtyEExmwgza3+oqRfjDQEhFPF51xhRyCregpksnXBKRSkBxtOtXjGJxjPpXUdBiP7Eoq
         uOUHmn+vimR1OZICOKESQcvUSwkdvlPi+ndVL/t+X8TrDwLHJpVEN3yHqGN+ipfj+nV3
         5NvCTQVgzO1dwMWAh380abVN4bnyf/sqglUuCRswgLRAraW1FzltaiaI+rnLCo+lm1PT
         BXUg==
X-Gm-Message-State: AAQBX9f1eBGw2uHn5fo/z91CrlCdaDUC9GGGgWjptEKe7Zk0HU7XQzhm
        cOHyOYTS93uMemPLjWM45aZeosY7acI=
X-Google-Smtp-Source: AKy350YNjIyBf05Rzrqmt75QnE8aYLG7gL8EnRUNmB8GgeZ+XXBAMCa/dzxkVrLnINpzEdlUZ1W0Qw==
X-Received: by 2002:a1c:7716:0:b0:3ee:67ff:4aad with SMTP id t22-20020a1c7716000000b003ee67ff4aadmr767258wmi.26.1680571362442;
        Mon, 03 Apr 2023 18:22:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c00d500b003ee4e99a8f6sm13515777wmm.33.2023.04.03.18.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:42 -0700 (PDT)
Message-Id: <dbfe03129e3073f57a13c23dd697eb4785c5e3be.1680571351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:15 +0000
Subject: [PATCH v2 11/24] treewide: remove cache.h inclusion due to git-zlib
 changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This actually only affects http-backend.c, but the git-zlib changes
are going to be instrumental in pulling out an object-file.h which
will help with several more files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 http-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-backend.c b/http-backend.c
index d41b3b9e1e7..ac146d85c54 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
-- 
gitgitgadget

