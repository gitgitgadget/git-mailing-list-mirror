Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471CFC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiCYT2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiCYT2H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:28:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC881E95E0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:01:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r64so4956014wmr.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=G7PGFBpFC4tm3i1KP72gdNk2duNe9L5HqCAtkEk9LQU=;
        b=Z0iMTbVawwzweRU4BzQ1pbFGUDs0bvTSAn7yKcU77fKnZ5d+rT76PWqEKFcL92HmF9
         kN9aqnkz06QuuQzyP52/YLAODM2sOuONSHIULpQagrY5EzAdOQfzbdgg/p9ndTdHaP0N
         SY9mezROXucsCLOBcozhNSRtJCLItuB+ZSUl6Ejo+DvZOyIrEkkWGFQ5orqI/vSf7woR
         0UYRYmg/WRzFq2hyERvY4Hn8wAqGJdrurbZDMr/Yva82g7wD8m6QNivSF/yorpwXnrPg
         eApO/VErE5s4V2sNYxONmN3y8xR66PmJ8uOWNQWNtMikjFgTWALyY2YPHNMJj9Liqn5n
         wF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G7PGFBpFC4tm3i1KP72gdNk2duNe9L5HqCAtkEk9LQU=;
        b=Do+o+gUKONmNRfbwMi8yjV+9GUbt/fVJxZBJxut94E32xpHlk5/+AQiPogQpQT7z40
         m+IXK5P5bfzyFRRMMrOFMkdJCar35PbpCEzTy8HNDyYaOtLAO7JX9KS14SC/OWxXM7i4
         sq8L99+TfHZSxWzoSVG5+/Y3/Ad0qwFhkqgCZP1isjRZ7JtxJDhJSw5Avsn1tID1XiTW
         8XmPufremI5OWN3atfrnm6i6oER60Kd2Y6fDXOsZK4CVQQgLmw7E6szz0M0kD94FOpNH
         9pfPlNOs3T1kxafCjyZJgwjvTtToWIf6Xx26W4SU0Jf+1Ggz3O1wmETxS5WSH8ti+6fI
         L/pA==
X-Gm-Message-State: AOAM531RhTWhzWvGrgRoWSRLjgK2udOGyAE6sMQnTXSEkAmbLe7/LekM
        Ye6c91nK5TdXQ1pzugiOapkPv2MpQU8=
X-Google-Smtp-Source: ABdhPJxuc23yFAsNZ5sYz3cMs9xon8KM4qObIcUS3AxNMliFsZLDd/egXKuZu/8Ro9yQSfUxbVjUIg==
X-Received: by 2002:a05:600c:3b8c:b0:38c:b365:7220 with SMTP id n12-20020a05600c3b8c00b0038cb3657220mr11087093wms.120.1648231505450;
        Fri, 25 Mar 2022 11:05:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b00203f51aa12asm5601401wrq.55.2022.03.25.11.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:05:05 -0700 (PDT)
Message-Id: <pull.1188.git.1648231504463.gitgitgadget@gmail.com>
From:   "Des Preston via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:05:04 +0000
Subject: [PATCH] worktree: include repair cmd in usage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Des Preston <despreston@gmail.com>,
        Des Preston <despreston@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Des Preston <despreston@gmail.com>

The worktree repair command was not added to the usage menu for the
worktree command. This commit adds the usage of 'worktree repair'
according to the existing docs.

Signed-off-by: Des Preston <despreston@gmail.com>
---
    worktree: include repair cmd in usage
    
    I'm working on an extension for the github CLI (github.com/cli/cli) to
    make it easier to create and manage worktrees using Github info
    (github.comm/despreston/gh-worktree). I noticed there was a worktree
    command that wasn't showing up in the usage menu git worktree -h.
    
    Signed-off-by: Des Preston despreston@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1188%2Fdespreston%2Fworktree-usage-repair-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1188/despreston/worktree-usage-repair-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1188

 builtin/worktree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2838254f7f2..8682ff4c417 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -22,6 +22,7 @@ static const char * const worktree_usage[] = {
 	N_("git worktree move <worktree> <new-path>"),
 	N_("git worktree prune [<options>]"),
 	N_("git worktree remove [<options>] <worktree>"),
+	N_("git worktree repair [<path>]"),
 	N_("git worktree unlock <path>"),
 	NULL
 };

base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
-- 
gitgitgadget
