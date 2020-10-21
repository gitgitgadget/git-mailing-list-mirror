Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AF2C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 12:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986BE22249
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 12:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7tp/L+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442639AbgJUMvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408138AbgJUMvC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 08:51:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1256C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 05:51:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o7so1425845pgv.6
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQDLRFW4FiYAUG6yGXSGbCtCgG6dpFRXFikvWvF4lr0=;
        b=q7tp/L+T3QrB7Vb9c0x4hAbHXggJHLk1Lk+/vSLrgd27zrfPXiajmF2AO4x/URTmGk
         flFnYUhnE7/4PpnqbbRtr68RSaQIzWV2ImLVSsD67BCB9G2f8XI2GSGi6nOpRIbXMA3A
         fqhmzLxADvoVdCcgohzkJ819EyRw94OMHrG+VfGpS+6c3tTEQV3N3DQ6UtE2T4haIYt8
         XXD/f+bQo6zLZdkMhIC+xLpf0ZWdSAIBw1Kbd5DuCzAzs+sQiAMYo1CzAh/SfeSJ0H+g
         PCgbIeUfO/BjAaH60+Iil8BmwAwiGke62e0pTDRxJWkkVkyfhcqEjGSJ4NEvLSevpiCR
         GwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQDLRFW4FiYAUG6yGXSGbCtCgG6dpFRXFikvWvF4lr0=;
        b=Zx3IAZqYBqvU9eICOInfEe39w7eQdyEHwGIMEYll59ggOyya+lX9qbmY1lNJbKoI4w
         smggWqVKr7MudQ5Dj7++7R4aISwUQvCRnifLzbwy8+baV898O9Ybq5olgHzJx9ZFPHSh
         nnV9wmPH6uEVbJNeigiYZZBdqPHt3PJ0+tKymR/PXpm+5Gi7o5sF+JYiNEE/AK0NSJhC
         9Snk+gbaShJHNBH+BxAHHtWJpD22DPd4CUXk53CsgDFvYZ07pgaaAeuHHwpVoEuWiGUT
         I1yEvjSTitZ5ZWN5x9ofkEQq5SJeKzF/jQFsZZMNIQ/obXZAkvojqfdLjBCtcY0QRtZQ
         DYOQ==
X-Gm-Message-State: AOAM5318tGJnfP+EhCuNL/lpicoHzZSEf1m1Bm2ADXWyefjZuoQYXpiR
        n6iat2e5Hz2Qetcnd0fM7u3Zp1930PxAQg==
X-Google-Smtp-Source: ABdhPJyJzUwvOEul8NrhqjW5SkSQ6I0VMC4vvri42/EjLVj7+dH6BO5/NatqUW4A3DPvXEpYu8Zb+g==
X-Received: by 2002:a62:644c:0:b029:155:fdf4:52ed with SMTP id y73-20020a62644c0000b0290155fdf452edmr3482924pfb.9.1603284660001;
        Wed, 21 Oct 2020 05:51:00 -0700 (PDT)
Received: from localhost.localdomain ([106.215.55.55])
        by smtp.googlemail.com with ESMTPSA id j24sm2054857pjn.9.2020.10.21.05.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:50:59 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v5 3/5][Outreachy] t7102,t7201: remove whitespace after redirect operator
Date:   Wed, 21 Oct 2020 18:18:21 +0530
Message-Id: <20201021124823.2217-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201021124823.2217-1-charvi077@gmail.com>
References: <20201020121152.21645-1-charvi077@gmail.com>
 <20201021124823.2217-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/CodingGuidelines, redirect
operator is written with space before, but no space
after them.

Let's remove these whitespaces after redirect operators.

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7102-reset.sh | 30 +++++++++++++++---------------
 t/t7201-co.sh    | 10 +++++-----
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 2b4cfb2c83..a8c96bf162 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -70,15 +70,15 @@ check_changes () {
 
 test_expect_success 'reset --hard message' '
 	hex=$(git log -1 --format="%h") &&
-	git reset --hard > .actual &&
-	echo HEAD is now at $hex $(commit_msg) > .expected &&
+	git reset --hard >.actual &&
+	echo HEAD is now at $hex $(commit_msg) >.expected &&
 	test_i18ncmp .expected .actual
 '
 
 test_expect_success 'reset --hard message (ISO8859-1 logoutputencoding)' '
 	hex=$(git log -1 --format="%h") &&
-	git -c "i18n.logOutputEncoding=$test_encoding" reset --hard > .actual &&
-	echo HEAD is now at $hex $(commit_msg $test_encoding) > .expected &&
+	git -c "i18n.logOutputEncoding=$test_encoding" reset --hard >.actual &&
+	echo HEAD is now at $hex $(commit_msg $test_encoding) >.expected &&
 	test_i18ncmp .expected .actual
 '
 
@@ -387,25 +387,25 @@ test_expect_success '--hard reset to ORIG_HEAD should clear a fast-forward merge
 '
 
 test_expect_success 'test --mixed <paths>' '
-	echo 1 > file1 &&
-	echo 2 > file2 &&
+	echo 1 >file1 &&
+	echo 2 >file2 &&
 	git add file1 file2 &&
 	test_tick &&
 	git commit -m files &&
 	before1=$(git rev-parse --short HEAD:file1) &&
 	before2=$(git rev-parse --short HEAD:file2) &&
 	git rm file2 &&
-	echo 3 > file3 &&
-	echo 4 > file4 &&
-	echo 5 > file1 &&
+	echo 3 >file3 &&
+	echo 4 >file4 &&
+	echo 5 >file1 &&
 	after1=$(git rev-parse --short $(git hash-object file1)) &&
 	after4=$(git rev-parse --short $(git hash-object file4)) &&
 	git add file1 file3 file4 &&
 	git reset HEAD -- file1 file2 file3 &&
 	test_must_fail git diff --quiet &&
-	git diff > output &&
+	git diff >output &&
 
-	cat > expect <<-EOF &&
+	cat >expect <<-EOF &&
 	diff --git a/file1 b/file1
 	index $before1..$after1 100644
 	--- a/file1
@@ -423,9 +423,9 @@ test_expect_success 'test --mixed <paths>' '
 	EOF
 
 	test_cmp expect output &&
-	git diff --cached > output &&
+	git diff --cached >output &&
 
-	cat > cached_expect <<-EOF &&
+	cat >cached_expect <<-EOF &&
 	diff --git a/file4 b/file4
 	new file mode 100644
 	index 0000000..$after4
@@ -460,14 +460,14 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 	git diff-index --cached --exit-code HEAD
 '
 
-cat > expect << EOF
+cat >expect << EOF
 Unstaged changes after reset:
 M	file2
 EOF
 
 test_expect_success '--mixed refreshes the index' '
 	echo 123 >> file2 &&
-	git reset --mixed HEAD > output &&
+	git reset --mixed HEAD >output &&
 	test_i18ncmp expect output
 '
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b527f8009c..74553f991b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -33,7 +33,7 @@ fill () {
 
 
 test_expect_success setup '
-	fill x y z > same &&
+	fill x y z >same &&
 	fill 1 2 3 4 5 6 7 8 >one &&
 	fill a b c d e >two &&
 	git add same one two &&
@@ -55,7 +55,7 @@ test_expect_success setup '
 
 	git checkout -b simple master &&
 	rm -f one &&
-	fill a c e > two &&
+	fill a c e >two &&
 	git commit -a -m "Simple D one, M two" &&
 
 	git checkout master
@@ -95,7 +95,7 @@ test_expect_success 'checkout -m with dirty tree' '
 	git clean -f &&
 
 	fill 0 1 2 3 4 5 6 7 8 >one &&
-	git checkout -m side > messages &&
+	git checkout -m side >messages &&
 
 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
 
@@ -159,7 +159,7 @@ test_expect_success 'checkout -m with merge conflict' '
 test_expect_success 'format of merge conflict from checkout -m' '
 	git checkout -f master && git clean -f &&
 
-	fill b d > two &&
+	fill b d >two &&
 	git checkout -m simple &&
 
 	git ls-files >current &&
@@ -182,7 +182,7 @@ test_expect_success 'format of merge conflict from checkout -m' '
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	git checkout -f master && git reset --hard && git clean -f &&
 
-	fill b d > two &&
+	fill b d >two &&
 	git checkout --merge --conflict=diff3 simple &&
 
 	cat <<-EOF >expect &&
-- 
2.29.0.rc1

