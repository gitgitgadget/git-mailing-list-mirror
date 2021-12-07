Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C238C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 23:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbhLGX1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 18:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbhLGX1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 18:27:31 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D94C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 15:24:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q82-20020a627555000000b004a4f8cadb6fso473080pfc.20
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 15:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VOVBGTyG3kye33bAYGJKbpzvhz86g1HSR2PCN9dATuU=;
        b=oh4siMGj9rB15BcxtkDzKGH1bTjQD6QHTzGrBbB0HOpZcKGe278g8BSqaegHT9itsv
         o4NMtjAtcYbrdAIh2uZfzprSpCrg6SUUId96ntxmOQoYHnpG7Agc9b9bz5j8eZYGs8hb
         czKZPztHEvrhP+guy4a5ioubNPJJhVINcOOxiuA94fRXgCTWD2PNIWCaOmIPolsZ0BYa
         IPmdIcL1UbP0BGqRu4/1a2YWO1WRiXfegIwNdY+is1oINiNWl/EJLZ6Ic2+PQGSiWG9F
         ZzsPr/PT7fT4AGb5jm2yfWWYiHgkyoW6LQfnySKr/xDfqChvBGkDjosfsKZtNoh6ezov
         OzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VOVBGTyG3kye33bAYGJKbpzvhz86g1HSR2PCN9dATuU=;
        b=l4kO2HelaQBM73Gok+KspZVM7a4ONO9tNKmkGFTk/BU/2Tz9GR2lbE+CyCwzNVV1TW
         lr/r5fGuVgaEk+qJW+giywpMqXwftJiC8qFMdwMOztPZnlpVlhH6xfWNU/chP1eZsi8o
         BL+nhP4xYaAxPvCWoqKuOdycqL9pgw9xpWkP0sWnROzY1GR3o9ZJgyURzfS4UHJHp9/X
         UsmeqLuknW6GQr1V+9sHhLL1kezSSpW6rZkS8SNBEmaSgFcW/q+ORHv3gJRWyX/kGAYA
         Xbuw3DwiGZcMFzVcPF2h3tBGBYwqvuIFS68d6ksYf1Zu2283IMJykuVbRr9L1z971Huf
         K0Yw==
X-Gm-Message-State: AOAM530CuW5gkwUo9g3YiuQRcOJibrWNXBxxbFnyC8tj1CK3XgPQrqc1
        jtCCHLTR3gyxWRjAwlQUsqWVQXtTi4aXYRc304BvhD7El5WNnlLeDHaQnlcfLXpXO85HmFSPsdG
        AQDDcuO8+qkRr+8QvQXB5TImU0Atx5w8HKFStfo83FsEIIIqCpZm5yCbEdBWS8F0Kq9lglF3nvO
        Ii
X-Google-Smtp-Source: ABdhPJzttRWTIkWvY3CmjAgEpOH/27pLs/ERQsACM0M0EwN8Jj8S6aFj0KwsJ1jgHbGYImXsHUBKS26RXOJuQQnQjqo8
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1385:b0:4ad:580d:8a8 with
 SMTP id t5-20020a056a00138500b004ad580d08a8mr2152185pfg.10.1638919440113;
 Tue, 07 Dec 2021 15:24:00 -0800 (PST)
Date:   Tue,  7 Dec 2021 15:23:52 -0800
In-Reply-To: <cover.1638919346.git.jonathantanmy@google.com>
Message-Id: <de2be06818781bbef29926c0e8e8981746242c60.1638919346.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1638919346.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v6 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a feature that supports config file inclusion conditional on
whether the repo has a remote with a URL that matches a glob.

Similar to my previous work on remote-suggested hooks [1], the main
motivation is to allow remote repo administrators to provide recommended
configs in a way that can be consumed more easily (e.g. through a
package installable by a package manager - it could, for example,
contain a file to be included conditionally and a post-install script
that adds the include directive to the system-wide config file).

In order to do this, Git reruns the config parsing mechanism upon
noticing the first URL-conditional include in order to find all remote
URLs, and these remote URLs are then used to determine if that first and
all subsequent includes are executed. Remote URLs are not allowed to be
configued in any URL-conditionally-included file.

[1] https://lore.kernel.org/git/cover.1623881977.git.jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config.txt |  16 ++++++
 config.c                 | 121 ++++++++++++++++++++++++++++++++++++---
 config.h                 |   9 +++
 t/t1300-config.sh        | 118 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 257 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0c0e6b859f..e0e5ca558e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -159,6 +159,22 @@ all branches that begin with `foo/`. This is useful if your branches are
 organized hierarchically and you would like to apply a configuration to
 all the branches in that hierarchy.
 
+`hasconfig:remote.*.url:`::
+	The data that follows this keyword is taken to
+	be a pattern with standard globbing wildcards and two
+	additional ones, `**/` and `/**`, that can match multiple
+	components. The first time this keyword is seen, the rest of
+	the config files will be scanned for remote URLs (without
+	applying any values). If there exists at least one remote URL
+	that matches this pattern, the include condition is met.
++
+Files included by this option (directly or indirectly) are not allowed
+to contain remote URLs.
++
+This keyword is designed to be forwards compatible with a naming
+scheme that supports more variable-based include conditions, but
+currently Git only supports the exact keyword described above.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
diff --git a/config.c b/config.c
index 94ad5ce913..f17053d91b 100644
--- a/config.c
+++ b/config.c
@@ -125,6 +125,12 @@ struct config_include_data {
 	config_fn_t fn;
 	void *data;
 	const struct config_options *opts;
+	struct git_config_source *config_source;
+
+	/*
+	 * All remote URLs discovered when reading all config files.
+	 */
+	struct string_list *remote_urls;
 };
 #define CONFIG_INCLUDE_INIT { 0 }
 
@@ -301,9 +307,92 @@ static int include_by_branch(const char *cond, size_t cond_len)
 	return ret;
 }
 
-static int include_condition_is_true(const struct config_options *opts,
+static int add_remote_url(const char *var, const char *value, void *data)
+{
+	struct string_list *remote_urls = data;
+	const char *remote_name;
+	size_t remote_name_len;
+	const char *key;
+
+	if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
+			      &key) &&
+	    remote_name &&
+	    !strcmp(key, "url"))
+		string_list_append(remote_urls, value);
+	return 0;
+}
+
+static void populate_remote_urls(struct config_include_data *inc)
+{
+	struct config_options opts;
+
+	struct config_source *store_cf = cf;
+	struct key_value_info *store_kvi = current_config_kvi;
+	enum config_scope store_scope = current_parsing_scope;
+
+	opts = *inc->opts;
+	opts.unconditional_remote_url = 1;
+
+	cf = NULL;
+	current_config_kvi = NULL;
+	current_parsing_scope = 0;
+
+	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
+	string_list_init_dup(inc->remote_urls);
+	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
+
+	cf = store_cf;
+	current_config_kvi = store_kvi;
+	current_parsing_scope = store_scope;
+}
+
+static int forbid_remote_url(const char *var, const char *value, void *data)
+{
+	const char *remote_name;
+	size_t remote_name_len;
+	const char *key;
+
+	if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
+			      &key) &&
+	    remote_name &&
+	    !strcmp(key, "url"))
+		die(_("remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url"));
+	return 0;
+}
+
+static int at_least_one_url_matches_glob(const char *glob, int glob_len,
+					 struct string_list *remote_urls)
+{
+	struct strbuf pattern = STRBUF_INIT;
+	struct string_list_item *url_item;
+	int found = 0;
+
+	strbuf_add(&pattern, glob, glob_len);
+	for_each_string_list_item(url_item, remote_urls) {
+		if (!wildmatch(pattern.buf, url_item->string, WM_PATHNAME)) {
+			found = 1;
+			break;
+		}
+	}
+	strbuf_release(&pattern);
+	return found;
+}
+
+static int include_by_remote_url(struct config_include_data *inc,
+		const char *cond, size_t cond_len)
+{
+	if (inc->opts->unconditional_remote_url)
+		return 1;
+	if (!inc->remote_urls)
+		populate_remote_urls(inc);
+	return at_least_one_url_matches_glob(cond, cond_len,
+					     inc->remote_urls);
+}
+
+static int include_condition_is_true(struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
+	const struct config_options *opts = inc->opts;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
 		return include_by_gitdir(opts, cond, cond_len, 0);
@@ -311,6 +400,9 @@ static int include_condition_is_true(const struct config_options *opts,
 		return include_by_gitdir(opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
+				   &cond_len))
+		return include_by_remote_url(inc, cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
@@ -335,9 +427,16 @@ static int git_config_include(const char *var, const char *value, void *data)
 		ret = handle_path_include(value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
-	    !strcmp(key, "path"))
+	    cond && include_condition_is_true(inc, cond, cond_len) &&
+	    !strcmp(key, "path")) {
+		config_fn_t old_fn = inc->fn;
+
+		if (inc->opts->unconditional_remote_url)
+			inc->fn = forbid_remote_url;
 		ret = handle_path_include(value, inc);
+		if (inc->opts->unconditional_remote_url)
+			inc->fn = old_fn;
+	}
 
 	return ret;
 }
@@ -1933,11 +2032,13 @@ int config_with_options(config_fn_t fn, void *data,
 			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
+	int ret;
 
 	if (opts->respect_includes) {
 		inc.fn = fn;
 		inc.data = data;
 		inc.opts = opts;
+		inc.config_source = config_source;
 		fn = git_config_include;
 		data = &inc;
 	}
@@ -1950,17 +2051,23 @@ int config_with_options(config_fn_t fn, void *data,
 	 * regular lookup sequence.
 	 */
 	if (config_source && config_source->use_stdin) {
-		return git_config_from_stdin(fn, data);
+		ret = git_config_from_stdin(fn, data);
 	} else if (config_source && config_source->file) {
-		return git_config_from_file(fn, config_source->file, data);
+		ret = git_config_from_file(fn, config_source->file, data);
 	} else if (config_source && config_source->blob) {
 		struct repository *repo = config_source->repo ?
 			config_source->repo : the_repository;
-		return git_config_from_blob_ref(fn, repo, config_source->blob,
+		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 						data);
+	} else {
+		ret = do_git_config_sequence(opts, fn, data);
 	}
 
-	return do_git_config_sequence(opts, fn, data);
+	if (inc.remote_urls) {
+		string_list_clear(inc.remote_urls, 0);
+		FREE_AND_NULL(inc.remote_urls);
+	}
+	return ret;
 }
 
 static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
diff --git a/config.h b/config.h
index 48a5e472ca..ab0106d287 100644
--- a/config.h
+++ b/config.h
@@ -89,6 +89,15 @@ struct config_options {
 	unsigned int ignore_worktree : 1;
 	unsigned int ignore_cmdline : 1;
 	unsigned int system_gently : 1;
+
+	/*
+	 * For internal use. Include all includeif.hasremoteurl paths without
+	 * checking if the repo has that remote URL, and when doing so, verify
+	 * that files included in this way do not configure any remote URLs
+	 * themselves.
+	 */
+	unsigned int unconditional_remote_url : 1;
+
 	const char *commondir;
 	const char *git_dir;
 	config_parser_event_fn_t event_fn;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9ff46f3b04..8310562b84 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2387,4 +2387,122 @@ test_expect_success '--get and --get-all with --fixed-value' '
 	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
 '
 
+test_expect_success 'includeIf.hasconfig:remote.*.url' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	cat >include-this <<-\EOF &&
+	[user]
+		this = this-is-included
+	EOF
+	cat >dont-include-that <<-\EOF &&
+	[user]
+		that = that-is-not-included
+	EOF
+	cat >>hasremoteurlTest/.git/config <<-EOF &&
+	[includeIf "hasconfig:remote.*.url:foo"]
+		path = "$(pwd)/include-this"
+	[includeIf "hasconfig:remote.*.url:bar"]
+		path = "$(pwd)/dont-include-that"
+	[remote "foo"]
+		url = foo
+	EOF
+
+	echo this-is-included >expect-this &&
+	git -C hasremoteurlTest config --get user.this >actual-this &&
+	test_cmp expect-this actual-this &&
+
+	test_must_fail git -C hasremoteurlTest config --get user.that
+'
+
+test_expect_success 'includeIf.hasconfig:remote.*.url respects last-config-wins' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	cat >include-two-three <<-\EOF &&
+	[user]
+		two = included-config
+		three = included-config
+	EOF
+	cat >>hasremoteurlTest/.git/config <<-EOF &&
+	[remote "foo"]
+		url = foo
+	[user]
+		one = main-config
+		two = main-config
+	[includeIf "hasconfig:remote.*.url:foo"]
+		path = "$(pwd)/include-two-three"
+	[user]
+		three = main-config
+	EOF
+
+	echo main-config >expect-main-config &&
+	echo included-config >expect-included-config &&
+
+	git -C hasremoteurlTest config --get user.one >actual &&
+	test_cmp expect-main-config actual &&
+
+	git -C hasremoteurlTest config --get user.two >actual &&
+	test_cmp expect-included-config actual &&
+
+	git -C hasremoteurlTest config --get user.three >actual &&
+	test_cmp expect-main-config actual
+'
+
+test_expect_success 'includeIf.hasconfig:remote.*.url globs' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	printf "[user]\ndss = yes\n" >double-star-start &&
+	printf "[user]\ndse = yes\n" >double-star-end &&
+	printf "[user]\ndsm = yes\n" >double-star-middle &&
+	printf "[user]\nssm = yes\n" >single-star-middle &&
+	printf "[user]\nno = no\n" >no &&
+
+	cat >>hasremoteurlTest/.git/config <<-EOF &&
+	[remote "foo"]
+		url = https://foo/bar/baz
+	[includeIf "hasconfig:remote.*.url:**/baz"]
+		path = "$(pwd)/double-star-start"
+	[includeIf "hasconfig:remote.*.url:**/nomatch"]
+		path = "$(pwd)/no"
+	[includeIf "hasconfig:remote.*.url:https:/**"]
+		path = "$(pwd)/double-star-end"
+	[includeIf "hasconfig:remote.*.url:nomatch:/**"]
+		path = "$(pwd)/no"
+	[includeIf "hasconfig:remote.*.url:https:/**/baz"]
+		path = "$(pwd)/double-star-middle"
+	[includeIf "hasconfig:remote.*.url:https:/**/nomatch"]
+		path = "$(pwd)/no"
+	[includeIf "hasconfig:remote.*.url:https://*/bar/baz"]
+		path = "$(pwd)/single-star-middle"
+	[includeIf "hasconfig:remote.*.url:https://*/baz"]
+		path = "$(pwd)/no"
+	EOF
+
+	git -C hasremoteurlTest config --get user.dss &&
+	git -C hasremoteurlTest config --get user.dse &&
+	git -C hasremoteurlTest config --get user.dsm &&
+	git -C hasremoteurlTest config --get user.ssm &&
+	test_must_fail git -C hasremoteurlTest config --get user.no
+'
+
+test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such included files' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	cat >include-with-url <<-\EOF &&
+	[remote "bar"]
+		url = bar
+	EOF
+	cat >>hasremoteurlTest/.git/config <<-EOF &&
+	[includeIf "hasconfig:remote.*.url:foo"]
+		path = "$(pwd)/include-with-url"
+	EOF
+
+	# test with any Git command
+	test_must_fail git -C hasremoteurlTest status 2>err &&
+	grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
+'
+
 test_done
-- 
2.34.1.400.ga245620fadb-goog

