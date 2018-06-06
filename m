Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0DE1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933807AbeFFRDQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:16 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40365 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933788AbeFFRDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:11 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so10219771lfc.7
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Euk4diy/4P77yW0831lQLiBWzlNcv1SeUwVpoiSHgs=;
        b=ODqLvH6wujEkKvvHCRLcVwd4YdhVwOI2EY3mr0PzutAWJVyZGLdvSSEjH1wym4E/Yc
         TxilgpWBD1ueNm1BBCfge6DUhLfIJO2yNo6lt7KfX1BPXQzxIXwG9xrhUe6xAvx5YhCC
         c0kXpcntVMUVrpPLO71U5cX8W9RATzmP+Ohj9r+7dbTYanInsuXMhU6SlROF850+NAnW
         M+b//XsO3kTqMoWe4nCRNmvPDvqo9pLhlZ8w4u+LYKOWOZzplovzg9Z5cl8MHUnXRCjs
         otpU1hqbHYl1oCnqXs7pPNyvl+ewTnRE4zpKTL9OIY5ZviS8oPynQloRKdseeW/2jam0
         bssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Euk4diy/4P77yW0831lQLiBWzlNcv1SeUwVpoiSHgs=;
        b=Hu9bxSSRMYNQ5iIP72OUyWagstAQxS1S7ycPWheGsnoWmImHhHtugdAyRLJXhj8unV
         TpNaR7EQKt2Lo9V4v74M09aSmDJbgatVKHLNFILGnKCHXvEoE1qhG53CLB30ntTDJdVu
         JVcp2TDq9wdWP71/2531fk/z78x4UiM9MFYCrtfXTap7jwIH8d045QKSDfprGyJAcXyZ
         vmNMPwBzC/+FYfRw4MA9raNYz5mqir6AA2Z/g4id+ZUDO++KD8eWCY1CjzzPi74ZgVir
         ZXyN/DEAFA3RrwSeiRAOv1AA5P/Mew17mSL9n2620d+xRYooMd4925CyYFHMQybaiNgt
         UUGg==
X-Gm-Message-State: APt69E19TkpxkzEGq8dKQwgmnSZbaPmLZKTB7oY0lQPiecFVZkvuqLUh
        r+YlCI2UDkrwP2+Wfk13FEw=
X-Google-Smtp-Source: ADUXVKIXwI8q2MiMFH2U+e1QlEsNfAXXcphGnYKZyYj07l8eynS4bF/iMXhNYOXLMmhKqTP2UH8nmg==
X-Received: by 2002:a19:7:: with SMTP id 7-v6mr2497861lfa.62.1528304589925;
        Wed, 06 Jun 2018 10:03:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 16/23] preload-index.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 19:02:36 +0200
Message-Id: <20180606170243.4169-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 preload-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/preload-index.c b/preload-index.c
index d61d7662d5..cc2b579791 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2008 Linus Torvalds
  */
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "pathspec.h"
 #include "dir.h"
@@ -58,7 +59,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce->ce_flags & CE_FSMONITOR_VALID)
 			continue;
-		if (!ce_path_match(&the_index, ce, &p->pathspec, NULL))
+		if (!ce_path_match(index, ce, &p->pathspec, NULL))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
 			continue;
-- 
2.18.0.rc0.333.g22e6ee6cdf

