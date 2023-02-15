Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31258C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 02:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjBOCk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjBOCkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 21:40:51 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87ED28239
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:50 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c2so20504293qtw.5
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35iftTChXhbYCh3E5Wk4+TdQiuf6+npXGgVuS6deYQI=;
        b=AWrn08OzcUkfPamIxPcSLm9SLa6Z/pHfNCcuzgQ9pCHBkyaei+SXdARyulklxaWVv6
         XD3tjqgBBPz9/WhcGnFWW4feCCamH+kY2k/lHC4WoHW5WwZPWk0vCr6XeXYwoDy7Fs+E
         e2Gj9APGHJskF5baXM30ijcPd8HG3D6D/bF4AF2Pr9GdzX0a4ntax06/o+BKjfoFHP6L
         SMrOEpaS+Kk1zlYiEceoNXgMUkfmzWS/sOXcwbY4I0Xmi6pcTNSJDFZOsKej7dL6HrG3
         MKYATZCHjR42yTmEsKs9ES5xG+o3gnUYwIcfgnIxUb4KZNS/+4Mxrg4xoJ3AUs22EIhI
         gOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35iftTChXhbYCh3E5Wk4+TdQiuf6+npXGgVuS6deYQI=;
        b=Z4PVh9vDN77JrGRmMjZ9KHUPr3+N1xq7fOvokD0651r4JwOnmf9Jqocr9w3/DRfve8
         Aw+yqQNyyG3E56lDy7226Xbwz4ZySAzPx/aG/X/oZHLfYCAcxR4OOX1LlPt17ynq3Ayk
         bVRuiQIOapPnlChnTb0XKNFWQvUvg6dzrpnGaZ/RtXhRsx+EJF4ggVIAaN7HNTBzU+E9
         IJiKZCOuYeJlmHujb/MjzGgcHFN0zBeDvCVgKdbecBagKxpnF9pkg1DealmvNH7/j6vt
         5f0AQNjBdbcQM9nbRIoIHP2e7NkO9/9n0qGOla27iHRTEgrpgQXe3XdmMJ1G1/5eB/VC
         BiTQ==
X-Gm-Message-State: AO0yUKXs/ZscpQ4Ru9LDuaP0DEqzM7OvTA7zQcNvCNQ/y1E0UxT14keb
        aWbxzkoWnaLGtmI2A1Y9VUqPvXRvbNl8lQ==
X-Google-Smtp-Source: AK7set+I3+HAMstc/+EjgBNFTyogjTV1WS5EBay8wRJk94O0vC7+Zyur6PMv4TFmv9XcwDAEJ62iGw==
X-Received: by 2002:a05:622a:a028:b0:3b9:bc8c:c209 with SMTP id jt40-20020a05622aa02800b003b9bc8cc209mr2458034qtb.20.1676428849447;
        Tue, 14 Feb 2023 18:40:49 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id e184-20020a3769c1000000b0073b69922cfesm1069734qkc.85.2023.02.14.18.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:40:47 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v6 3/3] t4113: put executable lines to test_expect_success
Date:   Tue, 14 Feb 2023 21:39:53 -0500
Message-Id: <20230215023953.11880-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215023953.11880-1-cheskaqiqi@gmail.com>
References: <20230209154417.10763-1-cheskaqiqi@gmail.com>
 <20230215023953.11880-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As t/README says, put all code inside test_expect_success and
other assertions. This old test scripts have setup code
outside of tests. This is problematic since any failures of the
setup code will go unnoticed. Therefore, move setup code into the tests
themselves so that failures are properly flagged. t/README also says,
use "<<-" instead of "<<" to strip leading TABs used for indentation.
Fix it. We should chain test assertions(t/README). Therefore,Chain
this test assertions with &&. What's more,take advantage of modern
style. Use test_write_lines instead.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 55 ++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index a470c9ce7b..56fc2f436b 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -8,46 +8,39 @@ test_description='git apply trying to add an ending line.
 '
 . ./test-lib.sh
 
-# setup
-
-cat >test-patch <<\EOF
-diff --git a/file b/file
---- a/file
-+++ b/file
-@@ -1,2 +1,3 @@
- a
- b
-+c
-EOF
-
-echo 'a' >file
-echo 'b' >>file
-echo 'c' >>file
-
 test_expect_success setup '
+	cat >test-patch <<-\EOF &&
+	diff --git a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,3 @@
+	 a
+	 b
+	+c
+	EOF
+
+	test_write_lines a b c >file &&
 	git update-index --add file
 '
-# test
 
 test_expect_success 'apply at the end' '
 	test_must_fail git apply --index test-patch
 '
-cat >test-patch <<\EOF
-diff a/file b/file
---- a/file
-+++ b/file
-@@ -1,2 +1,3 @@
-+a
- b
- c
-EOF
-
-echo >file 'a
-b
-c'
-git update-index file
 
 test_expect_success 'apply at the beginning' '
+	cat >test-patch <<-\EOF &&
+	diff a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,3 @@
+	+a
+	 b
+	 c
+	EOF
+
+	test_write_lines a b c >file &&
+	git update-index file &&
 	test_must_fail git apply --index test-patch
 '
+
 test_done
-- 
2.39.0

