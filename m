Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8A2C77B71
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjDUO6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjDUO6A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 10:58:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113EA125B2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:57:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f7c281a015so1154598f8f.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682089077; x=1684681077;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icne5xfGB2d788/L7Cr9bQB8RSyNpE8WakcsfTOQCfU=;
        b=MXEX3b3yLS1VRAa2gb4vsweFdBR/0ILoRbOhIp/bHLQl/ZZmYYkdC+98XyspZMfvk5
         KFGmUVx93PgOclPtSrMCbPu6VGhdt3o2aknxNq6scX6r5McUWHjyYfn5JnR/Zg747y5q
         dU2V+6MLK7+ffSBbpYxBfBBBAOw/b46F+3XVFoMy8uo17nz9dahHA4DfdKMKy3QQp6Lc
         XG6LXz7vS7RWof80FmowH86nkjNAWyUKJXk+YPwI/KaEl3y9O2d7zK+WahKY6MhFtnTQ
         +nqHGhs3XR6BZR2hjLw9wpZBUdebpUKl+oySLIqHwrV9V80PsncnTJ1BmGJesKKiEs6n
         mgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089077; x=1684681077;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icne5xfGB2d788/L7Cr9bQB8RSyNpE8WakcsfTOQCfU=;
        b=O6J0wOZM4eiLGDTrhfe4Xn8Gt5X5RcQIP7xXmwBEOyw3wHJx9C+cQpt4iEAoF2OM9j
         rI/0OMmSV1xaB6pOqbLtmHiQZeJHs3QTY9/nN42BJKkBVocI2B20jSj7u7hWJ30i5tnK
         s/scHcmn45ut7E2+8RpiJYMmILt/JwDSlcUCmUP9Tq2HzjShRNRg459MfiPaGjQgYuHn
         4b6JL/bKQMyPUSfdlVsaq7DH+KMXyvFeTI1y3/CTOgGH0b/Hk7vcLbaaTCEdyIlmHs9i
         gqDxgDqP0fYmg1MBcdjD3Zc3+pyNqVUQOv2YWuTP/hnYr3g630yjBOkQffTuln6D/e7D
         AKmw==
X-Gm-Message-State: AAQBX9f9CFjy8e5ExE7ftP5Ho1MpMgg7eWSeCzLwQb67in/ulRYokMB0
        pNZaJO8BIrTHET30rvHTeys3clUQ3kM=
X-Google-Smtp-Source: AKy350Ysm6NXQvvg04Zw/bY08/LdLP/nuZUa+iQMssSqPHFLx+n8zJPTN8rYyoRgx5eC91umkTmhOg==
X-Received: by 2002:adf:f983:0:b0:2ef:ba4f:c821 with SMTP id f3-20020adff983000000b002efba4fc821mr3316137wrr.36.1682089077175;
        Fri, 21 Apr 2023 07:57:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4f01000000b002fc0de07930sm4564080wru.13.2023.04.21.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:57:56 -0700 (PDT)
Message-Id: <3dfb2c6903bcc61258c72ba5c8e4201c9db2665b.1682089074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 14:57:49 +0000
Subject: [PATCH v2 1/6] rebase -i: move unlink() calls
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

At the start of each iteration the loop that picks commits removes
state files from the previous pick. However some of these are only
written if there are conflicts so only need to be removed before
starting the loop, not in each iteration.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d2c7698c48c..5073ec5902b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4639,6 +4639,10 @@ static int pick_commits(struct repository *r,
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
+	unlink(rebase_path_message());
+	unlink(rebase_path_stopped_sha());
+	unlink(rebase_path_amend());
+
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
 		const char *arg = todo_item_get_arg(todo_list, item);
@@ -4662,10 +4666,7 @@ static int pick_commits(struct repository *r,
 						todo_list->total_nr,
 						opts->verbose ? "\n" : "\r");
 			}
-			unlink(rebase_path_message());
 			unlink(rebase_path_author_script());
-			unlink(rebase_path_stopped_sha());
-			unlink(rebase_path_amend());
 			unlink(git_path_merge_head(r));
 			unlink(git_path_auto_merge(r));
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
-- 
gitgitgadget

