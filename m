Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCA8C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 17:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjBBRUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjBBRT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 12:19:59 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8A73772
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 09:19:58 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id u7so1033126ilg.4
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 09:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsvqzuO1UoCFSuxPs7rAwnQLOWLKUAxA57LRDPQvoag=;
        b=G0BdhuHknXU3ji1uuTlIZYgVTTqzk6YLt4QXW71RhTr54vA6dW4j+KkuP2bGdXPmM2
         KSrUcK6K39fGtLQ8hySP7iLp/5VSWliLsmCdOgmJ0XcB48LcyPffgNbwTpVuBRltAyZf
         4Pt6nzzwNexPimOoeOTj3xQFqqC+jKb7LdPwa4TuHZa/sew2dXxU8QtvT99VAL1FyrXQ
         dii1KxKP1EYTATszdK6637y7WMW4SxPZmKA5oh2h1GU/ZYBHi2MqZFak0YT1cFe9k8jV
         Moy1IrULeImRBBBWTyQvPAk+T4eqUDuQKcERas8zZdkC4yLy+AyLujSmOKmylIT7bvMV
         6QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsvqzuO1UoCFSuxPs7rAwnQLOWLKUAxA57LRDPQvoag=;
        b=5VOici02AVmD7CE3dazP1azaowAMka6/3VqaJCPjouYoFOenhYukV2tvBCBCgHKcTc
         6/i3/DbFYlbRjbzx+ZFWDFbVRIXlBZZagWSrCCY2oYw00Fc/Oa4y2m3MIuvGdTp6v1eZ
         4Di36WwTaLUWiUof+hL/brNSmLe5+c2cWFPd4P7YREiFsTjJD8mOchhmynNN2sHCg1PN
         ds5GeTqVvVk3j/G45bzFPyKTqAGULMeCSoRUrYIGtSTiI5CSoHj2AZqGwXeF0yRGOvNL
         dDEtisWbxTdyZehGHBaTrRb7lJzHdTP2WD+nuSFNjBhV3VM0h9EtZsUbwEUoM2zufEle
         SuZQ==
X-Gm-Message-State: AO0yUKXRZFkEm65UyMw1iEyznM2+DhvO1wLnCzpARqKouA43ujUh4R1P
        EzCB3kA7ZvH5myZwiRqA7y5hNkWEYu6opw==
X-Google-Smtp-Source: AK7set/Vh0ImAi7TZD6z+0mlLtEtktIgISOwag5SutFg7oVow3ft4BbesRB2QSnN0825eORownDXWw==
X-Received: by 2002:a05:6e02:1566:b0:310:b39f:1d11 with SMTP id k6-20020a056e02156600b00310b39f1d11mr6078003ilu.12.1675358397494;
        Thu, 02 Feb 2023 09:19:57 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a3-20020a92d343000000b0030bfdb6ef60sm55887ilh.58.2023.02.02.09.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:19:57 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v2 2/4] t4113:put second creation in own step
Date:   Thu,  2 Feb 2023 12:18:19 -0500
Message-Id: <20230202171821.10508-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202171821.10508-1-cheskaqiqi@gmail.com>
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
 <20230202171821.10508-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

files "test-patch" and "file" are created twice.put the second creation 
of the files to its own step'setup for apply at the beginning'.

Make the second creation of the files its own step
'setup for apply at the beginning'.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index aa57895b22..d84f632bc3 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -8,8 +8,6 @@ test_description='git apply trying to add an ending line.
 '
 . ./test-lib.sh
 
-# setup
-
 cat >test-patch <<\EOF
 diff --git a/file b/file
 --- a/file
@@ -27,26 +25,27 @@ echo 'c' >>file
 test_expect_success setup '
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
+test_expect_success 'setup for apply at the beginning' '
+	cat >test-patch <<\EOF
+	diff a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,3 @@
+	+a
+	b
+	c
+	EOF
+
+	echo >file 'a
+	b
+	c'
+	git update-index file
+'
 
 test_expect_success 'apply at the beginning' '
     test_must_fail git apply --index test-patch
-- 
2.39.0

