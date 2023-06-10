Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC7AC7EE29
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjFJUVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjFJUVf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C2A3AB9
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30af56f5f52so1940596f8f.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428488; x=1689020488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGhLXXBoQ6UI1vHMOyV7YwVlIGSV+5Rfv8inY3ASxdE=;
        b=L2VHsGXiCvxUsBDwlFa2dTVOjbhQoZtzVazjo8sHiCjEOOvXewNO7ddFcLRGvYi4Jm
         BK5E0/+cVvdN5iGqrbtQ0+gTaS2lpXaQU9GgfjLFuLVV+gjQoEMp5PcxXZfEp/gdGZVR
         6TssTSH/QacRkcbLyLtUFgnyV+nsaX5SK4KHpYsitnevoA5Sco4lmF4IhgyfUr0bIMDn
         v35ALbZpEOHsWYAmuMk4rZRpFDcwMLlXVYlcD+nfxOZp9s7cBD83d/LdnzxiRIPEod2I
         mnE8RJK4xJDBi/C6I7fUwviRYZxOeV/2Jnj1xkbNmFrJtD3pP/oiCMfjpaQef/N6QnPs
         pUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428488; x=1689020488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGhLXXBoQ6UI1vHMOyV7YwVlIGSV+5Rfv8inY3ASxdE=;
        b=KgvhnsM5ZMkUfZC1Vk+7OGQICK6C1vln/Ps73Bv6eFSZTgQKRLbyQKIyam7Er6iHaO
         8JfGDMInSqDoXUUkpn/3vNeLL3xo2kxZuT88C1XoUjGVUzVDRVKMmwJVvBI7DYr+E63i
         H7jTaIcuMjqVjHVS8Wf06z38AaiaNsmryS251IGozhTvpCt22dBtYbNghUJBdf2q/j5F
         MgxKDN4E2nGwnGTr5vLpsutR8u3l6uRcBfCyljRzbRCGl8ciQrKqSVApsabMN/VIcl9K
         rez55/CbR/cv3Pe/R8IAcbkP/DSN8VGAclY1jz5UNedD/iMj10QwlCXdaxihhWie9Ds+
         rKBg==
X-Gm-Message-State: AC+VfDxh9RdO5PLl4Ri6rKFn2/kz/uoDFRZZPCh1X4JVEvxobI2a0d0H
        Ju58PE4vF3pbwuwrZNyffAOypggdyL8=
X-Google-Smtp-Source: ACHHUZ4bXCerI1ljQnjZsF1HGSdw2ZgNMCx+Me/ZKZPwNF7A1fjQ5qlDVgVRnIpuTrbdAPNYR50Faw==
X-Received: by 2002:adf:e792:0:b0:30e:3f55:ebcc with SMTP id n18-20020adfe792000000b0030e3f55ebccmr1723119wrm.44.1686428487562;
        Sat, 10 Jun 2023 13:21:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14-20020adfe30e000000b00307a86a4bcesm7912832wrj.35.2023.06.10.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:27 -0700 (PDT)
Message-Id: <1f3c9e8d417d2c9f16583da7609e8f322059f1f1.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:01 +0000
Subject: [PATCH 02/25] completion: complete --break-rewrites
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
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
index 90fe292459b..f07b00b9c68 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1753,7 +1753,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--diff-algorithm=
 			--submodule --submodule= --ignore-submodules
 			--indent-heuristic --no-indent-heuristic
-			--textconv --no-textconv
+			--textconv --no-textconv --break-rewrites
 			--patch --no-patch
 			--anchored=
 "
-- 
gitgitgadget

