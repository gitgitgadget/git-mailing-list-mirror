Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC81FC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3AF2076E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwtMdxFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCUSAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37912 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgCUSAN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id e5so1162210edq.5
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BmKV7oFN4iQWK0H2ANuyeOer2R1yN9d+6RLRtDWCvTg=;
        b=XwtMdxFyBn3rQtKxRJY+DPJA8vaPnKbs8/AsFxnv1oOkFg1jQQqLHdkpTadIsHEnvG
         L10ACAgW+uS2e+Lp13XmInvGo2AtAC6gDt5R+VSSja1a4FMS9WyHMbmZPTevxw+UPgR5
         f4D1DZ+l0lDzsvYubk6EoEWzD6orlNwWJzLJ5HwUTk7zBXndKiHeuwneF4w9TxotTei3
         faOeHNZAnYn3mi/jHwZ6MQR/957iB+uDmfOVAZyjJxXXQezi/p8Uu/RWsy1ZeDsFNLDH
         70LRQOVusso54SWIjVLsxAGFXW1NaKGxxBcrqyabN2xvbinPLWxTO4UtCT/nZpX8q+gU
         k5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BmKV7oFN4iQWK0H2ANuyeOer2R1yN9d+6RLRtDWCvTg=;
        b=Z5jJiOM31RE6RzVXRV/PxTDKgKPiMBlJx69uuCIjJmZUnueQP+eoxDQB7lfY8iecBP
         pBnNtNjoj9VWRMJAFbi8wuPT/i+GLGfTNOAX+rq0EJcIJukDQnWEFootoVDodbExvP2O
         zmiAAxMi3UUMsOnzil7D3Gb1890ZHiozijA6punUHSvDuS7HJtXee7h4EI2bai+YDDht
         r7cxtcL2hCtslDnaImJu3NIKZaXoE46ecxVaLYIQ2hzvZmftmjTz6sJ/ZPEqA8c48Zjo
         sTsTlvbYvQlfs149Nn251qkSg4zU/1jYgyhjfZuRic2mc4lYZeqnCocHJl4ek/4h0P0Z
         SdTw==
X-Gm-Message-State: ANhLgQ3wvovkg1Rq19eTPVDeDQ+3SPhJSqx/aGIu6PJCQ/zMD0nIBx1J
        N9JMyHY0zbgIVLtbUUQVw9F4XasP
X-Google-Smtp-Source: ADFU+vtf4JGcMEjxvHPdKqocvn1WGTAqnFN6ijCkt1I+meQJIvXeUj/62aId7zrb6r+zYg0xgwbzdA==
X-Received: by 2002:a50:eb4c:: with SMTP id z12mr14053956edp.387.1584813611132;
        Sat, 21 Mar 2020 11:00:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v24sm611079ejq.20.2020.03.21.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:10 -0700 (PDT)
Message-Id: <3c183727c983fc733d83301cd289c24bd0e8bc65.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 17:59:52 +0000
Subject: [PATCH v2 01/18] unpack-trees: fix minor typo in comment
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

