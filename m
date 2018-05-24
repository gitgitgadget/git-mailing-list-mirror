Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70851F51C
	for <e@80x24.org>; Thu, 24 May 2018 07:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbeEXHFB (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 03:05:01 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44138 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeEXHEw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 03:04:52 -0400
Received: by mail-ot0-f195.google.com with SMTP id g7-v6so686044otj.11
        for <git@vger.kernel.org>; Thu, 24 May 2018 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fYyPuneKiFoHqjKDBRPCeN0yiSy9HEvrVCkIq+FFeNQ=;
        b=M9NofWdP8VFn8fAv9u4ZEewyEeKnz1+6TOfsoPIx8KuvrLo4Wxu7RNwjfTTVBWqP5Z
         gfBiIt+KEBoX/NQuht/hINCw5xKbF05uqfSBu1EQBxM2AUpEpoL6c0uGIwVa8cEgo12G
         JByTAKJ1IN1NahFzoJBLFekRFwoxzmxorSpQE7cvuWGSeL1Ez4aPUEXAOr2o8Ng8njDW
         3tbiOzh/hXaWKbMQM06ekbc1xaADN2azwIxRJw1JeXV0mguLC4wtOyf+7k3ifVm5ZI15
         IPbfsbrI0de5nMxce4Yfv1hxLr4VWSmncBx74O53z9Yp1fr+Lb1mleoiZXlvDWmD2IDf
         eCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fYyPuneKiFoHqjKDBRPCeN0yiSy9HEvrVCkIq+FFeNQ=;
        b=Z/mNdi2UfsV72Tj8uMYbEDsffGdDswDUOaTQsfismR6AGFr7oOU1/BVUuJ5Yo0EvfH
         yEcTxdEBmwCWoCYXQgudRrdusSfAgH5oYKVWro/jH0JVNUnCeWA+WkhWDjPU6kr6yoSx
         mHKQE9Nm8mr65s3lgvkYb1ocIw4Bg7veQ5UmrfT4FIJcbfmETgBaTYNhICz7SJy5j54H
         x4+LuoowcMpoRth8lSfTXjaLL2rFW+4ffjw46eB7kVXV/LZD8zpOqbhfYuku/he0XtqQ
         X1KdcXY5372wLtWuN+sFCi/8nRvy0mhNSDdUvAVNqp67sONcgL6kPp5Fq+7FjGQxRem4
         Qjgg==
X-Gm-Message-State: ALKqPwe6DR+YlmWEwEMfuHyvjiLycuxK72XdG6I33OxclRGMZSxXbs/4
        tvENyFd6Ei+DjcVm8tfq2/dFSw==
X-Google-Smtp-Source: AB8JxZq35JzrofzaAJHcY8N0AFxyEr/Qyoukw6Ww+q/RjhmQ5rzMcLyuAZBMzXBM3RsrEXQkJUXY4A==
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr4107755otj.14.1527145491958;
        Thu, 24 May 2018 00:04:51 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id q75-v6sm12076244ota.69.2018.05.24.00.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 00:04:51 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/5] t6036, t6042: prefer test_cmp to sequences of test
Date:   Thu, 24 May 2018 00:04:38 -0700
Message-Id: <20180524070439.6367-5-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.1.gda85003413
In-Reply-To: <20180524070439.6367-1-newren@gmail.com>
References: <20180524070439.6367-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh    | 109 +++++++++++++++++----------
 t/t6042-merge-rename-corner-cases.sh |  94 ++++++++++++++---------
 2 files changed, 130 insertions(+), 73 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b716155723..e5f167a06e 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -72,11 +72,14 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 		git ls-files -o >out &&
 		test_line_count = 3 out &&
 
-		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
-		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
-
-		test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
-		test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
+		git rev-parse >expect       \
+			L2:three   R2:three \
+			L2:three   R2:three &&
+		git rev-parse   >actual     \
+			:2:three   :3:three &&
+		git hash-object >>actual    \
+			three~HEAD three~R2^0
+		test_cmp expect actual
 	)
 '
 
@@ -145,11 +148,14 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 		git ls-files -o >out &&
 		test_line_count = 3 out &&
 
-		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
-		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
-
-		test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
-		test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
+		git rev-parse >expect       \
+			L2:three   R2:three \
+			L2:three   R2:three &&
+		git rev-parse   >actual     \
+			:2:three   :3:three &&
+		git hash-object >>actual    \
+			three~HEAD three~R2^0
+		test_cmp expect actual
 	)
 '
 
@@ -224,19 +230,23 @@ test_expect_success 'git detects differently handled merges conflict' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test $(git rev-parse :2:new_a) = $(git rev-parse D:new_a) &&
-		test $(git rev-parse :3:new_a) = $(git rev-parse E:new_a) &&
+		git rev-parse >expect       \
+			D:new_a  E:new_a &&
+		git rev-parse   >actual     \
+			:2:new_a :3:new_a &&
+		test_cmp expect actual
 
-		git cat-file -p B:new_a >>merged &&
-		git cat-file -p C:new_a >>merge-me &&
+		git cat-file -p B:new_a >ours &&
+		git cat-file -p C:new_a >theirs &&
 		>empty &&
 		test_must_fail git merge-file \
 			-L "Temporary merge branch 2" \
 			-L "" \
 			-L "Temporary merge branch 1" \
-			merged empty merge-me &&
-		sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
-		test $(git rev-parse :1:new_a) = $(git hash-object merged-internal)
+			ours empty theirs &&
+		sed -e "s/^\([<=>]\)/\1\1\1/" ours >expect &&
+		git cat-file -p :1:new_a >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -311,8 +321,11 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 
-		test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
-		test $(git rev-parse :2:file) = $(git rev-parse B:file)
+		git rev-parse >expect       \
+			master:file  B:file &&
+		git rev-parse   >actual      \
+			:1:file      :2:file &&
+		test_cmp expect actual
 	)
 '
 
@@ -330,8 +343,11 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 
-		test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
-		test $(git rev-parse :3:file) = $(git rev-parse B:file)
+		git rev-parse >expect       \
+			master:file  B:file &&
+		git rev-parse   >actual      \
+			:1:file      :3:file &&
+		test_cmp expect actual
 	)
 '
 
@@ -443,8 +459,11 @@ test_expect_success 'merge of D & E1 fails but has appropriate contents' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
-		test $(git rev-parse :2:a) = $(git rev-parse B:a)
+		git rev-parse >expect    \
+			A:ignore-me  B:a &&
+		git rev-parse   >actual   \
+			:0:ignore-me :2:a &&
+		test_cmp expect actual
 	)
 '
 
@@ -463,8 +482,11 @@ test_expect_success 'merge of E1 & D fails but has appropriate contents' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
-		test $(git rev-parse :3:a) = $(git rev-parse B:a)
+		git rev-parse >expect    \
+			A:ignore-me  B:a &&
+		git rev-parse   >actual   \
+			:0:ignore-me :3:a &&
+		test_cmp expect actual
 	)
 '
 
@@ -483,10 +505,11 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
 		git ls-files -o >out &&
 		test_line_count = 2 out &&
 
-		test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
-		test $(git rev-parse :3:a/file) = $(git rev-parse E2:a/file) &&
-		test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
-		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+		git rev-parse >expect    \
+			B:a   E2:a/file  c:a/file   A:ignore-me &&
+		git rev-parse   >actual   \
+			:2:a  :3:a/file  :1:a/file  :0:ignore-me &&
+		test_cmp expect actual
 
 		test_path_is_file a~HEAD
 	)
@@ -507,10 +530,11 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 		git ls-files -o >out &&
 		test_line_count = 2 out &&
 
-		test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
-		test $(git rev-parse :2:a/file) = $(git rev-parse E2:a/file) &&
-		test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
-		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+		git rev-parse >expect    \
+			B:a   E2:a/file  c:a/file   A:ignore-me &&
+		git rev-parse   >actual   \
+			:3:a  :2:a/file  :1:a/file  :0:ignore-me &&
+		test_cmp expect actual
 
 		test_path_is_file a~D^0
 	)
@@ -688,9 +712,15 @@ test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
-		test $(git rev-parse HEAD:c) = $(git rev-parse A:a) &&
-		test "$(cat a)" = "$(printf "1\n2\n3\n4\n5\n6\n7\n8\n")"
+		printf "1\n2\n3\n4\n5\n6\n7\n8\n" >correct &&
+		git rev-parse >expect \
+			A:a   A:a     \
+			correct       &&
+		git rev-parse   >actual  \
+			:0:b  :0:c       &&
+		git hash-object >>actual \
+			a                &&
+		test_cmp expect actual
 	)
 '
 
@@ -765,8 +795,11 @@ test_expect_success 'virtual merge base handles rename/rename(1to2)/add-dest' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test $(git rev-parse HEAD:a) = $(git rev-parse A:a) &&
-		test $(git rev-parse HEAD:c) = $(git rev-parse E:c)
+		git rev-parse >expect \
+			A:a   E:c     &&
+		git rev-parse   >actual \
+			:0:a  :0:c      &&
+		test_cmp expect actual
 	)
 '
 
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 90225b8bcd..1cbd946fc2 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -80,8 +80,11 @@ test_expect_failure 'rename/modify/add-source conflict resolvable' '
 
 		git merge -s recursive C^0 &&
 
-		test $(git rev-parse B:a) = $(git rev-parse b) &&
-		test $(git rev-parse C:a) = $(git rev-parse a)
+		git rev-parse >expect \
+			B:a   C:a     &&
+		git rev-parse >actual \
+			b     c       &&
+		test_cmp expect actual
 	)
 '
 
@@ -124,8 +127,11 @@ test_expect_failure 'conflict caused if rename not detected' '
 		test_line_count = 1 out &&
 
 		test_line_count = 6 c &&
-		test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
-		test $(git rev-parse HEAD:b) = $(git rev-parse A:b)
+		git rev-parse >expect \
+			B:a   A:b     &&
+		git rev-parse >actual \
+			:0:a  :0:b    &&
+		test_cmp expect actual
 	)
 '
 
@@ -216,8 +222,11 @@ test_expect_failure 'detect rename/add-source and preserve all data' '
 		test_path_is_file a &&
 		test_path_is_file b &&
 
-		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
-		test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+		git rev-parse >expect \
+			A:a   C:a     &&
+		git rev-parse >actual \
+			:0:b  :0:a    &&
+		test_cmp expect actual
 	)
 '
 
@@ -239,8 +248,11 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
 		test_path_is_file a &&
 		test_path_is_file b &&
 
-		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
-		test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+		git rev-parse >expect \
+			A:a   C:a     &&
+		git rev-parse >actual \
+			:0:b  :0:a    &&
+		test_cmp expect actual
 	)
 '
 
@@ -336,9 +348,11 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 			left base right &&
 		test_cmp left newfile~HEAD &&
 
-		test $(git rev-parse :1:newfile) = $(git rev-parse base:file) &&
-		test $(git rev-parse :2:newfile) = $(git rev-parse left-conflict:newfile) &&
-		test $(git rev-parse :3:newfile) = $(git rev-parse right:file) &&
+		git rev-parse >expect                                 \
+			base:file   left-conflict:newfile  right:file &&
+		git rev-parse >actual                                 \
+			:1:newfile  :2:newfile             :3:newfile &&
+		test_cmp expect actual
 
 		test_path_is_file newfile/realfile &&
 		test_path_is_file newfile~HEAD
@@ -458,8 +472,11 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 		test_path_is_file c~HEAD &&
 		test_path_is_file c~C^0 &&
 
-		test $(git hash-object c~HEAD) = $(git rev-parse C:a) &&
-		test $(git hash-object c~C^0) = $(git rev-parse B:b)
+		git rev-parse >expect   \
+			C:a     B:b     &&
+		git hash-object >actual \
+			c~HEAD  c~C^0   &&
+		test_cmp expect actual
 	)
 '
 
@@ -505,13 +522,15 @@ test_expect_success 'merge has correct working tree contents' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
-		test $(git rev-parse :3:b) = $(git rev-parse A:a) &&
-		test $(git rev-parse :2:c) = $(git rev-parse A:a) &&
-
 		test_path_is_missing a &&
-		test $(git hash-object b) = $(git rev-parse A:a) &&
-		test $(git hash-object c) = $(git rev-parse A:a)
+		git rev-parse >expect   \
+			A:a   A:a   A:a \
+			A:a   A:a       &&
+		git rev-parse >actual    \
+			:1:a  :3:b  :2:c &&
+		git hash-object >>actual \
+			b     c          &&
+		test_cmp expect actual
 	)
 '
 
@@ -557,10 +576,11 @@ test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge'
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test $(git rev-parse 3:a) = $(git rev-parse C:a) &&
-		test $(git rev-parse 1:a) = $(git rev-parse A:a) &&
-		test $(git rev-parse 2:b) = $(git rev-parse B:b) &&
-		test $(git rev-parse 3:c) = $(git rev-parse C:c) &&
+		git rev-parse >expect         \
+			C:a   A:a   B:b   C:C &&
+		git rev-parse >actual          \
+			:3:a  :1:a  :2:b  :3:c &&
+		test_cmp expect actual
 
 		test_path_is_file a &&
 		test_path_is_file b &&
@@ -605,8 +625,11 @@ test_expect_failure 'rename/rename/add-source still tracks new a file' '
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
-		test $(git rev-parse HEAD:a) = $(git rev-parse C:a) &&
-		test $(git rev-parse HEAD:b) = $(git rev-parse A:a)
+		git rev-parse >expect \
+			C:a   A:a     &&
+		git rev-parse >actual \
+			:0:a  :0:b    &&
+		test_cmp expect actual
 	)
 '
 
@@ -653,16 +676,17 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 		git ls-files -o >out &&
 		test_line_count = 5 out &&
 
-		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
-		test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
-		test $(git rev-parse :3:b) = $(git rev-parse B:b) &&
-		test $(git rev-parse :2:c) = $(git rev-parse C:c) &&
-		test $(git rev-parse :3:c) = $(git rev-parse B:c) &&
-
-		test $(git hash-object c~HEAD) = $(git rev-parse C:c) &&
-		test $(git hash-object c~B\^0) = $(git rev-parse B:c) &&
-		test $(git hash-object b~HEAD) = $(git rev-parse C:b) &&
-		test $(git hash-object b~B\^0) = $(git rev-parse B:b) &&
+		git rev-parse >expect               \
+			A:a   C:b   B:b   C:c   B:c &&
+		git rev-parse >actual                \
+			:1:a  :2:b  :3:b  :2:c  :3:c &&
+		test_cmp expect actual
+
+		git rev-parse >expect               \
+			C:c     B:c     C:b     B:b &&
+		git hash-object >actual                \
+			c~HEAD  c~B\^0  b~HEAD  b~B\^0 &&
+		test_cmp expect actual
 
 		test_path_is_missing b &&
 		test_path_is_missing c
-- 
2.17.0.1.gda85003413

