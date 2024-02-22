Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82E12D1E1
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643954; cv=none; b=hRpEHZdBIn0oBsb03Z0jgObrTkwyR1Hmw5vBBvNE6jCht0ICfq5qlbWOLDtKZ0XL/W6OiWtrpirv429agelRfh2xV0cPbSq3m7kT+/66Qe2DDWBgIuhdIrN3w2ba4I9En79REtwrMpYCjb6ORsAzoJvrFJfFlvHFq9ZoTJ4k1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643954; c=relaxed/simple;
	bh=WTzgZTndMtz4AsJ1jS8hxG1j/2q41pjqPTaSHG1xJRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XMNuLx8+IdxrIPGG3/e0zG3IddbFGsAmMki6RgfUAQGkGDMNV62lEcU0RPswZ8I7l/r1JKBN9rPHo/P0Foq9FJH+TYyKH6XN7yC3/0mGQ+RjCKceQ6ZOygodux21i7Uq45f96tyr4/lC74rRvEJzav62I9lBl/PN+XpU5MZh440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCLfEsBz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCLfEsBz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-603c0e020a6so4306037b3.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 15:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708643951; x=1709248751; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRr+OBcq3bSkQ/mU8Y4FAnUuHwXStx7Y3ft6ZPK0glA=;
        b=WCLfEsBztRNVIGBtcKK4JZxdQh96qg88EY2a7nyzLAuWRkXIyrZ5K/eYC0f7vz3KyZ
         8AroVSA57AURHw87L2YzQqqF5KVgjQck0Je/U0vmzwzCsqT1cCWBgWqFF8vVCIbDVjpQ
         TiFrXp1JHO/HhWsOU98S0Q9lgQxReOgA8GKTezEzA+Er7LRM+L3DRg26wmttEQk/b9ig
         AHYNsDt61Qzf9j+JFQqGCJls5eCi7mKE7nQt1jm4QOgNei3XAXkgNYKN93uIi2wVULj3
         Q7L3Fl0k5i8Zan7CbLA6jM2ldOFduxyrsDiIilqOQbnyWBWyYoml2r5+K59fYXbZAwuJ
         32DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708643951; x=1709248751;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRr+OBcq3bSkQ/mU8Y4FAnUuHwXStx7Y3ft6ZPK0glA=;
        b=Ice11RCZTCeDsVjMdH9uM2V78Mkjwex7/XgAS2W3QISKyezjjRufIJ/r1RlixHZ48J
         464jPbyyQOtcUPWMT97+dL8uZ24S0hSPL/3n23wy9V2+u4AlHj2HHGy7YxxoRQ6F9SDm
         rYg8h8XeOocGqaAQul6A6U1HlNa54KGY84zDcpnEC0vXycRRuKj6aVM+QVihFhUKZ9IS
         RCiSjp0Dj0hOlN2ZPMi7e3U1pIawtDSkxHgw9lMHQpwLElzPZSAOm1MOibSZ7hqNZvub
         w2HDWnsVJ7lixz3kTAtkUgFFp0KjpU0TX6S8+4WOMnaxrRJFbarPzmbwjE7AoTIqbhf/
         jGDQ==
X-Gm-Message-State: AOJu0YylJvX2UK2+eSY0NsI2elRgRdvRqJueKBvdCeQ3p86BNoTW/PGp
	yPWT8evtsXioUUlnA6MmbQmnw/cLCyycD5+jODVal7udGhHruYAa+viZS5kLUE9jjJA2geG1zdI
	P3wfrG/qmdT5EoYVZvUN12n0nXIKyUHwhMk1dFBhLu+vjDWxdoKKh5ctAeWcwLRBVX5dDNNxy+n
	tDEHaAGM5viUD2FlKaRGAPaVD8I6xetaH1nGMg8gA=
X-Google-Smtp-Source: AGHT+IF89cGHJP18UnTNp1zghWnsZqCfqHe37Fya9dlc+6xGz5U9aO4uHHdNW2+iYR0BHbePs42u8rBayLiXUg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:4ac4:71c0:92c1:4c83])
 (user=steadmon job=sendgmr) by 2002:a0d:dd42:0:b0:608:9b1f:5bab with SMTP id
 g63-20020a0ddd42000000b006089b1f5babmr139666ywe.9.1708643951366; Thu, 22 Feb
 2024 15:19:11 -0800 (PST)
Date: Thu, 22 Feb 2024 15:19:06 -0800
In-Reply-To: <cover.1708643825.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708643825.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <57344e9aa39b1fb1abf8275c6504cf80157ae0e6.1708643825.git.steadmon@google.com>
Subject: [PATCH 1/2] commit-graph: add `git commit-graph clear` subcommand
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In the event the commit graph becomes corrupted, one option for recovery
is to simply delete it and then rewrite it from scratch. However, this
requires users to manually delete files and directories under .git/,
which is generally discouraged.

Add a new subcommand `git commit-graph clear` to provide a convenient
option for removing the commit graph. Include tests for both single-file
and split-file commit graphs. While we're at it, replace various cleanup
steps in the commit graph tests with `git commit-graph clear`.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/git-commit-graph.txt |  5 ++++
 builtin/commit-graph.c             | 40 ++++++++++++++++++++++++++++++
 commit-graph.c                     | 27 ++++++++++++++++++++
 commit-graph.h                     |  1 +
 t/t5318-commit-graph.sh            | 13 ++++++++--
 t/t5324-split-commit-graph.sh      | 26 +++++++++++++------
 6 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 903b16830e..0c96c428e6 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 			[--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]
 			[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]
 			<split-options>
+'git commit-graph clear' [--object-dir <dir>]
 
 
 DESCRIPTION
@@ -114,6 +115,10 @@ database. Used to check for corrupted data.
 With the `--shallow` option, only check the tip commit-graph file in
 a chain of split commit-graphs.
 
+'clear'::
+
+Delete the commit graph file(s) and directory, if any exist.
+
 
 EXAMPLES
 --------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 7102ee90a0..0e2fecae50 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -23,6 +23,9 @@
 	   "                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]\n" \
 	   "                       <split-options>")
 
+#define BUILTIN_COMMIT_GRAPH_CLEAR_USAGE \
+	N_("git commit-graph clear [--object-dir <dir>]")
+
 static const char * builtin_commit_graph_verify_usage[] = {
 	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
 	NULL
@@ -33,9 +36,15 @@ static const char * builtin_commit_graph_write_usage[] = {
 	NULL
 };
 
+static const char * builtin_commit_graph_clear_usage[] = {
+	BUILTIN_COMMIT_GRAPH_CLEAR_USAGE,
+	NULL
+};
+
 static char const * const builtin_commit_graph_usage[] = {
 	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
 	BUILTIN_COMMIT_GRAPH_WRITE_USAGE,
+	BUILTIN_COMMIT_GRAPH_CLEAR_USAGE,
 	NULL,
 };
 
@@ -331,12 +340,43 @@ static int graph_write(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static int graph_clear(int argc, const char **argv, const char *prefix) {
+	int ret = 0;
+	struct object_directory *odb = NULL;
+	char *path;
+	static struct option builtin_commit_graph_clear_options[] = {
+		OPT_END(),
+	};
+	struct option *options = add_common_options(builtin_commit_graph_clear_options);
+
+	trace2_cmd_mode("clear");
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_commit_graph_clear_options,
+			     builtin_commit_graph_clear_usage, 0);
+
+	if (!opts.obj_dir)
+		opts.obj_dir = get_object_directory();
+
+	odb = find_odb(the_repository, opts.obj_dir);
+
+	path = get_commit_graph_filename(odb);
+	ret |= unlink_or_warn(path);
+	ret |= rm_commit_graph_chain(odb);
+
+	FREE_AND_NULL(options);
+	free(path);
+
+	return ret;
+}
+
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_commit_graph_options[] = {
 		OPT_SUBCOMMAND("verify", &fn, graph_verify),
 		OPT_SUBCOMMAND("write", &fn, graph_write),
+		OPT_SUBCOMMAND("clear", &fn, graph_clear),
 		OPT_END(),
 	};
 	struct option *options = parse_options_concat(builtin_commit_graph_options, common_opts);
diff --git a/commit-graph.c b/commit-graph.c
index 45417d7412..ca84423042 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -206,6 +206,33 @@ char *get_commit_graph_chain_filename(struct object_directory *odb)
 	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
 }
 
+int rm_commit_graph_chain(struct object_directory *odb)
+{
+	int ret = 0;
+	struct strbuf chain_dir = STRBUF_INIT, file_path = STRBUF_INIT;
+	struct dirent *d;
+	DIR *dir;
+
+	strbuf_addf(&chain_dir, "%s/info/commit-graphs/", odb->path);
+	strbuf_addbuf(&file_path, &chain_dir);
+	dir = opendir(chain_dir.buf);
+	if (!dir)
+		goto cleanup;
+	while ((d = readdir(dir))) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		strbuf_setlen(&file_path, chain_dir.len);
+		strbuf_addstr(&file_path, d->d_name);
+		ret |= unlink_or_warn(file_path.buf);
+	}
+	closedir(dir);
+	rmdir_or_warn(chain_dir.buf);
+cleanup:
+	strbuf_release(&chain_dir);
+	strbuf_release(&file_path);
+	return ret;
+}
+
 static struct commit_graph *alloc_commit_graph(void)
 {
 	struct commit_graph *g = xcalloc(1, sizeof(*g));
diff --git a/commit-graph.h b/commit-graph.h
index e519cb81cb..1a6002767c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -31,6 +31,7 @@ struct string_list;
 
 char *get_commit_graph_filename(struct object_directory *odb);
 char *get_commit_graph_chain_filename(struct object_directory *odb);
+int rm_commit_graph_chain(struct object_directory *odb);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a2b4442660..35354bddcb 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -397,7 +397,7 @@ test_expect_success 'warn on improper hash version' '
 test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow chunk' '
 	UNIX_EPOCH_ZERO="@0 +0000" &&
 	FUTURE_DATE="@4147483646 +0000" &&
-	rm -f full/.git/objects/info/commit-graph &&
+	git -C full commit-graph clear &&
 	test_commit -C full --date "$FUTURE_DATE" future-1 &&
 	test_commit -C full --date "$UNIX_EPOCH_ZERO" old-1 &&
 	git -C full commit-graph write --reachable &&
@@ -824,7 +824,7 @@ test_expect_success 'overflow during generation version upgrade' '
 
 corrupt_chunk () {
 	graph=full/.git/objects/info/commit-graph &&
-	test_when_finished "rm -rf $graph" &&
+	test_when_finished "git -C full commit-graph clear" &&
 	git -C full commit-graph write --reachable &&
 	corrupt_chunk_file $graph "$@"
 }
@@ -945,4 +945,13 @@ test_expect_success 'stale commit cannot be parsed when traversing graph' '
 	)
 '
 
+test_expect_success 'commit-graph clear removes files' '
+	git -C full commit-graph write &&
+	git -C full commit-graph verify &&
+	test_path_is_file full/.git/objects/info/commit-graph &&
+	git -C full commit-graph clear &&
+	! test_path_exists full/.git/objects/info/commit-graph &&
+	! test_path_exists full/.git/objects/info/commit-graphs
+'
+
 test_done
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 281266f788..ab5bc67fb6 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -120,7 +120,7 @@ test_expect_success 'fork and fail to base a chain on a commit-graph file' '
 	git clone . fork &&
 	(
 		cd fork &&
-		rm .git/objects/info/commit-graph &&
+		git commit-graph clear &&
 		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
 		test_commit new-commit &&
 		git commit-graph write --reachable --split &&
@@ -177,7 +177,7 @@ test_expect_success 'create fork and chain across alternate' '
 	(
 		cd fork &&
 		git config core.commitGraph true &&
-		rm -rf $graphdir &&
+		git commit-graph clear &&
 		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
 		test_commit 13 &&
 		git branch commits/13 &&
@@ -387,7 +387,7 @@ test_expect_success 'verify across alternates' '
 	git clone --no-hardlinks . verify-alt &&
 	(
 		cd verify-alt &&
-		rm -rf $graphdir &&
+		git commit-graph clear &&
 		altdir="$(pwd)/../.git/objects" &&
 		echo "$altdir" >.git/objects/info/alternates &&
 		git commit-graph verify --object-dir="$altdir/" &&
@@ -435,7 +435,7 @@ test_expect_success 'split across alternate where alternate is not split' '
 	git clone --no-hardlinks . alt-split &&
 	(
 		cd alt-split &&
-		rm -f .git/objects/info/commit-graph &&
+		git commit-graph clear &&
 		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
 		test_commit 18 &&
 		git commit-graph write --reachable --split &&
@@ -446,7 +446,7 @@ test_expect_success 'split across alternate where alternate is not split' '
 
 test_expect_success '--split=no-merge always writes an incremental' '
 	test_when_finished rm -rf a b &&
-	rm -rf $graphdir $infodir/commit-graph &&
+	git commit-graph clear &&
 	git reset --hard commits/2 &&
 	git rev-list HEAD~1 >a &&
 	git rev-list HEAD >b &&
@@ -456,7 +456,7 @@ test_expect_success '--split=no-merge always writes an incremental' '
 '
 
 test_expect_success '--split=replace replaces the chain' '
-	rm -rf $graphdir $infodir/commit-graph &&
+	git commit-graph clear &&
 	git reset --hard commits/3 &&
 	git rev-list -1 HEAD~2 >a &&
 	git rev-list -1 HEAD~1 >b &&
@@ -490,7 +490,7 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'handles file descriptor exhaustion'
 while read mode modebits
 do
 	test_expect_success POSIXPERM "split commit-graph respects core.sharedrepository $mode" '
-		rm -rf $graphdir $infodir/commit-graph &&
+		git commit-graph clear &&
 		git reset --hard commits/1 &&
 		test_config core.sharedrepository "$mode" &&
 		git commit-graph write --split --reachable &&
@@ -508,7 +508,7 @@ done <<\EOF
 EOF
 
 test_expect_success '--split=replace with partial Bloom data' '
-	rm -rf $graphdir $infodir/commit-graph &&
+	git commit-graph clear &&
 	git reset --hard commits/3 &&
 	git rev-list -1 HEAD~2 >a &&
 	git rev-list -1 HEAD~1 >b &&
@@ -718,4 +718,14 @@ test_expect_success 'write generation data chunk when commit-graph chain is repl
 	)
 '
 
+
+test_expect_success 'commit-graph clear removes files' '
+	git commit-graph write &&
+	git commit-graph verify &&
+	! test_dir_is_empty .git/objects/info/commit-graphs &&
+	git commit-graph clear &&
+	! test_path_exists .git/objects/info/commit-graph &&
+	! test_path_exists .git/objects/info/commit-graphs
+'
+
 test_done
-- 
2.44.0.rc0.258.g7320e95886-goog

