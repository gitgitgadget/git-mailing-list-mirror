Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE0C7EE2C
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjERUEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjERUEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:04:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06398E45
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so16001515e9.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440218; x=1687032218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgU1OssP17DowgeYVI6AkXEVwnwzxvc59lV61R1ihd0=;
        b=qiUW4TUEkVJjxjv05jgo8afKYJufFuy+MCnobYlsjyBE9R9LeSyzM9aHPpgFHf7W6c
         l9BNcOnpvl4AztCGs96GskpGfRwrtBo8o2nqo5rc7oDrs0FOoo8jWj9uAFYlYCOl1XY6
         f6AyYHgs53HyuMjOTclS0Gifl7fCG1wY+UNkFpEJT7VYUImNVVE53JrGAhQKLuFabVWH
         Gfzdsuutk6jHH8aaMmhdMNSQFowA3VQl9niza+jLPgL2t8NQR4FPXzdfGEVfRY5TpVfr
         IqMcawFcAeQrs3rhw8viz+kP9/Jq35/zpICeh9gV1TQrNpAZZzxP02obGrq6Fsr+t6N2
         PeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440218; x=1687032218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgU1OssP17DowgeYVI6AkXEVwnwzxvc59lV61R1ihd0=;
        b=EGQOEAahBN70tYgENmu8jQSNCyPGt3c6ci+QLdgPNeoWtXACEEqdOafPFxr52q/lFm
         JPUl2CV0FMo3CpfXCvCZ7kBA1Z6yE04iTw5gfCzWfDXMaAbtFxg1XMWTajM4kfa4aIRh
         DXwjl7NmzjWyvoISr7qtEnFgYeqiilf+/UuwQ5T/T+6ZEnfi5O+LNTeeQVVo72Z03ZEO
         qzRTZ2aEAum6eubWOiylPxRs7ba5lpA4LTgZrbcmADa7VGR4lxCFoQglaXQsbSBXJ1dq
         4mXlD0QJnMKo6NhhiHaSqm9xxnNIyRCMd1Od/Myd/+Qx4cGFAWyFmgosJZRkksooS9fQ
         2eOw==
X-Gm-Message-State: AC+VfDzitn9U6CHlZwEQDLM9PrhwqOCEUIhRZMt5XtpcRsoJr9+Ta1cT
        xbNiLmeDoFPqniEAF5ujA1Xk0pCsRO4=
X-Google-Smtp-Source: ACHHUZ7N7mkwYZVV4Thkg44e53bK7SOreb8OTaoNXmg2INtWfIG+gfIlTaAyU+DrjVqQvWK2e1pAXw==
X-Received: by 2002:a1c:720e:0:b0:3f4:2d31:11b2 with SMTP id n14-20020a1c720e000000b003f42d3111b2mr2546150wmc.13.1684440218047;
        Thu, 18 May 2023 13:03:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q28-20020a056000137c00b003093a412310sm3052313wrz.92.2023.05.18.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:37 -0700 (PDT)
Message-Id: <8e5a934ae1e9b2a1fde670ba54a9c2f141f13110.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:22 +0000
Subject: [PATCH 17/20] t5303-pack-corruption-resilience: modernize test format
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
 t/t5303-pack-corruption-resilience.sh | 584 +++++++++++++-------------
 1 file changed, 292 insertions(+), 292 deletions(-)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 2926e8dfc41..61469ef4a68 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -59,304 +59,304 @@ do_corrupt_object() {
 
 printf '\0' > zero
 
-test_expect_success \
-    'initial setup validation' \
-    'create_test_files &&
-     create_new_pack &&
-     git prune-packed &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    'create corruption in header of first object' \
-    'do_corrupt_object $blob_1 0 < zero &&
-     test_must_fail git cat-file blob $blob_1 > /dev/null &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     test_must_fail git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... but having a loose copy allows for full recovery' \
-    'mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_1 &&
-     mv tmp ${pack}.idx &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... and loose copy of first delta allows for partial recovery' \
-    'git prune-packed &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_2 &&
-     mv tmp ${pack}.idx &&
-     test_must_fail git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    'create corruption in data of first object' \
-    'create_new_pack &&
-     git prune-packed &&
-     chmod +w ${pack}.pack &&
-     perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
-     test_must_fail git cat-file blob $blob_1 > /dev/null &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     test_must_fail git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... but having a loose copy allows for full recovery' \
-    'mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_1 &&
-     mv tmp ${pack}.idx &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... and loose copy of second object allows for partial recovery' \
-    'git prune-packed &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_2 &&
-     mv tmp ${pack}.idx &&
-     test_must_fail git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    'create corruption in header of first delta' \
-    'create_new_pack &&
-     git prune-packed &&
-     do_corrupt_object $blob_2 0 < zero &&
-     git cat-file blob $blob_1 > /dev/null &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     test_must_fail git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... but having a loose copy allows for full recovery' \
-    'mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_2 &&
-     mv tmp ${pack}.idx &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... and then a repack "clears" the corruption' \
-    'do_repack &&
-     git prune-packed &&
-     git verify-pack ${pack}.pack &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    'create corruption in data of first delta' \
-    'create_new_pack &&
-     git prune-packed &&
-     chmod +w ${pack}.pack &&
-     perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
-     git cat-file blob $blob_1 > /dev/null &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     test_must_fail git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... but having a loose copy allows for full recovery' \
-    'mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_2 &&
-     mv tmp ${pack}.idx &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... and then a repack "clears" the corruption' \
-    'do_repack &&
-     git prune-packed &&
-     git verify-pack ${pack}.pack &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    'corruption in delta base reference of first delta (OBJ_REF_DELTA)' \
-    'create_new_pack &&
-     git prune-packed &&
-     do_corrupt_object $blob_2 2 < zero &&
-     git cat-file blob $blob_1 > /dev/null &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     test_must_fail git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... but having a loose copy allows for full recovery' \
-    'mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_2 &&
-     mv tmp ${pack}.idx &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... and then a repack "clears" the corruption' \
-    'do_repack &&
-     git prune-packed &&
-     git verify-pack ${pack}.pack &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    'corruption #0 in delta base reference of first delta (OBJ_OFS_DELTA)' \
-    'create_new_pack --delta-base-offset &&
-     git prune-packed &&
-     do_corrupt_object $blob_2 2 < zero &&
-     git cat-file blob $blob_1 > /dev/null &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     test_must_fail git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... but having a loose copy allows for full recovery' \
-    'mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_2 &&
-     mv tmp ${pack}.idx &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... and then a repack "clears" the corruption' \
-    'do_repack --delta-base-offset &&
-     git prune-packed &&
-     git verify-pack ${pack}.pack &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    'corruption #1 in delta base reference of first delta (OBJ_OFS_DELTA)' \
-    'create_new_pack --delta-base-offset &&
-     git prune-packed &&
-     printf "\001" | do_corrupt_object $blob_2 2 &&
-     git cat-file blob $blob_1 > /dev/null &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     test_must_fail git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... but having a loose copy allows for full recovery' \
-    'mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_2 &&
-     mv tmp ${pack}.idx &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... and then a repack "clears" the corruption' \
-    'do_repack --delta-base-offset &&
-     git prune-packed &&
-     git verify-pack ${pack}.pack &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... and a redundant pack allows for full recovery too' \
-    'do_corrupt_object $blob_2 2 < zero &&
-     git cat-file blob $blob_1 > /dev/null &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     test_must_fail git cat-file blob $blob_3 > /dev/null &&
-     mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_1 &&
-     git hash-object -t blob -w file_2 &&
-     printf "$blob_1\n$blob_2\n" | git pack-objects .git/objects/pack/pack &&
-     git prune-packed &&
-     mv tmp ${pack}.idx &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    'corruption of delta base reference pointing to wrong object' \
-    'create_new_pack --delta-base-offset &&
-     git prune-packed &&
-     printf "\220\033" | do_corrupt_object $blob_3 2 &&
-     git cat-file blob $blob_1 >/dev/null &&
-     git cat-file blob $blob_2 >/dev/null &&
-     test_must_fail git cat-file blob $blob_3 >/dev/null'
-
-test_expect_success \
-    '... but having a loose copy allows for full recovery' \
-    'mv ${pack}.idx tmp &&
-     git hash-object -t blob -w file_3 &&
-     mv tmp ${pack}.idx &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    '... and then a repack "clears" the corruption' \
-    'do_repack --delta-base-offset --no-reuse-delta &&
-     git prune-packed &&
-     git verify-pack ${pack}.pack &&
-     git cat-file blob $blob_1 > /dev/null &&
-     git cat-file blob $blob_2 > /dev/null &&
-     git cat-file blob $blob_3 > /dev/null'
-
-test_expect_success \
-    'corrupting header to have too small output buffer fails unpack' \
-    'create_new_pack &&
-     git prune-packed &&
-     printf "\262\001" | do_corrupt_object $blob_1 0 &&
-     test_must_fail git cat-file blob $blob_1 > /dev/null &&
-     test_must_fail git cat-file blob $blob_2 > /dev/null &&
-     test_must_fail git cat-file blob $blob_3 > /dev/null'
+test_expect_success 'initial setup validation' '
+	create_test_files &&
+	create_new_pack &&
+	git prune-packed &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success 'create corruption in header of first object' '
+	do_corrupt_object $blob_1 0 < zero &&
+	test_must_fail git cat-file blob $blob_1 > /dev/null &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	test_must_fail git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... but having a loose copy allows for full recovery' '
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_1 &&
+	mv tmp ${pack}.idx &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... and loose copy of first delta allows for partial recovery' '
+	git prune-packed &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_2 &&
+	mv tmp ${pack}.idx &&
+	test_must_fail git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success 'create corruption in data of first object' '
+	create_new_pack &&
+	git prune-packed &&
+	chmod +w ${pack}.pack &&
+	perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
+	test_must_fail git cat-file blob $blob_1 > /dev/null &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	test_must_fail git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... but having a loose copy allows for full recovery' '
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_1 &&
+	mv tmp ${pack}.idx &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... and loose copy of second object allows for partial recovery' '
+	git prune-packed &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_2 &&
+	mv tmp ${pack}.idx &&
+	test_must_fail git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success 'create corruption in header of first delta' '
+	create_new_pack &&
+	git prune-packed &&
+	do_corrupt_object $blob_2 0 < zero &&
+	git cat-file blob $blob_1 > /dev/null &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	test_must_fail git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... but having a loose copy allows for full recovery' '
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_2 &&
+	mv tmp ${pack}.idx &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... and then a repack "clears" the corruption' '
+	do_repack &&
+	git prune-packed &&
+	git verify-pack ${pack}.pack &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success 'create corruption in data of first delta' '
+	create_new_pack &&
+	git prune-packed &&
+	chmod +w ${pack}.pack &&
+	perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
+	git cat-file blob $blob_1 > /dev/null &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	test_must_fail git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... but having a loose copy allows for full recovery' '
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_2 &&
+	mv tmp ${pack}.idx &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... and then a repack "clears" the corruption' '
+	do_repack &&
+	git prune-packed &&
+	git verify-pack ${pack}.pack &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success 'corruption in delta base reference of first delta (OBJ_REF_DELTA)' '
+	create_new_pack &&
+	git prune-packed &&
+	do_corrupt_object $blob_2 2 < zero &&
+	git cat-file blob $blob_1 > /dev/null &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	test_must_fail git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... but having a loose copy allows for full recovery' '
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_2 &&
+	mv tmp ${pack}.idx &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... and then a repack "clears" the corruption' '
+	do_repack &&
+	git prune-packed &&
+	git verify-pack ${pack}.pack &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success 'corruption #0 in delta base reference of first delta (OBJ_OFS_DELTA)' '
+	create_new_pack --delta-base-offset &&
+	git prune-packed &&
+	do_corrupt_object $blob_2 2 < zero &&
+	git cat-file blob $blob_1 > /dev/null &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	test_must_fail git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... but having a loose copy allows for full recovery' '
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_2 &&
+	mv tmp ${pack}.idx &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... and then a repack "clears" the corruption' '
+	do_repack --delta-base-offset &&
+	git prune-packed &&
+	git verify-pack ${pack}.pack &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success 'corruption #1 in delta base reference of first delta (OBJ_OFS_DELTA)' '
+	create_new_pack --delta-base-offset &&
+	git prune-packed &&
+	printf "\001" | do_corrupt_object $blob_2 2 &&
+	git cat-file blob $blob_1 > /dev/null &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	test_must_fail git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... but having a loose copy allows for full recovery' '
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_2 &&
+	mv tmp ${pack}.idx &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... and then a repack "clears" the corruption' '
+	do_repack --delta-base-offset &&
+	git prune-packed &&
+	git verify-pack ${pack}.pack &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... and a redundant pack allows for full recovery too' '
+	do_corrupt_object $blob_2 2 < zero &&
+	git cat-file blob $blob_1 > /dev/null &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	test_must_fail git cat-file blob $blob_3 > /dev/null &&
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_1 &&
+	git hash-object -t blob -w file_2 &&
+	printf "$blob_1\n$blob_2\n" | git pack-objects .git/objects/pack/pack &&
+	git prune-packed &&
+	mv tmp ${pack}.idx &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success 'corruption of delta base reference pointing to wrong object' '
+	create_new_pack --delta-base-offset &&
+	git prune-packed &&
+	printf "\220\033" | do_corrupt_object $blob_3 2 &&
+	git cat-file blob $blob_1 >/dev/null &&
+	git cat-file blob $blob_2 >/dev/null &&
+	test_must_fail git cat-file blob $blob_3 >/dev/null
+'
+
+test_expect_success '... but having a loose copy allows for full recovery' '
+	mv ${pack}.idx tmp &&
+	git hash-object -t blob -w file_3 &&
+	mv tmp ${pack}.idx &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success '... and then a repack "clears" the corruption' '
+	do_repack --delta-base-offset --no-reuse-delta &&
+	git prune-packed &&
+	git verify-pack ${pack}.pack &&
+	git cat-file blob $blob_1 > /dev/null &&
+	git cat-file blob $blob_2 > /dev/null &&
+	git cat-file blob $blob_3 > /dev/null
+'
+
+test_expect_success 'corrupting header to have too small output buffer fails unpack' '
+	create_new_pack &&
+	git prune-packed &&
+	printf "\262\001" | do_corrupt_object $blob_1 0 &&
+	test_must_fail git cat-file blob $blob_1 > /dev/null &&
+	test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	test_must_fail git cat-file blob $blob_3 > /dev/null
+'
 
 # \0 - empty base
 # \1 - one byte in result
 # \1 - one literal byte (X)
-test_expect_success \
-    'apply good minimal delta' \
-    'printf "\0\1\1X" > minimal_delta &&
-     test-tool delta -p /dev/null minimal_delta /dev/null'
+test_expect_success 'apply good minimal delta' '
+	printf "\0\1\1X" > minimal_delta &&
+	test-tool delta -p /dev/null minimal_delta /dev/null
+'
 
 # \0 - empty base
 # \1 - 1 byte in result
 # \2 - two literal bytes (one too many)
-test_expect_success \
-    'apply delta with too many literal bytes' \
-    'printf "\0\1\2XX" > too_big_literal &&
-     test_must_fail test-tool delta -p /dev/null too_big_literal /dev/null'
+test_expect_success 'apply delta with too many literal bytes' '
+	printf "\0\1\2XX" > too_big_literal &&
+	test_must_fail test-tool delta -p /dev/null too_big_literal /dev/null
+'
 
 # \4 - four bytes in base
 # \1 - one byte in result
 # \221 - copy, one byte offset, one byte size
 #   \0 - copy from offset 0
 #   \2 - copy two bytes (one too many)
-test_expect_success \
-    'apply delta with too many copied bytes' \
-    'printf "\4\1\221\0\2" > too_big_copy &&
-     printf base >base &&
-     test_must_fail test-tool delta -p base too_big_copy /dev/null'
+test_expect_success 'apply delta with too many copied bytes' '
+	printf "\4\1\221\0\2" > too_big_copy &&
+	printf base >base &&
+	test_must_fail test-tool delta -p base too_big_copy /dev/null
+'
 
 # \0 - empty base
 # \2 - two bytes in result
 # \2 - two literal bytes (we are short one)
-test_expect_success \
-    'apply delta with too few literal bytes' \
-    'printf "\0\2\2X" > truncated_delta &&
-     test_must_fail test-tool delta -p /dev/null truncated_delta /dev/null'
+test_expect_success 'apply delta with too few literal bytes' '
+	printf "\0\2\2X" > truncated_delta &&
+	test_must_fail test-tool delta -p /dev/null truncated_delta /dev/null
+'
 
 # \0 - empty base
 # \1 - one byte in result
 # \221 - copy, one byte offset, one byte size
 #   \0 - copy from offset 0
 #   \1 - copy one byte (we are short one)
-test_expect_success \
-    'apply delta with too few bytes in base' \
-    'printf "\0\1\221\0\1" > truncated_base &&
-     test_must_fail test-tool delta -p /dev/null truncated_base /dev/null'
+test_expect_success 'apply delta with too few bytes in base' '
+	printf "\0\1\221\0\1" > truncated_base &&
+	test_must_fail test-tool delta -p /dev/null truncated_base /dev/null
+'
 
 # \4 - four bytes in base
 # \2 - two bytes in result
@@ -366,20 +366,20 @@ test_expect_success \
 #
 # Note that the literal byte is necessary to get past the uninteresting minimum
 # delta size check.
-test_expect_success \
-    'apply delta with truncated copy parameters' \
-    'printf "\4\2\1X\221" > truncated_copy_delta &&
-     printf base >base &&
-     test_must_fail test-tool delta -p base truncated_copy_delta /dev/null'
+test_expect_success 'apply delta with truncated copy parameters' '
+	printf "\4\2\1X\221" > truncated_copy_delta &&
+	printf base >base &&
+	test_must_fail test-tool delta -p base truncated_copy_delta /dev/null
+'
 
 # \0 - empty base
 # \1 - one byte in result
 # \1 - one literal byte (X)
 # \1 - trailing garbage command
-test_expect_success \
-    'apply delta with trailing garbage literal' \
-    'printf "\0\1\1X\1" > tail_garbage_literal &&
-     test_must_fail test-tool delta -p /dev/null tail_garbage_literal /dev/null'
+test_expect_success 'apply delta with trailing garbage literal' '
+	printf "\0\1\1X\1" > tail_garbage_literal &&
+	test_must_fail test-tool delta -p /dev/null tail_garbage_literal /dev/null
+'
 
 # \4 - four bytes in base
 # \1 - one byte in result
@@ -387,19 +387,19 @@ test_expect_success \
 # \221 - copy, one byte offset, one byte size
 #   \0 - copy from offset 0
 #   \1 - copy 1 byte
-test_expect_success \
-    'apply delta with trailing garbage copy' \
-    'printf "\4\1\1X\221\0\1" > tail_garbage_copy &&
-     printf base >base &&
-     test_must_fail test-tool delta -p /dev/null tail_garbage_copy /dev/null'
+test_expect_success 'apply delta with trailing garbage copy' '
+	printf "\4\1\1X\221\0\1" > tail_garbage_copy &&
+	printf base >base &&
+	test_must_fail test-tool delta -p /dev/null tail_garbage_copy /dev/null
+'
 
 # \0 - empty base
 # \1 - one byte in result
 # \1 - one literal byte (X)
 # \0 - bogus opcode
-test_expect_success \
-    'apply delta with trailing garbage opcode' \
-    'printf "\0\1\1X\0" > tail_garbage_opcode &&
-     test_must_fail test-tool delta -p /dev/null tail_garbage_opcode /dev/null'
+test_expect_success 'apply delta with trailing garbage opcode' '
+	printf "\0\1\1X\0" > tail_garbage_opcode &&
+	test_must_fail test-tool delta -p /dev/null tail_garbage_opcode /dev/null
+'
 
 test_done
-- 
gitgitgadget

