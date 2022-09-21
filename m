Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B14EC6FA8E
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 13:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiIUNDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 09:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIUNDD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 09:03:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCE8F956
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 06:03:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a29so5847145pfk.5
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JOhM6L6a5rOpyB763JJ/no8akw3RQlEzkmOCvtxvMlc=;
        b=pvy6Tb1XPdoXEI2+omVf/FiV6RCm4DfW1DXXVsGQaQvjAkc2jEhf1fV5b55wh2bKHT
         bQIfXih0O1BxZBbxI6oTUy4EVYHaS8mxsJ8/FIpyjArFPj13afeU4FXQPC3FYoeoS/Yg
         mCh5yKVl+uF8IN1w9cxoPTCv7pI0sASEiyTUO9BwND0mZFz8Di/iyX1qObelU0VtVqQH
         u3KIWGeMdJ/O57fJrnAFn7Vbfs+dfRAPxN/dPT4gDbL8B8mURVMhgykDBHPeUTEdAISi
         aHVXP1scO3T7bDhmqTRNXxWBEhl49SZgc1uMvtj6ssVLh45D7CmlpM4t8tea3HPi3D8x
         sulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JOhM6L6a5rOpyB763JJ/no8akw3RQlEzkmOCvtxvMlc=;
        b=N7ZUduEqAKfgantoj1dVD7HZWmo4gdF9gPgZzQFq4cEalhuAsH4ztmXUAkMP6GlSeH
         hRZqfSiC/uymT6d870biZLrchE5s3ddsHkTlTykkGO/bDGoD8QwS166myVdFsY3qwowI
         51eDLz3rkjtDOs/jUFz7UPMhneL1cXSZY6rPsgPtA2qvCwfapelcJFqQZdJuhDqZ+74O
         mcn7lWGduHoEWE5h4IgfKPxuiaCd/zhHqKIKZlihIxdrvsKHwIJ8ySrkWIsCRi5mxnGN
         GFxqQGTiuLFZlsfm3pKvq8lGtMTyRme2oPgLbGOR6pNIFbIlYv9gIIRYodvkkYGpGchg
         Kp2Q==
X-Gm-Message-State: ACrzQf3hTo8XU6E2qnPEhs0FZzs0gkHEFujnMRJjrmoQ438JI2rwcMm8
        sgCxH0odTDgp5mymaRR6KYBX5kxRF3E=
X-Google-Smtp-Source: AMsMyM4YU+xPOjgfd9WvuJfy3rLNz4tvXzSVpmXxexVNywjLSr47BWGSEEOVa7ldVkE554Yq1B8HJQ==
X-Received: by 2002:a05:6a00:114f:b0:528:2c7a:634c with SMTP id b15-20020a056a00114f00b005282c7a634cmr28928452pfm.41.1663765380527;
        Wed, 21 Sep 2022 06:03:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:5008:db00:84c8:158c:9494:ee57])
        by smtp.gmail.com with ESMTPSA id i64-20020a625443000000b0053e5daf1a25sm2084332pfb.45.2022.09.21.06.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 06:02:59 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] t: remove \{m,n\} from BRE grep usage
Date:   Wed, 21 Sep 2022 20:02:30 +0700
Message-Id: <ebaf6cec07e3a07c969c456e93aa9d4464f75548.1663765176.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0
In-Reply-To: <cover.1663765176.git.congdanhqx@gmail.com>
References: <cover.1663765176.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The CodingGuidelines says we should avoid \{m,n\} in BRE usage.
And their usages in our code base is limited, and subjectively
hard to read.

Replace them with ERE.

Except for "0\{40\}" which would be changed to "$ZERO_OID",
which is a better value for testing with:
GIT_TEST_DEFAULT_HASH=sha256

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

 Phillip Wood said:
 > \{m,n\} is valid in a posix BRE[1]. If we're already using it without
 > anyone
 > complaining I think it would be better to update CodingGuidlines to allow
 > it.

 Yes, I agree. However, I think our usage of \{m,n\} is limited.
 Let's skip the lifting for now.

 t/t3200-branch.sh             | 4 ++--
 t/t3305-notes-fanout.sh       | 2 +-
 t/t3404-rebase-interactive.sh | 6 +++---
 t/t5550-http-fetch-dumb.sh    | 2 +-
 t/t5702-protocol-v2.sh        | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9723c2827c..b82cffc0b3 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -201,8 +201,8 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 
 test_expect_success 'git branch -M baz bam should add entries to .git/logs/HEAD' '
 	msg="Branch: renamed refs/heads/baz to refs/heads/bam" &&
-	grep " 0\{40\}.*$msg$" .git/logs/HEAD &&
-	grep "^0\{40\}.*$msg$" .git/logs/HEAD
+	grep " $ZERO_OID.*$msg$" .git/logs/HEAD &&
+	grep "^$ZERO_OID.*$msg$" .git/logs/HEAD
 '
 
 test_expect_success 'git branch -M should leave orphaned HEAD alone' '
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 22ffe5bcb9..1ec1fb6715 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -9,7 +9,7 @@ path_has_fanout() {
 	path=$1 &&
 	fanout=$2 &&
 	after_last_slash=$(($(test_oid hexsz) - $fanout * 2)) &&
-	echo $path | grep -q "^\([0-9a-f]\{2\}/\)\{$fanout\}[0-9a-f]\{$after_last_slash\}$"
+	echo $path | grep -q -E "^([0-9a-f]{2}/){$fanout}[0-9a-f]{$after_last_slash}$"
 }
 
 touched_one_note_with_fanout() {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 688b01e3eb..4f5abb5ad2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1244,9 +1244,9 @@ test_expect_success 'short commit ID collide' '
 		test $colliding_id = "$(git rev-parse HEAD | cut -c 1-4)" &&
 		grep "^pick $colliding_id " \
 			.git/rebase-merge/git-rebase-todo.tmp &&
-		grep "^pick [0-9a-f]\{$hexsz\}" \
+		grep -E "^pick [0-9a-f]{$hexsz}" \
 			.git/rebase-merge/git-rebase-todo &&
-		grep "^pick [0-9a-f]\{$hexsz\}" \
+		grep -E "^pick [0-9a-f]{$hexsz}" \
 			.git/rebase-merge/git-rebase-todo.backup &&
 		git rebase --continue
 	) &&
@@ -1261,7 +1261,7 @@ test_expect_success 'respect core.abbrev' '
 		set_cat_todo_editor &&
 		test_must_fail git rebase -i HEAD~4 >todo-list
 	) &&
-	test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
+	test 4 = $(grep -c -E "pick [0-9a-f]{12,}" todo-list)
 '
 
 test_expect_success 'todo count' '
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index d7cf85ffea..8f182a3cbf 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -234,7 +234,7 @@ test_expect_success 'http-fetch --packfile' '
 		--index-pack-arg=--keep \
 		"$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
 
-	grep "^keep.[0-9a-f]\{16,\}$" out &&
+	grep -E "^keep.[0-9a-f]{16,}$" out &&
 	cut -c6- out >packhash &&
 
 	# Ensure that the expected files are generated
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5d42a355a8..b33cd4afca 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1001,7 +1001,7 @@ test_expect_success 'part of packfile response provided as URI' '
 	do
 		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
 		{
-			grep "^[0-9a-f]\{16,\} " out || :
+			grep -E "^[0-9a-f]{16,} " out || :
 		} >out.objectlist &&
 		if test_line_count = 1 out.objectlist
 		then
-- 
2.38.0.rc0

