Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B4AC77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjDUTN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjDUTNt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C0B30CD
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f173af665fso14264345e9.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104407; x=1684696407;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a85yV2tGCqUGpf5WRbk6k+FSe/9Q/9V+mQyzN/o9oI=;
        b=XMGDGcbEd2/DoquF9rcKr3fc0HTi7hB9bqmKUQbFK+uiJlRr7n4BnGoljU4kvR9eP7
         EeYV5b5uFqwvjqEQO2jOWECX75kzg43kQ1TIaBQA+L9vhspdFzz4fH9EHqym6VaDi9oY
         /AsMWiT6P5HLtsLkyuHk3KyaQN2b+oj7lTtt8OSr1WasK3/EjGJ+1FAHrJo0DG0gJ07O
         74itkclUpUDgjDyhVHE8G0e2gsR8quryQ03w8v2y8vcSbjeoIFqo8WZ1V5DqegR+fJJP
         vDXusHb14/PTS/M5iNtS1HHnI0r+VAE4q+TsLuNwORWJWh0XJqqT8MpfRsNYhDVgt8Un
         pnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104407; x=1684696407;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2a85yV2tGCqUGpf5WRbk6k+FSe/9Q/9V+mQyzN/o9oI=;
        b=I2eYQL+8rK4Ph2VymTFznsaQV9lB+Os44ByWonumsoCa65uk9BWz1WuYyCFn/LhYMR
         b2FIt+9Sv/JGVRsZpnbXsR++BtRIg5IEDOuYNbc/INuqEAWqtWcjOZ2Oe1L2Vavz6CKr
         yOJvsTOzB5MRFa+J+u5FSWRgYo4PI4ckKszhiDiRGv7F1JRBq3MvZbkuVUCR0EODpyiq
         HY55hMsfP6uyoK8oDeH3IRQPUNAkEqs/GpmjHLkQPX/0mGFHO57wIyjf9LlxAufbKC9d
         Ra/O4v48Umuo8/WR4sxRT+9wEMzTIrBftoV+/PoE4eNsSHZC315V2CS2nTkhAtBjAzs0
         UAyA==
X-Gm-Message-State: AAQBX9dSTM24rLLo5F3cY9ECwcxYgMQ6ZpRd3ZoTTiaI7KeQqUGIf0pP
        3rpr3bSZ2++K4/LRdJGyAUJLbVsLG68=
X-Google-Smtp-Source: AKy350Z96r7R+v3K5oMmTT8g3bVWxe1cGL7Iqfj99MPYJbfFnpPOzZiJlLwgHN3dMZbAHQzfwY4J/g==
X-Received: by 2002:a7b:c38e:0:b0:3f1:718d:a21c with SMTP id s14-20020a7bc38e000000b003f1718da21cmr2759321wmj.31.1682104406702;
        Fri, 21 Apr 2023 12:13:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b002efb2d861dasm4991407wrj.77.2023.04.21.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:26 -0700 (PDT)
Message-Id: <1071e70c92892166e1ed2cf22bcd7eb49bdf3b20.1682104399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:14 +0000
Subject: [PATCH 10/14] (RFC-only) config: finish config_fn_t refactor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Here's an exhaustive list of all of the changes:

* Cases that need a judgement call

  - trace2/tr2_cfg.c:tr2_cfg_set_fl()

    This function needs to account for tr2_cfg_cb() now using "kvi".
    Since this is only called (indirectly) by git_config_set(), config
    source information has never been available here, so just pass NULL.
    It will be tr2_cfg_cb()'s responsibility to not use "kvi".

  - builtin/checkout.c:checkout_main()

    This calls git_xmerge_config() as a shorthand for parsing a CLI arg.
    "kvi" doesn't apply, so just pass NULL. This might be worth
    refactoring away, since git_xmerge_config() can call
    git_default_config().

  - config.c:git_config_include()

    Replace the local "kvi" variable with the "kvi" parameter. This
    makes config_include_data.config_reader obsolete, so remove it.

* Hard for cocci to catch

  - urlmatch.c

    Manually refactor the custom config callbacks in "struct
    urlmatch_config".

  - diff.h, fsck.h, grep.h, ident.h, xdiff-interface.h

    "struct key_value_info" hasn't been defined yet, so forward declare
    it. Alternatively, maybe these files should "#include config.h".

* Likely deficiencies in .cocci patch

  - submodule-config.c:gitmodules_cb()

    Manually refactor a parse_config() call that gets missed because it
    uses a different "*data" arg.

  - grep.h, various

    Manually refactor grep_config() calls. Not sure why these don't get
    picked up.

  - config.c:git_config_include(), http.c:http_options()

    Manually add "kvi" where it was missed. Not sure why they get missed.

  - builtin/clone.c:write_one_config()

    Manually refactor a git_clone_config() call. Probably got missed
    because I didn't include git_config_parse_parameter().

  - ident.h

    Remove the UNUSED attribute. Not sure why this is the only instance
    of this.

  - git-compat-util.h, compat/mingw.[h|c]

    Manually refactor noop_core_config(), platform_core_config() and
    mingw_core_config(). I can probably add these as "manual fixups" in
    cocci.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/checkout.c | 2 +-
 builtin/clone.c    | 4 ++--
 builtin/grep.c     | 2 +-
 compat/mingw.c     | 3 ++-
 compat/mingw.h     | 4 +++-
 config.c           | 5 +----
 diff.h             | 1 +
 fsck.h             | 1 +
 git-compat-util.h  | 2 ++
 grep.c             | 6 +++---
 grep.h             | 4 +++-
 http.c             | 5 +++--
 ident.h            | 3 ++-
 submodule-config.c | 4 ++--
 trace2/tr2_cfg.c   | 2 +-
 urlmatch.c         | 6 +++---
 xdiff-interface.h  | 2 ++
 17 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 92017ba6696..9641423dc2f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1687,7 +1687,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	if (opts->conflict_style) {
 		opts->merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
+		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL, NULL);
 	}
 	if (opts->force) {
 		opts->discard_changes = 1;
diff --git a/builtin/clone.c b/builtin/clone.c
index 1e1cf104194..e654757c45d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -791,14 +791,14 @@ static int git_clone_config(const char *k, const char *v,
 }
 
 static int write_one_config(const char *key, const char *value,
-			    struct key_value_info *kvi UNUSED, void *data)
+			    struct key_value_info *kvi, void *data)
 {
 	/*
 	 * give git_clone_config a chance to write config values back to the
 	 * environment, since git_config_set_multivar_gently only deals with
 	 * config-file writes
 	 */
-	int apply_failed = git_clone_config(key, value, data);
+	int apply_failed = git_clone_config(key, value, kvi, data);
 	if (apply_failed)
 		return apply_failed;
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 177befc3ed4..6e795f9f3a2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -290,7 +290,7 @@ static int wait_all(void)
 static int grep_cmd_config(const char *var, const char *value,
 			   struct key_value_info *kvi, void *cb)
 {
-	int st = grep_config(var, value, cb);
+	int st = grep_config(var, value, kvi, cb);
 
 	if (git_color_config(var, value, cb) < 0)
 		st = -1;
diff --git a/compat/mingw.c b/compat/mingw.c
index 94c5a1daa40..c8181469a2f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -242,7 +242,8 @@ static int core_restrict_inherited_handles = -1;
 static enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 static char *unset_environment_variables;
 
-int mingw_core_config(const char *var, const char *value, void *cb)
+int mingw_core_config(const char *var, const char *value,
+		      struct key_value_info *kvi UNUSED, void *cb)
 {
 	if (!strcmp(var, "core.hidedotfiles")) {
 		if (value && !strcasecmp(value, "dotgitonly"))
diff --git a/compat/mingw.h b/compat/mingw.h
index 209cf7cebad..4f2b489b883 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -11,7 +11,9 @@ typedef _sigset_t sigset_t;
 #undef _POSIX_THREAD_SAFE_FUNCTIONS
 #endif
 
-int mingw_core_config(const char *var, const char *value, void *cb);
+struct key_value_info;
+int mingw_core_config(const char *var, const char *value,
+		      struct key_value_info *, void *cb);
 #define platform_core_config mingw_core_config
 
 /*
diff --git a/config.c b/config.c
index 60f8c0c666b..aa183f6f244 100644
--- a/config.c
+++ b/config.c
@@ -147,7 +147,6 @@ struct config_include_data {
 	void *data;
 	const struct config_options *opts;
 	struct git_config_source *config_source;
-	struct config_reader *config_reader;
 
 	/*
 	 * All remote URLs discovered when reading all config files.
@@ -433,10 +432,9 @@ static int include_condition_is_true(struct key_value_info *kvi,
 static int kvi_fn(config_fn_t fn, const char *key, const char *value,
 		  struct key_value_info *kvi, void *data);
 static int git_config_include(const char *var, const char *value,
-			      struct key_value_info *kvi UNUSED, void *data)
+			      struct key_value_info *kvi, void *data)
 {
 	struct config_include_data *inc = data;
-	struct key_value_info *kvi = inc->config_reader->config_kvi;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -2252,7 +2250,6 @@ int config_with_options(config_fn_t fn, void *data,
 		inc.data = data;
 		inc.opts = opts;
 		inc.config_source = config_source;
-		inc.config_reader = &the_reader;
 		fn = git_config_include;
 		data = &inc;
 	}
diff --git a/diff.h b/diff.h
index 6a3efa63753..2ceb0fd2d66 100644
--- a/diff.h
+++ b/diff.h
@@ -532,6 +532,7 @@ void free_diffstat_info(struct diffstat_t *diffstat);
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg);
 
+struct key_value_info;
 int git_diff_basic_config(const char *var, const char *value,
 			  struct key_value_info *kvi, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
diff --git a/fsck.h b/fsck.h
index a06f202576c..914e67a067d 100644
--- a/fsck.h
+++ b/fsck.h
@@ -233,6 +233,7 @@ void fsck_put_object_name(struct fsck_options *options,
 const char *fsck_describe_object(struct fsck_options *options,
 				 const struct object_id *oid);
 
+struct key_value_info;
 /*
  * git_config() callback for use by fsck-y tools that want to support
  * fsck.<msg> fsck.skipList etc.
diff --git a/git-compat-util.h b/git-compat-util.h
index 4a200a9fb41..6812b592c15 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,8 +440,10 @@ typedef uintmax_t timestamp_t;
 #endif
 
 #ifndef platform_core_config
+struct key_value_info;
 static inline int noop_core_config(const char *var UNUSED,
 				   const char *value UNUSED,
+				   struct key_value_info *kvi UNUSED,
 				   void *cb UNUSED)
 {
 	return 0;
diff --git a/grep.c b/grep.c
index 1516b0689d0..2d3b9bf5d92 100644
--- a/grep.c
+++ b/grep.c
@@ -55,7 +55,7 @@ define_list_config_array_extra(color_grep_slots, {"match"});
  * the grep_defaults template.
  */
 int grep_config(const char *var, const char *value,
-		struct key_value_info *kvi UNUSED, void *cb)
+		struct key_value_info *kvi, void *cb)
 {
 	struct grep_opt *opt = cb;
 	const char *slot;
@@ -90,9 +90,9 @@ int grep_config(const char *var, const char *value,
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value);
 	if (!strcmp(var, "color.grep.match")) {
-		if (grep_config("color.grep.matchcontext", value, cb) < 0)
+		if (grep_config("color.grep.matchcontext", value, kvi, cb) < 0)
 			return -1;
-		if (grep_config("color.grep.matchselected", value, cb) < 0)
+		if (grep_config("color.grep.matchselected", value, kvi, cb) < 0)
 			return -1;
 	} else if (skip_prefix(var, "color.grep.", &slot)) {
 		int i = LOOKUP_CONFIG(color_grep_slots, slot);
diff --git a/grep.h b/grep.h
index c59592e3bdb..6d2fb0ada54 100644
--- a/grep.h
+++ b/grep.h
@@ -202,7 +202,9 @@ struct grep_opt {
 	.output = std_output, \
 }
 
-int grep_config(const char *var, const char *value, void *);
+struct key_value_info;
+int grep_config(const char *var, const char *value, struct key_value_info *kvi,
+		void *);
 void grep_init(struct grep_opt *, struct repository *repo);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
diff --git a/http.c b/http.c
index d5d82c5230f..3d4292eba6a 100644
--- a/http.c
+++ b/http.c
@@ -361,7 +361,8 @@ static void process_curl_messages(void)
 	}
 }
 
-static int http_options(const char *var, const char *value, void *cb)
+static int http_options(const char *var, const char *value,
+			struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp("http.version", var)) {
 		return git_config_string(&curl_http_version, var, value);
@@ -532,7 +533,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	/* Fall back on the default ones */
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, kvi, cb);
 }
 
 static int curl_empty_auth_enabled(void)
diff --git a/ident.h b/ident.h
index f55db41ff99..4e3bd347c52 100644
--- a/ident.h
+++ b/ident.h
@@ -62,7 +62,8 @@ const char *fmt_name(enum want_ident);
 int committer_ident_sufficiently_given(void);
 int author_ident_sufficiently_given(void);
 
+struct key_value_info;
 int git_ident_config(const char *, const char *,
-		     struct key_value_info *UNUSED, void *);
+		     struct key_value_info *, void *);
 
 #endif
diff --git a/submodule-config.c b/submodule-config.c
index 522c9cd3213..7d773f33621 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -675,7 +675,7 @@ out:
 }
 
 static int gitmodules_cb(const char *var, const char *value,
-			 struct key_value_info *kvi UNUSED, void *data)
+			 struct key_value_info *kvi, void *data)
 {
 	struct repository *repo = data;
 	struct parse_config_parameter parameter;
@@ -685,7 +685,7 @@ static int gitmodules_cb(const char *var, const char *value,
 	parameter.gitmodules_oid = null_oid();
 	parameter.overwrite = 1;
 
-	return parse_config(var, value, &parameter);
+	return parse_config(var, value, kvi, &parameter);
 }
 
 void repo_read_gitmodules(struct repository *repo, int skip_if_read)
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 6871258d468..8ed139c69f4 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -146,5 +146,5 @@ void tr2_cfg_set_fl(const char *file, int line, const char *key,
 	struct tr2_cfg_data data = { file, line };
 
 	if (tr2_cfg_load_patterns() > 0)
-		tr2_cfg_cb(key, value, &data);
+		tr2_cfg_cb(key, value, NULL, &data);
 }
diff --git a/urlmatch.c b/urlmatch.c
index 47683974d8c..c94500b61b3 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -552,7 +552,7 @@ static int cmp_matches(const struct urlmatch_item *a,
 }
 
 int urlmatch_config_entry(const char *var, const char *value,
-			  struct key_value_info *kvi UNUSED, void *cb)
+			  struct key_value_info *kvi, void *cb)
 {
 	struct string_list_item *item;
 	struct urlmatch_config *collect = cb;
@@ -566,7 +566,7 @@ int urlmatch_config_entry(const char *var, const char *value,
 
 	if (!skip_prefix(var, collect->section, &key) || *(key++) != '.') {
 		if (collect->cascade_fn)
-			return collect->cascade_fn(var, value, cb);
+			return collect->cascade_fn(var, value, kvi, cb);
 		return 0; /* not interested */
 	}
 	dot = strrchr(key, '.');
@@ -610,7 +610,7 @@ int urlmatch_config_entry(const char *var, const char *value,
 	strbuf_addstr(&synthkey, collect->section);
 	strbuf_addch(&synthkey, '.');
 	strbuf_addstr(&synthkey, key);
-	retval = collect->collect_fn(synthkey.buf, value, collect->cb);
+	retval = collect->collect_fn(synthkey.buf, value, kvi, collect->cb);
 
 	strbuf_release(&synthkey);
 	return retval;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index c1676b11702..749cdf77579 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -50,6 +50,8 @@ int buffer_is_binary(const char *ptr, unsigned long size);
 
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 void xdiff_clear_find_func(xdemitconf_t *xecfg);
+
+struct key_value_info;
 int git_xmerge_config(const char *var, const char *value,
 		      struct key_value_info *kvi, void *cb);
 extern int git_xmerge_style;
-- 
gitgitgadget

