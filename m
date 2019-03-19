Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A199C20248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfCSTEE (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:04:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38608 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfCSTED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:04:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so67677wrm.5
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=2TgUbW+qlY3Ve+/t/hfaznxNICgzHWByEi6CzkHCxCA=;
        b=dpMVtfqeuTMehaqUN+vczCIdOQpC7OwDHLfA2L6ElVg0VVbDncDEqOmgDQEtUImXM2
         xtLxeP4h7p0J//5o4P5Vakm0a7cBZyl41p8xpNS0eERfjS65plR7ERr6/c1QYjq0dZN3
         Ike35V0s4oYuDg23E6lNBApiKRz9Shr58kouiqc8yAmyPmX8utr2/E1nr+kOpJZ8qntw
         ePZ2cy6KL0AdYLOUC0Gjkhv9dUDoIdjOm+Omz5Kp/xJud6JUBXDRNNt9m7OFY7vSI8oL
         S+7Pu0WJ/o/IdwNrulFo/0T0cFxTWrK3r983IBs7+lEQ7SqVsECuqRv0rP2NJT2qAhSs
         IRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=2TgUbW+qlY3Ve+/t/hfaznxNICgzHWByEi6CzkHCxCA=;
        b=aGu7Umu4/8/c604oDT+NgMMd9T+0pAOvjVyS4LfIQAqs68TrAse6iPo/RipgxeqWDB
         d6kn111teXAdz+4Noda78Am+WzAW512VRhbz3BLJeL8CZ++nLe9X72swj0k+MbwXIGgK
         9Vn0bdCJmydwkIjQpgY2YjOgxsIatTtk6rQjZOTB0gD4TiP6kIqUuUFumRIgiYzNMCyw
         NZw6ZQjqmCL37OruLQHGm1CvtkDbrataxg9QGFBhKFHvx1w8Ka0w2WGPtbc4vOCd0wmd
         F7c9YfV9iHL4bE5IjZLqxubjGhJHyGEUB15DTmqUp84itIuZbDDdl98c9dZ40NgLghrq
         88wg==
X-Gm-Message-State: APjAAAX3CGTBBMgZgIKNGfkqBtRl+ZLZtHumUUx05CmYHEa61n6/zv8I
        0ObTUcC+GgPj2ol0aMUzhCJGcfhCDcM=
X-Google-Smtp-Source: APXvYqy8AswF7qcQCvFy0CtGOQOIsjuMn4hlzHjb4Yk4aSKzQ2UyMm/Llc6WiT3dS7bg+NWuYwkAGA==
X-Received: by 2002:adf:a147:: with SMTP id r7mr17716511wrr.5.1553022240950;
        Tue, 19 Mar 2019 12:04:00 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:04:00 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 05/11] rebase -i: remove duplication
Date:   Tue, 19 Mar 2019 19:03:11 +0000
Message-Id: <20190319190317.6632-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

path_state_dir() and merge_dir() refer to the same path so remove one of
them.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 80252d72df..e55bd0348a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -37,7 +37,6 @@ static char const * const builtin_rebase_usage[] = {
 	NULL
 };
 
-static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
 static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 static GIT_PATH_FUNC(apply_dir, "rebase-apply")
@@ -182,8 +181,8 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 {
 	FILE *interactive;
 
-	if (!is_directory(path_state_dir()) && mkdir_in_gitdir(path_state_dir()))
-		return error_errno(_("could not create temporary %s"), path_state_dir());
+	if (!is_directory(merge_dir()) && mkdir_in_gitdir(merge_dir()))
+		return error_errno(_("could not create temporary %s"), merge_dir());
 
 	delete_reflog("REBASE_HEAD");
 
-- 
2.21.0

