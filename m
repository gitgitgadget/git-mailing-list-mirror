Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C228C77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjERUED (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjERUDu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14010D9
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30948709b3cso914022f8f.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440214; x=1687032214;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkcYSR3fwPn3MtxKdihTiuxXUNGFu5g6Ovg+qQ4XcMM=;
        b=QkHrvvWZf3PRbgRvQuk6oI0tFhE2qH4LVxbvM7e/Kf9aDDkMWKoYp0CpJ6vh/6jXu/
         RWB3bAt0v+lNR3NbSq/caQVFmZQTQXCEyVSRtoBukh7o/tyTRrOtxKJmAnquJXQG6xvf
         yZi7Qoy/YMZcq1ozwv+iX+1DXK5xc6IjW8D/bG3dQCV9AB8B0Bs9JsXpy1Bb9XqcB2HG
         oCoJfZ2deE9YG8QDUoYfjA14q6ZTwdPEieVz8ZTk8EEZzQI+aT5S2ENRJgVE3HCkvkHL
         SCX7K7z5PYAm2N4bZ3i1zd8WUy8e59CRWaooo92BzEgaw7afVFoxLRdjJxBosfecGmq9
         i+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440214; x=1687032214;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkcYSR3fwPn3MtxKdihTiuxXUNGFu5g6Ovg+qQ4XcMM=;
        b=k0PxSURZdy5zEmjkdNIB0c+JvTjKFtiD01v8FBqNhFnQ3eEDchyJ3s4+pvmlgfsy0s
         d5ScQLibpNZn56IcfeLsGXT7aIhItIwq9lVpiKAOjd1XxcmY1VyFnT1BKMVAZZ0suazt
         gaHXtlGIJx1wQZPFMZbtmf+2zFHuHSd79M5zhfFxsPWZG+p+apPcc4EOsd48VneG/HEI
         4WhMKCuP3H7HOGEBhDEjnyt4Q3FohOgA3rh266RsKsVxfb3WP5P0kCOHmq894LBoeOxq
         F2zDuAFi975Lq5oa/sysr92TvYv3NtVaVx7PFDxGnbfiz8v7lNlnree9SQuCZpQihWmx
         VIIg==
X-Gm-Message-State: AC+VfDzGyv09dXv/sp0xZw37rKMg3igw6sG7p4U1C3jUXS5qDGolAQoO
        dVUaQPcXf1R12B8y9dgA6c01QTRcatk=
X-Google-Smtp-Source: ACHHUZ43nzxB8qjlsqXJQphGl2Qy0RjZat0iVzTTNXEn1JRyL2ABdMlKPF3ez9c7+oybWJPl7z2kwA==
X-Received: by 2002:adf:f405:0:b0:2f9:61d4:1183 with SMTP id g5-20020adff405000000b002f961d41183mr2765459wro.45.1684440214542;
        Thu, 18 May 2023 13:03:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18-20020adff152000000b002e61e002943sm3038880wro.116.2023.05.18.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:34 -0700 (PDT)
Message-Id: <5ed43aca06f9617c0dd7425b14d0e8c470c2c72d.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:17 +0000
Subject: [PATCH 12/20] t4004-diff-rename-symlink: modernize test format
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
 t/t4004-diff-rename-symlink.sh | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index 8def4d4aee9..1d70d4d221b 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -14,21 +14,21 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
-test_expect_success SYMLINKS \
-    'prepare reference tree' \
-    'echo xyzzy | tr -d '\\\\'012 >yomin &&
-     ln -s xyzzy frotz &&
-    git update-index --add frotz yomin &&
-    tree=$(git write-tree) &&
-    echo $tree'
+test_expect_success SYMLINKS 'prepare reference tree' '
+	echo xyzzy | tr -d '\\\\'012 >yomin &&
+	ln -s xyzzy frotz &&
+	git update-index --add frotz yomin &&
+	tree=$(git write-tree) &&
+	echo $tree
+'
 
-test_expect_success SYMLINKS \
-    'prepare work tree' \
-    'mv frotz rezrov &&
-     rm -f yomin &&
-     ln -s xyzzy nitfol &&
-     ln -s xzzzy bozbar &&
-    git update-index --add --remove frotz rezrov nitfol bozbar yomin'
+test_expect_success SYMLINKS 'prepare work tree' '
+	mv frotz rezrov &&
+	rm -f yomin &&
+	ln -s xyzzy nitfol &&
+	ln -s xzzzy bozbar &&
+	git update-index --add --remove frotz rezrov nitfol bozbar yomin
+'
 
 # tree has frotz pointing at xyzzy, and yomin that contains xyzzy to
 # confuse things.  work tree has rezrov (xyzzy) nitfol (xyzzy) and
@@ -36,9 +36,9 @@ test_expect_success SYMLINKS \
 # rezrov and nitfol are rename/copy of frotz and bozbar should be
 # a new creation.
 
-test_expect_success SYMLINKS 'setup diff output' "
-    GIT_DIFF_OPTS=--unified=0 git diff-index -C -p $tree >current &&
-    cat >expected <<\EOF
+test_expect_success SYMLINKS 'setup diff output' '
+	GIT_DIFF_OPTS=--unified=0 git diff-index -C -p $tree >current &&
+	cat >expected <<\EOF
 diff --git a/bozbar b/bozbar
 new file mode 120000
 --- /dev/null
@@ -62,10 +62,10 @@ deleted file mode 100644
 -xyzzy
 \ No newline at end of file
 EOF
-"
+'
 
-test_expect_success SYMLINKS \
-    'validate diff output' \
-    'compare_diff_patch current expected'
+test_expect_success SYMLINKS 'validate diff output' '
+	compare_diff_patch current expected
+'
 
 test_done
-- 
gitgitgadget

