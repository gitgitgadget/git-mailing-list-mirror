Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A513C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 02:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiFUCFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 22:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiFUCFq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 22:05:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3B515FD5
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 19:05:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e25so13006580wrc.13
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 19:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Bf6PNgPyQRpDfQnouHLZV15FMXcM3Hi+5w4UsJk9ssI=;
        b=L4iyTwbz8RjXgwsPKuVZLuCU4LAaojmiLZ9z0E2XtWg9EMldfHsexfy0d1M6CiWjlz
         d83erixK/G3961+s7HNgN0U5uzPlpCmxmYhLWgsahSosmc5Un4rW2z02LsW0nId34A+i
         g3HFLUmeJzTN5E+AOfcjPNO5L+TY2zgE3n7zG/oZVWNnhWmzx9HqxkrlV0kfms8bpfTf
         9zQqFwyMjzzwbyrqm5AMShDmVCfiONuuzl5pj+7J9xRKvm6N2SUTQv6gsw/IunbcyMM4
         LiJpaOZWa42PjmzzO5abw+LUQM1cpdblYhvzK2v6JspOxRqki/LkdsW5e6RGUxRmDLUl
         Efdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Bf6PNgPyQRpDfQnouHLZV15FMXcM3Hi+5w4UsJk9ssI=;
        b=Bzdc5Dk9lDCNIoZ4qR+obsqArHyxEq/08aXPNBJNyBCCgzEMHzMH1MrjZrIZszyCtf
         jmkls9F7HH4Wrut3Zp3YOjDPCJtnDa6rDihFk8CW6bxVwCLiETJl9VuR1IatJ2G37ggg
         NtNJLOni4LRD5HV8+oQnkUDnwQd/9vGtI74axL1ZDwRKMVymyJtExQoQ2X/gprhziqg+
         7Edpef5RZwO6YmAxQwnA0uFSGcqj4Ak+Tgfzgv7h+SaA/0nZyYgywFvM3d8NG0sEM2Kg
         Ie9RNDQ64RYQBusygKgOsVge/FyLhPCjU/cO1FQBP3io22qCNLGfW+a3LyKqn4Dj4rxj
         HESw==
X-Gm-Message-State: AJIora8MJWv1xjDLm/8pcv41+16tVMX9Tv4YgLuVpXtSLZLK9F0uVPa5
        ZdLZpVUb0GpmiKsfUY/mv75tKUrS8iQo3Q==
X-Google-Smtp-Source: AGRyM1sLnxLxApcWETvY4B+X4C6shHZThaMKhFQ1QrczMjX2k4rwWp7+pgKMpcSVOsC/wTjje0pzIg==
X-Received: by 2002:a05:6000:68a:b0:21b:8157:2712 with SMTP id bo10-20020a056000068a00b0021b81572712mr18550039wrb.250.1655777141636;
        Mon, 20 Jun 2022 19:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bv27-20020a0560001f1b00b0021b84ac7a05sm5100084wrb.0.2022.06.20.19.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 19:05:41 -0700 (PDT)
Message-Id: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jun 2022 02:05:40 +0000
Subject: [PATCH v3] ls-files: introduce "--format" option
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

--format cannot used with -s, -o, -k, --resolve-undo,
--deduplicate and --debug.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files: introduce "--format" options
    
    v2->v3:
    
     1. remove %(tag) because -t is deprecated, suggested by Phillip.
     2. fix some description of atoms in document, suggested by Phillip..

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1262%2Fadlternative%2Fzh%2Fls-file-format-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1262/adlternative/zh/ls-file-format-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1262

Range-diff vs v2:

 1:  67f2c3b8ebe ! 1:  aaafa35ffcd ls-files: introduce "--format" option
     @@ Documentation/git-ls-files.txt: quoted as explained for the configuration variab
      +into the resulting output. For each outputting line, the following
      +names can be used:
      +
     -+tag::
     -+	The tag of file status.
      +objectmode::
     -+	The mode of the object.
     ++	The mode of the file which is in the index.
      +objectname::
     -+	The name of the object.
     ++	The name of the file which is in the index.
      +stage::
     -+	The stage of the file.
     ++	The stage of the file which is in the index.
      +eol::
     -+	The line endings of files.
     ++	The <eolinfo> and <eolattr> of files both in the
     ++	index and the work-tree.
      +path::
     -+	The pathname of the object.
     ++	The pathname of the file which is in the index.
      +ctime::
     -+	The create time of file.
     ++	The create time of file which is in the index.
      +mtime::
     -+	The modify time of file.
     ++	The modified time of file which is in the index.
      +dev::
     -+	The ID of device containing file.
     ++	The ID of device containing file which is in the index.
      +ino::
     -+	The inode number of file.
     ++	The inode number of file which is in the index.
      +uid::
     -+	The user id of file owner.
     ++	The user id of file owner which is in the index.
      +gid::
     -+	The group id of file owner.
     ++	The group id of file owner which is in the index.
      +size::
     -+	The size of the file.
     ++	The size of the file which is in the index.
      +flags::
     -+	The flags of the file.
     ++	The flags of the file in the index which include
     ++	in-memory only flags and some extended on-disk flags.
       
       EXCLUDE PATTERNS
       ----------------
     @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
      +	struct show_index_data *data = context;
      +	const char *end;
      +	const char *p;
     -+	unsigned int errlen;
      +	const struct stat_data *sd = &data->ce->ce_stat_data;
      +	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
      +	if (len)
     @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
      +		      "does not end in ')'"), start);
      +
      +	len = end - start + 1;
     -+	if (skip_prefix(start, "(tag)", &p))
     -+		strbuf_addstr(sb, get_tag(data->ce, data->tag));
     -+	else if (skip_prefix(start, "(objectmode)", &p))
     ++	if (skip_prefix(start, "(objectmode)", &p))
      +		strbuf_addf(sb, "%06o", data->ce->ce_mode);
      +	else if (skip_prefix(start, "(objectname)", &p))
      +		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
     @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
      +		strbuf_addf(sb, "size: %u", sd->sd_size);
      +	else if (skip_prefix(start, "(flags)", &p))
      +		strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
     -+	else {
     -+		errlen = (unsigned long)len;
     -+		die(_("bad ls-files format: %%%.*s"), errlen, start);
     -+	}
     ++	else
     ++		die(_("bad ls-files format: %%%.*s"), (int)len, start);
      +
      +	return len;
      +}
      +
      +static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,
     -+			const char *format, const char *fullname, const char *tag) {
     ++			const char *format, const char *fullname) {
      +
      +	struct show_index_data data = {
     -+		.tag = tag,
      +		.pathname = fullname,
      +		.istate = repo->index,
      +		.ce = ce,
     @@ builtin/ls-files.c: static void show_ce(struct repository *repo, struct dir_stru
       				  S_ISDIR(ce->ce_mode) ||
       				  S_ISGITLINK(ce->ce_mode))) {
      +		if (format) {
     -+			show_ce_fmt(repo, ce, format, fullname, tag);
     ++			show_ce_fmt(repo, ce, format, fullname);
      +			return;
      +		}
      +
     @@ t/t3013-ls-files-format.sh (new)
      +	git commit -m base
      +'
      +
     -+test_expect_success 'git ls-files --format tag' '
     -+	printf "H \nH \n" >expect &&
     -+	git ls-files --format="%(tag)" -t >actual &&
     -+	test_cmp expect actual
     -+'
     -+
      +test_expect_success 'git ls-files --format objectmode' '
      +	cat >expect <<-\EOF &&
      +	100755


 Documentation/git-ls-files.txt |  51 +++++++++++++-
 builtin/ls-files.c             | 124 ++++++++++++++++++++++++++++++++-
 t/t3013-ls-files-format.sh     | 124 +++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+), 4 deletions(-)
 create mode 100755 t/t3013-ls-files-format.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0dabf3f0ddc..39211bde797 100644
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
+	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo` and
+	`--debug`.
 \--::
 	Do not interpret any more arguments as options.
 
@@ -223,6 +230,48 @@ quoted as explained for the configuration variable `core.quotePath`
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
+	The mode of the file which is in the index.
+objectname::
+	The name of the file which is in the index.
+stage::
+	The stage of the file which is in the index.
+eol::
+	The <eolinfo> and <eolattr> of files both in the
+	index and the work-tree.
+path::
+	The pathname of the file which is in the index.
+ctime::
+	The create time of file which is in the index.
+mtime::
+	The modified time of file which is in the index.
+dev::
+	The ID of device containing file which is in the index.
+ino::
+	The inode number of file which is in the index.
+uid::
+	The user id of file owner which is in the index.
+gid::
+	The group id of file owner which is in the index.
+size::
+	The size of the file which is in the index.
+flags::
+	The flags of the file in the index which include
+	in-memory only flags and some extended on-disk flags.
 
 EXCLUDE PATTERNS
 ----------------
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e791b65e7e9..387641b32df 100644
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
@@ -58,8 +60,8 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_eolinfo(struct index_state *istate,
-			  const struct cache_entry *ce, const char *path)
+static void write_eolinfo_internal(struct strbuf *sb, struct index_state *istate,
+				   const struct cache_entry *ce, const char *path)
 {
 	if (show_eol) {
 		struct stat st;
@@ -71,10 +73,25 @@ static void write_eolinfo(struct index_state *istate,
 							       ce->name);
 		if (!lstat(path, &st) && S_ISREG(st.st_mode))
 			w_txt = get_wt_convert_stats_ascii(path);
-		printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
+		if (sb)
+			strbuf_addf(sb, "i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
+		else
+			printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
 	}
 }
 
+static void write_eolinfo(struct index_state *istate,
+			  const struct cache_entry *ce, const char *path)
+{
+	write_eolinfo_internal(NULL, istate, ce, path);
+}
+
+static void write_eolinfo_to_buf(struct strbuf *sb, struct index_state *istate,
+				 const struct cache_entry *ce, const char *path)
+{
+	write_eolinfo_internal(sb, istate, ce, path);
+}
+
 static void write_name(const char *name)
 {
 	/*
@@ -85,6 +102,15 @@ static void write_name(const char *name)
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
@@ -222,6 +248,85 @@ static void show_submodule(struct repository *superproject,
 	repo_clear(&subrepo);
 }
 
+struct show_index_data {
+	const char *tag;
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
+	const struct stat_data *sd = &data->ce->ce_stat_data;
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
+	else if (skip_prefix(start, "(eol)", &p))
+		write_eolinfo_to_buf(sb, data->istate,
+				     data->ce, data->pathname);
+	else if (skip_prefix(start, "(path)", &p))
+		write_name_to_buf(sb, data->pathname);
+	else if (skip_prefix(start, "(ctime)", &p))
+		strbuf_addf(sb, "ctime: %u:%u",
+			    sd->sd_ctime.sec, sd->sd_ctime.nsec);
+	else if (skip_prefix(start, "(mtime)", &p))
+		strbuf_addf(sb, "mtime: %u:%u",
+			    sd->sd_mtime.sec, sd->sd_mtime.nsec);
+	else if (skip_prefix(start, "(dev)", &p))
+		strbuf_addf(sb, "dev: %u", sd->sd_dev);
+	else if (skip_prefix(start, "(ino)", &p))
+		strbuf_addf(sb, "ino: %u", sd->sd_ino);
+	else if (skip_prefix(start, "(uid)", &p))
+		strbuf_addf(sb, "uid: %u", sd->sd_uid);
+	else if (skip_prefix(start, "(gid)", &p))
+		strbuf_addf(sb, "gid: %u", sd->sd_gid);
+	else if (skip_prefix(start, "(size)", &p))
+		strbuf_addf(sb, "size: %u", sd->sd_size);
+	else if (skip_prefix(start, "(flags)", &p))
+		strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
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
@@ -236,6 +341,11 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
+		if (format) {
+			show_ce_fmt(repo, ce, format, fullname);
+			return;
+		}
+
 		tag = get_tag(ce, tag);
 
 		if (!show_stage) {
@@ -675,6 +785,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			 N_("suppress duplicate entries")),
 		OPT_BOOL(0, "sparse", &show_sparse_dirs,
 			 N_("show sparse directories in the presence of a sparse index")),
+		OPT_STRING_F(0, "format", &format, N_("format"),
+			     N_("format to use for the output"),
+			     PARSE_OPT_NONEG),
 		OPT_END()
 	};
 	int ret = 0;
@@ -699,6 +812,11 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	for (i = 0; i < exclude_list.nr; i++) {
 		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
+
+	if (format && (show_stage || show_others || show_killed ||
+		show_resolve_undo || skipping_duplicates || debug_mode))
+			die(_("ls-files --format cannot used with -s, -o, -k, --resolve-undo, --deduplicate, --debug"));
+
 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
new file mode 100755
index 00000000000..8c3ef2df138
--- /dev/null
+++ b/t/t3013-ls-files-format.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+
+test_description='git ls-files --format test'
+
+. ./test-lib.sh
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
+	git ls-files --format="%(objectmode)" -t >actual &&
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
+test_expect_success 'git ls-files --format eol' '
+	printf "i/lf    w/lf    attr/                 \t\n" >expect &&
+	printf "i/lf    w/lf    attr/                 \t\n" >>expect &&
+	git ls-files --format="%(eol)" --eol >actual &&
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
+test_expect_success 'git ls-files --format ctime' '
+	git ls-files --debug >out &&
+	grep ctime out >expect &&
+	git ls-files --format="  %(ctime)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format mtime' '
+	git ls-files --debug >out &&
+	grep mtime out >expect &&
+	git ls-files --format="  %(mtime)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format dev and ino' '
+	git ls-files --debug >out &&
+	grep dev out >expect &&
+	git ls-files --format="  %(dev)%x09%(ino)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format uid and gid' '
+	git ls-files --debug >out &&
+	grep uid out >expect &&
+	git ls-files --format="  %(uid)%x09%(gid)" >actual &&
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
+test_expect_success 'git ls-files --format size and flags' '
+	git ls-files --debug >out &&
+	grep size out >expect &&
+	git ls-files --format="  %(size)%x09%(flags)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format imitate --stage' '
+	git ls-files --stage >expect &&
+	git ls-files --format="%(objectmode) %(objectname) %(stage)%x09%(path)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format imitate --debug' '
+	git ls-files --debug >expect &&
+	git ls-files --format="%(path)%x0a  %(ctime)%x0a  %(mtime)%x0a  %(dev)%x09%(ino)%x0a  %(uid)%x09%(gid)%x0a  %(size)%x09%(flags)" >actual &&
+	test_cmp expect actual
+'
+
+for flag in -s -o -k --resolve-undo --deduplicate --debug
+do
+	test_expect_success "git ls-files --format is incompatible with $flag" '
+		test_must_fail git ls-files --format="%(objectname)" $flag
+	'
+done
+test_done

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget
