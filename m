Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE12C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 14:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBEOxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 09:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBEOxb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 09:53:31 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6C61E1F5
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 06:53:30 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z17so632942ilm.7
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 06:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MxSVkpTBKvyq2ZLxVxrwRVw4QL9qD4OKkKY45ZRqNA=;
        b=DW28ZLGRfnGLmT4NMrib/MKYm/JJHsiTyLC5Ck+YpI5gUtJx4V2kFB54OmqOFQbHpq
         SgTBWd8Sw4HotzYSGmJiVQjPZ2QA5TlZDTNPlBIwmsGHEraKrr89lb7d8u6orSPYpRvx
         u9/yIGRKygkKjsAaZwx+lUTXog9Yn85fa846domWFEL19iJtbQ/mqKu0B6GIDTVQMT57
         +FHB1L0Mk95aHRAEYhkr6gr9jnWfCLj0s9i69D3knbtwy6lojoMRaplOBGkh1uENDs3o
         xtQQaUjz9WerV6OMGRKWb+/7hDBxltjM4uf9KI85+qXUVxvgQnDTVpDN5STiLdTrWJXv
         /uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MxSVkpTBKvyq2ZLxVxrwRVw4QL9qD4OKkKY45ZRqNA=;
        b=RI9b8DqBRvmepeFM+8zOCKDw4JGEvne0febK7nvQIu+pTgiCfmfwozJ+ZUVaz6qgmv
         EveaPPugMYsly3n58XmbggK3HVdL2RVNMIQcWNzO53Xw9NonymuSpVbT6Qy+hGYRxU/w
         l00P0NiIBhYZvswGtW2c21WA+f5ozpB7UUFOOGBBXMfjpnx9HQ+2SXsA/TaiktqQ6ivW
         CtcqhBvgkVrmPrRpR74KdBjMJSnB7BbJa0Yw6w831TUKVOkqsW1KWK/hg2S4IwrbXHGj
         89Yd/J49RCjLdCqVIALshWVz7Pkw8Wlai8LzJuXQb1unNVwd4lwJL6LbPjKjHceAr4PH
         HzAg==
X-Gm-Message-State: AO0yUKUDi2k+uRgpwBumoJt1tGQlbot0+3WFwtb80L/R+qxeOJ6ne5Ii
        j9tn4MtOLblOpoQoPyc3lR+pOObgKCbzUg==
X-Google-Smtp-Source: AK7set8v2i3vWQqlzwFjsQ+SWikMUrgL4xb3Jxu+loeZdHJPWfgC7juhWBrLL0CSolxkYf94NJKX8w==
X-Received: by 2002:a05:6e02:1528:b0:313:b792:3d8f with SMTP id i8-20020a056e02152800b00313b7923d8fmr3381310ilu.31.1675608809207;
        Sun, 05 Feb 2023 06:53:29 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056e02097200b00310a5b8504asm2518227ilt.36.2023.02.05.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 06:53:28 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v3 2/3] t4113: put executable lines to test_expect_success
Date:   Sun,  5 Feb 2023 09:52:44 -0500
Message-Id: <20230205145245.11078-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230205145245.11078-1-cheskaqiqi@gmail.com>
References: <20230202171821.10508-1-cheskaqiqi@gmail.com>
 <20230205145245.11078-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script is written in old style,where there are
some executable lines outside test_expect_success. Put the executable
lines inside the test_expect_success.

As t/README says,use "<<-" instead of "<<"
to strip leading TABs used for indentation. Change the "<<" to "<<-"

for example:
-cat >test-patch <<\EOF
-diff a/file b/file

 test_expect_success 'apply at the beginning' '
+	cat >test-patch <<-\EOF
+	diff a/file b/file
+	--- a/file

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 59 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index aa57895b22..e0a52a12c4 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -8,47 +8,42 @@ test_description='git apply trying to add an ending line.
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
+	cat >test-patch <<-\EOF
+	diff --git a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,3 @@
+	a
+	b
+	+c
+	EOF
+
+	echo 'a' >file
+	echo 'b' >>file
+	echo 'c' >>file
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
-
 test_expect_success 'apply at the beginning' '
+	cat >test-patch <<-\EOF
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
     test_must_fail git apply --index test-patch
 '
 
-- 
2.39.0

