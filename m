Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B90C77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjERUDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjERUDe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E41E4F
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f42c865534so23860105e9.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440209; x=1687032209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/uwlHsqQ0SjLckIGcvQveLGz7OFwioRNNwmn9EM39g=;
        b=j/NfTfTFbrxm36/TaxqCwiRfP/1OwpGXb8WpDWPgFjCepmJ44T0k/BrRacEna0Stpu
         6QnO0fb0slcmY5sptKOqXuVldYB++xz4FTlD5xU8l4M0390YFj84iViAn66zXr9PmBSf
         HeKyeohAJvdV30Unt3Fe+vWl4bcdxKQMp+mbsYb1mDq2284UPX9EYiJMjNluLTKhkl6l
         YEM9wq4z9yCc82fImhsiGy0Njd0rIewAz5npg08+qQSlAWVUQLRt9sxi9qPSaa/EqLHO
         7QKRguxXYvesSznBmO2niu2va0rXAeNijrwWgVpMAHaZwz8H53S+LOYOJ9FkEOc89UI5
         7B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440209; x=1687032209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/uwlHsqQ0SjLckIGcvQveLGz7OFwioRNNwmn9EM39g=;
        b=VEzgIc3pkbH6mtH2NVT2MtdgztRBHZM1LYwyLd6BeIGbKhBYdSzNkGd0BGra4EfUle
         vwyc8BKU+3gzrDsZhJsSwBLaFhhK4/U1iR8IqJppeueLQWLKyVIjZbI9EQ+FEj3HPqjB
         B9D1LhOqVaRLbLnY8M55+sR1B4v82sMqsVe4HFIESm1TXKCi3Npw/ZxJw9HegX8aTxg1
         G4QhtkMBT7yFuHFrS2BvoTFKJmBzlYIWMNFllXRMq7QVAlH4TOdfN+Gahp9hmfiK9DBu
         2dlhih1HxCm9R0puw0KYGSFZmU6ksvUgKVt79i83owuqyNgaf4D7IAXJb62Vix+UXXTp
         9r2g==
X-Gm-Message-State: AC+VfDxPffOBRzfT5qD0jKML5YWoPL+hp2Djl7/6RG8xcdE1SypocnT9
        cGg84+B7LsaNlE2sjzvfC+T2+Lm+m6M=
X-Google-Smtp-Source: ACHHUZ6Dtrm31U0ssdtBOZCsDAVnuBGuHiXC3Do3v1EBQXzoLMa0fl+oZgkdB1psMfNI+h42OCEwPQ==
X-Received: by 2002:a7b:ce91:0:b0:3f4:2cf3:a53c with SMTP id q17-20020a7bce91000000b003f42cf3a53cmr2505319wmj.22.1684440209610;
        Thu, 18 May 2023 13:03:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a1cf708000000b003f42d3111b8sm203868wmh.30.2023.05.18.13.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:29 -0700 (PDT)
Message-Id: <6cdf6c0317fb5de93ea53b21d75933da151be2ee.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:09 +0000
Subject: [PATCH 04/20] t1001-read-tree-m-2way: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests are still using the older four space indent format. Update
these to use tabs.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t1001-read-tree-m-2way.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 3fb1b0c162d..88c524f6558 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -26,7 +26,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
 read_tree_twoway () {
-    git read-tree -m "$1" "$2" && git ls-files --stage
+	git read-tree -m "$1" "$2" && git ls-files --stage
 }
 
 compare_change () {
-- 
gitgitgadget

