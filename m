Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F17C7EE29
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjFJUWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjFJUVn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17D43A97
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f732d37d7cso29588245e9.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428497; x=1689020497;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C4+Z+JYxHOHgPNO9HRTisJPCa1ZLhtMUtS+8PzVvZc=;
        b=pkpLYDBstnDG5JOp7Mf8lSY16VZQ5Zj/UkxOeocKc4Vk1kyEcXkRP8eHDef6T4ORHV
         VWbdPLAs3qtLeIr3ROtOiWK3QWawtOKOZx4rMk1Bu30CqrFrpUJ/gnn+P8d4mH+ILXib
         ZxWbbjt5gul8FVXr9d29yEtusSwXuYyBWSHkyMudoLZvOTXHpMDlzyUA58rRcxM0dW9x
         W8MndqMAEYaEOQcKBkSBVIblMcTqQExtJDJ3h51rtCq1xDmbDD+m4o1Ljspcq8V6tkW5
         k9E4ABx2MVeI/gZ8fQBVcVslt5aSf328fhhhpZqfBEqjhQI2kasCZUFZlgZngaHQ/2pR
         lXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428497; x=1689020497;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C4+Z+JYxHOHgPNO9HRTisJPCa1ZLhtMUtS+8PzVvZc=;
        b=gcwfDCkaCEf1sLvEvGU1ly4NYlA6gjlvfYrxjq9VOSc8IM8kmotVSsQGOC//7DUu8/
         4htAx7Asi7irfjXwr5gupcqtlt0eAwLEufnEWQRr7iNCO522JtAhnMuKpQYKxz3PPjxX
         u2IQzrbS+MPK5Xpk8n9CpwX9URJeELri/a0AFlOrUVk10uwnlu3CQAFlIctqJwVWnhYT
         3yLlQ9JhjKKa03FR0iueQU0NdnUqVNc0RB04JltqgSI1mdIUR2nhQsbj35D/sW8DqQ/h
         9tZJKQHwM3WeI7Q/jZTOEpp7I4ccRQ4frlOfa7lVgByUqq1XMW+jo2CPbEkFIx4erY9v
         KfIg==
X-Gm-Message-State: AC+VfDxezeIjIlqET+1fM4RMq6MIf17BS3xHV8RJGT1LgSLCUDyR7IsL
        ugweNqXZ18+Vvg0VU++9RL2+FZrzm5c=
X-Google-Smtp-Source: ACHHUZ6jTH6xf1egpQkngbUKD274ucF9ePQKeX8ufu3SjpZOhN8Yo0Y+yl+5dPUVssn6s9li6F6/iQ==
X-Received: by 2002:a5d:5450:0:b0:30f:bbec:216b with SMTP id w16-20020a5d5450000000b0030fbbec216bmr103379wrv.65.1686428497127;
        Sat, 10 Jun 2023 13:21:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d4387000000b003064088a94fsm7911298wrq.16.2023.06.10.13.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:36 -0700 (PDT)
Message-Id: <0f16a466fd9bdafe0365ee9cf1bce81fc11767d1.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:15 +0000
Subject: [PATCH 16/25] completion: complete --no-stat
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
index f4e773cb997..ec2e4c9e711 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1758,7 +1758,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
-			--irreversible-delete --line-prefix
+			--irreversible-delete --line-prefix --no-stat
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

