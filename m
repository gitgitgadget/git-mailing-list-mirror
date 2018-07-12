Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AFFB1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeGPN1p (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:45 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:41303 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbeGPN1p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:45 -0400
Received: by mail-pl0-f42.google.com with SMTP id w8-v6so15233162ply.8
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h/DcBtIxRr9hy9v5MWtLpUC1nfg3XJTV+Ck9X5ZLKF0=;
        b=hLQ8QnSOQEoo9UOWzCbp5JeuQ93ycLzi9HagUmu6yslE1jn9IDIGqobHN9Zb7zi8tK
         3ybqnJfa1K66APZF/ascYEnfTry7Z+oKsvFsYt9wBZmDK4ujWT4S383ye3DsoYVfBupT
         uusq8CFKDcHVAqvw18d493b+Wn2xZNMksHhFhPhjWM9uCklY99QYtRDWImFwGeLjx8UT
         qOdYNXE1jGnlZnI6NkAUt2R5Qs6U+8ci4Jr3c63GyIKvetJzpNmChz92onQ7lzIrpYyI
         R4CCGzQ2ZCT6fz5HRzSlR47j0EYxazmY202vgMFFO+xNAzixLZtqB/oM296PfQP5YCwF
         qpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h/DcBtIxRr9hy9v5MWtLpUC1nfg3XJTV+Ck9X5ZLKF0=;
        b=Ws02rZdsaaiHPPF0iHDNlRZ4lF36dl+mic1GUeTHXYgAqgltC4H5qn5KdSTHWzfPi9
         1yOq9jWFXr86NKVVgURPdMZr9Ijgoji1qmT/PQ2IxOHvTARyM5XspSDnh8dmKOSF3nt4
         3m32pMjuaYifbA+B5yI5mGWExNhQl4rPBMjeDCtyuPwJascvmgs8p0v4xjBqTQdqQYww
         a0qTBSL6ozEJBAEesAhiSLOv8czhmH7jf7HtdSC2SCsbTC4BY/8UIDuaAMlxhIGLrL7V
         59S+b79fhXO9eQgSiVq1fslQ2W2AGUh6k4fow+MIL6yVz1jGbJZ5nG44rtA293BHEsSD
         WWPg==
X-Gm-Message-State: AOUpUlFcCLK/2mywx882USv9kb+BMh8rLQUlMOl0h+2edy6FrUoBSY9H
        h770LoTh7/aDE/TjCx77Jv3eMw==
X-Google-Smtp-Source: AAOMgpe0x8Sl7G6qk+gPyg5sfknrMSNEf5r3fAsDJ8XI/3eflYWREW+GDEzOErjcwWS5HQ4TmWW/0g==
X-Received: by 2002:a17:902:2924:: with SMTP id g33-v6mr16771001plb.26.1531746023368;
        Mon, 16 Jul 2018 06:00:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id d12-v6sm19937510pfn.118.2018.07.16.06.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:22 -0700 (PDT)
Message-Id: <74b7352b580ae920d9d5f206b9389e207aada4fe.1531746010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Jul 2018 16:47:52 -0400
Subject: [PATCH 06/16] upload-pack: generalize commit date cutoff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The ok_to_give_up() method uses the commit date as a cutoff to avoid
walking the entire reachble set of commits. Before moving the
reachable() method to commit-reach.c, pull out the dependence on the
global constant 'oldest_have' with a 'min_commit_date' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 upload-pack.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e7ad7f24b..96298e50e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -336,7 +336,8 @@ static int got_oid(const char *hex, struct object_id *oid)
 	return 0;
 }
 
-static int reachable(struct commit *from, int with_flag, int assign_flag)
+static int reachable(struct commit *from, int with_flag, int assign_flag,
+		     time_t min_commit_date)
 {
 	struct prio_queue work = { compare_commits_by_commit_date };
 
@@ -354,7 +355,7 @@ static int reachable(struct commit *from, int with_flag, int assign_flag)
 		if (commit->object.flags & REACHABLE)
 			continue;
 		commit->object.flags |= REACHABLE;
-		if (commit->date < oldest_have)
+		if (commit->date < min_commit_date)
 			continue;
 		for (list = commit->parents; list; list = list->next) {
 			struct commit *parent = list->item;
@@ -371,10 +372,12 @@ static int reachable(struct commit *from, int with_flag, int assign_flag)
 /*
  * Determine if every commit in 'from' can reach at least one commit
  * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
- * as a marker for commits that are already visited.
+ * as a marker for commits that are already visited. Do not walk
+ * commits with date below 'min_commit_date'.
  */
 static int can_all_from_reach_with_flag(struct object_array *from,
-					int with_flag, int assign_flag)
+					int with_flag, int assign_flag,
+					time_t min_commit_date)
 {
 	int i;
 
@@ -393,7 +396,8 @@ static int can_all_from_reach_with_flag(struct object_array *from,
 			from->objects[i].item->flags |= assign_flag;
 			continue;
 		}
-		if (!reachable((struct commit *)from_one, with_flag, assign_flag))
+		if (!reachable((struct commit *)from_one, with_flag, assign_flag,
+			       min_commit_date))
 			return 0;
 	}
 	return 1;
@@ -404,7 +408,8 @@ static int ok_to_give_up(void)
 	if (!have_obj.nr)
 		return 0;
 
-	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE, COMMON_KNOWN);
+	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE,
+					    COMMON_KNOWN, oldest_have);
 }
 
 static int get_common_commits(void)
-- 
gitgitgadget

