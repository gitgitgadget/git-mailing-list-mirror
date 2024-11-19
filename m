Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4D1D1507
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030627; cv=none; b=u8pWPCbLJuaM+pVNugL3M0zztYx/8ZKc0f/+tMR77qcHz4VA6ffNEgjm/yzgXwAcqGSqXGUXTgW81nF5+fOlT16+y9XWKGPCEbXLPb6pqB95aKux35PAGtG9C7Fb7OgBW5nYsCCp1ke+UJpao5M1PTbW3hhJeQ8FENeh5m/9tpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030627; c=relaxed/simple;
	bh=cnYpYjLBTIDxdGMCq3ftfxN2ANuqhy1kTRobzTcW9PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=csEBb594U7MsKEaHs1rYFmIZ/Oy1Sr9yJ+Iy7Q8E63Vthbhsxa3vmn2RpyI+xD1RlNqGl7i+f5CWWvgNXm1+FfY4sCEsOCxVbli+hawd0HHSq5FqYwA03TYWCnoWJwG639dDgku4bGPmKM0GTybkipbUWt3zXJnIxP4x95B7UHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn17V7Ss; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn17V7Ss"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ec86a67feso199518266b.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030620; x=1732635420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ovtm9gY84fKxE73HsC17sHE1y34He/t9h9sNO1xW/I4=;
        b=Bn17V7SsLUVsFqkGNcxS7S/YAHu1WIch5/i7FMMRb6SBVQY2kdgvW+vrGlmeycxuog
         bM4i+3WpE18I3mYkXKhtAYlLuvknMe5J8l5AegpjLsZhh4fIHK91CSPqWpc6eGSxneCW
         pQP9eJsuzoA4ebn1TebzUBdFA2KzztmkGvvcnkP71JA50aOJH2TM9FD4ehhEAwcIbUD6
         VgW1TyQ2hreFU0JwZIDTx/oowR+tx3/8RssDZduZp+k0V5PimeyGbfurRRxbP86lqp7Y
         zEQ/zO8ORwcRvMGwKjt2vNfEIGKoFrtEOMztVuYwmYonWvdyBwsPAnInBaq9+L1X4MUm
         ehgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030620; x=1732635420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ovtm9gY84fKxE73HsC17sHE1y34He/t9h9sNO1xW/I4=;
        b=PIrd3GKESvqLniqp7Vr5cgogDa6XvF/L1LBTZ5ptzFQqZQD3E4qAcpmK9WSNoBl2YO
         eCKD6xDxuZ/f4/Plo9Wqur1xUzcvdfi7FBtE/I4oNYbEdsYqmFWyLdNM0WTPZK+7UOVI
         +wxwGV0HTMXy1+ZM7jAzP7JbFupdO3eCI1hubSUsdnzUVSV4jvZCOgl2UOpZCY7FRIK2
         ltXi6d0p2DIBCaiBXP0yGyJUZMRyJPfQRdT1/Xa/M4076p9ESzdJNRxix+8VJ2k5eiv3
         5SBLyMxtvTysgndoF1geBr/ACPCRkvdDYes0Owv3Mz/E+oD89SaTsYoNVqbKx79IO1Cz
         8L3g==
X-Gm-Message-State: AOJu0YzUcyiAbMMUBaxfAQwY6eTsTSD4Ap3K2TQ2XdrTR1IT8BKO7AOk
	9Brjv62w2e2ZeLSYaxefteVLjY/1OE+8OZFhX0rYJqkxx62+ePZ+zo932+uu
X-Google-Smtp-Source: AGHT+IFReoUyxiFzZBLxDrSowyxdAq5rbIiwf4cu3Che/YZLoPtMYLjbah19YhbCPRxncyVfD6J+cg==
X-Received: by 2002:a17:907:6095:b0:a99:fc3d:7c76 with SMTP id a640c23a62f3a-aa483529883mr1325257966b.37.1732030619622;
        Tue, 19 Nov 2024 07:36:59 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:36:59 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:40 +0100
Subject: [PATCH v2 01/10] builtin: pass repository to sub commands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-1-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=53123;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=cnYpYjLBTIDxdGMCq3ftfxN2ANuqhy1kTRobzTcW9PU=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCXGtrnlbDehLzUHt6frLNsMh/5VPAQMHsig
 W9sj1EIxAqJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywlwAKCRA+1Z8kjkaM
 f0wLC/9NKKELr+gdBJnDTuenxv0sZxyAXDW4pecgf6SSPXFNtQHYGiSrSZCJ+er6OcPLPcIoz8e
 vlteMluyHotHQ5vZw6lMkvMDJilpI5kgPVUr8S1X1VWPVrIi4etMT+Jq3pLQTF2mvhl4y0t2igc
 fcEyNKqU69kUxL5h02djqAdv/X0u6Y8n3jMe2WLyEsnAYL6KvnyfxrDCn2UWpd23Wi8j/1HNtU8
 Io1VXCj96FT714cFpkr9c3v04nxSpr6nQsNCDU42tF8EulELBkBW8c7p7RxWLt000+FwCjuW86e
 RIeQUR56OeHHz79E+a1xA0whbUA0bOhOz+CQ8MkKwgVbDWFOyp0lcgW1FyxMifXAneLALtFtwkg
 m3U0R+/jSBO8+kQHxVWaHSj4qnI40SpJy3ieiFzApQLadFegzZZziElq4H9grMCMWYMZkue8UCW
 1T1G9vY7eqEacu3gqKu5yyhQuKQnmZKVhuiNJuwsG+JtQa66vsYc0oiETr/GG11/H1E7Y=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 9b1cb5070f (builtin: add a repository parameter for builtin
functions, 2024-09-13) the repository was passed down to all builtin
commands. This allowed the repository to be passed down to lower layers
without depending on the global `the_repository` variable.

Continue this work by also passing down the repository parameter from
the command to sub-commands. In the upcoming commit, utilize this to
remove global variable usage in `midx-write.c`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/bisect.c              | 32 +++++++++++++++++++-----------
 builtin/bundle.c              | 16 +++++++++------
 builtin/commit-graph.c        | 10 ++++++----
 builtin/config.c              | 25 ++++++++++++++---------
 builtin/gc.c                  | 21 ++++++++++++--------
 builtin/hook.c                |  7 ++++---
 builtin/multi-pack-index.c    | 16 +++++++++------
 builtin/notes.c               | 36 +++++++++++++++++++++------------
 builtin/reflog.c              | 17 ++++++++++------
 builtin/refs.c                | 10 ++++++----
 builtin/remote.c              | 34 +++++++++++++++++++++-----------
 builtin/sparse-checkout.c     | 25 ++++++++++++++---------
 builtin/stash.c               | 39 +++++++++++++++++++++++-------------
 builtin/submodule--helper.c   | 46 ++++++++++++++++++++++++++++---------------
 builtin/worktree.c            | 28 ++++++++++++++++----------
 parse-options.h               |  4 +++-
 t/helper/test-parse-options.c |  8 +++++---
 17 files changed, 239 insertions(+), 135 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 21d17a6c1a83e51fb82b53703b95d89bd9028830..8166d4abf532fbc95aaac71198e9722684ccf7f5 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1312,7 +1312,8 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 	return res;
 }
 
-static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED,
+			     struct repository *repo UNUSED)
 {
 	if (argc > 1)
 		return error(_("'%s' requires either no argument or a commit"),
@@ -1320,7 +1321,8 @@ static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNU
 	return bisect_reset(argc ? argv[0] : NULL);
 }
 
-static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
+			     struct repository *repo UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1333,7 +1335,8 @@ static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNU
 	return res;
 }
 
-static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED,
+			     struct repository *repo UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1344,7 +1347,8 @@ static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNU
 	return res;
 }
 
-static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *prefix)
+static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *prefix,
+			    struct repository *repo UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1358,12 +1362,15 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	return res;
 }
 
-static int cmd_bisect__log(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED)
+static int cmd_bisect__log(int argc UNUSED, const char **argv UNUSED,
+			   const char *prefix UNUSED,
+			   struct repository *repo UNUSED)
 {
 	return bisect_log();
 }
 
-static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UNUSED,
+			      struct repository *repo UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1376,7 +1383,8 @@ static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UN
 	return res;
 }
 
-static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUSED,
+			    struct repository *repo UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1388,7 +1396,8 @@ static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUS
 	return res;
 }
 
-static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix UNUSED,
+				 struct repository *repo UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1399,7 +1408,8 @@ static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix
 	return res;
 }
 
-static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSED,
+			   struct repository *repo UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1415,7 +1425,7 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 int cmd_bisect(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       struct repository *repo)
 {
 	int res = 0;
 	parse_opt_subcommand_fn *fn = NULL;
@@ -1451,7 +1461,7 @@ int cmd_bisect(int argc,
 	} else {
 		argc--;
 		argv++;
-		res = fn(argc, argv, prefix);
+		res = fn(argc, argv, prefix, repo);
 	}
 
 	return is_bisect_success(res) ? 0 : -res;
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 127518c2a8d3c4ec0bde62f1932e964ce9bcf66f..3f14754197c847e7a4e98b607c1a24df2b053daf 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -67,7 +67,8 @@ static int parse_options_cmd_bundle(int argc,
 	return argc;
 }
 
-static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
+static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
+			     struct repository *repo UNUSED) {
 	struct strvec pack_opts = STRVEC_INIT;
 	int version = -1;
 	int ret;
@@ -123,7 +124,8 @@ static int open_bundle(const char *path, struct bundle_header *header,
 	return read_bundle_header(path, header);
 }
 
-static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
+static int cmd_bundle_verify(int argc, const char **argv, const char *prefix,
+			     struct repository *repo UNUSED) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int quiet = 0;
@@ -164,7 +166,8 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 	return ret;
 }
 
-static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix) {
+static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix,
+				 struct repository *repo UNUSED) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int ret;
@@ -189,7 +192,8 @@ static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix
 	return ret;
 }
 
-static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix) {
+static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix,
+			       struct repository *repo UNUSED) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int ret;
@@ -231,7 +235,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 int cmd_bundle(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -247,5 +251,5 @@ int cmd_bundle(int argc,
 
 	packet_trace_identity("bundle");
 
-	return !!fn(argc, argv, prefix);
+	return !!fn(argc, argv, prefix, repo);
 }
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 7c991db6eb48ad6e935727a079abac02bb358f8a..bd70d052e706b6e34b5aaaceef158c63ea4863d5 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -62,7 +62,8 @@ static struct option *add_common_options(struct option *to)
 	return parse_options_concat(common_opts, to);
 }
 
-static int graph_verify(int argc, const char **argv, const char *prefix)
+static int graph_verify(int argc, const char **argv, const char *prefix,
+			struct repository *repo UNUSED)
 {
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb = NULL;
@@ -214,7 +215,8 @@ static int git_commit_graph_write_config(const char *var, const char *value,
 	return 0;
 }
 
-static int graph_write(int argc, const char **argv, const char *prefix)
+static int graph_write(int argc, const char **argv, const char *prefix,
+		       struct repository *repo UNUSED)
 {
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
@@ -333,7 +335,7 @@ static int graph_write(int argc, const char **argv, const char *prefix)
 int cmd_commit_graph(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_commit_graph_options[] = {
@@ -352,5 +354,5 @@ int cmd_commit_graph(int argc,
 			     builtin_commit_graph_usage, 0);
 	FREE_AND_NULL(options);
 
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/builtin/config.c b/builtin/config.c
index cba702210815b716a5c6c93ebb69d8c485901e43..16e6e3055598f1355714dc6de458b662870214c0 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -826,7 +826,8 @@ static void display_options_init(struct config_display_options *opts)
 	}
 }
 
-static int cmd_config_list(int argc, const char **argv, const char *prefix)
+static int cmd_config_list(int argc, const char **argv, const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct config_display_options display_opts = CONFIG_DISPLAY_OPTIONS_INIT;
@@ -861,7 +862,8 @@ static int cmd_config_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int cmd_config_get(int argc, const char **argv, const char *prefix)
+static int cmd_config_get(int argc, const char **argv, const char *prefix,
+			  struct repository *repo UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct config_display_options display_opts = CONFIG_DISPLAY_OPTIONS_INIT;
@@ -915,7 +917,8 @@ static int cmd_config_get(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int cmd_config_set(int argc, const char **argv, const char *prefix)
+static int cmd_config_set(int argc, const char **argv, const char *prefix,
+			  struct repository *repo UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	const char *value_pattern = NULL, *comment_arg = NULL;
@@ -973,7 +976,8 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int cmd_config_unset(int argc, const char **argv, const char *prefix)
+static int cmd_config_unset(int argc, const char **argv, const char *prefix,
+			    struct repository *repo UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	const char *value_pattern = NULL;
@@ -1010,7 +1014,8 @@ static int cmd_config_unset(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int cmd_config_rename_section(int argc, const char **argv, const char *prefix)
+static int cmd_config_rename_section(int argc, const char **argv, const char *prefix,
+				     struct repository *repo UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct option opts[] = {
@@ -1039,7 +1044,8 @@ static int cmd_config_rename_section(int argc, const char **argv, const char *pr
 	return ret;
 }
 
-static int cmd_config_remove_section(int argc, const char **argv, const char *prefix)
+static int cmd_config_remove_section(int argc, const char **argv, const char *prefix,
+				     struct repository *repo UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct option opts[] = {
@@ -1099,7 +1105,8 @@ static int show_editor(struct config_location_options *opts)
 	return 0;
 }
 
-static int cmd_config_edit(int argc, const char **argv, const char *prefix)
+static int cmd_config_edit(int argc, const char **argv, const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct option opts[] = {
@@ -1395,7 +1402,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 int cmd_config(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       struct repository *repo)
 {
 	parse_opt_subcommand_fn *subcommand = NULL;
 	struct option subcommand_opts[] = {
@@ -1422,7 +1429,7 @@ int cmd_config(int argc,
 	if (subcommand) {
 		argc = parse_options(argc, argv, prefix, subcommand_opts, builtin_config_usage,
 		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
-		return subcommand(argc, argv, prefix);
+		return subcommand(argc, argv, prefix, repo);
 	}
 
 	return cmd_config_actions(argc, argv, prefix);
diff --git a/builtin/gc.c b/builtin/gc.c
index 09802eb989471be242a4b2d74606b0998fdd2b11..50ccab172365d22c8f89e9f6fb822fca948878e7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1567,7 +1567,8 @@ static int task_option_parse(const struct option *opt UNUSED,
 	return 0;
 }
 
-static int maintenance_run(int argc, const char **argv, const char *prefix)
+static int maintenance_run(int argc, const char **argv, const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	int i;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
@@ -1629,7 +1630,8 @@ static char const * const builtin_maintenance_register_usage[] = {
 	NULL
 };
 
-static int maintenance_register(int argc, const char **argv, const char *prefix)
+static int maintenance_register(int argc, const char **argv, const char *prefix,
+				struct repository *repo UNUSED)
 {
 	char *config_file = NULL;
 	struct option options[] = {
@@ -1693,7 +1695,8 @@ static char const * const builtin_maintenance_unregister_usage[] = {
 	NULL
 };
 
-static int maintenance_unregister(int argc, const char **argv, const char *prefix)
+static int maintenance_unregister(int argc, const char **argv, const char *prefix,
+				  struct repository *repo UNUSED)
 {
 	int force = 0;
 	char *config_file = NULL;
@@ -2923,7 +2926,8 @@ static const char *const builtin_maintenance_start_usage[] = {
 	NULL
 };
 
-static int maintenance_start(int argc, const char **argv, const char *prefix)
+static int maintenance_start(int argc, const char **argv, const char *prefix,
+			     struct repository *repo)
 {
 	struct maintenance_start_opts opts = { 0 };
 	struct option options[] = {
@@ -2946,7 +2950,7 @@ static int maintenance_start(int argc, const char **argv, const char *prefix)
 	if (update_background_schedule(&opts, 1))
 		die(_("failed to set up maintenance schedule"));
 
-	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL))
+	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL, repo))
 		warning(_("failed to add repo to global config"));
 	return 0;
 }
@@ -2956,7 +2960,8 @@ static const char *const builtin_maintenance_stop_usage[] = {
 	NULL
 };
 
-static int maintenance_stop(int argc, const char **argv, const char *prefix)
+static int maintenance_stop(int argc, const char **argv, const char *prefix,
+			    struct repository *repo UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -2976,7 +2981,7 @@ static const char * const builtin_maintenance_usage[] = {
 int cmd_maintenance(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_maintenance_options[] = {
@@ -2990,5 +2995,5 @@ int cmd_maintenance(int argc,
 
 	argc = parse_options(argc, argv, prefix, builtin_maintenance_options,
 			     builtin_maintenance_usage, 0);
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/builtin/hook.c b/builtin/hook.c
index 367ef3e0b893fa16756880395151a82ed053acd8..672d2e37e845a2118aca1c4417a837138c250590 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -19,7 +19,8 @@ static const char * const builtin_hook_run_usage[] = {
 	NULL
 };
 
-static int run(int argc, const char **argv, const char *prefix)
+static int run(int argc, const char **argv, const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	int i;
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
@@ -70,7 +71,7 @@ static int run(int argc, const char **argv, const char *prefix)
 int cmd_hook(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo UNUSED)
+	     struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_hook_options[] = {
@@ -81,5 +82,5 @@ int cmd_hook(int argc,
 	argc = parse_options(argc, argv, NULL, builtin_hook_options,
 			     builtin_hook_usage, 0);
 
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index d159ed1314d912a390ed725659b3abe7c821b83f..85e40a4b6d3e47e9ec1ec27c094455e5ba75b5b0 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -119,7 +119,8 @@ static void read_packs_from_stdin(struct string_list *to)
 }
 
 static int cmd_multi_pack_index_write(int argc, const char **argv,
-				      const char *prefix)
+				      const char *prefix,
+				      struct repository *repo UNUSED)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_write_options[] = {
@@ -183,7 +184,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 }
 
 static int cmd_multi_pack_index_verify(int argc, const char **argv,
-				       const char *prefix)
+				       const char *prefix,
+				       struct repository *repo UNUSED)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_verify_options[] = {
@@ -210,7 +212,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 }
 
 static int cmd_multi_pack_index_expire(int argc, const char **argv,
-				       const char *prefix)
+				       const char *prefix,
+				       struct repository *repo UNUSED)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_expire_options[] = {
@@ -237,7 +240,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 }
 
 static int cmd_multi_pack_index_repack(int argc, const char **argv,
-				       const char *prefix)
+				       const char *prefix,
+				       struct repository *repo UNUSED)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_repack_options[] = {
@@ -271,7 +275,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 int cmd_multi_pack_index(int argc,
 			 const char **argv,
 			 const char *prefix,
-			 struct repository *repo UNUSED)
+			 struct repository *repo)
 {
 	int res;
 	parse_opt_subcommand_fn *fn = NULL;
@@ -297,7 +301,7 @@ int cmd_multi_pack_index(int argc,
 			     builtin_multi_pack_index_usage, 0);
 	FREE_AND_NULL(options);
 
-	res = fn(argc, argv, prefix);
+	res = fn(argc, argv, prefix, repo);
 
 	free(opts.object_dir);
 	return res;
diff --git a/builtin/notes.c b/builtin/notes.c
index 72c8a51cfacf72e1f115774487311b3d4464d204..d051abf6dff8f2bce193fd52b4beda5060af3972 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -431,7 +431,8 @@ static struct notes_tree *init_notes_check(const char *subcommand,
 	return t;
 }
 
-static int list(int argc, const char **argv, const char *prefix)
+static int list(int argc, const char **argv, const char *prefix,
+		struct repository *repo UNUSED)
 {
 	struct notes_tree *t;
 	struct object_id object;
@@ -468,9 +469,11 @@ static int list(int argc, const char **argv, const char *prefix)
 	return retval;
 }
 
-static int append_edit(int argc, const char **argv, const char *prefix);
+static int append_edit(int argc, const char **argv, const char *prefix,
+		       struct repository *repo UNUSED);
 
-static int add(int argc, const char **argv, const char *prefix)
+static int add(int argc, const char **argv, const char *prefix,
+	       struct repository *repo)
 {
 	int force = 0, allow_empty = 0;
 	const char *object_ref;
@@ -543,7 +546,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			 * argv[0-1].
 			 */
 			argv[0] = "edit";
-			return append_edit(argc, argv, prefix);
+			return append_edit(argc, argv, prefix, repo);
 		}
 		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
 			oid_to_hex(&object));
@@ -569,7 +572,8 @@ static int add(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int copy(int argc, const char **argv, const char *prefix)
+static int copy(int argc, const char **argv, const char *prefix,
+		struct repository *repo UNUSED)
 {
 	int retval = 0, force = 0, from_stdin = 0;
 	const struct object_id *from_note, *note;
@@ -646,7 +650,8 @@ static int copy(int argc, const char **argv, const char *prefix)
 	return retval;
 }
 
-static int append_edit(int argc, const char **argv, const char *prefix)
+static int append_edit(int argc, const char **argv, const char *prefix,
+		       struct repository *repo UNUSED)
 {
 	int allow_empty = 0;
 	const char *object_ref;
@@ -749,7 +754,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int show(int argc, const char **argv, const char *prefix)
+static int show(int argc, const char **argv, const char *prefix,
+		struct repository *repo UNUSED)
 {
 	const char *object_ref;
 	struct notes_tree *t;
@@ -875,7 +881,8 @@ static int git_config_get_notes_strategy(const char *key,
 	return 0;
 }
 
-static int merge(int argc, const char **argv, const char *prefix)
+static int merge(int argc, const char **argv, const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
 	struct object_id result_oid;
@@ -1016,7 +1023,8 @@ static int remove_one_note(struct notes_tree *t, const char *name, unsigned flag
 	return (flag & IGNORE_MISSING) ? 0 : status;
 }
 
-static int remove_cmd(int argc, const char **argv, const char *prefix)
+static int remove_cmd(int argc, const char **argv, const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	unsigned flag = 0;
 	int from_stdin = 0;
@@ -1059,7 +1067,8 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 	return retval;
 }
 
-static int prune(int argc, const char **argv, const char *prefix)
+static int prune(int argc, const char **argv, const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct notes_tree *t;
 	int show_only = 0, verbose = 0;
@@ -1088,7 +1097,8 @@ static int prune(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int get_ref(int argc, const char **argv, const char *prefix)
+static int get_ref(int argc, const char **argv, const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	struct option options[] = { OPT_END() };
 	char *notes_ref;
@@ -1109,7 +1119,7 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 int cmd_notes(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	const char *override_notes_ref = NULL;
 	parse_opt_subcommand_fn *fn = NULL;
@@ -1148,5 +1158,5 @@ int cmd_notes(int argc,
 		strbuf_release(&sb);
 	}
 
-	return !!fn(argc, argv, prefix);
+	return !!fn(argc, argv, prefix, repo);
 }
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 22df6834f71098ab8378e4423967f0fb87858340..5a0c22f2f7e58733ce636619f3f19265b394bde5 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -234,7 +234,8 @@ static int expire_total_callback(const struct option *opt,
 	return 0;
 }
 
-static int cmd_reflog_show(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_show(int argc, const char **argv, const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -253,7 +254,8 @@ static int show_reflog(const char *refname, void *cb_data UNUSED)
 	return 0;
 }
 
-static int cmd_reflog_list(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_list(int argc, const char **argv, const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -270,7 +272,8 @@ static int cmd_reflog_list(int argc, const char **argv, const char *prefix)
 	return refs_for_each_reflog(ref_store, show_reflog, NULL);
 }
 
-static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
+			     struct repository *repo UNUSED)
 {
 	struct cmd_reflog_expire_cb cmd = { 0 };
 	timestamp_t now = time(NULL);
@@ -394,7 +397,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
-static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_delete(int argc, const char **argv, const char *prefix,
+			     struct repository *repo UNUSED)
 {
 	int i, status = 0;
 	unsigned int flags = 0;
@@ -424,7 +428,8 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
-static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
+			     struct repository *repo UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -467,7 +472,7 @@ int cmd_reflog(int argc,
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 	if (fn)
-		return fn(argc - 1, argv + 1, prefix);
+		return fn(argc - 1, argv + 1, prefix, repository);
 	else
 		return cmd_log_reflog(argc, argv, prefix, repository);
 }
diff --git a/builtin/refs.c b/builtin/refs.c
index 24978a7b7b081ac6ed8ca99016f201d34c0639f8..3502980d21d055d8fc5ef36d2165aae61bc4db62 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -12,7 +12,8 @@
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
 
-static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
+static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
+			    struct repository *repo UNUSED)
 {
 	const char * const migrate_usage[] = {
 		REFS_MIGRATE_USAGE,
@@ -63,7 +64,8 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
-static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
 	const char * const verify_usage[] = {
@@ -93,7 +95,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo UNUSED)
+	     struct repository *repo)
 {
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
@@ -108,5 +110,5 @@ int cmd_refs(int argc,
 	};
 
 	argc = parse_options(argc, argv, prefix, opts, refs_usage, 0);
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/builtin/remote.c b/builtin/remote.c
index 76670ddd8b44e5b118c76522613c445ad92c5364..56214775df4ce86bf5d8e4ddb8d19140f696aeef 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -155,7 +155,8 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 	return 0;
 }
 
-static int add(int argc, const char **argv, const char *prefix)
+static int add(int argc, const char **argv, const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	int fetch = 0, fetch_tags = TAGS_DEFAULT;
 	unsigned mirror = MIRROR_NONE;
@@ -706,7 +707,8 @@ static void handle_push_default(const char* old_name, const char* new_name)
 }
 
 
-static int mv(int argc, const char **argv, const char *prefix)
+static int mv(int argc, const char **argv, const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	int show_progress = isatty(2);
 	struct option options[] = {
@@ -881,7 +883,8 @@ static int mv(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
-static int rm(int argc, const char **argv, const char *prefix)
+static int rm(int argc, const char **argv, const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -1303,7 +1306,8 @@ static int show_all(void)
 	return result;
 }
 
-static int show(int argc, const char **argv, const char *prefix)
+static int show(int argc, const char **argv, const char *prefix,
+		struct repository *repo UNUSED)
 {
 	int no_query = 0, result = 0, query_flag = 0;
 	struct option options[] = {
@@ -1399,7 +1403,8 @@ static int show(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
-static int set_head(int argc, const char **argv, const char *prefix)
+static int set_head(int argc, const char **argv, const char *prefix,
+		    struct repository *repo UNUSED)
 {
 	int i, opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
@@ -1503,7 +1508,8 @@ static int prune_remote(const char *remote, int dry_run)
 	return result;
 }
 
-static int prune(int argc, const char **argv, const char *prefix)
+static int prune(int argc, const char **argv, const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	int dry_run = 0, result = 0;
 	struct option options[] = {
@@ -1534,7 +1540,8 @@ static int get_remote_default(const char *key, const char *value UNUSED,
 	return 0;
 }
 
-static int update(int argc, const char **argv, const char *prefix)
+static int update(int argc, const char **argv, const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	int i, prune = -1;
 	struct option options[] = {
@@ -1616,7 +1623,8 @@ static int set_remote_branches(const char *remotename, const char **branches,
 	return 0;
 }
 
-static int set_branches(int argc, const char **argv, const char *prefix)
+static int set_branches(int argc, const char **argv, const char *prefix,
+			struct repository *repo UNUSED)
 {
 	int add_mode = 0;
 	struct option options[] = {
@@ -1635,7 +1643,8 @@ static int set_branches(int argc, const char **argv, const char *prefix)
 	return set_remote_branches(argv[0], argv + 1, add_mode);
 }
 
-static int get_url(int argc, const char **argv, const char *prefix)
+static int get_url(int argc, const char **argv, const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	int i, push_mode = 0, all_mode = 0;
 	const char *remotename = NULL;
@@ -1674,7 +1683,8 @@ static int get_url(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int set_url(int argc, const char **argv, const char *prefix)
+static int set_url(int argc, const char **argv, const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
 	int matches = 0, negative_matches = 0;
@@ -1765,7 +1775,7 @@ static int set_url(int argc, const char **argv, const char *prefix)
 int cmd_remote(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -1788,7 +1798,7 @@ int cmd_remote(int argc,
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
 
 	if (fn) {
-		return !!fn(argc, argv, prefix);
+		return !!fn(argc, argv, prefix, repo);
 	} else {
 		if (argc) {
 			error(_("unknown subcommand: `%s'"), argv[0]);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 49aedc1de81a17b8b491cded7fa71b384e0e8be9..6f5fa5893b839fe21fef44ecbd837d132ebbac26 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -48,7 +48,8 @@ static char const * const builtin_sparse_checkout_list_usage[] = {
 	NULL
 };
 
-static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
+				struct repository *repo UNUSED)
 {
 	static struct option builtin_sparse_checkout_list_options[] = {
 		OPT_END(),
@@ -443,7 +444,8 @@ static struct sparse_checkout_init_opts {
 	int sparse_index;
 } init_opts;
 
-static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
+				struct repository *repo UNUSED)
 {
 	struct pattern_list pl;
 	char *sparse_filename;
@@ -770,7 +772,8 @@ static struct sparse_checkout_add_opts {
 	int use_stdin;
 } add_opts;
 
-static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
+			       struct repository *repo UNUSED)
 {
 	static struct option builtin_sparse_checkout_add_options[] = {
 		OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
@@ -808,7 +811,8 @@ static struct sparse_checkout_set_opts {
 	int use_stdin;
 } set_opts;
 
-static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
+			       struct repository *repo UNUSED)
 {
 	int default_patterns_nr = 2;
 	const char *default_patterns[] = {"/*", "!/*/", NULL};
@@ -866,7 +870,8 @@ static struct sparse_checkout_reapply_opts {
 } reapply_opts;
 
 static int sparse_checkout_reapply(int argc, const char **argv,
-				   const char *prefix)
+				   const char *prefix,
+				   struct repository *repo UNUSED)
 {
 	static struct option builtin_sparse_checkout_reapply_options[] = {
 		OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
@@ -901,7 +906,8 @@ static char const * const builtin_sparse_checkout_disable_usage[] = {
 };
 
 static int sparse_checkout_disable(int argc, const char **argv,
-				   const char *prefix)
+				   const char *prefix,
+				   struct repository *repo UNUSED)
 {
 	static struct option builtin_sparse_checkout_disable_options[] = {
 		OPT_END(),
@@ -989,7 +995,8 @@ static int check_rules(struct pattern_list *pl, int null_terminated) {
 	return 0;
 }
 
-static int sparse_checkout_check_rules(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_check_rules(int argc, const char **argv, const char *prefix,
+				       struct repository *repo UNUSED)
 {
 	static struct option builtin_sparse_checkout_check_rules_options[] = {
 		OPT_BOOL('z', NULL, &check_rules_opts.null_termination,
@@ -1037,7 +1044,7 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
 int cmd_sparse_checkout(int argc,
 			const char **argv,
 			const char *prefix,
-			struct repository *repo UNUSED)
+			struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_sparse_checkout_options[] = {
@@ -1060,5 +1067,5 @@ int cmd_sparse_checkout(int argc,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index 1399a1bbe2c222ed3e1c33ac2dd17bd1148f709c..c212b1c0b2c7c55de2fdd5d7d7a247ce6f530960 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -249,7 +249,8 @@ static int do_clear_stash(void)
 			       ref_stash, &obj, 0);
 }
 
-static int clear_stash(int argc, const char **argv, const char *prefix)
+static int clear_stash(int argc, const char **argv, const char *prefix,
+		       struct repository *repo UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -652,7 +653,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	return ret;
 }
 
-static int apply_stash(int argc, const char **argv, const char *prefix)
+static int apply_stash(int argc, const char **argv, const char *prefix,
+		       struct repository *repo UNUSED)
 {
 	int ret = -1;
 	int quiet = 0;
@@ -726,7 +728,8 @@ static int get_stash_info_assert(struct stash_info *info, int argc,
 	return 0;
 }
 
-static int drop_stash(int argc, const char **argv, const char *prefix)
+static int drop_stash(int argc, const char **argv, const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	int ret = -1;
 	int quiet = 0;
@@ -748,7 +751,8 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int pop_stash(int argc, const char **argv, const char *prefix)
+static int pop_stash(int argc, const char **argv, const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	int ret = -1;
 	int index = 0;
@@ -778,7 +782,8 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int branch_stash(int argc, const char **argv, const char *prefix)
+static int branch_stash(int argc, const char **argv, const char *prefix,
+			struct repository *repo UNUSED)
 {
 	int ret = -1;
 	const char *branch = NULL;
@@ -816,7 +821,8 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int list_stash(int argc, const char **argv, const char *prefix)
+static int list_stash(int argc, const char **argv, const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct option options[] = {
@@ -889,7 +895,8 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 	do_diff_cache(&info->b_commit, diff_opt);
 }
 
-static int show_stash(int argc, const char **argv, const char *prefix)
+static int show_stash(int argc, const char **argv, const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	int i;
 	int ret = -1;
@@ -1017,7 +1024,8 @@ static int do_store_stash(const struct object_id *w_commit, const char *stash_ms
 	return 0;
 }
 
-static int store_stash(int argc, const char **argv, const char *prefix)
+static int store_stash(int argc, const char **argv, const char *prefix,
+		       struct repository *repo UNUSED)
 {
 	int quiet = 0;
 	const char *stash_msg = NULL;
@@ -1491,7 +1499,8 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	return ret;
 }
 
-static int create_stash(int argc, const char **argv, const char *prefix UNUSED)
+static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
+			struct repository *repo UNUSED)
 {
 	int ret;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
@@ -1827,12 +1836,14 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
-static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
+static int push_stash_unassumed(int argc, const char **argv, const char *prefix,
+				struct repository *repo UNUSED)
 {
 	return push_stash(argc, argv, prefix, 0);
 }
 
-static int save_stash(int argc, const char **argv, const char *prefix)
+static int save_stash(int argc, const char **argv, const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	int keep_index = -1;
 	int only_staged = 0;
@@ -1878,7 +1889,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 int cmd_stash(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	pid_t pid = getpid();
 	const char *index_file;
@@ -1916,9 +1927,9 @@ int cmd_stash(int argc,
 		    (uintmax_t)pid);
 
 	if (fn)
-		return !!fn(argc, argv, prefix);
+		return !!fn(argc, argv, prefix, repo);
 	else if (!argc)
-		return !!push_stash_unassumed(0, NULL, prefix);
+		return !!push_stash_unassumed(0, NULL, prefix, repo);
 
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b6b5f1ebde7c2e4780af4097a0c4d6d838948aee..19e587838132f26e2e10dc4a9f93f7b1c78cd49d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -399,7 +399,8 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	free(displaypath);
 }
 
-static int module_foreach(int argc, const char **argv, const char *prefix)
+static int module_foreach(int argc, const char **argv, const char *prefix,
+			  struct repository *repo UNUSED)
 {
 	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -544,7 +545,8 @@ static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data
 		       info->flags);
 }
 
-static int module_init(int argc, const char **argv, const char *prefix)
+static int module_init(int argc, const char **argv, const char *prefix,
+		       struct repository *repo UNUSED)
 {
 	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -738,7 +740,8 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 			 info->prefix, info->super_prefix, info->flags);
 }
 
-static int module_status(int argc, const char **argv, const char *prefix)
+static int module_status(int argc, const char **argv, const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	struct status_cb info = STATUS_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -1163,7 +1166,8 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	return ret;
 }
 
-static int module_summary(int argc, const char **argv, const char *prefix)
+static int module_summary(int argc, const char **argv, const char *prefix,
+			  struct repository *repo UNUSED)
 {
 	struct summary_cb info = SUMMARY_CB_INIT;
 	int cached = 0;
@@ -1339,7 +1343,8 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 		       info->flags);
 }
 
-static int module_sync(int argc, const char **argv, const char *prefix)
+static int module_sync(int argc, const char **argv, const char *prefix,
+		       struct repository *repo UNUSED)
 {
 	struct sync_cb info = SYNC_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -1485,7 +1490,8 @@ static void deinit_submodule_cb(const struct cache_entry *list_item,
 	deinit_submodule(list_item->name, info->prefix, info->flags);
 }
 
-static int module_deinit(int argc, const char **argv, const char *prefix)
+static int module_deinit(int argc, const char **argv, const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	struct deinit_cb info = DEINIT_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -1842,7 +1848,8 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 	return 0;
 }
 
-static int module_clone(int argc, const char **argv, const char *prefix)
+static int module_clone(int argc, const char **argv, const char *prefix,
+			struct repository *repo UNUSED)
 {
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
@@ -2779,7 +2786,8 @@ static int update_submodules(struct update_data *update_data)
 	return ret;
 }
 
-static int module_update(int argc, const char **argv, const char *prefix)
+static int module_update(int argc, const char **argv, const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	struct pathspec pathspec = { 0 };
 	struct pathspec pathspec2 = { 0 };
@@ -2911,7 +2919,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int push_check(int argc, const char **argv, const char *prefix UNUSED)
+static int push_check(int argc, const char **argv, const char *prefix UNUSED,
+		      struct repository *repo UNUSED)
 {
 	struct remote *remote;
 	const char *superproject_head;
@@ -2991,7 +3000,8 @@ static int push_check(int argc, const char **argv, const char *prefix UNUSED)
 	return 0;
 }
 
-static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
+static int absorb_git_dirs(int argc, const char **argv, const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	int i;
 	struct pathspec pathspec = { 0 };
@@ -3024,7 +3034,8 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int module_set_url(int argc, const char **argv, const char *prefix)
+static int module_set_url(int argc, const char **argv, const char *prefix,
+			  struct repository *repo UNUSED)
 {
 	int quiet = 0, ret;
 	const char *newurl;
@@ -3063,7 +3074,8 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
-static int module_set_branch(int argc, const char **argv, const char *prefix)
+static int module_set_branch(int argc, const char **argv, const char *prefix,
+			     struct repository *repo UNUSED)
 {
 	int opt_default = 0, ret;
 	const char *opt_branch = NULL;
@@ -3113,7 +3125,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
-static int module_create_branch(int argc, const char **argv, const char *prefix)
+static int module_create_branch(int argc, const char **argv, const char *prefix,
+				struct repository *repo UNUSED)
 {
 	enum branch_track track;
 	int quiet = 0, force = 0, reflog = 0, dry_run = 0;
@@ -3424,7 +3437,8 @@ static void die_on_repo_without_commits(const char *path)
 	strbuf_release(&sb);
 }
 
-static int module_add(int argc, const char **argv, const char *prefix)
+static int module_add(int argc, const char **argv, const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
@@ -3557,7 +3571,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 int cmd_submodule__helper(int argc,
 			  const char **argv,
 			  const char *prefix,
-			  struct repository *repo UNUSED)
+			  struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	const char *const usage[] = {
@@ -3583,5 +3597,5 @@ int cmd_submodule__helper(int argc,
 	};
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index dae63dedf4cac2621f51f95a39aa456b33acd894..824dd71d643f112f384cde4de1373698c67de254 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -231,7 +231,8 @@ static void prune_worktrees(void)
 	strbuf_release(&reason);
 }
 
-static int prune(int ac, const char **av, const char *prefix)
+static int prune(int ac, const char **av, const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
@@ -763,7 +764,8 @@ static char *dwim_branch(const char *path, char **new_branch)
 	return NULL;
 }
 
-static int add(int ac, const char **av, const char *prefix)
+static int add(int ac, const char **av, const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
@@ -1039,7 +1041,8 @@ static void pathsort(struct worktree **wt)
 	QSORT(wt, n, pathcmp);
 }
 
-static int list(int ac, const char **av, const char *prefix)
+static int list(int ac, const char **av, const char *prefix,
+		struct repository *repo UNUSED)
 {
 	int porcelain = 0;
 	int line_terminator = '\n';
@@ -1084,7 +1087,8 @@ static int list(int ac, const char **av, const char *prefix)
 	return 0;
 }
 
-static int lock_worktree(int ac, const char **av, const char *prefix)
+static int lock_worktree(int ac, const char **av, const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	const char *reason = "", *old_reason;
 	struct option options[] = {
@@ -1119,7 +1123,8 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
 	return 0;
 }
 
-static int unlock_worktree(int ac, const char **av, const char *prefix)
+static int unlock_worktree(int ac, const char **av, const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -1182,7 +1187,8 @@ static void validate_no_submodules(const struct worktree *wt)
 		die(_("working trees containing submodules cannot be moved or removed"));
 }
 
-static int move_worktree(int ac, const char **av, const char *prefix)
+static int move_worktree(int ac, const char **av, const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	int force = 0;
 	struct option options[] = {
@@ -1312,7 +1318,8 @@ static int delete_git_work_tree(struct worktree *wt)
 	return ret;
 }
 
-static int remove_worktree(int ac, const char **av, const char *prefix)
+static int remove_worktree(int ac, const char **av, const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	int force = 0;
 	struct option options[] = {
@@ -1377,7 +1384,8 @@ static void report_repair(int iserr, const char *path, const char *msg, void *cb
 	}
 }
 
-static int repair(int ac, const char **av, const char *prefix)
+static int repair(int ac, const char **av, const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	const char **p;
 	const char *self[] = { ".", NULL };
@@ -1397,7 +1405,7 @@ static int repair(int ac, const char **av, const char *prefix)
 int cmd_worktree(int ac,
 		 const char **av,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -1422,5 +1430,5 @@ int cmd_worktree(int ac,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	return fn(ac, av, prefix);
+	return fn(ac, av, prefix, repo);
 }
diff --git a/parse-options.h b/parse-options.h
index ae15342390837c21503ab812648a7d8fd21432a8..f0801d4532a175b65783689f2a68fb56da2c8e87 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -3,6 +3,8 @@
 
 #include "gettext.h"
 
+struct repository;
+
 /**
  * Refer to Documentation/technical/api-parse-options.txt for the API doc.
  */
@@ -73,7 +75,7 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
 					      const char *arg, int unset);
 
 typedef int parse_opt_subcommand_fn(int argc, const char **argv,
-				    const char *prefix);
+				    const char *prefix, struct repository *repo);
 
 /*
  * `type`::
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 5250913d99eba18a28878d3904cb7b2399670d02..5da359486cdcb353b277653111bc201c5f82851e 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -282,14 +282,16 @@ int cmd__parse_options_flags(int argc, const char **argv)
 	return parse_options_flags__cmd(argc, argv, test_flags);
 }
 
-static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED)
+static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED,
+		      struct repository *repo UNUSED)
 {
 	printf("fn: subcmd_one\n");
 	print_args(argc, argv);
 	return 0;
 }
 
-static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED)
+static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED,
+		      struct repository *repo UNUSED)
 {
 	printf("fn: subcmd_two\n");
 	print_args(argc, argv);
@@ -319,7 +321,7 @@ static int parse_subcommand__cmd(int argc, const char **argv,
 
 	printf("opt: %d\n", opt);
 
-	return fn(argc, argv, NULL);
+	return fn(argc, argv, NULL, NULL);
 }
 
 int cmd__parse_subcommand(int argc, const char **argv)

-- 
2.47.0

