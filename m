Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01219C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48F760FF2
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJ2Rdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 13:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhJ2Rdr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 13:33:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A471C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:31:18 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id y18-20020a17090abd1200b001a4dcd1501cso3555740pjr.4
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eFJ4cJizrjX8YJZ2TyLWGGsugb+oz7Fh9Qhc/kw3izU=;
        b=Q8HxsJ4ZEkONZJZedLtG0lEuneSg8QTddBpCN70iOvwNgARYUsYDgvV9WycpMKRcc8
         xXzJST9FqOC0UP7aLRMIFKB+LfMmr/dZwHkR+0uyXCCLLoqlhws3qhnI9aO5+xq1Cyvs
         W5BAD4lUsRgx5vAhzPZCyDi+MS6guLfgNcbhzet9ziJYFHd70troVmUb3AxIX0Bl3xTj
         5KrZkm98MzimkTCmGSPown12IuJ9Dz0k83cjLBl5lf955vYNEVOMQ2fa13G6DoBHuUsX
         u+T0NUSb3OHZU0XKI1GT2CguDhm8c4FUroJ8G+lbVfxtFu/a8HMADE5JV34EiHDanLNv
         IXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eFJ4cJizrjX8YJZ2TyLWGGsugb+oz7Fh9Qhc/kw3izU=;
        b=z4SpzQN95xXGOx5SnxtU1kR4mRHrvfNnlu9K2EPHqQCqmDUa4Q2BEUjFIcuBP0YQ48
         MJ5IJ1fwG/LTw1W5+hOI0wSBqnCNST72pkw+NG2pyNeDjohjcYkS5NkenMnOzRu1nixB
         6COQOteGcOIJPuJPYW6GZeoOecvD3EkS6/hN5si1Y1C81+Yapjrlm6jwKN3Z7hSwbvbq
         skSDqKFaxaedgtcPAH++YoaMV1RIfOivxace/mGojclWmFIrDe1Da4A4h8hmwbsex6We
         pnJigvEHlBuOmnlpr3oSA+MyOdBHeSibCkqDHKQBf6DueZsMQPJZVGYdsaZHrXcvFuhC
         sTCg==
X-Gm-Message-State: AOAM530q+A7S5obPdp7g5O9znSRMtTgaUsDlMmaFHFsUz9sUUjyKpFFW
        IAVpIP/9mU4UhckBOCbBkLKbUn+Vtnsn5Vmo3QbU1j5GVqoCKACHXrrm44nl4QCpJpIJQNBivwx
        SW/DS4BnEmidQqdkdOOwG5H0d846+Mi3u5MkGYNlaOI/APUcGxcEGhaXNfmBKKXdv3uH51RzgOR
        /G
X-Google-Smtp-Source: ABdhPJyGEMmD0BM7VFZFvhAysQiKFhfa0gigYuH1xhEw802yz85qGVIQnhmYudI4UlDY0lcJ/YCiqQz4pW8YFi6N6nCL
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:e012:: with SMTP id
 u18mr6045398pjy.103.1635528677890; Fri, 29 Oct 2021 10:31:17 -0700 (PDT)
Date:   Fri, 29 Oct 2021 10:31:10 -0700
In-Reply-To: <cover.1635527389.git.jonathantanmy@google.com>
Message-Id: <3c0d51ee39b8e149b5be57b8cd3f8cd403fe49c9.1635527389.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1635527389.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [WIP v2 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a feature that supports config file inclusion conditional on
whether the repo has a remote with a URL that matches a glob.

Similar to my previous work on remote-suggested hooks [1], the main
motivation is to allow remote repo administrators to provide recommended
configs in a way that can be consumed more easily (e.g. through a
package installable by a package manager).

NEEDSWORK: The way this works is that if we see such an include, we
shunt all subsequent configs into a stash (while looking for URLs), then
process the stash. In particular, this means that more memory is needed,
and the nature of error reporting changes (currently, if a callback
returns nonzero for a variable, processing halts immediately, but with
this patch, all the config might be read from disk before the callback
even sees the variable). I'll need to expand on this and write a
documentation section.

One alternative is to rerun the config parsing mechanism upon noticing
the first URL-conditional include in order to find all URLs. This would
require the config files to be read from disk twice, though.

[1] https://lore.kernel.org/git/cover.1623881977.git.jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 config.c          | 132 +++++++++++++++++++++++++++++++++++++++++-----
 t/t1300-config.sh |  60 +++++++++++++++++++++
 2 files changed, 180 insertions(+), 12 deletions(-)

diff --git a/config.c b/config.c
index 94ad5ce913..63a37e0a5d 100644
--- a/config.c
+++ b/config.c
@@ -120,13 +120,30 @@ static long config_buf_ftell(struct config_source *conf)
 	return conf->u.buf.pos;
 }
 
+struct stashed_var {
+	char *var;
+	char *value;
+	int depth;
+
+	char *url;
+};
+
 struct config_include_data {
 	int depth;
 	config_fn_t fn;
 	void *data;
 	const struct config_options *opts;
+
+	/*
+	 * All remote URLs discovered when reading all config files.
+	 */
+	struct string_list remote_urls;
+
+	struct stashed_var *stashed;
+	size_t stashed_nr, stashed_alloc;
+	int current_stash_depth;
 };
-#define CONFIG_INCLUDE_INIT { 0 }
+#define CONFIG_INCLUDE_INIT { .remote_urls = STRING_LIST_INIT_DUP }
 
 static int git_config_include(const char *var, const char *value, void *data);
 
@@ -316,28 +333,110 @@ static int include_condition_is_true(const struct config_options *opts,
 	return 0;
 }
 
+static int execute_stashed(struct config_include_data *inc)
+{
+	size_t i = 0;
+	while (i < inc->stashed_nr) {
+		int ret = inc->fn(inc->stashed[i].var, inc->stashed[i].value,
+				  inc->data);
+		if (ret)
+			return ret;
+
+		/*
+		 * If it is an include, skip to next entry of the same depth if
+		 * the URL doesn't match
+		 */
+		if (inc->stashed[i].url) {
+			struct strbuf pattern = STRBUF_INIT;
+			struct string_list_item *url_item;
+			int found = 0;
+
+			strbuf_addstr(&pattern, inc->stashed[i].url);
+			add_trailing_starstar_for_dir(&pattern);
+			for_each_string_list_item(url_item, &inc->remote_urls) {
+				if (!wildmatch(pattern.buf, url_item->string,
+					       WM_PATHNAME)) {
+					found = 1;
+					break;
+				}
+			}
+			strbuf_release(&pattern);
+			if (found) {
+				i++;
+			} else {
+				int depth = inc->stashed[i].depth;
+
+				i++;
+				while (i < inc->stashed_nr &&
+				       inc->stashed[i].depth != depth)
+					i++;
+			}
+		} else {
+			i++;
+		}
+	}
+	return 0;
+}
+
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
+	const char *remote_name;
+	size_t remote_name_len;
 	const char *cond, *key;
 	size_t cond_len;
-	int ret;
+	int ret = 0;
+
+	if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
+			      &key) &&
+	    remote_name &&
+	    !strcmp(key, "url"))
+		string_list_append(&inc->remote_urls, value);
 
 	/*
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
 	 */
-	ret = inc->fn(var, value, inc->data);
-	if (ret < 0)
-		return ret;
+	if (inc->stashed_nr || starts_with(var, "includeif.hasremoteurl:")) {
+		struct stashed_var *last;
+
+		/*
+		 * Start or continue using the stash. (A false positive on
+		 * "includeif.hasremoteurl:?.path" is fine here - this just
+		 * means that some config variables unnecessarily go through
+		 * the stash before being passed to the callback.)
+		 */
+		ALLOC_GROW_BY(inc->stashed, inc->stashed_nr, 1,
+			      inc->stashed_alloc);
+		last = &inc->stashed[inc->stashed_nr - 1];
+		last->var = xstrdup(var);
+		last->value = xstrdup(value);
+		last->depth = inc->current_stash_depth;
+	} else {
+		ret = inc->fn(var, value, inc->data);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (!strcmp(var, "include.path"))
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
+			inc->stashed[inc->stashed_nr - 1].url =
+				xmemdupz(url, url_len);
+			inc->current_stash_depth++;
+			ret = handle_path_include(value, inc);
+			inc->current_stash_depth--;
+		} else if (include_condition_is_true(inc->opts, cond, cond_len)) {
+			ret = handle_path_include(value, inc);
+		}
+	}
 
 	return ret;
 }
@@ -1933,6 +2032,7 @@ int config_with_options(config_fn_t fn, void *data,
 			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
+	int ret;
 
 	if (opts->respect_includes) {
 		inc.fn = fn;
@@ -1950,17 +2050,25 @@ int config_with_options(config_fn_t fn, void *data,
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
+	if (inc.stashed_nr) {
+		execute_stashed(&inc);
+		inc.stashed_nr = 0;
+	}
+
+	string_list_clear(&inc.remote_urls, 0);
+	return ret;
 }
 
 static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9ff46f3b04..ea15f7fd46 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2387,4 +2387,64 @@ test_expect_success '--get and --get-all with --fixed-value' '
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
+test_expect_success 'includeIf.hasremoteurl respects last-config-wins' '
+	test_create_repo hasremoteurlTestOverride &&
+
+	cat >"$(pwd)"/include-two-three <<-\EOF &&
+	[user]
+		two = included-config
+		three = included-config
+	EOF
+	cat >>hasremoteurlTestOverride/.git/config <<-EOF &&
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
+	git -C hasremoteurlTestOverride config --get user.one >actual &&
+	test_cmp expect-main-config actual &&
+
+	git -C hasremoteurlTestOverride config --get user.two >actual &&
+	test_cmp expect-included-config actual &&
+
+	git -C hasremoteurlTestOverride config --get user.three >actual &&
+	test_cmp expect-main-config actual
+'
+
 test_done
-- 
2.33.1.1089.g2158813163f-goog

