Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC98CC433FE
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 16:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbiAKQkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 11:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiAKQkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 11:40:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C5C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:40:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso1812235wmc.3
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SagTRgb0Fa7LKdm4Z4vqgY6AAgSxRW5l9yIC/I1rIDg=;
        b=f0hQ4KFlesVBtO/etDAq5Bd49HonkEv2i1aX+5fjk8Cc/4AhnVlRoRdydjU6kzqaYw
         Xxdg2ORD5gPzHnOOs/iRx1SBTxOVRUcAQCBQnwPfty+iQ3sLkvLFJyw96cO4VaTjtLKs
         UIWzqHzL8MyyKrsXbZCGGhZsMDlRuqdid9//Vge6G75kYhRJP5EdLqY/k9P0nsTruH9A
         D3kmGIBWr7Rc8eDfTnQek1SiOc0bY5CzfaasDRfUPdRlwY7Hn/MACSiovqfYodQvzNLU
         sY1LkFZeLqS0WmG5bCbvgNjCF8Wyos1J4BHxu1i/hSqe44q72PiP6UYzr3BnQO1B5v8k
         NpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SagTRgb0Fa7LKdm4Z4vqgY6AAgSxRW5l9yIC/I1rIDg=;
        b=vOXHJw1CQDtU3uyHKxlItv3B7XSm8I+u0HRx+UJa04GTebuWJm0J/z7mpWKw0erk4Q
         k/HWLKQ0izAkPalp2XIwzbXw/P8tnWOcGyz8lttbqzV8wZO+uy9C2+A16wXLaxYar8uW
         fRSpYRJBSxiW8n9k64dV+8qeBFjaDsMWjGGR+rYxrpcCOQlTixK3Kw6cu00QHbdCdkw+
         6Qq+8Axn87e6atq21WCKgUpjY7im6MtgK0X9L/cCwUwmsNOVe37p/FfH4a819ctuDWBS
         NSA822E1LPL80hgwA1eJYnKceEUo51v6TUoAFrxB+/G2SGXV60dEsffagCdPzLBPRMfn
         JUKA==
X-Gm-Message-State: AOAM532FC5/NYF0H4mKQPcYn0Kf/BM3RIG9bM3xFYes2nybUNHgfQME1
        1Rb3qg3TJgbPMH5GJ2OMMCV1ZLPUDDlG1Q==
X-Google-Smtp-Source: ABdhPJyTtUOU19cY7aTk4bYeSefvSrl37/yfVaLsMJROrxvJWhCawEo35iljG3qxvL2oHpZjigeCMA==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr3181175wmj.187.1641919241015;
        Tue, 11 Jan 2022 08:40:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o38sm2536934wms.11.2022.01.11.08.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:40:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] test-tool genzeros: initialize "zeros" to avoid SunCC warning
Date:   Tue, 11 Jan 2022 17:40:21 +0100
Message-Id: <patch-1.3-4dadf7320ab-20220111T163908Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.844.gb5945183dcf
In-Reply-To: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It isn't important for optimization to have this be "static", so let's
just initialize it and avoid this warning on Sun Studio 12.5:

    "t/helper/test-genzeros.c", line 7: warning: const object should have initializer: zeros

This amends code added in df7000cd910 (test-tool genzeros: generate
large amounts of data more efficiently, 2021-11-02), and first tagged
with v2.35.0-rc0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-genzeros.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index 8ca988d6216..5dc89eda0cb 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -3,8 +3,7 @@
 
 int cmd__genzeros(int argc, const char **argv)
 {
-	/* static, so that it is NUL-initialized */
-	static const char zeros[256 * 1024];
+	const char zeros[256 * 1024] = { 0 };
 	intmax_t count;
 	ssize_t n;
 
-- 
2.35.0.rc0.844.gb5945183dcf

