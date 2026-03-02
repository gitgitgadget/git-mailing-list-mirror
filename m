Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715E249EB
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428554; cv=none; b=LPkOSmCGE8vn1E9Exv9qDUwTC5Fmm28gOK1J3RCdGBa4LRiIW+DINX4NbOHp2r6NRQ+1OflzxeC+kj/7OV/UfvffZZpbi60e4vIHNxXniFMMqhxGj2eF52cznIxI4drsj0gdzHeUQlFzc5FzrLvopVjSIPJhmIg0V+ElFgL7u6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428554; c=relaxed/simple;
	bh=URz6FTmuXLY7avfwHWIWvhMFfRpXh1kz2Mm8jssNMcg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DC4RtyieO+jSgyMJYAFAniF7fDPVA47N8G9oaiKmchdqlAfpaKsotX6tEFwybPlF52gptQvSf09Xtt9PUwHnKjw5kDEEpmZswEoL+sKQNDaAB1WSZvnQGT9JD5lRU0Eq0EK+zM1OAjO3hwkTGkTglqCkeIxGZQpkKNvD2/Q5lxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no+LFpIz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no+LFpIz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6f21c2d81so394508385a.2
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 21:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772428550; x=1773033350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAVOIdtiBZ2CtYMx5E3hFISZacw9iMNiVi3rG6j8gzE=;
        b=no+LFpIzrNN7kl2+JTqFWoAuVUdccXVWTkQrIabHS5egtOydlF9aAy2hST5qliVLeG
         hXSkxIhyCGx978iNVYtFJ0sTX+OCyPVx/9LNGKFjblD6gAM4zXRaav77a3xUPr6kcECJ
         g90M/s8ctk+d+XbjvEmk5a3RmJSQPINFAIzJW9Z5YLHqzLzaRCKYOzfv9zD0McVuJp/Y
         JDtd7xjfX9bH1d5JCKxSIGZpX0WGIuuCWGY9KSYz2GHzPUNwF35S3jfV7n19dejTlxDe
         bPyjhQhuB7lu/dv0jTPVSpB5AqhAybEzX4NwOfiuVK6xNrgWU/BjFBoOhYHLAc3bZtu0
         yu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772428550; x=1773033350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jAVOIdtiBZ2CtYMx5E3hFISZacw9iMNiVi3rG6j8gzE=;
        b=SDDBOSrvVx97MFjGOpKPI08D8bUw6evsHkCNfztr2PLbJx23ejZksRZGP8YFg4mGl7
         OEiWCGm6FXVljClxBlGhEHfQXlQkiBxRnKb6deRBPH+9cH32ey5v9Lihe8WPKHFm5/P/
         THoc6Gc4f3BWRaRUdIi5+4miUlammU9ArB48JEwLc3qEW2ZykPQlyHZb9gN/7nNDrYsn
         EfMDsLr+z/PrxnZpBSLhtDPH5Uo/LM7TXKt4uE8pddtEKDtoV4jQr8tkwsMix9YPJ83V
         rROW19/PUyKJZqFdGOq5kTMOKgg483RwYq3ZRCVDqk5soBVhWa52lt6p107Eo5E//1qO
         QcNw==
X-Gm-Message-State: AOJu0Yz4h37WQcIf3XpX+ReEuPg/FC7P1qsZR4SM3kmkSPeo5kg98fau
	7yO0uc6gcCFFmJmFwYhrm591mjz0WConRJ8duMHEWznI1Uetvm2u1dsf7JoQrw==
X-Gm-Gg: ATEYQzxIHpZPOeiRJ/bpFq79arAAkvpWdhOPMreaKsI9Vxd49pJT74BeadjH7Vj2r8i
	6BcCbNseGHYeqMpZjaGk63rQCIKXEpcmJi8mXKIsXcKPtaPI59Q2SgK/ts5IWB0F8tc/EAafEgQ
	+OYRTpUt2kTBZYQokiTpKXOakuHfpkEDkqeYyK2I9IQp1DqMdJXKm474yhlvE0cq0AVpzQioh6l
	irXDji36rIN3jk8dbfBWl48Tl8s1xn3rV5OO4bTRGmCyk0aKGfGaD6tfvHMBr5eOOR5+WlyB4vI
	ZeBmvMWZ2tMwIa/XDR7rBRyrmVztJ0yXa2qbgPV07zbs67xwdJdzJTLWrw67OcRcabVcZxgxmVb
	AXuKw+7na/6+Evl89zrQpH3A8WAT0PSw7bAa50eKuCx8gtI6UwNZ+CVyupGa//wGZgTv3P8/1Ym
	ygUlzWxnTNxfSzaKY5qoWx6lSwwo6dvf8y6N0P
X-Received: by 2002:a05:620a:288b:b0:8ca:363a:cd73 with SMTP id af79cd13be357-8cbc8f366acmr1339120885a.68.1772428549900;
        Sun, 01 Mar 2026 21:15:49 -0800 (PST)
Received: from [127.0.0.1] ([172.183.95.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a017add76sm2767746d6.36.2026.03.01.21.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:15:49 -0800 (PST)
Message-Id: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "eslam reda via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 05:15:42 +0000
Subject: [PATCH v6 0/6] repo info: add category/path keys and --path-format
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>


This series now focuses only on git repo info improvements.
===========================================================

It introduces category-aware key requests, adds path-oriented keys (path.*),
and adds --path-format=(absolute|relative) so scripts can request stable
path rendering behavior.


What this PR does
=================

For git repo info, this series:

 * introduces explicit repo_info context plumbing,
 * adds category-key expansion (for example, layout expands to layout.*),
 * adds path-oriented keys (path.*) for common repository locations,
 * adds --path-format=(absolute|relative) to control path output style.

Tests and documentation are updated accordingly.


What this PR does NOT do
========================

 * No git repo structure feature changes.
 * No t1901 structure test changes.
 * No structure metrics/docs additions.


Key naming/scope adjustments from review
========================================

 * renamed path.git-prefix to path.prefix,
 * added path.working-tree (alias for path.toplevel),
 * removed file-layout-oriented keys:
   * path.logs-directory
   * path.packed-refs-file
   * path.refs-directory
   * path.shallow-file
 * for bare repositories, work-tree style keys return empty values.


Commit structure
================

 * repo: introduce repo_info context plumbing
 * repo: support category requests in repo info
 * repo: add path keys to repo info
 * repo: add --path-format for info path output
 * t1900: cover repo info path keys and path-format
 * docs: describe repo info path keys

All commits are signed off with the same real-name identity.


Changes since previous revision
===============================

 * dropped all repo structure code/tests/docs from this branch,
 * split context plumbing and category expansion into separate commits,
 * rebased and cleaned history to avoid fix-on-fix commits,
 * aligned key naming/scope with review feedback.


Validation
==========

Focused (Linux Docker):

 * make -C t test T=t1900-repo.sh → passed (53/53)

Eslam reda ragheb (6):
  repo: introduce repo_info context plumbing
  repo: support category requests in repo info
  repo: add path keys to repo info
  repo: add --path-format for info path output
  t1900: cover repo info path keys and path-format
  docs: describe repo info path keys

 Documentation/git-repo.adoc |  58 +++++++++-
 builtin/repo.c              | 209 +++++++++++++++++++++++++++++++++---
 t/t1900-repo.sh             | 194 +++++++++++++++++++++++++++++++++
 3 files changed, 441 insertions(+), 20 deletions(-)


base-commit: 2cc71917514657b93014134350864f4849edfc83
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2208%2Feslam-reda-div%2Fgsoc-contribute-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2208/eslam-reda-div/gsoc-contribute-v6
Pull-Request: https://github.com/git/git/pull/2208

Range-diff vs v5:

  1:  99c8058298 !  1:  bddea1a22e repo: teach info context and category keys
     @@ Metadata
      Author: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
       ## Commit message ##
     -    repo: teach info context and category keys
     +    repo: introduce repo_info context plumbing
      
     -    Introduce an explicit repo_info context for the repo info codepath
     -    and thread it through value lookups and field printing.
     +    Introduce a repo_info context and thread it through get_value_fn,
     +    field lookup, and value-printing helpers.
      
     -    This removes direct coupling from these helpers to ad-hoc
     -    repository globals and makes key retrieval logic easier to extend
     -    safely.
     -
     -    Also teach git repo info to accept category names (for example,
     -    layout) and expand them to matching key.* entries in request
     -    order.
     -
     -    This improves script ergonomics while preserving existing behavior
     -    for explicit keys and clear errors for unknown names.
     +    This prepares repo info for fields that need invocation-specific
     +    context in addition to the repository handle.
      
          Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
     @@ builtin/repo.c: struct field {
       	strbuf_addstr(buf,
       		      ref_storage_format_to_name(repo->ref_storage_format));
       	return 0;
     -@@ builtin/repo.c: static get_value_fn *get_value_fn_for_key(const char *key)
     - 	return found ? found->get_value : NULL;
     - }
     - 
     -+static void print_field(enum output_format format, const char *key,
     -+			const char *value);
     -+
     -+static int print_category_fields(const char *category,
     -+				 struct repo_info *info,
     -+				 enum output_format format,
     -+				 struct strbuf *valbuf)
     -+{
     -+	int found = 0;
     -+	size_t category_len = strlen(category);
     -+
     -+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
     -+		const struct field *field = &repo_info_fields[i];
     -+
     -+		if (!starts_with(field->key, category) ||
     -+		    field->key[category_len] != '.')
     -+			continue;
     -+
     -+		strbuf_reset(valbuf);
     -+		field->get_value(info, valbuf);
     -+		print_field(format, field->key, valbuf->buf);
     -+		found = 1;
     -+	}
     -+
     -+	return found;
     -+}
     -+
     - static void print_field(enum output_format format, const char *key,
     - 			const char *value)
     - {
      @@ builtin/repo.c: static void print_field(enum output_format format, const char *key,
       }
       
     @@ builtin/repo.c: static void print_field(enum output_format format, const char *k
       {
       	int ret = 0;
      @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
     - 
     - 		get_value = get_value_fn_for_key(key);
     - 
     --		if (!get_value) {
     --			ret = error(_("key '%s' not found"), key);
     -+		if (get_value) {
     -+			strbuf_reset(&valbuf);
     -+			get_value(info, &valbuf);
     -+			print_field(format, key, valbuf.buf);
     - 			continue;
       		}
       
     --		strbuf_reset(&valbuf);
     + 		strbuf_reset(&valbuf);
      -		get_value(repo, &valbuf);
     --		print_field(format, key, valbuf.buf);
     -+		if (!print_category_fields(key, info, format, &valbuf))
     -+			ret = error(_("key '%s' not found"), key);
     ++		get_value(info, &valbuf);
     + 		print_field(format, key, valbuf.buf);
       	}
       
     - 	strbuf_release(&valbuf);
     +@@ builtin/repo.c: static int print_fields(int argc, const char **argv,
       	return ret;
       }
       
     @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
      @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
       			 struct repository *repo)
       {
     - 	enum output_format format = FORMAT_KEYVALUE;
     + 	enum output_format format = FORMAT_NEWLINE_TERMINATED;
      +	struct repo_info info = {
      +		.repo = repo,
      +		.prefix = prefix,
      +	};
       	int all_keys = 0;
     + 	int show_keys = 0;
       	struct option options[] = {
     - 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
      @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
       		die(_("--all and <key> cannot be used together"));
       
  4:  504d9cf7a0 !  2:  2369608976 repo: add structure max object size metrics
     @@ Metadata
      Author: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
       ## Commit message ##
     -    repo: add structure max object size metrics
     +    repo: support category requests in repo info
      
     -    Extend git repo structure with maximum inflated and on-disk object
     -    sizes, both per type and overall max values.
     +    Teach repo info to accept category names (for example, layout)
     +    and expand them to matching key.* entries in request order.
      
     -    This complements existing totals by highlighting outliers that
     -    often drive repository bloat analysis.
     -
     -    The implementation updates object counting to track per-type maxima
     -    while walking reachable objects.
     -
     -    It exposes those values in both table and keyvalue formats for
     -    scripts and human output.
     +    Explicit keys keep their existing behavior; unknown keys or
     +    categories still report clear errors.
      
          Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
       ## builtin/repo.c ##
     -@@ builtin/repo.c: struct object_values {
     - struct object_stats {
     - 	struct object_values type_counts;
     - 	struct object_values inflated_sizes;
     -+	struct object_values max_inflated_sizes;
     - 	struct object_values disk_sizes;
     -+	struct object_values max_disk_sizes;
     - };
     - 
     - struct repo_structure {
     -@@ builtin/repo.c: static inline size_t get_total_object_values(struct object_values *values)
     - 	return values->tags + values->commits + values->trees + values->blobs;
     +@@ builtin/repo.c: static get_value_fn *get_value_fn_for_key(const char *key)
     + 	return found ? found->get_value : NULL;
       }
       
     -+static inline size_t get_max_object_value(struct object_values *values)
     ++static void print_field(enum output_format format, const char *key,
     ++			const char *value);
     ++
     ++static int print_category_fields(const char *category,
     ++				 struct repo_info *info,
     ++				 enum output_format format,
     ++				 struct strbuf *valbuf)
      +{
     -+	size_t max = values->commits;
     ++	int found = 0;
     ++	size_t category_len = strlen(category);
      +
     -+	if (values->trees > max)
     -+		max = values->trees;
     -+	if (values->blobs > max)
     -+		max = values->blobs;
     -+	if (values->tags > max)
     -+		max = values->tags;
     ++	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
     ++		const struct field *field = &repo_info_fields[i];
      +
     -+	return max;
     -+}
     ++		if (!starts_with(field->key, category) ||
     ++		    field->key[category_len] != '.')
     ++			continue;
      +
     - static void stats_table_setup_structure(struct stats_table *table,
     - 					struct repo_structure *stats)
     - {
     -@@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *table,
     - 			      "    * %s", _("Blobs"));
     - 	stats_table_size_addf(table, objects->disk_sizes.tags,
     - 			      "    * %s", _("Tags"));
     ++		strbuf_reset(valbuf);
     ++		field->get_value(info, valbuf);
     ++		print_field(format, field->key, valbuf->buf);
     ++		found = 1;
     ++	}
      +
     -+	stats_table_size_addf(table, objects->max_inflated_sizes.commits,
     -+			      "  * %s", _("Largest commit"));
     -+	stats_table_size_addf(table, objects->max_inflated_sizes.trees,
     -+			      "  * %s", _("Largest tree"));
     -+	stats_table_size_addf(table, objects->max_inflated_sizes.blobs,
     -+			      "  * %s", _("Largest blob"));
     -+	stats_table_size_addf(table, objects->max_inflated_sizes.tags,
     -+			      "  * %s", _("Largest tag"));
     ++	return found;
     ++}
      +
     -+	stats_table_size_addf(table, get_max_object_value(&objects->max_disk_sizes),
     -+			      "  * %s", _("Largest disk size"));
     -+	stats_table_size_addf(table, objects->max_disk_sizes.commits,
     -+			      "    * %s", _("Commits"));
     -+	stats_table_size_addf(table, objects->max_disk_sizes.trees,
     -+			      "    * %s", _("Trees"));
     -+	stats_table_size_addf(table, objects->max_disk_sizes.blobs,
     -+			      "    * %s", _("Blobs"));
     -+	stats_table_size_addf(table, objects->max_disk_sizes.tags,
     -+			      "    * %s", _("Tags"));
     - }
     - 
     - static void stats_table_print_structure(const struct stats_table *table)
     -@@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
     - static void structure_keyvalue_print(struct repo_structure *stats,
     - 				     char key_delim, char value_delim)
     + static void print_field(enum output_format format, const char *key,
     + 			const char *value)
       {
     -+	size_t max_inflated_size = get_max_object_value(&stats->objects.max_inflated_sizes);
     -+	size_t max_disk_size = get_max_object_value(&stats->objects.max_disk_sizes);
     -+
     - 	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->refs.branches, value_delim);
     - 	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
     -@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
     - 	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
     +@@ builtin/repo.c: static int print_fields(int argc, const char **argv,
       
     -+	printf("objects.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)max_inflated_size, value_delim);
     -+	printf("objects.commits.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_inflated_sizes.commits, value_delim);
     -+	printf("objects.trees.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_inflated_sizes.trees, value_delim);
     -+	printf("objects.blobs.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_inflated_sizes.blobs, value_delim);
     -+	printf("objects.tags.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_inflated_sizes.tags, value_delim);
     -+
     -+	printf("objects.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)max_disk_size, value_delim);
     -+	printf("objects.commits.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_disk_sizes.commits, value_delim);
     -+	printf("objects.trees.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_disk_sizes.trees, value_delim);
     -+	printf("objects.blobs.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_disk_sizes.blobs, value_delim);
     -+	printf("objects.tags.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_disk_sizes.tags, value_delim);
     -+
     - 	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
     - 	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
     -@@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_array *oids,
     - 	struct object_stats *stats = data->stats;
     - 	size_t inflated_total = 0;
     - 	size_t disk_total = 0;
     -+	size_t max_inflated = 0;
     -+	size_t max_disk = 0;
     - 	size_t object_count;
     + 		get_value = get_value_fn_for_key(key);
       
     - 	for (size_t i = 0; i < oids->nr; i++) {
     -@@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_array *oids,
     - 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
     - 						  OBJECT_INFO_QUICK) < 0)
     +-		if (!get_value) {
     +-			ret = error(_("key '%s' not found"), key);
     ++		if (get_value) {
     ++			strbuf_reset(&valbuf);
     ++			get_value(info, &valbuf);
     ++			print_field(format, key, valbuf.buf);
       			continue;
     -+		if (disk < 0)
     -+			continue;
     + 		}
       
     - 		inflated_total += inflated;
     --		disk_total += disk;
     -+		disk_total += (size_t)disk;
     -+		if (inflated > max_inflated)
     -+			max_inflated = inflated;
     -+		if ((size_t)disk > max_disk)
     -+			max_disk = (size_t)disk;
     +-		strbuf_reset(&valbuf);
     +-		get_value(info, &valbuf);
     +-		print_field(format, key, valbuf.buf);
     ++		if (!print_category_fields(key, info, format, &valbuf))
     ++			ret = error(_("key '%s' not found"), key);
       	}
       
     - 	switch (type) {
     - 	case OBJ_TAG:
     - 		stats->type_counts.tags += oids->nr;
     - 		stats->inflated_sizes.tags += inflated_total;
     -+		if (max_inflated > stats->max_inflated_sizes.tags)
     -+			stats->max_inflated_sizes.tags = max_inflated;
     - 		stats->disk_sizes.tags += disk_total;
     -+		if (max_disk > stats->max_disk_sizes.tags)
     -+			stats->max_disk_sizes.tags = max_disk;
     - 		break;
     - 	case OBJ_COMMIT:
     - 		stats->type_counts.commits += oids->nr;
     - 		stats->inflated_sizes.commits += inflated_total;
     -+		if (max_inflated > stats->max_inflated_sizes.commits)
     -+			stats->max_inflated_sizes.commits = max_inflated;
     - 		stats->disk_sizes.commits += disk_total;
     -+		if (max_disk > stats->max_disk_sizes.commits)
     -+			stats->max_disk_sizes.commits = max_disk;
     - 		break;
     - 	case OBJ_TREE:
     - 		stats->type_counts.trees += oids->nr;
     - 		stats->inflated_sizes.trees += inflated_total;
     -+		if (max_inflated > stats->max_inflated_sizes.trees)
     -+			stats->max_inflated_sizes.trees = max_inflated;
     - 		stats->disk_sizes.trees += disk_total;
     -+		if (max_disk > stats->max_disk_sizes.trees)
     -+			stats->max_disk_sizes.trees = max_disk;
     - 		break;
     - 	case OBJ_BLOB:
     - 		stats->type_counts.blobs += oids->nr;
     - 		stats->inflated_sizes.blobs += inflated_total;
     -+		if (max_inflated > stats->max_inflated_sizes.blobs)
     -+			stats->max_inflated_sizes.blobs = max_inflated;
     - 		stats->disk_sizes.blobs += disk_total;
     -+		if (max_disk > stats->max_disk_sizes.blobs)
     -+			stats->max_disk_sizes.blobs = max_disk;
     - 		break;
     - 	default:
     - 		BUG("invalid object type");
     + 	strbuf_release(&valbuf);
  2:  6d5b9ff075 !  3:  477333a94c repo: add path keys to repo info
     @@ builtin/repo.c: static int get_object_format(struct repo_info *info, struct strb
      +	return 0;
      +}
      +
     -+static int get_path_git_prefix(struct repo_info *info, struct strbuf *buf)
     ++static int get_path_prefix(struct repo_info *info, struct strbuf *buf)
      +{
     -+	if (info->prefix)
     -+		strbuf_addstr(buf, info->prefix);
     ++	strbuf_addstr(buf, info->prefix);
      +	return 0;
      +}
      +
     @@ builtin/repo.c: static int get_object_format(struct repo_info *info, struct strb
      +	return 0;
      +}
      +
     -+static int get_path_logs_directory(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "logs"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
      +static int get_path_objects_directory(struct repo_info *info, struct strbuf *buf)
      +{
      +	repo_info_add_path(info, buf, repo_get_object_directory(info->repo));
      +	return 0;
      +}
      +
     -+static int get_path_packed_refs_file(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "packed-refs"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
     -+static int get_path_refs_directory(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "refs"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
     -+static int get_path_shallow_file(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "shallow"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
      +static int get_path_superproject_working_tree(struct repo_info *info,
      +					     struct strbuf *buf)
      +{
     @@ builtin/repo.c: static int get_object_format(struct repo_info *info, struct strb
      +
      +	return 0;
      +}
     ++
     ++static int get_path_work_tree(struct repo_info *info, struct strbuf *buf)
     ++{
     ++	return get_path_toplevel(info, buf);
     ++}
      +
       static int get_references_format(struct repo_info *info, struct strbuf *buf)
       {
     @@ builtin/repo.c: static const struct field repo_info_fields[] = {
      +	{ "path.common-dir", get_path_common_dir },
      +	{ "path.config-file", get_path_config_file },
      +	{ "path.git-dir", get_path_git_dir },
     -+	{ "path.git-prefix", get_path_git_prefix },
      +	{ "path.grafts-file", get_path_grafts_file },
      +	{ "path.hooks-directory", get_path_hooks_directory },
      +	{ "path.index-file", get_path_index_file },
     -+	{ "path.logs-directory", get_path_logs_directory },
      +	{ "path.objects-directory", get_path_objects_directory },
     -+	{ "path.packed-refs-file", get_path_packed_refs_file },
     -+	{ "path.refs-directory", get_path_refs_directory },
     -+	{ "path.shallow-file", get_path_shallow_file },
     ++	{ "path.prefix", get_path_prefix },
      +	{ "path.superproject-working-tree", get_path_superproject_working_tree },
      +	{ "path.toplevel", get_path_toplevel },
     ++	{ "path.working-tree", get_path_work_tree },
       	{ "references.format", get_references_format },
       };
       
     +@@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
     + 	enum output_format format = FORMAT_NEWLINE_TERMINATED;
     + 	struct repo_info info = {
     + 		.repo = repo,
     +-		.prefix = prefix,
     ++		.prefix = prefix ? prefix : "",
     + 	};
     + 	int all_keys = 0;
     + 	int show_keys = 0;
  3:  5c438d045b !  4:  2a7afe4f87 repo: add --path-format for info path output
     @@ builtin/repo.c
       #include "utf8.h"
       
       static const char *const repo_usage[] = {
     --	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
     -+	"git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]",
     - 	"git repo structure [--format=(table|keyvalue|nul) | -z]",
     +-	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
     ++	"git repo info [--format=(lines|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]",
     + 	"git repo info --keys [--format=(lines|nul) | -z]",
     + 	"git repo structure [--format=(table|lines|nul) | -z]",
       	NULL
       };
       
     @@ builtin/repo.c: static int parse_format_cb(const struct option *opt,
      @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
       	struct repo_info info = {
       		.repo = repo,
     - 		.prefix = prefix,
     + 		.prefix = prefix ? prefix : "",
      +		.path_format = PATH_FORMAT_ABSOLUTE,
       	};
       	int all_keys = 0;
     - 	struct option options[] = {
     + 	int show_keys = 0;
      @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
       			       N_("synonym for --format=nul"),
       			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
     @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
      +			       N_("format"), N_("path output format"),
      +			       PARSE_OPT_NONEG, parse_path_format_cb),
       		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
     + 		OPT_BOOL(0, "keys", &show_keys, N_("show keys")),
       		OPT_END()
     - 	};
  5:  4b502925c9 <  -:  ---------- repo: add structure topology and path-depth metrics
  6:  1751181950 <  -:  ---------- repo: add aggregate structure totals to keyvalue output
  7:  fd18f28db0 !  5:  1e52e7bd7f t1900: cover repo info path keys and path-format
     @@ Commit message
          Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
       ## t/t1900-repo.sh ##
     -@@ t/t1900-repo.sh: REPO_INFO_KEYS='
     - 	layout.bare
     - 	layout.shallow
     - 	object.format
     +@@ t/t1900-repo.sh: test_description='test git repo-info'
     + 
     + . ./test-lib.sh
     + 
     ++# git-repo-info keys. It must contain the same keys listed in the const
     ++# repo_info_fields, in lexicographical order.
     ++REPO_INFO_KEYS='
     ++	layout.bare
     ++	layout.shallow
     ++	object.format
      +	path.common-dir
      +	path.config-file
      +	path.git-dir
     -+	path.git-prefix
      +	path.grafts-file
      +	path.hooks-directory
      +	path.index-file
     -+	path.logs-directory
      +	path.objects-directory
     -+	path.packed-refs-file
     -+	path.refs-directory
     -+	path.shallow-file
     ++	path.prefix
      +	path.superproject-working-tree
      +	path.toplevel
     - 	references.format
     - '
     - 
     ++	path.working-tree
     ++	references.format
     ++'
     ++
      +REPO_INFO_PATH_KEYS='
      +	path.common-dir
      +	path.config-file
      +	path.git-dir
     -+	path.git-prefix
      +	path.grafts-file
      +	path.hooks-directory
      +	path.index-file
     -+	path.logs-directory
      +	path.objects-directory
     -+	path.packed-refs-file
     -+	path.refs-directory
     -+	path.shallow-file
     ++	path.prefix
      +	path.superproject-working-tree
      +	path.toplevel
     ++	path.working-tree
      +'
      +
       # Test whether a key-value pair is correctly returned
     @@ t/t1900-repo.sh: test_expect_success 'values returned in order requested' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'path.git-prefix matches rev-parse --show-prefix' '
     ++test_expect_success 'path.prefix matches rev-parse --show-prefix' '
      +	git init path-prefix &&
      +	mkdir -p path-prefix/a/b &&
      +	expected_value=$(git -C path-prefix/a/b rev-parse --show-prefix) &&
     -+	echo "path.git-prefix=$expected_value" >expect &&
     -+	git -C path-prefix/a/b repo info path.git-prefix >actual &&
     ++	echo "path.prefix=$expected_value" >expect &&
     ++	git -C path-prefix/a/b repo info path.prefix >actual &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t1900-repo.sh: test_expect_success 'values returned in order requested' '
      +	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path config) &&
      +	echo "path.config-file=$expected_value" >expect &&
      +	git -C path-git-path repo info path.config-file >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path logs) &&
     -+	echo "path.logs-directory=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.logs-directory >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path packed-refs) &&
     -+	echo "path.packed-refs-file=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.packed-refs-file >actual &&
     -+	test_cmp expect actual &&
     ++	test_cmp expect actual
     ++'
      +
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path refs) &&
     -+	echo "path.refs-directory=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.refs-directory >actual &&
     -+	test_cmp expect actual &&
     ++test_expect_success 'path.working-tree matches path.toplevel' '
     ++	git init path-work-tree &&
     ++	expected_value=$(git -C path-work-tree rev-parse --show-toplevel) &&
     ++	echo "path.working-tree=$expected_value" >expect &&
     ++	git -C path-work-tree repo info path.working-tree >actual &&
     ++	test_cmp expect actual
     ++'
      +
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path shallow) &&
     -+	echo "path.shallow-file=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.shallow-file >actual &&
     ++test_expect_success 'path.working-tree is empty in bare repository' '
     ++	git init --bare bare-path-work-tree &&
     ++	echo "path.working-tree=" >expect &&
     ++	git -C bare-path-work-tree repo info path.working-tree >actual &&
      +	test_cmp expect actual
      +'
      +
  8:  0525ed4cd9 <  -:  ---------- t1901: extend structure metric coverage and portability
  9:  f17c0f03e5 !  6:  b98490a4a4 docs: describe repo info path keys and structure metrics
     @@ Metadata
      Author: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
       ## Commit message ##
     -    docs: describe repo info path keys and structure metrics
     +    docs: describe repo info path keys
      
     -    Document the newly added repo info capabilities, including
     -    category keys and path-oriented key definitions.
     -
     -    Also describe --path-format behavior for path outputs.
     -
     -    Update git repo structure documentation to cover newly reported
     -    maxima and aggregate keyvalue/nul fields.
     -
     -    This keeps command behavior and output keys fully specified for
     -    users and scripts.
     +    Document repo info category requests, path.* keys, and
     +    --path-format behavior.
      
          Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
     @@ Documentation/git-repo.adoc: git-repo - Retrieve information about the repositor
       SYNOPSIS
       --------
       [synopsis]
     --git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
     -+git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]
     - git repo structure [--format=(table|keyvalue|nul) | -z]
     +-git repo info [--format=(lines|nul) | -z] [--all | <key>...]
     ++git repo info [--format=(lines|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]
     + git repo info --keys [--format=(lines|nul) | -z]
     + git repo structure [--format=(table|lines|nul) | -z]
       
     - DESCRIPTION
      @@ Documentation/git-repo.adoc: supported:
     - +
     - `-z` is an alias for `--format=nul`.
     + `nul`:::
     + 	Similar to `lines`, but using a _NUL_ character after each value.
       
      +`--path-format=(absolute|relative)`:::
      +	Controls formatting for keys in the `path` category. The default is
      +	`absolute`. This option may be specified multiple times; the last one
      +	specified takes effect.
      +
     - `structure [--format=(table|keyvalue|nul) | -z]`::
     + `structure [--format=(table|lines|nul) | -z]`::
       	Retrieve statistics about the current repository structure. The
       	following kinds of information are reported:
      @@ Documentation/git-repo.adoc: supported:
     @@ Documentation/git-repo.adoc: supported:
       The output format can be chosen through the flag `--format`. Three formats are
       supported:
      @@ Documentation/git-repo.adoc: supported:
     - `keyvalue`:::
     + `lines`:::
       	Each line of output contains a key-value pair for a repository stat.
       	The '=' character is used to delimit between the key and the value.
      +	Both aggregate metrics and per-type metrics are included.
     @@ Documentation/git-repo.adoc: values that they return:
      +`path.git-dir`::
      +	The path to the git directory.
      +
     -+`path.git-prefix`::
     ++`path.prefix`::
      +	The path of the current working directory relative to the top-level
      +	directory.
      +
     @@ Documentation/git-repo.adoc: values that they return:
      +`path.index-file`::
      +	The path to the index file.
      +
     -+`path.logs-directory`::
     -+	The path to the `logs` directory.
     -+
      +`path.objects-directory`::
      +	The path to the objects directory.
      +
     -+`path.packed-refs-file`::
     -+	The path to the `packed-refs` file.
     -+
     -+`path.refs-directory`::
     -+	The path to the `refs` directory.
     -+
     -+`path.shallow-file`::
     -+	The path to the `shallow` file.
     -+
      +`path.superproject-working-tree`::
      +	The path to the superproject's working tree root, or an empty string
      +	when the repository is not used as a submodule.
     @@ Documentation/git-repo.adoc: values that they return:
      +`path.toplevel`::
      +	The path to the top-level working tree directory, or an empty string
      +	for bare repositories.
     ++
     ++`path.working-tree`::
     ++	Alias for `path.toplevel`.
      +
       `references.format`::
       	The reference storage format. The valid values are:
 10:  1bc100d6ca <  -:  ---------- repo: reduce repetition in structure keyvalue output
 11:  8af17ad831 <  -:  ---------- repo: refine path keys for repo info

-- 
gitgitgadget
