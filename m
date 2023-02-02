Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F282CC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 17:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjBBRTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBBRTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 12:19:52 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F4F677A3
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 09:19:50 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id u7so1032986ilg.4
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 09:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRWd3volIxTwiewvNY27CvBbuSUwXsMkeH1oejv0Q60=;
        b=BmYALUQ4XgkCyjOhhlwjyF1bJENy43/XgNZWaPPHOTSDlC2SJ+xeRNn4xjbxuXRJyG
         NipdjlGZkj2gE+w3uQsE3pK/KidPwrLQn64cVVQM8w0Tst5ws6OdlZoWcR4G9/Ox1Hzu
         uAwIKJ+U5QxqnDQnZ0WSzcRq0z59vefslabXDpXe/6swrw7zmwm/8O6QvtxX7kD6zQRd
         U/BB4U4oDvXS+yw43Q/Q4DpIKp3pIKrltmNpn08h5cEMPJIIMQaWVN0SCvS4W4wD1cWP
         tVJneHZPq1c59KnTm+MhVGR+hOo5gUDVRwVcYdgBBCktEDjN4YA4xyi8N856HceNv/pl
         M51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRWd3volIxTwiewvNY27CvBbuSUwXsMkeH1oejv0Q60=;
        b=mBg5NC9+4JlEQEOOB/RmQMgfq7A00v5l+Z8D5YUCfVpujENfDRIADLAj6y6KXGrZ4v
         20ZKiWDu+2HVkPkjlYfuVOzvPVSSBzg4tm/cxnjl8TENHO4HvTMmLlDmumfxpS0ZlKUL
         k1xVG5ebg2oDyYQ2eTI3/636jnme7nGVj/vSHT8EtCI+ZdGHSlanZWJtqPOP+8vOLNVM
         Mk/Ci9iHuuRoKEL++ozaS/QHeZZNOVsb1Ix8jBXHPnfYF1H519lMbRWhH6gJLTre1u/H
         yREn9Bd4HsZ9W0B5V27uwhLY4bkU7jj+xqoCYxTk34md/f6prsOtXYOs2UYixQtg5q6d
         53dA==
X-Gm-Message-State: AO0yUKUljku2CGhuyeLGfbKc5do7Gdk4FUDJkNCppqjvqvcbvw4JI0oP
        yoLmsvL/RxSIYMY3ILsjqdedteGo3VYw4Q==
X-Google-Smtp-Source: AK7set/7WLkDCzDpSuspaUktaXYjHq7XRhABo1ildRAaQxSBAjSyqxZo6tJG/Dsbmc5TFkHAzpDJKg==
X-Received: by 2002:a05:6e02:20ee:b0:311:1075:4dac with SMTP id q14-20020a056e0220ee00b0031110754dacmr6741471ilv.8.1675358389916;
        Thu, 02 Feb 2023 09:19:49 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a3-20020a92d343000000b0030bfdb6ef60sm55887ilh.58.2023.02.02.09.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:19:48 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, rybak.a.v@gmail.com
Subject: [PATCH v2 0/4] t4113: modernize test style
Date:   Thu,  2 Feb 2023 12:18:17 -0500
Message-Id: <20230202171821.10508-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modernize the test script t4113.

Comparing to v1:

1.Test scripts in file in this script are written in old style,
     where the test_expect_success command and test title are written on
     separate lines.Change the old style '\'  to new style "'".
for example :
-test_expect_success setup \
-    'git update-index --add file'
-
+test_expect_success setup '
+    git update-index --add file
+'    

2.Files "test-patch" and "file" are created twice.
put the second creation of the files to its own step
'setup for apply at the beginning'

3.This script still use the old style "<<".
Change  "<<-" instead of "<<"
for exmaple:
-	cat >test-patch <<\EOF
+	cat >test-patch <<-\EOF

4.The test bodies in this script are written in old style .which indented with space, but not TAB.replace indentation spaces with tabs.
for example :

 test_expect_success setup '
-    git update-index --add file
+	git update-index --add file
 '

Shuqi Liang (4):
  t/t4113-apply-ending.sh: Modernize a test script
  Test scripts in file t4113-apply-ending.sh, files "test-patch" and
    "file" are created twice.
  use "<<-" instead of "<<"
  t4113-apply-ending.sh used 4-column indent with space,fix it in use
    tabs for indentation.

 t/t4113-apply-ending.sh | 51 +++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

Range-diff against v1:
1:  d7d52f1f79 = 1:  d7d52f1f79 t/t4113-apply-ending.sh: Modernize a test script
-:  ---------- > 2:  d9e5a54e32 Test scripts in file t4113-apply-ending.sh, files "test-patch" and "file" are created twice.
-:  ---------- > 3:  01a5c3285e use "<<-" instead of "<<"
-:  ---------- > 4:  cf2b2ca5a0 t4113-apply-ending.sh used 4-column indent with space,fix it in use tabs for indentation.
-- 
2.39.0

