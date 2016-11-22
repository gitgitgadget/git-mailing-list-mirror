Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5EC1FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 01:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932286AbcKVBgD (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 20:36:03 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35492 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbcKVBgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 20:36:02 -0500
Received: by mail-pg0-f53.google.com with SMTP id p66so1489504pga.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 17:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MINhqsrLnY0W88UgboDqKHQ+99Nizu+gITVqnW6ed5k=;
        b=COcarDV0ibyny7h1WUHp9AfML8xPJH7LNu2ddk/TfxK3+QTqsoh89G0R54NybXVCgR
         41wf0e5varenL5VsRGQaWOgbcLDk3g/QuOeiQa41cnfzMfxXKNCwH576ze4EAhaDvVli
         cI7vMga4cm2meThrDU5A6FRBRlQ1ZLrlVy94Mt2CdZVBmHL5LpVOlalgok0mAJdFxvvh
         WmDqPSFalPsVXCaakQ/k5PeTmgZZHVYXHM0NPPMMOJb1JqvQkc436BRki0I/vs0F0wcl
         KbcHAJdkswHRujJEt+Jz7x8K9Mp9gK/nkHGKc/qJbU9VgiX9fF9Ptkun4FDJF16w0xS4
         cPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MINhqsrLnY0W88UgboDqKHQ+99Nizu+gITVqnW6ed5k=;
        b=HpI0cmKDYx+xzFbRfixqXpCUxpxUSFo0c8IfM8HJVVJJ/SDhqVQ9bDL/k7cNSMZtQU
         J8T9kp1OFNHhnhIbyMEYO4HTGJ1kWIhPlgyK26bNeWFcu/aw02jIpSYVbD7LcHeZGwRZ
         mmm2nBbL37GhvYkgiGfUPX7gg9pzOR5Q+sswUfUijx4b0e/rf6dsHPxOUyZmo5KjAUQI
         /rQcnkzAxBZ+DwAmGOqeOKLbmyDN+m1Wzw6/qkw5xs3lcTJMSO4M1MlwfNv1Ib1KmyPm
         d6uYh3v3atmhMgOk883zY9Wk34ibk4wUBbOnY3CXje/BzBfNETrt9jHY1kNhiNV6OwGf
         wUPQ==
X-Gm-Message-State: AKaTC03UmAHm1MV9a+T+Goq+rqkiHmNdv1Wsab7A7ijmEZqsDetx1PtWSNrt2s5Eeh2j2f+5
X-Received: by 10.99.251.5 with SMTP id o5mr38641607pgh.152.1479778561032;
        Mon, 21 Nov 2016 17:36:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id z62sm40228861pfz.19.2016.11.21.17.36.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 17:36:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/3] submodule-config: rename commit_sha1 to commit_or_tree
Date:   Mon, 21 Nov 2016 17:35:49 -0800
Message-Id: <20161122013550.1800-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
In-Reply-To: <20161122013550.1800-1-sbeller@google.com>
References: <20161122013550.1800-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is also possible to pass in a tree hash to lookup a submodule config.
Make it clear by naming the variables accrodingly. Looking up a submodule
config by tree hash will come in handy in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-submodule-config.txt |  8 ++---
 submodule-config.c                               | 46 ++++++++++++------------
 submodule-config.h                               |  4 +--
 t/t7411-submodule-config.sh                      | 11 ++++++
 4 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 941fa178dd..768458580f 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -47,15 +47,15 @@ Functions
 	Can be passed to the config parsing infrastructure to parse
 	local (worktree) submodule configurations.
 
-`const struct submodule *submodule_from_path(const unsigned char *commit_sha1, const char *path)`::
+`const struct submodule *submodule_from_path(const unsigned char *commit_or_tree, const char *path)`::
 
-	Lookup values for one submodule by its commit_sha1 and path.
+	Lookup values for one submodule by its commit_or_tree and path.
 
-`const struct submodule *submodule_from_name(const unsigned char *commit_sha1, const char *name)`::
+`const struct submodule *submodule_from_name(const unsigned char *commit_or_tree, const char *name)`::
 
 	The same as above but lookup by name.
 
-If given the null_sha1 as commit_sha1 the local configuration of a
+If given the null_sha1 as commit_or_tree the local configuration of a
 submodule will be returned (e.g. consolidated values from local git
 configuration and the .gitmodules file in the worktree).
 
diff --git a/submodule-config.c b/submodule-config.c
index 15ffab6af4..d88a746c56 100644
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
@@ -448,7 +448,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
 	/* fill the submodule config into the cache */
 	parameter.cache = cache;
-	parameter.commit_sha1 = commit_sha1;
+	parameter.commit_or_tree = commit_or_tree;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
@@ -484,7 +484,7 @@ int parse_submodule_config_option(const char *var, const char *value)
 {
 	struct parse_config_parameter parameter;
 	parameter.cache = &the_submodule_cache;
-	parameter.commit_sha1 = NULL;
+	parameter.commit_or_tree = NULL;
 	parameter.gitmodules_sha1 = null_sha1;
 	parameter.overwrite = 1;
 
@@ -492,18 +492,18 @@ int parse_submodule_config_option(const char *var, const char *value)
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
2.11.0.rc2.18.g0126045.dirty

