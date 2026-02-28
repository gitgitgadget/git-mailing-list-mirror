Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF73E557A
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305573; cv=none; b=AxyoOA6UPdYWpV2TZgneLCtZpbN5pGcs2ohZ/52dY+AzTVyG8fcQB50cBNIfNfDrsODLf7LIE0G1+NBNw1Elae/ISD+1VqtaQKF4UaYBH3Lf6gik4SCCugyBZqSNX6o/H0lBjGqdvZTaHLnVB4BUhdc3YQFYKmJPszY+toRvbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305573; c=relaxed/simple;
	bh=viK7PnE0ne6PYlL8Lm7qqkOvsTtD8lcp7Q0sLbELZso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgK2rl4uffMpqs1yeAeFg9TMms5YF0q/roq6iXwB8sM3QCqt+XBAU9+jN/5OL4MaYg6g9O4tSpkLaOPL0Zu7t8kUwKJu//6j6RJRXWnj5uo6CS8mjBZn5WH39YQl5dcRjb6wloMepnflc/kUhmKSWQMehjCUNzsYe5xT3qriSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POm7LpE7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POm7LpE7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70c38515d3so203032a12.0
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 11:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772305570; x=1772910370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1hc0KC7AhLJuC7B8EDIQdj8wOJAg8o3cUUvx1LUoIM=;
        b=POm7LpE7ZAr1ciKGUmVbNYLCKIwkorEY543KCP9E9WHKuvxr/vrDJw7Sgr4jyuhRJt
         2UdguGMxSOroMiaZnuf1Hb0G0QpjzkOr1s+uKg5iuNYItuhD0g6ewwb9OB1tPOjhn2Mn
         9FCW2Vwl5ll9JEI1iy4yh2zskdOf1c1LN1yItXxhmofGOy0mo8eTi0eo022cFldtOwZr
         Ugnqg+PathTUXQt8iqohKOsIwAAA01FAPu1faunxCy0nnzDN1J3DJhgT0aaG6SM6ZJyt
         VDSjzQOMoMmCd0cBqALHWd2K6MspLStcY+dysEUie5AjvoeN99D4BN9/4iYJ9KB8ZAC1
         htfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305570; x=1772910370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S1hc0KC7AhLJuC7B8EDIQdj8wOJAg8o3cUUvx1LUoIM=;
        b=wHb7rYBfO1JD0CPKhVYrWahBZVsYee8A5luo46i7XmsJxKZaZZ9w33tvok/p8KGD5i
         bkAUgb3M1CgRXIBUotl/Ae/DRwE/ug6GwlXUdujb6MzlyjUkX/Ni8mMwc4NWgZjL2Lg6
         nHPpdNxXf7lgSl10RJzYxaqFyCSO8sqAosFljvtYXSepO+tBLr6gvpwVuS5vV0bhRdEU
         /PJ1/lvA3gPKYMRUne1UYDlB+KhppqGq1I35XIJ5xaO/6ei2N9tKbjj19LQO3ryn38m2
         LQlhWh5lS/1DyMY18ygSQ+jqqk/22jJswCbE1pflCw0bKxv//03q0NMFWwJ2Lb2kucy5
         9L3Q==
X-Gm-Message-State: AOJu0Yx63LUj/QwKqWHTjv35jd7VZ0ABpspAd9C9GzxjxzhTLZ3EqygH
	Au5pl/yNhUOlLvB5X9Zy87rU2iiiEJq4PNGf2shIWwkCsVx5SoeovnTcZg2mqI+r
X-Gm-Gg: ATEYQzxtWh1mPyT0rllI5FG+bKlZAQL72pM5Put6O/aRqDOIApn5TEAIcpTgvXNL47r
	0ujHHYgVu/995ce6/LW+g/ax45il9D6VZsYSpP2TcB6cskombKXBgqpw3OcRQv1LLnxnUAWCfwu
	rjltwwg/+ouRg+68xt5Mtv9PBQYdz5OdzjlhHc77OxyDcyByyY3BJmw2lqik4JoJheRb32SMB+K
	o1xNN8hJAwiNtXT5N4ugxZqfdSuiemJ3mOaQT2N3nWvO7QeuIEBtDtmme8dDVrN3KBti6crIeZY
	Fa2Hrxzljee3OUbtze2mGVpo+x52Y5ton721LaTx+W8wIhrqIyFJ0WaG2CPf5hDEHluRoGcpi6K
	twcrdKMPTeG4gn6mriq8gQ8sJsSFRmW69xgxI1sF7TGrVz8BGs6cnEUUL0ccAqUcTCmpJwPGu7F
	Np6UKfpCCt4v0SV2WmGFyo3XxRP2s1y6VGbSLjBCGJB/RXwicCZbd5twL+WEXzE51ZNOlr8mtcU
	HJNCPmJ/vXkeb1A/NJOlmw=
X-Received: by 2002:a05:6a00:2e98:b0:81f:44bc:8714 with SMTP id d2e1a72fcca58-8274d966ec6mr5372111b3a.2.1772305569642;
        Sat, 28 Feb 2026 11:06:09 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3e4asm8556644b3a.28.2026.02.28.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:06:09 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 3/3] pretty: pass 'struct repository' to pretty_print_commit()
Date: Sun,  1 Mar 2026 03:02:01 +0800
Message-ID: <20260228190201.3684705-4-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228190201.3684705-1-a3205153416@gmail.com>
References: <20260228040727.2057192-1-a3205153416@gmail.com>
 <20260228190201.3684705-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the migration of encoding settings into 'struct repo_settings',
the commit formatting and logging APIs now require a repository context.

Update the signatures of 'pretty_print_commit()' and  'pp_commit_easy()' to
accept 'struct repository *' as their first argument, allowing them to call
'repo_get_log_output_encoding(r)' without relying on the global
'the_repository'.

For callers residing in the 'builtin/' directory, and for areas
that do not yet possess a repository context (such as 'bundle.c'),
fallback to using 'the_repository'.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 builtin/checkout.c    |  4 ++--
 builtin/log.c         |  2 +-
 builtin/merge.c       |  2 +-
 builtin/reset.c       |  2 +-
 builtin/rev-list.c    |  2 +-
 builtin/shortlog.c    |  2 +-
 builtin/show-branch.c |  2 +-
 builtin/stash.c       |  2 +-
 bundle.c              |  2 +-
 log-tree.c            |  6 +++---
 pretty.c              | 13 +++++++------
 pretty.h              |  4 ++--
 range-diff.c          | 10 +++++-----
 revision.c            |  4 ++--
 sequencer.c           | 12 ++++++------
 15 files changed, 35 insertions(+), 34 deletions(-)

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
index 1c9ec09098..922a0788e9 100644
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
index 3c6a2914d8..1ebe0e6038 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -307,7 +307,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 		ctx.color = revs->diffopt.use_color;
 		ctx.rev = revs;
-		pretty_print_commit(&ctx, commit, &buf);
+		pretty_print_commit(the_repository, &ctx, commit, &buf);
 		if (buf.len) {
 			if (revs->commit_format != CMIT_FMT_ONELINE)
 				graph_show_oneline(revs->graph);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index ce9f20de2f..0e47c4dc40 100644
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
index 3d94726251..caaff35cb7 100644
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
index 7914a57b43..4876d0a852 100644
--- a/bundle.c
+++ b/bundle.c
@@ -463,7 +463,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 	ctx.fmt = CMIT_FMT_ONELINE;
 	ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 	strbuf_reset(&buf);
-	pretty_print_commit(&ctx, commit, &buf);
+	pretty_print_commit(the_repository, &ctx, commit, &buf);
 	strbuf_trim(&buf);
 
 	object = (struct object *)commit;
diff --git a/log-tree.c b/log-tree.c
index aea3cbf7c6..2039c31297 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -859,7 +859,7 @@ void show_log(struct rev_info *opt)
 
 		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 		format_display_notes(&commit->object.oid, &notebuf,
-				     repo_get_log_output_encoding(the_repository), raw);
+				     repo_get_log_output_encoding(opt->repo), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
@@ -879,13 +879,13 @@ void show_log(struct rev_info *opt)
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
 	ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
-	ctx.output_encoding = repo_get_log_output_encoding(the_repository);
+	ctx.output_encoding = repo_get_log_output_encoding(opt->repo);
 	ctx.rev = opt;
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
 	if (opt->graph)
 		ctx.graph_width = graph_width(opt->graph);
-	pretty_print_commit(&ctx, commit, &msgbuf);
+	pretty_print_commit(opt->repo, &ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, 0, APPEND_SIGNOFF_DEDUP);
diff --git a/pretty.c b/pretty.c
index e939d0ff3b..8bcd57905d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2281,7 +2281,8 @@ void pp_remainder(struct pretty_print_context *pp,
 	}
 }
 
-void pretty_print_commit(struct pretty_print_context *pp,
+void pretty_print_commit(struct repository *r,
+			 struct pretty_print_context *pp,
 			 const struct commit *commit,
 			 struct strbuf *sb)
 {
@@ -2293,13 +2294,13 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	int need_8bit_cte = pp->need_8bit_cte;
 
 	if (pp->fmt == CMIT_FMT_USERFORMAT) {
-		repo_format_commit_message(the_repository, commit,
+		repo_format_commit_message(r, commit,
 					   user_format, sb, pp);
 		return;
 	}
 
-	encoding = repo_get_log_output_encoding(the_repository);
-	msg = reencoded = repo_logmsg_reencode(the_repository, commit, NULL,
+	encoding = repo_get_log_output_encoding(r);
+	msg = reencoded = repo_logmsg_reencode(r, commit, NULL,
 					       encoding);
 
 	if (pp->fmt == CMIT_FMT_ONELINE || cmit_fmt_is_mail(pp->fmt))
@@ -2363,10 +2364,10 @@ void pretty_print_commit(struct pretty_print_context *pp,
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
index 57edff40a8..368d033ceb 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -418,7 +418,7 @@ static void output_pair_header(struct diff_options *diffopt,
 
 	if (!dashes->len)
 		strbuf_addchars(dashes, '-',
-				strlen(repo_find_unique_abbrev(the_repository, oid, abbrev)));
+				strlen(repo_find_unique_abbrev(diffopt->repo, oid, abbrev)));
 
 	if (!b_util) {
 		color = color_old;
@@ -440,7 +440,7 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
-			    repo_find_unique_abbrev(the_repository, &a_util->oid, abbrev));
+			    repo_find_unique_abbrev(diffopt->repo, &a_util->oid, abbrev));
 
 	if (status == '!')
 		strbuf_addf(buf, "%s%s", color_reset, color);
@@ -452,15 +452,15 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
-			    repo_find_unique_abbrev(the_repository, &b_util->oid, abbrev));
+			    repo_find_unique_abbrev(diffopt->repo, &b_util->oid, abbrev));
 
-	commit = lookup_commit_reference(the_repository, oid);
+	commit = lookup_commit_reference(diffopt->repo, oid);
 	if (commit) {
 		if (status == '!')
 			strbuf_addf(buf, "%s%s", color_reset, color);
 
 		strbuf_addch(buf, ' ');
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
+		pp_commit_easy(diffopt->repo, CMIT_FMT_ONELINE, commit, buf);
 	}
 	strbuf_addf(buf, "%s\n", color_reset);
 
diff --git a/revision.c b/revision.c
index 961ecd1d6c..5c3c5a102d 100644
--- a/revision.c
+++ b/revision.c
@@ -3130,7 +3130,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	diff_setup_done(&revs->diffopt);
 
-	if (!is_encoding_utf8(repo_get_log_output_encoding(the_repository)))
+	if (!is_encoding_utf8(repo_get_log_output_encoding(revs->repo)))
 		revs->grep_filter.ignore_locale = 1;
 	compile_grep_patterns(&revs->grep_filter);
 
@@ -4064,7 +4064,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	 * so we will not end up with a buffer that has two different encodings
 	 * in it.
 	 */
-	encoding = repo_get_log_output_encoding(the_repository);
+	encoding = repo_get_log_output_encoding(opt->repo);
 	message = repo_logmsg_reencode(the_repository, commit, NULL, encoding);
 
 	/* Copy the commit to temporary if we are using "fake" headers */
diff --git a/sequencer.c b/sequencer.c
index b9a4f75c5f..09e6dcca43 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3332,7 +3332,7 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 	return 0;
 }
 
-static int walk_revs_populate_todo(struct todo_list *todo_list,
+static int walk_revs_populate_todo(struct repository *r, struct todo_list *todo_list,
 				struct replay_opts *opts)
 {
 	enum todo_command command = opts->action == REPLAY_PICK ?
@@ -3344,7 +3344,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	if (prepare_revs(opts))
 		return -1;
 
-	encoding = repo_get_log_output_encoding(the_repository);
+	encoding = repo_get_log_output_encoding(r);
 
 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
@@ -5543,7 +5543,7 @@ int sequencer_pick_revisions(struct repository *r,
 	 * progress
 	 */
 
-	if (walk_revs_populate_todo(&todo_list, opts) ||
+	if (walk_revs_populate_todo(r, &todo_list, opts) ||
 			create_seq_dir(r) < 0) {
 		res = -1;
 		goto out;
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

