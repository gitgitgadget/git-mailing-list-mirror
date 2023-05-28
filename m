Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F753C7EE2C
	for <git@archiver.kernel.org>; Sun, 28 May 2023 10:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjE1KAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE1KAF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 06:00:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5EC7
        for <git@vger.kernel.org>; Sun, 28 May 2023 03:00:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso16456935e9.1
        for <git@vger.kernel.org>; Sun, 28 May 2023 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685268002; x=1687860002;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKCNsnSCIhezy1b739K/7TfpZEK8BIHI2EOZyRN4u/w=;
        b=g9Yqhgoh6OA8RcEioUCZcDyE36Q/WWy6y072p5DHWsy2VFv82xUf0xBwq1/ykSEhhy
         g9KeemdHnNK4r1sn+7VHLBNcGTTu0GDwo8VX3i+astRPsitNVJKVMJBO6uHFVzgjC1Bi
         KwAyN8N5Ig2y1m4nEaSMjJ+CeIo3UvRubeRMXumMLE3JiHWAW/KUx28vOvDBZ2KiMyug
         1Y45fRIqKAJ6UF4LG4oebM0d1S9L3MvoIZHDIha6aq1HwR1shlJchK8+dVMM1vvwTRcH
         TOxXB0YK8DD5zcBUIjZK+wG+JpEt2PLUy7HlT9jQvKfw8SgJEhDvUQSQq7v5mIjL6q5L
         D18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685268002; x=1687860002;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKCNsnSCIhezy1b739K/7TfpZEK8BIHI2EOZyRN4u/w=;
        b=EXrLt2ATpltYg+XWXci0EE3dHA8FRoXIcRYmuMI/Jr6R3986pw6NadKeWqvlO2l3EB
         LbUn0mvFIl+9rzHWop/BQ/22IxMRnxzKxCkJA86RFTnI9XxcKG8t5HWmz45c9LrQ5GsH
         QngnsMBj+DGEMeXG7IB+WE+xOKHdTMEA1gVExkN5GeukB+ImUO1NTtRyhOppinUdBmyn
         CJ2DAPMHkmREjCDQajfC89wcC/U7GrR5RQgAgjSt9lAoafq55NZvL9vsyVftL6XVCZpj
         7bdAezxTfQVPv66EIY1yWCm1XCLWsHHe5oTV1UOv01p7VDY2HbsCF0+sx4S9TcMgdl+v
         Y0Bw==
X-Gm-Message-State: AC+VfDy1JpV9Hd1QV+w/YrF/boA9VuVO60LCqowm6cAjE26xzcb7HmIc
        uqm57wOxu0ZtXOZp/EGom3H2++XyQK8=
X-Google-Smtp-Source: ACHHUZ4vr5lF6njGX4+MTd99CUmhB0LFoMOD3J5KDtyndcPmKq9DlvmfhjZMF3Hb1of1pGE2tGZybg==
X-Received: by 2002:a05:600c:5403:b0:3f6:e67f:a79e with SMTP id he3-20020a05600c540300b003f6e67fa79emr3993202wmb.13.1685268002455;
        Sun, 28 May 2023 03:00:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003eddc6aa5fasm14241592wmd.39.2023.05.28.03.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 03:00:02 -0700 (PDT)
Message-Id: <ab1cdd95e03c8f0a9896898b34ceab7b67bee3b5.1685267999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1257.v3.git.1685267999.gitgitgadget@gmail.com>
References: <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
        <pull.1257.v3.git.1685267999.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 May 2023 09:59:58 +0000
Subject: [PATCH v3 2/3] reset: new failing test for reset of case-insensitive
 duplicate in index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

On case-insensitive filesystems, where core.ignorecase is normally set,
the index is still case-sensitive, and surprising outcomes are possible
when the index contains states that cannot be represented on the file
system.

Add an "expect_failure" test to illustrate one such situation, where two
files differing only in case are in the index, and a "reset --hard" ends
up creating an unexpected worktree change.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7104-reset-hard.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index cf9697eba9a..55050ac831e 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -44,4 +44,15 @@ test_expect_success 'reset --hard did not corrupt index or cache-tree' '
 
 '
 
+test_expect_failure CASE_INSENSITIVE_FS 'reset --hard handles index-only case-insensitive duplicate' '
+	test_commit "initial" file1 "initial commit with file1" initial &&
+	file1blob=$(git rev-parse :file1) &&
+	git update-index --add --cacheinfo 100644,$file1blob,File1 &&
+
+	# reset --hard accidentally leaves the working tree with a deleted file.
+	git reset --hard &&
+	git status --porcelain -uno >wt_changes_remaining &&
+	test_must_be_empty wt_changes_remaining
+'
+
 test_done
-- 
gitgitgadget

