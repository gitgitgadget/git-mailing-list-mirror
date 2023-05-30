Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D8C7EE2F
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjE3Smj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjE3Sm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC2E106
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6ef9a928fso32037445e9.3
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472141; x=1688064141;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RmdQ+huunD5hfrFf7TDRqB6p/W9L6glVZFLf5uzLhI=;
        b=Gjob0KR7GpLZyrhgi0QyMOweCFSob8XBwt+YTAcuNsfWFetrG3XByCCMFdCKaIfDeS
         WujkrZ0uVF39lcaxIAxon6QXB54+FB4r30UsiVlcThWmOEs6KorrItcVYKrkL+bNJNE/
         zNADjR3umDuIBuNAI8ZTj563NR5+7TE+hYhxPLPFHBTmtWQaCaVVD5dbCBR59m81/Zvl
         qCAIyixcsxILQkQ8YCUmw8xzgK5g/+4IEBu5LUkYsgGYFi9/0vMNWg/rpy35ZKkNv2us
         IG/Ij2wGJrMzPy8zxz1MNSFiWq3HmckT3Pyz/SSwgeA/6eERi9PsQO6vKoC3PN5lk3fH
         j+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472141; x=1688064141;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RmdQ+huunD5hfrFf7TDRqB6p/W9L6glVZFLf5uzLhI=;
        b=DMG0clTC6lpY13ev8q4YhsJSpEOIo+snsh7g1Hm2IEthwr+cTTOvm0yKpQ6Lz8wSgn
         vZ2dBbcHByjipfpRP50pLgpeg23t55qgw1IYFiSOTkdsGv1gQsr/km6FuMBLR1yNKbtI
         0mDFF/9khJknI8D9DUX/MfipuSpZ6ahFoLDuTzYbhSrkIlCwBfqwcjQFTAu7dfW0pvK8
         cWe+GLFU3r12g68jsDEB0SrLWhb62YGPG4aUbZWJEYaY875DtZ/NKLjNX0hpANWcXcIb
         9caQkqXVGr51hWHtKDnc77qO7BYKRAMn17kvtcifRG43atYoA8h5zhOsdNC5qH7d6/qX
         M5Rg==
X-Gm-Message-State: AC+VfDwSAeO9zvKW5WuSHMBgiYMN5h/hzfEgqWE9ILDt9Jp9LEiZAC/L
        UXJ7kw9c8Sn6ULNksksSlLD9mZpUO6c=
X-Google-Smtp-Source: ACHHUZ4PfWvDXWSXDLN+EG41A1PQSpQjy67I0nN3Cupqp5TD52DD+Ub0LVmOLn6uWdjbCxR5Y+U51g==
X-Received: by 2002:a1c:c902:0:b0:3f6:787:4a70 with SMTP id f2-20020a1cc902000000b003f607874a70mr2191431wmb.15.1685472141511;
        Tue, 30 May 2023 11:42:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003f42461ac75sm21650168wmf.12.2023.05.30.11.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:21 -0700 (PDT)
Message-Id: <f363b16025996f6cf16a683f5e2b3fe3721f4d93.1685472133.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:03 +0000
Subject: [PATCH v2 05/14] (RFC-only) config: finish config_fn_t refactor
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
 16 files changed, 32 insertions(+), 19 deletions(-)

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
index fb12d8040e8..0b794b6f32e 100644
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

