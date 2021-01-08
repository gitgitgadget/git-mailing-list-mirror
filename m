Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A745DC433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE3123383
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbhAHJ0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbhAHJ0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:26:37 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7FAC0612F9
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 01:25:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id iq13so3330082pjb.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 01:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=beWNG+690OTiaPIvDDb4xzSXF3VhJt/XqaUnPr4PUMk=;
        b=BsZvG4Qbb4Y4DdKal2dvlSoeiE9EImLdsbHD9/5hgsynjUUXPsN6onOYOVDsog1CtB
         64zzKuE0tbacgjPtmpngmkeow18gaJoKHOM1FuHkRXnvZniAgLMNXgKs8y8V6R4Y5N+R
         NU32Cp+wXJjU+a0vnFId1ShZCEfR8DI1iZpMhA2ldbr/fwXg3IIhg/f9PkHu6vjTTSs8
         z22Cdj+QOH8PhnoGItld3ZmS5Di6/5WlVPR68ZBsX3rHAOFuP8QUPXPMaoq+/lPFAoz9
         VStvIIyVNn1rpSclFHqKWM6moxEJodonngAGHtIj+b2ewBM81GDplVXipOBH2tKZKGeb
         HuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beWNG+690OTiaPIvDDb4xzSXF3VhJt/XqaUnPr4PUMk=;
        b=J8LZyR2hM04KMUtJKAlOYwqqFdGMc34Y8nSvuwxrbDtbDyJSgu4m0nZAhKKyFQ8MIX
         BA5dR3dYqSR+kcWwe4uEQ0vK2/snRYylzeXky1F/Xgux2YGfhswwNjI7O0az7kY85Zp2
         t7I4ZO0ymjYro8vd4ENCOhPCjOzMCkDQEK79KFu+QlntZ4TQw/+iY1GOtNJ2T94ApEhh
         ozO07jZ8a4pqlcz+zvPMi7gwT+cZoqWx0ml81twT976lgpCwA8abwhhps1RLjhsFcnJ8
         WVk0dzxqkCSEo2qRCp3RqQrVw7lNQfs4nVoMIMJEE1ow5OpQAPfyCfgvF8LFQ8XrAzMc
         LpxQ==
X-Gm-Message-State: AOAM530vDfBi/f1zGDtOcXMSmvGdosMNBmG0vVsK0NSIHClaj2Mf0zQs
        z+2ZgWb8PSivCT2D8HZ0XiHuFpS1kJZOuA==
X-Google-Smtp-Source: ABdhPJyc9yQj5SJhErzHBrUCkj6I12glssNXIGfAM464EC950veM0a+BWlbOylYsXVtlMuQd25To5w==
X-Received: by 2002:a17:90a:e64e:: with SMTP id ep14mr2723993pjb.5.1610097956525;
        Fri, 08 Jan 2021 01:25:56 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:e06:7e2e:2d21:e266:30b:8fc])
        by smtp.googlemail.com with ESMTPSA id 6sm8384234pfj.216.2021.01.08.01.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 01:25:56 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 4/9] sequencer: pass todo_item to do_pick_commit()
Date:   Fri,  8 Jan 2021 14:53:42 +0530
Message-Id: <20210108092345.2178-5-charvi077@gmail.com>
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
index b050a9a212..cdafc2e0e8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1884,8 +1884,7 @@ static void record_in_rewritten(struct object_id *oid,
 }
 
 static int do_pick_commit(struct repository *r,
-			  enum todo_command command,
-			  struct commit *commit,
+			  struct todo_item *item,
 			  struct replay_opts *opts,
 			  int final_fixup, int *check_todo)
 {
@@ -1898,6 +1897,8 @@ static int do_pick_commit(struct repository *r,
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, reword = 0, allow, drop_commit;
+	enum todo_command command = item->command;
+	struct commit *commit = item->commit;
 
 	if (opts->no_commit) {
 		/*
@@ -4147,8 +4148,8 @@ static int pick_commits(struct repository *r,
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
@@ -4610,11 +4611,14 @@ static int single_pick(struct repository *r,
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

