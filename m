Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A2C4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193F924672
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAPhqCfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgB0AFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:05:10 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:36107 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgB0AFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 19:05:10 -0500
Received: by mail-wm1-f47.google.com with SMTP id p17so1367862wma.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FFYoCE1ZPpLJxny0MIbayPC0gd08WBqglqPxTrR8n8Y=;
        b=mAPhqCfSyW8Ai90FijYhs8mYj/UpI/zaQs0KPrzoA6Fbiv8lFAjR5VX1hiVHlrN81u
         UYZZrL4S9y18PuEV82Xr3eLmB1vFCCuOwPuCInRqS5P3hs/0vRklbGQiHGdPQ0xwQXxa
         0LzEonWQEw/wjc0mx5W7+aRDHMY2uFFncGH6JiKIxPLsUyUTSfk/DxqH39fxbh4eShqS
         21RqCyKPhgVlRAwxi2xrPXcnL27bzxOtUbqeunyRXYYF1CFMCcNU6UEHufnKL5oBT40f
         05z0Sv604u6OTezXs6ioAUH+VJCn5klXDxy7Wa4JSJD0MzqWcgyYJLomwZnvHrxQjXXe
         c90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FFYoCE1ZPpLJxny0MIbayPC0gd08WBqglqPxTrR8n8Y=;
        b=R+tAq4dMeYQebHmmTFVh3H+A6ArZDkXsHKciRk3WGSYeTWyJe1zqm3lhsQyDQfAvhf
         bUa+ZIpzjGtgOvjXIo97wmnCI/1hPyyOk1NrXu7LV/5OaCTHhbOUfuD7iW85MDaMMN8n
         3BEgZuKKNm9I7Y2jSbS1cgplnBZe8S5LLAXkIKaaFLnEcd3tcopg5YJYjbROo60OmxBi
         w1m0f+tb44EfalY47ZhxnfRvmE8k79ihY+atE1lnwMaNuLOEWbbGhzoRDQ797Cgf4adm
         cD8q9oOWKyK66iZjeunajpQ1PAbAcZS6TxZno2PENGJkxnv7/O0YOsuh61TGjFgHpvLL
         vORw==
X-Gm-Message-State: APjAAAVsuxxW9F40pzTuzt/Ht2koMcxwX6HI2SKPloo3O6wNVGx1gkUr
        +Cy+ZkuVN2rmBx05aJBa8R3hz40W
X-Google-Smtp-Source: APXvYqxr2+lhv4/MCodBTAORCohuRwNmhnrJu00xe2jnVub4DBopuPR3fnvLBepqsNMcW1i72hUa0Q==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr1414213wmd.9.1582761906453;
        Wed, 26 Feb 2020 16:05:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm5188002wml.7.2020.02.26.16.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 16:05:06 -0800 (PST)
Message-Id: <pull.715.git.git.1582761905294.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 00:05:05 +0000
Subject: [PATCH] merge-recursive: apply collision handling unification to
 recursive case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the en/merge-path-collision topic (see commit ac193e0e0aa5, "Merge
branch 'en/merge-path-collision'", 2019-01-04), all the "file collision"
conflict types were modified for consistency.  In particular,
rename/add, rename/rename(2to1) and each rename/add piece of a
rename/rename(1to2)/add[/add] conflict were made to behave like add/add
conflicts have always been handled.

However, this consistency was not enforced when opt->priv->call_depth >
0 for rename/rename conflicts.  Update rename/rename(1to2) and
rename/rename(2to1) conflicts in the recursive case to also be
consistent.  As an added bonus, this simplifies the code considerably.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-recursive: apply collision handling unification to recursive case
    
    This commit ties up a loose end that I was unaware of with the
    en/merge-path-collision topic from very early 2019.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-715%2Fnewren%2Frecursive-collision-handling-redux-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-715/newren/recursive-collision-handling-redux-v1
Pull-Request: https://github.com/git/git/pull/715

 merge-recursive.c                 | 152 +++++++++---------------------
 t/t6036-recursive-corner-cases.sh |  39 ++++++--
 2 files changed, 77 insertions(+), 114 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index aee1769a7ac..3728b3f6598 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1557,35 +1557,6 @@ static int handle_file_collision(struct merge_options *opt,
 					     b, a);
 	}
 
-	/*
-	 * In the recursive case, we just opt to undo renames
-	 */
-	if (opt->priv->call_depth && (prev_path1 || prev_path2)) {
-		/* Put first file (a->oid, a->mode) in its original spot */
-		if (prev_path1) {
-			if (update_file(opt, 1, a, prev_path1))
-				return -1;
-		} else {
-			if (update_file(opt, 1, a, collide_path))
-				return -1;
-		}
-
-		/* Put second file (b->oid, b->mode) in its original spot */
-		if (prev_path2) {
-			if (update_file(opt, 1, b, prev_path2))
-				return -1;
-		} else {
-			if (update_file(opt, 1, b, collide_path))
-				return -1;
-		}
-
-		/* Don't leave something at collision path if unrenaming both */
-		if (prev_path1 && prev_path2)
-			remove_file(opt, 1, collide_path, 0);
-
-		return 0;
-	}
-
 	/* Remove rename sources if rename/add or rename/rename(2to1) */
 	if (prev_path1)
 		remove_file(opt, 1, prev_path1,
@@ -1746,85 +1717,56 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		return -1;
 	free(path_desc);
 
-	if (opt->priv->call_depth) {
-		/*
-		 * FIXME: For rename/add-source conflicts (if we could detect
-		 * such), this is wrong.  We should instead find a unique
-		 * pathname and then either rename the add-source file to that
-		 * unique path, or use that unique path instead of src here.
-		 */
-		if (update_file(opt, 0, &mfi.blob, o->path))
-			return -1;
+	if (opt->priv->call_depth)
+		remove_file_from_index(opt->repo->index, o->path);
 
-		/*
-		 * Above, we put the merged content at the merge-base's
-		 * path.  Now we usually need to delete both a->path and
-		 * b->path.  However, the rename on each side of the merge
-		 * could also be involved in a rename/add conflict.  In
-		 * such cases, we should keep the added file around,
-		 * resolving the conflict at that path in its favor.
-		 */
-		add = &ci->ren1->dst_entry->stages[flip_stage(2)];
-		if (is_valid(add)) {
-			if (update_file(opt, 0, add, a->path))
-				return -1;
-		}
-		else
-			remove_file_from_index(opt->repo->index, a->path);
-		add = &ci->ren2->dst_entry->stages[flip_stage(3)];
-		if (is_valid(add)) {
-			if (update_file(opt, 0, add, b->path))
-				return -1;
-		}
-		else
-			remove_file_from_index(opt->repo->index, b->path);
+	/*
+	 * For each destination path, we need to see if there is a
+	 * rename/add collision.  If not, we can write the file out
+	 * to the specified location.
+	 */
+	add = &ci->ren1->dst_entry->stages[flip_stage(2)];
+	if (is_valid(add)) {
+		add->path = mfi.blob.path = a->path;
+		if (handle_file_collision(opt, a->path,
+					  NULL, NULL,
+					  ci->ren1->branch,
+					  ci->ren2->branch,
+					  &mfi.blob, add) < 0)
+			return -1;
 	} else {
-		/*
-		 * For each destination path, we need to see if there is a
-		 * rename/add collision.  If not, we can write the file out
-		 * to the specified location.
-		 */
-		add = &ci->ren1->dst_entry->stages[flip_stage(2)];
-		if (is_valid(add)) {
-			add->path = mfi.blob.path = a->path;
-			if (handle_file_collision(opt, a->path,
-						  NULL, NULL,
-						  ci->ren1->branch,
-						  ci->ren2->branch,
-						  &mfi.blob, add) < 0)
-				return -1;
-		} else {
-			char *new_path = find_path_for_conflict(opt, a->path,
-								ci->ren1->branch,
-								ci->ren2->branch);
-			if (update_file(opt, 0, &mfi.blob,
-					new_path ? new_path : a->path))
-				return -1;
-			free(new_path);
-			if (update_stages(opt, a->path, NULL, a, NULL))
-				return -1;
-		}
+		char *new_path = find_path_for_conflict(opt, a->path,
+							ci->ren1->branch,
+							ci->ren2->branch);
+		if (update_file(opt, 0, &mfi.blob,
+				new_path ? new_path : a->path))
+			return -1;
+		free(new_path);
+		if (!opt->priv->call_depth &&
+		    update_stages(opt, a->path, NULL, a, NULL))
+			return -1;
+	}
 
-		add = &ci->ren2->dst_entry->stages[flip_stage(3)];
-		if (is_valid(add)) {
-			add->path = mfi.blob.path = b->path;
-			if (handle_file_collision(opt, b->path,
-						  NULL, NULL,
-						  ci->ren1->branch,
-						  ci->ren2->branch,
-						  add, &mfi.blob) < 0)
-				return -1;
-		} else {
-			char *new_path = find_path_for_conflict(opt, b->path,
-								ci->ren2->branch,
-								ci->ren1->branch);
-			if (update_file(opt, 0, &mfi.blob,
-					new_path ? new_path : b->path))
-				return -1;
-			free(new_path);
-			if (update_stages(opt, b->path, NULL, NULL, b))
-				return -1;
-		}
+	add = &ci->ren2->dst_entry->stages[flip_stage(3)];
+	if (is_valid(add)) {
+		add->path = mfi.blob.path = b->path;
+		if (handle_file_collision(opt, b->path,
+					  NULL, NULL,
+					  ci->ren1->branch,
+					  ci->ren2->branch,
+					  add, &mfi.blob) < 0)
+			return -1;
+	} else {
+		char *new_path = find_path_for_conflict(opt, b->path,
+							ci->ren2->branch,
+							ci->ren1->branch);
+		if (update_file(opt, 0, &mfi.blob,
+				new_path ? new_path : b->path))
+			return -1;
+		free(new_path);
+		if (!opt->priv->call_depth &&
+		    update_stages(opt, b->path, NULL, NULL, b))
+			return -1;
 	}
 
 	return 0;
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 7d73afdcdaa..b3bf4626178 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -60,9 +60,9 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 		test_must_fail git merge -s recursive R2^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 5 out &&
 		git ls-files -u >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
@@ -133,9 +133,9 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 		test_must_fail git merge -s recursive R2^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 5 out &&
 		git ls-files -u >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
@@ -218,8 +218,18 @@ test_expect_success 'git detects differently handled merges conflict' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		git rev-parse >expect       \
-			C:new_a  D:new_a  E:new_a &&
+		git cat-file -p C:new_a >ours &&
+		git cat-file -p C:a >theirs &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "Temporary merge branch 1" \
+			-L "" \
+			-L "Temporary merge branch 2" \
+			ours empty theirs &&
+		sed -e "s/^\([<=>]\)/\1\1\1/" ours >ours-tweaked &&
+		git hash-object ours-tweaked >expect &&
+		git rev-parse >>expect      \
+				  D:new_a  E:new_a &&
 		git rev-parse   >actual     \
 			:1:new_a :2:new_a :3:new_a &&
 		test_cmp expect actual &&
@@ -257,7 +267,8 @@ test_expect_success 'git detects differently handled merges conflict, swapped' '
 		ctime=$(git log --no-walk --date=raw --format=%cd C | awk "{print \$1}") &&
 		newctime=$(($btime+1)) &&
 		git fast-export --no-data --all | sed -e s/$ctime/$newctime/ | git fast-import --force --quiet &&
-		# End of differences; rest is copy-paste of last test
+		# End of most differences; rest is copy-paste of last test,
+		# other than swapping C:a and C:new_a due to order switch
 
 		git checkout D^0 &&
 		test_must_fail git merge -s recursive E^0 &&
@@ -269,8 +280,18 @@ test_expect_success 'git detects differently handled merges conflict, swapped' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		git rev-parse >expect       \
-			C:new_a  D:new_a  E:new_a &&
+		git cat-file -p C:a >ours &&
+		git cat-file -p C:new_a >theirs &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "Temporary merge branch 1" \
+			-L "" \
+			-L "Temporary merge branch 2" \
+			ours empty theirs &&
+		sed -e "s/^\([<=>]\)/\1\1\1/" ours >ours-tweaked &&
+		git hash-object ours-tweaked >expect &&
+		git rev-parse >>expect      \
+				  D:new_a  E:new_a &&
 		git rev-parse   >actual     \
 			:1:new_a :2:new_a :3:new_a &&
 		test_cmp expect actual &&

base-commit: 2d2118b814c11f509e1aa76cb07110f7231668dc
-- 
gitgitgadget
