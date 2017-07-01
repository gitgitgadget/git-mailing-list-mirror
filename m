Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7072201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbdGAA2w (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:28:52 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36715 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbdGAA2s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:48 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so74171857pfl.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PTquX2EQFbBqteZFPsh0wjoA2eo74QGjcvx26SFhih0=;
        b=ipbM1xheLLCzGATqf3XDD9qdppyXudQixtEBNfrezLJJ+GmduFQ8CZP/24ODeo8iyJ
         7NZ77w8SegRcFhEbaKHmOfhbENNFttg5Rk34g48bvz0LT68CoFv60o7b+ZwZXLDw/pM6
         C69qse7YsBHyX5gERq9moCybEXXmBEjsBa1vYlTbzvXo+F4/5tT/Rf5bYBYSHrwUgf3o
         O9Mr2pAeLAWz8/6kVupapMQjlkvIoG9I90RuV1GDSKA9RbskmNxpiA9KUva1B2dlM3EN
         2bN5UfGnsBhj02ExdYg0q21LD1vB7RFnqZarnDMiSHGVOJwj1rsVA3kTa3otmcKCNGTQ
         jfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PTquX2EQFbBqteZFPsh0wjoA2eo74QGjcvx26SFhih0=;
        b=fYYivtnlvaCxjeLG9uNwE4zhIWfyAB//ZybDb3i19mZvIABTS8G1plYVd4ePpeo1YW
         UB3zZda9JHNYp5FV5ONfr5O1HZp4h3whok2QIfyCK/ehktcumG9pGEKWhFfSNFJ232e9
         qYEz1SgY0PqfcQgJTs6OKOdt3+eIDnDijHu+OdKCH+ggbqY9lzJZWJnyndO1dqYXKLFA
         lV2F9JzHlrWGuyJ5flQfPF4TFDkZ2bQSucsueQcMRzZQq+mX0d9jL3kA/va3Nm6Cnt+G
         TrfQXGWX//Yq0WCOPLCyLD8cv/iGz7Sc9BPcZ0pi7gpbkOTA0b0Vxbx5ZYrNbvVmNkI8
         XXeA==
X-Gm-Message-State: AKS2vOxvYnm138N6ID8yNvagF9gCaS5VeTzibfd2vqHzZxRZstN2prc6
        cRTUkAOfnhHg3PHu7JfvDQ==
X-Received: by 10.84.170.67 with SMTP id i61mr8176202plb.114.1498868927788;
        Fri, 30 Jun 2017 17:28:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id t189sm18819501pfb.13.2017.06.30.17.28.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/10] convert/sub-process: drop cast to hashmap_cmp_fn
Date:   Fri, 30 Jun 2017 17:28:33 -0700
Message-Id: <20170701002838.22785-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 convert.c     | 3 +--
 sub-process.c | 7 +++++--
 sub-process.h | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index deaf0ba7b3..04966c723c 100644
--- a/convert.c
+++ b/convert.c
@@ -583,8 +583,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 
 	if (!subprocess_map_initialized) {
 		subprocess_map_initialized = 1;
-		hashmap_init(&subprocess_map, (hashmap_cmp_fn) cmd2process_cmp,
-			     NULL, 0);
+		hashmap_init(&subprocess_map, cmd2process_cmp, NULL, 0);
 		entry = NULL;
 	} else {
 		entry = (struct cmd2process *)subprocess_find_entry(&subprocess_map, cmd);
diff --git a/sub-process.c b/sub-process.c
index a3cfab1a9d..6cbffa4406 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -6,10 +6,13 @@
 #include "pkt-line.h"
 
 int cmd2process_cmp(const void *unused_cmp_data,
-		    const struct subprocess_entry *e1,
-		    const struct subprocess_entry *e2,
+		    const void *entry,
+		    const void *entry_or_key,
 		    const void *unused_keydata)
 {
+	const struct subprocess_entry *e1 = entry;
+	const struct subprocess_entry *e2 = entry_or_key;
+
 	return strcmp(e1->cmd, e2->cmd);
 }
 
diff --git a/sub-process.h b/sub-process.h
index 96a2cca360..8cd07a59ab 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -21,8 +21,8 @@ struct subprocess_entry {
 /* subprocess functions */
 
 extern int cmd2process_cmp(const void *unused_cmp_data,
-			   const struct subprocess_entry *e1,
-			   const struct subprocess_entry *e2,
+			   const void *e1,
+			   const void *e2,
 			   const void *unused_keydata);
 
 typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
-- 
2.13.0.31.g9b732c453e

