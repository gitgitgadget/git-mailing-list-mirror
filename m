Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997A3E95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbjJHGpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbjJHGpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F37B106
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406650da82bso31945085e9.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747537; x=1697352337; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDrhrV4z17i3udi3dHche1kNhiU5sBKhDqHpMXWYj5k=;
        b=hnzAwVeunYo0J3s28nGYe9Z0ieG1+gCmq04/vBS1fWK05nnGTTSDBaM3v53715g7yP
         QO4jtnKXdEcSkHdUNbNMcqc36oJHvmUi7jnaZ8EURwjdzub+bHDEmS/CB3+bM4KNsWoa
         EjCBGQBZWp15YwEQUkduh4Aldjl0+OXRmUbukaHsS9DlByfIrOCXwBBK4x97CA5BovxT
         UBOkN0Lzciuei4QK8S8Cty2q+8R/PqWY6qkSsY5g41td+Bo2QPVfiBfrHQGIy6C5gb5+
         zrAIsQN9hCSSurj5WywLYy9dwENr3QuUSg3rV3jjHvDI9scb6crd1kl6DOOlt3bQ6ACL
         uAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747537; x=1697352337;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDrhrV4z17i3udi3dHche1kNhiU5sBKhDqHpMXWYj5k=;
        b=upypOt8Ve8C9PAB/jA5cKHa4LOqFtK0RoHRX+yqx5g8dkvUWL77zEKV/7d++RxeYEY
         1xOSLrWwTaHhcta3gzNO5rRTtYH4ELYf2OntVUvZnNUYw2ljccwaFUA7ZotUTkoBo9SG
         BPi65kDHIv5uTG0SiDHKzv3bbQuqlSxZ49akDPjlq11QXb4X1jYWR8s1L+2fyxzkzQNj
         ds9ckLuPXh16oEDzc4IyRQNUbeYcXXste6QXlcRabzcYlqRM8eOx2qcw0Nbyah99UcSt
         zVKMh+xzPCooJ2IRHv1iWBeXx+XhuJlGdvdOQPgU2eVfOOvfRlSMF+hZcL/hNyVTYI+C
         mzig==
X-Gm-Message-State: AOJu0YwwUC0PwXZkjTLLYZJ98V6aIuojXejRqkck3ULjepvxtxQMnyjA
        edkyuwSoQUxC0OAl7qNJ2x0ouRuKh1c=
X-Google-Smtp-Source: AGHT+IE0caGo4hw/rQ0ITkTGYeWryOYIWFp3Py9ZxG8n7OidRVzL4Z5LTRHI4e7MV3p36wmWJ7gy+g==
X-Received: by 2002:a7b:ce98:0:b0:401:bf56:8ba0 with SMTP id q24-20020a7bce98000000b00401bf568ba0mr10850465wmj.28.1696747537071;
        Sat, 07 Oct 2023 23:45:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b004054dcbf92asm7773258wmi.20.2023.10.07.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:36 -0700 (PDT)
Message-ID: <b218a1e66d009d66f83bd605102aee79883fa7e1.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:12 +0000
Subject: [PATCH 10/25] documentation: fix adjective vs. noun
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/commit.txt b/Documentation/config/commit.txt
index 2c95573930b..bcb46cf630e 100644
--- a/Documentation/config/commit.txt
+++ b/Documentation/config/commit.txt
@@ -25,5 +25,5 @@ commit.template::
 	new commit messages.
 
 commit.verbose::
-	A boolean or int to specify the level of verbose with `git commit`.
+	A boolean or int to specify the level of verbosity with `git commit`.
 	See linkgit:git-commit[1].
-- 
gitgitgadget

