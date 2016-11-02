Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D4920193
	for <e@80x24.org>; Wed,  2 Nov 2016 23:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757231AbcKBXRe (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 19:17:34 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34767 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756229AbcKBXRd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 19:17:33 -0400
Received: by mail-pf0-f173.google.com with SMTP id n85so19632180pfi.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YnXFgrrg+fqgkX/u0ILxnCqO1BmfyK2yZ3JLC7pNgIY=;
        b=XMv6GZhe6lw8jUmsPpo1OxvcqYry8CicuHa8n+ymfwKBrkfPYZGw96ZVezLM0WTBYQ
         jOwkDBVYtHTwuNiJnrDFstKegS692LVeITFhwa0/LS7AKldQuC4D2X7eabIdbNOK3t0l
         R0e+6jVRaPd2cji8y2YRZ+tn08aNDUv+Vf/73G1BUZ/hbOMIzdxbYNr69eA3xbYhOCnv
         T4Pow5nIM+kJQWwRaNmHu89VjyIdPuhvWZVumFmV/IhqIVzsGo6SzPyp+BYDrUZMHQGg
         PcgoI2LAQS5V3BtJRW17atgS78cZzq4Irkm5hBhlAcOLdUW4WthQ9dOf2sQOhzZnRMjn
         DYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YnXFgrrg+fqgkX/u0ILxnCqO1BmfyK2yZ3JLC7pNgIY=;
        b=GFrWCvwjvNmtDCmeXE8ZnceuylYWcer4pGWoozh4HXrTM8RJ5wF+Dip5CAoud4QJgm
         hrxotfa/eekJCV6/WgEURjJYCCmKyQkg0o+Yg2wQ6J40m8nDdV/7YL2VFM8Vx1LIqApq
         dN3WUPDEIbGJ9txVLszh7Rdj1v++ImJZUJnQxPgM0jB4hyB9sYCHwCojcJGsyqnKt0+P
         PRWrEt5OnzdSj53xOymXlfrCao7Q5QhSk6K8VUllMNEwG5Vu2Iu3SE68ZFwe6gPvfy7K
         UzGFtHlKvdh7YBS4Pq19xtXmQI7lHhNfs78Z0OL8yXpjFBuANHpNs6vlNHAzfrtWijur
         XnVQ==
X-Gm-Message-State: ABUngve53OJA8AU5lUqKX/k61JzuL//IZf02djz2b3oQmvJdDfI38Tc1Wr7e6SZqzGgDIQmU
X-Received: by 10.98.200.203 with SMTP id i72mr11253522pfk.181.1478128652230;
        Wed, 02 Nov 2016 16:17:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b836:b884:f13a:bcf4])
        by smtp.gmail.com with ESMTPSA id u1sm7186893pfb.96.2016.11.02.16.17.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 16:17:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule-config: rename commit_sha1 to commit_or_tree
Date:   Wed,  2 Nov 2016 16:17:21 -0700
Message-Id: <20161102231722.15787-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.621.g399b625.dirty
In-Reply-To: <20161102231722.15787-1-sbeller@google.com>
References: <20161102231722.15787-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is also possible to pass in a tree hash to lookup a submodule config.
Make it clear by naming the variables accrodingly. Looking up a submodule
config by tree hash will come in handy in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-submodule-config.txt |  4 +-
 submodule-config.c                               | 47 ++++++++++++------------
 submodule-config.h                               |  4 +-
 t/t7411-submodule-config.sh                      | 11 ++++++
 4 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 941fa178dd..81921e477b 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -47,11 +47,11 @@ Functions
 	Can be passed to the config parsing infrastructure to parse
 	local (worktree) submodule configurations.
 
-`const struct submodule *submodule_from_path(const unsigned char *commit_sha1, const char *path)`::
+`const struct submodule *submodule_from_path(const unsigned char *commit_or_tree, const char *path)`::
 
 	Lookup values for one submodule by its commit_sha1 and path.
 
-`const struct submodule *submodule_from_name(const unsigned char *commit_sha1, const char *name)`::
+`const struct submodule *submodule_from_name(const unsigned char *commit_or_tree, const char *name)`::
 
 	The same as above but lookup by name.
 
diff --git a/submodule-config.c b/submodule-config.c
index 15ffab6af4..4c5f5d074b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -263,12 +263,12 @@ int parse_push_recurse_submodules_arg(const char *opt, const char *arg)
 	return parse_push_recurse(opt, arg, 1);
 }
 
-static void warn_multiple_config(const unsigned char *commit_sha1,
+static void warn_multiple_config(const unsigned char *commit_or_tree,
 				 const char *name, const char *option)
 {
 	const char *commit_string = "WORKTREE";
-	if (commit_sha1)
-		commit_string = sha1_to_hex(commit_sha1);
+	if (commit_or_tree)
+		commit_string = sha1_to_hex(commit_or_tree);
 	warning("%s:.gitmodules, multiple configurations found for "
 			"'submodule.%s.%s'. Skipping second one!",
 			commit_string, name, option);
@@ -276,7 +276,7 @@ static void warn_multiple_config(const unsigned char *commit_sha1,
 
 struct parse_config_parameter {
 	struct submodule_cache *cache;
-	const unsigned char *commit_sha1;
+	const unsigned char *commit_or_tree;
 	const unsigned char *gitmodules_sha1;
 	int overwrite;
 };
@@ -300,7 +300,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->path)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->commit_or_tree, submodule->name,
 					"path");
 		else {
 			if (submodule->path)
@@ -314,7 +314,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
 		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->commit_or_tree, submodule->name,
 					"fetchrecursesubmodules");
 		else
 			submodule->fetch_recurse = parse_fetch_recurse(
@@ -324,7 +324,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->ignore)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->commit_or_tree, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
 			 strcmp(value, "dirty") &&
@@ -340,7 +340,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		if (!value) {
 			ret = config_error_nonbool(var);
 		} else if (!me->overwrite && submodule->url) {
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->commit_or_tree, submodule->name,
 					"url");
 		} else {
 			free((void *) submodule->url);
@@ -351,21 +351,21 @@ static int parse_config(const char *var, const char *value, void *data)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite &&
 			 submodule->update_strategy.type != SM_UPDATE_UNSPECIFIED)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->commit_or_tree, submodule->name,
 					     "update");
 		else if (parse_submodule_update_strategy(value,
 			 &submodule->update_strategy) < 0)
 				die(_("invalid value for %s"), var);
 	} else if (!strcmp(item.buf, "shallow")) {
 		if (!me->overwrite && submodule->recommend_shallow != -1)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->commit_or_tree, submodule->name,
 					     "shallow");
 		else
 			submodule->recommend_shallow =
 				git_config_bool(var, value);
 	} else if (!strcmp(item.buf, "branch")) {
 		if (!me->overwrite && submodule->branch)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->commit_or_tree, submodule->name,
 					     "branch");
 		else {
 			free((void *)submodule->branch);
@@ -379,18 +379,18 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
-static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
+static int gitmodule_sha1_from_commit(const unsigned char *commit_or_tree,
 				      unsigned char *gitmodules_sha1,
 				      struct strbuf *rev)
 {
 	int ret = 0;
 
-	if (is_null_sha1(commit_sha1)) {
+	if (is_null_sha1(commit_or_tree)) {
 		hashclr(gitmodules_sha1);
 		return 1;
 	}
 
-	strbuf_addf(rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
+	strbuf_addf(rev, "%s:.gitmodules", sha1_to_hex(commit_or_tree));
 	if (get_sha1(rev->buf, gitmodules_sha1) >= 0)
 		ret = 1;
 
@@ -402,7 +402,7 @@ static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
  * revisions.
  */
 static const struct submodule *config_from(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *key,
+		const unsigned char *commit_or_tree, const char *key,
 		enum lookup_type lookup_type)
 {
 	struct strbuf rev = STRBUF_INIT;
@@ -418,7 +418,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	 * return the first submodule. Can be used to check whether
 	 * there are any submodules parsed.
 	 */
-	if (!commit_sha1 || !key) {
+	if (!commit_or_tree || !key) {
 		struct hashmap_iter iter;
 		struct submodule_entry *entry;
 
@@ -428,7 +428,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		return entry->config;
 	}
 
-	if (!gitmodule_sha1_from_commit(commit_sha1, sha1, &rev))
+	if (!gitmodule_sha1_from_commit(commit_or_tree, sha1, &rev))
 		goto out;
 
 	switch (lookup_type) {
@@ -448,7 +448,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
 	/* fill the submodule config into the cache */
 	parameter.cache = cache;
-	parameter.commit_sha1 = commit_sha1;
+	// todo: get the actual tree here:
+	parameter.commit_or_tree = commit_or_tree;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
@@ -484,7 +485,7 @@ int parse_submodule_config_option(const char *var, const char *value)
 {
 	struct parse_config_parameter parameter;
 	parameter.cache = &the_submodule_cache;
-	parameter.commit_sha1 = NULL;
+	parameter.commit_or_tree = NULL;
 	parameter.gitmodules_sha1 = null_sha1;
 	parameter.overwrite = 1;
 
@@ -492,18 +493,18 @@ int parse_submodule_config_option(const char *var, const char *value)
 	return parse_config(var, value, &parameter);
 }
 
-const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
+const struct submodule *submodule_from_name(const unsigned char *commit_or_tree,
 		const char *name)
 {
 	ensure_cache_init();
-	return config_from(&the_submodule_cache, commit_sha1, name, lookup_name);
+	return config_from(&the_submodule_cache, commit_or_tree, name, lookup_name);
 }
 
-const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
+const struct submodule *submodule_from_path(const unsigned char *commit_or_tree,
 		const char *path)
 {
 	ensure_cache_init();
-	return config_from(&the_submodule_cache, commit_sha1, path, lookup_path);
+	return config_from(&the_submodule_cache, commit_or_tree, path, lookup_path);
 }
 
 void submodule_free(void)
diff --git a/submodule-config.h b/submodule-config.h
index d05c542d2c..99df8e593c 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -25,9 +25,9 @@ struct submodule {
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_submodule_config_option(const char *var, const char *value);
-const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
+const struct submodule *submodule_from_name(const unsigned char *commit_or_tree,
 		const char *name);
-const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
+const struct submodule *submodule_from_path(const unsigned char *commit_or_tree,
 		const char *path);
 void submodule_free(void);
 
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 47562ce465..301ed5e48f 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -93,6 +93,17 @@ test_expect_success 'error message contains blob reference' '
 	)
 '
 
+test_expect_success 'using tree sha1 works' '
+	(
+		cd super &&
+		tree=$(git rev-parse HEAD^{tree}) &&
+		commit=$(git rev-parse HEAD^{commit}) &&
+		test-submodule-config $commit b >expect &&
+		test-submodule-config $tree b >actual &&
+		test_cmp expect actual
+	)
+'
+
 cat >super/expect_url <<EOF
 Submodule url: 'git@somewhere.else.net:a.git' for path 'b'
 Submodule url: 'git@somewhere.else.net:submodule.git' for path 'submodule'
-- 
2.10.2.621.g399b625.dirty

