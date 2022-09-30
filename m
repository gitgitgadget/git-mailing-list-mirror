Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF416C4332F
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiI3OKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiI3OKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 10:10:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D194E8E996
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso2295171wms.5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2psviCN9S4KzFfaeHXHKYf4B3oKYa4nWfaU5wV+N0UY=;
        b=iV2aXxt5aVBUf+srMzieZSBldLBQDC2gaWboYrIuUbUK5bwi82vaNkG4ZVV/1KO12z
         5Vhksz/aC6Dx8CRv03xhPUuwktFk6DK+TBw6BYJuuoD++OdMRFtMD6ybCJI0d/3VxbKY
         M1Ic8ga0YjFZaRuAWdNtgIFPthJTcIr6A1yfm8rvK34SpZyc7ZGuWa/lyq6HjJQhXkwm
         LcT+dVss0+2lkAOzj6VLHoaQ4gHxF+H3uYGKEwwO1SURd4MkdHa/8e5FVodz/XsG6O6Q
         NHtc2Q9ApmHMn2M34b8RqXWfrCsTmaSnBoL1dFsOLL3Pf++cII0ea3zZ0f4UO4fxp2yX
         hGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2psviCN9S4KzFfaeHXHKYf4B3oKYa4nWfaU5wV+N0UY=;
        b=Ole8v4xD4Cmk1DuMi+CkQ6dlq1GHpr3fVcZVbGjAd569nN4lSMpK3OLO2giM+uxT0q
         BPH/ytNq1Zk7I5qIO0pl6cz58pMMxIt96CGzHIQtd3iuxkj85WpZSXrt4U89slaiOnjK
         cs4KPB3/dE+s0/zucM/343ltL/G6QkRVW2v9LQKCyrBPDs8B+cGPfAT4aUwMbDAFGKDZ
         faXpCoadgJ/9RLeUl0b0+DF8vfZ4eBYXG4YCwGeFlt4gVrHx+kGG1vDci2YZCrs+F39J
         MxoU5b/wIA5ZUnc1vBihuZh087N2dDSZZWVxW3uNqYsBaMQgaT2dtGsWFSHRk2PEfrpP
         lcdw==
X-Gm-Message-State: ACrzQf29ispxm01w/pvZlxPzl4+JHzDSr4U89ySDcNwzUIBxpErL5ASA
        fnrg7t9DOv3DNY/Obo49HvHH8NB/CNM=
X-Google-Smtp-Source: AMsMyM6iKhmS9CvEC9xutn47SFnCIjL7nPNvB/nm7zq9Id4YPZ12cieSBWDmGttXkaE6/xes/q2Yxg==
X-Received: by 2002:a7b:c048:0:b0:3b4:fb26:f0f3 with SMTP id u8-20020a7bc048000000b003b4fb26f0f3mr14930334wmc.115.1664547020461;
        Fri, 30 Sep 2022 07:10:20 -0700 (PDT)
Received: from localhost (94-21-37-194.pool.digikabel.hu. [94.21.37.194])
        by smtp.gmail.com with ESMTPSA id d16-20020adfe890000000b0022e035a4e93sm1202429wrm.87.2022.09.30.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:10:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/6] sequencer: avoid empty lines after 'update-ref' instructions
Date:   Fri, 30 Sep 2022 16:09:46 +0200
Message-Id: <20220930140948.80367-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.542.g9b62912f7f
In-Reply-To: <20220930140948.80367-1-szeder.dev@gmail.com>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the sequencer generates a todo list for 'git rebase
--update-refs', it always inserts an empty line after each
'update-ref' instruction and after each comment line about checked out
refs.  These empty lines are unnecessary, distracting, and waste
valuable vertical screen real estate, especially when multiple refs
point to the same commit:

  pick 29a79f8 two
  pick 74bf293 three
  # Ref refs/heads/branch3 checked out at '/tmp/test/WT'

  update-ref refs/heads/branch2

  update-ref refs/heads/branch1

  pick 5f59b82 four

Eliminate those empty lines.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d26ede83c4..fba92c90b1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5945,12 +5945,12 @@ static int add_decorations_to_list(const struct commit *commit,
 		/* If the branch is checked out, then leave a comment instead. */
 		if ((path = branch_checked_out(decoration->name))) {
 			item->command = TODO_COMMENT;
-			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
+			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'",
 				    decoration->name, path);
 		} else {
 			struct string_list_item *sti;
 			item->command = TODO_UPDATE_REF;
-			strbuf_addf(ctx->buf, "%s\n", decoration->name);
+			strbuf_addstr(ctx->buf, decoration->name);
 
 			sti = string_list_insert(&ctx->refs_to_oids,
 						 decoration->name);
-- 
2.38.0.rc2.542.g9b62912f7f

