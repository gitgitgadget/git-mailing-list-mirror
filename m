Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5635CC433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 12:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiB0M1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 07:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiB0M07 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 07:26:59 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209DE6D951
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 04:26:23 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o26so8434995pgb.8
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/egdeIQHmPwktkzRr3IFjI7RoxTnYuBhKFh3O0fI+w=;
        b=ap1cSLIWWYktBJFFuytEQcdJ0tjd4QVLGlUZGNYwEIqNi/QUK8shfHzLIuQon37uBv
         rJpdB1j18Fy+5u0NE8XFK9kCR0mABt/fwhP/VoClB7Jv0jNagEoRLo50t78SF3Wh9Jhj
         +u8uFEd+yaYjUJ0ApNKUtXFcqyCJzUddEQouKc8hyd8dd0OH6iSZFSVYSHYVJ+0fbcd9
         T8YTi35/lBAOSdmRKopUl/9JZguyqoY+mFQY4UrAN9CDhlYu6hbHelCSeaVVx24ozphe
         K96BzpIPcN01sWf+2p5teq3AX3bUFlAHRePRGRvHxu/3GHoujEeZlgPXpdA+4hp6n+8Y
         CqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/egdeIQHmPwktkzRr3IFjI7RoxTnYuBhKFh3O0fI+w=;
        b=rIgNAs8VAv268shNjSODMiferC5jSlqgO2/NiLnz7Iv8B23T3LrknTLvBYzg7ezy44
         fUM/nXAjHk9DQEzYIHmiRNypOe6s+r5BR87ZRlk5dAQ4MjUa7atOjckoaETeJ5NNEHW5
         7TVYXI9CYG5i/XWKONPUE+RGi1vpwa2ChowfPn2/t7c5LD1RoQL2AJT7COqMQ6LAQTBK
         2EER1ixg5HzvVq2fz2psCKVWglgXkQTXMwp7ECopTVWSuYnB7lrlU24hlv30UnmeNQkF
         vG7B3uC2Tapp8Cyku35VPRdVrKGUXQ3X35ixZyr/0dAyzSC7AaYMDYlcsbOK9Ad7WGJ1
         K/VA==
X-Gm-Message-State: AOAM530fpMjQet7gPCvAuh4iZ7dPfIYbRyVB3Qih973WyZbBNunlvzYs
        GyG1DnS4eSDDkGOlrFs6Y9hwtr+SJQ59rwN6
X-Google-Smtp-Source: ABdhPJw0DG9q/U0C+pIR9GuXN1pOs74IkMDbdRtHaSXFVo3PGmMmoNwU5ObcpiYh3Mx5gF0PSBDExw==
X-Received: by 2002:a05:6a00:1f07:b0:4e1:3335:9dd6 with SMTP id be7-20020a056a001f0700b004e133359dd6mr16404924pfb.76.1645964782160;
        Sun, 27 Feb 2022 04:26:22 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.152])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm9802969pfh.174.2022.02.27.04.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 04:26:21 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, avarab@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH v2 2/2] t0030-t0050: avoid pipes with Git on LHS
Date:   Sun, 27 Feb 2022 17:54:53 +0530
Message-Id: <20220227122453.25278-3-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227122453.25278-1-shivam828787@gmail.com>
References: <220224.86o82wab31.gmgdl@evledraar.gmail.com>
 <20220227122453.25278-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pipes ignore error codes of LHS command and thus we should not use
them with Git in tests. As an alternative, use a 'tmp' file to write
the Git output so we can test the exit code.

Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
---
 t/t0030-stripspace.sh | 75 +++++++++++++++++++++++++++----------------
 t/t0050-filesystem.sh |  3 +-
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index ae1ca380c1..7bc3dcd07c 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -13,6 +13,10 @@ s40='                                        '
 sss="$s40$s40$s40$s40$s40$s40$s40$s40$s40$s40" # 400
 ttt="$t40$t40$t40$t40$t40$t40$t40$t40$t40$t40" # 400
 
+printf_git_stripspace () {
+    printf "$1" | git stripspace
+}
+
 test_expect_success \
     'long lines without spaces should be unchanged' '
     echo "$ttt" >expect &&
@@ -225,32 +229,38 @@ test_expect_success \
 
 test_expect_success \
     'text without newline at end should end with newline' '
-    test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$ttt"
 '
 
 # text plus spaces at the end:
 
 test_expect_success \
     'text plus spaces without newline at end should end with newline' '
-    test $(printf "$ttt$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$sss$sss$sss" | git stripspace | wc -l) -gt 0
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss$sss"
 '
 
 test_expect_success \
     'text plus spaces without newline at end should not show spaces' '
-    ! (printf "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
+    printf "$ttt$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$ttt$sss" | git stripspace &&
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$ttt$ttt$sss" | git stripspace &&
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$sss$sss" | git stripspace &&
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$ttt$sss$sss" | git stripspace &&
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$sss$sss$sss" | git stripspace &&
+    ! grep "  " tmp >/dev/null
 '
 
 test_expect_success \
@@ -282,12 +292,18 @@ test_expect_success \
 
 test_expect_success \
     'text plus spaces at end should not show spaces' '
-    ! (echo "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
+    echo "$ttt$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    echo "$ttt$ttt$sss" | git stripspace >tmp &&
+    ! grep "  " tmp>/dev/null &&
+    echo "$ttt$ttt$ttt$sss" &&
+    ! grep "  " tmp >/dev/null &&
+    echo "$ttt$sss$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    echo "$ttt$ttt$sss$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    echo "$ttt$sss$sss$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null
 '
 
 test_expect_success \
@@ -339,11 +355,16 @@ test_expect_success \
 
 test_expect_success \
     'spaces without newline at end should not show spaces' '
-    ! (printf "" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss$sss$sss" | git stripspace | grep " " >/dev/null)
+    printf "" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null &&
+    printf "$sss" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null &&
+    printf "$sss$sss" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null &&
+    printf "$sss$sss$sss" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null &&
+    printf "$sss$sss$sss$sss" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null
 '
 
 test_expect_success \
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index afc343cf9b..5c9dc90d0b 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -104,7 +104,8 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
 	rm camelcase &&
 	echo 1 >CamelCase &&
 	git add CamelCase &&
-	camel=$(git ls-files | grep -i camelcase) &&
+	git ls-files >tmp &&
+	camel=$(grep -i camelcase tmp) &&
 	test $(echo "$camel" | wc -l) = 1 &&
 	test "z$(git cat-file blob :$camel)" = z1
 '
-- 
2.25.1

