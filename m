Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5412047F
	for <e@80x24.org>; Sun, 17 Sep 2017 20:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbdIQUR7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 16:17:59 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38437 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdIQUR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 16:17:58 -0400
Received: by mail-wr0-f193.google.com with SMTP id p37so4004030wrb.5
        for <git@vger.kernel.org>; Sun, 17 Sep 2017 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WxF2//fdy9u/GyhNRwYKY4X7ukYAH7HtLuKe9zhhDMw=;
        b=tKyomEQA4eLZlVMR+6gW4fVC6sW4wuD/KiUFmnNu6SPCPIV4pCcsYuSmI+tfVNZr10
         RNdC9NvyXUkDCYwkLerPEoWnAob7gFOz/bGj3TAR0Zclz+4w1i+BcObqvJ7RR23XX7FI
         47DZQrtjE1ZtIkgjdcNYCnLNMnLpRaW/33v44Pceq+deYCguX5MtezcKILIh87pQ7Sb5
         pJ3UHrRmhXYMaItHWn5XX87PYPyTG7sy/d7x35WKD7N/bb5QTTRpBkPKAKDICSTheTa3
         oHtifIJUiuPf+Os3C14WbnVyKADtmNI+16W12V0UeqmaG70kLgaKU4bj0ujSdy5PaB2e
         9Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WxF2//fdy9u/GyhNRwYKY4X7ukYAH7HtLuKe9zhhDMw=;
        b=KCsCQB+o0e+30P3L6dEWYhMDDBOW4VOCSF4jQZHHALYEdd+vSGd7X3smPzh99TU6vg
         zGGcBo6Gvyi5oTcEvmzGKpYgWp2UFHtnIi+eyQXevzvqZhHJTtvWPTtUhnfVUTDRS7MY
         5grTMI/XwEnjYhkWkICXi2GmW9WvfowEthnzCxDPaqopslfZzXMEBFULrvJkiYQfugPb
         w9/6ls9ZpGC5LHabWOQZcpCcR9ZR22WUP+e2+37eW6WG3/2w0a/2I+Oc7eGykBmz04ZX
         PvSEfq3/HKpV77meJ6V3k6YCWb3xnxnzuygT0PM7e4taZEQlLiPV2qGWKQnlZRA+ePGw
         LInw==
X-Gm-Message-State: AHPjjUgur22aTpyRkRFnn7+zu/mktF8rwI26WHV/fKh4WsmBDbuVPRDb
        eJfTrT4qqiVkCg==
X-Google-Smtp-Source: ADKCNb4MdGgKpMGoPqDnJwBUOihs2s09Xetzm2VWye9cf4heMnKrgK4EVnUYUWPS113QiJ8Qkxxsng==
X-Received: by 10.223.185.5 with SMTP id k5mr22353294wrf.189.1505679477670;
        Sun, 17 Sep 2017 13:17:57 -0700 (PDT)
Received: from localhost.localdomain ([41.90.228.228])
        by smtp.googlemail.com with ESMTPSA id q188sm6272260wmb.43.2017.09.17.13.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Sep 2017 13:17:57 -0700 (PDT)
From:   phionah bugosi <bugosip@gmail.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, phionah bugosi <bugosip@gmail.com>
Subject: [PATCH] pack: make packed_git_mru global a value instead of a pointer
Date:   Sun, 17 Sep 2017 23:17:47 +0300
Message-Id: <1505679467-20720-1-git-send-email-bugosip@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: phionah bugosi <bugosip@gmail.com>
---
 builtin/pack-objects.c |  5 +++--
 cache.h                |  7 -------
 list.h                 |  6 ++++++
 packfile.c             | 12 ++++++------
 4 files changed, 15 insertions(+), 15 deletions(-)

This patch makes packed_git_mru global a value instead of a pointer and
makes use of list.h

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a57b4f0..189123f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "list.h"
 #include "config.h"
 #include "attr.h"
 #include "object.h"
@@ -1012,7 +1013,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 			return want;
 	}
 
-	for (entry = packed_git_mru->head; entry; entry = entry->next) {
+	for (entry = packed_git_mru.head; entry; entry = entry->next) {
 		struct packed_git *p = entry->item;
 		off_t offset;
 
@@ -1030,7 +1031,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 			}
 			want = want_found_object(exclude, p);
 			if (!exclude && want > 0)
-				mru_mark(packed_git_mru, entry);
+				mru_mark(&packed_git_mru, entry);
 			if (want != -1)
 				return want;
 		}
diff --git a/cache.h b/cache.h
index a916bc7..c8d7086 100644
--- a/cache.h
+++ b/cache.h
@@ -1585,13 +1585,6 @@ extern struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
 
-/*
- * A most-recently-used ordered version of the packed_git list, which can
- * be iterated instead of packed_git (and marked via mru_mark).
- */
-struct mru;
-extern struct mru *packed_git_mru;
-
 struct pack_entry {
 	off_t offset;
 	unsigned char sha1[20];
diff --git a/list.h b/list.h
index a226a87..525703b 100644
--- a/list.h
+++ b/list.h
@@ -26,6 +26,12 @@
 #define LIST_H	1
 
 /*
+ * A most-recently-used ordered version of the packed_git list, which can
+ * be iterated instead of packed_git (and marked via mru_mark).
+ */
+extern struct mru packed_git_mru
+
+/*
  * The definitions of this file are adopted from those which can be
  * found in the Linux kernel headers to enable people familiar with the
  * latter find their way in these sources as well.
diff --git a/packfile.c b/packfile.c
index f86fa05..61a61aa 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "list.h"
 #include "mru.h"
 #include "pack.h"
 #include "dir.h"
@@ -41,8 +42,7 @@ static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
 
-static struct mru packed_git_mru_storage;
-struct mru *packed_git_mru = &packed_git_mru_storage;
+struct mru packed_git_mru;
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -861,9 +861,9 @@ static void prepare_packed_git_mru(void)
 {
 	struct packed_git *p;
 
-	mru_clear(packed_git_mru);
+	mru_clear(&packed_git_mru);
 	for (p = packed_git; p; p = p->next)
-		mru_append(packed_git_mru, p);
+		mru_append(&packed_git_mru, p);
 }
 
 static int prepare_packed_git_run_once = 0;
@@ -1832,9 +1832,9 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	if (!packed_git)
 		return 0;
 
-	for (p = packed_git_mru->head; p; p = p->next) {
+	for (p = packed_git_mru.head; p; p = p->next) {
 		if (fill_pack_entry(sha1, e, p->item)) {
-			mru_mark(packed_git_mru, p);
+			mru_mark(&packed_git_mru, p);
 			return 1;
 		}
 	}
-- 
2.7.4

