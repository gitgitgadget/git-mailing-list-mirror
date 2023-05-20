Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4366AC7EE26
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjETQOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjETQOH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537C810A
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso27517455e9.1
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599244; x=1687191244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10zWt/GB2YlEdRKE9G/e9Jlyd+WQNy3R5+Sx8mZ8ePg=;
        b=GtxgB0Cf2hSk5AoWn0SmMxV9MtAM1K2HPtHnKjKXmTyxmxwHN+QJlvPmg+ZeAjbLvk
         nhbEQfaU69z+yRiAkKV7T4YdVJCxlP+VQW0JRQ1+ZfeaOze5Lat9rbhtqa2dP4VLYUmX
         YTn+dc1vT0Y3tmPxaiSgG9xvuGG37hcL/hamMAGJLhGMSSJvtXvuv5DgSHEdvX7HCK0z
         /tme6mjhnkiYeb/k3RNQdb66HS/51TXUYLG1pWtTzcjDbtBMdHQO5hedoO56v7yhfAsl
         B3dmm5ln3X4lzgIikFoWxzpGmypa1CoqYlCY5CWXlkYvprDhoMjihlSMzc36DtZbFTI0
         uZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599244; x=1687191244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10zWt/GB2YlEdRKE9G/e9Jlyd+WQNy3R5+Sx8mZ8ePg=;
        b=kEgwp4pgC+k20Fw9ikS3XxhtSUEjXeE/TeoAh7cls6f5O2LViHJ4uOxw7CfAXSAWeC
         FrYkAtUpJFE7yfvwp5PYPYpXy5f7l/D737qV/JcyE2OVdqXgxfzIcrbzfp8cOlK+s07C
         o59CepFFozGXJ40vUnoUh8xNg5WQkwzBgMtvozgqqKty9cyKMo1TGdS2ht1F0u9uVjKP
         XCpg4WkxpZVs9NPiaM0zO5wl4H/a4uwPxIi8YYallfKBqWcRDYL54ZgXjymV+szxs7YC
         oPmGv1KPK9gBbMo8v33R8RnUkGGXDYK756AQd45j8CglzFR/eoy4VfkQm7ttq50L+giz
         4hmw==
X-Gm-Message-State: AC+VfDyk+CVALBD0+7OtjV0K+7stlVPGpkFwitADO2IAI7u1LtxE/t6K
        LTZrLb+zwVDzESbwjUP3LM1JXt9BBB0=
X-Google-Smtp-Source: ACHHUZ6MHB/guLCQeamB3o/upP+b2xD1hxNx+hBaBEUUtFPSGpk+lUnCAVNebNYueAw2JldC23QbQA==
X-Received: by 2002:a05:600c:2116:b0:3f4:298f:4cf2 with SMTP id u22-20020a05600c211600b003f4298f4cf2mr3918860wml.24.1684599244402;
        Sat, 20 May 2023 09:14:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003f423508c6bsm2602363wmq.44.2023.05.20.09.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:04 -0700 (PDT)
Message-Id: <c70af95a7998c7f0d1585cb412359d55d9ed4db6.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:54 +0000
Subject: [PATCH 06/10] t7700-repack: modernize test format
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

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t7700-repack.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index faa739eeb91..3f930fa4762 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -460,10 +460,10 @@ test_expect_success '--write-midx -b packs non-kept objects' '
 '
 
 test_expect_success '--write-midx removes stale pack-based bitmaps' '
-       rm -fr repo &&
-       git init repo &&
-       test_when_finished "rm -fr repo" &&
-       (
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
 		cd repo &&
 		test_commit base &&
 		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Ab &&
@@ -477,7 +477,7 @@ test_expect_success '--write-midx removes stale pack-based bitmaps' '
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 		test_path_is_missing $pack_bitmap
-       )
+	)
 '
 
 test_expect_success '--write-midx with --pack-kept-objects' '
-- 
gitgitgadget

