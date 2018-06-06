Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A05B1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932344AbeFFHkK (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:10 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35759 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932214AbeFFHkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:40:06 -0400
Received: by mail-lf0-f66.google.com with SMTP id y72-v6so7564735lfd.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yMyuoCd+xmPgJJqGRzMqZKb2QeI+uMmxnUNlJb8uh98=;
        b=K7O2TSEyOIz7F1x90i4zxlUa/gfweqBQbT5YVwc8fjLNDviQeB8dMHU2uhLTcoBxHD
         8yuwU1EkhdakkqX1iX/JuN5BwbWzr4S4MN+xq7ZmEWC/C08BXLhXVmUl0cIqrOinRAs3
         cX4NbdyPBFRbhE9aENXp0IRA/EItDczVDodEXo5gtUyqkHQogqvOaVE35vKgYuSP3Yov
         sMk3DdpqtHFYLQNsxA14tSfOZcHG/jqLJjXIOKzXFLa3mCbWda0mKd9ogTT7LzxIBF8J
         2eEhCBHkfi5d1w7hpXcgxTu0rgy9qPIoU5VCeBdD61UUnvQcIDvOHaDsDlmvao05u4JN
         pIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMyuoCd+xmPgJJqGRzMqZKb2QeI+uMmxnUNlJb8uh98=;
        b=KZW4GkBJsD+Z7Bt7fK41vkv/wDgNF3tQgASaW9GiCd9c71kaIc2ZamLLas3UJ+MpTz
         rSGHHuQHmNFTop8mzmBPDaHyBPtI/JeBm0VeRwGkTGdiR347uJYiriQY+uX3dx1VVZD0
         Y+ZTJtUSDhllY04jEu4BXsWWp48O6QabECLLVWSt3Ryhzj+lI0qye/60M+1tQkZ2cyKD
         vDbFqmYT2ns+wtDgkl+nJcKpInnkDgLZQOBUkcerhoSkFprnuNzcxrA57iAGw9rRw8f9
         78yiahwV7DrvXTYCjCmmRpgvzpt4TD6e2x1m5t/RZVGDQtFTR1pnzXo87WsUbIUEMm9M
         MXJw==
X-Gm-Message-State: APt69E3MT4VCzy4CjP6JkkRIqYEFEP2Q4igUxgbpsaeOYYoMF8ti6qd0
        ov8rUDZ20+lf5B08suY0k0U83g==
X-Google-Smtp-Source: ADUXVKLEB4FERsq9WsNkbI+2kgcQkkgzmJqkCUE2pGtnhCIgsZ+O049Z5Kh4yzzEGX/jhY61zGPGvw==
X-Received: by 2002:a2e:92cb:: with SMTP id k11-v6mr1260298ljh.18.1528270805393;
        Wed, 06 Jun 2018 00:40:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:40:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 18/20] resolve-undo.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 09:39:31 +0200
Message-Id: <20180606073933.14755-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 resolve-undo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/resolve-undo.c b/resolve-undo.c
index 9c45fe5d1d..a4918546c3 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "dir.h"
 #include "resolve-undo.h"
@@ -146,7 +147,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 		struct cache_entry *nce;
 		if (!ru->mode[i])
 			continue;
-		nce = make_cache_entry(&the_index, ru->mode[i], ru->oid[i].hash,
+		nce = make_cache_entry(istate, ru->mode[i], ru->oid[i].hash,
 				       name, i + 1, 0);
 		if (matched)
 			nce->ce_flags |= CE_MATCHED;
@@ -186,7 +187,7 @@ void unmerge_index(struct index_state *istate, const struct pathspec *pathspec)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (!ce_path_match(&the_index, ce, pathspec, NULL))
+		if (!ce_path_match(istate, ce, pathspec, NULL))
 			continue;
 		i = unmerge_index_entry_at(istate, i);
 	}
-- 
2.18.0.rc0.333.g22e6ee6cdf

