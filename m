Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA3C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 06:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiGEGcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 02:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGEGcp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 02:32:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6B9B7CF
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 23:32:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v16so4599633wrd.13
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CDsJlavQt7Ibi8dspUcuJ3U6mtyOGHlxR2PSYxi//HE=;
        b=TKY4c7rhhzTiPpooVuWnpZC/Bp2Fy4r13+Gc9HVbdN37lIf2EpK46W7k+YCxLvE5HB
         be8Ie29Yde22Yrk1SmI0JIjWwdV66LUfhF6MRVux5dIfsVaq1vsdw11N/N6k5Tyepu76
         VaDp9RWny9jIC+jkBLTiAYwaVN51wHbUUVaB5ZSh2Y+19mJ84plYJHodKa+y21uMnPCj
         1Hl/8+HSGsbjbaFXZVT0PfR/vx4BAPbPBipPxXKoHxTLYI+gRijQve7z2Luwnc5FjJ6g
         y7YudNxy/vTfQc/p4irpPx1G+Fn9CteGZqDLEOjJTaqfk0wmAlM6ebzNMzTy6NFSAcS0
         sIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CDsJlavQt7Ibi8dspUcuJ3U6mtyOGHlxR2PSYxi//HE=;
        b=nWccXlGxhYEtLRgvYoWeKCJpEO+zaUW2fZzQm1osa44oqCQnXXy5z9mP40j+E4xGBc
         L0RsebBd96qfUXQAj6cojaz2u1JvDXAYXJjG6SzPBmL9F01vaxhOkO84yJzPGrmVKD5d
         EgTU07zCDcBNHY85nPZ+GqKljBXTDrMACVOdE7S45EJr26YGky36G2uoNhlejMiyy1rm
         iHYKPipaqu6L0Lk0YrIrrwb8H5OGkzH0leiNuBluwrAEW8QJ7yXSWq5t3ba4XIES+zYB
         UkTiEl/ScSATKgBq/HVe2PLhBlZ4uq5zDtLb6dmQUY6luw4BAWyUHB+60GDjoVDP41lf
         jnaw==
X-Gm-Message-State: AJIora/cbpjc5RhQiX38XJlqwWEZyo/5m/AE037qxhylRkdwaK4UiARb
        Ozn/8PKdW/noMB1vLHIuWno5pewXFyw=
X-Google-Smtp-Source: AGRyM1townefx9y7EOsq9UmUIjA3BYq4YvC/5mxtdLo+O3lC/bqUaxlijDPvl7hPIv7TkFygo+Dxig==
X-Received: by 2002:a5d:65c3:0:b0:21b:bca9:83b1 with SMTP id e3-20020a5d65c3000000b0021bbca983b1mr30284609wrw.568.1657002762299;
        Mon, 04 Jul 2022 23:32:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba15-20020a0560001c0f00b0021bae66362esm29043526wrb.58.2022.07.04.23.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 23:32:41 -0700 (PDT)
Message-Id: <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
References: <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jul 2022 06:32:40 +0000
Subject: [PATCH v5] ls-files: introduce "--format" option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add a new option --format that output index enties
informations with custom format, taking inspiration
from the option with the same name in the `git ls-tree`
command.

--format cannot used with -s, -o, -k, -t, --resolve-undo,
--deduplicate and --eol.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files: introduce "--format" options
    
    v4->v5:
    
     1. Let --format incompatible with -t.
     2. Fix %(eolinfo) and %(eolattr) docs suggested by Junio.
    
    Looking forward to Ævar's reviewing.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1262%2Fadlternative%2Fzh%2Fls-file-format-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1262/adlternative/zh/ls-file-format-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1262

Range-diff vs v4:

 1:  6827e44e158 ! 1:  1ce69d6202a ls-files: introduce "--format" option
     @@ Commit message
          from the option with the same name in the `git ls-tree`
          command.
      
     -    --format cannot used with -s, -o, -k, --resolve-undo,
     +    --format cannot used with -s, -o, -k, -t, --resolve-undo,
          --deduplicate and --eol.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ Documentation/git-ls-files.txt: followed by the  ("attr/<eolattr>").
      +	It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
      +	interpolates to character with hex code `xx`; for example `%00`
      +	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
     -+	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo`
     ++	--format cannot be combined with `-s`, `-o`, `-k`, `-t`, `--resolve-undo`
      +	and `--eol`.
       \--::
       	Do not interpret any more arguments as options.
     @@ Documentation/git-ls-files.txt: quoted as explained for the configuration variab
      +stage::
      +	The stage of the file which is recorded in the index.
      +eolinfo:index::
     -+	The <eolinfo> of the file which is recorded in the index.
      +eolinfo:worktree::
     -+	The <eolinfo> of the file which is recorded in the working tree.
     ++	The <eolinfo> (see the description of the `--eol` option) of
     ++	the contents in the index or in the worktree for the path.
      +eolattr::
     -+	The <eolattr> of the file which is recorded in the index.
     ++	The <eolattr> (see the description of the `--eol` option)
     ++	that applies to the path.
      +path::
      +	The pathname of the file which is recorded in the index.
       
     @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
       	}
      +
      +	if (format && (show_stage || show_others || show_killed ||
     -+		show_resolve_undo || skipping_duplicates || show_eol))
     -+			usage_msg_opt("--format cannot used with -s, -o, -k, "
     ++		show_resolve_undo || skipping_duplicates || show_eol || show_tag))
     ++			usage_msg_opt("--format cannot used with -s, -o, -k, -t"
      +				      "--resolve-undo, --deduplicate, --eol",
      +				      ls_files_usage, builtin_ls_files_options);
      +
     @@ t/t3013-ls-files-format.sh (new)
      +TEST_PASSES_SANITIZE_LEAK=true
      +. ./test-lib.sh
      +
     -+for flag in -s -o -k --resolve-undo --deduplicate --eol
     ++for flag in -s -o -k -t --resolve-undo --deduplicate --eol
      +do
      +	test_expect_success "usage: --format is incompatible with $flag" '
      +		test_expect_code 129 git ls-files --format="%(objectname)" $flag
     @@ t/t3013-ls-files-format.sh (new)
      +	100755
      +	100644
      +	EOF
     -+	git ls-files --format="%(objectmode)" -t >actual &&
     ++	git ls-files --format="%(objectmode)" >actual &&
      +	test_cmp expect actual
      +'
      +


 Documentation/git-ls-files.txt |  38 ++++++++++-
 builtin/ls-files.c             | 113 +++++++++++++++++++++++++++++++++
 t/t3013-ls-files-format.sh     | 108 +++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100755 t/t3013-ls-files-format.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0dabf3f0ddc..97d4cebba9f 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--recurse-submodules]
-		[--abbrev[=<n>]] [--] [<file>...]
+		[--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -192,6 +192,13 @@ followed by the  ("attr/<eolattr>").
 	to the contained files. Sparse directories will be shown with a
 	trailing slash, such as "x/" for a sparse directory "x".
 
+--format=<format>::
+	A string that interpolates `%(fieldname)` from the result being shown.
+	It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
+	interpolates to character with hex code `xx`; for example `%00`
+	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
+	--format cannot be combined with `-s`, `-o`, `-k`, `-t`, `--resolve-undo`
+	and `--eol`.
 \--::
 	Do not interpret any more arguments as options.
 
@@ -223,6 +230,35 @@ quoted as explained for the configuration variable `core.quotePath`
 (see linkgit:git-config[1]).  Using `-z` the filename is output
 verbatim and the line is terminated by a NUL byte.
 
+It is possible to print in a custom format by using the `--format`
+option, which is able to interpolate different fields using
+a `%(fieldname)` notation. For example, if you only care about the
+"objectname" and "path" fields, you can execute with a specific
+"--format" like
+
+	git ls-files --format='%(objectname) %(path)'
+
+FIELD NAMES
+-----------
+Various values from structured fields can be used to interpolate
+into the resulting output. For each outputting line, the following
+names can be used:
+
+objectmode::
+	The mode of the file which is recorded in the index.
+objectname::
+	The name of the file which is recorded in the index.
+stage::
+	The stage of the file which is recorded in the index.
+eolinfo:index::
+eolinfo:worktree::
+	The <eolinfo> (see the description of the `--eol` option) of
+	the contents in the index or in the worktree for the path.
+eolattr::
+	The <eolattr> (see the description of the `--eol` option)
+	that applies to the path.
+path::
+	The pathname of the file which is recorded in the index.
 
 EXCLUDE PATTERNS
 ----------------
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e791b65e7e9..79ecdce2c9c 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -11,6 +11,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "builtin.h"
+#include "strbuf.h"
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
@@ -48,6 +49,7 @@ static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
 static int exclude_args;
+static const char *format;
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
@@ -75,6 +77,30 @@ static void write_eolinfo(struct index_state *istate,
 	}
 }
 
+static void write_index_eolinfo_to_buf(struct strbuf *sb, struct index_state *istate,
+				       const struct cache_entry *ce)
+{
+	const char *i_txt = "";
+	if (ce && S_ISREG(ce->ce_mode))
+		i_txt = get_cached_convert_stats_ascii(istate, ce->name);
+	strbuf_addstr(sb, i_txt);
+}
+
+static void write_worktree_eolinfo_to_buf(struct strbuf *sb, const char *path)
+{
+	struct stat st;
+	const char *w_txt = "";
+	if (!lstat(path, &st) && S_ISREG(st.st_mode))
+		w_txt = get_wt_convert_stats_ascii(path);
+	strbuf_addstr(sb, w_txt);
+}
+
+static void write_eolattr_to_buf(struct strbuf *sb, struct index_state *istate,
+				 const char *path)
+{
+	strbuf_addstr(sb, get_convert_attr_ascii(istate, path));
+}
+
 static void write_name(const char *name)
 {
 	/*
@@ -85,6 +111,15 @@ static void write_name(const char *name)
 				   stdout, line_terminator);
 }
 
+static void write_name_to_buf(struct strbuf *sb, const char *name)
+{
+	const char *rel = relative_path(name, prefix_len ? prefix : NULL, sb);
+	if (line_terminator)
+		quote_c_style(rel, sb, NULL, 0);
+	else
+		strbuf_add(sb, rel, strlen(rel));
+}
+
 static const char *get_tag(const struct cache_entry *ce, const char *tag)
 {
 	static char alttag[4];
@@ -222,6 +257,68 @@ static void show_submodule(struct repository *superproject,
 	repo_clear(&subrepo);
 }
 
+struct show_index_data {
+	const char *pathname;
+	struct index_state *istate;
+	const struct cache_entry *ce;
+};
+
+static size_t expand_show_index(struct strbuf *sb, const char *start,
+			       void *context)
+{
+	struct show_index_data *data = context;
+	const char *end;
+	const char *p;
+	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
+	if (len)
+		return len;
+	if (*start != '(')
+		die(_("bad ls-files format: element '%s' "
+		      "does not start with '('"), start);
+
+	end = strchr(start + 1, ')');
+	if (!end)
+		die(_("bad ls-files format: element '%s'"
+		      "does not end in ')'"), start);
+
+	len = end - start + 1;
+	if (skip_prefix(start, "(objectmode)", &p))
+		strbuf_addf(sb, "%06o", data->ce->ce_mode);
+	else if (skip_prefix(start, "(objectname)", &p))
+		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
+	else if (skip_prefix(start, "(stage)", &p))
+		strbuf_addf(sb, "%d", ce_stage(data->ce));
+	else if (skip_prefix(start, "(eolinfo:index)", &p))
+		write_index_eolinfo_to_buf(sb, data->istate, data->ce);
+	else if (skip_prefix(start, "(eolinfo:worktree)", &p))
+		write_worktree_eolinfo_to_buf(sb, data->pathname);
+	else if (skip_prefix(start, "(eolattr)", &p))
+		write_eolattr_to_buf(sb, data->istate, data->pathname);
+	else if (skip_prefix(start, "(path)", &p))
+		write_name_to_buf(sb, data->pathname);
+	else
+		die(_("bad ls-files format: %%%.*s"), (int)len, start);
+
+	return len;
+}
+
+static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,
+			const char *format, const char *fullname) {
+
+	struct show_index_data data = {
+		.pathname = fullname,
+		.istate = repo->index,
+		.ce = ce,
+	};
+
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_expand(&sb, format, expand_show_index, &data);
+	strbuf_addch(&sb, line_terminator);
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+	return;
+}
+
 static void show_ce(struct repository *repo, struct dir_struct *dir,
 		    const struct cache_entry *ce, const char *fullname,
 		    const char *tag)
@@ -236,6 +333,12 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
+		if (format) {
+			show_ce_fmt(repo, ce, format, fullname);
+			print_debug(ce);
+			return;
+		}
+
 		tag = get_tag(ce, tag);
 
 		if (!show_stage) {
@@ -675,6 +778,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			 N_("suppress duplicate entries")),
 		OPT_BOOL(0, "sparse", &show_sparse_dirs,
 			 N_("show sparse directories in the presence of a sparse index")),
+		OPT_STRING_F(0, "format", &format, N_("format"),
+			     N_("format to use for the output"),
+			     PARSE_OPT_NONEG),
 		OPT_END()
 	};
 	int ret = 0;
@@ -699,6 +805,13 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	for (i = 0; i < exclude_list.nr; i++) {
 		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
+
+	if (format && (show_stage || show_others || show_killed ||
+		show_resolve_undo || skipping_duplicates || show_eol || show_tag))
+			usage_msg_opt("--format cannot used with -s, -o, -k, -t"
+				      "--resolve-undo, --deduplicate, --eol",
+				      ls_files_usage, builtin_ls_files_options);
+
 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
new file mode 100755
index 00000000000..60c415aafd6
--- /dev/null
+++ b/t/t3013-ls-files-format.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description='git ls-files --format test'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+for flag in -s -o -k -t --resolve-undo --deduplicate --eol
+do
+	test_expect_success "usage: --format is incompatible with $flag" '
+		test_expect_code 129 git ls-files --format="%(objectname)" $flag
+	'
+done
+
+test_expect_success 'setup' '
+	echo o1 >o1 &&
+	echo o2 >o2 &&
+	git add o1 o2 &&
+	git add --chmod +x o1 &&
+	git commit -m base
+'
+
+test_expect_success 'git ls-files --format objectmode' '
+	cat >expect <<-\EOF &&
+	100755
+	100644
+	EOF
+	git ls-files --format="%(objectmode)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format objectname' '
+	oid1=$(git hash-object o1) &&
+	oid2=$(git hash-object o2) &&
+	cat >expect <<-EOF &&
+	$oid1
+	$oid2
+	EOF
+	git ls-files --format="%(objectname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format eolinfo:index' '
+	cat >expect <<-\EOF &&
+	lf
+	lf
+	EOF
+	git ls-files --format="%(eolinfo:index)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format eolinfo:worktree' '
+	cat >expect <<-\EOF &&
+	lf
+	lf
+	EOF
+	git ls-files --format="%(eolinfo:worktree)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format eolattr' '
+	printf "\n\n" >expect &&
+	git ls-files --format="%(eolattr)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format path' '
+	cat >expect <<-\EOF &&
+	o1
+	o2
+	EOF
+	git ls-files --format="%(path)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with -m' '
+	echo change >o1 &&
+	cat >expect <<-\EOF &&
+	o1
+	EOF
+	git ls-files --format="%(path)" -m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with -d' '
+	echo o3 >o3 &&
+	git add o3 &&
+	rm o3 &&
+	cat >expect <<-\EOF &&
+	o3
+	EOF
+	git ls-files --format="%(path)" -d >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format imitate --stage' '
+	git ls-files --stage >expect &&
+	git ls-files --format="%(objectmode) %(objectname) %(stage)%x09%(path)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with --debug' '
+	git ls-files --debug >expect &&
+	git ls-files --format="%(path)" --debug >actual &&
+	test_cmp expect actual
+'
+
+test_done

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget
