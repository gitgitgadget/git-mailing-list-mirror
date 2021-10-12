Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0915CC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4444604DA
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhJLW7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhJLW7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 18:59:35 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB42CC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:57:32 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id g26-20020a63521a000000b0029524f04f5aso312733pgb.5
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zdq2v4kNGT8fqmSl3qlN88CLTYwnVgsV1XXeYXG6QLM=;
        b=W5hObry0l1lmm7ZkRQNxDkt5yil4z0pX3810X/BlbO7UhZZung1nY9snowejgF6Dtd
         EnczSCcTB6Q1l0yyby/s4/sgHouwoQwihTmFsxAYdxjR1L9tyzXsqVSK4Qt7eJan0df7
         DfYXeA2gPG8lhVpghVj6LZgOOGUgggvqJ9o/EcOSEgWlPjT+SXVxOpGje4049nygn99O
         3Usen8an7WMUXuJuGG36VvotEulR2lqOBxGE8OwQDiZJk2mspWmHLi/yIW+Lvs22JZ/l
         3etzWb9oRTLCt4HN/4hHmc6D8AMJmB4oAhfGdHiln8Xpby4WooDsLwXX64LWFYk8Q2GI
         09YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zdq2v4kNGT8fqmSl3qlN88CLTYwnVgsV1XXeYXG6QLM=;
        b=h85YPEfOfRjb4Zd9VoyEhrjpoJt29MErHvtdFsDX0TMIyc8gf9Df+nnPA2ZoNYoCI+
         V4JbAX30rHUXYpwa1OSnCssZ7mX96k2ij5CKwdo3ejRenu72TA0jIdVpyjJMS4/Gjv7e
         n/MSKmJJ5K1TArV0HN8GmaSGEHraHIxWVHl3EjW5JcDeCjkSndFH2KvMCefDheN+CLAP
         Wqw9m6bwoWPDbE9Zvl/0FxQKTWA+ysVh6Yrl1xiJQ8KRj3MV44t5EGjagTEDIOLZq7/q
         WHEed45kuaiBYCZ9eC16EGfA8xjlOQoM0ZowfgEPrkpgPdoLy/Igb7hmJ8zgcmTayqHC
         dNEQ==
X-Gm-Message-State: AOAM531cn3f+VpOLkde8KlUF1Boxy535aYY7i0G8UZZ+Q+7YuM+04H7j
        ynp5coDT9V8wwEDN9MYVFc6HJnHxUj2RPuCjpTjZB9D8XS1Ko90BthfldG+sw6nVeIXOhoq9rna
        U6bMAOl/lB6bhSxnPtUK+PAZQ9frgrcR6+pBVoxa6jnfc66AS5fbCO4Gvee42BTkCqUracgrvc2
        bM
X-Google-Smtp-Source: ABdhPJxt2x9nZvhcVQ6DCVRw57hkXlDk0Ea3xgastPWdgo0hG7Aop3VPGeFjCPbcJRkkuCixF9b5QFeIloRSWjy2bsJ5
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:1cd:: with SMTP id
 196mr16091266pgb.39.1634079452344; Tue, 12 Oct 2021 15:57:32 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:57:23 -0700
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <967680d27aa7a2709e528ff989a9dd534886efba.1634077795.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [RFC PATCH 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a feature that supports config file inclusion conditional on
whether the repo has a remote with a URL that matches a glob.

Similar to my previous work on remote-suggested hooks [1], the main
motivation is to allow remote repo administrators to provide recommended
configs in a way that can be consumed more easily (e.g. through a
package installable by a package manager). But this can also be used by,
say, an individual that wants certain configs to apply to a certain set
of local repos but not others.

I marked this as RFC because there are some design points that need to
be resolved:

 - The existing "include" and "includeIf" instructions are executed
   immediately, whereas in order to be useful, the execution of
   "includeIf hasremoteurl" needs to be delayed until all config files
   are read. Are there better ways to do this?

 - Is the conditionally-included file allowed to have its own
   "include{,If}" instructions? I'm thinking that we should forbid it
   because, for example, if we had 4 files as follows: A includes B and
   C includes D, and we include A and C in our main config (in that
   order), it wouldn't be clear whether B (because A was first included)
   or C (because we should execute everything at the same depth first)
   should be executed first. (In this patch, I didn't do anything about
   includes.)

 - A small one: the exact format of the glob. I probably will treat the
   URL like a path.

[1] https://lore.kernel.org/git/cover.1623881977.git.jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 config.c          | 70 +++++++++++++++++++++++++++++++++++++++++------
 t/t1300-config.sh | 27 ++++++++++++++++++
 2 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index 365d57833b..448509d549 100644
--- a/config.c
+++ b/config.c
@@ -125,8 +125,20 @@ struct config_include_data {
 	config_fn_t fn;
 	void *data;
 	const struct config_options *opts;
+
+	/*
+	 * All remote URLs discovered when reading all config files.
+	 */
+	struct string_list remote_urls;
+
+	/*
+	 * All "includeif.hasremoteurl:" entries. The item is the URL glob and the
+	 * util is the path (must be freed).
+	 */
+	struct string_list include_url_glob_to_path;
 };
-#define CONFIG_INCLUDE_INIT { 0 }
+#define CONFIG_INCLUDE_INIT { .remote_urls = STRING_LIST_INIT_DUP, \
+	.include_url_glob_to_path = STRING_LIST_INIT_DUP }
 
 static int git_config_include(const char *var, const char *value, void *data);
 
@@ -319,10 +331,18 @@ static int include_condition_is_true(const struct config_options *opts,
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
+	const char *remote_name;
+	size_t remote_name_len;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
 
+	if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
+			      &key) &&
+	    remote_name &&
+	    !strcmp(key, "url"))
+		string_list_append(&inc->remote_urls, value);
+
 	/*
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
@@ -335,9 +355,18 @@ static int git_config_include(const char *var, const char *value, void *data)
 		ret = handle_path_include(value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
-	    !strcmp(key, "path"))
-		ret = handle_path_include(value, inc);
+	    cond && !strcmp(key, "path")) {
+		if (skip_prefix_mem(cond, cond_len, "hasremoteurl:", &cond,
+				    &cond_len)) {
+			struct string_list_item *item = string_list_append_nodup(
+				&inc->include_url_glob_to_path,
+				xmemdupz(cond, cond_len));
+			item->util = xstrdup(value);
+			ret = 0;
+		} else if (include_condition_is_true(inc->opts, cond, cond_len)) {
+			ret = handle_path_include(value, inc);
+		}
+	}
 
 	return ret;
 }
@@ -1951,6 +1980,8 @@ int config_with_options(config_fn_t fn, void *data,
 			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
+	int ret;
+	struct string_list_item *glob_item;
 
 	if (opts->respect_includes) {
 		inc.fn = fn;
@@ -1968,17 +1999,40 @@ int config_with_options(config_fn_t fn, void *data,
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
+	}
+
+	for_each_string_list_item(glob_item, &inc.include_url_glob_to_path) {
+		struct strbuf pattern = STRBUF_INIT;
+		struct string_list_item *url_item;
+		int found = 0;
+
+		strbuf_addstr(&pattern, glob_item->string);
+		add_trailing_starstar_for_dir(&pattern);
+		for_each_string_list_item(url_item, &inc.remote_urls) {
+			if (!wildmatch(pattern.buf, url_item->string, WM_PATHNAME)) {
+				found = 1;
+				break;
+			}
+		}
+		strbuf_release(&pattern);
+		if (found) {
+			handle_path_include(glob_item->util, &inc);
+		}
 	}
 
-	return do_git_config_sequence(opts, fn, data);
+	string_list_clear(&inc.remote_urls, 0);
+	string_list_clear(&inc.include_url_glob_to_path, 1);
+	return ret;
 }
 
 static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9ff46f3b04..4803155f89 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2387,4 +2387,31 @@ test_expect_success '--get and --get-all with --fixed-value' '
 	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
 '
 
+test_expect_success 'includeIf.hasremoteurl' '
+	test_create_repo hasremoteurlTest &&
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
 test_done
-- 
2.33.0.882.g93a45727a2-goog

