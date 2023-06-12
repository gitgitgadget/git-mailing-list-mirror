Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952F5C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjFLMx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbjFLMxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BBD118
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f78a32266bso43443915e9.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574387; x=1689166387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+/f/RVZomTkapsMngxop6R26fwIFTVcMJ/LWQ406iE=;
        b=dZ56MhV5/UuZqyIvSHvxMYhCjTUADUCQRGGj0iFVtJUTqwmQOGQu1Zmqkd9R12WLxU
         /9p6tlg1iFqX3yN7WaV3r6GvUJh0WL399oAzdxEmJwy9CPD1xDZTU4Kp9DhxFvz2WR2+
         Ax4pb7ztxDXPNJHa8ZZbT23fyVkVEv34WQsAn52nSv36avseWAATApT53Fmi+ZuRX1v9
         d25liVb+GQFRba68Bee0kF/a0CE5T+SaPAn/ysa/r/e8uJawsx8RjUy4lf1EbwoqV6YS
         lOWRjbbtRonleH/SvWfV+3dpZqaYCgU3cTM4ocNjKDtzJvTCg82+3cpOpiaWbcaom0q5
         UChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574387; x=1689166387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+/f/RVZomTkapsMngxop6R26fwIFTVcMJ/LWQ406iE=;
        b=EZCG5M6MPL9iSMrBUyB5elGp/P5GSjmtlFm95DU2inTp/gAdkp8PDdkBzy3NiGi5g1
         J5FaJZXTbVQvkFzU5SJ1kf/kE5CS7Ev0IuS43J1vECMzg4mGupoeG4YtoBEkA58aGuOP
         BQAtY0P5tulys1ZnBGNPOF6byeWDdp29AEQsSpCyL+iJ8RYpJDmvKXa1Mna1LjYpkw5d
         jA9ipmt1Tg2rJt5WPG9KFhcM9CM0tLbLgflXjDyqwLpUv+OYagNTX54J8fVLuCNybRgV
         6HCWU9PQL5lr2VpRz/Dy6w2ce9HfP88iueKHG+9IkcCiUPnpTdrve43U65cRK/vRzPWz
         XTqg==
X-Gm-Message-State: AC+VfDyluDGwCetPHs0kpZAAPqNLvi/hj2WL73wDLQCNSCdf+5AIeU6r
        JABzbVf9mh92wkN4tozk4eAdmr+gJ8E=
X-Google-Smtp-Source: ACHHUZ6wK+Uj3j0vWZY3oZPPt+nw3Tyo8GNfVs4uq784SA5SVieKeuoiwTNwHXFQeE1sgQSEOK8Q/Q==
X-Received: by 2002:a5d:69c8:0:b0:30f:c1c3:8173 with SMTP id s8-20020a5d69c8000000b0030fc1c38173mr1969302wrw.26.1686574387219;
        Mon, 12 Jun 2023 05:53:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15-20020adffacf000000b0030fb3ec9e46sm6417440wrs.45.2023.06.12.05.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:06 -0700 (PDT)
Message-Id: <560ad1cd0179f8615dadd8b252b5c3f8cef6822e.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:42 +0000
Subject: [PATCH v2 14/25] completion: complete --line-prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7246ced14ad..13d6730f33d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1757,7 +1757,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
-			--irreversible-delete
+			--irreversible-delete --line-prefix
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

