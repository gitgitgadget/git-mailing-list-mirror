Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94753ECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 05:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiH1FSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 01:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiH1FSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 01:18:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5231ED4
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 22:18:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso6494284wmc.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 22:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=ao/HoFwMErGAKFpH1ar8+UrSeOZ4X3nC41g9X/28iUE=;
        b=j2N3X6uTqZJrsN9fOgKEw1Yp3paP0OJY3S+y+sLTSMYkWJLHo1NqxMpoMbIiI1jMUy
         bCuvw4Sp7Y/Ah5790VfzXkvOPEuU82vuNpOiLNbwDL1Bd9HqYpHsK6r3p/orVu0Ehf2h
         I6p3Mnuv8I2uUkTF7c8E6wYD9OXtEQr2C4WXMNCa0cQe5H5kTW+9bdFzKJhrbxnUHx2+
         kpJaqzwgitAZKSdhBTm9kHxJEpukH723or1YjOq1fPNPi4Dds4QrF0ayIUKSNVtXWxDO
         7N/7ATP3Mql6VU2vXKAlkQ5L/KNyDzpLeghwIEkphW1Bgcp/0ip1mNU6o+WshIH5AykD
         QOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=ao/HoFwMErGAKFpH1ar8+UrSeOZ4X3nC41g9X/28iUE=;
        b=jY+/oI7q/jpI792YwBVGtHGVYDl8G9ZrV+eE4bgLnL7NecF3pAHZWBFVmXGQy/adVK
         B0jk7cLoLRaQ9F47dhQyFCVRu+fSUHZjxbVTt5yzs+D3PJ8bpuxrY0MofQ6f5OBBquvd
         7UhjySEFiY3DlmBTGNjBKW6ew/1eN4L0IxuSEkjf/fSbUvB+oy/WqJsqIVo9N2bmf0k0
         C7dnZa5DSuKN0sH56R9BQgoWallT/sxh5NEp/REHLZln+yxeQu1mYysZvzjQJC0kuFrC
         WGWlQeW6NAP6b1Se5u+HiTn4t/a4bKak/78TwkOvikdoZeyZmSFSyBEGVBgB0Q651JSU
         RaeA==
X-Gm-Message-State: ACgBeo1z6jx0DdGHY/VTsYHUdC9f3hyR+R6u2bijM1Lv43OQtVV3lTvf
        tkDab3HM4JV6wYSws159tNGtBaYpOO4=
X-Google-Smtp-Source: AA6agR7F3Z7FmO742unV/MPdmN5e2wp9hn1f2L9y/H1E8XSsfErq5UdLcLpqO4Oea18wDnwnASE5PA==
X-Received: by 2002:a05:600c:4f10:b0:3a5:f8c8:a5b5 with SMTP id l16-20020a05600c4f1000b003a5f8c8a5b5mr3687112wmq.34.1661663884961;
        Sat, 27 Aug 2022 22:18:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay15-20020a5d6f0f000000b002207a5d8db3sm3764095wrb.73.2022.08.27.22.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:18:04 -0700 (PDT)
Message-Id: <32cb3a23c31ecc2700d14d80b62fcccf40da81a6.1661663880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Aug 2022 05:17:59 +0000
Subject: [PATCH 3/3] t4301: emit blank line in more idiomatic fashion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

The unusual use of:

    printf "\\n" >>file &&

may give readers pause, making them wonder why this form was chosen over
the more typical:

    printf "\n" >>file &&

However, even that may give pause since it is a somewhat unusual and
long-winded way of saying:

    echo >>file &&

Therefore, replace `printf` with the more idiomatic `echo`, with the
hope of eliminating a possible stumbling block for those reading the
code.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4301-merge-tree-write-tree.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 82a104bcbc9..28ca5c38bb5 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -176,7 +176,7 @@ test_expect_success 'directory rename + content conflict' '
 
 		test_expect_code 1 \
 			git merge-tree -z A^0 B^0 >out &&
-		printf "\\n" >>out &&
+		echo >>out &&
 		anonymize_hash out >actual &&
 		q_to_tab <<-\EOF | lf_to_nul >expect &&
 		HASH
@@ -230,7 +230,7 @@ test_expect_success 'rename/delete handling' '
 
 		test_expect_code 1 \
 			git merge-tree -z A^0 B^0 >out &&
-		printf "\\n" >>out &&
+		echo >>out &&
 		anonymize_hash out >actual &&
 		q_to_tab <<-\EOF | lf_to_nul >expect &&
 		HASH
@@ -284,7 +284,7 @@ test_expect_success 'rename/add handling' '
 
 		test_expect_code 1 \
 			git merge-tree -z A^0 B^0 >out &&
-		printf "\\n" >>out &&
+		echo >>out &&
 
 		#
 		# First, check that the bar that appears at stage 3 does not
@@ -351,7 +351,7 @@ test_expect_success SYMLINKS 'rename/add, where add is a mode conflict' '
 
 		test_expect_code 1 \
 			git merge-tree -z A^0 B^0 >out &&
-		printf "\\n" >>out &&
+		echo >>out &&
 
 		#
 		# First, check that the bar that appears at stage 3 does not
@@ -417,7 +417,7 @@ test_expect_success 'rename/rename + content conflict' '
 
 		test_expect_code 1 \
 			git merge-tree -z A^0 B^0 >out &&
-		printf "\\n" >>out &&
+		echo >>out &&
 		anonymize_hash out >actual &&
 		q_to_tab <<-\EOF | lf_to_nul >expect &&
 		HASH
@@ -471,7 +471,7 @@ test_expect_success 'rename/add/delete conflict' '
 
 		test_expect_code 1 \
 			git merge-tree -z B^0 A^0 >out &&
-		printf "\\n" >>out &&
+		echo >>out &&
 		anonymize_hash out >actual &&
 
 		q_to_tab <<-\EOF | lf_to_nul >expect &&
@@ -528,7 +528,7 @@ test_expect_success 'rename/rename(2to1)/delete/delete conflict' '
 
 		test_expect_code 1 \
 			git merge-tree -z A^0 B^0 >out &&
-		printf "\\n" >>out &&
+		echo >>out &&
 		anonymize_hash out >actual &&
 
 		q_to_tab <<-\EOF | lf_to_nul >expect &&
@@ -600,7 +600,7 @@ test_expect_success 'mod6: chains of rename/rename(1to2) and add/add via collidi
 
 		test_expect_code 1 \
 			git merge-tree -z A^0 B^0 >out &&
-		printf "\\n" >>out &&
+		echo >>out &&
 
 		#
 		# First, check that some of the hashes that appear as stage
@@ -690,7 +690,7 @@ test_expect_success 'directory rename + rename/delete + modify/delete + director
 
 		test_expect_code 1 \
 			git merge-tree -z A^0 B^0 >out &&
-		printf "\\n" >>out &&
+		echo >>out &&
 		anonymize_hash out >actual &&
 
 		q_to_tab <<-\EOF | lf_to_nul >expect &&
@@ -760,7 +760,7 @@ test_expect_success 'NUL terminated conflicted file "lines"' '
 	git commit -m "Renamed numbers" &&
 
 	test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >out &&
-	printf "\\n" >>out &&
+	echo >>out &&
 	anonymize_hash out >actual &&
 
 	# Expected results:
-- 
gitgitgadget
