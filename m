Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7621F461
	for <e@80x24.org>; Sun,  7 Jul 2019 00:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfGGABB (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jul 2019 20:01:01 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46043 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGGABB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jul 2019 20:01:01 -0400
Received: by mail-vs1-f68.google.com with SMTP id h28so5975477vsl.12
        for <git@vger.kernel.org>; Sat, 06 Jul 2019 17:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qkebvhqoII/c0tW0630uyPzcn7bEZeWtwStkwR0F90I=;
        b=pttzY0uqRoxZFe90kKnmGoc2wGuJhQdMfjOAI0me2hl0hI4lsCTaeocVUg9qaQTtSj
         xoYcgobkh5yQjJkFp3OC4/MqoDvx+J3jP8G72GFDqOiMXD3wv9SjfCUo7bJ0nkWkB3eE
         UP0BbZaxVptfKiIlo0dnvwCMf90yV1nHzsmfZKA30gxoYFRhtC8gxCZ52g8Ovj+SRgXq
         NqWcbWHGLVaBIf997x2lXXg+fz5B8EEIBOLRoI/ushOy/RisQSXAEirFlHe6bDx85Kj1
         3Xd8XFEMCqK7LLli8ad+q+JL+b2DqAvsSIp0GmsbE704afGjF9cdJ39+gma9G1REewn6
         2q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qkebvhqoII/c0tW0630uyPzcn7bEZeWtwStkwR0F90I=;
        b=NwMEo7NTFL3fHZVEmHZsPecoQelx+f0BiFv3GMCyjOdDQCQ9hWXs/WF6Ew5vxNu0I6
         3kz43PWZ1Hdx8/LQTAKRl9sJfzEypgY5keorXthsImuxVL8oqGmj8uygD6UxYVVVd3ep
         j0Lgyr6tx1wClzwlWN0YJs+GoAIOUzDF6tEs91daco0GFrAzizQPWmBWQ8kVR/+xaLRP
         eW/M/hfFJehMlK+xh5mSNGAECCHVS0NvagN+fZCpjFgs/Rcw44yIwHAA6VKG18ejYNmg
         k7P6nHeZn6j5ZfYSlfsfn0TIuGH9gGBz6jENWup3quFlxc5pPOifQucZLBnYIq9Cj5HY
         AGIA==
X-Gm-Message-State: APjAAAUyYwgDQhxqGava5yIc7GHdmqDrFg2qIqd40HclNz4b8sBFd2Zj
        nXHE4y2Khp9gs/7hoduxLm8TS1RQ
X-Google-Smtp-Source: APXvYqyhbVO0IGufIOUElMGtd9ug0cnZffvIbTFzZonqef5AcnjgA7NfBxzR2ujNDq0U6rHZDCf3vQ==
X-Received: by 2002:a67:2586:: with SMTP id l128mr6018489vsl.52.1562457659889;
        Sat, 06 Jul 2019 17:00:59 -0700 (PDT)
Received: from linuxerio.hitronhub.home ([186.32.195.224])
        by smtp.gmail.com with ESMTPSA id 185sm910401vsg.5.2019.07.06.17.00.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 17:00:59 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1] builtin/merge.c - cleanup of code in for-cycle that tests strategies
Date:   Sat,  6 Jul 2019 18:00:52 -0600
Message-Id: <20190707000052.26057-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous code was a little convoluted to follow logic
New code is shorter and logic is easier to follow

- Easier to see what happens when merge is successful
	and how --no-commit affects result
- Simpler to see that for-cycle will stop when merge_was_ok is set
- Easier to spot what logic will run through best_strategy
- Easier to see that in case of ret being 2, cycle will continue
- Keep a single break case (when automerge succedes and a revision will
  be created)
- Put together closing actions when automerge succedes if a revision
  will be created

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/merge.c | 51 ++++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6e99aead46..94f2713bea 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1586,7 +1586,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	    save_state(&stash))
 		oidclr(&stash);
 
-	for (i = 0; i < use_strategies_nr; i++) {
+	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
 		int ret;
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
@@ -1604,40 +1604,26 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
+			int cnt = evaluate_result();
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
@@ -1645,6 +1631,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * auto resolved the merge cleanly.
 	 */
 	if (automerge_was_ok) {
+		write_tree_trivial(&result_tree);
 		ret = finish_automerge(head_commit, head_subsumed,
 				       common, remoteheads,
 				       &result_tree, wt_strategy);
-- 
2.20.1

