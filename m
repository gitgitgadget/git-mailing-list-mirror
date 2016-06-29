Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F7E1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 07:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbcF2Hf0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 03:35:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36310 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbcF2Hf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 03:35:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id c82so12116974wme.3
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 00:35:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G04gsr/oQ2aNaDVZgOowIJYVxM6fDlflErHn9eOIAFM=;
        b=QWc2qG5OEvyJpz4jukMGPcffMMoVojheHdkViJX/0vkKx9adlpLHSizU9Xo7oKFFpK
         Tsc4a0rKIxEf0yPnVlc4QckCop0d5IKgGT+QgdmRkcenBwGpxLG8rO1S7hJDcp+gch/a
         G9pY1J+6uajn6j8824SAqZliV4bC8NQBsba0LnM7i9I7woOInKeEuTcWy4p1wZW29lNQ
         6pQeK1rJSSjDRfRoV7HfAZBzKF6WZcJt2TJ3/DfvaXK3MCmYhQupjpacnS1bSRKrkTQq
         HJbfKX/HZDuwAvX7XTiUqGe0Ifs8Kbf0nInKDncuSop662BMMs7AeDvn13MalmoIdDGY
         lhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G04gsr/oQ2aNaDVZgOowIJYVxM6fDlflErHn9eOIAFM=;
        b=heLYz2mL+qUQ9mM7F3+4KIz3lGEF4b7XuhnLwUGXltkWSVWIWOp+Q3CQvBtec47hEz
         ZIjrOqLI7yOmaoGtdxzLgFHxlRWgy91qSv2+jylmJJqeUXwJIGH8Vj7YG81rupDqLEQi
         6oSxWoWbl3M3FuPe0xYhvSLO/i6sz6VQjF1iJ3Y2nMTGi87bSOQuKsnBPFugC3wCBi59
         WEcqCQBV0qg7Z0SOWTjLlgpG8GjWoogDLB2q0pUHgFadGSWma8uWLCGB5tLV9v3OeAe9
         9ZN+wwjVTvgEL+grGG6JpmP0lhHZYk74f03a9meewQwnyDYoeCLQ61ioGYGR46RR/Xke
         Ddvg==
X-Gm-Message-State: ALyK8tKg9RjyfIuhsN0xWMA8rzM/HimYh1dFaphnUZEmNKPAt6uXGDWfGJ/UHznJvJIQfQ==
X-Received: by 10.28.4.140 with SMTP id 134mr20279680wme.91.1467185724494;
        Wed, 29 Jun 2016 00:35:24 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB46C0.dip0.t-ipconnect.de. [93.219.70.192])
        by smtp.gmail.com with ESMTPSA id t3sm2732360wmf.6.2016.06.29.00.35.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Jun 2016 00:35:23 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	mhagger@alum.mit.edu, j6t@kdbg.org, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2] git-p4: place temporary refs used for branch import under refs/git-p4-tmp
Date:	Wed, 29 Jun 2016 09:35:27 +0200
Message-Id: <1467185727-8235-1-git-send-email-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <xmqqeg7h87yg.fsf@gitster.mtv.corp.google.com>
References: <xmqqeg7h87yg.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git-P4 used to place temporary refs under "git-p4-tmp". Since 3da1f37
Git checks that all refs are placed under "refs". Instruct Git-P4 to
place temporary refs under "refs/git-p4-tmp". There are no backwards
compatibility considerations as these refs are transient.

Use "git show-ref --verify" to check the (non-)existience of the refs
instead of file checks assuming the file-based ref backend.

All refs under "refs" are shared across all worktrees. This is not
desired for temporary Git-P4 refs and will be adressed in a later patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Thank you Hannes for the sharp eye!

diff to v1:
* check non-existence of refs/git-p4-tmp instead of ref/git-p4-tmp
* use refs/git-p4-tmp instead of ref/git-p4-tmp in commit message
* check reference with "git show-ref --verify" to be future-proof (thanks Junio!)

Cheers,
Lars


 git-p4.py                | 2 +-
 t/t9801-git-p4-branch.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b6593cf..6b252df 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2274,7 +2274,7 @@ class P4Sync(Command, P4UserMap):
         self.useClientSpec_from_options = False
         self.clientSpecDirs = None
         self.tempBranches = []
-        self.tempBranchLocation = "git-p4-tmp"
+        self.tempBranchLocation = "refs/git-p4-tmp"
         self.largeFileSystem = None

         if gitConfig('git-p4.largeFileSystem'):
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 0aafd03..6a86d69 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -300,7 +300,7 @@ test_expect_success 'git p4 clone complex branches' '
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
 		! grep update file2 &&
-		test_path_is_missing .git/git-p4-tmp
+		test_must_fail git show-ref --verify refs/git-p4-tmp
 	)
 '

@@ -352,7 +352,7 @@ test_expect_success 'git p4 sync changes to two branches in the same changelist'
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
 		! grep update file2 &&
-		test_path_is_missing .git/git-p4-tmp
+		test_must_fail git show-ref --verify refs/git-p4-tmp
 	)
 '

--
2.5.1

