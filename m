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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63316C433E6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328BC22D58
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbhAXRHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbhAXRHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:07:11 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D6EC061756
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j12so6854863pjy.5
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKNDGS89h3BP7A+kc9sS7Cfxp6AlmTx76lu6cpG0xto=;
        b=XE9+lW8l8YymCHFPn5Cg/vjITDvGkoNmjjPkyc/d3C5c1cyZASukr9iXO6gOZoWuUt
         Rrt1da5+AR6aOTqY7K9PpE7O9thzXLCFcN1HKy80A+hbQVLIGvCk0NEyJsavaIg2jv4Y
         0YVtrFo03F5+YmfDaiW40weTxqnWzPt8Kuo8saMIeNgid4k33nlmnkWlVksgyNZo16GS
         vaYMDlFLKzg66zcJMda+MmSfep8wRiVOmb3rQ+fGiMddY4hNfgRiApimRkKXN5CcxMhm
         Fq07sfC87quGbhBIGclrqQskDP7CHCjKGp3yWi1xVbCjA+Ym5XucPchI2qzONnc6YYkD
         4K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKNDGS89h3BP7A+kc9sS7Cfxp6AlmTx76lu6cpG0xto=;
        b=G/bmUH22eIPsWnis/o/YzBUmrZ2a1wQBC1A6Dr4oeRzBaMbsXuPD3he+xzY2bac+Vx
         or/49d/CPfpMdOhH7cGwcGEnFtd1RROjBgUbxrymZxEcOgFM+A3ZTit2PXFLD90o4Au7
         rqVkXCK7WqhpwVrlYSpFnIP7uWLi9f0ZlnuUQXdQHBxP7Fr7VeNf+SJPGaIS33nQFEAi
         KYqKJhCDFQGwnMD6JYXTcNZz4C5EDBy2Oo4rrT8vTaoA/aKQrOw0izxt4hxmfviGBEae
         wdeUKyBRcP/rQxa2y8N8tNFhZiYPLit1qM2lWGMFxZC5Re45s5/2swz7N4zqr/ObHKSI
         Yb+w==
X-Gm-Message-State: AOAM533m2pIf4ye1lqgbppYUghwsF1UAt6iQc/nanzVliHfJ+XeHXWzn
        vpEEp5U2WHrExXVMm/YrVF6MiNmV7i12pQ==
X-Google-Smtp-Source: ABdhPJzRVmhG3YoUC3vDWHi8cpe3m4v/smGhaa2XoEuZuuD4kvj2hZnZ75HyfXfKBQ0oqbexiQ2SUg==
X-Received: by 2002:a17:90a:a44:: with SMTP id o62mr17302954pjo.209.1611507990751;
        Sun, 24 Jan 2021 09:06:30 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:f516:739c:ea0e:a6ba])
        by smtp.googlemail.com with ESMTPSA id r30sm16283308pjg.43.2021.01.24.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:06:30 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        marcnarc@xiplink.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 4/9] sequencer: pass todo_item to do_pick_commit()
Date:   Sun, 24 Jan 2021 22:34:02 +0530
Message-Id: <20210124170405.30583-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210124170405.30583-1-charvi077@gmail.com>
References: <20210119074102.21598-1-charvi077@gmail.com>
 <20210124170405.30583-1-charvi077@gmail.com>
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
index 034149f24d..09cbb17f87 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1877,8 +1877,7 @@ static void record_in_rewritten(struct object_id *oid,
 }
 
 static int do_pick_commit(struct repository *r,
-			  enum todo_command command,
-			  struct commit *commit,
+			  struct todo_item *item,
 			  struct replay_opts *opts,
 			  int final_fixup, int *check_todo)
 {
@@ -1891,6 +1890,8 @@ static int do_pick_commit(struct repository *r,
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, reword = 0, allow, drop_commit;
+	enum todo_command command = item->command;
+	struct commit *commit = item->commit;
 
 	if (opts->no_commit) {
 		/*
@@ -4140,8 +4141,8 @@ static int pick_commits(struct repository *r,
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
@@ -4603,11 +4604,14 @@ static int single_pick(struct repository *r,
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

