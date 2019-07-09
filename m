Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373801F461
	for <e@80x24.org>; Tue,  9 Jul 2019 03:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGIDQY (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 23:16:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35401 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfGIDQY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 23:16:24 -0400
Received: by mail-ua1-f65.google.com with SMTP id j21so5823733uap.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 20:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9uy9nvzYgsGrXzzj2Qj8SJcuM6J3T5yiFSeINHCb05Q=;
        b=fqLhed0f+EpDEIw0XkF145C/6p55XAKspl/TNMRyqitK2iVex17ABIbp85hYOlBO8b
         rqSskcfxKruvygZKE5r/qXmaeMjL5nScWrGpRpu/5uVleA90GD6yoF1IFW7sTsEz10/K
         71n0aVjMbfnFRScaRaqd4YwREWUbvCHVT/3YgvFXi7fTFFUBbbD2Gawh4bpbnu1fKBJT
         /bMl9K/19Z8iwIMMPul0QjRwH6R2UpS7FvQn0QL44FGyB1pVgOCdZczO7O3l/Mjvf24w
         t00VQK/t9Pgd9P+dl3F2mAvA40PvC2m+LqBhCawURIIFgIMtECuGl1brSGAJowAqFMFo
         CUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9uy9nvzYgsGrXzzj2Qj8SJcuM6J3T5yiFSeINHCb05Q=;
        b=nlEu9DOK0xykgsx4ZUtG2VJEfFhGi4K+TKdE4Jx115/ZgMbOy2If/1re6CTFzczFKN
         3EYsoGyzPrtdgYp54Srd4EcdhCFW4WAYaC2dOqb8z9iHv8mNxWY0jzUk2Sj0eYs3Orr7
         LpJAzX1yhZ3kBM7BO33Lkfa5yKC/UwM9jod6WSMkhr11M0BZsfTqPpckcqze+U2/Y17E
         DAKP8Et6WdMSHOIwS0be3G52dToqjYRYpPY/WVmwflW3fdX8LUnyKawa0jBlwz9/GfZa
         baAtiXJxW5GrhQWyhsi6SnXqJkHDZCbfPopHnKlPtReUB53RLMhY0piQKRABJD6+zflY
         icFQ==
X-Gm-Message-State: APjAAAX4hFAgCAWMVlSmYb2iFYMZ7ukOfhyBYpWwjcL7E+nXrOx3lSgm
        LrqSGzLOEFRVeEl0KmBfxtL6qghJhr8=
X-Google-Smtp-Source: APXvYqz7MS3nBuQL7/q06BbjTsa4DFeTVqMTMkFdOeF2CSZKNfL3wPLdPaxuDgyA79R1E5FTzR8otQ==
X-Received: by 2002:ab0:6503:: with SMTP id w3mr11553728uam.99.1562642182997;
        Mon, 08 Jul 2019 20:16:22 -0700 (PDT)
Received: from linuxerio.localdomain ([186.32.195.224])
        by smtp.gmail.com with ESMTPSA id s7sm2303290uaq.11.2019.07.08.20.16.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 20:16:22 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v2] builtin/merge.c - cleanup of code in for-cycle that tests strategies
Date:   Mon,  8 Jul 2019 21:15:59 -0600
Message-Id: <20190709031559.21742-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.22.0.215.g4ce9ddf76f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cmd_merge() function has a loop that tries different
merge strategies in turn, and stops when a strategy gets a
clean merge, while keeping the "best" conflicted merge so
far.

Make the loop easier to follow by moving the code around,
ensuring that there is only one "break" in the loop where
an automerge succeeds.  Also group the actions that are
performed after an automerge succeeds together to a single
location, outside and after the loop.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/merge.c | 53 +++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6e99aead46..e7aeedc77d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -892,6 +892,7 @@ static int finish_automerge(struct commit *head,
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id result_commit;
 
+	write_tree_trivial(result_tree);
 	free_commit_list(common);
 	parents = remoteheads;
 	if (!head_subsumed || fast_forward == FF_NO)
@@ -1586,8 +1587,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	    save_state(&stash))
 		oidclr(&stash);
 
-	for (i = 0; i < use_strategies_nr; i++) {
-		int ret;
+	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
+		int ret, cnt;
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
 			restore_state(&head_commit->object.oid, &stash);
@@ -1604,40 +1605,26 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		ret = try_merge_strategy(use_strategies[i]->name,
 					 common, remoteheads,
 					 head_commit);
-		if (!option_commit && !ret) {
-			merge_was_ok = 1;
-			/*
-			 * This is necessary here just to avoid writing
-			 * the tree, but later we will *not* exit with
-			 * status code 1 because merge_was_ok is set.
-			 */
-			ret = 1;
-		}
-
-		if (ret) {
-			/*
-			 * The backend exits with 1 when conflicts are
-			 * left to be resolved, with 2 when it does not
-			 * handle the given merge at all.
-			 */
-			if (ret == 1) {
-				int cnt = evaluate_result();
-
-				if (best_cnt <= 0 || cnt <= best_cnt) {
-					best_strategy = use_strategies[i]->name;
-					best_cnt = cnt;
+		/*
+		 * The backend exits with 1 when conflicts are
+		 * left to be resolved, with 2 when it does not
+		 * handle the given merge at all.
+		 */
+		if (ret < 2) {
+			if (!ret) {
+				if (option_commit) {
+					/* Automerge succeeded. */
+					automerge_was_ok = 1;
+					break;
 				}
+				merge_was_ok = 1;
+			}
+			cnt = evaluate_result();
+			if (best_cnt <= 0 || cnt <= best_cnt) {
+				best_strategy = use_strategies[i]->name;
+				best_cnt = cnt;
 			}
-			if (merge_was_ok)
-				break;
-			else
-				continue;
 		}
-
-		/* Automerge succeeded. */
-		write_tree_trivial(&result_tree);
-		automerge_was_ok = 1;
-		break;
 	}
 
 	/*
-- 
2.20.1

