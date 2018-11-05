Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2C31F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbeKFEmX (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35406 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKFEmX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so9145938ljb.2
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvg8Z+FQnMXcOmkITbXP+xdOyJ+7C+d3npGAZtsVRp4=;
        b=gR46Cc/gUu7+d0409H+I8JSSuK8usagjMACnR2/Dp4DHysaRmnWlIkA6ia54Ojk+C9
         0ksZoqiozDMbzud+qfJcoLFyCXIO4zIety8xEAevhEo7CKUx4Jm8mn8JVAOAkQzhTzqm
         NRaq9xwk3tu+DcYVEQhrOVy/kAvO1repP+3r5gye6KPtFVOO2bHGmiCZaIgOpmjVuLsE
         HpxXeUAzOpKZZKybHCP6WL7c5nJ2zPMIIrqxVCcKv9tRNPomfpjwBxvSARMubg1jlCxA
         /wKS14rnLxc9ASDkvPqY7YRxs6pnB1M3bZqbOvbHXdn3mBz+FGoxeWC7+2gcsL6wOW25
         YSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvg8Z+FQnMXcOmkITbXP+xdOyJ+7C+d3npGAZtsVRp4=;
        b=KBw7fNoMv9mNkzwbc1gHRx3dcYdl64P9piWAzCvTmQXuquiXJTcZq3Z3v2xnNVriSV
         OT4c74WxPDbBdH6hXm8Qe1mdBPCSXVfXnuNuXmVGYifLwQN9qWpyQyuVzDKaP/BcjGKq
         tvApxxnhA6LS9jAP3p8UiGSZJ+0qVffVOHbJMDJ57MgqDNW42DdpaBVYNEt92EXISnmI
         UbCLW8iKLVp+H7VWr7hfhLaq4zE+WmT/2c7l+t4ZOD9BKEAUfgnpCvO3H3iyQdx08B8w
         UvqXG6dBF/0yoJr6g7wV2fF45AST8d/E8/Y9t8F5OGoC358YpR6Tg+kPNyHBzZRbkots
         +ZSw==
X-Gm-Message-State: AGRZ1gIyrqRy0zaEYh0duKZIrTa9bgUwRni6q7Go7qiiL3RZ7MVfh6PT
        xFAykdwdD+54yd0qzSIJ3Z0=
X-Google-Smtp-Source: AJdET5cf1BucEI4YYdwXAQV2urS0kZZMI6ue/acDKuQnasv+Zv0GEnAEZFRadtKWXMhvpNNsvu+HjA==
X-Received: by 2002:a2e:9d50:: with SMTP id y16-v6mr16483902ljj.136.1541445672183;
        Mon, 05 Nov 2018 11:21:12 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:11 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 05/16] read-cache.c: turn die("internal error") to BUG()
Date:   Mon,  5 Nov 2018 20:20:48 +0100
Message-Id: <20181105192059.20303-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d57958233e..0c37f4885e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -316,7 +316,7 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 			changed |= DATA_CHANGED;
 		return changed;
 	default:
-		die("internal error: ce_mode is %o", ce->ce_mode);
+		BUG("unsupported ce_mode: %o", ce->ce_mode);
 	}
 
 	changed |= match_stat_data(&ce->ce_stat_data, st);
@@ -2356,14 +2356,14 @@ void validate_cache_entries(const struct index_state *istate)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		if (!istate) {
-			die("internal error: cache entry is not allocated from expected memory pool");
+			BUG("cache entry is not allocated from expected memory pool");
 		} else if (!istate->ce_mem_pool ||
 			!mem_pool_contains(istate->ce_mem_pool, istate->cache[i])) {
 			if (!istate->split_index ||
 				!istate->split_index->base ||
 				!istate->split_index->base->ce_mem_pool ||
 				!mem_pool_contains(istate->split_index->base->ce_mem_pool, istate->cache[i])) {
-				die("internal error: cache entry is not allocated from expected memory pool");
+				BUG("cache entry is not allocated from expected memory pool");
 			}
 		}
 	}
-- 
2.19.1.1005.gac84295441

