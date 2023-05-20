Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A82C7EE2A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjETQOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjETQOF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F32121
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30626f4d74aso2838448f8f.0
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599241; x=1687191241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQyibiRXolRpIiLEza94rrYM8pmdRSEh2io/+Cjw4bs=;
        b=HKYLqD6vcNzVJPNT3lussXES2rg1owQBJcA9nK0mFRhrryewYojZFgDAbU97dtKMtI
         iXFs7KsoUJkn+XiRD5SDwX6wc//qlOLmBqZdBXDMxDhirip3iJHQRPjI1q0FFwWUY6OT
         g08uGZrp2KeGKP0M3K4dTOlClxKWEbOY421TTs4ul4T55C883QK1AZ+XjsyG9HrW79Ud
         67RSx0LNm1RIdLQSZ9yh7zNy7zPyfMiYB5WCtB/Fv4hxmfQeSK/4Uj61Bu2notDA1a4C
         5qj9yawP9bbB5syADyMVDeB549eMqP6kywnshLlpd679sBRiiLObEJCyCEs2wqGrFMW9
         04Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599241; x=1687191241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQyibiRXolRpIiLEza94rrYM8pmdRSEh2io/+Cjw4bs=;
        b=TKQRlTo6PUSG4KIrlAQxvWbankiKECAETwQnYyJ3eFLjmC5c3R4Tu8JF8Oz/C3E8UO
         f/UKOAi9oQIeyCqK7gQuKohbfOvWnhUgyX9+ciHeN0fu3lgoU7553s7RAa2YY+8euZGb
         YEhLaTZcABoGq78CnAUwoAedd1Od0twnvm8HpiHDiFQ6NIcu0osWj5kou8T3LLz3BvYR
         1rAlZl7Kkgra4C3SHZWrlbDtFJYjGU+QeK2U9YjBBsDVqdrnaEcpXpjwsy1UumorytXF
         MRdyyvo7CxyQ5xcF3uo5geJ6PTI3OPSYyUSn8UuIm6u8mz/2XdKmNamTwPVRhdLmFToI
         jWcQ==
X-Gm-Message-State: AC+VfDwEs+iraE/RvTaoMYRoYxRNJtYL9hqPxEHUewQ4UqUd+yDaq86s
        voDddCcHl+u54legvZ4t3rYNPy+gvOw=
X-Google-Smtp-Source: ACHHUZ7Lr3hY/2BM7LRE+tLf0AeJ3MU6nePCkI1KTBICDx03I40KERI81YSkfHUtho9ogqyjXlL1wA==
X-Received: by 2002:adf:e945:0:b0:306:2e48:6ded with SMTP id m5-20020adfe945000000b003062e486dedmr4677889wrn.13.1684599241572;
        Sat, 20 May 2023 09:14:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d58ec000000b00309257ad16csm2349469wrd.29.2023.05.20.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:01 -0700 (PDT)
Message-Id: <9ed2127a2595b42f45450358aecd2090d9cfea4c.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:50 +0000
Subject: [PATCH 02/10] t7111-reset-table: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t7111-reset-table.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t7111-reset-table.sh b/t/t7111-reset-table.sh
index 78f25c1c7ea..01b7c3503ca 100755
--- a/t/t7111-reset-table.sh
+++ b/t/t7111-reset-table.sh
@@ -10,9 +10,9 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 
 test_expect_success 'creating initial commits' '
-    test_commit E file1 &&
-    test_commit D file1 &&
-    test_commit C file1
+	test_commit E file1 &&
+	test_commit D file1 &&
+	test_commit C file1
 '
 
 while read W1 I1 H1 T opt W2 I2 H2
@@ -74,13 +74,13 @@ B C C C keep   B C C
 EOF
 
 test_expect_success 'setting up branches to test with unmerged entries' '
-    git reset --hard C &&
-    git branch branch1 &&
-    git branch branch2 &&
-    git checkout branch1 &&
-    test_commit B1 file1 &&
-    git checkout branch2 &&
-    test_commit B file1
+	git reset --hard C &&
+	git branch branch1 &&
+	git branch branch2 &&
+	git checkout branch1 &&
+	test_commit B1 file1 &&
+	git checkout branch2 &&
+	test_commit B file1
 '
 
 while read W1 I1 H1 T opt W2 I2 H2
-- 
gitgitgadget

