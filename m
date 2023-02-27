Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFFDC64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjB0P2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB0P21 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB29DD33B
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:24 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j3so4500530wms.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOAL/WFgID8YOd9lLNB0zCh3EXi1IuYdpdDovPkOCQY=;
        b=En1WTzLGkjEbZqF+BljsC1Kc1URK0ovR+rg+mgZv1SasvG6gwnXCF+6hbtVDbjE++Q
         6YbuYfP2uhxTbrLqpo/H6QVbU7uERa3k6nXZrpp/hsUIgPXmE5JwM5JcsWyx/Y6w1itZ
         0RHSQeYBZkrTcnfzIqRq1OkRBRCndjO42kqUyrN8BfRIAMpwRIbt+xBfwfM9DTnc+avt
         nPxwLtUZs3B+L5xHQ/YoWEVGqhGFBD1pc41eUhAF3KeAdZbEPvGhiv/Raai1aRJsyrBO
         9zGM5m3hQgy5Wyt7nSJo4dxCPyuOoJUCInae56dXoOqrs/11LxqLkIhQeATlialyO3cs
         wpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOAL/WFgID8YOd9lLNB0zCh3EXi1IuYdpdDovPkOCQY=;
        b=jQmcrE4Qm7WoJO3wK9GbsFdbWEWTvlVFlZrwq8VFu9Usa1rP/Acs4J+uAimcj7Ib9X
         J6mkccPewbhsZPu09uiBW1857X/+jWIbN4CSR5F93Gt9gMaSezCNs+F5KURhSxeQ+GvK
         +02bd5dh4O1BcvSjcSLT4B0zpm7TPBLqNOzMxuTlOgdqoGaOS0Vl/GstmHMe5RFugoz6
         FGe+EnBqyEOi6/zNw3icYJ7QNrp2/egxTJT8kJToE2daEt5nCwjVmpSGZQQjBP4bGqu5
         8majtmMwbseZSww2ghClwgEcYfxHr2sZIgnh5ffkDGPNYx8qRBnTZZjo126egNLsy4ZQ
         CfUQ==
X-Gm-Message-State: AO0yUKWPI1vxqa9jjX0+kBXCVYnKWbG7o6gx2izmrBZO9Ua/+YhOA5qD
        SSM0HiaJalhyxkKFDYKl+s8oHKB0HZU=
X-Google-Smtp-Source: AK7set/Pac+RYEDU9SVOQsDbovlNLgNwSVTWHm3lu9J2NzVxaJTW50UGW5j/imUSpwDMI8F2drI2nQ==
X-Received: by 2002:a05:600c:929:b0:3e2:5c3:bcfc with SMTP id m41-20020a05600c092900b003e205c3bcfcmr19389061wmp.18.1677511702546;
        Mon, 27 Feb 2023 07:28:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b002c54911f50bsm7387044wru.84.2023.02.27.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:22 -0800 (PST)
Message-Id: <7bbc4577a57fc9cb9debc249af232282b6b3f24f.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:08 +0000
Subject: [PATCH v3 01/13] t2021: fix platform-specific leftover cruft
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t2021.6 existed to test the status of a symlink that was left around by
previous tests.  It tried to also clean up the symlink after it was done
so that subsequent tests wouldn't be tripped up by it.  Unfortunately,
since this test had a SYMLINK prerequisite, that made the cleanup
platform dependent...and made a testcase I was trying to add to this
testsuite fail (that testcase will be included in the next patch).
Before we go and add new testcases, fix this cleanup by moving it into a
separate test.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2021-checkout-overwrite.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index 713c3fa6038..baca66e1a31 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -50,10 +50,13 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 
 test_expect_success SYMLINKS 'the symlink remained' '
 
-	test_when_finished "rm a/b" &&
 	test -h a/b
 '
 
+test_expect_success 'cleanup after previous symlink tests' '
+	rm a/b
+'
+
 test_expect_success SYMLINKS 'checkout -f must not follow symlinks when removing entries' '
 	git checkout -f start &&
 	mkdir dir &&
-- 
gitgitgadget

