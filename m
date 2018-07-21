Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D501F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeGUIlv (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:41:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33116 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeGUIlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:41:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so12905266ljj.0
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYA6q6Fo/NDnwb5OWCjlLioxYmFHutAkWI8RMnyigJg=;
        b=LLzX43CYBieIbz0o7pNW6ZiMyOu7F0wA6glfQV9czqsKkpd0tjwpxdYOG8njwAyJ6d
         a6qn+M1y479mJUQ2nE8qLprFuz8CvmYrVFW1zh7V7tf7YJjgtbidA4UtjgO7fc5Kg+ws
         nBl6KX/FTKl7VJUlirl+guvzf9vHBsdn1fG89SdkzVkP4BjEwMut8pazK7eJlE86euu3
         r0lGtM+4bkWNMi29eBia2jdZM9kA7WkmkFFqWL3qskDB0aph0avpWAJmEcRVc7r6wre/
         wxBjtwGMtC5RO+aEcWZ4r+GzGVBFzDeHJYzrRP+D4hN8adbFrOMcgfR8wvzOJQ1PBjaH
         4iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYA6q6Fo/NDnwb5OWCjlLioxYmFHutAkWI8RMnyigJg=;
        b=ZCEt1/npu8ciQXRluz6IWMs8etGVchNNzIigy4p41pEsNEjM9lbIZpFjDyYWjeMKYC
         29/bME/ug5N4KpWnFPK9hlRUcNoWNzXSH5r5f4Jez/m3ctIhWytSpi0Kj84FqRcJlAhc
         MK1aZQxBw+96v4jWx6rAIarr7/ICDIYRwSqrXcvXasy2t0NLO57dNfqn823KtLZpx9RU
         Dd5m5wFC1108IiluIib4/TCsQ+YaWJDLpOcLmc5w0y9vcbGb3NiEX1Vos4WKEzorpuGQ
         rAfPbQY90tSdKqj18jTxn3B8K5Uzxk0sVuh8rmX8B4/LjQ+fizALwcn/dZLPCe8eModf
         dXEw==
X-Gm-Message-State: AOUpUlHLWZYGSsXBR/bI6nYGXP5L7TbB0ip9eMAFOjh9rA8tCU2MjkGC
        IYm5FjspCY55lhdOewuiKbI=
X-Google-Smtp-Source: AAOMgpfnchIvW/qgrOONUO4z0ZNMaGzw+FdI+WuUoRksAMM6mD3D8Dd+r7in/UqByxHRbVvzzMUQww==
X-Received: by 2002:a2e:9c4d:: with SMTP id t13-v6mr3428667ljj.153.1532159401022;
        Sat, 21 Jul 2018 00:50:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 05/23] builtin/grep.c: mark strings for translation
Date:   Sat, 21 Jul 2018 09:49:23 +0200
Message-Id: <20180721074941.14632-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9774920999..58f941e951 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -489,7 +489,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 	}
 
 	if (repo_read_index(repo) < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
-- 
2.18.0.656.gda699b98b3

