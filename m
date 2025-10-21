Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A057221FDA
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071198; cv=none; b=jTbZ04rec2JFO8RQj12W8EFD2pzEBvBRbyyd8zrTXA9c7Mb+vQafSbu3bvOY0iwWQ7oQsd9WGvs6/zYKMmX5JRNVbKwzM6jpk3LMedzvQC5ooj3TFGpQRPVd9q6+ukyI0qoSYtDZQls1isq19yzkMjgFHBGwNWSWV2jidCibFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071198; c=relaxed/simple;
	bh=lAsgdvIeSLkjZEZvtphBuH+kdr+66VyuAs5209jvjSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuR6Tg03qW2J+KRrZHgUFhq7jXxafxLeBGUZWAypLPy5d892JxWY3sbbtIjZq1EVX8Bg7aUPZaZPxO9S7RJVz1aynKEe2buJao9Zr8Y5awAVb2qJpa3oDh+QLjRQ5HPVn3dH5zuv2sR36bufelvaE7uXaO6VgAq8V+dh1R3hnfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrlmbuZO; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrlmbuZO"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c2846c961fso3138181a34.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071195; x=1761675995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KyV+PIQLv3Rh6io9qJjReIMjfjngnsYx7YP9cqHlmw=;
        b=UrlmbuZOC2CinpYK17bS4z3AcWZ1Gq2mc7dZDQdCn1D5e2Rvb8Ncf6jsKZwoXo5QGM
         31mKTXdyKnNM1E8wmc/XH7uPnl/ejqG/RNVv3WduWXccIjZ8zgbraPdi96gnUYtI68Ba
         BnDpdyrZ9bl+dVoMHfANg3J0oXjhxNr9a+e9pS89fvBV6rX7n7ItDVfdxhh6NQK3WIaF
         KuTK5kUw774r98CDtNHXknyQlTgS3ZP5sOc3/Ymi5ceQ9KPHl94B9/IceIIcacnHfc8V
         ug6C9iewaUw2XyKpgiQQoQo+gVEC4G0DxTMxloVUaq+LR8qs+g0KkbYXuTXLIjC+SvFf
         vUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071195; x=1761675995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KyV+PIQLv3Rh6io9qJjReIMjfjngnsYx7YP9cqHlmw=;
        b=ZtF59b84j3WapNCaMiYpYMCP+HpLRWbY9u5HHMYXmIec0iO2jcnEWFecTJq5jfYlO3
         487IrABcHTXgJhO3HFIHCN3mZhn+5WJ92H4PPsPLq+gSiNXzZ397/GtPivK6olXl3OjV
         I3beHZzsOoPczL+DTHa04/OdU1YICK7rBHATdB6nRsFnxipwmu9QKy9wAzQJntLVMdvN
         jHl6Hve6Stt9x3iZh87hfFvkA184vAHvdv8hPw1ZheThQzKVCrAEhMCggzQu8jZu186g
         h7A0C+wgh1cVPQCH4A2XhDFLoeP6LXlSY0+bHvlT6+lkTYY7gV7pW+aMqnaKBign33C/
         Jexg==
X-Gm-Message-State: AOJu0YxVioiFNNL7D2kw6b4jN+1fg3cj/+mh3yrFdTo8Rm5ENz6Fivcd
	yVgJChPNvUypmmehpfe7NjRpGutJImINPescoUhXaCfzuTC1HKsuVQDFXz6VeQ==
X-Gm-Gg: ASbGncvbJIcMTELS2X/demw8mC2gaYhUlNoHE/JgFeU6z1ZtdYvRe7S/5Vuk2LF8TCa
	pmzW2tZQG6LS5UNomwOF8+tKadH8/GiVodrQLj2P9NcWQZpNc1dHOoGYdV61rAByhNGEAcy5RG5
	uYaUG7pxFGzzlPHH6aVWWZXL2/rLYP4L3c95GBrWUS6VXu8e3AF1cieYV2mCq8OGOvF6U3hK9m3
	qDfsS+qfl852GDylfnWcctZizmGE1TXMr85DannkXHbGyigqIMMrDUEyAMCokhEgQdPje9lAQhp
	WJHLrbd7kGw2NkBjnbRyB8N7vWwwZPzj9hfb89GCkTOInopznMVqhMVMldFcn5g15gsmza9YMq5
	E/uIgv4hA4sI2ZssEi3vUycR6WQ6dASUNDULtRcu3ZuiXF3o+02WfUqHDeSeF/7OZ2yNDcKidTK
	YaE78ji+go
X-Google-Smtp-Source: AGHT+IFrFVIGSv1SxgHXqCWLYK8o+d3aqsxtYPmR9nQNh20TMgtdkrzkL2kSOnUyvdU8UxoY3ersew==
X-Received: by 2002:a05:6808:23c6:b0:43d:2d6f:bbb1 with SMTP id 5614622812f47-443a30de2cdmr6644989b6e.37.1761071194956;
        Tue, 21 Oct 2025 11:26:34 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2795853b6e.24.2025.10.21.11.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:26:34 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 0/7] builtin/repo: introduce structure subcommand
Date: Tue, 21 Oct 2025 13:25:54 -0500
Message-ID: <20251021182601.2687284-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251015211213.361797-1-jltobler@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
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

Changes since V5:
- Instead of using `filter_refs()` to get an array of all references, we
  now use `refs_for_each_ref()` to count references, and setup OIDs for
  the path walk, in place. Doing this not only allows us to avoid
  wasting memory storing all the reference info, but also to display
  progress info to the user while iterating across the references
  initially.
- Add a prepatory patch to export `ref_kind_from_refname()` via
  "ref_filter.h" so we can reuse logic to categorize references while
  counting.

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

Justin Tobler (7):
  builtin/repo: rename repo_info() to cmd_repo_info()
  ref-filter: allow NULL filter pattern
  ref-filter: export ref_kind_from_refname()
  builtin/repo: introduce structure subcommand
  builtin/repo: add object counts in structure output
  builtin/repo: add keyvalue and nul format for structure stats
  builtin/repo: add progress meter for structure stats

 Documentation/git-repo.adoc |  30 +++
 builtin/repo.c              | 380 +++++++++++++++++++++++++++++++++++-
 ref-filter.c                |   6 +-
 ref-filter.h                |   2 +
 t/meson.build               |   1 +
 t/t1901-repo-structure.sh   | 129 ++++++++++++
 6 files changed, 542 insertions(+), 6 deletions(-)
 create mode 100755 t/t1901-repo-structure.sh

Range-diff against v5:
1:  ed04168562 = 1:  ed04168562 builtin/repo: rename repo_info() to cmd_repo_info()
2:  6aa76d1323 = 2:  6aa76d1323 ref-filter: allow NULL filter pattern
-:  ---------- > 3:  aee696c69b ref-filter: export ref_kind_from_refname()
3:  eda1afbe3d ! 4:  4ad599d0ec builtin/repo: introduce structure subcommand
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	va_end(ap);
     +}
     +
    ++static inline size_t get_total_reference_count(struct ref_stats *stats)
    ++{
    ++	return stats->branches + stats->remotes + stats->tags + stats->others;
    ++}
    ++
     +static void stats_table_setup_structure(struct stats_table *table,
     +					struct ref_stats *refs)
     +{
     +	size_t ref_total;
     +
    -+	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
    ++	ref_total = get_total_reference_count(refs);
     +	stats_table_addf(table, "* %s", _("References"));
     +	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
     +	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	string_list_clear(&table->rows, 1);
     +}
     +
    -+static void structure_count_references(struct ref_stats *stats,
    -+				       struct ref_array *refs)
    ++static int count_references(const char *refname,
    ++			    const char *referent UNUSED,
    ++			    const struct object_id *oid UNUSED,
    ++			    int flags UNUSED, void *cb_data)
     +{
    -+	for (int i = 0; i < refs->nr; i++) {
    -+		struct ref_array_item *ref = refs->items[i];
    -+
    -+		switch (ref->kind) {
    -+		case FILTER_REFS_BRANCHES:
    -+			stats->branches++;
    -+			break;
    -+		case FILTER_REFS_REMOTES:
    -+			stats->remotes++;
    -+			break;
    -+		case FILTER_REFS_TAGS:
    -+			stats->tags++;
    -+			break;
    -+		case FILTER_REFS_OTHERS:
    -+			stats->others++;
    -+			break;
    -+		default:
    -+			BUG("unexpected reference type");
    -+		}
    ++	struct ref_stats *stats = cb_data;
    ++
    ++	switch (ref_kind_from_refname(refname)) {
    ++	case FILTER_REFS_BRANCHES:
    ++		stats->branches++;
    ++		break;
    ++	case FILTER_REFS_REMOTES:
    ++		stats->remotes++;
    ++		break;
    ++	case FILTER_REFS_TAGS:
    ++		stats->tags++;
    ++		break;
    ++	case FILTER_REFS_OTHERS:
    ++		stats->others++;
    ++		break;
    ++	default:
    ++		BUG("unexpected reference type");
     +	}
    ++
    ++	return 0;
    ++}
    ++
    ++static void structure_count_references(struct ref_stats *stats,
    ++				       struct repository *repo)
    ++{
    ++	refs_for_each_ref(get_main_ref_store(repo), count_references, &stats);
     +}
     +
     +static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    -+			      struct repository *repo UNUSED)
    ++			      struct repository *repo)
     +{
    -+	struct ref_filter filter = REF_FILTER_INIT;
     +	struct stats_table table = {
     +		.rows = STRING_LIST_INIT_DUP,
     +	};
     +	struct ref_stats stats = { 0 };
    -+	struct ref_array refs = { 0 };
     +	struct option options[] = { 0 };
     +
     +	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
     +	if (argc)
     +		usage(_("too many arguments"));
     +
    -+	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
    -+		die(_("unable to filter refs"));
    -+
    -+	structure_count_references(&stats, &refs);
    ++	structure_count_references(&stats, repo);
     +
     +	stats_table_setup_structure(&table, &stats);
     +	stats_table_print_structure(&table);
     +
     +	stats_table_clear(&table);
    -+	ref_array_clear(&refs);
     +
     +	return 0;
     +}
4:  503af885d3 ! 5:  4d37f65331 builtin/repo: add object counts in structure output
    @@ builtin/repo.c: struct ref_stats {
      struct stats_table {
      	struct string_list rows;
      
    -@@ builtin/repo.c: static void stats_table_count_addf(struct stats_table *table, size_t value,
    - 	va_end(ap);
    +@@ builtin/repo.c: static inline size_t get_total_reference_count(struct ref_stats *stats)
    + 	return stats->branches + stats->remotes + stats->tags + stats->others;
      }
      
     +static inline size_t get_total_object_count(struct object_stats *stats)
    @@ builtin/repo.c: static void stats_table_count_addf(struct stats_table *table, si
     +	size_t object_total;
      	size_t ref_total;
      
    - 	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
    + 	ref_total = get_total_reference_count(refs);
     @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *table,
      	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
      	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      }
      
      static void stats_table_print_structure(const struct stats_table *table)
    -@@ builtin/repo.c: static void structure_count_references(struct ref_stats *stats,
    +@@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
    + 	string_list_clear(&table->rows, 1);
    + }
    + 
    ++struct count_references_data {
    ++	struct ref_stats *stats;
    ++	struct rev_info *revs;
    ++};
    ++
    + static int count_references(const char *refname,
    + 			    const char *referent UNUSED,
    +-			    const struct object_id *oid UNUSED,
    ++			    const struct object_id *oid,
    + 			    int flags UNUSED, void *cb_data)
    + {
    +-	struct ref_stats *stats = cb_data;
    ++	struct count_references_data *data = cb_data;
    ++	struct ref_stats *stats = data->stats;
    + 
    + 	switch (ref_kind_from_refname(refname)) {
    + 	case FILTER_REFS_BRANCHES:
    +@@ builtin/repo.c: static int count_references(const char *refname,
    + 		BUG("unexpected reference type");
      	}
    + 
    ++	/*
    ++	 * While iterating through references for counting, also add OIDs in
    ++	 * preparation for the path walk.
    ++	 */
    ++	add_pending_oid(data->revs, NULL, oid, 0);
    ++
    + 	return 0;
      }
      
    + static void structure_count_references(struct ref_stats *stats,
    ++				       struct rev_info *revs,
    + 				       struct repository *repo)
    + {
    +-	refs_for_each_ref(get_main_ref_store(repo), count_references, &stats);
    ++	struct count_references_data data = {
    ++		.stats = stats,
    ++		.revs = revs,
    ++	};
    ++
    ++	refs_for_each_ref(get_main_ref_store(repo), count_references, &data);
    ++}
    ++
    ++
     +static int count_objects(const char *path UNUSED, struct oid_array *oids,
     +			 enum object_type type, void *cb_data)
     +{
    @@ builtin/repo.c: static void structure_count_references(struct ref_stats *stats,
     +}
     +
     +static void structure_count_objects(struct object_stats *stats,
    -+				    struct ref_array *refs,
     +				    struct rev_info *revs)
     +{
     +	struct path_walk_info info = PATH_WALK_INFO_INIT;
    @@ builtin/repo.c: static void structure_count_references(struct ref_stats *stats,
     +	info.path_fn = count_objects;
     +	info.path_fn_data = stats;
     +
    -+	for (int i = 0; i < refs->nr; i++) {
    -+		struct ref_array_item *ref = refs->items[i];
    -+
    -+		switch (ref->kind) {
    -+		case FILTER_REFS_BRANCHES:
    -+		case FILTER_REFS_TAGS:
    -+		case FILTER_REFS_REMOTES:
    -+		case FILTER_REFS_OTHERS:
    -+			add_pending_oid(revs, NULL, &ref->objectname, 0);
    -+			break;
    -+		default:
    -+			BUG("unexpected reference type");
    -+		}
    -+	}
    -+
     +	walk_objects_by_path(&info);
     +	path_walk_info_clear(&info);
    -+}
    -+
    + }
    + 
      static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    --			      struct repository *repo UNUSED)
    -+			      struct repository *repo)
    - {
    - 	struct ref_filter filter = REF_FILTER_INIT;
    +@@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
      	struct stats_table table = {
      		.rows = STRING_LIST_INIT_DUP,
      	};
     -	struct ref_stats stats = { 0 };
     +	struct repo_structure stats = { 0 };
    - 	struct ref_array refs = { 0 };
     +	struct rev_info revs;
      	struct option options[] = { 0 };
      
    @@ builtin/repo.c: static void structure_count_references(struct ref_stats *stats,
      	if (argc)
      		usage(_("too many arguments"));
      
    +-	structure_count_references(&stats, repo);
     +	repo_init_revisions(repo, &revs, prefix);
    - 	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
    - 		die(_("unable to filter refs"));
    - 
    --	structure_count_references(&stats, &refs);
    -+	structure_count_references(&stats.refs, &refs);
    -+	structure_count_objects(&stats.objects, &refs, &revs);
    ++
    ++	structure_count_references(&stats.refs, &revs, repo);
    ++	structure_count_objects(&stats.objects, &revs);
      
      	stats_table_setup_structure(&table, &stats);
      	stats_table_print_structure(&table);
      
      	stats_table_clear(&table);
     +	release_revisions(&revs);
    - 	ref_array_clear(&refs);
      
      	return 0;
    + }
     
      ## t/t1901-repo-structure.sh ##
     @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
5:  b336578445 ! 6:  3d42929434 builtin/repo: add keyvalue and nul format for structure stats
    @@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
     +	fflush(stdout);
     +}
     +
    - static void structure_count_references(struct ref_stats *stats,
    - 				       struct ref_array *refs)
    - {
    + struct count_references_data {
    + 	struct ref_stats *stats;
    + 	struct rev_info *revs;
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
      	struct stats_table table = {
      		.rows = STRING_LIST_INIT_DUP,
      	};
     +	enum output_format format = FORMAT_TABLE;
      	struct repo_structure stats = { 0 };
    - 	struct ref_array refs = { 0 };
      	struct rev_info revs;
     -	struct option options[] = { 0 };
     +	struct option options[] = {
    @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const
      	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
      	if (argc)
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    - 	structure_count_references(&stats.refs, &refs);
    - 	structure_count_objects(&stats.objects, &refs, &revs);
    + 	structure_count_references(&stats.refs, &revs, repo);
    + 	structure_count_objects(&stats.objects, &revs);
      
     -	stats_table_setup_structure(&table, &stats);
     -	stats_table_print_structure(&table);
6:  70c0b7e200 ! 7:  67d7d8eb8c builtin/repo: add progress meter for structure stats
    @@ builtin/repo.c
      #include "ref-filter.h"
      #include "refs.h"
     @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    + struct count_references_data {
    + 	struct ref_stats *stats;
    + 	struct rev_info *revs;
    ++	struct progress *progress;
    + };
    + 
    + static int count_references(const char *refname,
    +@@ builtin/repo.c: static int count_references(const char *refname,
    + {
    + 	struct count_references_data *data = cb_data;
    + 	struct ref_stats *stats = data->stats;
    ++	size_t ref_count;
    + 
    + 	switch (ref_kind_from_refname(refname)) {
    + 	case FILTER_REFS_BRANCHES:
    +@@ builtin/repo.c: static int count_references(const char *refname,
    + 	 */
    + 	add_pending_oid(data->revs, NULL, oid, 0);
    + 
    ++	ref_count = get_total_reference_count(stats);
    ++	display_progress(data->progress, ref_count);
    ++
    + 	return 0;
      }
      
      static void structure_count_references(struct ref_stats *stats,
    --				       struct ref_array *refs)
    -+				       struct ref_array *refs,
    + 				       struct rev_info *revs,
    +-				       struct repository *repo)
     +				       struct repository *repo,
     +				       int show_progress)
      {
    -+	struct progress *progress = NULL;
    -+
    -+	if (show_progress)
    -+		progress = start_delayed_progress(repo, _("Counting references"),
    -+						  refs->nr);
    -+
    - 	for (int i = 0; i < refs->nr; i++) {
    - 		struct ref_array_item *ref = refs->items[i];
    + 	struct count_references_data data = {
    + 		.stats = stats,
    + 		.revs = revs,
    + 	};
      
    -@@ builtin/repo.c: static void structure_count_references(struct ref_stats *stats,
    - 		default:
    - 			BUG("unexpected reference type");
    - 		}
    -+
    -+		display_progress(progress, i + 1);
    - 	}
    ++	if (show_progress)
    ++		data.progress = start_delayed_progress(repo,
    ++						       _("Counting references"), 0);
     +
    -+	stop_progress(&progress);
    + 	refs_for_each_ref(get_main_ref_store(repo), count_references, &data);
    ++	stop_progress(&data.progress);
      }
      
     +struct count_objects_data {
     +	struct object_stats *stats;
     +	struct progress *progress;
     +};
    -+
    + 
      static int count_objects(const char *path UNUSED, struct oid_array *oids,
      			 enum object_type type, void *cb_data)
      {
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
      }
      
      static void structure_count_objects(struct object_stats *stats,
    --				    struct ref_array *refs,
     -				    struct rev_info *revs)
    -+				    struct ref_array *refs, struct rev_info *revs,
    ++				    struct rev_info *revs,
     +				    struct repository *repo, int show_progress)
      {
      	struct path_walk_info info = PATH_WALK_INFO_INIT;
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
      	info.path_fn = count_objects;
     -	info.path_fn_data = stats;
     +	info.path_fn_data = &data;
    - 
    - 	for (int i = 0; i < refs->nr; i++) {
    - 		struct ref_array_item *ref = refs->items[i];
    -@@ builtin/repo.c: static void structure_count_objects(struct object_stats *stats,
    - 		}
    - 	}
    - 
    ++
     +	if (show_progress)
     +		data.progress = start_delayed_progress(repo, _("Counting objects"), 0);
    -+
    + 
      	walk_objects_by_path(&info);
      	path_walk_info_clear(&info);
     +	stop_progress(&data.progress);
    @@ builtin/repo.c: static void structure_count_objects(struct object_stats *stats,
      
      static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    + 	enum output_format format = FORMAT_TABLE;
      	struct repo_structure stats = { 0 };
    - 	struct ref_array refs = { 0 };
      	struct rev_info revs;
     +	int show_progress = -1;
      	struct option options[] = {
    @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const
      	};
      
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    - 	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
    - 		die(_("unable to filter refs"));
      
    --	structure_count_references(&stats.refs, &refs);
    --	structure_count_objects(&stats.objects, &refs, &revs);
    + 	repo_init_revisions(repo, &revs, prefix);
    + 
    +-	structure_count_references(&stats.refs, &revs, repo);
    +-	structure_count_objects(&stats.objects, &revs);
     +	if (show_progress < 0)
     +		show_progress = isatty(2);
     +
    -+	structure_count_references(&stats.refs, &refs, repo, show_progress);
    -+	structure_count_objects(&stats.objects, &refs, &revs, repo, show_progress);
    ++	structure_count_references(&stats.refs, &revs, repo, show_progress);
    ++	structure_count_objects(&stats.objects, &revs, repo, show_progress);
      
      	switch (format) {
      	case FORMAT_TABLE:
    @@ t/t1901-repo-structure.sh: test_expect_success 'keyvalue and nul format' '
     +		GIT_PROGRESS_DELAY=0 git repo structure --progress >out 2>err &&
     +
     +		test_file_not_empty out &&
    -+		test_grep "Counting references: 100% (2/2), done." err &&
    ++		test_grep "Counting references: 2, done." err &&
     +		test_grep "Counting objects: 3, done." err &&
     +
     +		GIT_PROGRESS_DELAY=0 git repo structure --no-progress >out 2>err &&

base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
-- 
2.51.0.193.g4975ec3473b

