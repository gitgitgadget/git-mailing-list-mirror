Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07D9207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdEBWYl (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:41 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33661 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751703AbdEBWXr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:47 -0400
Received: by mail-pg0-f46.google.com with SMTP id y4so62828249pge.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=95kD6+p3EN95XH88wfW4PiTMuXXep7DqWmvs3lvo540=;
        b=auLBoGAq532aB4j/wt3eARj+35wrRYWb6MNhvWzP1RmQvsNQvc4/sh6igj/ZSNt+73
         IneHGXFfcb17ElecRgefYhvtOP5JaqhgWf3+kmhB9igyLoSQNJpH4HxqFD9N6nuEw4JB
         1yVR31AYUQ6gTmWOmeUGtCysDTAiaMAVknwkV3c2A44zQECzyc2hpTCmuK4koZ1muyDj
         FfyGKbxpElD+1CKMFeIDhjagfaUg5lxgrTjPXHGJrJaUKdn/cS281I9/4q0ql6wNmAli
         LH53ullpy/wOrZ3y6ADNOjV3PjICVDnYfVD2ooLFcBTEAcFnX4FgR/m4llFn/JvmeH96
         ns2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=95kD6+p3EN95XH88wfW4PiTMuXXep7DqWmvs3lvo540=;
        b=Vl5oi1fcadY/QCzT+tAJXl+9SPF3TgO2yACDLLP8YHfMEWNp/9xqj6DLeE6ePM+vVd
         ktV7GuW+6+e/4zRxyLcrtkGPy3wxtNS8HGumYotHcDjt0q3zHtC7G6FwmPqsv9kGrK/S
         8kl4lcd0M3+KBjaX1WGPfRr10nZNQmXzDGDcLNapJ9FauaOmpA7winsDFt2AWKF6Okvx
         IKM9W/4rIfeTd/1qCWLZr8KdSDwXMzJk8vdCkQ7ZI/rE+RfPQxMDrQjPS0jr+UZwP9R1
         oqmoQInpovk3A+e/b7GeWJvbdV9XixJ1PTYlkACISKizR/y+AAl8YdQNfNA2pWjQj6O6
         v2JA==
X-Gm-Message-State: AN3rC/58Pv7h5zSZJ0rjwZVuCQ2PDn+QFeAHoxWcvvOJNwmgKfhCVtJt
        wJNvQyfo4bmJ8cXq
X-Received: by 10.98.147.93 with SMTP id b90mr1441914pfe.88.1493763826623;
        Tue, 02 May 2017 15:23:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id i15sm739815pfj.51.2017.05.02.15.23.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/24] cache.h: drop add_cache_entry
Date:   Tue,  2 May 2017 15:23:13 -0700
Message-Id: <20170502222322.21055-16-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coccinelle patch
-add_cache_entry(ce, option)
+add_index_entry(&the_index, ce, option)

Additionally drop the define from cache.h manually.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c                | 4 ++--
 builtin/blame.c        | 3 ++-
 builtin/checkout.c     | 3 ++-
 builtin/reset.c        | 3 ++-
 builtin/update-index.c | 8 ++++----
 cache.h                | 1 -
 merge-recursive.c      | 4 ++--
 tree.c                 | 2 +-
 8 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/apply.c b/apply.c
index bb1cd77c66..66d4969e72 100644
--- a/apply.c
+++ b/apply.c
@@ -4284,7 +4284,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 				       "for newly created file %s"), path);
 		}
 	}
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+	if (add_index_entry(&the_index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
 		free(ce);
 		return error(_("unable to add cache entry for %s"), path);
 	}
@@ -4428,7 +4428,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		oidcpy(&ce->oid, &patch->threeway_stage[stage - 1]);
-		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+		if (add_index_entry(&the_index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
 			free(ce);
 			return error(_("unable to add cache entry for %s"),
 				     patch->new_name);
diff --git a/builtin/blame.c b/builtin/blame.c
index c71d9a3340..5140015cc0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2413,7 +2413,8 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	add_index_entry(&the_index, ce,
+			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 
 	cache_tree_invalidate_path(&the_index, path);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 039d3d296b..34ec9f7e32 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -118,7 +118,8 @@ static int update_some(const unsigned char *sha1, struct strbuf *base,
 		}
 	}
 
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+	add_index_entry(&the_index, ce,
+			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	return 0;
 }
 
diff --git a/builtin/reset.c b/builtin/reset.c
index f8073b1caa..0e19d6e8d5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -138,7 +138,8 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 			ce->ce_flags |= CE_INTENT_TO_ADD;
 			set_object_name_for_intent_to_add_entry(ce);
 		}
-		add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+		add_index_entry(&the_index, ce,
+				ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	}
 }
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d7a117c674..e0738f74bf 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -286,7 +286,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option))
+	if (add_index_entry(&the_index, ce, option))
 		return error("%s: cannot add to the index - missing --add option?", path);
 	return 0;
 }
@@ -416,7 +416,7 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 		ce->ce_flags |= CE_VALID;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option))
+	if (add_index_entry(&the_index, ce, option))
 		return error("%s: cannot add to the index - missing --add option?",
 			     path);
 	report("add '%s'", path);
@@ -659,12 +659,12 @@ static int unresolve_one(const char *path)
 	}
 
 	remove_file_from_cache(path);
-	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
+	if (add_index_entry(&the_index, ce_2, ADD_CACHE_OK_TO_ADD)) {
 		error("%s: cannot add our version to the index.", path);
 		ret = -1;
 		goto free_return;
 	}
-	if (!add_cache_entry(ce_3, ADD_CACHE_OK_TO_ADD))
+	if (!add_index_entry(&the_index, ce_3, ADD_CACHE_OK_TO_ADD))
 		return 0;
 	error("%s: cannot add their version to the index.", path);
 	ret = -1;
diff --git a/cache.h b/cache.h
index a18ebf263a..54c1bbf0d1 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
diff --git a/merge-recursive.c b/merge-recursive.c
index 163d37866e..6420dc1951 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -230,7 +230,7 @@ static int add_cacheinfo(struct merge_options *o,
 	if (!ce)
 		return err(o, _("addinfo_cache failed for path '%s'"), path);
 
-	ret = add_cache_entry(ce, options);
+	ret = add_index_entry(&the_index, ce, options);
 	if (refresh) {
 		struct cache_entry *nce;
 
@@ -238,7 +238,7 @@ static int add_cacheinfo(struct merge_options *o,
 		if (!nce)
 			return err(o, _("addinfo_cache failed for path '%s'"), path);
 		if (nce != ce)
-			ret = add_cache_entry(nce, options);
+			ret = add_index_entry(&the_index, nce, options);
 	}
 	return ret;
 }
diff --git a/tree.c b/tree.c
index 82a6ae2a19..5f9a322ddd 100644
--- a/tree.c
+++ b/tree.c
@@ -27,7 +27,7 @@ static int read_one_entry_opt(const unsigned char *sha1, const char *base, int b
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	hashcpy(ce->oid.hash, sha1);
-	return add_cache_entry(ce, opt);
+	return add_index_entry(&the_index, ce, opt);
 }
 
 static int read_one_entry(const unsigned char *sha1, struct strbuf *base,
-- 
2.13.0.rc1.39.ga6db8bfa24

