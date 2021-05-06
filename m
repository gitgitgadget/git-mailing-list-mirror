Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDE3C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCC661090
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbhEFQxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhEFQxr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:53:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4435C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:52:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so3413444wmn.2
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Co0d1CBaNMlWOAx/tnA6iPj7GRwGq4paSIRmxwG10ec=;
        b=Xyr7Y83JLcXZiH5Oh4nRXfi2SDbdfbrs+Wp4okJcU01iuI0Db7CBd99VxkHxMbXeTS
         biztFksxtKz7vdQDaDNbqCJUOdX/pGgJuGHWmZuH2JR61hkKR7PMj8+dXfqhGS49W/GR
         Uycn1U/7hou0BHe0rk5K2tvk0in4em2MmZ5rPD+0WBqE3RKRWx4b3bJDmuti2EAO9c1Q
         mjeRn/6u3IK3NcPN9pv5LBcsVvx9GQeryG5kXxYno+3/Xj8ED47dAm3L65zS+R6flzHU
         e1ZGbB9bFzYrt+pv+KKrPuO3SDMbJRFAdF9xGA9jKTwEZ/8Ax43A9tEbRd4NDXmWlfJ1
         a8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Co0d1CBaNMlWOAx/tnA6iPj7GRwGq4paSIRmxwG10ec=;
        b=YL4Op9ZCYQIOO/wyfOAR5PEnPTwE7l0nvHa3s8bfjH1+dW5n/kgvu0ozUjTiqwHl8f
         j1nhNcTzuee3nlwn3Hdm8EPyuPcT/i5GMx6o5DS+0TEAgd6xFArOXqNa96EnV1otfGDe
         N2hdsv3BdKUuLkKPzSIme4f6/C/Qrz5ibX1X6tsLK0n/MCJEIo5h/Oy3+MiyrpsP5FkY
         hcBQHTNGpKOCZA01+FOe9Dqr+tT9IRKLWHwni+p+toG6Vuzvgb8CB/9aGSypT2c4ILbd
         d7nO05t1b1T2m4Ab8mfLuN0XfoXS/47jJAk9KR7jLHzusA+qVH4vXNEonqjxhLQfkySi
         6Y1A==
X-Gm-Message-State: AOAM531AXhBbM4wdQ2gsiUIZkSOQAsTlpY/5a5MUBXYZZXzTViAwg7WT
        yU5E9/DM6uO4xQG970DoxII=
X-Google-Smtp-Source: ABdhPJwKqwqh+gxqN98t61QoC6WsxEagsEV9jqpyq+zpkRUvLVvKouzj7Eh3LwgaO3cjN98tW+lsCw==
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr11487619wmq.78.1620319966533;
        Thu, 06 May 2021 09:52:46 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42006d71140a7638f172.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:6d71:140a:7638:f172])
        by smtp.gmail.com with ESMTPSA id y14sm5354482wrr.82.2021.05.06.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:52:46 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 8/8] config/format: describe format.confirmOverwrite
Date:   Thu,  6 May 2021 18:51:02 +0200
Message-Id: <20210506165102.123739-9-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.450.g14fbf8793d
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/config/format.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index fdbc06a4d2..bc189e3ec8 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -42,6 +42,11 @@ format.coverFromDescription::
 	description. See the `--cover-from-description` option in
 	linkgit:git-format-patch[1].
 
+format.confirmOverwrite::
+	Determines when the user must be prompted for confirmation whenever a
+	cover letter or a patch is subject to be overwritten. See the
+	`--confirm-overwrite` option in linkgit:git-format-patch[1].
+
 format.signature::
 	The default for format-patch is to output a signature containing
 	the Git version number. Use this variable to change that default.
-- 
2.31.1.449.g4a44fa8106

