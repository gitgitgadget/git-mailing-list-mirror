Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C54EB64DD
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 06:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGAGzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jul 2023 02:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGAGzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2023 02:55:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D24C1E
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 23:49:02 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401e38e203dso21647871cf.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 23:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688194141; x=1690786141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeQbDBwjm+QHeePsg6tzXgliWFGrMDfId2ndVhXjHgQ=;
        b=hhFvvRiZ/TSsmogTI8R5JIcLiByBPxSS/j0FOuiITXMTt81RXsL8xGbdJsiB+nljza
         waLCb9QokdCPnSgR4ErjusNIVNIiCnslhc1DMmv7K8azo9pUPjUTJ0UO7ly19O3fDiNs
         8kDuRfwTbxLUuI/o0s3jFN8pG8eX362g1S9pIxVlhsFNi8Je+u9CGD7GdpzVgTH+UFzO
         dW5AmsRblDEKKJQPE+CIbm6ga9oWUwUSAzZWRm63ouMR/yU+EgjBnA9i4hKmhPb4ki9j
         kV+R2Asx42po/+tdSU0oULvW9kGkAmpoDDjzEYFFXTQzhUVgiiTAsBEywCrmsNeHBkWF
         WxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688194141; x=1690786141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeQbDBwjm+QHeePsg6tzXgliWFGrMDfId2ndVhXjHgQ=;
        b=TEMUT0uIjeLwkl6E1IzGaYBIx6BUmm7mmpsDYbRh/nGlPx7HAye0/msCkTQZK2here
         BZzlo3b9vQJFVKYdyYtlVR3RrAct7jIki2S3vHVTipxXhPddZf3yaX8Vv3GVrgFDjTke
         VYG3ph0W3pY+AhmdInXQrWOVKDhjlg+Fn7gSdwiae1HD/nqoDT0Mqh1x1C582N2DnyG3
         Zux6XMNxGheODWtvj2R5/JGAlD6AH9H/tbU96jWznZbwXrkn+dy54BGdyYD69coDbdQJ
         FBXfDQIixzqzDQ/h+/SlxEdij0FYzscv9rsjnpHcINpvdlAsK6q1darBFAJ4LNoSQYWg
         Jjyg==
X-Gm-Message-State: AC+VfDzpxkbvqKEI6exrRiybDZ8XVdzACIHk9kracKlz4lX739jg4NlM
        3h0W53xnLmtWOiEPxaLno8m8p1w6YICnwA==
X-Google-Smtp-Source: ACHHUZ4aGqwIpTpIiE9jpGW7S1F7HsTE4QTQTojoiqTPJIV42ZGZGBH38eNyS9IQHluJRCOifWRp5Q==
X-Received: by 2002:a05:622a:ca:b0:3fd:ecdc:1e1e with SMTP id p10-20020a05622a00ca00b003fdecdc1e1emr6702848qtw.22.1688194140869;
        Fri, 30 Jun 2023 23:49:00 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-18-69-158-189-182.dsl.bell.ca. [69.158.189.182])
        by smtp.googlemail.com with ESMTPSA id a26-20020ac8435a000000b003e69c51cf53sm2269720qtn.72.2023.06.30.23.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 23:49:00 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v1 2/3] t1092: add tests for `git check-attr`
Date:   Sat,  1 Jul 2023 02:48:42 -0400
Message-Id: <20230701064843.147496-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230701064843.147496-1-cheskaqiqi@gmail.com>
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for `git check-attr`, make sure it behaves as expected when
path is both inside or outside of sparse-checkout definition.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8a95adf4b5..4edfa3c168 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2259,4 +2259,33 @@ test_expect_success 'worktree is not expanded' '
 	ensure_not_expanded worktree remove .worktrees/hotfix
 '
 
+test_expect_success 'check-attr with pathspec inside sparse definition' '
+	init_repos &&
+
+	echo "a -crlf myAttr" >>.gitattributes &&
+	run_on_all cp ../.gitattributes ./deep &&
+
+	test_all_match git check-attr -a -- deep/a &&
+
+	test_all_match git add deep/.gitattributes &&
+	test_all_match git check-attr -a --cached -- deep/a
+'
+
+test_expect_success 'check-attr with pathspec outside sparse definition' '
+	init_repos &&
+
+	echo "a -crlf myAttr" >>.gitattributes &&
+	run_on_sparse mkdir folder1 &&
+	run_on_all cp ../.gitattributes ./folder1 &&
+	run_on_all cp a folder1/a &&
+
+	test_all_match git check-attr -a -- folder1/a &&
+
+	git -C full-checkout add folder1/.gitattributes &&
+	run_on_sparse git add --sparse folder1/.gitattributes &&
+	run_on_all git commit -m "add .gitattributes" &&
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git check-attr  -a --cached -- folder1/a
+'
+
 test_done
-- 
2.39.0

