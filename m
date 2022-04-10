Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C241C433EF
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 11:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiDJLWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 07:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiDJLWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 07:22:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64835554A9
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:20:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s28so3129421wrb.5
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26d2l3y+kfwX6oONuqxEfk9ORE38Fvz9NxVfKItKHW0=;
        b=F6MDzjy8vTEPbUr2TRvAYTAWN4FKnAB1QABjEbgaCVWNs3l6dDU8IkszqRIxTQEOzS
         5KzKvKSI4wu65Hpj2Umxe/JpeRj/8rGxWkE9j4mRNhj+UPwh46egsmSKUh1zWjimnKoQ
         Yf2AVMc3Y9dD450114NpyrdYyisnPQzLfxic5w61CqJpQT4ROkwZFjtbcStE0tLBIU03
         EVqTtsW579W39gEp1jTqRn9uVCcdZQsEGTbL+QP+3gceVd2UkQ087Ohvd+NkIBz5WcSg
         tETh27X4pH4nFmwhwfvNtaazqj93Xba9rSw32qFnpDDiWZV6mGsvmXdNW8lUEvn+KRLn
         CjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26d2l3y+kfwX6oONuqxEfk9ORE38Fvz9NxVfKItKHW0=;
        b=kklUEx7hRBZqNsRs/yPnLStrFQOOs1vref6+lp/rKkhaI1H3U8yuJm/nj1OAkSJGwS
         9n0v+fFiIWCeC8cP7BYXoHL2q1GjJBHPI1aYUP9hC6d79XzuPIYjNdkawthY/B+9H3he
         e5JrBGrfe8XykKEEQwSpeNGZhNVsHOnaXuPGMqY63u2wYto611AXJChuOPDqlyYa1H2Y
         JIysFRtvtytjfydEbGrUxNMk15uQaHvjlNp/TvA8JJwgwkSp3sRrc00utv9PNJMwsgh6
         aYKJGuG1LYQxMhBCk60FXN+MrWUQQlgwJOXwfjWUxoZjSnOE+CAh85+ytImV8Tuz9qlt
         tbyA==
X-Gm-Message-State: AOAM532uxMtQHx9t8bLDQAjBVmk1p0MwsdK++y7YIIfzN+IlZt8gI9Hi
        KXIu9okLQMODdd6ugaSXdOi/oTeFO4Y=
X-Google-Smtp-Source: ABdhPJz8urE2YQn6WX2fCNXnN7XT2v8urnRb7K5wD7dnVjtkh1pW61dBLYzXV97XdMNCizn18vkh6A==
X-Received: by 2002:a5d:47cd:0:b0:207:8f41:df5d with SMTP id o13-20020a5d47cd000000b002078f41df5dmr10798140wrc.163.1649589601964;
        Sun, 10 Apr 2022 04:20:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a18:7100:c718:bf46:5915:85be])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm19149452wmj.18.2022.04.10.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 04:20:01 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [RFC PATCH 1/6] t0066: improve readablity of dir-iterator tests
Date:   Sun, 10 Apr 2022 14:18:47 +0300
Message-Id: <20220410111852.2097418-2-kioplato@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410111852.2097418-1-kioplato@gmail.com>
References: <20220410111852.2097418-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Be consistent throughout the dir-iterator tests regarding the order in
which we:
  * create test directories
  * create expected outputs
  * test if actual and expected outputs differ

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 227 +++++++++++++++++++++-------------------
 1 file changed, 118 insertions(+), 109 deletions(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 63a1a45cd3..fb20219487 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -5,145 +5,154 @@ test_description='Test the dir-iterator functionality'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success 'setup' '
-	mkdir -p dir &&
-	mkdir -p dir/a/b/c/ &&
-	>dir/b &&
-	>dir/c &&
-	mkdir -p dir/d/e/d/ &&
-	>dir/a/b/c/d &&
-	>dir/a/e &&
-	>dir/d/e/d/a &&
-
-	mkdir -p dir2/a/b/c/ &&
-	>dir2/a/b/c/d
+test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
+	mkdir -p dir6/a/b/c &&
+	>dir6/a/b/c/d &&
+
+
+	cat >expected-out <<-EOF
+	[d] (a) [a] ./dir6/a
+	[d] (a/b) [b] ./dir6/a/b
+	[d] (a/b/c) [c] ./dir6/a/b/c
+	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
+	EOF
+'
+test_expect_success 'iteration of dir w/ three nested dirs w/ file' '
+	test-tool dir-iterator ./dir6 >actual-out &&
+	test_cmp expected-out actual-out
 '
 
-test_expect_success 'dir-iterator should iterate through all files' '
-	cat >expected-iteration-sorted-output <<-EOF &&
-	[d] (a) [a] ./dir/a
-	[d] (a/b) [b] ./dir/a/b
-	[d] (a/b/c) [c] ./dir/a/b/c
-	[d] (d) [d] ./dir/d
-	[d] (d/e) [e] ./dir/d/e
-	[d] (d/e/d) [d] ./dir/d/e/d
-	[f] (a/b/c/d) [d] ./dir/a/b/c/d
-	[f] (a/e) [e] ./dir/a/e
-	[f] (b) [b] ./dir/b
-	[f] (c) [c] ./dir/c
-	[f] (d/e/d/a) [a] ./dir/d/e/d/a
+test_expect_success 'setup -- dir w/ complex structure w/o symlinks' '
+	mkdir -p dir11/a/b/c/ &&
+	>dir11/b &&
+	>dir11/c &&
+	>dir11/a/e &&
+	>dir11/a/b/c/d &&
+	mkdir -p dir11/d/e/d/ &&
+	>dir11/d/e/d/a &&
+
+
+	cat >expected-sorted-out <<-EOF
+	[d] (a) [a] ./dir11/a
+	[d] (a/b) [b] ./dir11/a/b
+	[d] (a/b/c) [c] ./dir11/a/b/c
+	[d] (d) [d] ./dir11/d
+	[d] (d/e) [e] ./dir11/d/e
+	[d] (d/e/d) [d] ./dir11/d/e/d
+	[f] (a/b/c/d) [d] ./dir11/a/b/c/d
+	[f] (a/e) [e] ./dir11/a/e
+	[f] (b) [b] ./dir11/b
+	[f] (c) [c] ./dir11/c
+	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
 	EOF
+'
+test_expect_success 'iteration of dir w/ complex structure w/o symlinks' '
+	test-tool dir-iterator ./dir11 >actual-out &&
+	sort actual-out >actual-sorted-out &&
 
-	test-tool dir-iterator ./dir >out &&
-	sort out >./actual-iteration-sorted-output &&
+	test_cmp expected-sorted-out actual-sorted-out
+'
 
-	test_cmp expected-iteration-sorted-output actual-iteration-sorted-output
+test_expect_success 'dir_iterator_begin() should fail upon inexistent paths' '
+	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-out &&
+
+	test_must_fail test-tool dir-iterator ./inexistent-path >actual-out &&
+	test_cmp expected-inexistent-path-out actual-out
 '
 
-test_expect_success 'dir-iterator should list files in the correct order' '
-	cat >expected-pre-order-output <<-EOF &&
-	[d] (a) [a] ./dir2/a
-	[d] (a/b) [b] ./dir2/a/b
-	[d] (a/b/c) [c] ./dir2/a/b/c
-	[f] (a/b/c/d) [d] ./dir2/a/b/c/d
-	EOF
+test_expect_success 'dir_iterator_begin() should fail upon non directory paths' '
+	>some-file &&
 
-	test-tool dir-iterator ./dir2 >actual-pre-order-output &&
 
-	test_cmp expected-pre-order-output actual-pre-order-output
-'
+	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-out &&
 
-test_expect_success 'begin should fail upon inexistent paths' '
-	test_must_fail test-tool dir-iterator ./inexistent-path \
-		>actual-inexistent-path-output &&
-	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-output &&
-	test_cmp expected-inexistent-path-output actual-inexistent-path-output
-'
+	test_must_fail test-tool dir-iterator ./some-file >actual-out &&
+	test_cmp expected-non-dir-out actual-out &&
 
-test_expect_success 'begin should fail upon non directory paths' '
-	test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output &&
-	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-output &&
-	test_cmp expected-non-dir-output actual-non-dir-output
+	test_must_fail test-tool dir-iterator --pedantic ./some-file >actual-out &&
+	test_cmp expected-non-dir-out actual-out
 '
 
-test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by default' '
-	cat >expected-no-permissions-output <<-EOF &&
-	[d] (a) [a] ./dir3/a
-	EOF
+test_expect_success POSIXPERM,SANITY \
+'dir_iterator_advance() should not fail on errors by default' '
 
-	mkdir -p dir3/a &&
-	>dir3/a/b &&
-	chmod 0 dir3/a &&
+	mkdir -p dir13/a &&
+	>dir13/a/b &&
+	chmod 0 dir13/a &&
 
-	test-tool dir-iterator ./dir3 >actual-no-permissions-output &&
-	test_cmp expected-no-permissions-output actual-no-permissions-output &&
-	chmod 755 dir3/a &&
-	rm -rf dir3
-'
 
-test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w/ pedantic flag' '
-	cat >expected-no-permissions-pedantic-output <<-EOF &&
-	[d] (a) [a] ./dir3/a
-	dir_iterator_advance failure
+	cat >expected-no-permissions-out <<-EOF &&
+	[d] (a) [a] ./dir13/a
 	EOF
 
-	mkdir -p dir3/a &&
-	>dir3/a/b &&
-	chmod 0 dir3/a &&
+	test-tool dir-iterator ./dir13 >actual-out &&
+	test_cmp expected-no-permissions-out actual-out &&
 
-	test_must_fail test-tool dir-iterator --pedantic ./dir3 \
-		>actual-no-permissions-pedantic-output &&
-	test_cmp expected-no-permissions-pedantic-output \
-		actual-no-permissions-pedantic-output &&
-	chmod 755 dir3/a &&
-	rm -rf dir3
+	chmod 755 dir13/a &&
+	rm -rf dir13
 '
 
-test_expect_success SYMLINKS 'setup dirs with symlinks' '
-	mkdir -p dir4/a &&
-	mkdir -p dir4/b/c &&
-	>dir4/a/d &&
-	ln -s d dir4/a/e &&
-	ln -s ../b dir4/a/f &&
-
-	mkdir -p dir5/a/b &&
-	mkdir -p dir5/a/c &&
-	ln -s ../c dir5/a/b/d &&
-	ln -s ../ dir5/a/b/e &&
-	ln -s ../../ dir5/a/b/f
-'
+test_expect_success POSIXPERM,SANITY \
+'dir_iterator_advance() should fail on errors, w/ pedantic flag' '
 
-test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default' '
-	cat >expected-no-follow-sorted-output <<-EOF &&
-	[d] (a) [a] ./dir4/a
-	[d] (b) [b] ./dir4/b
-	[d] (b/c) [c] ./dir4/b/c
-	[f] (a/d) [d] ./dir4/a/d
-	[s] (a/e) [e] ./dir4/a/e
-	[s] (a/f) [f] ./dir4/a/f
+	mkdir -p dir13/a &&
+	>dir13/a/b &&
+	chmod 0 dir13/a &&
+
+
+	cat >expected-no-permissions-pedantic-out <<-EOF &&
+	[d] (a) [a] ./dir13/a
+	dir_iterator_advance failure
 	EOF
 
-	test-tool dir-iterator ./dir4 >out &&
-	sort out >actual-no-follow-sorted-output &&
+	test_must_fail test-tool dir-iterator --pedantic ./dir13 >actual-out &&
+	test_cmp expected-no-permissions-pedantic-out actual-out &&
 
-	test_cmp expected-no-follow-sorted-output actual-no-follow-sorted-output
+	chmod 755 dir13/a &&
+	rm -rf dir13
 '
 
-test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag' '
-	cat >expected-follow-sorted-output <<-EOF &&
-	[d] (a) [a] ./dir4/a
-	[d] (a/f) [f] ./dir4/a/f
-	[d] (a/f/c) [c] ./dir4/a/f/c
-	[d] (b) [b] ./dir4/b
-	[d] (b/c) [c] ./dir4/b/c
-	[f] (a/d) [d] ./dir4/a/d
-	[f] (a/e) [e] ./dir4/a/e
+test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
+	mkdir -p dir14/a &&
+	mkdir -p dir14/b/c &&
+	>dir14/a/d &&
+	ln -s d dir14/a/e &&
+	ln -s ../b dir14/a/f &&
+
+
+	cat >expected-dont-follow-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir14/a
+	[d] (b) [b] ./dir14/b
+	[d] (b/c) [c] ./dir14/b/c
+	[f] (a/d) [d] ./dir14/a/d
+	[s] (a/e) [e] ./dir14/a/e
+	[s] (a/f) [f] ./dir14/a/f
 	EOF
+	cat >expected-follow-sorted-out <<-EOF
+	[d] (a) [a] ./dir14/a
+	[d] (a/f) [f] ./dir14/a/f
+	[d] (a/f/c) [c] ./dir14/a/f/c
+	[d] (b) [b] ./dir14/b
+	[d] (b/c) [c] ./dir14/b/c
+	[f] (a/d) [d] ./dir14/a/d
+	[f] (a/e) [e] ./dir14/a/e
+	EOF
+'
+test_expect_success SYMLINKS \
+'dont-follow-symlinks of dir w/ symlinks w/o cycle' '
+
+	test-tool dir-iterator ./dir14 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-dont-follow-sorted-out actual-sorted-out
+'
+test_expect_success SYMLINKS \
+'follow-symlinks of dir w/ symlinks w/o cycle' '
 
-	test-tool dir-iterator --follow-symlinks ./dir4 >out &&
-	sort out >actual-follow-sorted-output &&
+	test-tool dir-iterator --follow-symlinks ./dir14 >actual-out &&
+	sort actual-out >actual-sorted-out &&
 
-	test_cmp expected-follow-sorted-output actual-follow-sorted-output
+	test_cmp expected-follow-sorted-out actual-sorted-out
 '
 
 test_done
-- 
2.35.1

