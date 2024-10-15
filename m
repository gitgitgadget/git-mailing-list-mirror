Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBC1C4A2B
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003802; cv=none; b=dvR+Nt3i+M6AGTQh5U/bgAFP6J/pul8xBWeZTDdS9RAjfNvKJ8PJeO2vk5EmG5z2SbQNdCmVAM2p43M4o/qHcuv4kFao7BLYYggm4DqeVdyhb8tHmkGnARJJTztsWB8FGKNybwLWzpQMufmt5XHQWg9yHo58DD4d9I4Azd26ZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003802; c=relaxed/simple;
	bh=dt8IoWK2XM+0QMbvzlSIvGCliSmQ29q4nisktjUFDT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVLrjsKnCW9KqnUJNcuRFfSJSm/pz2zVC17wmf4v0oiDBBHOyzoe2KsUOxqlokdWrpGkSrJBs9T1YhsDx+Y31H8tnpv5Ycx/h2qtqDPWysps1RT1B9dgyDDMqYkgen9V8Mb/XQv0kafuWf/te8wusSOGnteDYJ5ydjFSHPNFa2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDpPB7dQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDpPB7dQ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e74900866so758519b3a.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729003800; x=1729608600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1kP66qCqLLS6wrKSOpQrTJEAMPNULxXbNTshULQCcs=;
        b=lDpPB7dQYOWWv/da3ZLhG+jbGLS/pEEyFA4olfaj7u3OwzWf7IF7l68YOdTJIwG9VZ
         QNBmL7u1E8vPEGojKyebXzIvMD7IENeIuLB6SuomLLx6MEDGPAaPBN6H0NAR/Ly1kKsa
         DrLFaSRNKJ/vsMVUxG2S/KAkDd1TmUquWR+iyZW1r5e8uQBFF6TMY29v5jExZqNmjuyT
         M8FQhMIjQGDniwuyw9gkliZ2OVzD46YgPapTA2ojjaxrcn5plll/BePQHG/3b9bQ7Faj
         pFFCDubPllew5lYp33v6qHwJRWH+jGx4ENSPaGIeukLeMQ6Ui7DDPmNCgVWULMZ8QQbW
         Jd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003800; x=1729608600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1kP66qCqLLS6wrKSOpQrTJEAMPNULxXbNTshULQCcs=;
        b=ntZeUOdiSnJVvAEG1QvVETk6O36ThoYCbMTnr6x/n+4GLCPkRpspnMHLi4F+WSOANT
         QcQEFA2n/NFE9DXywWyFiv4LCB0tD5IuzZHoB8T3rtmAW8mjhy2yrJ3ltQ74GcYc3MpN
         pnpl5mFW6WiIU+y324MASiaDS1wOKnUUp7OWCAoMjBwLUygJ+Wu7dA+95Phvttu1mNsY
         kI3ruGJEsSU4VhpM0b8UdFoZ20ly/m1b7u0K++H9c2csKAP0yTlC1fieU9KCyT1NbRzE
         VQIuojKh9GCJw3GBkNcF5PsFr+2hzEyjOQPo9KLAS/vzhO9yJZicvQm0ATNFI/PeCu5q
         VorQ==
X-Gm-Message-State: AOJu0Yxnt8l79lonK28S3or72/bqW8LMFq428oJ0v3xfRzCWHK29y+2a
	NcZSzOYpb401ZOYxS/V+AOjmkfEvtFp/iVPwcwfhdXVM7xv9pwoJ8AcyvQ==
X-Google-Smtp-Source: AGHT+IH6SAkD5rmDWZfHOsddIKUusxF8kUtNA1MKPBPF7NCLqrZHRrgglHWNas9Rz6Zr1HA1ROchCw==
X-Received: by 2002:a05:6a00:2d9d:b0:71e:7d52:fa6d with SMTP id d2e1a72fcca58-71e7daef151mr862508b3a.21.1729003799506;
        Tue, 15 Oct 2024 07:49:59 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:51ac:756c:f3be:7ccc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e7753420asm1328000b3a.205.2024.10.15.07.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:49:59 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH 2/3] pretty: don't rely on "the_repository"
Date: Tue, 15 Oct 2024 20:01:23 +0530
Message-ID: <20241015144935.4059-3-five231003@gmail.com>
X-Mailer: git-send-email 2.47.0.73.g7a80afd5fd.dirty
In-Reply-To: <20241015144935.4059-1-five231003@gmail.com>
References: <20241015144935.4059-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change pretty so that it doesn't have to implicitly rely on being given
"the_repository" anymore and can handle any arbitrary repository -
hence also allowing us to remove the USE_THE_REPOSITORY_VARIABLE guard.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 builtin/checkout.c    |  6 +++--
 builtin/log.c         |  4 +--
 builtin/merge.c       |  2 +-
 builtin/reset.c       |  2 +-
 builtin/rev-list.c    |  2 +-
 builtin/shortlog.c    |  3 ++-
 builtin/show-branch.c |  3 ++-
 builtin/stash.c       |  2 +-
 bundle.c              |  2 +-
 log-tree.c            |  2 +-
 pretty.c              | 63 ++++++++++++++++++++++++-------------------
 pretty.h              | 14 +++++-----
 range-diff.c          |  2 +-
 revision.c            |  6 ++---
 sequencer.c           | 11 ++++----
 15 files changed, 69 insertions(+), 55 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9c30000d3a..e90354c893 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -675,7 +675,8 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (!repo_parse_commit(the_repository, commit))
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
+		pp_commit_easy(the_repository, CMIT_FMT_ONELINE,
+			       commit, &sb);
 	if (print_sha1_ellipsis()) {
 		fprintf(stderr, "%s %s... %s\n", msg,
 			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV),
@@ -1063,7 +1064,8 @@ static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 	strbuf_add_unique_abbrev(sb, &commit->object.oid, DEFAULT_ABBREV);
 	strbuf_addch(sb, ' ');
 	if (!repo_parse_commit(the_repository, commit))
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
+		pp_commit_easy(the_repository, CMIT_FMT_ONELINE,
+			       commit, sb);
 	strbuf_addch(sb, '\n');
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index c28064c6f3..4e107bf775 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -186,7 +186,7 @@ static void cmd_log_init_defaults(struct rev_info *rev,
 				  struct log_config *cfg)
 {
 	if (cfg->fmt_pretty)
-		get_commit_format(cfg->fmt_pretty, rev);
+		get_commit_format(the_repository, cfg->fmt_pretty, rev);
 	if (cfg->default_follow)
 		rev->diffopt.flags.default_follow_renames = 1;
 	rev->verbose_header = 1;
@@ -2618,7 +2618,7 @@ static void print_commit(char sign, struct commit *commit, int verbose,
 		       repo_find_unique_abbrev(the_repository, &commit->object.oid, abbrev));
 	} else {
 		struct strbuf buf = STRBUF_INIT;
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
+		pp_commit_easy(the_repository, CMIT_FMT_ONELINE, commit, &buf);
 		fprintf(file, "%c %s %s\n", sign,
 		       repo_find_unique_abbrev(the_repository, &commit->object.oid, abbrev),
 		       buf.buf);
diff --git a/builtin/merge.c b/builtin/merge.c
index 84d0f3604b..7d5fda8acf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -427,7 +427,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 		strbuf_addch(&out, '\n');
 		strbuf_addf(&out, "commit %s\n",
 			oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&ctx, commit, &out);
+		pretty_print_commit(the_repository, &ctx, commit, &out);
 	}
 	write_file_buf(git_path_squash_msg(the_repository), out.buf, out.len);
 	strbuf_release(&out);
diff --git a/builtin/reset.c b/builtin/reset.c
index 7154f88826..6395b65584 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -139,7 +139,7 @@ static void print_new_head_line(struct commit *commit)
 	printf(_("HEAD is now at %s"),
 		repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
 
-	pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
+	pp_commit_easy(the_repository, CMIT_FMT_ONELINE, commit, &buf);
 	if (buf.len > 0)
 		printf(" %s", buf.buf);
 	putchar('\n');
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index e8427a7c0c..1b564dea59 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -221,7 +221,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 		ctx.color = revs->diffopt.use_color;
 		ctx.rev = revs;
-		pretty_print_commit(&ctx, commit, &buf);
+		pretty_print_commit(the_repository, &ctx, commit, &buf);
 		if (buf.len) {
 			if (revs->commit_format != CMIT_FMT_ONELINE)
 				graph_show_oneline(revs->graph);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 81b8baf44a..426d86cc65 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -250,7 +250,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 
 	if (!log->summary) {
 		if (log->user_format)
-			pretty_print_commit(&ctx, commit, &oneline);
+			pretty_print_commit(the_repository, &ctx,
+					    commit, &oneline);
 		else
 			repo_format_commit_message(the_repository, commit,
 						   "%s", &oneline, &ctx);
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index cd6bdf63bc..769e952175 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -301,7 +301,8 @@ static void show_one_commit(struct commit *commit, int no_name)
 	struct commit_name *name = commit_to_name(commit);
 
 	if (commit->object.parsed) {
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
+		pp_commit_easy(the_repository, CMIT_FMT_ONELINE,
+			       commit, &pretty);
 		pretty_str = pretty.buf;
 	}
 	skip_prefix(pretty_str, "[PATCH] ", &pretty_str);
diff --git a/builtin/stash.c b/builtin/stash.c
index 1399a1bbe2..2ffe5f7736 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1403,7 +1403,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 						  &head_commit->object.oid,
 						  DEFAULT_ABBREV);
 	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
-	pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
+	pp_commit_easy(the_repository, CMIT_FMT_ONELINE, head_commit, &msg);
 
 	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
 	commit_list_insert(head_commit, &parents);
diff --git a/bundle.c b/bundle.c
index aad00836b9..27a1cad633 100644
--- a/bundle.c
+++ b/bundle.c
@@ -485,7 +485,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 	ctx.fmt = CMIT_FMT_ONELINE;
 	ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 	strbuf_reset(&buf);
-	pretty_print_commit(&ctx, commit, &buf);
+	pretty_print_commit(the_repository, &ctx, commit, &buf);
 	strbuf_trim(&buf);
 
 	object = (struct object *)commit;
diff --git a/log-tree.c b/log-tree.c
index 6bbddcf85a..37ea632230 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -858,7 +858,7 @@ void show_log(struct rev_info *opt)
 		ctx.from_ident = &opt->from_ident;
 	if (opt->graph)
 		ctx.graph_width = graph_width(opt->graph);
-	pretty_print_commit(&ctx, commit, &msgbuf);
+	pretty_print_commit(the_repository, &ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, 0, APPEND_SIGNOFF_DEDUP);
diff --git a/pretty.c b/pretty.c
index e7b069a48c..cc093c3787 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
@@ -42,7 +40,8 @@ static struct cmt_fmt_map {
 static size_t builtin_formats_len;
 static size_t commit_formats_len;
 static size_t commit_formats_alloc;
-static struct cmt_fmt_map *find_commit_format(const char *sought);
+static struct cmt_fmt_map *find_commit_format(struct repository *r,
+					      const char *sought);
 
 int commit_format_is_empty(enum cmit_fmt fmt)
 {
@@ -116,7 +115,7 @@ static int git_pretty_formats_config(const char *var, const char *value,
 	return 0;
 }
 
-static void setup_commit_formats(void)
+static void setup_commit_formats(struct repository *r)
 {
 	struct cmt_fmt_map builtin_formats[] = {
 		{ "raw",	CMIT_FMT_RAW,		0,	0 },
@@ -140,7 +139,7 @@ static void setup_commit_formats(void)
 	COPY_ARRAY(commit_formats, builtin_formats,
 		   ARRAY_SIZE(builtin_formats));
 
-	git_config(git_pretty_formats_config, NULL);
+	repo_config(r, git_pretty_formats_config, NULL);
 }
 
 static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
@@ -178,15 +177,17 @@ static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
 	return found;
 }
 
-static struct cmt_fmt_map *find_commit_format(const char *sought)
+static struct cmt_fmt_map *find_commit_format(struct repository *r,
+					      const char *sought)
 {
 	if (!commit_formats)
-		setup_commit_formats();
+		setup_commit_formats(r);
 
 	return find_commit_format_recursive(sought, sought, 0);
 }
 
-void get_commit_format(const char *arg, struct rev_info *rev)
+void get_commit_format(struct repository *r, const char *arg,
+		       struct rev_info *rev)
 {
 	struct cmt_fmt_map *commit_format;
 
@@ -205,7 +206,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		return;
 	}
 
-	commit_format = find_commit_format(arg);
+	commit_format = find_commit_format(r, arg);
 	if (!commit_format)
 		die("invalid --pretty format: %s", arg);
 
@@ -1434,7 +1435,8 @@ static void free_decoration_options(const struct decoration_options *opts)
 	free(opts->tag);
 }
 
-static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
+static size_t format_commit_one(struct repository *r,
+				struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
 {
@@ -1546,7 +1548,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	/* these depend on the commit */
 	if (!commit->object.parsed)
-		parse_object(the_repository, &commit->object.oid);
+		parse_object(r, &commit->object.oid);
 
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
@@ -1784,7 +1786,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	return 0;	/* unknown placeholder */
 }
 
-static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
+static size_t format_and_pad_commit(struct repository *r,
+				    struct strbuf *sb, /* in UTF-8 */
 				    const char *placeholder,
 				    struct format_commit_context *c)
 {
@@ -1803,7 +1806,8 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 	}
 	while (1) {
 		int modifier = *placeholder == 'C';
-		size_t consumed = format_commit_one(&local_sb, placeholder, c);
+		size_t consumed = format_commit_one(r, &local_sb,
+						    placeholder, c);
 		total_consumed += consumed;
 
 		if (!modifier)
@@ -1888,7 +1892,8 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 	return total_consumed;
 }
 
-static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
+static size_t format_commit_item(struct repository *r,
+				 struct strbuf *sb, /* in UTF-8 */
 				 const char *placeholder,
 				 struct format_commit_context *context)
 {
@@ -1930,9 +1935,9 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 
 	orig_len = sb->len;
 	if (context->flush_type == no_flush)
-		consumed = format_commit_one(sb, placeholder, context);
+		consumed = format_commit_one(r, sb, placeholder, context);
 	else
-		consumed = format_and_pad_commit(sb, placeholder, context);
+		consumed = format_and_pad_commit(r, sb, placeholder, context);
 	if (magic == NO_MAGIC)
 		return consumed;
 
@@ -2001,7 +2006,7 @@ void repo_format_commit_message(struct repository *r,
 
 		if (skip_prefix(format, "%", &format))
 			strbuf_addch(sb, '%');
-		else if ((len = format_commit_item(sb, format, &context)))
+		else if ((len = format_commit_item(r, sb, format, &context)))
 			format += len;
 		else
 			strbuf_addch(sb, '%');
@@ -2034,7 +2039,8 @@ void repo_format_commit_message(struct repository *r,
 	repo_unuse_commit_buffer(r, commit, context.message);
 }
 
-static void pp_header(struct pretty_print_context *pp,
+static void pp_header(struct repository *r,
+		      struct pretty_print_context *pp,
 		      const char *encoding,
 		      const struct commit *commit,
 		      const char **msg_p,
@@ -2060,7 +2066,7 @@ static void pp_header(struct pretty_print_context *pp,
 		}
 
 		if (starts_with(line, "parent ")) {
-			if (linelen != the_hash_algo->hexsz + 8)
+			if (linelen != r->hash_algo->hexsz + 8)
 				die("bad parent line in commit");
 			continue;
 		}
@@ -2279,7 +2285,8 @@ void pp_remainder(struct pretty_print_context *pp,
 	}
 }
 
-void pretty_print_commit(struct pretty_print_context *pp,
+void pretty_print_commit(struct repository *r,
+			 struct pretty_print_context *pp,
 			 const struct commit *commit,
 			 struct strbuf *sb)
 {
@@ -2291,14 +2298,13 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	int need_8bit_cte = pp->need_8bit_cte;
 
 	if (pp->fmt == CMIT_FMT_USERFORMAT) {
-		repo_format_commit_message(the_repository, commit,
+		repo_format_commit_message(r, commit,
 					   user_format, sb, pp);
 		return;
 	}
 
-	encoding = repo_get_log_output_encoding(the_repository);
-	msg = reencoded = repo_logmsg_reencode(the_repository, commit, NULL,
-					       encoding);
+	encoding = repo_get_log_output_encoding(r);
+	msg = reencoded = repo_logmsg_reencode(r, commit, NULL, encoding);
 
 	if (pp->fmt == CMIT_FMT_ONELINE || cmit_fmt_is_mail(pp->fmt))
 		indent = 0;
@@ -2326,7 +2332,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 		}
 	}
 
-	pp_header(pp, encoding, commit, &msg, sb);
+	pp_header(r, pp, encoding, commit, &msg, sb);
 	if (pp->fmt != CMIT_FMT_ONELINE && !cmit_fmt_is_mail(pp->fmt)) {
 		strbuf_addch(sb, '\n');
 	}
@@ -2358,13 +2364,14 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	if (cmit_fmt_is_mail(pp->fmt) && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	repo_unuse_commit_buffer(the_repository, commit, reencoded);
+	repo_unuse_commit_buffer(r, commit, reencoded);
 }
 
-void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
+void pp_commit_easy(struct repository *r, enum cmit_fmt fmt,
+		    const struct commit *commit,
 		    struct strbuf *sb)
 {
 	struct pretty_print_context pp = {0};
 	pp.fmt = fmt;
-	pretty_print_commit(&pp, commit, sb);
+	pretty_print_commit(r, &pp, commit, sb);
 }
diff --git a/pretty.h b/pretty.h
index df267afe4a..530782337a 100644
--- a/pretty.h
+++ b/pretty.h
@@ -81,8 +81,8 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w);
  * Shortcut for invoking pretty_print_commit if we do not have any context.
  * Context would be set empty except "fmt".
  */
-void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
-			struct strbuf *sb);
+void pp_commit_easy(struct repository *r, enum cmit_fmt fmt,
+		    const struct commit *commit, struct strbuf *sb);
 
 /*
  * Get information about user and date from "line", format it and
@@ -124,16 +124,18 @@ void repo_format_commit_message(struct repository *r,
  * Parse given arguments from "arg", check it for correctness and
  * fill struct rev_info.
  */
-void get_commit_format(const char *arg, struct rev_info *);
+void get_commit_format(struct repository *r, const char *arg,
+		       struct rev_info *);
 
 /*
  * Make a commit message with all rules from given "pp"
  * and put it into "sb".
  * Please use this function if you have a context (candidate for "pp").
  */
-void pretty_print_commit(struct pretty_print_context *pp,
-			const struct commit *commit,
-			struct strbuf *sb);
+void pretty_print_commit(struct repository *r,
+			 struct pretty_print_context *pp,
+			 const struct commit *commit,
+			 struct strbuf *sb);
 
 /*
  * Change line breaks in "msg" to "line_separator" and put it into "sb".
diff --git a/range-diff.c b/range-diff.c
index 10885ba301..e5fb27a65b 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -442,7 +442,7 @@ static void output_pair_header(struct diff_options *diffopt,
 			strbuf_addf(buf, "%s%s", color_reset, color);
 
 		strbuf_addch(buf, ' ');
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
+		pp_commit_easy(the_repository, CMIT_FMT_ONELINE, commit, buf);
 	}
 	strbuf_addf(buf, "%s\n", color_reset);
 
diff --git a/revision.c b/revision.c
index c3a54577b0..1dfb8a52cf 100644
--- a/revision.c
+++ b/revision.c
@@ -2553,7 +2553,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--pretty")) {
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
-		get_commit_format(NULL, revs);
+		get_commit_format(the_repository, NULL, revs);
 	} else if (skip_prefix(arg, "--pretty=", &optarg) ||
 		   skip_prefix(arg, "--format=", &optarg)) {
 		/*
@@ -2562,7 +2562,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		 */
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
-		get_commit_format(optarg, revs);
+		get_commit_format(the_repository, optarg, revs);
 	} else if (!strcmp(arg, "--expand-tabs")) {
 		revs->expand_tabs_in_log = 8;
 	} else if (!strcmp(arg, "--no-expand-tabs")) {
@@ -2606,7 +2606,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes = 0;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
-		get_commit_format("oneline", revs);
+		get_commit_format(the_repository, "oneline", revs);
 		revs->pretty_given = 1;
 		revs->abbrev_commit = 1;
 	} else if (!strcmp(arg, "--graph")) {
diff --git a/sequencer.c b/sequencer.c
index 25783d3b8b..a51feb0242 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1477,7 +1477,7 @@ void print_commit_summary(struct repository *r,
 
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
-	get_commit_format(format.buf, &rev);
+	get_commit_format(the_repository, format.buf, &rev);
 	rev.always_show_header = 0;
 	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
 	diff_setup_done(&rev.diffopt);
@@ -5883,7 +5883,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			continue;
 
 		strbuf_reset(&oneline);
-		pretty_print_commit(pp, commit, &oneline);
+		pretty_print_commit(the_repository, pp, commit, &oneline);
 
 		to_merge = commit->parents ? commit->parents->next : NULL;
 		if (!to_merge) {
@@ -6017,7 +6017,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				strbuf_addf(out, "%s onto\n", cmd_reset);
 			else {
 				strbuf_reset(&oneline);
-				pretty_print_commit(pp, commit, &oneline);
+				pretty_print_commit(the_repository, pp,
+						    commit, &oneline);
 				strbuf_addf(out, "%s %s # %s\n",
 					    cmd_reset, to, oneline.buf);
 			}
@@ -6088,7 +6089,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 		free(format);
 		format = xstrdup("%s");
 	}
-	get_commit_format(format, &revs);
+	get_commit_format(the_repository, format, &revs);
 	free(format);
 	pp.fmt = revs.commit_format;
 	pp.output_encoding = repo_get_log_output_encoding(r);
@@ -6122,7 +6123,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			continue;
 		strbuf_addf(out, "%s %s ", insn,
 			    oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&pp, commit, out);
+		pretty_print_commit(the_repository, &pp, commit, out);
 		if (is_empty)
 			strbuf_addf(out, " %s empty", comment_line_str);
 		strbuf_addch(out, '\n');
-- 
2.47.0.73.g7a80afd5fd.dirty

