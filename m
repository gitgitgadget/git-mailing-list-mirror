Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454B5C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 16:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiLLQbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 11:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiLLQb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:27 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9387AFCF2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m19so5927190wms.5
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FotZg4yy9XlqAjPVJNxC5xwRpcqkYAtK4Jr/uCnQRcg=;
        b=Lhxg7majVMA+prwXg8viWatfVjmEmB9VJxGwBoG08o5OldHg4SBiLr35Dm54kCMrV7
         mykArtbtpLxL20h76SPL52+MRAkqNvJA8/7oTyPOZNZ53ZUAb9gz8DV9BWLGwOjSbL5r
         F9jaru7saQi+5EUEgoxyNR5NK7lTjFG+UVrKVWgzpPSQE5HGSVXPBW06LqML/eojYWj6
         KnXaLdkFIGRhv0AOtG43Hak1+VdxPX9a5rX6N6vRqdqVNsfyYsAKAtCmb8+0eo2RWcGg
         M40L56RJsx/BWXlPPk90c2PRV0lb3nWEUSp31c3f//kIS9l+0brc/wWRlm18XJYeEhTT
         X15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FotZg4yy9XlqAjPVJNxC5xwRpcqkYAtK4Jr/uCnQRcg=;
        b=leoEo8hruVp011nu1/5rkdiZK7Sx8eqqFM5ErCqHc0ZC+pbCPEx/AytI2oPWitvGlc
         g2fxDq5KtGDwr8HLi/2yC2lFmVmQJwkXzmBcwk0+NQQejcW/gtfpuzg3clXW5RQGWCYq
         wW4A9YavvPPitivTTcFYn0yZcsbN12V60Cm8J84nzCVXR9zCaqmz2Cm7537m2u05lxTX
         lrLxnuO2ioULPe7XNTbnZPg5tGKTjL7xEUfUnHmUT8ArOO06N4NJFCFsdp7tP8sdmiyR
         eSAxqJD9ZYNZGwr22xQipZlGJAJFguUeF4WFi7ZgnEiI8y7YOqclDcCr3WGCDhuflUNm
         8U7g==
X-Gm-Message-State: ANoB5pkdvsBzDPRKlEM18ca9gkOkLvc0VUsKsdN1wjbpzVrcc+i1+P5t
        WI8fnRY+aDWcnDOqOuf7KWHd6vq8ETg=
X-Google-Smtp-Source: AA0mqf5M/Hp99+CVKcibGdnsHb6qEQRkCwxYlvg3pPnpPHOpdc2Za2HuqW/sr340VjMv/NqiyV5kbg==
X-Received: by 2002:a7b:c417:0:b0:3cc:cc18:b490 with SMTP id k23-20020a7bc417000000b003cccc18b490mr12824717wmi.28.1670862680957;
        Mon, 12 Dec 2022 08:31:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003d069fc7372sm10804674wmq.1.2022.12.12.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:31:20 -0800 (PST)
Message-Id: <813e81a058227bd373cec802e443fcd677042fb4.1670862677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
        <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 16:31:16 +0000
Subject: [PATCH v2 3/4] test-lib-functions: add helper for trailing hash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It can be helpful to check that a file format with a trailing hash has a
specific hash in the final bytes of a written file. This is made more
apparent by recent changes that allow skipping the hash algorithm and
writing a null hash at the end of the file instead.

Add a new test_trailing_hash helper and use it in t1600 to verify that
index.skipHash=true really does skip the hash computation, since
'git fsck' does not actually verify the hash.

Keep the 'git fsck' call to ensure that any potential future change to
check the index hash does not cause an error in this case.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1600-index.sh        | 3 +++
 t/test-lib-functions.sh | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 45feb0fc5d8..55914bc3506 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -68,6 +68,9 @@ test_expect_success 'out of bounds index.version issues warning' '
 test_expect_success 'index.skipHash config option' '
 	rm -f .git/index &&
 	git -c index.skipHash=true add a &&
+	test_trailing_hash .git/index >hash &&
+	echo $(test_oid zero) >expect &&
+	test_cmp expect hash &&
 	git fsck
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 796093a7b32..60308843f8f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1875,3 +1875,11 @@ test_cmp_config_output () {
 	sort config-actual >sorted-actual &&
 	test_cmp sorted-expect sorted-actual
 }
+
+# Given a filename, extract its trailing hash as a hex string
+test_trailing_hash () {
+	local file="$1" &&
+	tail -c $(test_oid rawsz) "$file" |
+		test-tool hexdump |
+		sed "s/ //g"
+}
-- 
gitgitgadget

