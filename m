Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027E61F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeFCQeu (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:34:50 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40581 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCQes (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:48 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so21572070lfc.7
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65mcW8uT7Zc6BFvG/9d5DUJVc9fARiglItXOyYutaYM=;
        b=orDB2mtIvO1ocv9PIhmvczT1FChZur+5p4fnWEd+iVogEyCQEbNuHCX96B/WejQGAD
         Qq/04w2R2xlDE64WrL3H+pc9hxTNQcT4QdwGzWA+RgJCOTuNcCX/tYPo6HfZ3jcpU41w
         +T6prnyOPKrnwwJbHKhiACDKc1JaqkMLQmkw9SZ9tZHV2GRUfqaiP79PoYXXSWs3vZrT
         t8bT7BGlUE2XOdTR1pRF5vxCejRFdtm220Q/98wjTbvdxShlb693lC3ysOs35OignyKS
         oWOHPwky1Lerog096mc/nSA67EVX9WeJXz1qNqObtdkl1C/5JjlMH2BVAnK60Y0MeKU3
         Uj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65mcW8uT7Zc6BFvG/9d5DUJVc9fARiglItXOyYutaYM=;
        b=qOyoWloQ8glNZnBHKsT14Ke/GVZtwdUNnsn6r2/uXcnBiAsl0raqs6VnNCRtnzF85x
         iLia/bjggJYn1B5i4tVQMjBAt30KBHqLAomw9Br1rUZovJQucCXP07z1g+0QIXWRBFo/
         6Jq7DjrFMKcVXKRh1zVF7/f/tS5NeE2NbvHyABt9zrHjAI7RGqpsZgzasG9lgqENRq1R
         sXOVusgVufAhea3iqNwbzsTQd8+EM+jaGRAKyIdnRsbeaGDUuYRK4pcVOFPKO513rNwA
         msbYjYPfgA2pL7BY5spdRbcA9w2+Eka10nqzCZr8tAE6Naynq5uiZNu0OVUSuOfsCFFH
         fVeg==
X-Gm-Message-State: ALKqPwdYuwtEeX9RJqq4wp2sa8/1iT13hcDvc1duNohcbGVmkS0JLaiE
        brRNmt/T5vFjgEe5qObZZ04=
X-Google-Smtp-Source: ADUXVKLwGT0gMOKETHdPW3yY0YWswR+r5OiRfhL2ZyvQdf8+RhHSZmaF4HduPRRqtqWVlS2nG8HSsw==
X-Received: by 2002:a2e:8951:: with SMTP id b17-v6mr7233773ljk.111.1528043686982;
        Sun, 03 Jun 2018 09:34:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/23] builtin/grep.c: mark strings for translation and no full stops
Date:   Sun,  3 Jun 2018 18:34:02 +0200
Message-Id: <20180603163420.13702-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
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
2.18.0.rc0.333.g22e6ee6cdf

