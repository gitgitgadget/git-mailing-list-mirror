Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0B7C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5161A23119
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEjlCuTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgI0OBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0OBK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 10:01:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55094C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:01:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so6168944ljk.8
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WVfG4NPGVRjcbUB6K/0s+sAc2dKjBsEwOKTfWEXl6g=;
        b=AEjlCuTqoMaYtRTNvMLWA+6mRjFc9YmL+UcHWfp7Un0dcw+fNBB/SyfchnJGRsKTkf
         ufVEEOTgQrqI3srcMdTga23rmWT9TrHnB7iSc0c1cCLOULklEgO/H6ZYRS3kl7qdjbBJ
         85olQZdUQDsq4FDbF5lqLibO6f+e+LSxwwjPhHZz07IzBUTekOGiyN8WZtmUZtfQyY0B
         C8xSPkBMxhB+rWp7q6E+4LiWt23+IFCuEjiRvgtrYiZQganJ/J53mYWXjQnbd+TrvIIv
         eMj/rsbl17aqhW7bqhmPRfbM57tqkYstDH9Ws44H7Qmp8XJXIE3SsrImXEsgcVFHVzFj
         6o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WVfG4NPGVRjcbUB6K/0s+sAc2dKjBsEwOKTfWEXl6g=;
        b=BKToVd6PKpZ+pmcgWN+xeHN92YPbLFcq9JTrmPZ4MspZi5tgvenkiOpGM0fqvbjvsd
         BtDThtq9oKuHYDJiiP+lhrz+0m2SxoWEEkcVaYSaz+ko9Ovqoxp4DWRciSi+sCVXAUkp
         KuLsTkSZFjukwZd/hSA8e1v/EjcUsAwp81zgX5QxWl0rOIkIxmfQPQa8yy+JRfNXvZ7E
         mVdsbDvLVCpWEoqHDD7QkjMShjmcUxWLctZTsjcqPQdomLrJKPqCGJbWpJ1nrHzS/z8g
         NPU8l3NNJhiIoFB+3VVVeblx1WkGGRaGuiH4DEaFN2YcLo5uk+o8fjgvxkR/vr3l+o6Z
         rfOg==
X-Gm-Message-State: AOAM533AUqA69kYaXjZu1IsRgNSyUloQO6qHuW6kvCziGTva9iKbe+x3
        J+hgZeJRP2kXquxGhrL1+X3B+WKK4sM=
X-Google-Smtp-Source: ABdhPJxnZWHGOyLDojUx5Uqy2rXwf2mf+fk5vyKep3A2j97uwoVDk1+9SsTomSYNvIA+xprDyl1JvQ==
X-Received: by 2002:a2e:b054:: with SMTP id d20mr4099700ljl.406.1601215267379;
        Sun, 27 Sep 2020 07:01:07 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id p4sm2518491lfr.68.2020.09.27.07.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 07:01:06 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] config/fmt-merge-msg.txt: drop space in quote
Date:   Sun, 27 Sep 2020 16:00:45 +0200
Message-Id: <20200927140045.9668-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We document how `merge.suppressDest` can be used to omit " into <branch
name>" from the title of the merge message. It is true that we omit the
space character before "into", but that lone double quote character
risks ending up on the wrong side of a line break, looking a bit out of
place. This currently happens with, e.g., 80-character terminals.

Drop that leading quoted space. The result should be just as clear about
how this option affects the formatted message.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 On jc/fmt-merge-msg-suppress-destination.

 Documentation/config/fmt-merge-msg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/fmt-merge-msg.txt b/Documentation/config/fmt-merge-msg.txt
index a8e8f74d0a..3fbf40e24f 100644
--- a/Documentation/config/fmt-merge-msg.txt
+++ b/Documentation/config/fmt-merge-msg.txt
@@ -13,7 +13,7 @@ merge.suppressDest::
 	By adding a glob that matches the names of integration
 	branches to this multi-valued configuration variable, the
 	default merge message computed for merges into these
-	integration branches will omit " into <branch name>" from
+	integration branches will omit "into <branch name>" from
 	its title.
 +
 An element with an empty value can be used to clear the list
-- 
2.28.0.277.g9b3c35fffd

