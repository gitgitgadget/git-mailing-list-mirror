Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90516C433E6
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB2D2312D
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbhASHrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbhASHpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:45:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12ADC061757
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:14 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x12so10001097plr.10
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0waPDmLH/l4gUw7BeU3PZ2ZoHrAp3OFwi/gliFpRNo4=;
        b=Q4k3LucoffB7lXU9r5slQzF2rqmlJs70sLGtKXhR5z9GZAOSoAVuSHcqNf3uwPxJUi
         aq+tRmBviuUZdheRBmcERY/XqU/sY/xwpnUQQyK4TFASwufqJJLhkbGA8xh7aMW8EVY5
         Bc7zo6Zypm9xzGXuR1NcNa4FDHP4i6W9aY/h/PCN+yGra8tSLi4M64EXpBWKq1aF1XOi
         JINdKhLAfSOYHj8Ia01+BdqNIAXSzDh0fiTkUd9CYZsG0usLl4WxLKC6cX+w+8yr6luj
         yAnHbJLp93BcnO7JgPmflMl53j6Ht0ZjgauQUg3eynDr+DGxcvCkaTOCzh86jdMCkbRT
         c9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0waPDmLH/l4gUw7BeU3PZ2ZoHrAp3OFwi/gliFpRNo4=;
        b=Nf00K2DBkdu8exCP+RzQwJ7hjeJ1bGncBr1G1uUGWzbRunpM4GTW598hhDCF3VDcXJ
         18Ifpa01OhpUOEeZuXqiufFsmvwi9ud8yVKwCY6+eh6uTEHFnUohq3a+E7BBJ5WPbmek
         ed2nf9siFskYeu5b4XywtR+376XyPm6sOsls3iStxaE0mcZLtyRhw60C7DyCUCFpoysq
         43rrCxx+TKW4wytdbkR5wWK+vB7njvmEYI9z8FEgshx7o0i9/sb4WD1DzV8lfZWWJDxw
         Nk2muwaCu75nMK3tlN6VMBYlt7Hn6qMmXIJWLND41u81FOfPopRFbceMfDGFtVxcwD0i
         u59Q==
X-Gm-Message-State: AOAM530vYzw3Sgbwjy6d14L0+kFaOr5Ybcxoont5bEptaQRt4v/3E1GC
        Mofd6AjmwNeZTaZNmmFLaxZP80udhg/IQg==
X-Google-Smtp-Source: ABdhPJy0ZqOkW81ygpb+7iqzMg3244tRQbBvfMvd4//zVvyV2g5FHhKd2SQED8bHf0LiHen0AoLHFA==
X-Received: by 2002:a17:902:e812:b029:de:5af2:3d09 with SMTP id u18-20020a170902e812b02900de5af23d09mr3359685plg.33.1611042254376;
        Mon, 18 Jan 2021 23:44:14 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:55d6:8648:6f7a:9f93])
        by smtp.googlemail.com with ESMTPSA id x1sm19201525pgj.37.2021.01.18.23.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:44:13 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 4/9] sequencer: pass todo_item to do_pick_commit()
Date:   Tue, 19 Jan 2021 13:10:59 +0530
Message-Id: <20210119074102.21598-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As an additional member of the structure todo_item will be required in
future commits pass the complete structure.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9acb9c333e..8a9adb6ff3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1881,8 +1881,7 @@ static void record_in_rewritten(struct object_id *oid,
 }
 
 static int do_pick_commit(struct repository *r,
-			  enum todo_command command,
-			  struct commit *commit,
+			  struct todo_item *item,
 			  struct replay_opts *opts,
 			  int final_fixup, int *check_todo)
 {
@@ -1895,6 +1894,8 @@ static int do_pick_commit(struct repository *r,
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, reword = 0, allow, drop_commit;
+	enum todo_command command = item->command;
+	struct commit *commit = item->commit;
 
 	if (opts->no_commit) {
 		/*
@@ -4144,8 +4145,8 @@ static int pick_commits(struct repository *r,
 				setenv(GIT_REFLOG_ACTION, reflog_message(opts,
 					command_to_string(item->command), NULL),
 					1);
-			res = do_pick_commit(r, item->command, item->commit,
-					     opts, is_final_fixup(todo_list),
+			res = do_pick_commit(r, item, opts,
+					     is_final_fixup(todo_list),
 					     &check_todo);
 			if (is_rebase_i(opts))
 				setenv(GIT_REFLOG_ACTION, prev_reflog_action, 1);
@@ -4607,11 +4608,14 @@ static int single_pick(struct repository *r,
 		       struct replay_opts *opts)
 {
 	int check_todo;
+	struct todo_item item;
+
+	item.command = opts->action == REPLAY_PICK ?
+			TODO_PICK : TODO_REVERT;
+	item.commit = cmit;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(r, opts->action == REPLAY_PICK ?
-			      TODO_PICK : TODO_REVERT, cmit, opts, 0,
-			      &check_todo);
+	return do_pick_commit(r, &item, opts, 0, &check_todo);
 }
 
 int sequencer_pick_revisions(struct repository *r,
-- 
2.29.0.rc1

