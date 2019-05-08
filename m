Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEBBB1F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfEHPxw (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37502 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfEHPxv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so22536800edw.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fl6XL5n/Rg0V3uX9ruldw9vwj0sH2xIdLaQS488how4=;
        b=ffo6EETIlX08gMas6r+jNONgN96nhp7oQVu3CnL/oLGTHUzIe1jwdYQz+qlsoS4CX7
         d09F1ZvxrG8/iwlzc4erBq3cnjHBO4ukf4wmCEFnSKXdQdU4u2VsvgAgwy63THYEI6Jz
         Ql2IQLYagCMYaS1krTV2eek43zA+/qjJLVXCFzxwsYrr7KqOI4pXjla5yzDqz7cCOi9D
         GZPo9nFE2ZtPd/PgCNcwm0T3Fd9MtZZ4QYKYQYlqo3xN79obqnnAZDrqZZJke/I6n2i4
         cQlhu46nVUZKuJXGctNHfZkZwNWSvnxA43DRZ4WOD5ZT4dfuRefm3OYnsgRsny1qChDo
         5Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fl6XL5n/Rg0V3uX9ruldw9vwj0sH2xIdLaQS488how4=;
        b=Chf+uNH+V/U48jliN98Ns09qTlOsvTwQrWt/n9M8wYfafazL3x5KVA9G6VIl+aOFMr
         ef2XKQOu8ksdRNhH1aZAhO2U+CB0pM+YXfXtya9IpQP2Zp0eIvzwIF9J/TykAfF3ovwK
         Cdo+C83nCwg2029ESpv3s7ffXM2mku8OYdpDciJ1xMzC2GLXOmQ7qWDaj8aJ7mIkrxWj
         mRCPqHHnvFRrw1+p98DCyYVHDwOk4CLTXRPT/zTONvDpFlMx4e3npyZ54KvGKlKsvgqf
         1xXlP8ETnzCXmuwTyQ+pENZ7taVH3nCOraOLKOvruDdmIoHsfR8keI4uIQUNN3C5sblt
         2/pA==
X-Gm-Message-State: APjAAAVp5algvzQxz94QVQB/V12cPBQk55Rykp2xdsFWIF2aMpYBlcII
        0sysccnOfGl/fbsOeIbBdUQNR7JsRdc=
X-Google-Smtp-Source: APXvYqy2Dx9zi4UN60op8DGBfSwjdv3kNYHUA5VzBuCwKko7D6e3IhWhRcdZ17COZSw+XzP8v74Ofw==
X-Received: by 2002:a50:d791:: with SMTP id w17mr1253966edi.223.1557330829689;
        Wed, 08 May 2019 08:53:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a61sm5246614edf.8.2019.05.08.08.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:49 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:49 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:31 GMT
Message-Id: <86b18f15ba1e497c6bcfc8cb60dc0ef03a58422c.1557330826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/17] commit-graph: return with errors during write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method uses die() to report failure and
exit when confronted with an unexpected condition. This use of
die() in a library function is incorrect and is now replaced by
error() statements and an int return type.

Now that we use 'goto cleanup' to jump to the terminal condition
on an error, we have new paths that could lead to uninitialized
values. New initializers are added to correct for this.

The builtins 'commit-graph', 'gc', and 'commit' call these methods,
so update them to check the return value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 19 +++++++------
 builtin/commit.c       |  5 ++--
 builtin/gc.c           |  7 ++---
 commit-graph.c         | 60 +++++++++++++++++++++++++++++-------------
 commit-graph.h         | 10 +++----
 5 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 537fdfd0f0..2e86251f02 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -141,6 +141,7 @@ static int graph_write(int argc, const char **argv)
 	struct string_list *pack_indexes = NULL;
 	struct string_list *commit_hex = NULL;
 	struct string_list lines;
+	int result;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -168,10 +169,8 @@ static int graph_write(int argc, const char **argv)
 
 	read_replace_refs = 0;
 
-	if (opts.reachable) {
-		write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
-		return 0;
-	}
+	if (opts.reachable)
+		return write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
 
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
@@ -188,14 +187,14 @@ static int graph_write(int argc, const char **argv)
 		UNLEAK(buf);
 	}
 
-	write_commit_graph(opts.obj_dir,
-			   pack_indexes,
-			   commit_hex,
-			   opts.append,
-			   1);
+	result = write_commit_graph(opts.obj_dir,
+				    pack_indexes,
+				    commit_hex,
+				    opts.append,
+				    1);
 
 	UNLEAK(lines);
-	return 0;
+	return result;
 }
 
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
diff --git a/builtin/commit.c b/builtin/commit.c
index 2986553d5f..b9ea7222fa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1669,8 +1669,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "new_index file. Check that disk is not full and quota is\n"
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
-	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
-		write_commit_graph_reachable(get_object_directory(), 0, 0);
+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
+	    write_commit_graph_reachable(get_object_directory(), 0, 0))
+		return 1;
 
 	repo_rerere(the_repository, 0);
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
diff --git a/builtin/gc.c b/builtin/gc.c
index 020f725acc..3984addf73 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -664,9 +664,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		clean_pack_garbage();
 	}
 
-	if (gc_write_commit_graph)
-		write_commit_graph_reachable(get_object_directory(), 0,
-					     !quiet && !daemonized);
+	if (gc_write_commit_graph &&
+	    write_commit_graph_reachable(get_object_directory(), 0,
+					 !quiet && !daemonized))
+		return 1;
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
diff --git a/commit-graph.c b/commit-graph.c
index 66865acbd7..ee487a364b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -851,27 +851,30 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-void write_commit_graph_reachable(const char *obj_dir, int append,
-				  int report_progress)
+int write_commit_graph_reachable(const char *obj_dir, int append,
+				 int report_progress)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
+	int result;
 
 	for_each_ref(add_ref_to_list, &list);
-	write_commit_graph(obj_dir, NULL, &list, append, report_progress);
+	result = write_commit_graph(obj_dir, NULL, &list,
+				    append, report_progress);
 
 	string_list_clear(&list, 0);
+	return result;
 }
 
-void write_commit_graph(const char *obj_dir,
-			struct string_list *pack_indexes,
-			struct string_list *commit_hex,
-			int append, int report_progress)
+int write_commit_graph(const char *obj_dir,
+		       struct string_list *pack_indexes,
+		       struct string_list *commit_hex,
+		       int append, int report_progress)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
 	struct hashfile *f;
 	uint32_t i, count_distinct = 0;
-	char *graph_name;
+	char *graph_name = NULL;
 	struct lock_file lk = LOCK_INIT;
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
@@ -883,15 +886,17 @@ void write_commit_graph(const char *obj_dir,
 	uint64_t progress_cnt = 0;
 	struct strbuf progress_title = STRBUF_INIT;
 	unsigned long approx_nr_objects;
+	int res = 0;
 
 	if (!commit_graph_compatible(the_repository))
-		return;
+		return 0;
 
 	oids.nr = 0;
 	approx_nr_objects = approximate_object_count();
 	oids.alloc = approx_nr_objects / 32;
 	oids.progress = NULL;
 	oids.progress_done = 0;
+	commits.list = NULL;
 
 	if (append) {
 		prepare_commit_graph_one(the_repository, obj_dir);
@@ -932,10 +937,16 @@ void write_commit_graph(const char *obj_dir,
 			strbuf_setlen(&packname, dirlen);
 			strbuf_addstr(&packname, pack_indexes->items[i].string);
 			p = add_packed_git(packname.buf, packname.len, 1);
-			if (!p)
-				die(_("error adding pack %s"), packname.buf);
-			if (open_pack_index(p))
-				die(_("error opening index for %s"), packname.buf);
+			if (!p) {
+				error(_("error adding pack %s"), packname.buf);
+				res = 1;
+				goto cleanup;
+			}
+			if (open_pack_index(p)) {
+				error(_("error opening index for %s"), packname.buf);
+				res = 1;
+				goto cleanup;
+			}
 			for_each_object_in_pack(p, add_packed_commits, &oids,
 						FOR_EACH_OBJECT_PACK_ORDER);
 			close_pack(p);
@@ -1006,8 +1017,11 @@ void write_commit_graph(const char *obj_dir,
 	}
 	stop_progress(&progress);
 
-	if (count_distinct >= GRAPH_EDGE_LAST_MASK)
-		die(_("the commit graph format cannot write %d commits"), count_distinct);
+	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
+		error(_("the commit graph format cannot write %d commits"), count_distinct);
+		res = 1;
+		goto cleanup;
+	}
 
 	commits.nr = 0;
 	commits.alloc = count_distinct;
@@ -1039,16 +1053,21 @@ void write_commit_graph(const char *obj_dir,
 	num_chunks = num_extra_edges ? 4 : 3;
 	stop_progress(&progress);
 
-	if (commits.nr >= GRAPH_EDGE_LAST_MASK)
-		die(_("too many commits to write graph"));
+	if (commits.nr >= GRAPH_EDGE_LAST_MASK) {
+		error(_("too many commits to write graph"));
+		res = 1;
+		goto cleanup;
+	}
 
 	compute_generation_numbers(&commits, report_progress);
 
 	graph_name = get_commit_graph_filename(obj_dir);
 	if (safe_create_leading_directories(graph_name)) {
 		UNLEAK(graph_name);
-		die_errno(_("unable to create leading directories of %s"),
-			  graph_name);
+		error(_("unable to create leading directories of %s"),
+			graph_name);
+		res = errno;
+		goto cleanup;
 	}
 
 	hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
@@ -1107,9 +1126,12 @@ void write_commit_graph(const char *obj_dir,
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
+cleanup:
 	free(graph_name);
 	free(commits.list);
 	free(oids.list);
+
+	return res;
 }
 
 #define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
diff --git a/commit-graph.h b/commit-graph.h
index 7dfb8c896f..d15670bf46 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -65,12 +65,12 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
  */
 int generation_numbers_enabled(struct repository *r);
 
-void write_commit_graph_reachable(const char *obj_dir, int append,
+int write_commit_graph_reachable(const char *obj_dir, int append,
 				  int report_progress);
-void write_commit_graph(const char *obj_dir,
-			struct string_list *pack_indexes,
-			struct string_list *commit_hex,
-			int append, int report_progress);
+int write_commit_graph(const char *obj_dir,
+		       struct string_list *pack_indexes,
+		       struct string_list *commit_hex,
+		       int append, int report_progress);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
-- 
gitgitgadget

