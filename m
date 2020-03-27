Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDFC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66B92074D
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eduR4H4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgC0AtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51114 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgC0AtF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id d198so9838664wmd.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AtaLAwnXGUPigMOZsuTiV71cTVWw5YUyEOmxTGp9rrw=;
        b=eduR4H4MZsaypOJ96+GQz+w+9ZwGabVqGON/azcy2Gj2lkghM2h6Th1c9tVyNiAfq8
         wG02134Jcdq9E3a0V+6VzNEZp6nlBw64NvRPiOcr4OBd8Fd0afps2ZVrVKAEtqHzIkWr
         37vkxOFvWcf03+Fe+cw4c0bFTlNAQXe1PmT4ANBDhrEB6FIgLX/7vlBSKTj7miJjPP4f
         DacZ7qM64/9EhRFaZTmCPYBCBKb0BmPlDPwbnnip0FYVUW8CirfbE/s4HFUwx2fxf0IB
         H7x+sJEtw2Asxes4TpdHyRO8rb6qvaC3vHUJVIOjFpccKu+NcQvDdvfaWKzc+FOpEQz9
         R48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AtaLAwnXGUPigMOZsuTiV71cTVWw5YUyEOmxTGp9rrw=;
        b=FGa5WrBxZ+S3FjCYzkBA9uWaR/ud5u2v4IyF5xPJwYtf3Dmtb+t2IMerRFkw6PjcCF
         yIzqCtsjymkjjJGjxOv2C28FZV/4VXHV2FPofxrfHQbgTYwGkFSop5I7p2x9uve/bPPv
         2zIjv37D3AOabUEmT96CJznKqKLvxy+lZpFjAgpZdAkWVsoIumy5L+WPFY07ZlgP6REh
         JZZeIB0PdtCG3/l3pRRx45TC/KIE5D+OxhE10hC1vI1priASHZMmmIYVXdccU2KU9mTu
         ufTiTR655CtUv4zOEUrniSAei0aut6pkynKJLEkUYgQNjUmpoy+Z7rk6em/xx4UMabfj
         6Sgg==
X-Gm-Message-State: ANhLgQ15nT5qW/JKxAgRzVZDRlmJHfSUixhiGJSkbqgScu8X734h27Nc
        3fbSmvN+D6wfR7h2PlhMQMkl5NC6
X-Google-Smtp-Source: ADFU+vuzB311SZlaVtfmaih7y+m+7o6CUNrlFEY4Bd6biS8h7XbHdVOiTA6C3Mmy8IUdjMYfmJWMMg==
X-Received: by 2002:a1c:5452:: with SMTP id p18mr2747238wmi.102.1585270143952;
        Thu, 26 Mar 2020 17:49:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm5849903wmj.2.2020.03.26.17.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:03 -0700 (PDT)
Message-Id: <bb41a2a52f48263a5b5c6fad955f506cb6390a22.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:44 +0000
Subject: [PATCH v3 01/18] unpack-trees: fix minor typo in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1ecdab33040..0d0eec0221e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1618,7 +1618,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 		/*
 		 * Sparse checkout loop #2: set NEW_SKIP_WORKTREE on entries not in loop #1
-		 * If the will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
+		 * If they will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
 		 * so apply_sparse_checkout() won't attempt to remove it from worktree
 		 */
 		mark_new_skip_worktree(o->pl, &o->result,
-- 
gitgitgadget

