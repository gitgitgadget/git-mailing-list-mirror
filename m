Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7132FE042
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772397370; cv=none; b=n73b9jqf5krIrRE3+kw0RIun2yLmFmhx6fKebVy9bCDJmDFgdUiz3mqqTtnJm298so5U3VyoPIzh0cMnJ7H6VLGTrEHqRWocIIrAfmVW/Azlhy/dBAfotiZ8kBiQjDHwFw+y4wBZRI/nukMF8svQkyB//vfNGtobf4depSqhwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772397370; c=relaxed/simple;
	bh=+zJAhp1Hd0+uQhS2nJbpuSy4enKmx9LqCOZYWAbOQ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM/+hSfEH+4gmGfcUpc4QUqkKGQjQ4PKpVq0JzYzIOR9fZke+dwSOlZfTZ8QVRMJNiQ2NbNgK16xSmGaZTS78yzwtrSABNmpEwAf5O9oHkyQbwS6P3uujiXessF5oKJihJOOMKhKhSWmB0yhfa3JSFXUo/LUZYcqI9XPFWMjeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0VPRHlK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0VPRHlK"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c635d5d594dso696378a12.2
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 12:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772397368; x=1773002168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2x5h1tTaKJMS5ChVS2gNo69JEcF9PST4iYksk3UTRs=;
        b=f0VPRHlKz1wE6+4ORqEMwI+Ev8UztuS5AJ5R5FBf0xBLbqHmO5XB/mLCOnBautB/+o
         aIygaHOBlPs/HAbcM2uezWSqBxRr5dL476qaSY8U0OaW198TLehliR1dyLx83qgzBxdu
         JeoUBtIR09x02K3LJ09M+mBvJ1w5n9TF6cOndSGqYDBlf3f/v2pb7UnyLWsagEPPnThN
         o84K4PdZ8Pgmk3qZbXWNz0YygPzSO+ZKr0rp5YY/pC61AIbNPTr/v3nkjeB4gTglqVJY
         mRJORhWDISpLyc3jLd473P5ptbSMz/5H7NjWI9pIYfEjxGReorsZfJPCMoDCh4oJUvql
         pzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772397368; x=1773002168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e2x5h1tTaKJMS5ChVS2gNo69JEcF9PST4iYksk3UTRs=;
        b=o9y1fEBsHZPl7phIpVzU1pVBBm7qaVCG14YlEf8GET3Fv/Sk1lTmWTelh/SiazalCL
         VmwnnV0kkIUSI2Fivm9HhoXnMYgLdSFr2iuLJfQhX23FSy7hnQ4SXsmK/fY78P2Kgtzb
         WfpZXs0ijbrWwGBwP961AhNvjNsNHxTt/cTgZnoh6U9OEInup2o3D4EV+pXZOvFnC6FB
         MRWmSa/nT+Xzj0INniv/GdIeirfDf+kf4GpNBF636MP+BGz04Rro1Ry6OnXo6gHOlabN
         ckUdN2OIkwT7RSA4wwLFSDn3B6SLM69R5gF7W3KmoAo+RtAquuadTRPCQ9LsbdYp02as
         pvtg==
X-Gm-Message-State: AOJu0YyjHq66gUnWOQA/JjZBw3HPcXk8RT4nq7CuVS+1NYbMymz4+CBR
	L4z6QCfJ+GI2IlVByXiu3Sr0GwF71Z+xcZcw3kizje4MpRS6UddMnATwTEzXBR7w
X-Gm-Gg: ATEYQzwYwoH0D2nrgasHXJc/i7Zq1JTglO0vNW4IbzWHQtcMbmd8Z/H1C8M25I5t0g7
	4yFuMD2fG+OzqTki+zM4OFFgVT5fU3UMemwysElEvgEtpnhgFuVV4QazPqXxYFHWthI1PYG2D6r
	gmWe500LYKXOA+ptIhVJVQs7AJgB+SfEakKr8GIeSUM1U6MbknJ2sIWUnfk399nEmYaOiZduRst
	JQc6Z81YL3j1Jl8wG1R1PqDv+e9T32KUyeAHHnTb87GWjV8Rrl5BnzuKNCdmJCakbg1VhyYa4bW
	y3LsshQazkRHo7KZ9yGRd//f5NYwEpl0FASJt+0t6E3jxDcK5SJy5j1y/E++DxJxUr30pY5je8O
	0tnyC07tI1/wny9BeGJlSbKmd1JJ7614uZ65H2sBr1qbhcHiHHEPEGTAoBKJlpxGxcOa+LwIzYj
	1im9r4+s0KEkD+Qus4vR8snMdAs/c8NgVn1qJvP/zQMfVLfHOXdVv9puleTEQr5IC4WOo38osGz
	ORrUhgmh3NdX+QkDaAlHgM=
X-Received: by 2002:a17:90b:1f8f:b0:340:b8f2:24fa with SMTP id 98e67ed59e1d1-35965c2d023mr6348653a91.2.1772397368139;
        Sun, 01 Mar 2026 12:36:08 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4abcsm9496976a12.5.2026.03.01.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 12:36:07 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [PATCH v3 2/3] pretty: plumb 'struct repository' into pretty-print APIs
Date: Mon,  2 Mar 2026 04:35:38 +0800
Message-ID: <20260301203539.1421152-3-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301203539.1421152-1-a3205153416@gmail.com>
References: <20260228040727.2057192-1-a3205153416@gmail.com>
 <20260301203539.1421152-1-a3205153416@gmail.com>
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
index f7b313816e..64c5c9ed1a 100644
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

