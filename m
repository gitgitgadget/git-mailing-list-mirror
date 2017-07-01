Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C975201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbdGAA27 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:28:59 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33563 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbdGAA25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:57 -0400
Received: by mail-pf0-f173.google.com with SMTP id e7so74264528pfk.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YbU3TJvy0oUKTIOPvlSG6E0qGMm8MQl+S2IZTD6KXgI=;
        b=YxgHQ+LzR6D+AkCu+y7U9dIgsTLfEjTPLB/1dlmZV+nY0YjltQFKghxqTK1UXgnJBc
         +E0jbZo5kfgeZEFMPAZMiP9i+85sXrn4eN1KT4V/Iyjdq/VEBo2o75XuA8DY63bgxGLx
         1YZUkepd8mhgvPd7+o2trCgbT/YB5cMVKtDtm0uz5WiHtNVUUuffTJIOStaZWO4i237d
         K3pZgcRrnevE1PX1zkp1XOP8whva+P+d2HMz3znHPbiqOrzV7MHbkF5asIMCYs18j5Mo
         svrb3fT9v7ICXaV6ZfMk4MHcckmUxLAbx1wmNwafuScrMtwx0GDVLzc7d/pyZIC5WayF
         VxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YbU3TJvy0oUKTIOPvlSG6E0qGMm8MQl+S2IZTD6KXgI=;
        b=L5hHPmc683YSmuxDSF6TCQ+l6wtB1gg1K7k76NemteT4rWecEJre1TD72ZbeVoikF3
         GTLhZgosfcp4nuLfa15i8W3wujiWSq5JYzGBTXwHqT0QREXJ82zCRdSWnioyhnPp+LSO
         9WQ/1V70rTPD97Nm2M2KzPKdv+lJnQ1Q/BHjTB9YJT7+3MCKqXVxkpZr5tIOWYBrovqh
         KErni3qt/i9A2SETF3UiuxcXYs/mlZ3KKeZwXS77bt8cddt47YA0SuzEK88gdj8LnXt2
         opvB5nqAJcg8ZFOxS6wcZUYY58DQwJ8IWj7pQ0Jua6RYeetCn9v+O66I253ucvnISJOA
         1vFQ==
X-Gm-Message-State: AKS2vOxPotq//M7YWM3ZtXSAwkiI9xG7O4FM9aabSBY1i011dl5TYvvk
        4BJkzpIXU9Y5LDyT5/d59A==
X-Received: by 10.98.23.3 with SMTP id 3mr25261756pfx.55.1498868931261;
        Fri, 30 Jun 2017 17:28:51 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id t67sm19030619pfj.98.2017.06.30.17.28.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:50 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/10] submodule-config.c: drop hashmap_cmp_fn cast
Date:   Fri, 30 Jun 2017 17:28:36 -0700
Message-Id: <20170701002838.22785-9-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 0e1126183d..edc8dd04b6 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -35,27 +35,33 @@ static struct submodule_cache the_submodule_cache;
 static int is_cache_init;
 
 static int config_path_cmp(const void *unused_cmp_data,
-			   const struct submodule_entry *a,
-			   const struct submodule_entry *b,
+			   const void *entry,
+			   const void *entry_or_key,
 			   const void *unused_keydata)
 {
+	const struct submodule_entry *a = entry;
+	const struct submodule_entry *b = entry_or_key;
+
 	return strcmp(a->config->path, b->config->path) ||
 	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
 }
 
 static int config_name_cmp(const void *unused_cmp_data,
-			   const struct submodule_entry *a,
-			   const struct submodule_entry *b,
+			   const void *entry,
+			   const void *entry_or_key,
 			   const void *unused_keydata)
 {
+	const struct submodule_entry *a = entry;
+	const struct submodule_entry *b = entry_or_key;
+
 	return strcmp(a->config->name, b->config->name) ||
 	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
 }
 
 static void cache_init(struct submodule_cache *cache)
 {
-	hashmap_init(&cache->for_path, (hashmap_cmp_fn) config_path_cmp, NULL, 0);
-	hashmap_init(&cache->for_name, (hashmap_cmp_fn) config_name_cmp, NULL, 0);
+	hashmap_init(&cache->for_path, config_path_cmp, NULL, 0);
+	hashmap_init(&cache->for_name, config_name_cmp, NULL, 0);
 }
 
 static void free_one_config(struct submodule_entry *entry)
-- 
2.13.0.31.g9b732c453e

