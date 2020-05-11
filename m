Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B32C54E4A
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F012137B
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtHibR81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgEKFuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 01:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728136AbgEKFuF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 01:50:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2687BC061A0E
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m12so11737359wmc.0
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zQN+HjQ/dT/FyjrBrIXz7u2oBqsVV+x91UQcCg4ZWwM=;
        b=UtHibR81nxh0RqBUG/y95qRWTIQOPgOxZFSy2eVH5moOhc+UxqcDcgjILvLnf0o+Lv
         rwzBPqvMpqmdh2xfJp0R98Aqh43Adb7WqplztyOYt6qxghpr/kbIHG3KJRhH9T9BrKF4
         uz1UbwqVYYlmnV4nJmJi9pg0C0Tl9MJS7qjZLaMwIYkpArYVweE0+oeHrCHvTOS3CXC1
         MkKqo7yxuznX/q27MnvM+5D45T0OFt4AblgVWjQAeGDhc94Kaaq5FgmVrUyH+WnK8DRz
         P2L8iVCeH/6F1qIErq8iEKwR0RLkYEGGhQ3YlVJiANJnsI0Dm2Pnp3cvKjZRHHkFc7r4
         6vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zQN+HjQ/dT/FyjrBrIXz7u2oBqsVV+x91UQcCg4ZWwM=;
        b=nZ5QodMyg7+WzmJdKfNXUXjmY6JqQYEezpT4N9SwNzUhVxfSA0L3s7WRTV0xMQ0HsK
         gIFiTvMNFEENrtfD1Z2TgvOviNzLmb6oPJs3GmDU3GlUHoi4rUTs3IUX6igOWcUNa3HB
         FI3QAB+1SxSiCFzE+wOGexjTdK7RO2OlrgXo+MYdo3MnfPRv/MwDDfXcU2pYAnmHjElL
         x+7tm/ClYEYjp4GIa49rqXWp4lJEzLdMcWiFFIKBOr7xaovMjL3rFF52NXNVu+NgNcZ8
         Kraiott41YN6tshw7u9ZEzZ62jm87t+Egng/LUrlWpl9YNzJJdZCmF7HPKDtCPbypsCh
         NqZw==
X-Gm-Message-State: AGi0PuYpfnOQiO8jWYVJFEg1RNbPVftBB6Q0B49OrXuO/3y0yfEk01lm
        THn38QAABLbBtQPAhW6H3fInJDb3
X-Google-Smtp-Source: APiQypIzU/I12avcfdWCIee5p06VnA4kA7EZAi3g1Diz0ElUiAc5RnUTphApJlHhWG9mBdm8L61q5w==
X-Received: by 2002:a7b:cc69:: with SMTP id n9mr3540823wmj.145.1589176203673;
        Sun, 10 May 2020 22:50:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm17296013wrd.9.2020.05.10.22.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 22:50:03 -0700 (PDT)
Message-Id: <74fa6704905d5fa4b60adb2eefa0708223010e94.1589176201.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.git.1589176201.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 05:49:55 +0000
Subject: [PATCH 1/7] subtree: handle multiple parents passed to cache_miss
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Clarkson <tom@tqclarkson.com>

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 868e18b9a1a..9867718503c 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -238,7 +238,7 @@ cache_miss () {
 }
 
 check_parents () {
-	missed=$(cache_miss "$1")
+	missed=$(cache_miss $1)
 	local indent=$(($2 + 1))
 	for miss in $missed
 	do
-- 
gitgitgadget

