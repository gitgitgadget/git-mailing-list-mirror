Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6C8201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbdGAA2y (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:28:54 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33566 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbdGAA2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:53 -0400
Received: by mail-pf0-f180.google.com with SMTP id e7so74264695pfk.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9YClPTjWiSoXm3KxjVTtutgRZnw4tDdJfdKbseAncg=;
        b=njxAMAmsLneCKfkZfAIkKYQMEkepbWv0kX2ko0/MWuuj74iSnMAov+CwGmMsLaUqVn
         PjlqfkeeHoc35TBGwKHVIWy8TmjMibDOwOtlQ/DYt8NuxkGBazCtULSsWAvvWum81dma
         ifPVCyNaMKmkJRhjtEWiFRa8panHND0Lsdinob8LJ3EUQU7cXpDQygckMKI3+wF22OxC
         xxOw6CL1BJeDq97I4BZsqY7wx5v6+X0G9wH2bQt3lDIuRSk0hfJVOjYa1hdw+MDHtYRu
         /5P9gCqyg6mKoxa5fB9g2JHSeYPmMIICusUseT/TWZZqN7wt/gvRinHfxxq6ecBWRo23
         aPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9YClPTjWiSoXm3KxjVTtutgRZnw4tDdJfdKbseAncg=;
        b=hFXyOMc57DNevecQROgSQgUki+FPwTkzBi5TE9I16iiBPsmp/hNgR2J/cuetj/JSy+
         n18rIfIj4Xe2jDcmLf4fH7xa1Yvx0NCK7z8iPkv1FzhZdlmziF3eXyM2E+8N718MWE0I
         6PCBmvLXAXuKZC3kHaXigGPRUVN69MMGQuN7haxauCXgw8bqbrlPUmg7x4ze7GNDTZsw
         nWh4u7YDcVK1UK7XDqjvB4oKixUZ+KohGMi2YHUJK3miEo0vlR7COqxOhjNs3G4QZGdC
         iy8QR4Wr9BuDXTywV5izCy51kD1K+0AGk1JUAo69s8UH2vZx7d+esDBDyhVeXwbFTRZD
         fjqA==
X-Gm-Message-State: AKS2vOz6rkzzvsfg3HVZuX30EfsfOUmZryNc2ZObJshvfpd7ZNEXsH8R
        O6+XMBkGtBHabOIpdEXA3g==
X-Received: by 10.98.69.219 with SMTP id n88mr25415655pfi.192.1498868932562;
        Fri, 30 Jun 2017 17:28:52 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id b7sm23127229pfl.44.2017.06.30.17.28.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/10] name-hash.c: drop hashmap_cmp_fn cast
Date:   Fri, 30 Jun 2017 17:28:37 -0700
Message-Id: <20170701002838.22785-10-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 name-hash.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 0e10f3eab8..bd8dc7a6a7 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -17,10 +17,14 @@ struct dir_entry {
 };
 
 static int dir_entry_cmp(const void *unused_cmp_data,
-			 const struct dir_entry *e1,
-			 const struct dir_entry *e2,
-			 const char *name)
+			 const void *entry,
+			 const void *entry_or_key,
+			 const void *keydata)
 {
+	const struct dir_entry *e1 = entry;
+	const struct dir_entry *e2 = entry_or_key;
+	const char *name = keydata;
+
 	return e1->namelen != e2->namelen || strncasecmp(e1->name,
 			name ? name : e2->name, e1->namelen);
 }
@@ -110,10 +114,12 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 }
 
 static int cache_entry_cmp(const void *unused_cmp_data,
-			   const struct cache_entry *ce1,
-			   const struct cache_entry *ce2,
+			   const void *entry,
+			   const void *entry_or_key,
 			   const void *remove)
 {
+	const struct cache_entry *ce1 = entry;
+	const struct cache_entry *ce2 = entry_or_key;
 	/*
 	 * For remove_name_hash, find the exact entry (pointer equality); for
 	 * index_file_exists, find all entries with matching hash code and
@@ -574,10 +580,8 @@ static void lazy_init_name_hash(struct index_state *istate)
 {
 	if (istate->name_hash_initialized)
 		return;
-	hashmap_init(&istate->name_hash, (hashmap_cmp_fn) cache_entry_cmp,
-			NULL, istate->cache_nr);
-	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp,
-			NULL, istate->cache_nr);
+	hashmap_init(&istate->name_hash, cache_entry_cmp, NULL, istate->cache_nr);
+	hashmap_init(&istate->dir_hash, dir_entry_cmp, NULL, istate->cache_nr);
 
 	if (lookup_lazy_params(istate)) {
 		hashmap_disallow_rehash(&istate->dir_hash, 1);
-- 
2.13.0.31.g9b732c453e

