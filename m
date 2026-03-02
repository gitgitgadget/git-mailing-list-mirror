Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31622383C60
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441909; cv=none; b=aVkd6lRYPz8ufZTrRjlnRAGSljeQZPHots4o9R/L4OS9cBPwoyzp1bKUenGNd4OwwKCdvTkkYK90qLfo3HootbXCWAOArFpIwAX5yyvCPAGw5a8TRLF4tS5qvz0axWNJhBWFBhg+zgfBjidUs+5Gi7yvN+MB7eEC+jl0gQ9MnqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441909; c=relaxed/simple;
	bh=kGo8uH1yarazpdvCJwA2qiOb1uoMmX+aPNfQiz/1WSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC8a3hnQ13a6NqIA5Kwo7uCoTlWTzGpWUY5Rxm66az3M/U4QT4aPFsoVbLk1nn7Aqtk1mT0pF5yNpaqo3jwiE5W1QXLR0hqLU6ZhOoRCOM8vYrwGBsqFnMnSYtMVRK57vKHz9ptxYopQ0llGXatRSI/eILG4b51aWzZf7i1BEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecGi6uTS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecGi6uTS"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6de5ea6879so107890a12.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 00:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772441907; x=1773046707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwKCRU7srsXxb4GGO5FqbeMH46rVkdbRCSpCU6YtLd4=;
        b=ecGi6uTSnAKVwfpgtY22YUteLqWZpi7OyoVqoUpEJm5QVWBmcGC4vosQyTUTkT36CJ
         9DmODQwUhs1iyvUgdHGWrcTCY4yRjQAcNV0I484vViyRIgeKmX6GzVm3UIdEVYb4VDk+
         Txi2D1YSmCTJJL2K3RhvWBWfcveZkqL5GHCTGXp9aRnmgqn091jqOOroXMP4XOJsZZeL
         wUY/OIem0u0WNCYVtzfEULd6dXh3CX4RF458Z5btJCNfyBDNZ5a1myZU899sESkLT5yI
         hkmx7eoijgTVna38yi29mafA4YYTrHTobrPL6c4DzrEGo1MzWfHGX1J0Oha7EMor5evn
         bsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441907; x=1773046707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hwKCRU7srsXxb4GGO5FqbeMH46rVkdbRCSpCU6YtLd4=;
        b=JX7AXX94232Rh6T7TJFoUYEjBRcd0ef3wdFAnIs7FC4wVf92BOm0NRuFfJT+ZWGOnr
         v9EpOaILg7lhbsMRyv9pi4TUEGFuwgc/w8U+MhtyY3FcpgzPZ5AtQONhjDLywiSXfiuQ
         LcdRadpdQcA6fDrfROWQsJ1L6XhaOQA5yO21iOJZVi36MegMj0WCyMXeeybyPzKLGmnz
         5GbSXOes0aEmC67OHLnVXCGHiIGxwPEqOg/63/I90jgDXwt8BQlHrB0gSbl05E/5+IH8
         uF0kMDyqZ7BGNkFQ8ujW82NLDXCEsmXQ+lSOtSaIpfcvVQmTmRDWuajBQSIua3hwaqNw
         42CA==
X-Gm-Message-State: AOJu0Yxpz2CH43U9k2sZJ806gfXMBPoQfZGVyj5TRrGX3yhi4BXdzi0A
	ZQcV2sK347ca2Q3Xar/FYaOMJwhif6g272DNPZ/U/AgVLrwmqFTCdNU/zH4tYjU+
X-Gm-Gg: ATEYQzxhmFeYWWeqmirZ+82RtZEY28AA0Ei67B03GCCJgJ3cSDAtO0dTlkT8jriChj5
	C6KCiBHsq7II6ciOgYIE7Fp83PxMdkVzAMrLsf9dGLHigMtYok5ohrDnks+7MZx4Y/p0aWis/Ny
	YNRczY7eqoXl2TpSnEP4IhcCsmvm/Ly2Wo8ITL3GkuIHxDirk84Ijx3xIdkVagJkl5unDPWNtB8
	AzELc1d+8tO6tPlxliSPQSsfcCzlaH9vT8T8AafiTrVUp/G9m+8UHXTijaWqMF9GyY0UVtNXUw9
	iK2wy9/PqkXIFM4VZsJlB9LxWJndJCJ3fgrWvry6voKKYOp/2jtjgN/4YyWOWKkUgyzhvacN6Wm
	TWD1YKU7IySgox4xdC+al3CPxzNapaiSQMgQ/ijCpf7+m96wpVCqfzMQ8kIO2FdR2XCQnZbg51i
	kkAtheORg1WsQjbqIL/hFkm4ldsNSOFXPNuBYT7JETbWFoMEzJUnkTPjdHm4RQXOV6Nw3FwUtB5
	8rbahgIPbfRj9y75gKtLQQ=
X-Received: by 2002:a17:902:e809:b0:2ae:4999:218f with SMTP id d9443c01a7336-2ae49992641mr31145665ad.2.1772441907074;
        Mon, 02 Mar 2026 00:58:27 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4d31138fsm33920325ad.83.2026.03.02.00.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:58:26 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	jltobler@gmail.com
Subject: [PATCH v4 2/3] pretty: plumb 'struct repository' into pretty-print APIs
Date: Mon,  2 Mar 2026 16:57:36 +0800
Message-ID: <20260302085738.2510514-3-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302085738.2510514-1-a3205153416@gmail.com>
References: <20260228040727.2057192-1-a3205153416@gmail.com>
 <20260302085738.2510514-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for the elimination of the global state associated with
'log_output_encoding', functions responsible for formatting commit
messages, such as 'pretty_print_commit()' and 'pp_commit_easy()',
must be able to access a repository instance.

Plumb the 'struct repository' pointer down the call chain for these
APIs. Where no such context is readily available in built-ins or
high-level functions, fallback to 'the_repository'.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 builtin/checkout.c    | 4 ++--
 builtin/log.c         | 2 +-
 builtin/merge.c       | 2 +-
 builtin/reset.c       | 2 +-
 builtin/rev-list.c    | 2 +-
 builtin/shortlog.c    | 2 +-
 builtin/show-branch.c | 2 +-
 builtin/stash.c       | 2 +-
 bundle.c              | 2 +-
 log-tree.c            | 2 +-
 pretty.c              | 6 +++---
 pretty.h              | 4 ++--
 range-diff.c          | 2 +-
 sequencer.c           | 6 +++---
 14 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d816de583..3b9e3e45f9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -689,7 +689,7 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (!repo_parse_commit(the_repository, commit))
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
+		pp_commit_easy(the_repository, CMIT_FMT_ONELINE, commit, &sb);
 	if (print_sha1_ellipsis()) {
 		fprintf(stderr, "%s %s... %s\n", msg,
 			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV),
@@ -1077,7 +1077,7 @@ static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 	strbuf_add_unique_abbrev(sb, &commit->object.oid, DEFAULT_ABBREV);
 	strbuf_addch(sb, ' ');
 	if (!repo_parse_commit(the_repository, commit))
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
+		pp_commit_easy(the_repository, CMIT_FMT_ONELINE, commit, sb);
 	strbuf_addch(sb, '\n');
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 8ab6d3a943..0758aed580 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2521,7 +2521,7 @@ static void print_commit(char sign, struct commit *commit, int verbose,
 		       repo_find_unique_abbrev(the_repository, &commit->object.oid, abbrev));
 	} else {
 		struct strbuf buf = STRBUF_INIT;
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
+		pp_commit_easy(the_repository, CMIT_FMT_ONELINE, commit, &buf);
 		fprintf(file, "%c %s %s\n", sign,
 		       repo_find_unique_abbrev(the_repository, &commit->object.oid, abbrev),
 		       buf.buf);
diff --git a/builtin/merge.c b/builtin/merge.c
index 7c944fe179..dff8185776 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -470,7 +470,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 		strbuf_addch(&out, '\n');
 		strbuf_addf(&out, "commit %s\n",
 			oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&ctx, commit, &out);
+		pretty_print_commit(the_repository, &ctx, commit, &out);
 	}
 	write_file_buf(git_path_squash_msg(the_repository), out.buf, out.len);
 	strbuf_release(&out);
diff --git a/builtin/reset.c b/builtin/reset.c
index c48d9845f8..733f3fa905 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -141,7 +141,7 @@ static void print_new_head_line(struct commit *commit)
 	printf(_("HEAD is now at %s"),
 		repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
 
-	pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
+	pp_commit_easy(the_repository, CMIT_FMT_ONELINE, commit, &buf);
 	if (buf.len > 0)
 		printf(" %s", buf.buf);
 	putchar('\n');
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ddea8aa251..57c7b8d3ff 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -307,7 +307,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.output_encoding = get_log_output_encoding();
 		ctx.color = revs->diffopt.use_color;
 		ctx.rev = revs;
-		pretty_print_commit(&ctx, commit, &buf);
+		pretty_print_commit(the_repository, &ctx, commit, &buf);
 		if (buf.len) {
 			if (revs->commit_format != CMIT_FMT_ONELINE)
 				graph_show_oneline(revs->graph);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d80bf1a7d0..109785fd00 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -252,7 +252,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 
 	if (!log->summary) {
 		if (log->user_format)
-			pretty_print_commit(&ctx, commit, &oneline);
+			pretty_print_commit(the_repository, &ctx, commit, &oneline);
 		else
 			repo_format_commit_message(the_repository, commit,
 						   "%s", &oneline, &ctx);
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..6bfe9e2e96 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -310,7 +310,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 	struct commit_name *name = commit_to_name(commit);
 
 	if (commit->object.parsed) {
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
+		pp_commit_easy(the_repository, CMIT_FMT_ONELINE, commit, &pretty);
 		pretty_str = pretty.buf;
 	}
 	skip_prefix(pretty_str, "[PATCH] ", &pretty_str);
diff --git a/builtin/stash.c b/builtin/stash.c
index 785c1f9e5d..a522bb6de5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1480,7 +1480,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 						  &head_commit->object.oid,
 						  DEFAULT_ABBREV);
 	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
-	pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
+	pp_commit_easy(the_repository, CMIT_FMT_ONELINE, head_commit, &msg);
 
 	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
 	commit_list_insert(head_commit, &parents);
diff --git a/bundle.c b/bundle.c
index 42327f9739..3bc2ed9ee9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -463,7 +463,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 	ctx.fmt = CMIT_FMT_ONELINE;
 	ctx.output_encoding = get_log_output_encoding();
 	strbuf_reset(&buf);
-	pretty_print_commit(&ctx, commit, &buf);
+	pretty_print_commit(the_repository, &ctx, commit, &buf);
 	strbuf_trim(&buf);
 
 	object = (struct object *)commit;
diff --git a/log-tree.c b/log-tree.c
index 7e048701d0..fd2fb0bed6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -885,7 +885,7 @@ void show_log(struct rev_info *opt)
 		ctx.from_ident = &opt->from_ident;
 	if (opt->graph)
 		ctx.graph_width = graph_width(opt->graph);
-	pretty_print_commit(&ctx, commit, &msgbuf);
+	pretty_print_commit(opt->repo, &ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, 0, APPEND_SIGNOFF_DEDUP);
diff --git a/pretty.c b/pretty.c
index e0646bbc5d..51e3480431 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2281,7 +2281,7 @@ void pp_remainder(struct pretty_print_context *pp,
 	}
 }
 
-void pretty_print_commit(struct pretty_print_context *pp,
+void pretty_print_commit(struct repository *r, struct pretty_print_context *pp,
 			 const struct commit *commit,
 			 struct strbuf *sb)
 {
@@ -2363,10 +2363,10 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	repo_unuse_commit_buffer(the_repository, commit, reencoded);
 }
 
-void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
+void pp_commit_easy(struct repository *r, enum cmit_fmt fmt, const struct commit *commit,
 		    struct strbuf *sb)
 {
 	struct pretty_print_context pp = {0};
 	pp.fmt = fmt;
-	pretty_print_commit(&pp, commit, sb);
+	pretty_print_commit(r, &pp, commit, sb);
 }
diff --git a/pretty.h b/pretty.h
index fac699033e..13eb0189bd 100644
--- a/pretty.h
+++ b/pretty.h
@@ -82,7 +82,7 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w);
  * Shortcut for invoking pretty_print_commit if we do not have any context.
  * Context would be set empty except "fmt".
  */
-void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
+void pp_commit_easy(struct repository *r, enum cmit_fmt fmt, const struct commit *commit,
 			struct strbuf *sb);
 
 /*
@@ -132,7 +132,7 @@ void get_commit_format(const char *arg, struct rev_info *);
  * and put it into "sb".
  * Please use this function if you have a context (candidate for "pp").
  */
-void pretty_print_commit(struct pretty_print_context *pp,
+void pretty_print_commit(struct repository *r, struct pretty_print_context *pp,
 			const struct commit *commit,
 			struct strbuf *sb);
 
diff --git a/range-diff.c b/range-diff.c
index 57edff40a8..31d38c2318 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -460,7 +460,7 @@ static void output_pair_header(struct diff_options *diffopt,
 			strbuf_addf(buf, "%s%s", color_reset, color);
 
 		strbuf_addch(buf, ' ');
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
+		pp_commit_easy(diffopt->repo, CMIT_FMT_ONELINE, commit, buf);
 	}
 	strbuf_addf(buf, "%s\n", color_reset);
 
diff --git a/sequencer.c b/sequencer.c
index 627020d65b..e6b3e05fce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5870,7 +5870,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			continue;
 
 		strbuf_reset(&oneline);
-		pretty_print_commit(pp, commit, &oneline);
+		pretty_print_commit(revs->repo, pp, commit, &oneline);
 
 		to_merge = commit->parents ? commit->parents->next : NULL;
 		if (!to_merge) {
@@ -6012,7 +6012,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				strbuf_addf(out, "%s onto\n", cmd_reset);
 			else {
 				strbuf_reset(&oneline);
-				pretty_print_commit(pp, commit, &oneline);
+				pretty_print_commit(revs->repo, pp, commit, &oneline);
 				strbuf_addf(out, "%s %s %s\n",
 					    cmd_reset, to, oneline.buf);
 			}
@@ -6124,7 +6124,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out,
 			continue;
 		strbuf_addf(out, "%s %s ", insn,
 			    oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&pp, commit, out);
+		pretty_print_commit(r, &pp, commit, out);
 		if (is_empty)
 			strbuf_addf(out, " %s empty", comment_line_str);
 		strbuf_addch(out, '\n');
-- 
2.43.0

