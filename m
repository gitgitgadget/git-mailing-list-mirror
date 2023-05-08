Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A65AC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjEHR2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjEHR2G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:28:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A25729C
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:28:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f41d087bd3so14851195e9.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566878; x=1686158878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zotUQjqa062F5MjbHVx0PvV4jScR+pyZF1O65Od+bRM=;
        b=KV9LzBaJXWCqlCr5ksj/L25Bw4sEYyVxG5fTRU0SCUcsccy+WNZCKAysM9Mx75RI0L
         4wozVNFN/rfV1MSOSS6N98aknVOa6+W1SRmwHlCLIIySwUKzGbWMw6p7/TMO55qY0HVW
         deJLBf/gDKM99uHhRJkSkRhRkVEcJWssup7M8xczq3KsPb/eD6oOFRBuSVsgiVEBKybl
         15wxcpS0r+QkBz8u8qCiYiv9fR3UBefAqA8Yro7K7fFfWTw4oMWfeLcVON8JtuWxHTvI
         O3dgYss8IYNRnsbGGdiPykHv8xAdJyLJICTzDn3vhl4szmnB7YRPPdMxY+MIFf8MaMrU
         UzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566878; x=1686158878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zotUQjqa062F5MjbHVx0PvV4jScR+pyZF1O65Od+bRM=;
        b=KWdgY162e8GnKxDH+SJZVywriC/itj7MrntWHi935pVc2Zv5yVlJHN6qzhT9gTozzP
         8imN9Xjjg8eKGdBtBbLhzNmKEjtWfoSEhJTtWHnPlRMPW6BqxV1VF02MfQId7WwsKR+A
         IsPbEa7PaN3oamM8lnN7szYJhSICvZPnl0EwMF0mZrIp3OeubpyaVgMXTQG2yd9uN8Fx
         Jauqehv7k8LSMVDDlcItDBgkk8Jjk7BrB2jmvZlUvFCh/xc1jhl9+xRROenOWSN4jtLt
         8NT4VMFiBE5VjZgWA62HaMMOD4JvKk9Zi00xkkXQcyHslyVPpLQrRbtd/hzd4gdOSZKw
         Zv5g==
X-Gm-Message-State: AC+VfDxe6QwQG0K3sAu3fcj5/CvNTUQl/EoJ7nW28VE4uR04QtBwEER0
        5U9JQJW/nvqH35qP5UQcTho0uFtUD/o=
X-Google-Smtp-Source: ACHHUZ7Wf3MhukMgakiEBuGYjmlOd4i/el8Ja9u53bg7RygbTCZ2P5VhI3Cl/mjrtnOUDil032RXVg==
X-Received: by 2002:a05:600c:d2:b0:3f4:28db:f609 with SMTP id u18-20020a05600c00d200b003f428dbf609mr1130581wmm.36.1683566878756;
        Mon, 08 May 2023 10:27:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5-20020a1c6a05000000b003f4266965fbsm3142800wmc.5.2023.05.08.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:58 -0700 (PDT)
Message-Id: <2c04a5ba7f0ac16fe648c7dac2684523429378af.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:49 +0000
Subject: [PATCH 10/11] doc: trailer: mention 'key' in DESCRIPTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The 'key' option is used frequently in the examples at the bottom but
there is no mention of it in the description.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index c9b82ceba34..119dcd64f34 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -43,7 +43,9 @@ token: value
 ------------------------------------------------
 
 This means that the trimmed <token> and <value> will be separated by
-`': '` (one colon followed by one space).
+`': '` (one colon followed by one space). If the <token> should have a different
+string representation than itself, then the 'key' can be configured with
+'trailer.<token>.key'.
 
 By default the new trailer will appear at the end of all the existing
 trailers. If there is no existing trailer, the new trailer will appear
-- 
gitgitgadget

