Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E842027B
	for <e@80x24.org>; Thu, 18 May 2017 23:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755242AbdERXXA (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:23:00 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34345 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755211AbdERXWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:40 -0400
Received: by mail-pf0-f180.google.com with SMTP id 9so30795415pfj.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QDW7ukVM0oo3Vxybey52PGjdYC+ZtBh6BkmqGFovwkk=;
        b=g94OBYR9hnH3075QhATZ2h/Ldvrs7rXHZ8ecnQYBrgQ+8kEiApvVtSrGlFt85MsQvf
         BbQBLcLHuWPCCKGvD5a4sCpgfWc0uK8aBB+tSgFUVBlyLo+Vw7Jh/i+vaemr00Y4ApBl
         BaAWup+I4FA4JCNU1EbDhUtd5CiJDPxFg4ZtPeeMKWiGIfjO0gRF+G5BT6J7bNU0NM41
         sNUvAflxofQn/eBWoB48Vi8eBLdBxn8jwae7Yn7asy06Gdx805ply2xCGPhNUboBbHHa
         GAcTdhNvJHdiagKY4ybo4GNUN3HFSLQ6wp2elztsUtizDbsimJP5pKCTAmTNFt1P2Qnj
         /bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QDW7ukVM0oo3Vxybey52PGjdYC+ZtBh6BkmqGFovwkk=;
        b=lV57jYz+3ysuLZZy4Vtb3z+J0zJ1BLMndqAAUdfnDhk0ffss0KkbtPA3XoNt7+5fZI
         uLBfqba8815PYEB/hXRHYZxbQr9iBdPGOyfMiZw8nndhCFoKggDxi86zmqmmyoafrjpD
         G6UDWsht0Z6hT5gBMk7HhW0UasN+17GNp2ObtnRzWbskB4uTmaUxLc03AWU5+W2K0PM5
         UbaWpFlSNDTTj5v6VfaT3Pz0WHgn67uA2Wiz3rta3dxuWbt9toJxCs7UdwMw4HZcyloF
         pBMtnYB4Y8LnY7054B7ylL5Y4rbTvjTjeXgF4HImsi1+DP71e2jmvAvaz6pii+J1KE7J
         +W4g==
X-Gm-Message-State: AODbwcBl7FPy99AMChjREPHlifTEPfR+OKuH6+AEIoGLI+V6Bq0BvdUZ
        o2C3edehY6/1obCo
X-Received: by 10.84.149.168 with SMTP id m37mr7761151pla.74.1495149755056;
        Thu, 18 May 2017 16:22:35 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 19/23] repo: add per repo config
Date:   Thu, 18 May 2017 16:21:30 -0700
Message-Id: <20170518232134.163059-20-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h  |  1 +
 config.c |  2 +-
 repo.c   | 27 ++++++++++++++++++++++++++-
 repo.h   |  2 ++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 175e58f01..af9ae1173 100644
--- a/cache.h
+++ b/cache.h
@@ -2015,6 +2015,7 @@ struct config_set {
 };
 
 extern void git_configset_init(struct config_set *cs);
+extern int config_set_callback(const char *key, const char *value, void *cb);
 extern int git_configset_add_file(struct config_set *cs, const char *filename);
 extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
 extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
diff --git a/config.c b/config.c
index b4a3205da..d24baec50 100644
--- a/config.c
+++ b/config.c
@@ -1765,7 +1765,7 @@ void git_configset_clear(struct config_set *cs)
 	cs->list.items = NULL;
 }
 
-static int config_set_callback(const char *key, const char *value, void *cb)
+int config_set_callback(const char *key, const char *value, void *cb)
 {
 	struct config_set *cs = cb;
 	configset_add_value(cs, key, value);
diff --git a/repo.c b/repo.c
index 7e5c03ac5..223adf4c8 100644
--- a/repo.c
+++ b/repo.c
@@ -1,10 +1,16 @@
 #include "cache.h"
 #include "repo.h"
 
+char *
+repo_git_pathdup(const struct repo *repo, const char *file)
+{
+	return xstrfmt("%s/%s", repo->gitdir, file);
+}
+
 int
 repo_read_index(struct repo *repo, const char *index_file)
 {
-	char *index_path = xstrfmt("%s/index", repo->gitdir);
+	char *index_path = repo_git_pathdup(repo, "index");
 	const char *file = index_file ? index_file : index_path;
 
 	repo->index = xcalloc(1, sizeof(struct index_state));
@@ -16,6 +22,18 @@ repo_read_index(struct repo *repo, const char *index_file)
 }
 
 int
+repo_read_config(struct repo *repo)
+{
+	struct config_options opts = { 1, repo->gitdir };
+
+	repo->config = xcalloc(1, sizeof(struct config_set));
+	git_configset_init(repo->config);
+
+	return git_config_with_options(config_set_callback, repo->config,
+				       NULL, &opts);
+}
+
+int
 repo_init(struct repo *repo, const char *gitdir, const char *worktree)
 {
 	int error = 0;
@@ -40,6 +58,8 @@ repo_init(struct repo *repo, const char *gitdir, const char *worktree)
 	/* Maybe need a check to verify that a worktree is indeed a worktree? */
 	repo->worktree = xstrdup_or_null(worktree);
 
+	repo_read_config(repo);
+
 	free(abspath);
 	free(suspect);
 
@@ -58,4 +78,9 @@ repo_clear(struct repo *repo)
 		discard_index(repo->index);
 		free(repo->index);
 	}
+
+	if (repo->config) {
+		git_configset_clear(repo->config);
+		free(repo->config);
+	}
 }
diff --git a/repo.h b/repo.h
index 15a0bdee9..b4df774c3 100644
--- a/repo.h
+++ b/repo.h
@@ -2,12 +2,14 @@
 #define REPO_H
 
 struct index_state;
+struct config_set;
 
 struct repo {
 	char *gitdir;
 	char *worktree;
 	const char *submodule_prefix;
 	struct index_state *index;
+	struct config_set *config;
 };
 
 extern int repo_read_index(struct repo *repo, const char *index_file);
-- 
2.13.0.303.g4ebf302169-goog

