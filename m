Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E29201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932658AbdERXXF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:23:05 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32774 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755119AbdERXWi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:38 -0400
Received: by mail-pg0-f44.google.com with SMTP id u187so29512775pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6xZHP+E5gkhdHY8+3O67f/mUZkaJO/mwMwkLsDAUc3w=;
        b=ayvfg9C0vxYe3+Yq9/n3wYuJu3qlhu8Lr3fJl/N9Lj9DYQr/opuLk8XaF5r2EoDhTw
         ykL/ILzshngwTcfLGtt3eAykqnZPHmTT+XEr2lBJ2wB0FduK1lzKXg9FjQmCwWh7BX0/
         CXX6GuyhKWrCFAa1TMk1kzQGTKDv8OHonKKefTbxvBiOXqTjgXhStQZozaXwBfoTctnh
         2sOXtMmJ3TzS/sh/uBBkqy7aSXe6myADaSAZ4W9VfY9eOiBItyAffNP7ZvPuHvPJ4wjx
         tLwiog11DcHsPRjFdpxatsarCnggqutXssmYn/GEwlmXkoExJbtzPHYDf/qX1MIt0I+R
         iA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6xZHP+E5gkhdHY8+3O67f/mUZkaJO/mwMwkLsDAUc3w=;
        b=dDGZHGgDVUD7KbugdHI2IwnvBV9wseAOL4dkqvrRQhtmsJEKTkhBXyVCR+5AMHQa3X
         msbqNDg+QDQwdyMuN9cKcKJomYQ5UdnPtK2f0tvXXW3NBhotcaIC3fSOI/5ugNqShSgd
         BG3DJYSS6TcEa8FT6OTmHmqom1db1g01UcoT+81lLv9pQ03CwFe+78NwpIrWR6soKseG
         P4o8BI6RScdxAIwUQaAOHCjRu8w5Q35Vr9F0+e9s2oe02GX1RYj8S1ygFZvN1qlUrviL
         4oXqUIQ//vrFd5XHflVOpkdSF9PriKSoO6Ua4hLlQ/GYp84k5Ei5CaQixkOIrPV4+T40
         R9YA==
X-Gm-Message-State: AODbwcBzB6LoAKCF13dpi2Sxsiullj9jgiyf92cVwO/TbRd1wXX02j/F
        /yG8Rlk2I+pJQEBK
X-Received: by 10.84.171.195 with SMTP id l61mr7661640plb.147.1495149757824;
        Thu, 18 May 2017 16:22:37 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 21/23] repo: add repo_read_gitmodules
Date:   Thu, 18 May 2017 16:21:32 -0700
Message-Id: <20170518232134.163059-22-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add ability for a repository to poulate its own submodule_cache by
reading the repository's gitmodules file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repo.c | 26 ++++++++++++++++++++++++++
 repo.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/repo.c b/repo.c
index 223adf4c8..5449eb212 100644
--- a/repo.c
+++ b/repo.c
@@ -1,4 +1,6 @@
 #include "cache.h"
+#include "submodule.h"
+#include "submodule-config.h"
 #include "repo.h"
 
 char *
@@ -33,6 +35,27 @@ repo_read_config(struct repo *repo)
 				       NULL, &opts);
 }
 
+static int
+gitmodules_cb(const char *var, const char *value, void *data)
+{
+	struct repo *repo = data;
+	return parse_submodule_config_option_cache(repo->submodule_cache, var, value);
+}
+
+int
+repo_read_gitmodules(struct repo *repo)
+{
+	char *gitmodules_path = xstrfmt("%s/.gitmodules", repo->worktree);
+
+	if (!repo->worktree)
+		die("BUG: no worktree");
+
+	repo->submodule_cache = submodule_cache_alloc();
+	submodule_cache_init(repo->submodule_cache);
+	git_config_from_file(gitmodules_cb, gitmodules_path, repo);
+	return 0;
+}
+
 int
 repo_init(struct repo *repo, const char *gitdir, const char *worktree)
 {
@@ -83,4 +106,7 @@ repo_clear(struct repo *repo)
 		git_configset_clear(repo->config);
 		free(repo->config);
 	}
+
+	if (repo->submodule_cache)
+		submodule_cache_free(repo->submodule_cache);
 }
diff --git a/repo.h b/repo.h
index b4df774c3..9ff144957 100644
--- a/repo.h
+++ b/repo.h
@@ -10,10 +10,13 @@ struct repo {
 	const char *submodule_prefix;
 	struct index_state *index;
 	struct config_set *config;
+	struct submodule_cache *submodule_cache;
 };
 
 extern int repo_read_index(struct repo *repo, const char *index_file);
 extern int repo_init(struct repo *repo, const char *gitdir, const char *worktree);
 extern void repo_clear(struct repo *repo);
 
+extern int repo_read_gitmodules(struct repo *repo);
+
 #endif /* REPO_H */
-- 
2.13.0.303.g4ebf302169-goog

