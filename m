Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C6AC77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjERUER (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjERUDw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EF910F8
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3063433fa66so1589634f8f.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440216; x=1687032216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX9byp9YEf3LduogluBdzZY8lnkvGrb/QWlpSKzr7Eo=;
        b=Acy81lYW1cx8QKuhVeVhYQnr6d3+eaxw3CR5Vm+q1PAUBI42+BsfkZoikbm7u1cnZJ
         MsL1SZLu2RyAZDlreabtSsrXK5GzHUYExYEJ0QSu1JvXRtWWdybQD5B8z1xWT2jJ3VbW
         IifC0VxqmBgdxpfhos/dQWxEDQqoG63Lp5O86+nN7wJJS5pXAuwN5Nr/pjNc7QtfdsQg
         QEeUflnPFuxU/RZXgUEAcv/yAXWlclBLRzyb7HDFZXSX6sFTO+CSywiXadKbAY3ranvW
         yeZdhlODy6I+QKBLc10TG/dz5rNZVtlH9otx+OFcbevHkbn/49XqwyfJSaFLI8EL/7kP
         JqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440216; x=1687032216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX9byp9YEf3LduogluBdzZY8lnkvGrb/QWlpSKzr7Eo=;
        b=FqY5ZxGdqLDtxs/03XHk4sA1oU/YVl3oxIZ+J6ZzMu4amWeNUeHo8HJlB5cqOY1j+H
         7nIddcCZGcoSuNdZ5l6oMduvpdAFaK4qtAj8UFPaNQTRciV1/xWRQ74YoaJXHbjCFf7X
         w9ALeKq6KgAsO1Nt2/xHmL6DsjV1577SbNNvyVeHbVj8bxVQlLZs6xPoMMB661wlDRmM
         ZnrZ57OxNZT04+CgbdU50rfqDPpBkfYwK1jjRaeKEyjSHbw0auOUWxjKA6vAgnnIncko
         jgFAVBosGLu247j1kGAujSebukdCFV7vt+STBjihmEyJ2FuLC/ImdVhCaYguyqLW+02R
         GbIg==
X-Gm-Message-State: AC+VfDxfLo9D29xhMQnKCi+UDyigNkeyF4QXPgsgtqTW7QVH5dpan1U+
        qcDG4Naea+D6+6XiKxmErHxBAxrusmk=
X-Google-Smtp-Source: ACHHUZ6ISx84I1FHMHQyItqZofM95X94M8UyD0r2wQq7vUyLgic18W7y3s36hzEHYcxFIBp8xAfz1g==
X-Received: by 2002:a5d:6306:0:b0:306:37ac:ef8e with SMTP id i6-20020a5d6306000000b0030637acef8emr2387900wru.56.1684440216502;
        Thu, 18 May 2023 13:03:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a1c7302000000b003f3e50eb606sm231449wmb.13.2023.05.18.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:36 -0700 (PDT)
Message-Id: <7b348f3481f52bab876eb22485d3ec21c3f927f4.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:20 +0000
Subject: [PATCH 15/20] t5300-pack-object: modernize test format
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
 t/t5300-pack-object.sh | 184 ++++++++++++++++++++---------------------
 1 file changed, 92 insertions(+), 92 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d2ce236d612..745089479ca 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -208,7 +208,7 @@ test_expect_success 'unpack with OFS_DELTA' '
 '
 
 test_expect_success 'unpack with OFS_DELTA (core.fsyncmethod=batch)' '
-       check_unpack test-3-${packname_3} obj-list "$BATCH_CONFIGURATION"
+	check_unpack test-3-${packname_3} obj-list "$BATCH_CONFIGURATION"
 '
 
 test_expect_success 'compare delta flavors' '
@@ -263,97 +263,97 @@ test_expect_success 'survive missing objects/pack directory' '
 	)
 '
 
-test_expect_success \
-    'verify pack' \
-    'git verify-pack	test-1-${packname_1}.idx \
-			test-2-${packname_2}.idx \
-			test-3-${packname_3}.idx'
-
-test_expect_success \
-    'verify pack -v' \
-    'git verify-pack -v	test-1-${packname_1}.idx \
-			test-2-${packname_2}.idx \
-			test-3-${packname_3}.idx'
-
-test_expect_success \
-    'verify-pack catches mismatched .idx and .pack files' \
-    'cat test-1-${packname_1}.idx >test-3.idx &&
-     cat test-2-${packname_2}.pack >test-3.pack &&
-     if git verify-pack test-3.idx
-     then false
-     else :;
-     fi'
-
-test_expect_success \
-    'verify-pack catches a corrupted pack signature' \
-    'cat test-1-${packname_1}.pack >test-3.pack &&
-     echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
-     if git verify-pack test-3.idx
-     then false
-     else :;
-     fi'
-
-test_expect_success \
-    'verify-pack catches a corrupted pack version' \
-    'cat test-1-${packname_1}.pack >test-3.pack &&
-     echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
-     if git verify-pack test-3.idx
-     then false
-     else :;
-     fi'
-
-test_expect_success \
-    'verify-pack catches a corrupted type/size of the 1st packed object data' \
-    'cat test-1-${packname_1}.pack >test-3.pack &&
-     echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
-     if git verify-pack test-3.idx
-     then false
-     else :;
-     fi'
-
-test_expect_success \
-    'verify-pack catches a corrupted sum of the index file itself' \
-    'l=$(wc -c <test-3.idx) &&
-     l=$(expr $l - 20) &&
-     cat test-1-${packname_1}.pack >test-3.pack &&
-     printf "%20s" "" | dd of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
-     if git verify-pack test-3.pack
-     then false
-     else :;
-     fi'
-
-test_expect_success \
-    'build pack index for an existing pack' \
-    'cat test-1-${packname_1}.pack >test-3.pack &&
-     git index-pack -o tmp.idx test-3.pack &&
-     cmp tmp.idx test-1-${packname_1}.idx &&
-
-     git index-pack --promisor=message test-3.pack &&
-     cmp test-3.idx test-1-${packname_1}.idx &&
-     echo message >expect &&
-     test_cmp expect test-3.promisor &&
-
-     cat test-2-${packname_2}.pack >test-3.pack &&
-     git index-pack -o tmp.idx test-2-${packname_2}.pack &&
-     cmp tmp.idx test-2-${packname_2}.idx &&
-
-     git index-pack test-3.pack &&
-     cmp test-3.idx test-2-${packname_2}.idx &&
-
-     cat test-3-${packname_3}.pack >test-3.pack &&
-     git index-pack -o tmp.idx test-3-${packname_3}.pack &&
-     cmp tmp.idx test-3-${packname_3}.idx &&
-
-     git index-pack test-3.pack &&
-     cmp test-3.idx test-3-${packname_3}.idx &&
-
-     cat test-1-${packname_1}.pack >test-4.pack &&
-     rm -f test-4.keep &&
-     git index-pack --keep=why test-4.pack &&
-     cmp test-1-${packname_1}.idx test-4.idx &&
-     test -f test-4.keep &&
-
-     :'
+test_expect_success 'verify pack' '
+	git verify-pack test-1-${packname_1}.idx \
+		test-2-${packname_2}.idx \
+		test-3-${packname_3}.idx
+'
+
+test_expect_success 'verify pack -v' '
+	git verify-pack -v test-1-${packname_1}.idx \
+		test-2-${packname_2}.idx \
+		test-3-${packname_3}.idx
+'
+
+test_expect_success 'verify-pack catches mismatched .idx and .pack files' '
+	cat test-1-${packname_1}.idx >test-3.idx &&
+	cat test-2-${packname_2}.pack >test-3.pack &&
+	if git verify-pack test-3.idx
+	then false
+	else :;
+	fi
+'
+
+test_expect_success 'verify-pack catches a corrupted pack signature' '
+	cat test-1-${packname_1}.pack >test-3.pack &&
+	echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
+	if git verify-pack test-3.idx
+	then false
+	else :;
+	fi
+'
+
+test_expect_success 'verify-pack catches a corrupted pack version' '
+	cat test-1-${packname_1}.pack >test-3.pack &&
+	echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
+	if git verify-pack test-3.idx
+	then false
+	else :;
+	fi
+'
+
+test_expect_success 'verify-pack catches a corrupted type/size of the 1st packed object data' '
+	cat test-1-${packname_1}.pack >test-3.pack &&
+	echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
+	if git verify-pack test-3.idx
+	then false
+	else :;
+	fi
+'
+
+test_expect_success 'verify-pack catches a corrupted sum of the index file itself' '
+	l=$(wc -c <test-3.idx) &&
+	l=$(expr $l - 20) &&
+	cat test-1-${packname_1}.pack >test-3.pack &&
+	printf "%20s" "" | dd of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
+	if git verify-pack test-3.pack
+	then false
+	else :;
+	fi
+'
+
+test_expect_success 'build pack index for an existing pack' '
+	cat test-1-${packname_1}.pack >test-3.pack &&
+	git index-pack -o tmp.idx test-3.pack &&
+	cmp tmp.idx test-1-${packname_1}.idx &&
+
+	git index-pack --promisor=message test-3.pack &&
+	cmp test-3.idx test-1-${packname_1}.idx &&
+	echo message >expect &&
+	test_cmp expect test-3.promisor &&
+
+	cat test-2-${packname_2}.pack >test-3.pack &&
+	git index-pack -o tmp.idx test-2-${packname_2}.pack &&
+	cmp tmp.idx test-2-${packname_2}.idx &&
+
+	git index-pack test-3.pack &&
+	cmp test-3.idx test-2-${packname_2}.idx &&
+
+	cat test-3-${packname_3}.pack >test-3.pack &&
+	git index-pack -o tmp.idx test-3-${packname_3}.pack &&
+	cmp tmp.idx test-3-${packname_3}.idx &&
+
+	git index-pack test-3.pack &&
+	cmp test-3.idx test-3-${packname_3}.idx &&
+
+	cat test-1-${packname_1}.pack >test-4.pack &&
+	rm -f test-4.keep &&
+	git index-pack --keep=why test-4.pack &&
+	cmp test-1-${packname_1}.idx test-4.idx &&
+	test -f test-4.keep &&
+
+	:
+'
 
 test_expect_success 'unpacking with --strict' '
 
-- 
gitgitgadget

