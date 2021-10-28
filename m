Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F322FC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BA461056
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJ1U7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhJ1U73 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:59:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90860C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:57:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id y10so7203725qkp.9
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ITq5LGMhyiLiqpnPxtwJE//D3e5SsTBIh1aZakSbX1o=;
        b=O4HHmPNc7cJur5/vwrM5tXW1EWW6PTs8GJQcnZXzbPDVfxIaIzgyE3vKo04fl8EiH9
         y1TxfQ/EUUwnCeECyOxJhVm2OGlG3XVU4KPFq+5CJlXBf3EcaN3dNUhcqXSTQiU68P03
         ftkr8/Asbcsi6WuPKgCMCygKHzQLL5GaaobpikXwYZUi1YoJY2S7lcr7vrZM5Xcy1+OA
         hmCM22zIV/xlxrAnwLjT1cTdt8ntCQL+WsNbmquDHizLm7jLPj212Sp/JEzwxmTZZ6fU
         xXnQRMxnOzwPtlTFqSS5oWbbNBjHHy3SRL11rRPZRxsmQgF7QtiK8KScZn5ttZv9PABG
         0xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ITq5LGMhyiLiqpnPxtwJE//D3e5SsTBIh1aZakSbX1o=;
        b=KgskBes2YvGgEHX2sUtVH//aVFMzF5Zw8q+5dRCD1k1xYPjvK6TTd8YPhl3GSH5gH6
         eQM60FsehG3uFlE6jU40z493yt4t2thLgVkievNSd66YCgy5EPgaqzDn0BhvBR/Nu+qM
         kVNEzG2w3XEPJ/5SL/0M4ROxqf5Os+Y+9UPt0Qr3s3vpxQAeybuaZM2KbhhkOCFoE6yU
         yApQWt3v0Ic531Xjg787FKK7907IWDLrQ0vRs0Bul4TqhNlBd5dt2FYA8lJM/n49waKc
         +vdqIaO2JX3R7TPGwCqgOwGvmRd2oE8eF7GLOKoJFAjkp2orsnUp2bX8Gjgs0K+SuC8P
         yHLQ==
X-Gm-Message-State: AOAM5301xuu67ru4d5xtj6g+vKWKAbs1eh95TiAmELLj63MhTzGEQZ+4
        4/EDylbnAd+VEpfaAjFOFBOw/+4zeZM=
X-Google-Smtp-Source: ABdhPJxbIGjdZClTP3HfXOm0tTf71kXAP9vQzIa18vtSMpfOJpJq81bgwIfKmnFZtQfvm/m//8A7JQ==
X-Received: by 2002:a05:620a:578:: with SMTP id p24mr5736279qkp.237.1635454620500;
        Thu, 28 Oct 2021 13:57:00 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id az12sm2626136qkb.28.2021.10.28.13.56.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 13:57:00 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, vtbassmatt@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] test-lib: add prerequisite for 64-bit platforms
Date:   Thu, 28 Oct 2021 13:56:47 -0700
Message-Id: <20211028205649.84036-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1155.gbdb71ac078
In-Reply-To: <20211028205649.84036-1-carenas@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
 <20211028205649.84036-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow tests that assume a 64-bit size_t to be skipped in 32-bit platforms
and regardless of the size of long.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index fc1e521519..5fa7fb5719 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1687,6 +1687,10 @@ build_option () {
 	sed -ne "s/^$1: //p"
 }
 
+test_lazy_prereq IS_64BIT '
+	test 8 -eq "$(build_option sizeof-size_t)"
+'
+
 test_lazy_prereq LONG_IS_64BIT '
 	test 8 -le "$(build_option sizeof-long)"
 '
-- 
2.33.0.1155.gbdb71ac078

