Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EEBC38142
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjAQXf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjAQXe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3F4DBE0
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:25:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t5so27579931wrq.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=owEwADRFHuU+8npNjB9EeHHTN13pdUYZBa9cWkXwvVQ=;
        b=He+6o7gXnpAgilxSi/knIGEthr2t8rxoDcYtNH+6k0HrJJk/z3ELlJg4DOSJA/FmIr
         T9o36NFJv/k+FxI8RzbX/dHsxh2cgIC51cxYiqTw6Zw7NrpYemEmVKxOW152sky7qf0S
         ySKrgDqIihp1bcY9TwuV4SZ3qKivOnpHNaWrt9K2C4Z/LbDrTCk+M0M8VbZWwON/QeSX
         eXNRTwBO+n2ZlNnEfPvjH3RzCt7yd7v7qQJ7T90JYXVUzevI0ZlvE5V7MIkjQAYZ+/BT
         Mf6b8pJ+hbDnPnmiyEYDkIi1E757QxsHex9hAg9LANuOgCOPD+1grQYw5wrfJlUZ9hY4
         hBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owEwADRFHuU+8npNjB9EeHHTN13pdUYZBa9cWkXwvVQ=;
        b=peCCQiiqKjiTKGbdCfVhYGlJ2f5GoUKFMzaeTfI1F9rOUmYWv+eT6Kss2wiGQdQoWb
         ub3Al6oJp3qyBluMRz6k2V7SQN5g4ODWMaE0qf61Cbq9L6cVqR54MngKufR8udzsiIha
         ziUzWwV5Tf7sttCI7tfPGuAaHt8wSS1Bk0C3tNdxoZa+Hn94bVxQkj285czQDBzCsSCZ
         fP2g1eOpTs6yIa2512z0oV4324vPjxN93p1OgIIoAhW3Tx36TMavjZSbiKjqucnTPmUc
         hNQFaROhKsMyOzpzz0Ne0hrTxY1kkTsli156qdFqZuByA7hJTEBLU9N9AIfxSdIbVEg4
         98rg==
X-Gm-Message-State: AFqh2kohATwbIR/SZLcKW+czBy9EhDNEiqaCAOpfNv6MAeiHoBZaIKeP
        dmiIaKiwPZ3fdwZEude1ISBBh43matE=
X-Google-Smtp-Source: AMrXdXtPvV9ugiI+++A2wrETCIaXRiKeOjTTOB73ThiQlAMt9eNXUvi/V69Zg5MIKdc3vw4NdrW/qQ==
X-Received: by 2002:a5d:410b:0:b0:2bc:7fdd:9248 with SMTP id l11-20020a5d410b000000b002bc7fdd9248mr3816960wrp.9.1673990757249;
        Tue, 17 Jan 2023 13:25:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020adfdec2000000b002b9b9445149sm35599467wrn.54.2023.01.17.13.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:25:56 -0800 (PST)
Message-Id: <pull.1437.git.git.1673990756466.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 21:25:56 +0000
Subject: [PATCH] fsm-listen-daarwin: combine bit operations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    fsm-listen-daarwin: combine bit operations
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1437%2FAtariDreams%2Fdarwin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1437/AtariDreams/darwin-v1
Pull-Request: https://github.com/git/git/pull/1437

 compat/fsmonitor/fsm-listen-darwin.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 97a55a6f0a4..fccdd21d858 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -129,9 +129,9 @@ static int ef_is_root_renamed(const FSEventStreamEventFlags ef)
 
 static int ef_is_dropped(const FSEventStreamEventFlags ef)
 {
-	return (ef & kFSEventStreamEventFlagMustScanSubDirs ||
-		ef & kFSEventStreamEventFlagKernelDropped ||
-		ef & kFSEventStreamEventFlagUserDropped);
+	return (ef & (kFSEventStreamEventFlagMustScanSubDirs |
+		      kFSEventStreamEventFlagKernelDropped |
+		      kFSEventStreamEventFlagUserDropped));
 }
 
 /*

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
