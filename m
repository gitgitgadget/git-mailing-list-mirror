Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9C0C64EC4
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 21:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBUVrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjBUVrE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 16:47:04 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4BD305ED
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:47:03 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id bm5so3121878pgb.12
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DnJVS/msx9n1mG5wF/VTp4VhvTV/wnRa34wTOFb/bg=;
        b=SoTLj1Kijyo5qei72dYqRiCdaK8SkFFjWjRj8stfBqeyD3lSIWeP9rdqiJ2MHRajfT
         qnrgZSjh8FS54ON0zOQ5t9T82oGyZ82cE9QUAGEtzpXBWuLtVsAYdBHih8cPj3QpKN8A
         JBPSJ59ziLvDvzuvLAt4qIp9Y7bg4fXcJim4obSeCSMYBU7OioL5joAcxumTwZidD0D9
         YZlbJb8HMCGQh26DSdZPw1dt5SFmRNBvsxm6WTCmkk1+PVlgAjVZb9Sd3r4ETu/nlT9R
         MOwVYUD1bgJAa7QJteTbtDPDXKPuUP9KuiudR5XLe5q9zd2pS5U6gOu500cccTthmnpX
         YT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DnJVS/msx9n1mG5wF/VTp4VhvTV/wnRa34wTOFb/bg=;
        b=OjqoesYz3ylxxs0zwoPXTRyt287hp7o78Poz6JLGNDn+jS//kSg1Ux0Gz7mHksSEWA
         +aRUIuh1iIhi8a0/GRiEiRd7FJwVribK0KJpHa1GpjajzZtYJFAxdsKsD8hLc/6tEnS5
         1nsKgawSCWV7LCWPt9tvaF0GhSC6+Gp47wAfPpC9wc7kuihNM0eiehY7RxvNDQA3kF3H
         EHyePdyTxH0I1TFOrUmwQbbVnRTokUPSg6ftBYSrVO3qk/gpI5ZioPKzCqct1t9Tqr0l
         nVzOhswyy0ZOmHFeJQGkbt4xEIs4tHP20tvdFkxTFI1cdfEtw4W5tL9IqKmeEbzUv352
         +Z2g==
X-Gm-Message-State: AO0yUKWTNz/YAOeW3JwXgTi3b9usGrZmXUend10iX5P7UyQZAqI/NQWV
        Aph69GVSJTJVwFolRMlurvazOxiWM9/BKQ==
X-Google-Smtp-Source: AK7set8BvLPKjRtfIXvjs+PIby/HiX92XXmHOQnYMq+P8qCTcswIdEVwm0y8VP1G2Vb+c8Tf217stw==
X-Received: by 2002:aa7:8f0b:0:b0:578:ac9f:79a9 with SMTP id x11-20020aa78f0b000000b00578ac9f79a9mr6176894pfr.15.1677016022571;
        Tue, 21 Feb 2023 13:47:02 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dg56d59ey2wgev.ipv6.telus.net. [2001:56a:740f:7b00:548b:6839:29d0:4517])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b00590ede84b1csm10325385pfm.147.2023.02.21.13.47.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Feb 2023 13:47:02 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [GSOC][PATCH v2 1/1] t4121: modernize test style
Date:   Tue, 21 Feb 2023 14:46:53 -0700
Message-Id: <20230221214653.85830-2-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230221214653.85830-1-gvivan6@gmail.com>
References: <20230220235121.34375-1-gvivan6@gmail.com>
 <20230221214653.85830-1-gvivan6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test scripts in file t4121-apply-diffs.sh are written in old style,
where the test_expect_success command and test title are written on
separate lines, therefore update the tests to adhere to the new
style.

Signed-off-by: Vivan Garg <gvivan6@gmail.com>
---
 t/t4121-apply-diffs.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index a80cec9d11..f1cc42ff71 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -16,8 +16,8 @@ echo '1
 7
 8' >file
 
-test_expect_success 'setup' \
-	'git add file &&
+test_expect_success 'setup' '
+	git add file &&
 	git commit -q -m 1 &&
 	git checkout -b test &&
 	mv file file.tmp &&
@@ -27,10 +27,11 @@ test_expect_success 'setup' \
 	git commit -a -q -m 2 &&
 	echo 9 >>file &&
 	git commit -a -q -m 3 &&
-	git checkout main'
+	git checkout main
+'
 
-test_expect_success \
-	'check if contextually independent diffs for the same file apply' \
-	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
+test_expect_success 'check if contextually independent diffs for the same file apply' '
+	( git diff test~2 test~1 && git diff test~1 test~0 ) | git apply
+'
 
 test_done
-- 
2.37.0 (Apple Git-136)

