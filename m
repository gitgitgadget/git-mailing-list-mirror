Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED71BC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 17:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjBBRT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjBBRT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 12:19:56 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D02BF2E
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 09:19:55 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id g16so1043401ilr.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 09:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu94mJsB1VpCWwfnp1TjAaxCg3hx8wFr5wh+S+oTLhs=;
        b=oDJdhNuXHjXOCENGnRKl/m1j8arnROCQP2gcCpsXD0/e7XQCsO4f2iI5fdYNAi2azg
         /MkxkYsQyYqeXgHbtCeR9v44FFMMwg9QZxTmV19FtMhLgCsfN+QJSya0zmM3U2mJRtPj
         pTx1oBLImcUVdgR4TWF/tGpe4zq9iGhrQkw5oJN0hUz1+4Ja4mZY/3rQ3qIY8rBa9VIn
         HQGkjP56KXq6iVKkaq5CPbgXV4e8TFMg4gap9Saaatttz2ArRLtAiYk+bzmYMXWDIytc
         4lYQMMJC8ZO3BFFJAaYOR2fXVYMJdRck5v6yn/I6IitqoVBmfdk4CIvXaZqJJP6VBNIY
         wmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu94mJsB1VpCWwfnp1TjAaxCg3hx8wFr5wh+S+oTLhs=;
        b=w2N2NGqfBem8gPjwROQX/T+/JC5oK2aR/JPcdjjMFVFgRun8HqKMnq3O+JMTLvlbhP
         TsFH3nOFfbtGhD2pddpWWx/qB77W8fbtRa1YCnC/VBOku3oMKvsv5v94zTnrWx8qUOPw
         xu1q80aiI9+WvM8XVp7lJ4pYRmqX0I1Db3YZcDEJ6pdvSNBByqT2nPmT4DmRJPX9brEx
         /8uG9VUdKNdKCSKki7mDGUPULqMemFK8o9QQs64gwijuezbC/0azT9ornWDHvQOaJPyx
         SiW4aLVweYONJEKyma4fHi7IO7D+L55/vfOvje6WMs6dwRdNhxdiY2qe8ArpGAS0p84z
         Owvw==
X-Gm-Message-State: AO0yUKWfQ7jdj3ZFgxKrWOnKx9GB7Mg3otI8bUZ61O0oVjl9WomVay1r
        321zLvBWrsXRFrgEC12ooCkIQFRAKKSjDA==
X-Google-Smtp-Source: AK7set+ngFeh7trQszSdrAtyMepT83lx6+iaj4nLO+atgCZXnL01WxGfOp4q7tF8oZKTfY7EPglSjQ==
X-Received: by 2002:a05:6e02:b4b:b0:310:fc77:4796 with SMTP id f11-20020a056e020b4b00b00310fc774796mr2398612ilu.5.1675358394671;
        Thu, 02 Feb 2023 09:19:54 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a3-20020a92d343000000b0030bfdb6ef60sm55887ilh.58.2023.02.02.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:19:54 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v2 1/4]t4113: replace backslash with single quote
Date:   Thu,  2 Feb 2023 12:18:18 -0500
Message-Id: <20230202171821.10508-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202171821.10508-1-cheskaqiqi@gmail.com>
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
 <20230202171821.10508-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the old style '\'  to new style "'"

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 66fa51591e..aa57895b22 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -24,13 +24,14 @@ echo 'a' >file
 echo 'b' >>file
 echo 'c' >>file
 
-test_expect_success setup \
-    'git update-index --add file'
-
+test_expect_success setup '
+    git update-index --add file
+'
 # test
 
-test_expect_success 'apply at the end' \
-    'test_must_fail git apply --index test-patch'
+test_expect_success 'apply at the end' '
+    test_must_fail git apply --index test-patch
+'
 
 cat >test-patch <<\EOF
 diff a/file b/file
@@ -47,7 +48,8 @@ b
 c'
 git update-index file
 
-test_expect_success 'apply at the beginning' \
-	'test_must_fail git apply --index test-patch'
+test_expect_success 'apply at the beginning' '
+    test_must_fail git apply --index test-patch
+'
 
 test_done
-- 
2.39.0

