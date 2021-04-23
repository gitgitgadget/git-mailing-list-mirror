Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAAEC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8163F613DB
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbhDWAQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 20:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbhDWAQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 20:16:24 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA30C061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:49 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h4-20020ac858440000b029019d657b9f21so16508334qth.9
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WWiCRQ0V+OsMS939hqUbfRz0FDjfIAXQIYFFIZ00nlQ=;
        b=IEZvk58/oKtAnlglaijbH9tudLxIGe5DjxRJHfHxT5Gmy0fRVUBX8T63XRLW6bJS49
         zBw3vyTiZ7les9pnb1FE4Mj6XRnmIlVyuE9U9M1UL0v4z10e5XR7A2Z2On/wNfplvDxx
         nUyCUfuSwXAPrK8Xuoun4umbHGbzmpFEjFogRjXDF5hpZZTEonKiUs/+01gLIcjibLUv
         7pZGK8HQtfrFT43954lZmAqcWH8uZKjwxXHNs8fPcbS+zk/WXm5r+boZEjzYgOhvIiFo
         OtOqBzFtq+HPgTvvJVhXyAEkxjaDsZImjWAgga16uWQQUxNJnayoJSMjMrQ51whoSSYn
         Jz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WWiCRQ0V+OsMS939hqUbfRz0FDjfIAXQIYFFIZ00nlQ=;
        b=GNJQ9CArXP7uiG8qreEaoRGECi73pSCcOk+VTb55yTXpBirUcVeMEYQm4j18A3tqoG
         g9BVWENjowuV/FVyHEQieAS1lY6L7NkEJd8fXEESDK24yhStcJF/1kItGz8/klMuR9cN
         G9HMkuXQR/DW4krs7sTqOZBiAL0dMBPiaABQJk0LwnW0OyTZUM+8Ug3Xt1Ktfqb5Ded6
         D4eLkJTYaV0wQVETB9vQx30ZayISHQi8QZ7bjYvEkri75dxiKYt8k3hJcLtyc3OfNL8r
         5X5vgOdOQwPKEfzBN6I7DAbmD5YLBlxSGXQ0uGWOrbyyfUVKt2KjJgzJoUf7pTLZsxmQ
         utFg==
X-Gm-Message-State: AOAM532xEdIiNndN5J7W/sWriTIg92VxjSigbkFXJAvfnpoHwxbj59N+
        A4Xh3VOeb/vPNGP+hGaRPmxqvGuiyZ8m2ePcFutU++zUoSFfzY/t3uzaJT4GSYRe4sRmeXvsXjI
        uWpewzJkSSFbJ92cuzHc8Xa4oZReel67DlZBU7ZFp6eu0E2u2wN6neGLpH3hEhp8IAM4I5jg+YQ
        ==
X-Google-Smtp-Source: ABdhPJw5CpJRpRAI7hhMPKS5p7A+/53DWmv/ijNsreqimKLOwex3xUf+LrVTirVn3QjwRdQUsj+SH3pPQvb1piUTZnE=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:fe4e:1417:67a4:42aa])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:5482:: with SMTP id
 q2mr1280640qvy.36.1619136948378; Thu, 22 Apr 2021 17:15:48 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:15:38 -0700
In-Reply-To: <20210423001539.4059524-1-emilyshaffer@google.com>
Message-Id: <20210423001539.4059524-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210423001539.4059524-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [RFC PATCH v2 3/4] t7006-pager.sh: more lenient trace checking
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A number of tests in t7006-pager.sh are, as a side effect, checking that
'git log' does not invoke any child processes besides the pager. There
is no reason for that guarantee, and it is not explicitly the purpose of
these tests, so let's make the checking more intelligent and flexible.

child_start and child_exit events share a child ID - using that child
ID, we can try to disambiguate which child_exit belongs to which
child_start and limit our validation to only the pager's child process.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t7006-pager.sh | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435..ac2d91d56b 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -676,7 +676,9 @@ test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
 		test_terminal git log
 	fi &&
 
-	grep child_exit trace.normal >child-exits &&
+	PAGER_CHILD_ID=$(grep pager-used trace.normal | \
+			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
+	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
 	grep " code:0 " child-exits &&
 	test_path_is_file pager-used
@@ -697,7 +699,9 @@ test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
 		test_terminal git log
 	fi &&
 
-	grep child_exit trace.normal >child-exits &&
+	PAGER_CHILD_ID=$(grep pager-used trace.normal | \
+			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
+	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
 	grep " code:1 " child-exits &&
 	test_path_is_file pager-used
@@ -718,7 +722,9 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 		test_terminal git log
 	fi &&
 
-	grep child_exit trace.normal >child-exits &&
+	PAGER_CHILD_ID=$(grep pager-used trace.normal | \
+			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
+	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
 	grep " code:1 " child-exits &&
 	test_path_is_file pager-used
@@ -739,7 +745,9 @@ test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
 		test_terminal git log
 	fi &&
 
-	grep child_exit trace.normal >child-exits &&
+	PAGER_CHILD_ID=$(grep does-not-exist trace.normal | \
+			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
+	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
 	grep " code:127 " child-exits &&
 	test_path_is_file pager-used
@@ -760,7 +768,9 @@ test_expect_success TTY 'git attempts to page to nonexisting pager command, gets
 		test_terminal git log
 	fi &&
 
-	grep child_exit trace.normal >child-exits &&
+	PAGER_CHILD_ID=$(grep does-not-exist trace.normal | \
+			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
+	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
 	grep " code:-1 " child-exits
 '
@@ -780,7 +790,9 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 		test_terminal git log
 	fi &&
 
-	grep child_exit trace.normal >child-exits &&
+	PAGER_CHILD_ID=$(grep pager-used trace.normal | \
+			 sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
+	grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
 	grep " code:143 " child-exits &&
 	test_path_is_file pager-used
-- 
2.31.1.498.g6c1eba8ee3d-goog

