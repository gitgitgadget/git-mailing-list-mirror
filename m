Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2DEC38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjAaWt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 17:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjAaWtw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 17:49:52 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2751026E
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 14:49:50 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h18so4421731ilj.6
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 14:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TIrUQ1BoGHEdipJzbxIKUV114OAgqlftT2kCExAqDzk=;
        b=dpYXOCLHxg+5qw33b0AJQy6MgZoShh2bFNlFusENedNHnKyFqxlNhvTgwIe/LqvxCs
         A0fy51AFcsCcliClygZ8eiwIp7y9dyPOFLSSfEjhmR0XiD9EDV69+Ozky1NHfMnB0js3
         YX4DSnOGfjR4YEMDQb1zGDfd3lcsZLMCp/zmHUjcUOaMTBnCYYsOPoDRKboyw9JHggHm
         5sn+GZq//fz3n/4OWnct7hoWc1P4dyLkkNutB6Mgr1neaMl0z26Y2GdkWVV6fF7vgiF9
         BQFwx3IUjQG50aCHYHjbUBUE0F8zrckvVlMnfo4UT4hcUwG06Mw8xFWOqRELW0QmHqNB
         SwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIrUQ1BoGHEdipJzbxIKUV114OAgqlftT2kCExAqDzk=;
        b=nafKNz2mXPTb+g7VKHwMiIIynhi0+yQfcBn52PDIpKJi60jFzAyfR7G+fGzne8821x
         8SrIxvsIASRs6vXuTa2Rsv7U16kqS3kpLl70wQkksa1frzxy6OYwaEeRJNi11Xil4zAr
         ti2n4l6z9Cc3vQD5Yv4lXm4GVK/7w+/M/TOMVLdtanRkw32qp4MEBEhfr1ANJymSVdxr
         rOKq17M276k5GV3OYpC/kiluwTKTCHWkInZdOrZ0zpUMiE4fJnG/pEpQYz00UdQQuPFn
         SyR8Yp5yBGOSn3D9CC4x3NPrnwskV9ne/QdHjVU/ZN83n1e3pNHnZHTab6mIb76Omw2E
         wTnw==
X-Gm-Message-State: AO0yUKXlTFqWS5KDzTUVfOuW6lONLgFldMcbPR1zPyDV7DOuL0A0fSVR
        o4FW29HbvQgn0J52EfxJzT05rNb5v7LbOw==
X-Google-Smtp-Source: AK7set8NgAgIOvuN3qb14PrKQMhIZq5YhIwAgepQwQg4TVmrukyfXXnrgoISZPdQwWCH06i3Yy7GHA==
X-Received: by 2002:a05:6e02:2194:b0:30d:911c:e6de with SMTP id j20-20020a056e02219400b0030d911ce6demr11716753ila.14.1675205389436;
        Tue, 31 Jan 2023 14:49:49 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id a16-20020a056e020e1000b0031108705346sm1116924ilk.79.2023.01.31.14.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:49:48 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [GSoC][PATCH] t/t4113-apply-ending.sh: Modernize a test script
Date:   Tue, 31 Jan 2023 17:49:29 -0500
Message-Id: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I cleaned up some old style in test script.

for example :

* old style:

    test_expect_success \
        'title' \
        'body line 1 &&
        body line 2'

  should become:

    test_expect_success 'title' '
        body line 1 &&
        body line 2
    '




Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
Hi,I'm Shuqi Liang.a junior student majors in Computer Science at University of Western Ontario. 

This patch is the microproject I try to getting involved with the Git project.

I have read 'MyFirstContribution.txt', 'Hacking Git' and the book 《pro git》 ,and I know more about objects, references, packfile format, etc.
Over the coming period, I will delve into the source code and gain a deeper understanding and try to  contribute more meaningful patch to the community.

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

