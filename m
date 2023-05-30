Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE2C77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjE3Sm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjE3SmX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FFB114
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4789099f8f.2
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472139; x=1688064139;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=cvvi5LRxtouQw1hT7jlNRKIqgYJhLMMkPmJg7T9PgAORrCuj1ZmF7wA4TQWoNeL5lz
         Kht59TBPaHKtN96gkLYoBAl2oXkYClH2whgALKSqF2iv7escngyAQvS/RTRhR42J6TuW
         JkYsgBWznanqVKSvykpGr+JrI9H7krwjll5xWFe2WTmIE4CJGdm++db54SR6DQOaQ+oU
         Un2g2O4Y6v+NuB9AU5r3Qasew2Xc05t66Sw7TYZwEDWliXRmG0D85ZuANVESTDA74c6E
         GVEgZvmFScatjf5WKcvlRbFkW37u5P65SXRt/OfvU85CeqQ+9nNX+wjWqqsDdw62lKZh
         cXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472139; x=1688064139;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=BqWku9DkZq1LRxJvIgLyrTk7k12g5QlVSfQfRTKBJWwcvSdL2ZsL+P4qsE85FDELa7
         Y0yUmMV0L0Os/kNjvgK5TA8bqtw7AuxCb861pz3/EUsYlxahTDGcRHNmqSrD8xcr44Kc
         3l4Al2bGkYat5VrjQPFPPUbm0A6r4m+nelkSmE/tMQIv0qdOvU/ncx/wkF1Wof8xJSYu
         V0SP0GsRzAcTFfaFhPCrHZpGpYvF6iVcOhFXcudjNeenzmF70JW3o/r1dsxWZtpUVzoC
         /iEQhl9UvDzGWbp3j7eNBxEqX2Z/nXnu+6KqPhCN9mKPpgH2FgLmZ685heE0VrBgTsqG
         cdYg==
X-Gm-Message-State: AC+VfDyHCHY/QdJo9jRSp192WE4BZAO8Xp3Sjf8yNKHB6WFTTN+A/9zZ
        27x8WUUYvvCiDstr3vOADl16gRAO87M=
X-Google-Smtp-Source: ACHHUZ5hUd/FID1MONgvbKhcXhuKiF66iOiDWkH5jYzm+/5j6de1hGmITQrsW9wokaXdbUsWJzfDOQ==
X-Received: by 2002:a5d:4c82:0:b0:30a:ab38:30fe with SMTP id z2-20020a5d4c82000000b0030aab3830femr2538362wrs.43.1685472138813;
        Tue, 30 May 2023 11:42:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d4bcc000000b003062b2c5255sm4188976wrt.40.2023.05.30.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:18 -0700 (PDT)
Message-Id: <821f0b905803fe4f693a64e424a61119e97c3dce.1685472133.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:00 +0000
Subject: [PATCH v2 02/14] urlmatch.h: use config_fn_t type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

These are actually used as config callbacks, so use the typedef-ed type
and make future refactors easier.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 urlmatch.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/urlmatch.h b/urlmatch.h
index 9f40b00bfb8..bee374a642c 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -2,6 +2,7 @@
 #define URL_MATCH_H
 
 #include "string-list.h"
+#include "config.h"
 
 struct url_info {
 	/* normalized url on success, must be freed, otherwise NULL */
@@ -48,8 +49,8 @@ struct urlmatch_config {
 	const char *key;
 
 	void *cb;
-	int (*collect_fn)(const char *var, const char *value, void *cb);
-	int (*cascade_fn)(const char *var, const char *value, void *cb);
+	config_fn_t collect_fn;
+	config_fn_t cascade_fn;
 	/*
 	 * Compare the two matches, the one just discovered and the existing
 	 * best match and return a negative value if the found item is to be
-- 
gitgitgadget

