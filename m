Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A89C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbiEIR7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbiEIR6z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:58:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A32CCD1F
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a21so17206533edb.1
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8P4P8Bx/34XhG7chSqDwFYnBiBuSuKjkYNCtVMS3Rg=;
        b=nDMlsuRHtpDSIwKx+1tkxJaOrkk2kRCA1wHEx1FLc+Z7PM6yOtI2XySRIc9EUqwqmg
         qzYITKeu484HttDadrlPZq+5m2oAGZ8L+51aMdu/k/JiDO4g0KlX4QmRCTuM59Q+gsW6
         kFT1n5gdSTIzRbUgoE/GNxnCwXnQKg0LGRlBnNiy7fu541chD21U6DejTZagzZ7WTQKg
         t828s44JLnh1RqH9eKtBgibiL32/oj6LLhcc8s6w2HRmaAxgGI1OB8lmnJ/R2jgaCHtL
         c/xoIFvpsj5Miujax1K1bbKiwFp1sC1JUiXyBT6n9tC6X+mfLnbuVZcl497iiJbc0cR2
         61VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8P4P8Bx/34XhG7chSqDwFYnBiBuSuKjkYNCtVMS3Rg=;
        b=Dhd7PpRtsZzAkY5SNltrJGOEOQ6J9j6H/dhi/7NgsgAdpHTjVN4TQw6AYnCYoeGusJ
         qQo43w3txP85R5M3R6W7/Pee0H/ZM0SYLeRftkxbJWN6PDvoMcA1xXzZpbBHf6viC/HG
         HNcl1Z/OIZlhWcGiAKXc/YTN9p56aEH9+u8fPDRKDYvsdbKe1jvW2TwugynL6f+8fn9k
         4/spFFWG+RjgkI/ycWoy2eQfdrHyErp8u34J+cM6F1ALJdaLAFHhpEj/L7dA8aLsFw4e
         dr6+3hNGyYVe0ywUO3jq3PS7IK0wTKmC4BTHJ7GqoJM/GKhpUtd2q47NjdApWuuIqQQH
         wVVQ==
X-Gm-Message-State: AOAM532ood+zaDo3g4QT0vcvdl2OmuoHosydai3SeboghvcMu+dxJGn5
        ZBYcnC363RuU+SL39UWX/nNZ0rn03TQ=
X-Google-Smtp-Source: ABdhPJxrojBYAZCVZh2T9s8c5hQkiW3VpcBDyLz4d3qH9Ntt3pdUsSZtOs6LvIdUKbJKVKlUNCV9Vw==
X-Received: by 2002:a05:6402:1941:b0:413:2b7e:676e with SMTP id f1-20020a056402194100b004132b7e676emr19056894edz.114.1652118899675;
        Mon, 09 May 2022 10:54:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:54:59 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 03/15] t0066: shorter expected and actual output file names
Date:   Mon,  9 May 2022 20:51:47 +0300
Message-Id: <20220509175159.2948802-4-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the names of expected-* and actual-* files to shorter ones to
improve readability, avoiding line breaks. There is no reason to have
descriptive expected-* and actual-* file names since subtests
descriptions fulfill this need.

If a test fails we can re-run it with --run flag and read its expected
and actual outputs, since each subtest shares the same file names for
expected and actual outputs.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 59 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 801749eb7e..b21c58ade3 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup -- dir w/ complex structure' '
 	>dir/d/e/d/a
 '
 test_expect_success 'dir-iterator should iterate through all files' '
-	cat >expected-iteration-sorted-output <<-EOF &&
+	cat >expected-sorted-out <<-EOF &&
 	[d] (a) [a] ./dir/a
 	[d] (a/b) [b] ./dir/a/b
 	[d] (a/b/c) [c] ./dir/a/b/c
@@ -30,10 +30,10 @@ test_expect_success 'dir-iterator should iterate through all files' '
 	[f] (d/e/d/a) [a] ./dir/d/e/d/a
 	EOF
 
-	test-tool dir-iterator ./dir >out &&
-	sort out >./actual-iteration-sorted-output &&
+	test-tool dir-iterator ./dir >actual-out &&
+	sort actual-out >actual-sorted-out &&
 
-	test_cmp expected-iteration-sorted-output actual-iteration-sorted-output
+	test_cmp expected-sorted-out actual-sorted-out
 '
 
 test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
@@ -41,35 +41,34 @@ test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
 	>dir2/a/b/c/d
 '
 test_expect_success 'dir-iterator should list files in the correct order' '
-	cat >expected-pre-order-output <<-EOF &&
+	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir2/a
 	[d] (a/b) [b] ./dir2/a/b
 	[d] (a/b/c) [c] ./dir2/a/b/c
 	[f] (a/b/c/d) [d] ./dir2/a/b/c/d
 	EOF
 
-	test-tool dir-iterator ./dir2 >actual-pre-order-output &&
+	test-tool dir-iterator ./dir2 >actual-out &&
 
-	test_cmp expected-pre-order-output actual-pre-order-output
+	test_cmp expected-out actual-out
 '
 
 test_expect_success 'begin should fail upon inexistent paths' '
-	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-output &&
+	echo "dir_iterator_begin failure: ENOENT" >expected-out &&
 
-	test_must_fail test-tool dir-iterator ./inexistent-path \
-		>actual-inexistent-path-output &&
+	test_must_fail test-tool dir-iterator ./inexistent-path >actual-out &&
 
-	test_cmp expected-inexistent-path-output actual-inexistent-path-output
+	test_cmp expected-out actual-out
 '
 
 test_expect_success 'begin should fail upon non directory paths' '
 	>some-file &&
 
-	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-output &&
+	echo "dir_iterator_begin failure: ENOTDIR" >expected-out &&
 
-	test_must_fail test-tool dir-iterator ./some-file >actual-non-dir-output &&
+	test_must_fail test-tool dir-iterator ./some-file >actual-out &&
 
-	test_cmp expected-non-dir-output actual-non-dir-output
+	test_cmp expected-out actual-out
 '
 
 test_expect_success POSIXPERM,SANITY 'setup -- dir w/ dir w/o perms w/ file' '
@@ -77,28 +76,28 @@ test_expect_success POSIXPERM,SANITY 'setup -- dir w/ dir w/o perms w/ file' '
 	>dir3/a/b
 '
 test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by default' '
-	cat >expected-no-permissions-output <<-EOF &&
+	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir3/a
 	EOF
 
 	chmod 0 dir3/a &&
 
-	test-tool dir-iterator ./dir3 >actual-no-permissions-output &&
-	test_cmp expected-no-permissions-output actual-no-permissions-output &&
+	test-tool dir-iterator ./dir3 >actual-out &&
+	test_cmp expected-out actual-out &&
+
 	chmod 755 dir3/a
 '
 test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w/ pedantic flag' '
-	cat >expected-no-permissions-pedantic-output <<-EOF &&
+	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir3/a
 	dir_iterator_advance failure
 	EOF
 
 	chmod 0 dir3/a &&
 
-	test_must_fail test-tool dir-iterator --pedantic ./dir3 \
-		>actual-no-permissions-pedantic-output &&
-	test_cmp expected-no-permissions-pedantic-output \
-		actual-no-permissions-pedantic-output &&
+	test_must_fail test-tool dir-iterator --pedantic ./dir3 >actual-out &&
+	test_cmp expected-out actual-out &&
+
 	chmod 755 dir3/a
 '
 
@@ -110,7 +109,7 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
 	ln -s ../b dir4/a/f
 '
 test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default' '
-	cat >expected-no-follow-sorted-output <<-EOF &&
+	cat >expected-sorted-out <<-EOF &&
 	[d] (a) [a] ./dir4/a
 	[d] (b) [b] ./dir4/b
 	[d] (b/c) [c] ./dir4/b/c
@@ -119,13 +118,13 @@ test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default
 	[s] (a/f) [f] ./dir4/a/f
 	EOF
 
-	test-tool dir-iterator ./dir4 >out &&
-	sort out >actual-no-follow-sorted-output &&
+	test-tool dir-iterator ./dir4 >actual-out &&
+	sort actual-out >actual-sorted-out &&
 
-	test_cmp expected-no-follow-sorted-output actual-no-follow-sorted-output
+	test_cmp expected-sorted-out actual-sorted-out
 '
 test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag' '
-	cat >expected-follow-sorted-output <<-EOF &&
+	cat >expected-sorted-out <<-EOF &&
 	[d] (a) [a] ./dir4/a
 	[d] (a/f) [f] ./dir4/a/f
 	[d] (a/f/c) [c] ./dir4/a/f/c
@@ -135,10 +134,10 @@ test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag
 	[f] (a/e) [e] ./dir4/a/e
 	EOF
 
-	test-tool dir-iterator --follow-symlinks ./dir4 >out &&
-	sort out >actual-follow-sorted-output &&
+	test-tool dir-iterator --follow-symlinks ./dir4 >actual-out &&
+	sort actual-out >actual-sorted-out &&
 
-	test_cmp expected-follow-sorted-output actual-follow-sorted-output
+	test_cmp expected-sorted-out actual-sorted-out
 '
 
 test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
-- 
2.36.1

