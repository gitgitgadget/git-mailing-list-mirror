Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0167F1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeC1RZD (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:25:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43496 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeC1RZB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:25:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id j2so1242502pff.10
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1hX6Dzxh8rUD6c6/wE46M+MknO1kB3Zx0kAcEf77b48=;
        b=YWD1TS0mdpTXSEfuJMtA/5TuaZ+vrf9i4+fTWNqLaP1l4gKXTy1O+em9Y7oBxOID17
         QmCC8w4wy45ehcJusYUdhlQKNURz08GfqhpYIGa7xWt729wk1efUCI3Q0tmakmvlzYH0
         j2qjxuhSVpCwdxKAE3U77q2Q/NIdVraXsN5SjDnEkafjZHD+kAE6cDDQr5v7nFyWWw9A
         3py1dIGaC8c4E83vnVEgfizZ80fOlAvA4LeCZUqpk4wkwerytGfvri9MJB6RidUyFFzU
         YobVu2Ov7xWzsJLu6CvykAO8B3HXRZyDZfio2TTjwBOFhU9WS+JoU7zpseU7Kv/ZI6xq
         LuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1hX6Dzxh8rUD6c6/wE46M+MknO1kB3Zx0kAcEf77b48=;
        b=pvW+WIhNWNlxF/45jKBOch0ggI0T9mgF96ZFBjszuo+oGJRYlGC9+XYr+Na5UDVeWv
         6cyVS1zRtxoZy1XSmD0McoLyTb+GM0fRV9/aTYXKmzs+Qa3kDGMHeBghzmPLb1v9fqS+
         67JEfjYHxYQaiwijLcSgonrXd6t10ZsISX4M1a7tMKXAx3fLPZHdWxseYplbvD3r8sdH
         Cg9ylA4t5KyITzR73rOSr8YXulwgXvDlFIB7J4pmnwpSIvcADg2UysX3y3RhxJUF3mfe
         uAIzCU4X835ncQHB6WrlOOmYlmAXb8t6M0aBKZg2MVotoRrExzA/vna9CFa1xLEw5EUF
         KgLQ==
X-Gm-Message-State: AElRT7G5Mjjnncc5RHovENIu5yvanpcD6LtkuWK86eoIEuhpjiIs2Jhq
        fibgOH14EUY4Pm6cc44deEfHLg==
X-Google-Smtp-Source: AIpwx49D8yews7eUH46e7QYJ7GzqNQeaONN1rASwgahpxIarOM04CTzAypuOZeQuW6xeYAWcD0umjw==
X-Received: by 2002:a17:902:8206:: with SMTP id x6-v6mr4811171pln.256.1522257900075;
        Wed, 28 Mar 2018 10:25:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y18sm8504851pfe.67.2018.03.28.10.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:24:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        jonathantanmy@google.com, seanwbehan@riseup.net
Subject: [PATCH 4/6] submodule-config: remove submodule_from_cache
Date:   Wed, 28 Mar 2018 10:24:47 -0700
Message-Id: <20180328172449.27012-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328172449.27012-1-sbeller@google.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
 <20180328172449.27012-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This continues the story of bf12fcdf5e (submodule-config: store
the_submodule_cache in the_repository, 2017-06-22).

The previous patch taught submodule_from_path to take a repository into
account, such that submodule_from_{path, cache} are the same now.
Remove submodule_from_cache, migrating all its callers to
submodule_from_path.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 repository.c       | 2 +-
 submodule-config.c | 9 ---------
 submodule-config.h | 3 ---
 submodule.c        | 4 ++--
 4 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/repository.c b/repository.c
index 4ffbe9bc94..fa0a132e22 100644
--- a/repository.c
+++ b/repository.c
@@ -167,7 +167,7 @@ int repo_submodule_init(struct repository *submodule,
 	struct strbuf worktree = STRBUF_INIT;
 	int ret = 0;
 
-	sub = submodule_from_cache(superproject, &null_oid, path);
+	sub = submodule_from_path(superproject, &null_oid, path);
 	if (!sub) {
 		ret = -1;
 		goto out;
diff --git a/submodule-config.c b/submodule-config.c
index 4b7803e6ed..cb65354d4c 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -635,15 +635,6 @@ const struct submodule *submodule_from_path(struct repository *r,
 	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
 }
 
-const struct submodule *submodule_from_cache(struct repository *repo,
-					     const struct object_id *treeish_name,
-					     const char *key)
-{
-	gitmodules_read_check(repo);
-	return config_from(repo->submodule_cache, treeish_name,
-			   key, lookup_path);
-}
-
 void submodule_free(struct repository *r)
 {
 	if (r->submodule_cache)
diff --git a/submodule-config.h b/submodule-config.h
index 43dfe7dec0..6f686184e8 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -45,9 +45,6 @@ const struct submodule *submodule_from_name(struct repository *r,
 const struct submodule *submodule_from_path(struct repository *r,
 					    const struct object_id *commit_or_tree,
 					    const char *path);
-extern const struct submodule *submodule_from_cache(struct repository *repo,
-						    const struct object_id *treeish_name,
-						    const char *key);
 void submodule_free(struct repository *r);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index e94b7f9acd..89d0aee086 100644
--- a/submodule.c
+++ b/submodule.c
@@ -230,7 +230,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 	const struct string_list *sl;
 	const struct submodule *module;
 
-	module = submodule_from_cache(repo, &null_oid, path);
+	module = submodule_from_path(repo, &null_oid, path);
 
 	/* early return if there isn't a path->module mapping */
 	if (!module)
@@ -1235,7 +1235,7 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		submodule = submodule_from_cache(spf->r, &null_oid, ce->name);
+		submodule = submodule_from_path(spf->r, &null_oid, ce->name);
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-- 
2.17.0.rc1.321.gba9d0f2565-goog

