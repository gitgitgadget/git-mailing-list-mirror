Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D090C04FE0
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 23:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjGaXuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 19:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjGaXuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 19:50:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C131FDA
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1851c52f3dso5105283276.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690847393; x=1691452193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKhUecvx+n0CWYwJAHDbzvTBtPHSbIjmafI92mPc288=;
        b=D9/8POwDem3famyBRiyzRYYWMqjWt0UHAiwwb1N7qjmRazbZoi/Jv1IC2QxVVvRgci
         T3+G4NoF0VRWNXd1hFj4z6amXnTwWJQB+toY8rUWerhQTeWLeJWo3PatxjQhFlZws6mB
         ZgG8IVDY1F5ff20VWLZv7Zy8Wk5MTKp0HPP6mZr4Uzo38CcrWpA2bzV9wJGaOP206KvC
         BKqjUbsWjOn7IEC+Uc2gLG9rK3Omtcx3qrHPBOVRE41kp8Bf45MbzxARiuiqF1y5IGra
         iKeLGz8E2WEEecPpSSh2g92GJtgiMnoT71aZIk4P0KIvmWv+AFHgocaGLYf6I00ou0PB
         4woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847393; x=1691452193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKhUecvx+n0CWYwJAHDbzvTBtPHSbIjmafI92mPc288=;
        b=MpXKWxNK3wgFbbtiA4MkMtYmlmTjFsfvZWy/KrXe3Z6BVXq55ZpDNHNCXq8/3T732o
         ebJcCwbII0lDoRZvaX/MuxCfJvxiAsH9D6U40ERFLHnzPT75i68OWQ3wmJN28P46NdGZ
         U3Y+dO0B2a5aMKee2SmeGc68OEGYePRguZHtybcawGre6keu0AAiXA6unQmhkuQrPoKA
         oEoPQsuIwqvWRw3VpQ8uIRwj6JjSweNnoNjouG+VdJpFsSCWWjbM3+IjmlxLzSY1iuBV
         HPhWVChKGBYF75NLZJGhb0Mh7qSIZf6P9v4ZISC+EmguEeEQ57O241/gN9+kMQR6P6Fp
         C1GA==
X-Gm-Message-State: ABy/qLawl4hWeeg3LG2Fiw/Xg/B6LlIKVbYLRMtk5v6MvuKaC9Ls7xHJ
        j4PGdV77zIFTYee9J637OAI1HDeRjIx68yAMCFJ40I0Px+wup93XSxQ2j67MBOD2Di21qczZ8w2
        Uw8B0k/r9Sw6KuIGeBbIDhuYOEnDajDpqQIYDdVdVaISqUcsoDGqHNb0zGM3iCjs=
X-Google-Smtp-Source: APBJJlEEXosT+wCFAFm2LAbz3Gsi0vU2I04X1u0ceYHThsqov4QMI9AMU2ih8UESwWLxQ+OEOxmj7v1v+2Tqdg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:100f:b0:cf9:3564:33cc with SMTP
 id w15-20020a056902100f00b00cf9356433ccmr78908ybt.13.1690847393223; Mon, 31
 Jul 2023 16:49:53 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:46:39 -0700
In-Reply-To: <20230731234910.94149-1-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <20230731234910.94149-1-chooglen@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731234910.94149-3-chooglen@google.com>
Subject: [RFC PATCH v1.5 2/5] config: split out config_parse_options
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"struct config_options" is a disjoint set of options options used by the
config parser (e.g. event listners) and options used by
config_with_options() (e.g. to handle includes, choose which config
files to parse). Split parser-only options into config_parse_options.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 bundle-uri.c |  2 +-
 config.c     | 14 +++++++-------
 config.h     | 37 ++++++++++++++++++++-----------------
 fsck.c       |  2 +-
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 4b5c49b93d..f93ca6a486 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -237,7 +237,7 @@ int bundle_uri_parse_config_format(const char *uri,
 				   struct bundle_list *list)
 {
 	int result;
-	struct config_options opts = {
+	struct config_parse_options opts = {
 		.error_action = CONFIG_ERROR_ERROR,
 	};
 
diff --git a/config.c b/config.c
index ca77ca17a4..dc6cda03aa 100644
--- a/config.c
+++ b/config.c
@@ -983,7 +983,7 @@ static int get_base_var(struct config_source *cs, struct strbuf *name)
 struct parse_event_data {
 	enum config_event_t previous_type;
 	size_t previous_offset;
-	const struct config_options *opts;
+	const struct config_parse_options *opts;
 };
 
 static int do_event(struct config_source *cs, enum config_event_t type,
@@ -1031,7 +1031,7 @@ static void kvi_from_source(struct config_source *cs,
 
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
 			    struct key_value_info *kvi, void *data,
-			    const struct config_options *opts)
+			    const struct config_parse_options *opts)
 {
 	int comment = 0;
 	size_t baselen = 0;
@@ -1968,7 +1968,7 @@ int git_default_config(const char *var, const char *value,
  */
 static int do_config_from(struct config_source *top, config_fn_t fn,
 			  void *data, enum config_scope scope,
-			  const struct config_options *opts)
+			  const struct config_parse_options *opts)
 {
 	struct key_value_info kvi = KVI_INIT;
 	int ret;
@@ -1993,7 +1993,7 @@ static int do_config_from_file(config_fn_t fn,
 			       const enum config_origin_type origin_type,
 			       const char *name, const char *path, FILE *f,
 			       void *data, enum config_scope scope,
-			       const struct config_options *opts)
+			       const struct config_parse_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
@@ -2022,7 +2022,7 @@ static int git_config_from_stdin(config_fn_t fn, void *data,
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 				      void *data, enum config_scope scope,
-				      const struct config_options *opts)
+				      const struct config_parse_options *opts)
 {
 	int ret = -1;
 	FILE *f;
@@ -2048,7 +2048,7 @@ int git_config_from_mem(config_fn_t fn,
 			const enum config_origin_type origin_type,
 			const char *name, const char *buf, size_t len,
 			void *data, enum config_scope scope,
-			const struct config_options *opts)
+			const struct config_parse_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 
@@ -3380,7 +3380,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		struct stat st;
 		size_t copy_begin, copy_end;
 		int i, new_line = 0;
-		struct config_options opts;
+		struct config_parse_options opts;
 
 		if (!value_pattern)
 			store.value_pattern = NULL;
diff --git a/config.h b/config.h
index 40966cb682..b13586307d 100644
--- a/config.h
+++ b/config.h
@@ -85,6 +85,21 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 					struct config_source *cs,
 					void *event_fn_data);
 
+struct config_parse_options {
+	enum config_error_action {
+		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
+		CONFIG_ERROR_DIE, /* die() on error */
+		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
+		CONFIG_ERROR_SILENT, /* return -1 */
+	} error_action;
+	/*
+	 * event_fn and event_fn_data are for internal use only. Handles events
+	 * emitted by the config parser.
+	 */
+	config_parser_event_fn_t event_fn;
+	void *event_fn_data;
+};
+
 struct config_options {
 	unsigned int respect_includes : 1;
 	unsigned int ignore_repo : 1;
@@ -92,6 +107,9 @@ struct config_options {
 	unsigned int ignore_cmdline : 1;
 	unsigned int system_gently : 1;
 
+	const char *commondir;
+	const char *git_dir;
+	struct config_parse_options parse_options;
 	/*
 	 * For internal use. Include all includeif.hasremoteurl paths without
 	 * checking if the repo has that remote URL, and when doing so, verify
@@ -99,21 +117,6 @@ struct config_options {
 	 * themselves.
 	 */
 	unsigned int unconditional_remote_url : 1;
-
-	const char *commondir;
-	const char *git_dir;
-	/*
-	 * event_fn and event_fn_data are for internal use only. Handles events
-	 * emitted by the config parser.
-	 */
-	config_parser_event_fn_t event_fn;
-	void *event_fn_data;
-	enum config_error_action {
-		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
-		CONFIG_ERROR_DIE, /* die() on error */
-		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
-		CONFIG_ERROR_SILENT, /* return -1 */
-	} error_action;
 };
 
 /* Config source metadata for a given config key-value pair */
@@ -178,13 +181,13 @@ int git_config_from_file(config_fn_t fn, const char *, void *);
 
 int git_config_from_file_with_options(config_fn_t fn, const char *,
 				      void *, enum config_scope,
-				      const struct config_options *);
+				      const struct config_parse_options *);
 int git_config_from_mem(config_fn_t fn,
 			const enum config_origin_type,
 			const char *name,
 			const char *buf, size_t len,
 			void *data, enum config_scope scope,
-			const struct config_options *opts);
+			const struct config_parse_options *opts);
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     struct repository *repo,
 			     const struct object_id *oid, void *data,
diff --git a/fsck.c b/fsck.c
index 3be86616c5..522ee1c18a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1219,7 +1219,7 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		return 0;
 
 	if (oidset_contains(&options->gitmodules_found, oid)) {
-		struct config_options config_opts = { 0 };
+		struct config_parse_options config_opts = { 0 };
 		struct fsck_gitmodules_data data;
 
 		oidset_insert(&options->gitmodules_done, oid);
-- 
2.41.0.585.gd2178a4bd4-goog

