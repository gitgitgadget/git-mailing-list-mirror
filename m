Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E210F20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdAWUgH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:36:07 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35967 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdAWUf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:59 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so43793676pfu.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=owFPSyMolPZmJIEwH9PYFVDqp11yP3FT5lUpOnHgiXY=;
        b=YbsjdA5s2vYWR+z01SGYYcnsTjjfj5B7sArCZdyE2l9oKZOfw+26u+fUevBneIPQUG
         uRT/Qo86Nsg+Ei52F+ZXio1QcMfNjlcQgupkJuv7aCUzI1Jb3I64tZS3WMuXHUMAuuVQ
         pzKf2kms2fTudYMlSo4KWEExefkp16CzdUJnGITboLz2h63qMG3CqO8CXJVmjh2QWimI
         BOTzOAHtvofneO25CDvbKzVzdHUnqKWHCGJKBASbjtYrMFdJZ8Fuuc8f1DrdP3WxtK5U
         rj08HWpO3SBP6N1Nm/aEQwaHVi+NzFP+0OkhxHCjg1TXBq5q1H/6KAk+QkHU6M+lBCgj
         ojPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=owFPSyMolPZmJIEwH9PYFVDqp11yP3FT5lUpOnHgiXY=;
        b=Ge+P8foo72d49Ku6Cexw1McJvXgrHwAGUIL8tCUj48V2CfkuFP9Yqv6jgDfR9p/FE0
         ZlkJYok7djzlTb1Ua4YDXHKVw2hCfXv15cFDq5+HzJDhqexalrr7S05ivecCtiBEdJxw
         wfYsyrg55rwE6tUpWYZieOd0C1v8fQO1B2COsP7Vpv5zsJ1XupyKbujJf/UjRm4MHbwT
         pXcnQbv0T9XLO7ZXb7VVaAmVZ5AzcToaeg7Ub5Ry/yYqTArljh8dTAOnsM/Hjp2ffBvq
         Z2IwaLd5eU/qmcLDgGkF9Im9/MSok2WRUHSPv2R+/XH5uNt102AKEcna0WhAXuzPoZG5
         0OZg==
X-Gm-Message-State: AIkVDXKM1yJfDw68J8M8M9HDHqQ/exeWs2f2w0Kvcw8KE/3ieBTgDajhoUZQOkHcOrM4Mpai
X-Received: by 10.98.133.11 with SMTP id u11mr34446259pfd.132.1485203758180;
        Mon, 23 Jan 2017 12:35:58 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:56 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 14/27] attr: rename function and struct related to checking attributes
Date:   Mon, 23 Jan 2017 12:35:12 -0800
Message-Id: <20170123203525.185058-15-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The traditional API to check attributes is to prepare an N-element
array of "struct git_attr_check" and pass N and the array to the
function "git_check_attr()" as arguments.

In preparation to revamp the API to pass a single structure, in
which these N elements are held, rename the type used for these
individual array elements to "struct attr_check_item" and rename
the function to "git_check_attrs()".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 archive.c              |  6 +++---
 attr.c                 | 12 ++++++------
 attr.h                 |  8 ++++----
 builtin/check-attr.c   | 19 ++++++++++---------
 builtin/pack-objects.c |  6 +++---
 convert.c              | 12 ++++++------
 ll-merge.c             | 10 +++++-----
 userdiff.c             |  4 ++--
 ws.c                   |  6 +++---
 9 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/archive.c b/archive.c
index 01751e574..b76bd4691 100644
--- a/archive.c
+++ b/archive.c
@@ -87,7 +87,7 @@ void *sha1_file_to_archive(const struct archiver_args *args,
 	return buffer;
 }
 
-static void setup_archive_check(struct git_attr_check *check)
+static void setup_archive_check(struct attr_check_item *check)
 {
 	static struct git_attr *attr_export_ignore;
 	static struct git_attr *attr_export_subst;
@@ -123,7 +123,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
-	struct git_attr_check check[2];
+	struct attr_check_item check[2];
 	const char *path_without_prefix;
 	int err;
 
@@ -138,7 +138,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	path_without_prefix = path.buf + args->baselen;
 
 	setup_archive_check(check);
-	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
+	if (!git_check_attrs(path_without_prefix, ARRAY_SIZE(check), check)) {
 		if (ATTR_TRUE(check[0].value))
 			return 0;
 		args->convert = ATTR_TRUE(check[1].value);
diff --git a/attr.c b/attr.c
index 50e5ee393..2f180d609 100644
--- a/attr.c
+++ b/attr.c
@@ -56,7 +56,7 @@ static struct git_attr *(git_attr_hash[HASHSIZE]);
 static int cannot_trust_maybe_real;
 
 /* NEEDSWORK: This will become per git_attr_check */
-static struct git_attr_check *check_all_attr;
+static struct attr_check_item *check_all_attr;
 
 const char *git_attr_name(const struct git_attr *attr)
 {
@@ -713,7 +713,7 @@ static int macroexpand_one(int attr_nr, int rem);
 
 static int fill_one(const char *what, struct match_attr *a, int rem)
 {
-	struct git_attr_check *check = check_all_attr;
+	struct attr_check_item *check = check_all_attr;
 	int i;
 
 	for (i = a->num_attr - 1; 0 < rem && 0 <= i; i--) {
@@ -778,7 +778,7 @@ static int macroexpand_one(int nr, int rem)
  * collected. Otherwise all attributes are collected.
  */
 static void collect_some_attrs(const char *path, int num,
-			       struct git_attr_check *check)
+			       struct attr_check_item *check)
 
 {
 	struct attr_stack *stk;
@@ -806,7 +806,7 @@ static void collect_some_attrs(const char *path, int num,
 		rem = 0;
 		for (i = 0; i < num; i++) {
 			if (!check[i].attr->maybe_real) {
-				struct git_attr_check *c;
+				struct attr_check_item *c;
 				c = check_all_attr + check[i].attr->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
@@ -821,7 +821,7 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-int git_check_attr(const char *path, int num, struct git_attr_check *check)
+int git_check_attrs(const char *path, int num, struct attr_check_item *check)
 {
 	int i;
 
@@ -837,7 +837,7 @@ int git_check_attr(const char *path, int num, struct git_attr_check *check)
 	return 0;
 }
 
-int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
+int git_all_attrs(const char *path, int *num, struct attr_check_item **check)
 {
 	int i, count, j;
 
diff --git a/attr.h b/attr.h
index 00d7a662c..efc7bb3b3 100644
--- a/attr.h
+++ b/attr.h
@@ -20,11 +20,11 @@ extern const char git_attr__false[];
 #define ATTR_UNSET(v) ((v) == NULL)
 
 /*
- * Send one or more git_attr_check to git_check_attr(), and
+ * Send one or more git_attr_check to git_check_attrs(), and
  * each 'value' member tells what its value is.
  * Unset one is returned as NULL.
  */
-struct git_attr_check {
+struct attr_check_item {
 	const struct git_attr *attr;
 	const char *value;
 };
@@ -36,7 +36,7 @@ struct git_attr_check {
  */
 extern const char *git_attr_name(const struct git_attr *);
 
-int git_check_attr(const char *path, int, struct git_attr_check *);
+int git_check_attrs(const char *path, int, struct attr_check_item *);
 
 /*
  * Retrieve all attributes that apply to the specified path.  *num
@@ -45,7 +45,7 @@ int git_check_attr(const char *path, int, struct git_attr_check *);
  * objects describing the attributes and their values.  *check must be
  * free()ed by the caller.
  */
-int git_all_attrs(const char *path, int *num, struct git_attr_check **check);
+int git_all_attrs(const char *path, int *num, struct attr_check_item **check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 53a5a18c1..889264a5b 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -24,8 +24,8 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void output_attr(int cnt, struct git_attr_check *check,
-	const char *file)
+static void output_attr(int cnt, struct attr_check_item *check,
+			const char *file)
 {
 	int j;
 	for (j = 0; j < cnt; j++) {
@@ -51,14 +51,15 @@ static void output_attr(int cnt, struct git_attr_check *check,
 	}
 }
 
-static void check_attr(const char *prefix, int cnt,
-	struct git_attr_check *check, const char *file)
+static void check_attr(const char *prefix,
+		       int cnt, struct attr_check_item *check,
+		       const char *file)
 {
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
-		if (git_check_attr(full_path, cnt, check))
-			die("git_check_attr died");
+		if (git_check_attrs(full_path, cnt, check))
+			die("git_check_attrs died");
 		output_attr(cnt, check, file);
 	} else {
 		if (git_all_attrs(full_path, &cnt, &check))
@@ -69,8 +70,8 @@ static void check_attr(const char *prefix, int cnt,
 	free(full_path);
 }
 
-static void check_attr_stdin_paths(const char *prefix, int cnt,
-	struct git_attr_check *check)
+static void check_attr_stdin_paths(const char *prefix,
+				   int cnt, struct attr_check_item *check)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -99,7 +100,7 @@ static NORETURN void error_with_usage(const char *msg)
 
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
-	struct git_attr_check *check;
+	struct attr_check_item *check;
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8841f8b36..8b8fbd814 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -894,7 +894,7 @@ static void write_pack_file(void)
 			written, nr_result);
 }
 
-static void setup_delta_attr_check(struct git_attr_check *check)
+static void setup_delta_attr_check(struct attr_check_item *check)
 {
 	static struct git_attr *attr_delta;
 
@@ -906,10 +906,10 @@ static void setup_delta_attr_check(struct git_attr_check *check)
 
 static int no_try_delta(const char *path)
 {
-	struct git_attr_check check[1];
+	struct attr_check_item check[1];
 
 	setup_delta_attr_check(check);
-	if (git_check_attr(path, ARRAY_SIZE(check), check))
+	if (git_check_attrs(path, ARRAY_SIZE(check), check))
 		return 0;
 	if (ATTR_FALSE(check->value))
 		return 1;
diff --git a/convert.c b/convert.c
index 4e17e45ed..1b9829279 100644
--- a/convert.c
+++ b/convert.c
@@ -1028,7 +1028,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static enum crlf_action git_path_check_crlf(struct git_attr_check *check)
+static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
 
@@ -1045,7 +1045,7 @@ static enum crlf_action git_path_check_crlf(struct git_attr_check *check)
 	return CRLF_UNDEFINED;
 }
 
-static enum eol git_path_check_eol(struct git_attr_check *check)
+static enum eol git_path_check_eol(struct attr_check_item *check)
 {
 	const char *value = check->value;
 
@@ -1058,7 +1058,7 @@ static enum eol git_path_check_eol(struct git_attr_check *check)
 	return EOL_UNSET;
 }
 
-static struct convert_driver *git_path_check_convert(struct git_attr_check *check)
+static struct convert_driver *git_path_check_convert(struct attr_check_item *check)
 {
 	const char *value = check->value;
 	struct convert_driver *drv;
@@ -1071,7 +1071,7 @@ static struct convert_driver *git_path_check_convert(struct git_attr_check *chec
 	return NULL;
 }
 
-static int git_path_check_ident(struct git_attr_check *check)
+static int git_path_check_ident(struct attr_check_item *check)
 {
 	const char *value = check->value;
 
@@ -1093,7 +1093,7 @@ static const char *conv_attr_name[] = {
 static void convert_attrs(struct conv_attrs *ca, const char *path)
 {
 	int i;
-	static struct git_attr_check ccheck[NUM_CONV_ATTRS];
+	static struct attr_check_item ccheck[NUM_CONV_ATTRS];
 
 	if (!ccheck[0].attr) {
 		for (i = 0; i < NUM_CONV_ATTRS; i++)
@@ -1102,7 +1102,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
+	if (!git_check_attrs(path, NUM_CONV_ATTRS, ccheck)) {
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
 			ca->crlf_action = git_path_check_crlf(ccheck + 0);
diff --git a/ll-merge.c b/ll-merge.c
index ad8be42f9..198f07aca 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -336,13 +336,13 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 	return &ll_merge_drv[LL_TEXT_MERGE];
 }
 
-static int git_path_check_merge(const char *path, struct git_attr_check check[2])
+static int git_path_check_merge(const char *path, struct attr_check_item check[2])
 {
 	if (!check[0].attr) {
 		check[0].attr = git_attr("merge");
 		check[1].attr = git_attr("conflict-marker-size");
 	}
-	return git_check_attr(path, 2, check);
+	return git_check_attrs(path, 2, check);
 }
 
 static void normalize_file(mmfile_t *mm, const char *path)
@@ -362,7 +362,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *theirs, const char *their_label,
 	     const struct ll_merge_options *opts)
 {
-	static struct git_attr_check check[2];
+	static struct attr_check_item check[2];
 	static const struct ll_merge_options default_opts;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
@@ -398,12 +398,12 @@ int ll_merge(mmbuffer_t *result_buf,
 
 int ll_merge_marker_size(const char *path)
 {
-	static struct git_attr_check check;
+	static struct attr_check_item check;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
 	if (!check.attr)
 		check.attr = git_attr("conflict-marker-size");
-	if (!git_check_attr(path, 1, &check) && check.value) {
+	if (!git_check_attrs(path, 1, &check) && check.value) {
 		marker_size = atoi(check.value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/userdiff.c b/userdiff.c
index 2125d6da2..b0b44467a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -263,7 +263,7 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 struct userdiff_driver *userdiff_find_by_path(const char *path)
 {
 	static struct git_attr *attr;
-	struct git_attr_check check;
+	struct attr_check_item check;
 
 	if (!attr)
 		attr = git_attr("diff");
@@ -271,7 +271,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 
 	if (!path)
 		return NULL;
-	if (git_check_attr(path, 1, &check))
+	if (git_check_attrs(path, 1, &check))
 		return NULL;
 
 	if (ATTR_TRUE(check.value))
diff --git a/ws.c b/ws.c
index ea4b2b1df..fbd876e84 100644
--- a/ws.c
+++ b/ws.c
@@ -71,7 +71,7 @@ unsigned parse_whitespace_rule(const char *string)
 	return rule;
 }
 
-static void setup_whitespace_attr_check(struct git_attr_check *check)
+static void setup_whitespace_attr_check(struct attr_check_item *check)
 {
 	static struct git_attr *attr_whitespace;
 
@@ -82,10 +82,10 @@ static void setup_whitespace_attr_check(struct git_attr_check *check)
 
 unsigned whitespace_rule(const char *pathname)
 {
-	struct git_attr_check attr_whitespace_rule;
+	struct attr_check_item attr_whitespace_rule;
 
 	setup_whitespace_attr_check(&attr_whitespace_rule);
-	if (!git_check_attr(pathname, 1, &attr_whitespace_rule)) {
+	if (!git_check_attrs(pathname, 1, &attr_whitespace_rule)) {
 		const char *value;
 
 		value = attr_whitespace_rule.value;
-- 
2.11.0.483.g087da7b7c-goog

