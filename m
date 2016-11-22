Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C382021E
	for <e@80x24.org>; Tue, 22 Nov 2016 20:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756246AbcKVUOt (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 15:14:49 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32998 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754572AbcKVUOr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 15:14:47 -0500
Received: by mail-pg0-f48.google.com with SMTP id 3so10903395pgd.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 12:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K+egCfhxIxHxvAGzpEJvTi5w7q8naVYLx20rcBXaRAc=;
        b=MO/KrtIB4BglTh+bm428nnl3rRf6MPf/EJ13nLu0L+mpMfeXWUvVSRpwtX5QFBKt6s
         3IdZqYmE2SJBYXntS5K2FHK7t6i0KQ6DlEjvKROWaFAqUBczugim90slMSyDWv5UN4D1
         lA7ZYXc7YzhVerM5CANbFVDUzeAQkLNo4O6ZgohNiaFZ2he8jAGlMkCYQJISMj54qSVY
         m0ds9Nww+AHSk5IdKy/4wPOdtU8TGHfY1cT2b7x+VeseA5FLKH4GzQZJhMYXkIxVOZmn
         snMWdK6vbTiwrSFgQkk+QecXg3SEdAX3FDteXhAc/7WuIW+WRF/c7qN+yrD8LONyix4f
         4QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K+egCfhxIxHxvAGzpEJvTi5w7q8naVYLx20rcBXaRAc=;
        b=KIoMCb6Xs8gUNAZUnAKPdEYTBB0toNqlOoGHxkPOG2iN6lzyG7NxT1w+H1VsdE8GxR
         BHGvc1IR02QsNdImK6yzo90iVx9/Qam1jDzboANjs3p2fJNn057jM9htJ4QyHyD/TWgs
         G+sKoDUPKQAOcWy5SG3hV86l3Fk+0nHiPxGpGigu9/zbSn3KIUAdvJcRpZB7NB5Cl/Zh
         4DIw0IrnJZGwBvBPu0/6M9c8ALWuFaCjcPwyxPp0R8jQhKBljas6caIsijanM7M8eytw
         DA2fmEyCkdeEvdie8Ap4JPa62DR44LrrubbpNiPi8DWumekkUGKWRToghPPF/gOCdgu/
         Ciag==
X-Gm-Message-State: AKaTC01WE/O6rDO7w7coKyWmihxhhY+zJn+FVQl6hG7Z8avtg5j6Qa+OnN9pnFoGaSV+NF2I
X-Received: by 10.99.209.5 with SMTP id k5mr46429228pgg.13.1479845686654;
        Tue, 22 Nov 2016 12:14:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id z9sm47113729pfd.29.2016.11.22.12.14.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 12:14:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/3] submodule-config: rename commit_sha1 to treeish_name
Date:   Tue, 22 Nov 2016 12:14:37 -0800
Message-Id: <20161122201438.16069-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
In-Reply-To: <20161122201438.16069-1-sbeller@google.com>
References: <20161122201438.16069-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is also possible to pass in any treeish name to lookup a submodule
config. Make it clear by naming the variables accordingly. Looking up
a submodule config by tree hash will come in handy in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-submodule-config.txt |  9 ++---
 submodule-config.c                               | 46 ++++++++++++------------
 submodule-config.h                               |  4 +--
 t/t7411-submodule-config.sh                      | 14 ++++++++
 4 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 941fa178dd..8285bcc605 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -47,15 +47,16 @@ Functions
 	Can be passed to the config parsing infrastructure to parse
 	local (worktree) submodule configurations.
 
-`const struct submodule *submodule_from_path(const unsigned char *commit_sha1, const char *path)`::
+`const struct submodule *submodule_from_path(const unsigned char *treeish_name, const char *path)`::
 
-	Lookup values for one submodule by its commit_sha1 and path.
+	Given a tree-ish in the superproject and a path, return the
+	submodule that is bound at the path in the named tree.
 
-`const struct submodule *submodule_from_name(const unsigned char *commit_sha1, const char *name)`::
+`const struct submodule *submodule_from_name(const unsigned char *treeish_name, const char *name)`::
 
 	The same as above but lookup by name.
 
-If given the null_sha1 as commit_sha1 the local configuration of a
+If given the null_sha1 as treeish_name the local configuration of a
 submodule will be returned (e.g. consolidated values from local git
 configuration and the .gitmodules file in the worktree).
 
diff --git a/submodule-config.c b/submodule-config.c
index 15ffab6af4..ec13ab5a3d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -263,12 +263,12 @@ int parse_push_recurse_submodules_arg(const char *opt, const char *arg)
 	return parse_push_recurse(opt, arg, 1);
 }
 
-static void warn_multiple_config(const unsigned char *commit_sha1,
+static void warn_multiple_config(const unsigned char *treeish_name,
 				 const char *name, const char *option)
 {
 	const char *commit_string = "WORKTREE";
-	if (commit_sha1)
-		commit_string = sha1_to_hex(commit_sha1);
+	if (treeish_name)
+		commit_string = sha1_to_hex(treeish_name);
 	warning("%s:.gitmodules, multiple configurations found for "
 			"'submodule.%s.%s'. Skipping second one!",
 			commit_string, name, option);
@@ -276,7 +276,7 @@ static void warn_multiple_config(const unsigned char *commit_sha1,
 
 struct parse_config_parameter {
 	struct submodule_cache *cache;
-	const unsigned char *commit_sha1;
+	const unsigned char *treeish_name;
 	const unsigned char *gitmodules_sha1;
 	int overwrite;
 };
@@ -300,7 +300,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->path)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->treeish_name, submodule->name,
 					"path");
 		else {
 			if (submodule->path)
@@ -314,7 +314,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
 		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->treeish_name, submodule->name,
 					"fetchrecursesubmodules");
 		else
 			submodule->fetch_recurse = parse_fetch_recurse(
@@ -324,7 +324,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->ignore)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->treeish_name, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
 			 strcmp(value, "dirty") &&
@@ -340,7 +340,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		if (!value) {
 			ret = config_error_nonbool(var);
 		} else if (!me->overwrite && submodule->url) {
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->treeish_name, submodule->name,
 					"url");
 		} else {
 			free((void *) submodule->url);
@@ -351,21 +351,21 @@ static int parse_config(const char *var, const char *value, void *data)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite &&
 			 submodule->update_strategy.type != SM_UPDATE_UNSPECIFIED)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->treeish_name, submodule->name,
 					     "update");
 		else if (parse_submodule_update_strategy(value,
 			 &submodule->update_strategy) < 0)
 				die(_("invalid value for %s"), var);
 	} else if (!strcmp(item.buf, "shallow")) {
 		if (!me->overwrite && submodule->recommend_shallow != -1)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->treeish_name, submodule->name,
 					     "shallow");
 		else
 			submodule->recommend_shallow =
 				git_config_bool(var, value);
 	} else if (!strcmp(item.buf, "branch")) {
 		if (!me->overwrite && submodule->branch)
-			warn_multiple_config(me->commit_sha1, submodule->name,
+			warn_multiple_config(me->treeish_name, submodule->name,
 					     "branch");
 		else {
 			free((void *)submodule->branch);
@@ -379,18 +379,18 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
-static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
+static int gitmodule_sha1_from_commit(const unsigned char *treeish_name,
 				      unsigned char *gitmodules_sha1,
 				      struct strbuf *rev)
 {
 	int ret = 0;
 
-	if (is_null_sha1(commit_sha1)) {
+	if (is_null_sha1(treeish_name)) {
 		hashclr(gitmodules_sha1);
 		return 1;
 	}
 
-	strbuf_addf(rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
+	strbuf_addf(rev, "%s:.gitmodules", sha1_to_hex(treeish_name));
 	if (get_sha1(rev->buf, gitmodules_sha1) >= 0)
 		ret = 1;
 
@@ -402,7 +402,7 @@ static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
  * revisions.
  */
 static const struct submodule *config_from(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *key,
+		const unsigned char *treeish_name, const char *key,
 		enum lookup_type lookup_type)
 {
 	struct strbuf rev = STRBUF_INIT;
@@ -418,7 +418,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	 * return the first submodule. Can be used to check whether
 	 * there are any submodules parsed.
 	 */
-	if (!commit_sha1 || !key) {
+	if (!treeish_name || !key) {
 		struct hashmap_iter iter;
 		struct submodule_entry *entry;
 
@@ -428,7 +428,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		return entry->config;
 	}
 
-	if (!gitmodule_sha1_from_commit(commit_sha1, sha1, &rev))
+	if (!gitmodule_sha1_from_commit(treeish_name, sha1, &rev))
 		goto out;
 
 	switch (lookup_type) {
@@ -448,7 +448,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
 	/* fill the submodule config into the cache */
 	parameter.cache = cache;
-	parameter.commit_sha1 = commit_sha1;
+	parameter.treeish_name = treeish_name;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
@@ -484,7 +484,7 @@ int parse_submodule_config_option(const char *var, const char *value)
 {
 	struct parse_config_parameter parameter;
 	parameter.cache = &the_submodule_cache;
-	parameter.commit_sha1 = NULL;
+	parameter.treeish_name = NULL;
 	parameter.gitmodules_sha1 = null_sha1;
 	parameter.overwrite = 1;
 
@@ -492,18 +492,18 @@ int parse_submodule_config_option(const char *var, const char *value)
 	return parse_config(var, value, &parameter);
 }
 
-const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
+const struct submodule *submodule_from_name(const unsigned char *treeish_name,
 		const char *name)
 {
 	ensure_cache_init();
-	return config_from(&the_submodule_cache, commit_sha1, name, lookup_name);
+	return config_from(&the_submodule_cache, treeish_name, name, lookup_name);
 }
 
-const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
+const struct submodule *submodule_from_path(const unsigned char *treeish_name,
 		const char *path)
 {
 	ensure_cache_init();
-	return config_from(&the_submodule_cache, commit_sha1, path, lookup_path);
+	return config_from(&the_submodule_cache, treeish_name, path, lookup_path);
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
index 47562ce465..d389ae5408 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -93,6 +93,20 @@ test_expect_success 'error message contains blob reference' '
 	)
 '
 
+test_expect_success 'using different treeishs works' '
+	(
+		cd super &&
+		git tag new_tag &&
+		tree=$(git rev-parse HEAD^{tree}) &&
+		commit=$(git rev-parse HEAD^{commit}) &&
+		test-submodule-config $commit b >expect &&
+		test-submodule-config $tree b >actual.1 &&
+		test-submodule-config new_tag b >actual.2 &&
+		test_cmp expect actual.1 &&
+		test_cmp expect actual.2
+	)
+'
+
 cat >super/expect_url <<EOF
 Submodule url: 'git@somewhere.else.net:a.git' for path 'b'
 Submodule url: 'git@somewhere.else.net:submodule.git' for path 'submodule'
-- 
2.11.0.rc2.4.g3396b6f.dirty

