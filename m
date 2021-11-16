Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60CC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C44961B3E
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhKPDoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhKPDn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:43:28 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7078C03AA29
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 16:00:42 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q29-20020a631f5d000000b002dfcc4e0201so8030797pgm.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 16:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Yq/DzBmqkcklOy/EC6XQdPjHQR+gdR3MeUeYGLtogEU=;
        b=WQaO9CoKJVYcX1fEybRJnwlKJX/HtGN8RHveANmY/gLt76WsXcsybyEh2wm8q1JxeS
         9lmhYG6z0Y5iyB3BfZD4bTEtK92vcEE1/7gG0GqJ+9qGvzgD5eI1o8FZcLr9KZKohRTt
         vwuZLyFl5OAUfRmgCneFs0JNSPw01ObRXdhhxULQ3E6CXDt8v3egrsoWm83LMyF8XbNf
         MRSsSNEtzd4eb6CB8Rxe4YwUnIf5Bf6fMBUtaQVwOP4y5GTHVcxg6VmQRYhFmC+7N2j5
         Y9cpHiN97DP9mjZWlrUM1pmbBVBzMuHF783tL4WfuadThUoEDamDQay/KxFzWGLpr3bQ
         GauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yq/DzBmqkcklOy/EC6XQdPjHQR+gdR3MeUeYGLtogEU=;
        b=xBEswl+Q79rxOVbAACyvv59N6OWrsLUIlXQUFpPIFdS1WAa1NZ3zJv9oj5x5iazb8q
         tGS64D5sZiSxRkbRdaVMGUjx5n14+ozydkifQPqHU6p/ud6gFfSXSmDWOuKwWlC8M9To
         v6Geh7eR+o/9qRXIE0Qgcjoy/jWzMmCJbL/lGw31CGTnc6FCEh0vTXtYtZ30OPZiiX+Z
         EaTh4xsLTi0yBcUpYO58zjFFwJN/uF/bp4vN0NV8tljJeWv7trrwQ0ACVOIghbkaFKR0
         yf8yBuGe9qI5DJNZyU57vCgM6LJEP46G59kMTQuX7ZD95DmcWrk7smmO3YVDrMxmOgMq
         cadQ==
X-Gm-Message-State: AOAM533ncYNswcYMqPW6MaESbvCCQy7XV14x1sz00UegWmJ6s747SbBn
        epBImZiSnvi9o8nV686ObildZvufp6g+2QGAjnTneeJBHB5G37kmADbJTQAegQ9CDkg8/Py0dS2
        uDRA+DNbN9JtAVV9EGYFYjHJxbr2ahW56rpsJCAto/frbXXGH4NcWe4vwWnobNP8D/ysbSWd4um
        3T
X-Google-Smtp-Source: ABdhPJwdtzZGtvQDkI/c7+qy5rpOdQVQwIw7ndfXijrr5V0vHI1gZfQy6qbfOX59lzmRHHlBHag3sB/uo4fG+/2BnLPW
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:fc05:: with SMTP id
 j5mr1928858pgi.91.1637020842231; Mon, 15 Nov 2021 16:00:42 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:00:33 -0800
In-Reply-To: <cover.1637020610.git.jonathantanmy@google.com>
Message-Id: <1c1a07a0b65d4bbbb0f2628a3ddf1980e37d5065.1637020610.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1637020610.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v3 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, emilyshaffer@google.com,
        peff@peff.net, avarab@gmail.com, gitster@pobox.com
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
 Documentation/config.txt |  11 ++++
 config.c                 | 121 ++++++++++++++++++++++++++++++++++++---
 config.h                 |   7 +++
 t/t1300-config.sh        | 100 ++++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0c0e6b859f..93d18b2fe9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -159,6 +159,17 @@ all branches that begin with `foo/`. This is useful if your branches are
 organized hierarchically and you would like to apply a configuration to
 all the branches in that hierarchy.
 
+`hasremoteurl`::
+	The data that follows the keyword `hasremoteurl:` is taken to
+	be a pattern with standard globbing wildcards and two
+	additional ones, `**/` and `/**`, that can match multiple
+	components. The rest of the config files will be scanned for
+	remote URLs, and then if there at least one remote URL that
+	matches this pattern, the include condition is met.
++
+Files included by this option (directly or indirectly) are not allowed
+to contain remote URLs.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
diff --git a/config.c b/config.c
index 94ad5ce913..4ffc1e87e9 100644
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
 
@@ -316,12 +322,83 @@ static int include_condition_is_true(const struct config_options *opts,
 	return 0;
 }
 
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
+		die(_("remote URLs cannot be configured in file directly or indirectly included by includeIf.hasremoteurl"));
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
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
 	const char *cond, *key;
 	size_t cond_len;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Pass along all values, including "include" directives; this makes it
@@ -335,9 +412,29 @@ static int git_config_include(const char *var, const char *value, void *data)
 		ret = handle_path_include(value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
-	    !strcmp(key, "path"))
-		ret = handle_path_include(value, inc);
+	    cond && !strcmp(key, "path")) {
+		const char *url;
+		size_t url_len;
+
+		if (skip_prefix_mem(cond, cond_len, "hasremoteurl:", &url,
+				    &url_len)) {
+			if (inc->opts->unconditional_remote_url) {
+				config_fn_t old_fn = inc->fn;
+
+				inc->fn = forbid_remote_url;
+				ret = handle_path_include(value, inc);
+				inc->fn = old_fn;
+			} else {
+				if (!inc->remote_urls)
+					populate_remote_urls(inc);
+				if (at_least_one_url_matches_glob(
+						url, url_len, inc->remote_urls))
+					ret = handle_path_include(value, inc);
+			}
+		} else if (include_condition_is_true(inc->opts, cond, cond_len)) {
+			ret = handle_path_include(value, inc);
+		}
+	}
 
 	return ret;
 }
@@ -1933,11 +2030,13 @@ int config_with_options(config_fn_t fn, void *data,
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
@@ -1950,17 +2049,23 @@ int config_with_options(config_fn_t fn, void *data,
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
index 48a5e472ca..c24458b10a 100644
--- a/config.h
+++ b/config.h
@@ -89,6 +89,13 @@ struct config_options {
 	unsigned int ignore_worktree : 1;
 	unsigned int ignore_cmdline : 1;
 	unsigned int system_gently : 1;
+
+	/*
+	 * For internal use. Include all includeif.hasremoteurl paths without
+	 * checking if the repo has that remote URL.
+	 */
+	unsigned int unconditional_remote_url : 1;
+
 	const char *commondir;
 	const char *git_dir;
 	config_parser_event_fn_t event_fn;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9ff46f3b04..9daab4c6da 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2387,4 +2387,104 @@ test_expect_success '--get and --get-all with --fixed-value' '
 	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
 '
 
+test_expect_success 'includeIf.hasremoteurl' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	cat >"$(pwd)"/include-this <<-\EOF &&
+	[user]
+		this = this-is-included
+	EOF
+	cat >"$(pwd)"/dont-include-that <<-\EOF &&
+	[user]
+		that = that-is-not-included
+	EOF
+	cat >>hasremoteurlTest/.git/config <<-EOF &&
+	[includeIf "hasremoteurl:foo"]
+		path = "$(pwd)/include-this"
+	[includeIf "hasremoteurl:bar"]
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
+test_expect_success 'includeIf.hasremoteurl respects last-config-wins' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	cat >"$(pwd)"/include-two-three <<-\EOF &&
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
+	[includeIf "hasremoteurl:foo"]
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
+test_expect_success 'includeIf.hasremoteurl globs' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	printf "[user]\ndss = yes\n" >"$(pwd)/double-star-start" &&
+	printf "[user]\ndse = yes\n" >"$(pwd)/double-star-end" &&
+	printf "[user]\ndsm = yes\n" >"$(pwd)/double-star-middle" &&
+	printf "[user]\nssm = yes\n" >"$(pwd)/single-star-middle" &&
+	printf "[user]\nno = no\n" >"$(pwd)/no" &&
+
+	cat >>hasremoteurlTest/.git/config <<-EOF &&
+	[remote "foo"]
+		url = https://foo/bar/baz
+	[includeIf "hasremoteurl:**/baz"]
+		path = "$(pwd)/double-star-start"
+	[includeIf "hasremoteurl:**/nomatch"]
+		path = "$(pwd)/no"
+	[includeIf "hasremoteurl:https:/**"]
+		path = "$(pwd)/double-star-end"
+	[includeIf "hasremoteurl:nomatch:/**"]
+		path = "$(pwd)/no"
+	[includeIf "hasremoteurl:https:/**/baz"]
+		path = "$(pwd)/double-star-middle"
+	[includeIf "hasremoteurl:https:/**/nomatch"]
+		path = "$(pwd)/no"
+	[includeIf "hasremoteurl:https://*/bar/baz"]
+		path = "$(pwd)/single-star-middle"
+	[includeIf "hasremoteurl:https://*/baz"]
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
 test_done
-- 
2.34.0.rc1.387.gb447b232ab-goog

