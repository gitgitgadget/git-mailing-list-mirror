Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822A2C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 15:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjHAPXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 11:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjHAPXl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 11:23:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A572125
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 08:23:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso39917335e9.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690903415; x=1691508215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FsZlnQ/pdPdGxbCA6lMi0UO2zWupGBHUo0en+6o2o8=;
        b=nVAvP2Ph8nduFRg6NEVSMshgLGifVaLjccbyiqJy6b0V3xM8NUbLz+GMWGNZfUzzpb
         kyCSbvAUw7hnhJvQBYFp0TaYZLDDHPM09B4pQ7bc1iLIVGypGOIyYr5nRWRnx8UKjcN6
         2glNvRNuleTrwlWhI6TM9dbkdmoHTAIZ7ikAfuLcbyl7l99TSoOW6ZpEEh4PQneRUPbP
         M2Nftlns8ZFcjasY0g5pOjmpudZNsEISoIAz59I4xzKXfg7jw0J1cdJuns0SUqbVPFKW
         m9Xwx2ui6KTqqLXqaxvfK61XJE97PunDGl/RaY5M6+Joi7YTHp+pTKfq7AH5HlnrI3fm
         vG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690903415; x=1691508215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FsZlnQ/pdPdGxbCA6lMi0UO2zWupGBHUo0en+6o2o8=;
        b=YcSnjRBs2NOTdv1Lfivy6fw0mQ2bnGklY9j27ZXtCHBA3pqc5pvUC9rbz7/Ly3ourd
         TO+OcFcAAwbqPeX5H/G2k6yZwTPuzrwcD1ncipns7cJ+h/P05Uuf9/aDWtSDPSLOxmtP
         s+bm6RPJAbeKkO7Xud5uG5pbHex3PmoN3gZqnpvcDMwQ9QNhvRU6Qez4NLxFLYz/OtXO
         ETQnOWhv/DCE9yxZaE7LXu3PEJ12Kd8CWTCJW0EfEPyAXvSiauDae/4aWHpRzgiGveuW
         D4hGBog47P3zPTCC7EEK1OiBzz9v12m+02S6c/LuANH6PQK8YVGGDiZxOEhhmu1EmH8s
         pkIg==
X-Gm-Message-State: ABy/qLbOCXOSr6fcCrew4gmJRA++Nh/rJjyB0SVXpRmIUFhczanMJRQA
        YxaIrUtGtPOVuYVeOdHYeQ4RQCW7904=
X-Google-Smtp-Source: APBJJlGIhkyf/8sWzPuEbQYB9UJdVd4qikWhqvC3N7DPbpfY9RudLldDKPs5ufmS4eNzXciZCX3wDA==
X-Received: by 2002:a1c:6a0a:0:b0:3fa:aeac:e978 with SMTP id f10-20020a1c6a0a000000b003faaeace978mr2851242wmc.0.1690903415220;
        Tue, 01 Aug 2023 08:23:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13-20020a05600c0acd00b003fe1fe56202sm6296754wmr.33.2023.08.01.08.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:23:35 -0700 (PDT)
Message-ID: <1ab1ad2ef07687c25c1d346b5b7b26f38bafe5b9.1690903412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 15:23:26 +0000
Subject: [PATCH v3 1/7] rebase -i: move unlink() calls
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

At the start of each iteration the loop that picks commits removes
state files from the previous pick. However some of these are only
written if there are conflicts and so we break out of the loop after
writing them. Therefore they only need to be removed when the rebase
continues, not in each iteration.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cc9821ece2c..de66bda9d5b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4656,6 +4656,10 @@ static int pick_commits(struct repository *r,
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
+	unlink(rebase_path_message());
+	unlink(rebase_path_stopped_sha());
+	unlink(rebase_path_amend());
+
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
 		const char *arg = todo_item_get_arg(todo_list, item);
@@ -4679,10 +4683,7 @@ static int pick_commits(struct repository *r,
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

