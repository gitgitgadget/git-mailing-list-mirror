Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF7C1F51C
	for <e@80x24.org>; Thu, 24 May 2018 07:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754985AbeEXHFC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 03:05:02 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35408 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeEXHEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 03:04:51 -0400
Received: by mail-ot0-f194.google.com with SMTP id h8-v6so703321otb.2
        for <git@vger.kernel.org>; Thu, 24 May 2018 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EbyvZCNSzK7O/6dOVnq4z2qHoaYw00bR/qOyCI7Zgh8=;
        b=RssmOuyJbU/hjxbwba3ZV5anrBCcP4QR1I9tT8E6ekswQAXWnWOaH4yylcvmp23hCe
         lTo0ZNZvLv9pUsgaTz/k7Yr4kB5rr7SFOh1vMpszCwTedhPjqsx4kIDkekIVULDMxTOe
         cbxVfqQptthipZfScPBy9D7dYHB5VnlSaPmL/YtIwBeaUQg/25DPFYsiDc8j7vPCXONb
         P0iZ6Aqpi9jH+IQsWcTD1RGqu5KUp1//LA+S0C89kRZY3B6Agl/cLcD4/OpVd7Eq5zT6
         b4SXN9OQB//imfsMLtcAOiqIG+m9rI8zEYtzSSrzgypkuApA9AI+BKQ9HLoeEZMQH61l
         HirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EbyvZCNSzK7O/6dOVnq4z2qHoaYw00bR/qOyCI7Zgh8=;
        b=rTUR/y2cSJhZMB1Bx3Jt3kf3zbmadfqNIyQl5LI9nQ7UaDUrNhh+L6RlHfuD6Bkyly
         avgkYNeFI8tbjmgSdVkMQ3rxpS9SkRaf27CF6cxQkyV9SxnsSso4p4MJMWpWcIkTQnH/
         ZgHPiroOvzK0aSqqH1DxoW6Sask+O6bRHzrzt148uws8UP/lxxBTmo7FSXbpnWecIn+2
         xiqqjuEOIWyGf6tPAYwkB/TXTlDECFjXcAIkEU0S3Bl4fOmp9mf9JkvgXki3xbGhSMzL
         kOGVpAvGswZxvMCQq6qPZk3xCGIWTim6TYJsgkQZpvBbeoidVIf5QD1r5IIuG7Qmbr2+
         JtzA==
X-Gm-Message-State: ALKqPwe1W9FsB5eazszn/60jlgdr9pcfCA7DPw+Rrpoi9rZsnImUQ7Dq
        SeR75iGE79RSyCxD5gE1RvNyDw==
X-Google-Smtp-Source: AB8JxZp44pZgSOS4WZbZQuYT5yhhpjtBXP2FGPo81B5hLHBhIduH5ta+M8Qr9EiJexUIXgIjxNvUvA==
X-Received: by 2002:a9d:2b37:: with SMTP id o52-v6mr3580137otb.60.1527145490505;
        Thu, 24 May 2018 00:04:50 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id q75-v6sm12076244ota.69.2018.05.24.00.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 00:04:50 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/5] t6036, t6042: prefer test_path_is_file, test_path_is_missing
Date:   Thu, 24 May 2018 00:04:37 -0700
Message-Id: <20180524070439.6367-4-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.1.gda85003413
In-Reply-To: <20180524070439.6367-1-newren@gmail.com>
References: <20180524070439.6367-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh    |  4 +--
 t/t6042-merge-rename-corner-cases.sh | 40 ++++++++++++++--------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 3e659cff28..b716155723 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -488,7 +488,7 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
 		test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
 		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
 
-		test -f a~HEAD
+		test_path_is_file a~HEAD
 	)
 '
 
@@ -512,7 +512,7 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 		test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
 		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
 
-		test -f a~D^0
+		test_path_is_file a~D^0
 	)
 '
 
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index b76da8fcdf..90225b8bcd 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -38,7 +38,7 @@ test_expect_success "Does git preserve Gollum's precious artifact?" '
 		test_must_fail git merge -s recursive rename-the-ring &&
 
 		# Make sure git did not delete an untracked file
-		test -f ring
+		test_path_is_file ring
 	)
 '
 
@@ -213,8 +213,8 @@ test_expect_failure 'detect rename/add-source and preserve all data' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test -f a &&
-		test -f b &&
+		test_path_is_file a &&
+		test_path_is_file b &&
 
 		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
 		test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
@@ -236,8 +236,8 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test -f a &&
-		test -f b &&
+		test_path_is_file a &&
+		test_path_is_file b &&
 
 		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
 		test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
@@ -302,8 +302,8 @@ test_expect_success 'rename/directory conflict + clean content merge' '
 
 		test $(git rev-parse :2:newfile) = $(git hash-object expect) &&
 
-		test -f newfile/realfile &&
-		test -f newfile~HEAD
+		test_path_is_file newfile/realfile &&
+		test_path_is_file newfile~HEAD
 	)
 '
 
@@ -340,8 +340,8 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 		test $(git rev-parse :2:newfile) = $(git rev-parse left-conflict:newfile) &&
 		test $(git rev-parse :3:newfile) = $(git rev-parse right:file) &&
 
-		test -f newfile/realfile &&
-		test -f newfile~HEAD
+		test_path_is_file newfile/realfile &&
+		test_path_is_file newfile~HEAD
 	)
 '
 
@@ -394,7 +394,7 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 		echo 7 >>expect &&
 		test_cmp expect sub &&
 
-		test -f sub
+		test_path_is_file sub
 	)
 '
 
@@ -453,10 +453,10 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 		git ls-files -o >out &&
 		test_line_count = 3 out &&
 
-		test ! -f a &&
-		test ! -f b &&
-		test -f c~HEAD &&
-		test -f c~C^0 &&
+		test_path_is_missing a &&
+		test_path_is_missing b &&
+		test_path_is_file c~HEAD &&
+		test_path_is_file c~C^0 &&
 
 		test $(git hash-object c~HEAD) = $(git rev-parse C:a) &&
 		test $(git hash-object c~C^0) = $(git rev-parse B:b)
@@ -509,7 +509,7 @@ test_expect_success 'merge has correct working tree contents' '
 		test $(git rev-parse :3:b) = $(git rev-parse A:a) &&
 		test $(git rev-parse :2:c) = $(git rev-parse A:a) &&
 
-		test ! -f a &&
+		test_path_is_missing a &&
 		test $(git hash-object b) = $(git rev-parse A:a) &&
 		test $(git hash-object c) = $(git rev-parse A:a)
 	)
@@ -562,9 +562,9 @@ test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge'
 		test $(git rev-parse 2:b) = $(git rev-parse B:b) &&
 		test $(git rev-parse 3:c) = $(git rev-parse C:c) &&
 
-		test -f a &&
-		test -f b &&
-		test -f c
+		test_path_is_file a &&
+		test_path_is_file b &&
+		test_path_is_file c
 	)
 '
 
@@ -664,8 +664,8 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 		test $(git hash-object b~HEAD) = $(git rev-parse C:b) &&
 		test $(git hash-object b~B\^0) = $(git rev-parse B:b) &&
 
-		test ! -f b &&
-		test ! -f c
+		test_path_is_missing b &&
+		test_path_is_missing c
 	)
 '
 
-- 
2.17.0.1.gda85003413

