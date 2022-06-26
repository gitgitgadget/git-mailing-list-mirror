Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC662C433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 15:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiFZP3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 11:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiFZP3l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 11:29:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3BBDF74
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 08:29:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so4166260wmb.5
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u8CQUsG7lfgMSoJLX0PD8pUzI1HJbyKfTZdhFy0gXRA=;
        b=HH5zYloSZrtes1oOslQFiGaMntrNPUXCGLR1FzkJ04ZJQiqq0+9+f7SanBW1W3s1Fa
         lbFu+hUqpOJiVDPEATdzG3JsxBdH97j3i6YAor53oL9pH91y9X33kKOXzzUhKTDOW0UM
         ssOLQH5cpHZrfxZpZC9Kc9UAiCMQjzEwaBjj9qNAAulDF6dtVW+hy+xrE1hW/lKfoFbf
         0JP7gWPJr2JiFlHUd2Re9BVFLGoHc1oH737Km1lQuHQhAyEiMEF5FPuEKm6rhMJRdL6A
         JjXgEZg8qHC6CkavFZRNAZiTdfyzZA/QGGGkhKQM5zen+WSgU4ZTmoj4o/+SNjX/P94u
         IVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u8CQUsG7lfgMSoJLX0PD8pUzI1HJbyKfTZdhFy0gXRA=;
        b=gZaTd2SNgLiLHcXTNg7WAKymZ0GMhIu6fpDccbF4roVeEKo//Tk3gHgMKpWQcsts0D
         lyiMGexQiTx+f93LfLIoNu87YerjNQE1JUiNDS65Dc87oSGvhMLU0OzvkwORGLsXQP+1
         AS3x3DHqHpn6eOqcfsL1w9SiCRQqAuRJvT2v6842QVqH/+XSmFKZuN3Cl30mO8r6zqUP
         coq296Vw0TlphHRZSdjDz9PZ4iahYBTZPzMb/JZHr6YdcXs80K0IYlGZdPqlBDi3I4iI
         TSOzVnN81Ifib4iy3rKLD7YmfbjyVfWTiRmJnD1SIH9kZ89/fJ1t3XRtsaJvyJq6HGDy
         tCHg==
X-Gm-Message-State: AJIora9dqTqcrxvBQjyj00bwE+Tyz1jtIhVjVOyBXp5DlT07nYwwZ5zR
        C8pF3nUh3siyCKSU+inm7oZapFc0w6hooQ==
X-Google-Smtp-Source: AGRyM1t58yvQU5GqsTdcFNiE8ygck+yrUM97MwaHdeMwK8uui+CYkcMi2EMrYB65OlfGeBgV+VJpXQ==
X-Received: by 2002:a05:600c:1906:b0:39c:7f82:3090 with SMTP id j6-20020a05600c190600b0039c7f823090mr14850114wmq.152.1656257377588;
        Sun, 26 Jun 2022 08:29:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020a7bcb82000000b0039744bd664esm14021711wmi.13.2022.06.26.08.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 08:29:37 -0700 (PDT)
Message-Id: <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
References: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Jun 2022 15:29:35 +0000
Subject: [PATCH v4] ls-files: introduce "--format" option
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
--deduplicate and --eol.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files: introduce "--format" options
    
    v3->v4:
    
     1. Let --format compatible with --debug.
     2. Let --format incompatible with --eol.
     3. Split %(eol) to three atom: %(eolinfo:index), %(eolinfo:worktree)
        and %(eolattr).
     4. Remove %(ctime), %(mtime), %(dev), %(ino), %(uid), %(gid), %(size),
        %(flags).
     5. Fix output format without some dirty "prefix".
     6. Change some test.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1262%2Fadlternative%2Fzh%2Fls-file-format-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1262/adlternative/zh/ls-file-format-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1262

Range-diff vs v3:

 1:  aaafa35ffcd ! 1:  6827e44e158 ls-files: introduce "--format" option
     @@ Commit message
          command.
      
          --format cannot used with -s, -o, -k, --resolve-undo,
     -    --deduplicate and --debug.
     +    --deduplicate and --eol.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-ls-files.txt: followed by the  ("attr/<eolattr>").
      +	It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
      +	interpolates to character with hex code `xx`; for example `%00`
      +	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
     -+	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo` and
     -+	`--debug`.
     ++	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo`
     ++	and `--eol`.
       \--::
       	Do not interpret any more arguments as options.
       
     @@ Documentation/git-ls-files.txt: quoted as explained for the configuration variab
      +names can be used:
      +
      +objectmode::
     -+	The mode of the file which is in the index.
     ++	The mode of the file which is recorded in the index.
      +objectname::
     -+	The name of the file which is in the index.
     ++	The name of the file which is recorded in the index.
      +stage::
     -+	The stage of the file which is in the index.
     -+eol::
     -+	The <eolinfo> and <eolattr> of files both in the
     -+	index and the work-tree.
     ++	The stage of the file which is recorded in the index.
     ++eolinfo:index::
     ++	The <eolinfo> of the file which is recorded in the index.
     ++eolinfo:worktree::
     ++	The <eolinfo> of the file which is recorded in the working tree.
     ++eolattr::
     ++	The <eolattr> of the file which is recorded in the index.
      +path::
     -+	The pathname of the file which is in the index.
     -+ctime::
     -+	The create time of file which is in the index.
     -+mtime::
     -+	The modified time of file which is in the index.
     -+dev::
     -+	The ID of device containing file which is in the index.
     -+ino::
     -+	The inode number of file which is in the index.
     -+uid::
     -+	The user id of file owner which is in the index.
     -+gid::
     -+	The group id of file owner which is in the index.
     -+size::
     -+	The size of the file which is in the index.
     -+flags::
     -+	The flags of the file in the index which include
     -+	in-memory only flags and some extended on-disk flags.
     ++	The pathname of the file which is recorded in the index.
       
       EXCLUDE PATTERNS
       ----------------
     @@ builtin/ls-files.c: static char *ps_matched;
       
       static const char *tag_cached = "";
       static const char *tag_unmerged = "";
     -@@ builtin/ls-files.c: static const char *tag_modified = "";
     - static const char *tag_skip_worktree = "";
     - static const char *tag_resolve_undo = "";
     - 
     --static void write_eolinfo(struct index_state *istate,
     --			  const struct cache_entry *ce, const char *path)
     -+static void write_eolinfo_internal(struct strbuf *sb, struct index_state *istate,
     -+				   const struct cache_entry *ce, const char *path)
     - {
     - 	if (show_eol) {
     - 		struct stat st;
      @@ builtin/ls-files.c: static void write_eolinfo(struct index_state *istate,
     - 							       ce->name);
     - 		if (!lstat(path, &st) && S_ISREG(st.st_mode))
     - 			w_txt = get_wt_convert_stats_ascii(path);
     --		printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
     -+		if (sb)
     -+			strbuf_addf(sb, "i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
     -+		else
     -+			printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
       	}
       }
       
     -+static void write_eolinfo(struct index_state *istate,
     -+			  const struct cache_entry *ce, const char *path)
     ++static void write_index_eolinfo_to_buf(struct strbuf *sb, struct index_state *istate,
     ++				       const struct cache_entry *ce)
     ++{
     ++	const char *i_txt = "";
     ++	if (ce && S_ISREG(ce->ce_mode))
     ++		i_txt = get_cached_convert_stats_ascii(istate, ce->name);
     ++	strbuf_addstr(sb, i_txt);
     ++}
     ++
     ++static void write_worktree_eolinfo_to_buf(struct strbuf *sb, const char *path)
      +{
     -+	write_eolinfo_internal(NULL, istate, ce, path);
     ++	struct stat st;
     ++	const char *w_txt = "";
     ++	if (!lstat(path, &st) && S_ISREG(st.st_mode))
     ++		w_txt = get_wt_convert_stats_ascii(path);
     ++	strbuf_addstr(sb, w_txt);
      +}
      +
     -+static void write_eolinfo_to_buf(struct strbuf *sb, struct index_state *istate,
     -+				 const struct cache_entry *ce, const char *path)
     ++static void write_eolattr_to_buf(struct strbuf *sb, struct index_state *istate,
     ++				 const char *path)
      +{
     -+	write_eolinfo_internal(sb, istate, ce, path);
     ++	strbuf_addstr(sb, get_convert_attr_ascii(istate, path));
      +}
      +
       static void write_name(const char *name)
     @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
       }
       
      +struct show_index_data {
     -+	const char *tag;
      +	const char *pathname;
      +	struct index_state *istate;
      +	const struct cache_entry *ce;
     @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
      +	struct show_index_data *data = context;
      +	const char *end;
      +	const char *p;
     -+	const struct stat_data *sd = &data->ce->ce_stat_data;
      +	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
      +	if (len)
      +		return len;
     @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
      +		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
      +	else if (skip_prefix(start, "(stage)", &p))
      +		strbuf_addf(sb, "%d", ce_stage(data->ce));
     -+	else if (skip_prefix(start, "(eol)", &p))
     -+		write_eolinfo_to_buf(sb, data->istate,
     -+				     data->ce, data->pathname);
     ++	else if (skip_prefix(start, "(eolinfo:index)", &p))
     ++		write_index_eolinfo_to_buf(sb, data->istate, data->ce);
     ++	else if (skip_prefix(start, "(eolinfo:worktree)", &p))
     ++		write_worktree_eolinfo_to_buf(sb, data->pathname);
     ++	else if (skip_prefix(start, "(eolattr)", &p))
     ++		write_eolattr_to_buf(sb, data->istate, data->pathname);
      +	else if (skip_prefix(start, "(path)", &p))
      +		write_name_to_buf(sb, data->pathname);
     -+	else if (skip_prefix(start, "(ctime)", &p))
     -+		strbuf_addf(sb, "ctime: %u:%u",
     -+			    sd->sd_ctime.sec, sd->sd_ctime.nsec);
     -+	else if (skip_prefix(start, "(mtime)", &p))
     -+		strbuf_addf(sb, "mtime: %u:%u",
     -+			    sd->sd_mtime.sec, sd->sd_mtime.nsec);
     -+	else if (skip_prefix(start, "(dev)", &p))
     -+		strbuf_addf(sb, "dev: %u", sd->sd_dev);
     -+	else if (skip_prefix(start, "(ino)", &p))
     -+		strbuf_addf(sb, "ino: %u", sd->sd_ino);
     -+	else if (skip_prefix(start, "(uid)", &p))
     -+		strbuf_addf(sb, "uid: %u", sd->sd_uid);
     -+	else if (skip_prefix(start, "(gid)", &p))
     -+		strbuf_addf(sb, "gid: %u", sd->sd_gid);
     -+	else if (skip_prefix(start, "(size)", &p))
     -+		strbuf_addf(sb, "size: %u", sd->sd_size);
     -+	else if (skip_prefix(start, "(flags)", &p))
     -+		strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
      +	else
      +		die(_("bad ls-files format: %%%.*s"), (int)len, start);
      +
     @@ builtin/ls-files.c: static void show_ce(struct repository *repo, struct dir_stru
       				  S_ISGITLINK(ce->ce_mode))) {
      +		if (format) {
      +			show_ce_fmt(repo, ce, format, fullname);
     ++			print_debug(ce);
      +			return;
      +		}
      +
     @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
       	}
      +
      +	if (format && (show_stage || show_others || show_killed ||
     -+		show_resolve_undo || skipping_duplicates || debug_mode))
     -+			die(_("ls-files --format cannot used with -s, -o, -k, --resolve-undo, --deduplicate, --debug"));
     ++		show_resolve_undo || skipping_duplicates || show_eol))
     ++			usage_msg_opt("--format cannot used with -s, -o, -k, "
     ++				      "--resolve-undo, --deduplicate, --eol",
     ++				      ls_files_usage, builtin_ls_files_options);
      +
       	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
       		tag_cached = "H ";
     @@ t/t3013-ls-files-format.sh (new)
      +
      +test_description='git ls-files --format test'
      +
     ++TEST_PASSES_SANITIZE_LEAK=true
      +. ./test-lib.sh
      +
     ++for flag in -s -o -k --resolve-undo --deduplicate --eol
     ++do
     ++	test_expect_success "usage: --format is incompatible with $flag" '
     ++		test_expect_code 129 git ls-files --format="%(objectname)" $flag
     ++	'
     ++done
     ++
      +test_expect_success 'setup' '
      +	echo o1 >o1 &&
      +	echo o2 >o2 &&
     @@ t/t3013-ls-files-format.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --format eol' '
     -+	printf "i/lf    w/lf    attr/                 \t\n" >expect &&
     -+	printf "i/lf    w/lf    attr/                 \t\n" >>expect &&
     -+	git ls-files --format="%(eol)" --eol >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git ls-files --format path' '
     ++test_expect_success 'git ls-files --format eolinfo:index' '
      +	cat >expect <<-\EOF &&
     -+	o1
     -+	o2
     ++	lf
     ++	lf
      +	EOF
     -+	git ls-files --format="%(path)" >actual &&
     ++	git ls-files --format="%(eolinfo:index)" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --format ctime' '
     -+	git ls-files --debug >out &&
     -+	grep ctime out >expect &&
     -+	git ls-files --format="  %(ctime)" >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git ls-files --format mtime' '
     -+	git ls-files --debug >out &&
     -+	grep mtime out >expect &&
     -+	git ls-files --format="  %(mtime)" >actual &&
     ++test_expect_success 'git ls-files --format eolinfo:worktree' '
     ++	cat >expect <<-\EOF &&
     ++	lf
     ++	lf
     ++	EOF
     ++	git ls-files --format="%(eolinfo:worktree)" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --format dev and ino' '
     -+	git ls-files --debug >out &&
     -+	grep dev out >expect &&
     -+	git ls-files --format="  %(dev)%x09%(ino)" >actual &&
     ++test_expect_success 'git ls-files --format eolattr' '
     ++	printf "\n\n" >expect &&
     ++	git ls-files --format="%(eolattr)" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --format uid and gid' '
     -+	git ls-files --debug >out &&
     -+	grep uid out >expect &&
     -+	git ls-files --format="  %(uid)%x09%(gid)" >actual &&
     ++test_expect_success 'git ls-files --format path' '
     ++	cat >expect <<-\EOF &&
     ++	o1
     ++	o2
     ++	EOF
     ++	git ls-files --format="%(path)" >actual &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t3013-ls-files-format.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --format size and flags' '
     -+	git ls-files --debug >out &&
     -+	grep size out >expect &&
     -+	git ls-files --format="  %(size)%x09%(flags)" >actual &&
     -+	test_cmp expect actual
     -+'
     -+
      +test_expect_success 'git ls-files --format imitate --stage' '
      +	git ls-files --stage >expect &&
      +	git ls-files --format="%(objectmode) %(objectname) %(stage)%x09%(path)" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --format imitate --debug' '
     ++test_expect_success 'git ls-files --format with --debug' '
      +	git ls-files --debug >expect &&
     -+	git ls-files --format="%(path)%x0a  %(ctime)%x0a  %(mtime)%x0a  %(dev)%x09%(ino)%x0a  %(uid)%x09%(gid)%x0a  %(size)%x09%(flags)" >actual &&
     ++	git ls-files --format="%(path)" --debug >actual &&
      +	test_cmp expect actual
      +'
      +
     -+for flag in -s -o -k --resolve-undo --deduplicate --debug
     -+do
     -+	test_expect_success "git ls-files --format is incompatible with $flag" '
     -+		test_must_fail git ls-files --format="%(objectname)" $flag
     -+	'
     -+done
      +test_done


 Documentation/git-ls-files.txt |  37 ++++++++++-
 builtin/ls-files.c             | 113 +++++++++++++++++++++++++++++++++
 t/t3013-ls-files-format.sh     | 108 +++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+), 1 deletion(-)
 create mode 100755 t/t3013-ls-files-format.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0dabf3f0ddc..38e81cc889f 100644
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
+	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo`
+	and `--eol`.
 \--::
 	Do not interpret any more arguments as options.
 
@@ -223,6 +230,34 @@ quoted as explained for the configuration variable `core.quotePath`
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
+	The <eolinfo> of the file which is recorded in the index.
+eolinfo:worktree::
+	The <eolinfo> of the file which is recorded in the working tree.
+eolattr::
+	The <eolattr> of the file which is recorded in the index.
+path::
+	The pathname of the file which is recorded in the index.
 
 EXCLUDE PATTERNS
 ----------------
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e791b65e7e9..1d52f5cb90b 100644
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
+		show_resolve_undo || skipping_duplicates || show_eol))
+			usage_msg_opt("--format cannot used with -s, -o, -k, "
+				      "--resolve-undo, --deduplicate, --eol",
+				      ls_files_usage, builtin_ls_files_options);
+
 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
new file mode 100755
index 00000000000..a186fe21126
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
+for flag in -s -o -k --resolve-undo --deduplicate --eol
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
