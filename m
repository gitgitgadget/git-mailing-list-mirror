Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995501F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeKCR7p (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45170 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeKCR7o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id j4-v6so3700126ljc.12
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdcFxYhrvVHOOkVUtpi6izgL786iaIL3UhH8k7T+OQU=;
        b=O8ympxlZRUYwkihRGgdCMH43v3Ua87/BsIpjIYJ6yLbQcBC4WsP2uc0GrrQWSVgzg+
         xhj0DRdTslOGOuDzff4w3Mv8m3xk3e0lkcXLtXIp5IQH2kgJQlG9ZvluMG1TK8SJRfZg
         dGWbX+cicpDPM5JUx3Cy1i2s4WKfivSTg0dePPuX/uKBe5JdnSpxcmaTe4CRSKdmP3s+
         ntXOtLhabP7mKbDO2hz3pIJDCeKeXvaIFwO5oeGCUKwzfX4uLwx4QNlgzBensCxl1GoW
         FpnIQoX1RyTJa5FwnQz0OeYIM2cvL9AypKHlvepsgEjJFtIkU5OPz77vMWT8ewjruQU/
         KJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdcFxYhrvVHOOkVUtpi6izgL786iaIL3UhH8k7T+OQU=;
        b=O7GUniTCQxrjlpNF4i2jEXpNLC/JOD/nho+Vtv0Urho16/G7AyZm+joosGv/EL9dWi
         RaDUQG51K4xRdOHqXhDVYIiG4G/KHwF6QKaEdp13IL1uFLLOgri9ZDKYf78x1BqtDTgT
         HDDyYSWOT2D8kJt+1Y3wgsidKVhHXJZWVlBBXJ+YhGgLg9CIpkodSBTTE6hK3E6Gwqfc
         EbvYGbCyBliPIKsOXNkRUlZ8jRG5FYurDhAYHhPhg3o2TFA3W+Vv5YA6Jr85lfPOeyG8
         fOTS9GjUc4BzvlW40HgIK5u7UHt7fJayciQqNA3gfInc4n/Fyhrz9/7JlqB5TA4gFMMw
         cYHw==
X-Gm-Message-State: AGRZ1gLml/ENHow1SJmk+RsKTpIhl2wLlNBeI32XLdx8nKcBlOzeAQSA
        wO38tElDHSP+uKaaQ0FzuHQ=
X-Google-Smtp-Source: AJdET5coVIbRvXmmN46BWocgqK/YAaGPh0t+xCyJ+BAPIOXQI27fYAU0g+izebB/iPUyuqoHKdcKag==
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr6616967ljg.155.1541234947061;
        Sat, 03 Nov 2018 01:49:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 05/14] name-hash.c: remove #ifdef NO_PTHREADS
Date:   Sat,  3 Nov 2018 09:48:41 +0100
Message-Id: <20181103084850.9584-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 name-hash.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 1fcda73cb3..b3c9ac791d 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -7,6 +7,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "thread-utils.h"
 
 struct dir_entry {
 	struct hashmap_entry ent;
@@ -131,22 +132,6 @@ static int cache_entry_cmp(const void *unused_cmp_data,
 static int lazy_try_threaded = 1;
 static int lazy_nr_dir_threads;
 
-#ifdef NO_PTHREADS
-
-static inline int lookup_lazy_params(struct index_state *istate)
-{
-	return 0;
-}
-
-static inline void threaded_lazy_init_name_hash(
-	struct index_state *istate)
-{
-}
-
-#else
-
-#include "thread-utils.h"
-
 /*
  * Set a minimum number of cache_entries that we will handle per
  * thread and use that to decide how many threads to run (upto
@@ -516,6 +501,9 @@ static void threaded_lazy_init_name_hash(
 	struct lazy_dir_thread_data *td_dir;
 	struct lazy_name_thread_data *td_name;
 
+	if (!HAVE_THREADS)
+		return;
+
 	k_start = 0;
 	nr_each = DIV_ROUND_UP(istate->cache_nr, lazy_nr_dir_threads);
 
@@ -574,8 +562,6 @@ static void threaded_lazy_init_name_hash(
 	free(lazy_entries);
 }
 
-#endif
-
 static void lazy_init_name_hash(struct index_state *istate)
 {
 
-- 
2.19.1.1005.gac84295441

