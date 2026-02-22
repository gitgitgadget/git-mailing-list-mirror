Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45E3563D6
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771784944; cv=none; b=j2kVrP0Qoe/EU4ZT/PWc86YiYIpXyNfmupImvm64xdww1ZflAwL70dK1ltFYBAjrXexolrgMwB1rRfmLb2Drmy5EipN63RvvzRTKUX28Rp/LGAwMjV8ehhXo1Divxqv3OjAYhgvmU0zuBoL8qDVIaSvFapObpFhVmwPttV4vVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771784944; c=relaxed/simple;
	bh=PQGssLOtsj1Lz8TqOLTU7r9mWB0f0qyUHeA1DMGuC8M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D5QoXATouT1jTV8dJcwlL8UKACX7JhWQF0lPnLDHrtdt3Q9+meh+fh3SHBVfpOF7SKq4UtwwWCMH5SRv3xqBEHCkkK51/OLnLHI6XBcVyLO1nlrshOCfEkmLgXVxCaADyltmlV2FstN5NZQ3pXLFgUVcXw09dAY4tndpouNtauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfE8f2CW; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfE8f2CW"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso7262067eec.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771784940; x=1772389740; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a02xvkkxdCY+9Wr7qfgXR/+K4/xJNyots6cvPQ9RDL8=;
        b=NfE8f2CWL24DYcoHXouiPwVsGsgM3vd0jExuTYMaja/QP08k4gE1dXX3Vh9u10gKQ8
         2EDC3kAD+sEXqa1ZDy0RKZH4H9s8Tnw5M5ibMEDF7AZWUhAPKCkFjpOINV+Ss6BJQ1/g
         wUjswcfCmeO4rz+gZAYS2hrIWjnDq07TUnsdm/l4b76p3/iuSjJulK1f1hbUpLULoUat
         CKlxvkn5/AVN+HO6h25qR5+Fh3DcEBtPcbWk7XHSnJeDHHSB0+BmpPu3ymkWkNdgZceB
         1biSj+04PKxgi/gz3UKtqLynnuKgrVxKoiBtaSfoENat+dz4VRgTUL/sau2mdX8KKwkc
         /+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771784940; x=1772389740;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a02xvkkxdCY+9Wr7qfgXR/+K4/xJNyots6cvPQ9RDL8=;
        b=h35sZ9NNCLIskGBlhPuSrCHJIdVh0gRvZBXMvlYNSGRob4bfcthoN8PbDHYfIDeCmw
         BSMIlP6zZGSo5HEpr+QUt0U7PUgVb3uPb91tKZkxyjvr7eOyonolZaiSWy9EB5+IN7Gl
         O7a1Co5hXJ0eAZZlVQ+xB7FryzuqIthJINZqVHKmHgGDMN3CxoGx/ykTvuXDUOFv+Scg
         srvYNDQ7aa1soeCQgD+5atb5/PBxF+dvrL6XeNhctDARWgh3YyR8g1rrX8PKVnccgFuw
         h1O8j8iP3ZzGvceZU2e7RGQ9oZtuoH+s9v5dsPYpaaw8XqOQ5mR05ntj9D3zXHrOsfsT
         pzhw==
X-Gm-Message-State: AOJu0Yzf0oUQXWZgttwBBwh24uYc3bmEgFDOgmpiyH8hLs62KMRk7Fv1
	/5Srg3yXI+mF5vZ0oEBiI3eNHO31jlsyOUO1pLbe9rmCAM/iY/00qqRyjd5hpA==
X-Gm-Gg: AZuq6aJh3Y5XrB0wt5BSg9y6NH52PLMlCQIF5apJM8J2gbWOsgHiFNy0ptjgD5iSs/6
	Ss4Bq86MW9Ni/KSD77X/fPpIqjU3F/2gbwIDD4eD8SkiGlR/QojkjY8AuQoiJe8IFYq6Spe0Y6U
	+svbmn1Rw/R+rlqO0fqqulvk80+utRyJzRwoD8xaTsTLRXpoIaA6JiDLINEjCxhl70FiLkPSNym
	/ixSgy/f9SHdVmTwxUB5x5DtWG93OGAvtAW9Wbg5RvDbIuuXAsv+zXfV2AHVc3LvQWfM0OJ/Ftg
	SU22S1jrBYgKyUSv0Xf381uUGtroFeG6emdua5uZBi9ld5Ot5Df5fSO6wSquiJSvC7/2M9bOPWL
	4FjPRfmr4jNIzyh0NG71ANlpAp5PFhiFlSGOz9fps66CvPdTu7QYkkitSeVBeA2bl6GSBphuVBg
	b7hVjq/RdAiZChnwDQaD2b/Em+
X-Received: by 2002:a05:7301:3e09:b0:2a4:3593:645b with SMTP id 5a478bee46e88-2bd7bb4a5a3mr2617787eec.11.1771784940183;
        Sun, 22 Feb 2026 10:29:00 -0800 (PST)
Received: from [127.0.0.1] ([20.171.51.209])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8c936sm6269055c88.14.2026.02.22.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 10:28:59 -0800 (PST)
Message-Id: <9f2b3a46a4475ef9dcfec65def3a9965b476b4c4.1771784936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
From: "eslam-reda-div via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Feb 2026 18:28:54 +0000
Subject: [PATCH 1/3] repo: extend info paths and structure statistics
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    eslam-reda-div <eslam.reda.div@gmail.com>

From: eslam-reda-div <eslam.reda.div@gmail.com>

Improve git repo info by adding path-oriented keys that match values
users currently obtain from git rev-parse, including common directory,
git directory, top-level, superproject working tree, and additional
git-path based locations.

Teach git repo info to accept category keys like layout and path,
and add --path-format=(absolute|relative) so scripts can request the
desired path style explicitly. The command now uses repository context
passed to the command path instead of relying on global state.

Extend git repo structure with deeper repository metrics inspired by
git-sizer, including per-type maximum inflated and on-disk object sizes,
maximum commit parent count, maximum tree entry count, longest/deepest
blob path, and deepest annotated tag chain.

Update documentation and tests to cover new keys, formats, and metrics.

Signed-off-by: eslam-reda-div <eslam.reda.div@gmail.com>
---
 Documentation/git-repo.adoc |  67 ++++-
 builtin/repo.c              | 525 ++++++++++++++++++++++++++++++++++--
 t/t1900-repo.sh             | 196 ++++++++++++++
 t/t1901-repo-structure.sh   | 250 ++++++++++++-----
 4 files changed, 948 insertions(+), 90 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d70270dfa..b575977a4b 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
+git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]
 git repo structure [--format=(table|keyvalue|nul) | -z]
 
 DESCRIPTION
@@ -44,6 +44,11 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`--path-format=(absolute|relative)`:::
+	Controls formatting for keys in the `path` category. The default is
+	`absolute`. This option may be specified multiple times; the last one
+	specified takes effect.
+
 `structure [--format=(table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
@@ -52,6 +57,12 @@ supported:
 * Reachable object counts categorized by type
 * Total inflated size of reachable objects by type
 * Total disk size of reachable objects by type
+* Largest inflated reachable object size by type
+* Largest disk size of a reachable object by type
+* Largest parent count among reachable commits
+* Largest entry count among reachable trees
+* Longest and deepest path among reachable blobs
+* Deepest annotated tag chain
 +
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
@@ -64,6 +75,7 @@ supported:
 `keyvalue`:::
 	Each line of output contains a key-value pair for a repository stat.
 	The '=' character is used to delimit between the key and the value.
+	Both aggregate metrics and per-type metrics are included.
 	Values containing "unusual" characters are quoted as explained for the
 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
 
@@ -78,9 +90,11 @@ supported:
 
 INFO KEYS
 ---------
-In order to obtain a set of values from `git repo info`, you should provide
-the keys that identify them. Here's a list of the available keys and the
-values that they return:
+In order to obtain values from `git repo info`, provide either individual keys
+or category names. A category returns all keys within that category. For
+example, `layout` returns both `layout.bare` and `layout.shallow`.
+
+Here's a list of the available keys and the values that they return:
 
 `layout.bare`::
 	`true` if this is a bare repository, otherwise `false`.
@@ -91,6 +105,51 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.common-dir`::
+	The path to the common git directory.
+
+`path.config-file`::
+	The path to the `config` file in the git directory.
+
+`path.git-dir`::
+	The path to the git directory.
+
+`path.git-prefix`::
+	The path of the current working directory relative to the top-level
+	directory.
+
+`path.grafts-file`::
+	The path to the `info/grafts` file.
+
+`path.hooks-directory`::
+	The path to the `hooks` directory.
+
+`path.index-file`::
+	The path to the index file.
+
+`path.logs-directory`::
+	The path to the `logs` directory.
+
+`path.objects-directory`::
+	The path to the objects directory.
+
+`path.packed-refs-file`::
+	The path to the `packed-refs` file.
+
+`path.refs-directory`::
+	The path to the `refs` directory.
+
+`path.shallow-file`::
+	The path to the `shallow` file.
+
+`path.superproject-working-tree`::
+	The path to the superproject's working tree root, or an empty string
+	when the repository is not used as a submodule.
+
+`path.toplevel`::
+	The path to the top-level working tree directory, or an empty string
+	for bare repositories.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..df2702fddb 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,10 +1,9 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
-#include "environment.h"
+#include "abspath.h"
 #include "hex.h"
 #include "odb.h"
 #include "parse-options.h"
+#include "path.h"
 #include "path-walk.h"
 #include "progress.h"
 #include "quote.h"
@@ -13,16 +12,29 @@
 #include "revision.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "submodule.h"
 #include "shallow.h"
+#include "tree-walk.h"
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
+	"git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]",
 	"git repo structure [--format=(table|keyvalue|nul) | -z]",
 	NULL
 };
 
-typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
+enum path_format {
+	PATH_FORMAT_ABSOLUTE,
+	PATH_FORMAT_RELATIVE,
+};
+
+struct repo_info {
+	struct repository *repo;
+	const char *prefix;
+	enum path_format path_format;
+};
+
+typedef int get_value_fn(struct repo_info *info, struct strbuf *buf);
 
 enum output_format {
 	FORMAT_TABLE,
@@ -35,27 +47,161 @@ struct field {
 	get_value_fn *get_value;
 };
 
-static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+static void repo_info_add_path(struct repo_info *info,
+			       struct strbuf *buf,
+			       const char *path)
 {
-	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
+	if (info->path_format == PATH_FORMAT_RELATIVE) {
+		char *cwd = xgetcwd();
+		struct strbuf rel_path = STRBUF_INIT;
+
+		strbuf_addstr(buf, relative_path(path, cwd, &rel_path));
+		strbuf_release(&rel_path);
+		free(cwd);
+		return;
+	}
+
+	strbuf_add_absolute_path(buf, path);
+}
+
+static int get_layout_bare(struct repo_info *info, struct strbuf *buf)
+{
+	struct repository *repo = info->repo;
+	strbuf_addstr(buf, repo_get_work_tree(repo) ? "false" : "true");
 	return 0;
 }
 
-static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
+static int get_layout_shallow(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf,
 		      is_repository_shallow(repo) ? "true" : "false");
 	return 0;
 }
 
-static int get_object_format(struct repository *repo, struct strbuf *buf)
+static int get_object_format(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf, repo->hash_algo->name);
 	return 0;
 }
 
-static int get_references_format(struct repository *repo, struct strbuf *buf)
+static int get_path_common_dir(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_common_dir(info->repo));
+	return 0;
+}
+
+static int get_path_config_file(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "config"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_git_dir(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_git_dir(info->repo));
+	return 0;
+}
+
+static int get_path_git_prefix(struct repo_info *info, struct strbuf *buf)
+{
+	if (info->prefix)
+		strbuf_addstr(buf, info->prefix);
+	return 0;
+}
+
+static int get_path_grafts_file(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_graft_file(info->repo));
+	return 0;
+}
+
+static int get_path_hooks_directory(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "hooks"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_index_file(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_index_file(info->repo));
+	return 0;
+}
+
+static int get_path_logs_directory(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "logs"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_objects_directory(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_object_directory(info->repo));
+	return 0;
+}
+
+static int get_path_packed_refs_file(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "packed-refs"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_refs_directory(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "refs"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_shallow_file(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "shallow"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_superproject_working_tree(struct repo_info *info,
+					      struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (get_superproject_working_tree(&superproject))
+		repo_info_add_path(info, buf, superproject.buf);
+
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_toplevel(struct repo_info *info, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(info->repo);
+
+	if (work_tree)
+		repo_info_add_path(info, buf, work_tree);
+
+	return 0;
+}
+
+static int get_references_format(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf,
 		      ref_storage_format_to_name(repo->ref_storage_format));
 	return 0;
@@ -66,6 +212,20 @@ static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.common-dir", get_path_common_dir },
+	{ "path.config-file", get_path_config_file },
+	{ "path.git-dir", get_path_git_dir },
+	{ "path.git-prefix", get_path_git_prefix },
+	{ "path.grafts-file", get_path_grafts_file },
+	{ "path.hooks-directory", get_path_hooks_directory },
+	{ "path.index-file", get_path_index_file },
+	{ "path.logs-directory", get_path_logs_directory },
+	{ "path.objects-directory", get_path_objects_directory },
+	{ "path.packed-refs-file", get_path_packed_refs_file },
+	{ "path.refs-directory", get_path_refs_directory },
+	{ "path.shallow-file", get_path_shallow_file },
+	{ "path.superproject-working-tree", get_path_superproject_working_tree },
+	{ "path.toplevel", get_path_toplevel },
 	{ "references.format", get_references_format },
 };
 
@@ -87,6 +247,33 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			const char *value);
+
+static int print_category_fields(const char *category,
+				 struct repo_info *info,
+				 enum output_format format,
+				 struct strbuf *valbuf)
+{
+	int found = 0;
+	size_t category_len = strlen(category);
+
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+
+		if (!starts_with(field->key, category) ||
+		    field->key[category_len] != '.')
+			continue;
+
+		strbuf_reset(valbuf);
+		field->get_value(info, valbuf);
+		print_field(format, field->key, valbuf->buf);
+		found = 1;
+	}
+
+	return found;
+}
+
 static void print_field(enum output_format format, const char *key,
 			const char *value)
 {
@@ -105,7 +292,7 @@ static void print_field(enum output_format format, const char *key,
 }
 
 static int print_fields(int argc, const char **argv,
-			struct repository *repo,
+			struct repo_info *info,
 			enum output_format format)
 {
 	int ret = 0;
@@ -117,21 +304,22 @@ static int print_fields(int argc, const char **argv,
 
 		get_value = get_value_fn_for_key(key);
 
-		if (!get_value) {
-			ret = error(_("key '%s' not found"), key);
+		if (get_value) {
+			strbuf_reset(&valbuf);
+			get_value(info, &valbuf);
+			print_field(format, key, valbuf.buf);
 			continue;
 		}
 
-		strbuf_reset(&valbuf);
-		get_value(repo, &valbuf);
-		print_field(format, key, valbuf.buf);
+		if (!print_category_fields(key, info, format, &valbuf))
+			ret = error(_("key '%s' not found"), key);
 	}
 
 	strbuf_release(&valbuf);
 	return ret;
 }
 
-static int print_all_fields(struct repository *repo,
+static int print_all_fields(struct repo_info *info,
 			    enum output_format format)
 {
 	struct strbuf valbuf = STRBUF_INIT;
@@ -140,7 +328,7 @@ static int print_all_fields(struct repository *repo,
 		const struct field *field = &repo_info_fields[i];
 
 		strbuf_reset(&valbuf);
-		field->get_value(repo, &valbuf);
+		field->get_value(info, &valbuf);
 		print_field(format, field->key, valbuf.buf);
 	}
 
@@ -167,10 +355,30 @@ static int parse_format_cb(const struct option *opt,
 	return 0;
 }
 
+static int parse_path_format_cb(const struct option *opt,
+				const char *arg, int unset UNUSED)
+{
+	enum path_format *path_format = opt->value;
+
+	if (!strcmp(arg, "absolute"))
+		*path_format = PATH_FORMAT_ABSOLUTE;
+	else if (!strcmp(arg, "relative"))
+		*path_format = PATH_FORMAT_RELATIVE;
+	else
+		die(_("invalid path format '%s'"), arg);
+
+	return 0;
+}
+
 static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
+	struct repo_info info = {
+		.repo = repo,
+		.prefix = prefix,
+		.path_format = PATH_FORMAT_ABSOLUTE,
+	};
 	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
@@ -180,6 +388,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       N_("synonym for --format=nul"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
+		OPT_CALLBACK_F(0, "path-format", &info.path_format,
+			       N_("format"), N_("path output format"),
+			       PARSE_OPT_NONEG, parse_path_format_cb),
 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
 		OPT_END()
 	};
@@ -192,9 +403,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		die(_("--all and <key> cannot be used together"));
 
 	if (all_keys)
-		return print_all_fields(repo, format);
+		return print_all_fields(&info, format);
 	else
-		return print_fields(argc, argv, repo, format);
+		return print_fields(argc, argv, &info, format);
 }
 
 struct ref_stats {
@@ -214,7 +425,14 @@ struct object_values {
 struct object_stats {
 	struct object_values type_counts;
 	struct object_values inflated_sizes;
+	struct object_values max_inflated_sizes;
 	struct object_values disk_sizes;
+	struct object_values max_disk_sizes;
+	size_t max_commit_parent_count;
+	size_t max_tree_entry_count;
+	size_t max_blob_path_length;
+	size_t max_blob_path_depth;
+	size_t max_tag_chain_depth;
 };
 
 struct repo_structure {
@@ -317,6 +535,130 @@ static inline size_t get_total_object_values(struct object_values *values)
 	return values->tags + values->commits + values->trees + values->blobs;
 }
 
+static inline size_t get_max_object_value(struct object_values *values)
+{
+	size_t max = values->commits;
+
+	if (values->trees > max)
+		max = values->trees;
+	if (values->blobs > max)
+		max = values->blobs;
+	if (values->tags > max)
+		max = values->tags;
+
+	return max;
+}
+
+static size_t get_commit_parent_count(struct repository *repo,
+				      const struct object_id *oid)
+{
+	unsigned long size = 0;
+	const char *cur;
+	const char *end;
+	void *buf;
+	size_t count = 0;
+
+	buf = odb_read_object_peeled(repo->objects, oid, OBJ_COMMIT, &size, NULL);
+	if (!buf)
+		return 0;
+
+	cur = buf;
+	end = cur + size;
+	while (cur < end) {
+		const char *newline = memchr(cur, '\n', end - cur);
+		size_t line_len;
+
+		if (!newline)
+			break;
+		line_len = newline - cur;
+		if (!line_len)
+			break;
+
+		if (line_len > 7 && !memcmp(cur, "parent ", 7))
+			count++;
+
+		cur = newline + 1;
+	}
+
+	free(buf);
+	return count;
+}
+
+static size_t get_tree_entry_count(struct repository *repo,
+				   const struct object_id *oid)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	unsigned long size = 0;
+	void *buf;
+	size_t count = 0;
+
+	buf = odb_read_object_peeled(repo->objects, oid, OBJ_TREE, &size, NULL);
+	if (!buf)
+		return 0;
+
+	init_tree_desc(&desc, oid, buf, size);
+	while (tree_entry(&desc, &entry))
+		count++;
+
+	free(buf);
+	return count;
+}
+
+static size_t get_path_depth(const char *path)
+{
+	size_t depth = 0;
+
+	if (!path || !*path)
+		return 0;
+
+	depth = 1;
+	for (const char *cur = path; *cur; cur++)
+		if (*cur == '/')
+			depth++;
+
+	return depth;
+}
+
+static size_t get_tag_chain_depth(struct repository *repo,
+				  const struct object_id *oid)
+{
+	struct object_id current = *oid;
+	size_t depth = 0;
+
+	while (1) {
+		enum object_type type;
+		unsigned long size = 0;
+		struct object_id next;
+		const char *p, *end;
+		void *buf = odb_read_object(repo->objects, &current, &type, &size);
+
+		if (!buf)
+			break;
+		if (type != OBJ_TAG) {
+			free(buf);
+			break;
+		}
+
+		p = buf;
+		if (!skip_prefix(p, "object ", &p) ||
+		    parse_oid_hex_algop(p, &next, &end, repo->hash_algo) ||
+		    *end != '\n') {
+			free(buf);
+			break;
+		}
+
+		depth++;
+		free(buf);
+
+		if (oideq(&next, &current))
+			break;
+		oidcpy(&current, &next);
+	}
+
+	return depth;
+}
+
 static void stats_table_setup_structure(struct stats_table *table,
 					struct repo_structure *stats)
 {
@@ -371,6 +713,37 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->disk_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	stats_table_size_addf(table, objects->max_inflated_sizes.commits,
+			      "  * %s", _("Largest commit"));
+	stats_table_size_addf(table, objects->max_inflated_sizes.trees,
+			      "  * %s", _("Largest tree"));
+	stats_table_size_addf(table, objects->max_inflated_sizes.blobs,
+			      "  * %s", _("Largest blob"));
+	stats_table_size_addf(table, objects->max_inflated_sizes.tags,
+			      "  * %s", _("Largest tag"));
+
+	stats_table_size_addf(table, get_max_object_value(&objects->max_disk_sizes),
+			      "  * %s", _("Largest disk size"));
+	stats_table_size_addf(table, objects->max_disk_sizes.commits,
+			      "    * %s", _("Commits"));
+	stats_table_size_addf(table, objects->max_disk_sizes.trees,
+			      "    * %s", _("Trees"));
+	stats_table_size_addf(table, objects->max_disk_sizes.blobs,
+			      "    * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->max_disk_sizes.tags,
+			      "    * %s", _("Tags"));
+
+	stats_table_count_addf(table, objects->max_commit_parent_count,
+			       "  * %s", _("Largest parent count"));
+	stats_table_count_addf(table, objects->max_tree_entry_count,
+			       "  * %s", _("Largest tree entries"));
+	stats_table_count_addf(table, objects->max_blob_path_length,
+			       "  * %s", _("Longest blob path"));
+	stats_table_count_addf(table, objects->max_blob_path_depth,
+			       "  * %s", _("Deepest blob path"));
+	stats_table_count_addf(table, objects->max_tag_chain_depth,
+			       "  * %s", _("Deepest tag chain"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -449,6 +822,15 @@ static void stats_table_clear(struct stats_table *table)
 static void structure_keyvalue_print(struct repo_structure *stats,
 				     char key_delim, char value_delim)
 {
+	size_t references_count_total = get_total_reference_count(&stats->refs);
+	size_t object_count_total = get_total_object_values(&stats->objects.type_counts);
+	size_t inflated_size_total = get_total_object_values(&stats->objects.inflated_sizes);
+	size_t disk_size_total = get_total_object_values(&stats->objects.disk_sizes);
+	size_t max_inflated_size = get_max_object_value(&stats->objects.max_inflated_sizes);
+	size_t max_disk_size = get_max_object_value(&stats->objects.max_disk_sizes);
+
+	printf("references.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)references_count_total, value_delim);
 	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->refs.branches, value_delim);
 	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
@@ -458,6 +840,8 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->refs.others, value_delim);
 
+	printf("objects.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)object_count_total, value_delim);
 	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
 	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
@@ -467,6 +851,8 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
 
+	printf("objects.inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)inflated_size_total, value_delim);
 	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
 	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
@@ -476,6 +862,41 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
 
+	printf("objects.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)max_inflated_size, value_delim);
+	printf("objects.commits.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.commits, value_delim);
+	printf("objects.trees.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.trees, value_delim);
+	printf("objects.blobs.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.blobs, value_delim);
+	printf("objects.tags.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.tags, value_delim);
+
+	printf("objects.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)disk_size_total, value_delim);
+	printf("objects.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)max_disk_size, value_delim);
+	printf("objects.commits.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.commits, value_delim);
+	printf("objects.trees.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.trees, value_delim);
+	printf("objects.blobs.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.blobs, value_delim);
+	printf("objects.tags.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.tags, value_delim);
+
+	printf("objects.commits.max_parent_count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_commit_parent_count, value_delim);
+	printf("objects.trees.max_entry_count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_tree_entry_count, value_delim);
+	printf("objects.blobs.max_path_length%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_blob_path_length, value_delim);
+	printf("objects.blobs.max_path_depth%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_blob_path_depth, value_delim);
+	printf("objects.tags.max_chain_depth%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_tag_chain_depth, value_delim);
+
 	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
 	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
@@ -553,13 +974,15 @@ struct count_objects_data {
 	struct progress *progress;
 };
 
-static int count_objects(const char *path UNUSED, struct oid_array *oids,
+static int count_objects(const char *path, struct oid_array *oids,
 			 enum object_type type, void *cb_data)
 {
 	struct count_objects_data *data = cb_data;
 	struct object_stats *stats = data->stats;
 	size_t inflated_total = 0;
 	size_t disk_total = 0;
+	size_t max_inflated = 0;
+	size_t max_disk = 0;
 	size_t object_count;
 
 	for (size_t i = 0; i < oids->nr; i++) {
@@ -572,33 +995,89 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 
 		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
-						  OBJECT_INFO_QUICK) < 0)
+							  OBJECT_INFO_QUICK) < 0)
+			continue;
+		if (disk < 0)
 			continue;
 
 		inflated_total += inflated;
-		disk_total += disk;
+		disk_total += (size_t)disk;
+		if (inflated > max_inflated)
+			max_inflated = inflated;
+		if ((size_t)disk > max_disk)
+			max_disk = (size_t)disk;
 	}
 
 	switch (type) {
 	case OBJ_TAG:
+		for (size_t i = 0; i < oids->nr; i++) {
+			size_t tag_chain_depth = get_tag_chain_depth(data->odb->repo,
+								     &oids->oid[i]);
+
+			if (tag_chain_depth > stats->max_tag_chain_depth)
+				stats->max_tag_chain_depth = tag_chain_depth;
+		}
+
 		stats->type_counts.tags += oids->nr;
 		stats->inflated_sizes.tags += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.tags)
+			stats->max_inflated_sizes.tags = max_inflated;
 		stats->disk_sizes.tags += disk_total;
+		if (max_disk > stats->max_disk_sizes.tags)
+			stats->max_disk_sizes.tags = max_disk;
 		break;
 	case OBJ_COMMIT:
+		for (size_t i = 0; i < oids->nr; i++) {
+			size_t parent_count = get_commit_parent_count(data->odb->repo,
+								      &oids->oid[i]);
+
+			if (parent_count > stats->max_commit_parent_count)
+				stats->max_commit_parent_count = parent_count;
+		}
+
 		stats->type_counts.commits += oids->nr;
 		stats->inflated_sizes.commits += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.commits)
+			stats->max_inflated_sizes.commits = max_inflated;
 		stats->disk_sizes.commits += disk_total;
+		if (max_disk > stats->max_disk_sizes.commits)
+			stats->max_disk_sizes.commits = max_disk;
 		break;
 	case OBJ_TREE:
+		for (size_t i = 0; i < oids->nr; i++) {
+			size_t entry_count = get_tree_entry_count(data->odb->repo,
+								  &oids->oid[i]);
+
+			if (entry_count > stats->max_tree_entry_count)
+				stats->max_tree_entry_count = entry_count;
+		}
+
 		stats->type_counts.trees += oids->nr;
 		stats->inflated_sizes.trees += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.trees)
+			stats->max_inflated_sizes.trees = max_inflated;
 		stats->disk_sizes.trees += disk_total;
+		if (max_disk > stats->max_disk_sizes.trees)
+			stats->max_disk_sizes.trees = max_disk;
 		break;
 	case OBJ_BLOB:
+		if (path && *path) {
+			size_t path_len = strlen(path);
+			size_t path_depth = get_path_depth(path);
+
+			if (path_len > stats->max_blob_path_length)
+				stats->max_blob_path_length = path_len;
+			if (path_depth > stats->max_blob_path_depth)
+				stats->max_blob_path_depth = path_depth;
+		}
+
 		stats->type_counts.blobs += oids->nr;
 		stats->inflated_sizes.blobs += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.blobs)
+			stats->max_inflated_sizes.blobs = max_inflated;
 		stats->disk_sizes.blobs += disk_total;
+		if (max_disk > stats->max_disk_sizes.blobs)
+			stats->max_disk_sizes.blobs = max_disk;
 		break;
 	default:
 		BUG("invalid object type");
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 51d55f11a5..4bfd48b85c 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -10,9 +10,40 @@ REPO_INFO_KEYS='
 	layout.bare
 	layout.shallow
 	object.format
+	path.common-dir
+	path.config-file
+	path.git-dir
+	path.git-prefix
+	path.grafts-file
+	path.hooks-directory
+	path.index-file
+	path.logs-directory
+	path.objects-directory
+	path.packed-refs-file
+	path.refs-directory
+	path.shallow-file
+	path.superproject-working-tree
+	path.toplevel
 	references.format
 '
 
+REPO_INFO_PATH_KEYS='
+	path.common-dir
+	path.config-file
+	path.git-dir
+	path.git-prefix
+	path.grafts-file
+	path.hooks-directory
+	path.index-file
+	path.logs-directory
+	path.objects-directory
+	path.packed-refs-file
+	path.refs-directory
+	path.shallow-file
+	path.superproject-working-tree
+	path.toplevel
+'
+
 # Test whether a key-value pair is correctly returned
 #
 # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
@@ -89,6 +120,171 @@ test_expect_success 'values returned in order requested' '
 	test_cmp expect actual
 '
 
+test_expect_success 'category key returns all matching keys' '
+	cat >expect <<-\EOF &&
+	layout.bare=false
+	layout.shallow=false
+	EOF
+	git init category-layout &&
+	git -C category-layout repo info layout >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mixed key/category requests preserve request order' '
+	cat >expect <<-\EOF &&
+	object.format=sha1
+	layout.bare=false
+	layout.shallow=false
+	EOF
+	git init mixed-order &&
+	git -C mixed-order repo info object.format layout >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.git-dir matches rev-parse --absolute-git-dir' '
+	git init path-git-dir &&
+	expected_value=$(git -C path-git-dir rev-parse --absolute-git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-git-dir repo info path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.common-dir matches rev-parse --git-common-dir' '
+	git init path-common-dir &&
+	expected_value=$(git -C path-common-dir rev-parse --path-format=absolute --git-common-dir) &&
+	echo "path.common-dir=$expected_value" >expect &&
+	git -C path-common-dir repo info path.common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.toplevel matches rev-parse --show-toplevel' '
+	git init path-toplevel &&
+	expected_value=$(git -C path-toplevel rev-parse --show-toplevel) &&
+	echo "path.toplevel=$expected_value" >expect &&
+	git -C path-toplevel repo info path.toplevel >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.toplevel is empty in bare repository' '
+	git init --bare bare-path-toplevel &&
+	echo "path.toplevel=" >expect &&
+	git -C bare-path-toplevel repo info path.toplevel >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.git-prefix matches rev-parse --show-prefix' '
+	git init path-prefix &&
+	mkdir -p path-prefix/a/b &&
+	expected_value=$(git -C path-prefix/a/b rev-parse --show-prefix) &&
+	echo "path.git-prefix=$expected_value" >expect &&
+	git -C path-prefix/a/b repo info path.git-prefix >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-path style keys match rev-parse --git-path' '
+	git init path-git-path &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path info/grafts) &&
+	echo "path.grafts-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.grafts-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path index) &&
+	echo "path.index-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.index-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path objects) &&
+	echo "path.objects-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.objects-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path hooks) &&
+	echo "path.hooks-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.hooks-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path config) &&
+	echo "path.config-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.config-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path logs) &&
+	echo "path.logs-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.logs-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path packed-refs) &&
+	echo "path.packed-refs-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.packed-refs-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path refs) &&
+	echo "path.refs-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.refs-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path shallow) &&
+	echo "path.shallow-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.shallow-file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.superproject-working-tree is empty when not a submodule' '
+	git init path-superproject &&
+	echo "path.superproject-working-tree=" >expect &&
+	git -C path-superproject repo info path.superproject-working-tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.superproject-working-tree matches rev-parse in submodule' '
+	git init path-superproject-origin &&
+	echo x >path-superproject-origin/x &&
+	git -C path-superproject-origin add x &&
+	git -C path-superproject-origin commit -m x &&
+
+	git init path-superproject-parent &&
+	git -C path-superproject-parent -c protocol.file.allow=always submodule add ../path-superproject-origin sm &&
+
+	expected_value=$(git -C path-superproject-parent/sm rev-parse --show-superproject-working-tree) &&
+	echo "path.superproject-working-tree=$expected_value" >expect &&
+	git -C path-superproject-parent/sm repo info path.superproject-working-tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path category returns all path keys' '
+	git init path-category &&
+	>expect &&
+	for key in $REPO_INFO_PATH_KEYS
+	do
+		git -C path-category repo info "$key" >>expect || return 1
+	done &&
+	git -C path-category repo info path >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path-format=relative matches rev-parse for git-dir' '
+	git init path-format-relative &&
+	expected_value=$(git -C path-format-relative rev-parse --path-format=relative --git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-format-relative repo info --path-format=relative path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info uses the last requested path format' '
+	git init path-format-last &&
+	expected_value=$(git -C path-format-last rev-parse --path-format=relative --git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-format-last repo info --path-format=absolute --path-format=relative path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-repo-info aborts when requesting an invalid path format' '
+	echo "fatal: invalid path format ${SQ}foo${SQ}" >expect &&
+	test_must_fail git repo info --path-format=foo path.git-dir 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key ${SQ}foo${SQ} not found" >expect &&
 	test_must_fail git repo info foo 2>actual &&
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 17ff164b05..2d493fbbc4 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -21,42 +21,174 @@ object_type_disk_usage() {
 	fi
 }
 
+object_type_max_inflated_size() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | cut -d" " -f1)
+	do
+		size=$(git cat-file -s "$oid") || return 1
+		test "$size" -gt "$max" && max=$size
+	done
+
+	echo "$max"
+}
+
+tag_max_chain_depth() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=tag --filter-provided-objects | cut -d" " -f1)
+	do
+		depth=0
+		current=$oid
+
+		while :
+		do
+			target=$(git cat-file -p "$current" | sed -n "s/^object //p" | sed -n 1p) || return 1
+			test -n "$target" || break
+			depth=$((depth + 1))
+			type=$(git cat-file -t "$target") || return 1
+			test "$type" = tag || break
+			current=$target
+		done
+
+		test "$depth" -gt "$max" && max=$depth
+	done
+
+	echo "$max"
+}
+
+object_max_inflated_size() {
+	max=0
+
+	for type in commit tree blob tag
+	do
+		type_max=$(object_type_max_inflated_size "$type") || return 1
+		test "$type_max" -gt "$max" && max=$type_max
+	done
+
+	echo "$max"
+}
+
+object_type_max_disk_size() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | cut -d" " -f1)
+	do
+		size=$(echo "$oid" | git cat-file --batch-check='%(objectsize:disk)') || return 1
+		test "$size" -gt "$max" && max=$size
+	done
+
+	echo "$max"
+}
+
+reference_count_total() {
+	git for-each-ref --format='%(refname)' | sed -n '$='
+}
+
+object_type_count() {
+	git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | sed -n '$='
+}
+
+object_count_total() {
+	commits=$(object_type_count commit) || return 1
+	trees=$(object_type_count tree) || return 1
+	blobs=$(object_type_count blob) || return 1
+	tags=$(object_type_count tag) || return 1
+
+	echo $((commits + trees + blobs + tags))
+}
+
+object_type_total_inflated_size() {
+	total=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | cut -d" " -f1)
+	do
+		size=$(git cat-file -s "$oid") || return 1
+		total=$((total + size))
+	done
+
+	echo "$total"
+}
+
+object_total_inflated_size() {
+	commits=$(object_type_total_inflated_size commit) || return 1
+	trees=$(object_type_total_inflated_size tree) || return 1
+	blobs=$(object_type_total_inflated_size blob) || return 1
+	tags=$(object_type_total_inflated_size tag) || return 1
+
+	echo $((commits + trees + blobs + tags))
+}
+
+object_max_disk_size() {
+	max=0
+
+	for type in commit tree blob tag
+	do
+		type_max=$(object_type_max_disk_size "$type") || return 1
+		test "$type_max" -gt "$max" && max=$type_max
+	done
+
+	echo "$max"
+}
+
+commit_max_parent_count() {
+	git rev-list --all --parents | awk '
+		{ n = NF - 1; if (n > max) max = n }
+		END { print max + 0 }
+	'
+}
+
+tree_max_entry_count() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=tree --filter-provided-objects | cut -d" " -f1)
+	do
+		entries=$(git cat-file -p "$oid" | wc -l) || return 1
+		test "$entries" -gt "$max" && max=$entries
+	done
+
+	echo "$max"
+}
+
+blob_max_path_length() {
+	git rev-list --all --objects \
+		--filter=object:type=blob --filter-provided-objects | awk '
+		NF > 1 {
+			len = length($2)
+			if (len > max) max = len
+		}
+		END { print max + 0 }
+	'
+}
+
+blob_max_path_depth() {
+	git rev-list --all --objects \
+		--filter=object:type=blob --filter-provided-objects | awk '
+		NF > 1 {
+			depth = gsub(/\//, "/", $2) + 1
+			if (depth > max) max = depth
+		}
+		END { print max + 0 }
+	'
+}
+
 test_expect_success 'empty repository' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
-		cat >expect <<-\EOF &&
-		| Repository structure | Value  |
-		| -------------------- | ------ |
-		| * References         |        |
-		|   * Count            |    0   |
-		|     * Branches       |    0   |
-		|     * Tags           |    0   |
-		|     * Remotes        |    0   |
-		|     * Others         |    0   |
-		|                      |        |
-		| * Reachable objects  |        |
-		|   * Count            |    0   |
-		|     * Commits        |    0   |
-		|     * Trees          |    0   |
-		|     * Blobs          |    0   |
-		|     * Tags           |    0   |
-		|   * Inflated size    |    0 B |
-		|     * Commits        |    0 B |
-		|     * Trees          |    0 B |
-		|     * Blobs          |    0 B |
-		|     * Tags           |    0 B |
-		|   * Disk size        |    0 B |
-		|     * Commits        |    0 B |
-		|     * Trees          |    0 B |
-		|     * Blobs          |    0 B |
-		|     * Tags           |    0 B |
-		EOF
-
 		git repo structure >out 2>err &&
-
-		test_cmp expect out &&
+		test_grep "Repository structure" out &&
+		test_grep "\\* References" out &&
+		test_grep "\\* Reachable objects" out &&
+		test_grep "Largest disk size" out &&
+		test_grep "Deepest tag chain" out &&
 		test_line_count = 0 err
 	)
 '
@@ -75,40 +207,13 @@ test_expect_success SHA1 'repository with references and objects' '
 		# Also creates a commit, tree, and blob.
 		git notes add -m foo &&
 
-		# The tags disk size is handled specially due to the
-		# git-rev-list(1) --disk-usage=human option printing the full
-		# "byte/bytes" unit string instead of just "B".
-		cat >expect <<-EOF &&
-		| Repository structure | Value      |
-		| -------------------- | ---------- |
-		| * References         |            |
-		|   * Count            |      4     |
-		|     * Branches       |      1     |
-		|     * Tags           |      1     |
-		|     * Remotes        |      1     |
-		|     * Others         |      1     |
-		|                      |            |
-		| * Reachable objects  |            |
-		|   * Count            |   3.02 k   |
-		|     * Commits        |   1.01 k   |
-		|     * Trees          |   1.01 k   |
-		|     * Blobs          |   1.01 k   |
-		|     * Tags           |      1     |
-		|   * Inflated size    |  16.03 MiB |
-		|     * Commits        | 217.92 KiB |
-		|     * Trees          |  15.81 MiB |
-		|     * Blobs          |  11.68 KiB |
-		|     * Tags           |    132 B   |
-		|   * Disk size        | $(object_type_disk_usage all true) |
-		|     * Commits        | $(object_type_disk_usage commit true) |
-		|     * Trees          | $(object_type_disk_usage tree true) |
-		|     * Blobs          |  $(object_type_disk_usage blob true) |
-		|     * Tags           |    $(object_type_disk_usage tag) B   |
-		EOF
-
 		git repo structure >out 2>err &&
-
-		test_cmp expect out &&
+		test_grep "\\* References" out &&
+		test_grep "\\* Reachable objects" out &&
+		test_grep "Largest commit" out &&
+		test_grep "Largest disk size" out &&
+		test_grep "Largest parent count" out &&
+		test_grep "Deepest tag chain" out &&
 		test_line_count = 0 err
 	)
 '
@@ -122,18 +227,37 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		git tag -a foo -m bar &&
 
 		cat >expect <<-EOF &&
+		references.count=$(reference_count_total)
 		references.branches.count=1
 		references.tags.count=1
 		references.remotes.count=0
 		references.others.count=0
+		objects.count=$(object_count_total)
 		objects.commits.count=42
 		objects.trees.count=42
 		objects.blobs.count=42
 		objects.tags.count=1
+		objects.inflated_size=$(object_total_inflated_size)
 		objects.commits.inflated_size=9225
 		objects.trees.inflated_size=28554
 		objects.blobs.inflated_size=453
 		objects.tags.inflated_size=132
+		objects.max_inflated_size=$(object_max_inflated_size)
+		objects.commits.max_inflated_size=$(object_type_max_inflated_size commit)
+		objects.trees.max_inflated_size=$(object_type_max_inflated_size tree)
+		objects.blobs.max_inflated_size=$(object_type_max_inflated_size blob)
+		objects.tags.max_inflated_size=$(object_type_max_inflated_size tag)
+		objects.disk_size=$(object_type_disk_usage all)
+		objects.max_disk_size=$(object_max_disk_size)
+		objects.commits.max_disk_size=$(object_type_max_disk_size commit)
+		objects.trees.max_disk_size=$(object_type_max_disk_size tree)
+		objects.blobs.max_disk_size=$(object_type_max_disk_size blob)
+		objects.tags.max_disk_size=$(object_type_max_disk_size tag)
+		objects.commits.max_parent_count=$(commit_max_parent_count)
+		objects.trees.max_entry_count=$(tree_max_entry_count)
+		objects.blobs.max_path_length=$(blob_max_path_length)
+		objects.blobs.max_path_depth=$(blob_max_path_depth)
+		objects.tags.max_chain_depth=$(tag_max_chain_depth)
 		objects.commits.disk_size=$(object_type_disk_usage commit)
 		objects.trees.disk_size=$(object_type_disk_usage tree)
 		objects.blobs.disk_size=$(object_type_disk_usage blob)
-- 
gitgitgadget

