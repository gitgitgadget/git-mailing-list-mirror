Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D039C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 17:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLGR0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 12:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiLGR0F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 12:26:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9639669A9D
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 09:26:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y16so29088703wrm.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvTC4dVaqIpb1NK9YY6HU4hn/glAaEhIyfVbC4Etk6c=;
        b=UJDvSPXJ4Dky/Ddl0UzBTqEtVRdmWzlvq38/3jm9O2vPgiSQVIsr5syuYosBq01S1M
         oNs968wNe6CWczOuQZGlvTDss3g0TdfT3K4ow7/9m7LnBBTqRJbxU2yJVIGfjq0yakQr
         Lx2apTk/ZMvHJw38xiRKzUstYNNlloro0VtKj2GGupzQjiJboe94d0su6VfwDw0Kb1qJ
         71LKPjfZdt+Mt3AhIulVVz9VTKOTGriNRsxUXfdanB4m7LxaVD9mvYnZ8ZvSdl54UIiY
         HFzJeEOZ51wEWaJQuroHy03TzCz5RafXywNxOQM1AfX6Avr/T2cO3nGK+ws7vpxn9Jaw
         MHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvTC4dVaqIpb1NK9YY6HU4hn/glAaEhIyfVbC4Etk6c=;
        b=MASr4zs8hsj21rF0JcE+m60nwcWQ4hWrXo08xpob1LDHvm8nTHn50Kh7xkH6YKBpHh
         mYTr2unSyWeqwawbZ0pZKP3oaH4u5mXudH2CY2raNpe/qE1y3hMOD3llYF+f8XuxtOFm
         7h0c4LcdatnJUmCcnbvmrjJeCjBBAIAQ/JAvhqSzrkisxcRIdnkcXNvgoXA+/5iDVyZC
         1Cj/vORlkNQqr8EkPrrsAIh5DX0KRHH5f9XU+R7yD0XSsEHSJpmPLw9fGvVGQjjks35F
         ozIFOpVWXwPEqLEoPV9oh9jHbkTwHVPf2pSnD+G/kB8mDcHp5k1iTA0G8bGNLik7HXaP
         ScEw==
X-Gm-Message-State: ANoB5pnPUbE6Wa3eYKP5uRb8CGHC64gJxaXCWzlF22zxRF+65qN8vQya
        /TpIEBBVVTPrXpxrfb3a5yiMBF9z1o8=
X-Google-Smtp-Source: AA0mqf6RY77g9CV32Da/y7z/78GNtrMrYPW/vIZwpH7wx5PtUvI5e1wW107kAf2hyEN/AszAgwE2AQ==
X-Received: by 2002:adf:db07:0:b0:241:bf23:47dc with SMTP id s7-20020adfdb07000000b00241bf2347dcmr54121720wri.459.1670433961941;
        Wed, 07 Dec 2022 09:26:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az23-20020adfe197000000b002425504ae7dsm11845092wrb.80.2022.12.07.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:26:01 -0800 (PST)
Message-Id: <a20bf8de8645c19a02838d70a7c2c3b00378a50d.1670433958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 17:25:57 +0000
Subject: [PATCH 3/4] test-lib-functions: add helper for trailing hash
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
index df07c587e0e..55816756607 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -69,6 +69,9 @@ test_expect_success 'index.skipHash config option' '
 	(
 		rm -f .git/index &&
 		git -c index.skipHash=true add a &&
+		test_trailing_hash .git/index >hash &&
+		echo $(test_oid zero) >expect &&
+		test_cmp expect hash &&
 		git fsck
 	)
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 796093a7b32..e88acfdb68a 100644
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
+	tail -c $(test_oid rawsz) "$file" | \
+		test-tool hexdump | \
+		sed "s/ //g"
+}
-- 
gitgitgadget

