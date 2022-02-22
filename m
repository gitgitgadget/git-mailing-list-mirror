Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB91C433FE
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiBVQbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiBVQa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:30:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85078166E22
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h6so34382505wrb.9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HQq8/iPgI/xyiQATgzq2+Mc24qRfPHzu/mhuo+izd9Q=;
        b=TIh3Gp4lZYCim5Mx6F5LilNPKBPcCzCGVguDdGWieLja6ikxPh9grmtMBD78LZDdqM
         pmVqWfPq9qTuIgISvC1XBN4DnEClAMd3HGyDVx61mRhAGwLiGE9xNEbxROYp8ZNuQGm0
         JMXwTF17LgqY2lkgfwNbYUgwvvMqH/ZxOPuBOiZ6kAut17FyW2giou4nWZOnX525DS19
         BAuHJGk/5ZPmUDJ5mqdzhg9v+TvrmGYkRPIrP8n/nUzGcMlJhh4Fntg3fp+KILR63D12
         Tzhnyp55Onov6mNal3M/Ykknl2eQDu3ggl67Rljwsohu5z2tX8S8QXA8yKv0Y/fy+qXb
         eLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HQq8/iPgI/xyiQATgzq2+Mc24qRfPHzu/mhuo+izd9Q=;
        b=BtxGU8NkUnM7DWx8jhYJdD0tWfLGTmJDeig5EyhliCu6IwiEpXUA3F39VnF6ZYBnfH
         GNzFrHaxHK74w9u4h0Iyx8AMwmB+JL4bGVhxTswZHew4fibpmgCe/a2IvFp2kxAThyo0
         EEiEGs72AuEuDWAE518BLIxm0Cs9CzRW4oYlPCE31iwmBYicsi+8ymutrmIC605b0FXZ
         Da/MpUOVL89vneuuQkGDQN0bhn/6tjVyrFhegccYI/lF+ZVCWQcIJwSgpTO5Tzi3Yn4r
         vPAbkZKHHWxE8AO1VfSu2NQd29YW6hU4hWTx92FcAoLAS5wLva0JElstmOw8/SDKBxhs
         NHog==
X-Gm-Message-State: AOAM530HhvNJlQWkDKb91sOmHCJiftwea4mfwkF5Wi5o2MQl3ZSvYG+E
        CKQgUs7lVUT/exL0bFVAHC4AFHeZSMQ=
X-Google-Smtp-Source: ABdhPJwUJib0XwqwhKGmjzPiFhESTNXd4PWzfeLGMz9olKJocU8dQuonrnuEfR4Oxf/mza315Hm4OQ==
X-Received: by 2002:adf:f303:0:b0:1e7:aeab:ac6a with SMTP id i3-20020adff303000000b001e7aeabac6amr20636670wro.40.1645547428991;
        Tue, 22 Feb 2022 08:30:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm2672698wmi.47.2022.02.22.08.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:28 -0800 (PST)
Message-Id: <0d3db63bda6d6fe1de5be4912534594571a0ee29.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:14 +0000
Subject: [PATCH v2 05/14] bisect--helper: really retire `--bisect-autostart`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since b0f6494f70f (bisect--helper: retire `--bisect-autostart`
subcommand, 2020-10-15), the `--bisect-autostart` option is no more. But
we kept the `enum` value of the command mode around. Let's drop it, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4ee708e34c7..c7763be2c51 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1172,7 +1172,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_RESET = 1,
 		BISECT_TERMS,
 		BISECT_START,
-		BISECT_AUTOSTART,
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-- 
gitgitgadget

