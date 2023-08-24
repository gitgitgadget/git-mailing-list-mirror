Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B676C3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 14:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjHXONE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbjHXONB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 10:13:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EB9CD0
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 07:12:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3197b461bb5so5897567f8f.3
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692886376; x=1693491176;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwyaFWPJK5Ncr9hLcSk6A2+6c2W4oW4PIti7otsFBD8=;
        b=LBWdVvsUAdt39v/wyOhnRNfq1ZMbPrENTFJJofsOzL/RNFIXu3B0+tWqZvnSqyrmQd
         i4UKh9/bzU3GJpWgWXq6LicdNEVF7pKhaLhOc5Krg0NvfV5e2yZKrL4y7bi+NqgVX21z
         D2JNNGFjxjb4F/OhWCM/4gmsjouMOkv+03U2iavWFN66dNbbpEruQZHYZSg3Zg8yfALK
         HyDKFMcpmyvpKmKoxi+8YetnvzQzv8nvZm4r1zkJ2/FcE60lgJlR3p9FJp2V6z5bjLoA
         J087hip0ldHm3AqPH5vYwbY6LqBJkGUmD61dMPtpnYJQvvqQIOhMTd+SJlIkbG2QeiPZ
         jqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886376; x=1693491176;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwyaFWPJK5Ncr9hLcSk6A2+6c2W4oW4PIti7otsFBD8=;
        b=alai4E5Rw58M2I3lm0sAuiTk90PbfkwnTRpgM8ZDTvSpVSmszD3eblzmRkcbZTDQ5H
         hdAjbpH3b0D26TKSsaIDb/8dcOi3REHjOyfEhUWZT426wGKQNGZ2cCRSG12dhV+By+en
         Wloe5U0Xk2au2ak5BTdOh5dqlFafQqFKMPxVC5fnwsNqym9AmximawnCEOd8oit+zyhu
         peEpmLLPkt9KHHgyZQhQkHd5XXN+GHepkzBy+w9jsRxMPHJ7HjhIpUMi/SuTUJ+HQSlc
         tVftrH34FKWD4cxliZP2TXXfUv1O/7LnLqy/fWNTGLbYmxuDM8y4XdV1IBZz/a5TFI0Y
         XBDA==
X-Gm-Message-State: AOJu0YxYiouS8s16YCmfDrVw+56SRNrAkoq+UduHnPf/dvlqSZ0Aixa0
        Ip93qCEOsqWznA3Updu9FGIocisqBho=
X-Google-Smtp-Source: AGHT+IEL4U5E40cpypL2JjIhW+dn6mZaYa5gUxRLalS0GVz/otvVTq0ysSTEKagbmBCxePoOX2eIVA==
X-Received: by 2002:adf:f30c:0:b0:317:e5dc:5cd0 with SMTP id i12-20020adff30c000000b00317e5dc5cd0mr11563529wro.21.1692886376351;
        Thu, 24 Aug 2023 07:12:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d62c1000000b0031ad2663ed0sm22082620wrv.66.2023.08.24.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 07:12:56 -0700 (PDT)
Message-ID: <f940104a7814bd0b1e45f1230b2cb4b0be305699.1692886365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v2.git.1692886365.gitgitgadget@gmail.com>
References: <pull.1577.git.1692389061490.gitgitgadget@gmail.com>
        <pull.1577.v2.git.1692886365.gitgitgadget@gmail.com>
From:   "Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Aug 2023 14:12:44 +0000
Subject: [PATCH v2 1/2] Regression test for
 https://github.com/gitgitgadget/git/pull/1577
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Backhouse <kevinbackhouse@github.com>,
        Kevin Backhouse <kevinbackhouse@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Backhouse <kevinbackhouse@github.com>

Signed-off-by: Kevin Backhouse <kevinbackhouse@github.com>
---
 t/t9904-merge-leak.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 t/t9904-merge-leak.sh

diff --git a/t/t9904-merge-leak.sh b/t/t9904-merge-leak.sh
new file mode 100755
index 00000000000..09a4474fd73
--- /dev/null
+++ b/t/t9904-merge-leak.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+
+test_description='regression test for memory leak in git merge'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./lib-bash.sh
+
+# test-lib.sh disables LeakSanitizer by default, but we want it enabled
+# for this test
+ASAN_OPTIONS=
+export ASAN_OPTIONS
+
+. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
+
+test_expect_success 'Merge fails due to local changes' '
+	git init &&
+	echo x > x.txt &&
+	git add . &&
+	git commit -m "WIP" &&
+	git checkout -b dev &&
+	echo y > x.txt &&
+	git add . &&
+	git commit -m "WIP" &&
+	git checkout main &&
+	echo z > x.txt &&
+	git add . &&
+	git commit -m "WIP" &&
+	echo a > x.txt &&
+	git add . &&
+	echo "error: ''Your local changes to the following files would be overwritten by merge:''" >expected &&
+	echo "  x.txt" >>expected &&
+	echo "Merge with strategy ort failed." >>expected &&
+	test_must_fail git merge -s ort dev 2>actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
gitgitgadget

