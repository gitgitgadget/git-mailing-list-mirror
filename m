Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D22D7DDD
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562745; cv=none; b=VnvUd9gbDWjQLqFokgdo7gt0IYwIKAGBEu5sJWpWJDGMBYUiU7qiJFgIXOhhZs1klsumY8Kk9Lw1dYE3sbRs2aKXVqfQE4rMoQTub2w6WWE+wP0RsDerShFFJIfORc7KlSrPdczJ+K8DfTrxmojSAAd+udH223R9Kus7fR/Zb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562745; c=relaxed/simple;
	bh=3xJq2LMiMg1hIz3GNeqfpHfkQ8QdtpVABiVZbQUCZnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAAwaPyu854KkOKFXgr3d5+tzPJYU3lCVkTmLZjQxWSE4HKRVMGOO0c9/PUr1O08TBddhtw1Fhvgq1G/IUEOdH3DM+9gIZzHakSPZYzXkt4IMZ+hGCdw43r9JyOEqyXYiHRw88V79+Vs9vtylPw9bS4yiudRaIKaOZYhzuMuQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtHiimYN; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtHiimYN"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3c9660aaa13so55139fac.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760562740; x=1761167540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnmiTawWVWh+gAouOr19oFPA/eGP8r9TDdpMrF0+YTE=;
        b=BtHiimYNaLgHJbEFDHT4HaIQj+pTPGY6vhhukrN57TIdPiqPwB4T7XUp5MmNFKT4SD
         B2f18hmzyfKqf7x7I+H8zRzQF9j6/qXOc3ASUOM2LK7fbwQy7aRJkroVS0FTfzcRi2jn
         mCPL5jez0yAU26fDF89ximt8PDNAQjIRy1jUALuO0mxNFP4jDFXvf90UmKAxpyHWM027
         /Eet0o76QrXV/MmKvy0MJUr/4X27QFkdAWReLqU1Pis45szm09MXFM/5xsCwB7kcmFfV
         T0SJwFP87tuVKsJrnBcX/2YVaobbIoE+Z+h1jOMECNXT5qQ0q5jBmZrn+kT/TcMrkWbi
         QhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562740; x=1761167540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnmiTawWVWh+gAouOr19oFPA/eGP8r9TDdpMrF0+YTE=;
        b=qdkEFbDPAdO/2xmUrX224t66JD22Gb6P57CkJH54zNBveyw4hOHlsZ75G/cTn+uNms
         MVxPKHNU+/SShg7TlRJBDNeicCU3QDhnHmREPmG2ka7js899wunugUkew0Ai0VIu0m4R
         3o6+pkRASNJvxNfvI81Np0yaSyiYFCI/CF+rnNYuqN01IJR2Hb9vAuwa9IIUibDVflRn
         8cqWjt4tBytGlp+4h/57EEbjHhOqgpvJjDqdXtADVha61FV4k+J8zkLSGFk9z3lE8tZS
         JFxiyZ2lXZogqH4+YXrc7DmiiYXi0ZgKXFoROHe1UBvudBaEbnviN81WsiNv5DTj2Vmw
         d0rg==
X-Gm-Message-State: AOJu0YzHNzGfbbyJd8ThLDiq86F9BuNHXwcqcM1OyCybpjH0JYgE0PaR
	6pUJ1afoB64BaZpCaa3UfRFC3JbuyY/PGgPwxg48GrViL53nUhMJOPMfcIFqvQ==
X-Gm-Gg: ASbGncum9ojCBG6a4Cd+xtNF/JjF3Ry5OUOwPO7SxjWe18LjYNlIb+STaJy0+GOc/1w
	f0ZHEMdzIy49mzKAvMIIgWkrC90FJa0AaaasooxOWxCxLmeYsJA5BzQFeY8tcSRMMcL0rno8y4X
	sJb8HJDkBIKBxBqI5CY3WKur4Ah/ODOnfxS03yRF/glwk32xVJQ3j5/AbrAj+4axoXK2IuF6oLw
	1RkgS2O9j3rs6CcpSmCFMqOrhDrLUI4L5T0szbNTgLpr2dMetATvsdX4toYvFi+ws/BGrUH4UwP
	5mvjQHdRHtJ4zMUcZF+K0ci90Nv7mBLBu2e4O/ffNr2f9OufV7AW5sjl7NLh3l0MtUQc/3AOmQJ
	3sHWVkap8sUxgX+tXTVmLAyxHj4L4eU32rF1MZGNo77MrzlXP+2VpsK3wFGIFB2sBbASv91cjNe
	jbmnZH0SBk
X-Google-Smtp-Source: AGHT+IG9u3I6HbOvVJrrBes6vslWXA/gUCjU1sG+kLefA7TctOAnMND+ZtZMbAMR9f9EqS0bOlYnWQ==
X-Received: by 2002:a05:6870:6108:b0:35c:3928:478b with SMTP id 586e51a60fabf-3c0f9e78e9bmr14663975fac.38.1760562739532;
        Wed, 15 Oct 2025 14:12:19 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8eecb2bsm5806932fac.20.2025.10.15.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:12:19 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 0/6] builtin/repo: introduce structure subcommand
Date: Wed, 15 Oct 2025 16:12:07 -0500
Message-ID: <20251015211213.361797-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250927145049.723341-1-jltobler@gmail.com>
References: <20250927145049.723341-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The structure of a repository's history can have huge impacts on the
performance and health of the repository itself. Currently, Git lacks a
means to surface repository metrics regarding its structure/shape via a
single command. Acquiring this information requires users to be familiar
with the relevant data points and the various Git commands required to
surface them. To fill this gap, supplemental tools such as git-sizer(1)
have been developed.

To allow users to more readily identify repository structure related
information, introduce the "structure" subcommand in git-repo(1). The
goal of this subcommand is to eventually provide similar functionality
to git-sizer(1), but natively in Git.

In this initial version, the "structure" subcommand only surfaces counts
of the various reference and object types in a repository. In a
follow-up series, I would like to introduce additional data points that
are present in git-sizer(1) such as largest objects, combined object
sizes by type, and other general repository shape information.

Some other general features that would be nice to introduce eventually:

- A "level of concern" meter for reported stats. This could indicate to
  users which stats may be worth looking into further.
- Links to OIDs of interesting objects that correspond to certain stats.
- Options to limit which references to use when evaluating the
  repository.

Changes since V4:
- The subcommand was renamed from "stats" to "structure". This was done
  to define a more narrow scope for the types of stats that would be
  outtputted. This also also for other types of stat-related subcommands
  to be implemented in the future that may cover different aspects of
  the repository.
- Table column widths are now stored as ints to avoid the unneeded back
  and forth conversions.
- Dropped the clang-format patch as it has been upstreamed separately.
- Updated commit messages accordingly.

Changes since V3:
- Changed from using strlen() to utf8_strlen() to take into
  consideration that translatable strings may have characters that are
  more than one byte.

Changes since V2:
- Added clang-format patch to address false postive triggered in this
  series.
- Use varargs for stats_table_add() family of functions.
- Print to stdout directly instead of using strbuf.
- Add parse_option() earlier in the series.
- Use start_delayed_progress() instead of start_progress().
- Add test to validate --[no-]progress options.
- Some other small fixes.

Changes since V1:
- Translatable terms displayed in the table have formatting separated
  out.
- Squashed the `keyvalue` and `nul` output format patches into one.
- Added a progress meter to provide users with more feedback.
- Updated docs to outline to outline reported data in a bulleted list.
- Combined similar tests together to reduce repetitive setup.
- Added patch to improve ref-filter interface so we don't have to create
  a dummy patterns array.
- Many other renames and cleanups to improve patch clarity.

Thanks,
-Justin

Justin Tobler (6):
  builtin/repo: rename repo_info() to cmd_repo_info()
  ref-filter: allow NULL filter pattern
  builtin/repo: introduce structure subcommand
  builtin/repo: add object counts in structure output
  builtin/repo: add keyvalue and nul format for structure stats
  builtin/repo: add progress meter for structure stats

 Documentation/git-repo.adoc |  30 +++
 builtin/repo.c              | 370 +++++++++++++++++++++++++++++++++++-
 ref-filter.c                |   4 +-
 t/meson.build               |   1 +
 t/t1901-repo-structure.sh   | 129 +++++++++++++
 5 files changed, 529 insertions(+), 5 deletions(-)
 create mode 100755 t/t1901-repo-structure.sh

Range-diff against v4:
1:  ed04168562 = 1:  ed04168562 builtin/repo: rename repo_info() to cmd_repo_info()
2:  6aa76d1323 = 2:  6aa76d1323 ref-filter: allow NULL filter pattern
3:  02a3fcc5fb < -:  ---------- clang-format: exclude control macros from SpaceBeforeParens
4:  8ec9914886 ! 3:  eda1afbe3d builtin/repo: introduce stats subcommand
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    builtin/repo: introduce stats subcommand
    +    builtin/repo: introduce structure subcommand
     
    -    The shape of a repository's history can have huge impacts on the
    +    The structure of a repository's history can have huge impacts on the
         performance and health of the repository itself. Currently, Git lacks a
    -    means to surface key stats/information regarding the shape of a
    -    repository via a single command. Acquiring this information requires
    -    users to be fairly knowledgeable about the structure of a Git repository
    -    and how to identify the relevant data points. To fill this gap,
    -    supplemental tools such as git-sizer(1) have been developed.
    +    means to surface repository metrics regarding its structure/shape via a
    +    single command. Acquiring this information requires users to be familiar
    +    with the relevant data points and the various Git commands required to
    +    surface them. To fill this gap, supplemental tools such as git-sizer(1)
    +    have been developed.
     
    -    To allow users to more readily identify potential issues for a
    -    repository, introduce the "stats" subcommand in git-repo(1) to output
    -    stats for the repository that may be of interest to users. The goal of
    -    this subcommand is to eventually provide similar functionality to
    -    git-sizer(1), but natively in Git.
    +    To allow users to more readily identify repository structure related
    +    information, introduce the "structure" subcommand in git-repo(1). The
    +    goal of this subcommand is to eventually provide similar functionality
    +    to git-sizer(1), but natively in Git.
     
         The initial version of this command only iterates through all references
         in the repository and tracks the count of branches, tags, remote refs,
    @@ Commit message
         to satisfy the requirements of the widest row contained.
     
         Subsequent commits will surface additional relevant data points to
    -    output.
    +    output and also provide other more machine-friendly output formats.
     
         Based-on-patch-by: Derrick Stolee <stolee@gmail.com>
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
    @@ Documentation/git-repo.adoc: SYNOPSIS
      --------
      [synopsis]
      git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
    -+git repo stats
    ++git repo structure
      
      DESCRIPTION
      -----------
    @@ Documentation/git-repo.adoc: supported:
      +
      `-z` is an alias for `--format=nul`.
      
    -+`stats`::
    -+	Retrieve statistics about the current repository. The following kinds
    -+	of information are reported:
    ++`structure`::
    ++	Retrieve statistics about the current repository structure. The
    ++	following kinds of information are reported:
     ++
     +* Reference counts categorized by type
     +
    @@ builtin/repo.c
      
      static const char *const repo_usage[] = {
      	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
    -+	"git repo stats",
    ++	"git repo structure",
      	NULL
      };
      
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +struct stats_table {
     +	struct string_list rows;
     +
    -+	size_t name_col_width;
    -+	size_t value_col_width;
    ++	int name_col_width;
    ++	int value_col_width;
     +};
     +
     +/*
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	struct strbuf buf = STRBUF_INIT;
     +	struct string_list_item *item;
     +	char *formatted_name;
    -+	size_t name_width;
    ++	int name_width;
     +
     +	strbuf_vaddf(&buf, format, ap);
     +	formatted_name = strbuf_detach(&buf, NULL);
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	if (name_width > table->name_col_width)
     +		table->name_col_width = name_width;
     +	if (entry) {
    -+		size_t value_width = utf8_strwidth(entry->value);
    ++		int value_width = utf8_strwidth(entry->value);
     +		if (value_width > table->value_col_width)
     +			table->value_col_width = value_width;
     +	}
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	va_end(ap);
     +}
     +
    -+static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
    ++static void stats_table_setup_structure(struct stats_table *table,
    ++					struct ref_stats *refs)
     +{
     +	size_t ref_total;
     +
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
     +}
     +
    -+static inline size_t max_size_t(size_t a, size_t b)
    ++static void stats_table_print_structure(const struct stats_table *table)
     +{
    -+	return (a > b) ? a : b;
    -+}
    -+
    -+static void stats_table_print(const struct stats_table *table)
    -+{
    -+	const char *name_col_title = _("Repository stats");
    ++	const char *name_col_title = _("Repository structure");
     +	const char *value_col_title = _("Value");
    -+	size_t name_title_len = utf8_strwidth(name_col_title);
    -+	size_t value_title_len = utf8_strwidth(value_col_title);
    ++	int name_col_width = utf8_strwidth(name_col_title);
    ++	int value_col_width = utf8_strwidth(value_col_title);
     +	struct string_list_item *item;
    -+	int name_col_width;
    -+	int value_col_width;
     +
    -+	name_col_width = cast_size_t_to_int(
    -+		max_size_t(table->name_col_width, name_title_len));
    -+	value_col_width = cast_size_t_to_int(
    -+		max_size_t(table->value_col_width, value_title_len));
    ++	if (table->name_col_width > name_col_width)
    ++		name_col_width = table->name_col_width;
    ++	if (table->value_col_width > value_col_width)
    ++		value_col_width = table->value_col_width;
     +
     +	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
     +	       value_col_width, value_col_title);
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	string_list_clear(&table->rows, 1);
     +}
     +
    -+static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
    ++static void structure_count_references(struct ref_stats *stats,
    ++				       struct ref_array *refs)
     +{
     +	for (int i = 0; i < refs->nr; i++) {
     +		struct ref_array_item *ref = refs->items[i];
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	}
     +}
     +
    -+static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    -+			  struct repository *repo UNUSED)
    ++static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    ++			      struct repository *repo UNUSED)
     +{
     +	struct ref_filter filter = REF_FILTER_INIT;
     +	struct stats_table table = {
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
     +		die(_("unable to filter refs"));
     +
    -+	stats_count_references(&stats, &refs);
    ++	structure_count_references(&stats, &refs);
     +
    -+	stats_table_setup(&table, &stats);
    -+	stats_table_print(&table);
    ++	stats_table_setup_structure(&table, &stats);
    ++	stats_table_print_structure(&table);
     +
     +	stats_table_clear(&table);
     +	ref_array_clear(&refs);
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
      	parse_opt_subcommand_fn *fn = NULL;
      	struct option options[] = {
      		OPT_SUBCOMMAND("info", &fn, cmd_repo_info),
    -+		OPT_SUBCOMMAND("stats", &fn, cmd_repo_stats),
    ++		OPT_SUBCOMMAND("structure", &fn, cmd_repo_structure),
      		OPT_END()
      	};
      
    @@ t/meson.build: integration_tests = [
        't1701-racy-split-index.sh',
        't1800-hook.sh',
        't1900-repo.sh',
    -+  't1901-repo-stats.sh',
    ++  't1901-repo-structure.sh',
        't2000-conflict-when-checking-files-out.sh',
        't2002-checkout-cache-u.sh',
        't2003-checkout-cache-mkdir.sh',
     
    - ## t/t1901-repo-stats.sh (new) ##
    + ## t/t1901-repo-structure.sh (new) ##
     @@
     +#!/bin/sh
     +
    -+test_description='test git repo stats'
    ++test_description='test git repo structure'
     +
     +. ./test-lib.sh
     +
    @@ t/t1901-repo-stats.sh (new)
     +	(
     +		cd repo &&
     +		cat >expect <<-\EOF &&
    -+		| Repository stats | Value |
    -+		| ---------------- | ----- |
    -+		| * References     |       |
    -+		|   * Count        |     0 |
    -+		|     * Branches   |     0 |
    -+		|     * Tags       |     0 |
    -+		|     * Remotes    |     0 |
    -+		|     * Others     |     0 |
    ++		| Repository structure | Value |
    ++		| -------------------- | ----- |
    ++		| * References         |       |
    ++		|   * Count            |     0 |
    ++		|     * Branches       |     0 |
    ++		|     * Tags           |     0 |
    ++		|     * Remotes        |     0 |
    ++		|     * Others         |     0 |
     +		EOF
     +
    -+		git repo stats >out 2>err &&
    ++		git repo structure >out 2>err &&
     +
     +		test_cmp expect out &&
     +		test_line_count = 0 err
    @@ t/t1901-repo-stats.sh (new)
     +		git notes add -m foo &&
     +
     +		cat >expect <<-\EOF &&
    -+		| Repository stats | Value |
    -+		| ---------------- | ----- |
    -+		| * References     |       |
    -+		|   * Count        |     4 |
    -+		|     * Branches   |     1 |
    -+		|     * Tags       |     1 |
    -+		|     * Remotes    |     1 |
    -+		|     * Others     |     1 |
    ++		| Repository structure | Value |
    ++		| -------------------- | ----- |
    ++		| * References         |       |
    ++		|   * Count            |     4 |
    ++		|     * Branches       |     1 |
    ++		|     * Tags           |     1 |
    ++		|     * Remotes        |     1 |
    ++		|     * Others         |     1 |
     +		EOF
     +
    -+		git repo stats >out 2>err &&
    ++		git repo structure >out 2>err &&
     +
     +		test_cmp expect out &&
     +		test_line_count = 0 err
5:  584d35f2c7 ! 4:  503af885d3 builtin/repo: add object counts in stats output
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    builtin/repo: add object counts in stats output
    +    builtin/repo: add object counts in structure output
     
         The amount of objects in a repository can provide insight regarding its
         shape. To surface this information, use the path-walk API to count the
    @@ Commit message
     
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: supported:
    - 	of information are reported:
    + 	following kinds of information are reported:
      +
      * Reference counts categorized by type
     +* Reachable object counts categorized by type
    @@ builtin/repo.c: struct ref_stats {
     +	size_t blobs;
     +};
     +
    -+struct repo_stats {
    ++struct repo_structure {
     +	struct ref_stats refs;
     +	struct object_stats objects;
     +};
    @@ builtin/repo.c: static void stats_table_count_addf(struct stats_table *table, si
      	va_end(ap);
      }
      
    --static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
     +static inline size_t get_total_object_count(struct object_stats *stats)
    - {
    ++{
     +	return stats->tags + stats->commits + stats->trees + stats->blobs;
     +}
     +
    -+static void stats_table_setup(struct stats_table *table, struct repo_stats *stats)
    -+{
    + static void stats_table_setup_structure(struct stats_table *table,
    +-					struct ref_stats *refs)
    ++					struct repo_structure *stats)
    + {
     +	struct object_stats *objects = &stats->objects;
     +	struct ref_stats *refs = &stats->refs;
     +	size_t object_total;
      	size_t ref_total;
      
      	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
    -@@ builtin/repo.c: static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
    +@@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *table,
      	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
      	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
      	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
    @@ builtin/repo.c: static void stats_table_setup(struct stats_table *table, struct
     +	stats_table_count_addf(table, objects->tags, "    * %s", _("Tags"));
      }
      
    - static inline size_t max_size_t(size_t a, size_t b)
    -@@ builtin/repo.c: static void stats_count_references(struct ref_stats *stats, struct ref_array *re
    + static void stats_table_print_structure(const struct stats_table *table)
    +@@ builtin/repo.c: static void structure_count_references(struct ref_stats *stats,
      	}
      }
      
    @@ builtin/repo.c: static void stats_count_references(struct ref_stats *stats, stru
     +	return 0;
     +}
     +
    -+static void stats_count_objects(struct object_stats *stats,
    -+				struct ref_array *refs, struct rev_info *revs)
    ++static void structure_count_objects(struct object_stats *stats,
    ++				    struct ref_array *refs,
    ++				    struct rev_info *revs)
     +{
     +	struct path_walk_info info = PATH_WALK_INFO_INIT;
     +
    @@ builtin/repo.c: static void stats_count_references(struct ref_stats *stats, stru
     +	path_walk_info_clear(&info);
     +}
     +
    - static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    --			  struct repository *repo UNUSED)
    -+			  struct repository *repo)
    + static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    +-			      struct repository *repo UNUSED)
    ++			      struct repository *repo)
      {
      	struct ref_filter filter = REF_FILTER_INIT;
      	struct stats_table table = {
      		.rows = STRING_LIST_INIT_DUP,
      	};
     -	struct ref_stats stats = { 0 };
    -+	struct repo_stats stats = { 0 };
    ++	struct repo_structure stats = { 0 };
      	struct ref_array refs = { 0 };
     +	struct rev_info revs;
      	struct option options[] = { 0 };
    @@ builtin/repo.c: static void stats_count_references(struct ref_stats *stats, stru
      	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
      		die(_("unable to filter refs"));
      
    --	stats_count_references(&stats, &refs);
    -+	stats_count_references(&stats.refs, &refs);
    -+	stats_count_objects(&stats.objects, &refs, &revs);
    +-	structure_count_references(&stats, &refs);
    ++	structure_count_references(&stats.refs, &refs);
    ++	structure_count_objects(&stats.objects, &refs, &revs);
      
    - 	stats_table_setup(&table, &stats);
    - 	stats_table_print(&table);
    + 	stats_table_setup_structure(&table, &stats);
    + 	stats_table_print_structure(&table);
      
      	stats_table_clear(&table);
     +	release_revisions(&revs);
    @@ builtin/repo.c: static void stats_count_references(struct ref_stats *stats, stru
      
      	return 0;
     
    - ## t/t1901-repo-stats.sh ##
    -@@ t/t1901-repo-stats.sh: test_expect_success 'empty repository' '
    - 	(
    - 		cd repo &&
    - 		cat >expect <<-\EOF &&
    --		| Repository stats | Value |
    --		| ---------------- | ----- |
    --		| * References     |       |
    --		|   * Count        |     0 |
    --		|     * Branches   |     0 |
    --		|     * Tags       |     0 |
    --		|     * Remotes    |     0 |
    --		|     * Others     |     0 |
    -+		| Repository stats    | Value |
    -+		| ------------------- | ----- |
    -+		| * References        |       |
    -+		|   * Count           |     0 |
    -+		|     * Branches      |     0 |
    -+		|     * Tags          |     0 |
    -+		|     * Remotes       |     0 |
    -+		|     * Others        |     0 |
    -+		|                     |       |
    -+		| * Reachable objects |       |
    -+		|   * Count           |     0 |
    -+		|     * Commits       |     0 |
    -+		|     * Trees         |     0 |
    -+		|     * Blobs         |     0 |
    -+		|     * Tags          |     0 |
    + ## t/t1901-repo-structure.sh ##
    +@@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
    + 		|     * Tags           |     0 |
    + 		|     * Remotes        |     0 |
    + 		|     * Others         |     0 |
    ++		|                      |       |
    ++		| * Reachable objects  |       |
    ++		|   * Count            |     0 |
    ++		|     * Commits        |     0 |
    ++		|     * Trees          |     0 |
    ++		|     * Blobs          |     0 |
    ++		|     * Tags           |     0 |
      		EOF
      
    - 		git repo stats >out 2>err &&
    -@@ t/t1901-repo-stats.sh: test_expect_success 'empty repository' '
    + 		git repo structure >out 2>err &&
    +@@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
      	)
      '
      
    @@ t/t1901-repo-stats.sh: test_expect_success 'empty repository' '
      		git notes add -m foo &&
      
      		cat >expect <<-\EOF &&
    --		| Repository stats | Value |
    --		| ---------------- | ----- |
    --		| * References     |       |
    --		|   * Count        |     4 |
    --		|     * Branches   |     1 |
    --		|     * Tags       |     1 |
    --		|     * Remotes    |     1 |
    --		|     * Others     |     1 |
    -+		| Repository stats    | Value |
    -+		| ------------------- | ----- |
    -+		| * References        |       |
    -+		|   * Count           |     4 |
    -+		|     * Branches      |     1 |
    -+		|     * Tags          |     1 |
    -+		|     * Remotes       |     1 |
    -+		|     * Others        |     1 |
    -+		|                     |       |
    -+		| * Reachable objects |       |
    -+		|   * Count           |   130 |
    -+		|     * Commits       |    43 |
    -+		|     * Trees         |    43 |
    -+		|     * Blobs         |    43 |
    -+		|     * Tags          |     1 |
    +@@ t/t1901-repo-structure.sh: test_expect_success 'repository with references' '
    + 		|     * Tags           |     1 |
    + 		|     * Remotes        |     1 |
    + 		|     * Others         |     1 |
    ++		|                      |       |
    ++		| * Reachable objects  |       |
    ++		|   * Count            |   130 |
    ++		|     * Commits        |    43 |
    ++		|     * Trees          |    43 |
    ++		|     * Blobs          |    43 |
    ++		|     * Tags           |     1 |
      		EOF
      
    - 		git repo stats >out 2>err &&
    + 		git repo structure >out 2>err &&
6:  76975b2eab ! 5:  b336578445 builtin/repo: add keyvalue and nul format for stats
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    builtin/repo: add keyvalue and nul format for stats
    +    builtin/repo: add keyvalue and nul format for structure stats
     
    -    All repository stats are outputted in a human-friendly table form. This
    -    format is not suitable for machine parsing. Add a --format option that
    -    supports three output modes: `table`, `keyvalue`, and `nul`. The `table`
    -    mode is the default format and prints the same table output as before.
    +    All repository structure stats are outputted in a human-friendly table
    +    form. This format is not suitable for machine parsing. Add a --format
    +    option that supports three output modes: `table`, `keyvalue`, and `nul`.
    +    The `table` mode is the default format and prints the same table output
    +    as before.
     
         With the `keyvalue` mode, each line of output contains a key-value pair
         of a repository stat. The '=' character is used to delimit between keys
    @@ Documentation/git-repo.adoc: SYNOPSIS
      --------
      [synopsis]
      git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
    --git repo stats
    -+git repo stats [--format=(table|keyvalue|nul)]
    +-git repo structure
    ++git repo structure [--format=(table|keyvalue|nul)]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-repo.adoc: supported:
      +
      `-z` is an alias for `--format=nul`.
      
    --`stats`::
    -+`stats [--format=(table|keyvalue|nul)]`::
    - 	Retrieve statistics about the current repository. The following kinds
    - 	of information are reported:
    +-`structure`::
    ++`structure [--format=(table|keyvalue|nul)]`::
    + 	Retrieve statistics about the current repository structure. The
    + 	following kinds of information are reported:
      +
     @@ Documentation/git-repo.adoc: supported:
      * Reachable object counts categorized by type
    @@ builtin/repo.c
      
      static const char *const repo_usage[] = {
      	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
    --	"git repo stats",
    -+	"git repo stats [--format=(table|keyvalue|nul)]",
    +-	"git repo structure",
    ++	"git repo structure [--format=(table|keyvalue|nul)]",
      	NULL
      };
      
    @@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
      	string_list_clear(&table->rows, 1);
      }
      
    -+static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
    -+				 char value_delim)
    ++static void structure_keyvalue_print(struct repo_structure *stats,
    ++				     char key_delim, char value_delim)
     +{
     +	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
     +	       (uintmax_t)stats->refs.branches, value_delim);
    @@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
     +	fflush(stdout);
     +}
     +
    - static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
    + static void structure_count_references(struct ref_stats *stats,
    + 				       struct ref_array *refs)
      {
    - 	for (int i = 0; i < refs->nr; i++) {
    -@@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    +@@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
      	struct stats_table table = {
      		.rows = STRING_LIST_INIT_DUP,
      	};
     +	enum output_format format = FORMAT_TABLE;
    - 	struct repo_stats stats = { 0 };
    + 	struct repo_structure stats = { 0 };
      	struct ref_array refs = { 0 };
      	struct rev_info revs;
     -	struct option options[] = { 0 };
    @@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const cha
      
      	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
      	if (argc)
    -@@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    - 	stats_count_references(&stats.refs, &refs);
    - 	stats_count_objects(&stats.objects, &refs, &revs);
    +@@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    + 	structure_count_references(&stats.refs, &refs);
    + 	structure_count_objects(&stats.objects, &refs, &revs);
      
    --	stats_table_setup(&table, &stats);
    --	stats_table_print(&table);
    +-	stats_table_setup_structure(&table, &stats);
    +-	stats_table_print_structure(&table);
     +	switch (format) {
     +	case FORMAT_TABLE:
    -+		stats_table_setup(&table, &stats);
    -+		stats_table_print(&table);
    ++		stats_table_setup_structure(&table, &stats);
    ++		stats_table_print_structure(&table);
     +		break;
     +	case FORMAT_KEYVALUE:
    -+		stats_keyvalue_print(&stats, '=', '\n');
    ++		structure_keyvalue_print(&stats, '=', '\n');
     +		break;
     +	case FORMAT_NUL_TERMINATED:
    -+		stats_keyvalue_print(&stats, '\n', '\0');
    ++		structure_keyvalue_print(&stats, '\n', '\0');
     +		break;
     +	default:
     +		BUG("invalid output format");
    @@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const cha
      	stats_table_clear(&table);
      	release_revisions(&revs);
     
    - ## t/t1901-repo-stats.sh ##
    -@@ t/t1901-repo-stats.sh: test_expect_success 'repository with references and objects' '
    + ## t/t1901-repo-structure.sh ##
    +@@ t/t1901-repo-structure.sh: test_expect_success 'repository with references and objects' '
      	)
      '
      
    @@ t/t1901-repo-stats.sh: test_expect_success 'repository with references and objec
     +		objects.tags.count=1
     +		EOF
     +
    -+		git repo stats --format=keyvalue >out 2>err &&
    ++		git repo structure --format=keyvalue >out 2>err &&
     +
     +		test_cmp expect out &&
     +		test_line_count = 0 err &&
     +
     +		# Replace key and value delimiters for nul format.
     +		tr "\n=" "\0\n" <expect >expect_nul &&
    -+		git repo stats --format=nul >out 2>err &&
    ++		git repo structure --format=nul >out 2>err &&
     +
     +		test_cmp expect_nul out &&
     +		test_line_count = 0 err
7:  1105346a3c ! 6:  70c0b7e200 builtin/repo: add progress meter for stats
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    builtin/repo: add progress meter for stats
    +    builtin/repo: add progress meter for structure stats
     
    -    When using the stats subcommand for git-repo(1), evaluating a repository
    -    may take some time depending on its shape. Add a progress meter to
    -    provide feedback to the user about what is happening. The progress meter
    -    is enabled by default when the command is executed from a tty. It can
    -    also be explicitly enabled/disabled via the --[no-]progress option.
    +    When using the structure subcommand for git-repo(1), evaluating a
    +    repository may take some time depending on its shape. Add a progress
    +    meter to provide feedback to the user about what is happening. The
    +    progress meter is enabled by default when the command is executed from a
    +    tty. It can also be explicitly enabled/disabled via the --[no-]progress
    +    option.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ builtin/repo.c
      #include "quote.h"
      #include "ref-filter.h"
      #include "refs.h"
    -@@ builtin/repo.c: static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
    - 	fflush(stdout);
    +@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
      }
      
    --static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
    -+static void stats_count_references(struct ref_stats *stats, struct ref_array *refs,
    -+				   struct repository *repo, int show_progress)
    + static void structure_count_references(struct ref_stats *stats,
    +-				       struct ref_array *refs)
    ++				       struct ref_array *refs,
    ++				       struct repository *repo,
    ++				       int show_progress)
      {
     +	struct progress *progress = NULL;
     +
    @@ builtin/repo.c: static void stats_keyvalue_print(struct repo_stats *stats, char
      	for (int i = 0; i < refs->nr; i++) {
      		struct ref_array_item *ref = refs->items[i];
      
    -@@ builtin/repo.c: static void stats_count_references(struct ref_stats *stats, struct ref_array *re
    +@@ builtin/repo.c: static void structure_count_references(struct ref_stats *stats,
      		default:
      			BUG("unexpected reference type");
      		}
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
      	return 0;
      }
      
    - static void stats_count_objects(struct object_stats *stats,
    --				struct ref_array *refs, struct rev_info *revs)
    -+				struct ref_array *refs, struct rev_info *revs,
    -+				struct repository *repo, int show_progress)
    + static void structure_count_objects(struct object_stats *stats,
    +-				    struct ref_array *refs,
    +-				    struct rev_info *revs)
    ++				    struct ref_array *refs, struct rev_info *revs,
    ++				    struct repository *repo, int show_progress)
      {
      	struct path_walk_info info = PATH_WALK_INFO_INIT;
     +	struct count_objects_data data = {
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
      
      	for (int i = 0; i < refs->nr; i++) {
      		struct ref_array_item *ref = refs->items[i];
    -@@ builtin/repo.c: static void stats_count_objects(struct object_stats *stats,
    +@@ builtin/repo.c: static void structure_count_objects(struct object_stats *stats,
      		}
      	}
      
    @@ builtin/repo.c: static void stats_count_objects(struct object_stats *stats,
     +	stop_progress(&data.progress);
      }
      
    - static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    -@@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    - 	struct repo_stats stats = { 0 };
    + static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    +@@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    + 	struct repo_structure stats = { 0 };
      	struct ref_array refs = { 0 };
      	struct rev_info revs;
     +	int show_progress = -1;
    @@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const cha
      		OPT_END()
      	};
      
    -@@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    +@@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
      	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
      		die(_("unable to filter refs"));
      
    --	stats_count_references(&stats.refs, &refs);
    --	stats_count_objects(&stats.objects, &refs, &revs);
    +-	structure_count_references(&stats.refs, &refs);
    +-	structure_count_objects(&stats.objects, &refs, &revs);
     +	if (show_progress < 0)
     +		show_progress = isatty(2);
     +
    -+	stats_count_references(&stats.refs, &refs, repo, show_progress);
    -+	stats_count_objects(&stats.objects, &refs, &revs, repo, show_progress);
    ++	structure_count_references(&stats.refs, &refs, repo, show_progress);
    ++	structure_count_objects(&stats.objects, &refs, &revs, repo, show_progress);
      
      	switch (format) {
      	case FORMAT_TABLE:
     
    - ## t/t1901-repo-stats.sh ##
    -@@ t/t1901-repo-stats.sh: test_expect_success 'keyvalue and nul format' '
    + ## t/t1901-repo-structure.sh ##
    +@@ t/t1901-repo-structure.sh: test_expect_success 'keyvalue and nul format' '
      	)
      '
      
    @@ t/t1901-repo-stats.sh: test_expect_success 'keyvalue and nul format' '
     +		cd repo &&
     +		test_commit foo &&
     +
    -+		GIT_PROGRESS_DELAY=0 git repo stats --progress >out 2>err &&
    ++		GIT_PROGRESS_DELAY=0 git repo structure --progress >out 2>err &&
     +
     +		test_file_not_empty out &&
     +		test_grep "Counting references: 100% (2/2), done." err &&
     +		test_grep "Counting objects: 3, done." err &&
     +
    -+		GIT_PROGRESS_DELAY=0 git repo stats --no-progress >out 2>err &&
    ++		GIT_PROGRESS_DELAY=0 git repo structure --no-progress >out 2>err &&
     +
     +		test_file_not_empty out &&
     +		test_line_count = 0 err

base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
-- 
2.51.0.193.g4975ec3473b

