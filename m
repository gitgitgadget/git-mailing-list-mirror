Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D28BC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AD72224B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWbzRD+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgKMMLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgKMMLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:11:07 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9220C061A04
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:02 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j7so9616305wrp.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUfvN0pl5K/WuXCV4D53cIPGvmeqL7bcfgCSQ17fPJA=;
        b=nWbzRD+/SDKe20Cl2jyPX9inFyHVuA7ViDJ7XXueqf3Vv4cjKCANmjqsyLuaV+Kbwx
         8+NkgeSzIjw4Ufl5DPnCzeDHr6FUQxMh7YQsO3cpZHV/6YQSnK+ZkfmzQwkK9fhySHCV
         kCiXXmEGeJ9Vbm3gc6syw6IC6rqlxh0sTEQYOYBLGYyU8VqPKoo6TCDDBdnnvfmHocSY
         Bncp+MJJu2Wi9vc3XEHuw8zcjQQFI3u3pXGhyaJn8eMoAdSmb72AfXtQntknsyXLrcC7
         kzs+lFJMPQOq8usADidW88rPAF/wy+Ze47KJiU0wQPH21VsDynXm/eDpQgLQBumU0gTg
         pD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUfvN0pl5K/WuXCV4D53cIPGvmeqL7bcfgCSQ17fPJA=;
        b=SaqtFSlJA52F9DMt0K1XGIl9yrNRWEug0goaH3+fkrsZJNgxcBkqNOuFKRvPQUQT4F
         GAITv7aAVz2W1IGcVMZ6EEhAm+Kb8cIprXzKYfwOSbIc8p/FqoOXyuR75fhdbMt2hj22
         lXso6wsoHyqoKmMTGJnyacu7TNi2mIP/21TFKxShfN0RfyxLre8dX1Sr6RefTjF5R+Ui
         VZYnDGuumSrllAtARpL8fc+YpMYRiEN8pMRtIv3DLlRKJuBQG2a7C53EO7WMZlgkGuSa
         Xn9xF1vUCBvOU9QK/xNq8V3lAp48WQC8ZU0zrWPgNwK2yWrR9EIKQsjr09ps7v44347n
         21GQ==
X-Gm-Message-State: AOAM533i78PvSMvRcTNZ16Z6EQfsAs/8NuAAfrmJAhDzYxZ83gIlMFA8
        3aFTtZZj3nrPTKOM/LsX+y7i1R01mSg=
X-Google-Smtp-Source: ABdhPJz72akDP/UpafHjKyClTQxueq4ndjHfDx8wh7w90Tk8K870X3jam2vrL+j95cWyVRqELkpvnA==
X-Received: by 2002:a5d:448a:: with SMTP id j10mr2975367wrq.33.1605269461250;
        Fri, 13 Nov 2020 04:11:01 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id g138sm10083697wme.39.2020.11.13.04.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:11:00 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 11/12] sequencer: use the "resolve" strategy without forking
Date:   Fri, 13 Nov 2020 12:04:27 +0100
Message-Id: <20201113110428.21265-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113110428.21265-1-alban.gruin@gmail.com>
References: <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201113110428.21265-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e8676e965f..ff411d54af 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -33,6 +33,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "merge-strategies.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2000,9 +2001,15 @@ static int do_pick_commit(struct repository *r,
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts_nr, (const char **)opts->xopts,
-					common, oid_to_hex(&head), remotes);
+
+		if (!strcmp(opts->strategy, "resolve")) {
+			repo_read_index(r);
+			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else
+			res |= try_merge_command(r, opts->strategy,
+						 opts->xopts_nr, (const char **)opts->xopts,
+						 common, oid_to_hex(&head), remotes);
+
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
-- 
2.20.1

