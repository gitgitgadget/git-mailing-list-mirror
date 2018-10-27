Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0311F453
	for <e@80x24.org>; Sat, 27 Oct 2018 17:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeJ1CMD (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 22:12:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40974 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbeJ1CMC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 22:12:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id u21-v6so4010024lja.8
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElWD/L0AMYKRyntyrlVCHl2EzE6d7g0uBaIj7GWAy84=;
        b=Oob7OwQsKw14If90cwG1VOpaZUsBQvqq1NRAo6WbqrKEbnKsLy4IJr6XNBgMdRON68
         cmfeAnnY3ZG++JhRc8AE6iFxXq4T15xPPQ5HvQaWf/LdlcNwIZ143nbiS0hqHHedcDHH
         9KTvGZmTvqJo98rNx/aZ9QHwDFSrOXSkEBJ5J2/Fl2zqFCCbaymUnXlhS6hDBmWRrYKJ
         lYrZTDqQPcvEjL6Phd7xJH9T2LXYppye5b1xvq1dsPt9OQdvnbBeT0cmu6kinoBVMlff
         MqXG2WiFlcPewOFM37yLEns5lDG+NNV1EjTWpNbOGKRI2QpPzuqB+AL/zYoby6+EwyUl
         FH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElWD/L0AMYKRyntyrlVCHl2EzE6d7g0uBaIj7GWAy84=;
        b=kEoWuB+juwV4boetXdDS+HHi2MmEP3zx9sItMgr09o+CJgjwRLUiA60FMu2yyW8Cor
         lV+oV+rQtWNq7q4Vn1zDkk0064BSAdJB8To6LiFxXjzni0ta+EJbqZGDXQI6bZpVM65s
         kaD9dcHPNBsgei3qZJJiPGfx0V/bwNXaH99xubhE+ENxpRUYz+VRdR57ZeNqfsQwLtF/
         jEmAMaUOn+yfWETvuB7a7unzLrVNlM7hmxUFzKJ5DD3rrbx5Hzj817EQiLugMITu8Bxu
         px06efUsZex9LM0Fi5PyqzDbqKKblUJx9heivBwelot5/vd/TffyFrSsPHrhbpzoSdJW
         17Cg==
X-Gm-Message-State: AGRZ1gJcGfLVWRWMvzZOG0bvJJbFzJsyh0n/Sc3QT52jjGe/e2oCiWD/
        oA2B6E9aBxvSFRPWcv0RmRo=
X-Google-Smtp-Source: AJdET5czt4r86YSA+E4v/UR9SnG/I5WfXnXihhj11HIkP8I4UyQ8NhEObbQtoUgdhsvuEHZ85Vh8Mw==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr5270634ljb.155.1540661419955;
        Sat, 27 Oct 2018 10:30:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i185-v6sm2333517lfg.89.2018.10.27.10.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:30:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v2 03/10] name-hash.c: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 19:30:01 +0200
Message-Id: <20181027173008.18852-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027173008.18852-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
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
2.19.1.647.g708186aaf9

