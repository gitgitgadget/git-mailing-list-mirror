Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E101F404
	for <e@80x24.org>; Tue,  3 Apr 2018 17:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeDCR5u (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 13:57:50 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:36368 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeDCR5t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 13:57:49 -0400
Received: by mail-ua0-f201.google.com with SMTP id t34so14700406uat.3
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=YGtqUC/H3RTB1+aN61VNux7D0rthSGnNaIEY+tEKXWo=;
        b=LVHIj/58YSfrBtiG8a6WQt1lKA/WNO6ukWTaYOMptOHDpzseBJV5ljSH5oA3laPQbW
         Fgp0EXXzg+u7rCUg3xULzHZyvnG5BRVSXRMCq9jOuwjYF/8Yxn1tLEFX/L6g5/l9e2y/
         JKe7pib/hWcDCjj3Vyt0c+pWNkhJiUQbHZyy1vfsL3BicKvf0+s+oPa+CuQ8qeqgBvDK
         UUvxx6jvei409ILUptTpmAM2pJpEMGBXKMtQCWTr4tc6nlMlbVwfQF5/KDyacuLD71lC
         NuZp7IqIkrGrdlFbpquYJKVRxd8uRUxPQlxXr9EOESzkYC+jrW6oT05Ln6VXtocVe6vx
         U/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=YGtqUC/H3RTB1+aN61VNux7D0rthSGnNaIEY+tEKXWo=;
        b=AMbbfgbgLG+4N+S/nXNlqNmTvFH/DvVSZBUKRnIp0sX5Kr8dNxt8AUc/VrjVnKjnmK
         vOCgIKKHIzOYgB/d7KLffLl/4lYYS+IsrLnYxD3Tnia6yrHFRpWzrA5fjP7uJ69+t/Zz
         fkgMuD8mdKVLaqDn4pxWIelCo4r29z3C4XpulOt4AN04z/Z0N74V5/h0QnHSl819aZie
         yXGVAnBMo1SOZJsAFD/xsG1DJXvUNOXrWzY+C8CS/pnWJUKftbr3ycMNUTIxlWLmh1EW
         TyEf+HC9RW5gDqpctKjX4LKC3tkeeeoMNFRD3Zm3SgPf4u+w0k/ScyXU2blahXUE8ino
         4TXQ==
X-Gm-Message-State: ALQs6tBDtlKULpF2ID03or5r18qNNNwpzzfKFOJKKyK0PlH83QW5n/q4
        3h8nUjXMvLsELu/DfhHC07EWuX8bNgUt7D8+A7PLzKpxaiXhT4vGHZ0+wcvs7RH6tMUciwoJQwe
        6mhLGtuU2w9+5YO5+UKs7tuw755SSDJxyiR1dwCXqoQi8KqBcDJltwLFqTw==
X-Google-Smtp-Source: AIpwx489ZnroCW3hJere/OSZCafkPPFAuZ/dI7pVB9J6kzZdbwrSt2Hlz3JoDr/dS7LG0Lq1FGSMNHMF6sA=
MIME-Version: 1.0
X-Received: by 10.176.26.139 with SMTP id j11mr6052532uai.103.1522778268890;
 Tue, 03 Apr 2018 10:57:48 -0700 (PDT)
Date:   Tue,  3 Apr 2018 10:57:45 -0700
Message-Id: <20180403175745.140638-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
Subject: [PATCH] commit: allow partial commits with relative paths
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 8894d53580 (commit: allow partial commits with relative paths,
2011-07-30) ensured that partial commits were allowed when a user
supplies a relative pathspec but then this was regressed in 5879f5684c
(remove prefix argument from pathspec_prefix, 2011-09-04) when the
prefix argument to 'pathspec_prefix' removed and the 'list_paths'
function wasn't properly adjusted to cope with the change, resulting in
over-eager pruning of the tree that is overlayed on the index.

This fixes the regression and adds a regression test so this can be
prevented in the future.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/commit.c  |  3 +--
 t/t7501-commit.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 37fcb55ab0..5571d4a3e2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -218,8 +218,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 	if (with_tree) {
 		char *max_prefix = common_prefix(pattern);
-		overlay_tree_on_index(&the_index, with_tree,
-				      max_prefix ? max_prefix : prefix);
+		overlay_tree_on_index(&the_index, with_tree, max_prefix);
 		free(max_prefix);
 	}
 
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index fa61b1a4ee..9dbbd01fc0 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -52,6 +52,18 @@ test_expect_success PERL 'can use paths with --interactive' '
 	git reset --hard HEAD^
 '
 
+test_expect_success 'removed files and relative paths' '
+	test_when_finished "rm -rf foo" &&
+	git init foo &&
+	>foo/foo.txt &&
+	git -C foo add foo.txt &&
+	git -C foo commit -m first &&
+	git -C foo rm foo.txt &&
+
+	mkdir -p foo/bar &&
+	git -C foo/bar commit -m second ../foo.txt
+'
+
 test_expect_success 'using invalid commit with -C' '
 	test_must_fail git commit --allow-empty -C bogus
 '
-- 
2.17.0.rc1.321.gba9d0f2565-goog

