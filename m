Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348E38BF70
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441913; cv=none; b=iTcCRgiaRhzUgxSr6DSIjEHU3n5DwN5UqymlFCl1hVV/oDblshDQEwkwaI6QxbzzDgYpvdFHU9fNWxhnsweJMM0k2HNEUnLhGRdmJPM/GDhkj2u68sMAEyvzL3v99BDd7BBGj+L2C6uD3nblWfUDgAfq2ZGtmvVfV4udSwWYePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441913; c=relaxed/simple;
	bh=HhWUIjSlm9IZZGUP0WwA0hV9aVBfGg0bZGwMG1qxjAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxeMof+raowYKYg3hHpJaMWly8OZKK/m5/VQ1nvNJQtzhf0/tjX7pc7LKMS0dA7/kkOMTjFYEwz1EzNY9cmV//jNT2ZCRsYZWP9zm+K/ufhGkRw92wMCZb9jC7ZmN8gIPtTzUWQoqRcXKjQIh5aItr5F4IALUqjQl240ZNvv4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR3RWQ2Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR3RWQ2Z"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a9633ef0d6so6238375ad.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 00:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772441911; x=1773046711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnFXc36Bz4cY+F5/QpOsydftJxPvKdE0p0HRivkIYg8=;
        b=YR3RWQ2ZNNpD2rqJTmm+llhGqMyB226JsKSTNDxColKn8JHcTwtuPNmZ1z4awvlVNs
         ExAT+Nh2wwu5bjrsoYys0Zyejbu8TJfH2Px0MkubEW4UAVC6lfVPFG+ctsciAEA0K/2C
         77Uyg4N5uPcEaeTZoRz1wOc4GeRj4UZcn56zTuTK2J+hdYAIPuCEgN2Df1HolvTcnrmK
         HMn0id5CpQFPceegRs7OceJ2ZrDjYUAqTC5WqMqP+ugNedDZDlbtRmC356kbswAqbji7
         MLmf79Y1y8UQkdQLFDji5fgf5iUosyX25VRGiHrnNySPiW2Di/3B8r1yBv50v/TjbYzg
         YjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441911; x=1773046711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KnFXc36Bz4cY+F5/QpOsydftJxPvKdE0p0HRivkIYg8=;
        b=oxVtjquJv563MaXv2+FWKxcqenUAbvgrLHI0f0LScqe2TF/dAr+KtbWn+bcAM0HGTR
         R3GjNiBbAzLazDfGKKAOcDtoTzZZjQGZ8QNthOcFHcI2fOSeeDm7U/2V70LLFYCwke1B
         Wu/AltbJ7AhYMyyYq4uxenpDrOj/BAG3kv8avBsrJO+9+GqGwdDCo5QBF38JN3D9Glx7
         M7rO3+aN+bLKrg+COM7+Tx43sj9dbymMXutWv6Eg/XejUcLzeSypC0yN4do5aRvPyhLZ
         czPUZKAJNxqLHSPwoZGYSOwtGfDgb5ruNJ7llsGnnKLgv6rVLxY7nXkZaYN+2iv0DBAI
         Hj0w==
X-Gm-Message-State: AOJu0YzQu6jnL3D54RQ6kgo/PZBakAA9oe6m4AqozRnqrfjpzZ3SCU5c
	+Ulx0Osdgcc047Ow3FInrNvmVE2g27eye0YB1MqOGUn6cd6fl9jiCHT8niOIbKuQ
X-Gm-Gg: ATEYQzyXikCErpFmRXZcpEMeVtGkjhTXFpiB5ZVfC406h0WXirfwj/0sZGWuzpSoIwB
	CuFiBFqwufRwObOhZV+y4EPj2rFSaJWPMB51TJWnWQ7RWaQsq8AFrV/Fca0xZzibdIL7EQg1pBb
	bxGlWdnOSHYCjs3tfNcKxNXyqdMEu5ePG93QAOtSWWgUoN1ghMKxlWiORT5niiHK60T1aHiN9V5
	LG2gZQxBRL9hdDs4OoCbU3T2bV5uaE2CkxL2AoVDTD+RBbHwjukXAj//5mCiW3rR/RNp4JP10to
	Qv5hovVwrhGh2L/uYkp6g6uDwyUbr4YPIpYEOJdfZLCgiokUIh5XyF7D+E2UxHHLWLqYSCu60Sf
	v3MoUTZYKmeOxzQZ5oD7ZnFfF3HUT0ArsPSnwNadHP9JrxCfXPJQuk7d2otkHPzZsHWWuoi3x9G
	TuA8sG/soxHOZdZoXM80uwio7ILh8Dhs04XhXdOKj9nrC7RnHnKOU67Is5Xc+jvB9tdsL/KKi7q
	8fa3Hhlv4JB9b/VK5IsJx+7aqDl+1M05g==
X-Received: by 2002:a17:903:11cd:b0:2ad:c66b:f5f6 with SMTP id d9443c01a7336-2ae2e02f410mr77417415ad.0.1772441910690;
        Mon, 02 Mar 2026 00:58:30 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4d31138fsm33920325ad.83.2026.03.02.00.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:58:30 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	jltobler@gmail.com
Subject: [PATCH v4 3/3] environment: migrate encoding configs to repo_config_values()
Date: Mon,  2 Mar 2026 16:57:37 +0800
Message-ID: <20260302085738.2510514-4-a3205153416@gmail.com>
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

The global variables 'git_commit_encoding' and 'git_log_output_encoding'
prevent libification.

Migrate these variables into the 'struct repo_config_values'. This ensures
that they are safely accessed via the 'repo_config_values()' accessor which
prevents uninitialized or cross-repository access.

Note that these variables are not migrated to 'repo_settings'. As eagerly
parsed user preferences, deferring them to lazy evaluation would break
early validation.

Currently, during the config parsing phase in 'git_default_i18n_config()',
the values are still parsed into the 'the_repository' instance of
'repo_config_values', Since safely plumbing a repository pointer through
the 'git_default_config' callback machinery remains highly invasive due
to custom contexts being passed via the 'void *cb' parameter.
However, the read-paths (commit APIs and log formatters) updated in
previous patches are now fully plumbed to accept any repository
instance.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 builtin/am.c       |  4 ++--
 builtin/blame.c    |  2 +-
 builtin/commit.c   |  6 +++---
 builtin/log.c      |  2 +-
 builtin/mailinfo.c |  6 +++---
 builtin/rev-list.c |  2 +-
 builtin/shortlog.c |  2 +-
 bundle.c           |  2 +-
 commit.c           | 13 +++++++------
 environment.c      | 33 ++++++++++++++++++++-------------
 environment.h      | 10 +++++-----
 log-tree.c         |  4 ++--
 pretty.c           |  2 +-
 remote-curl.c      |  2 +-
 replay.c           |  2 +-
 repository.c       |  2 ++
 revision.c         | 12 +++++++-----
 sequencer.c        | 22 +++++++++++-----------
 submodule.c        |  2 +-
 19 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5296124f84..990b6c54e7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1216,7 +1216,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	setup_mailinfo(the_repository, &mi);
 
 	if (state->utf8)
-		mi.metainfo_charset = get_commit_output_encoding();
+		mi.metainfo_charset = get_commit_output_encoding(the_repository);
 	else
 		mi.metainfo_charset = NULL;
 
@@ -1355,7 +1355,7 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	struct ident_split id;
 
 	buffer = repo_logmsg_reencode(the_repository, commit, NULL,
-				      get_commit_output_encoding());
+				      get_commit_output_encoding(the_repository));
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 	if (!ident_line)
diff --git a/builtin/blame.c b/builtin/blame.c
index eac2fe7320..0ad9f2c9f7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -202,7 +202,7 @@ static void get_commit_info(struct commit *commit, struct commit_info *ret)
 	const char *subject, *encoding;
 	const char *message;
 
-	encoding = get_log_output_encoding();
+	encoding = get_log_output_encoding(the_repository);
 	message = repo_logmsg_reencode(the_repository, commit, NULL, encoding);
 	get_ac_line(message, "\nauthor ",
 		    &ret->author, &ret->author_mail,
diff --git a/builtin/commit.c b/builtin/commit.c
index d619fd2ace..caf5896d97 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -794,7 +794,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			c = lookup_commit_reference_by_name(squash_message);
 			if (!c)
 				die(_("could not lookup commit '%s'"), squash_message);
-			ctx.output_encoding = get_commit_output_encoding();
+			ctx.output_encoding = get_commit_output_encoding(the_repository);
 			repo_format_commit_message(the_repository, c,
 						   "squash! %s\n\n", &sb,
 						   &ctx);
@@ -829,7 +829,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		commit = lookup_commit_reference_by_name(fixup_commit);
 		if (!commit)
 			die(_("could not lookup commit '%s'"), fixup_commit);
-		ctx.output_encoding = get_commit_output_encoding();
+		ctx.output_encoding = get_commit_output_encoding(the_repository);
 		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
 		repo_format_commit_message(the_repository, commit, fmt, &sb,
 					   &ctx);
@@ -1235,7 +1235,7 @@ static const char *read_commit_message(const char *name)
 	commit = lookup_commit_reference_by_name(name);
 	if (!commit)
 		die(_("could not lookup commit '%s'"), name);
-	out_enc = get_commit_output_encoding();
+	out_enc = get_commit_output_encoding(the_repository);
 	return repo_logmsg_reencode(the_repository, commit, NULL, out_enc);
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 0758aed580..8edb3c54e7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -568,7 +568,7 @@ static void show_tagger(const char *buf, struct rev_info *rev)
 
 	pp.fmt = rev->commit_format;
 	pp.date_mode = rev->date_mode;
-	pp_user_info(&pp, "Tagger", &out, buf, get_log_output_encoding());
+	pp_user_info(&pp, "Tagger", &out, buf, get_log_output_encoding(the_repository));
 	fprintf(rev->diffopt.file, "%s", out.buf);
 	strbuf_release(&out);
 }
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 8de7ba7de1..4f17cf1598 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -52,7 +52,7 @@ static int parse_opt_quoted_cr(const struct option *opt, const char *arg, int un
 int cmd_mailinfo(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	struct metainfo_charset meta_charset;
 	struct mailinfo mi;
@@ -83,7 +83,7 @@ int cmd_mailinfo(int argc,
 		OPT_END()
 	};
 
-	setup_mailinfo(the_repository, &mi);
+	setup_mailinfo(repo, &mi);
 	meta_charset.policy = CHARSET_DEFAULT;
 
 	argc = parse_options(argc, argv, prefix, options, mailinfo_usage, 0);
@@ -93,7 +93,7 @@ int cmd_mailinfo(int argc,
 
 	switch (meta_charset.policy) {
 	case CHARSET_DEFAULT:
-		mi.metainfo_charset = get_commit_output_encoding();
+		mi.metainfo_charset = get_commit_output_encoding(repo);
 		break;
 	case CHARSET_NO_REENCODE:
 		mi.metainfo_charset = NULL;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 57c7b8d3ff..3732edae8b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -304,7 +304,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.date_mode = revs->date_mode;
 		ctx.date_mode_explicit = revs->date_mode_explicit;
 		ctx.fmt = revs->commit_format;
-		ctx.output_encoding = get_log_output_encoding();
+		ctx.output_encoding = get_log_output_encoding(the_repository);
 		ctx.color = revs->diffopt.use_color;
 		ctx.rev = revs;
 		pretty_print_commit(the_repository, &ctx, commit, &buf);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 109785fd00..79606e57be 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -248,7 +248,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
 	ctx.date_mode = log->date_mode;
-	ctx.output_encoding = get_log_output_encoding();
+	ctx.output_encoding = get_log_output_encoding(the_repository);
 
 	if (!log->summary) {
 		if (log->user_format)
diff --git a/bundle.c b/bundle.c
index 3bc2ed9ee9..3b98cdd6fd 100644
--- a/bundle.c
+++ b/bundle.c
@@ -461,7 +461,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 	write_or_die(bpi->fd, buf.buf, buf.len);
 
 	ctx.fmt = CMIT_FMT_ONELINE;
-	ctx.output_encoding = get_log_output_encoding();
+	ctx.output_encoding = get_log_output_encoding(the_repository);
 	strbuf_reset(&buf);
 	pretty_print_commit(the_repository, &ctx, commit, &buf);
 	strbuf_trim(&buf);
diff --git a/commit.c b/commit.c
index 71a2b7bbe5..cb8ec675d1 100644
--- a/commit.c
+++ b/commit.c
@@ -1663,7 +1663,8 @@ N_("Warning: commit message did not conform to UTF-8.\n"
    "You may want to amend it after fixing the message, or set the config\n"
    "variable i18n.commitEncoding to the encoding your project uses.\n");
 
-static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg_len,
+static void write_commit_tree(struct repository *r, struct strbuf *buffer,
+			      const char *msg, size_t msg_len,
 			      const struct object_id *tree,
 			      const struct object_id *parents, size_t parents_len,
 			      const char *author, const char *committer,
@@ -1673,7 +1674,7 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 	size_t i;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+	encoding_is_utf8 = is_encoding_utf8(get_commit_output_encoding(r));
 
 	strbuf_grow(buffer, 8192); /* should avoid reallocs for the headers */
 	strbuf_addf(buffer, "tree %s\n", oid_to_hex(tree));
@@ -1694,7 +1695,7 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 		committer = git_committer_info(IDENT_STRICT);
 	strbuf_addf(buffer, "committer %s\n", committer);
 	if (!encoding_is_utf8)
-		strbuf_addf(buffer, "encoding %s\n", git_commit_encoding);
+		strbuf_addf(buffer, "encoding %s\n", get_commit_output_encoding(r));
 
 	while (extra) {
 		add_extra_header(buffer, extra);
@@ -1722,7 +1723,7 @@ int commit_tree_extended(struct repository *r, const char *msg, size_t msg_len,
 	size_t i, nparents;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+	encoding_is_utf8 = is_encoding_utf8(get_commit_output_encoding(r));
 
 	odb_assert_oid_type(the_repository->objects, tree, OBJ_TREE);
 
@@ -1735,7 +1736,7 @@ int commit_tree_extended(struct repository *r, const char *msg, size_t msg_len,
 	for (const struct commit_list *p = parents; p; p = p->next)
 		oidcpy(&parent_buf[i++], &p->item->object.oid);
 
-	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
+	write_commit_tree(r, &buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
 	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
 		result = -1;
 		goto out;
@@ -1763,7 +1764,7 @@ int commit_tree_extended(struct repository *r, const char *msg, size_t msg_len,
 			free(mapped_parents);
 			goto out;
 		}
-		write_commit_tree(&compat_buffer, msg, msg_len, &mapped_tree,
+		write_commit_tree(r, &compat_buffer, msg, msg_len, &mapped_tree,
 				  mapped_parents, nparents, author, committer, compat_extra);
 		free_commit_extra_headers(compat_extra);
 		free(mapped_parents);
diff --git a/environment.c b/environment.c
index 3ee88e20ff..948e22ec26 100644
--- a/environment.c
+++ b/environment.c
@@ -50,8 +50,6 @@ int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
 int warn_on_object_refname_ambiguity = 1;
-char *git_commit_encoding;
-char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
 int zlib_compression_level = Z_BEST_SPEED;
@@ -194,15 +192,22 @@ const char *strip_namespace(const char *namespaced_ref)
 	return NULL;
 }
 
-const char *get_log_output_encoding(void)
+const char *get_log_output_encoding(struct repository *r)
 {
-	return git_log_output_encoding ? git_log_output_encoding
-		: get_commit_output_encoding();
+	struct repo_config_values *cfg;
+	if (r != the_repository)
+		return get_commit_output_encoding(r);
+	cfg = repo_config_values(r);
+	return cfg->log_output_encoding ? cfg->log_output_encoding : get_commit_output_encoding(r);
 }
 
-const char *get_commit_output_encoding(void)
+const char *get_commit_output_encoding(struct repository *r)
 {
-	return git_commit_encoding ? git_commit_encoding : "UTF-8";
+	struct repo_config_values *cfg;
+	if (r != the_repository)	
+		return "UTF-8";
+	cfg= repo_config_values(r);
+	return cfg->commit_encoding ? cfg->commit_encoding : "UTF-8";
 }
 
 int use_optional_locks(void)
@@ -567,17 +572,17 @@ static int git_default_sparse_config(const char *var, const char *value)
 
 static int git_default_i18n_config(const char *var, const char *value)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	if (!strcmp(var, "i18n.commitencoding")) {
-		FREE_AND_NULL(git_commit_encoding);
-		return git_config_string(&git_commit_encoding, var, value);
+		FREE_AND_NULL(cfg->commit_encoding);
+		return git_config_string(&cfg->commit_encoding, var, value);
 	}
-
 	if (!strcmp(var, "i18n.logoutputencoding")) {
-		FREE_AND_NULL(git_log_output_encoding);
-		return git_config_string(&git_log_output_encoding, var, value);
+		FREE_AND_NULL(cfg->log_output_encoding);
+		return git_config_string(&cfg->log_output_encoding, var, value);
 	}
 
-	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
 
@@ -738,6 +743,8 @@ int git_default_config(const char *var, const char *value,
 void repo_config_values_init(struct repo_config_values *cfg)
 {
 	cfg->attributes_file = NULL;
+	cfg->commit_encoding = NULL;
+	cfg->log_output_encoding = NULL;
 	cfg->apply_sparse_checkout = 0;
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 8c221b567b..358c7d05e0 100644
--- a/environment.h
+++ b/environment.h
@@ -93,6 +93,9 @@ struct repo_config_values {
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
+
+	char *commit_encoding;
+	char *log_output_encoding;
 };
 
 struct repo_config_values *repo_config_values(struct repository *repo);
@@ -206,11 +209,8 @@ extern enum object_creation_mode object_creation_mode;
 
 extern int grafts_keep_true_parents;
 
-const char *get_log_output_encoding(void);
-const char *get_commit_output_encoding(void);
-
-extern char *git_commit_encoding;
-extern char *git_log_output_encoding;
+const char *get_log_output_encoding(struct repository *r);
+const char *get_commit_output_encoding(struct repository *r);
 
 extern char *editor_program;
 extern char *askpass_program;
diff --git a/log-tree.c b/log-tree.c
index fd2fb0bed6..364fd015f5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -859,7 +859,7 @@ void show_log(struct rev_info *opt)
 
 		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 		format_display_notes(&commit->object.oid, &notebuf,
-				     get_log_output_encoding(), raw);
+				     get_log_output_encoding(opt->repo), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
@@ -879,7 +879,7 @@ void show_log(struct rev_info *opt)
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
 	ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
-	ctx.output_encoding = get_log_output_encoding();
+	ctx.output_encoding = get_log_output_encoding(opt->repo);
 	ctx.rev = opt;
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
diff --git a/pretty.c b/pretty.c
index 51e3480431..6b585e2763 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2298,7 +2298,7 @@ void pretty_print_commit(struct repository *r, struct pretty_print_context *pp,
 		return;
 	}
 
-	encoding = get_log_output_encoding();
+	encoding = get_log_output_encoding(r);
 	msg = reencoded = repo_logmsg_reencode(the_repository, commit, NULL,
 					       encoding);
 
diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..146cb8930d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -379,7 +379,7 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 	if (strcmp(type->buf, "text/plain"))
 		return -1;
 	if (charset->len)
-		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
+		strbuf_reencode(msg, charset->buf, get_log_output_encoding(the_repository));
 
 	strbuf_trim(msg);
 	if (!msg->len)
diff --git a/replay.c b/replay.c
index 8704547aa1..0012d3aa18 100644
--- a/replay.c
+++ b/replay.c
@@ -56,7 +56,7 @@ static struct commit *create_commit(struct repository *repo,
 	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
-	const char *out_enc = get_commit_output_encoding();
+	const char *out_enc = get_commit_output_encoding(repo);
 	const char *message = repo_logmsg_reencode(repo, based_on,
 						   NULL, out_enc);
 	const char *orig_message = NULL;
diff --git a/repository.c b/repository.c
index 0207bcb299..3202d67bf0 100644
--- a/repository.c
+++ b/repository.c
@@ -384,6 +384,8 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
+	FREE_AND_NULL(repo->config_values_private_.commit_encoding);
+	FREE_AND_NULL(repo->config_values_private_.log_output_encoding);
 
 	odb_free(repo->objects);
 	repo->objects = NULL;
diff --git a/revision.c b/revision.c
index 29972c3a19..5fb85c0f13 100644
--- a/revision.c
+++ b/revision.c
@@ -2675,11 +2675,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
-		free(git_log_output_encoding);
+		struct repo_config_values *cfg = repo_config_values(revs->repo);
+
+		free(cfg->log_output_encoding);
 		if (strcmp(optarg, "none"))
-			git_log_output_encoding = xstrdup(optarg);
+			cfg->log_output_encoding = xstrdup(optarg);
 		else
-			git_log_output_encoding = xstrdup("");
+			cfg->log_output_encoding = xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^= 1;
@@ -3129,7 +3131,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	diff_setup_done(&revs->diffopt);
 
-	if (!is_encoding_utf8(get_log_output_encoding()))
+	if (!is_encoding_utf8(get_log_output_encoding(revs->repo)))
 		revs->grep_filter.ignore_locale = 1;
 	compile_grep_patterns(&revs->grep_filter);
 
@@ -4063,7 +4065,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	 * so we will not end up with a buffer that has two different encodings
 	 * in it.
 	 */
-	encoding = get_log_output_encoding();
+	encoding = get_log_output_encoding(opt->repo);
 	message = repo_logmsg_reencode(the_repository, commit, NULL, encoding);
 
 	/* Copy the commit to temporary if we are using "fake" headers */
diff --git a/sequencer.c b/sequencer.c
index e6b3e05fce..62717910d2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -480,13 +480,13 @@ static const char *short_commit_name(struct repository *r, struct commit *commit
 	return repo_find_unique_abbrev(r, &commit->object.oid, DEFAULT_ABBREV);
 }
 
-static int get_message(struct commit *commit, struct commit_message *out)
+static int get_message(struct repository *r, struct commit *commit, struct commit_message *out)
 {
 	const char *abbrev, *subject;
 	int subject_len;
 
 	out->message = repo_logmsg_reencode(the_repository, commit, NULL,
-					    get_commit_output_encoding());
+					    get_commit_output_encoding(r));
 	abbrev = short_commit_name(the_repository, commit);
 
 	subject_len = find_commit_subject(out->message, &subject);
@@ -1539,7 +1539,7 @@ static int try_to_commit(struct repository *r,
 
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
-		const char *out_enc = get_commit_output_encoding();
+		const char *out_enc = get_commit_output_encoding(r);
 		const char *message = repo_logmsg_reencode(r, current_head,
 							   NULL, out_enc);
 
@@ -2054,7 +2054,7 @@ static int update_squash_messages(struct repository *r,
 	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
 	const char *message, *body;
-	const char *encoding = get_commit_output_encoding();
+	const char *encoding = get_commit_output_encoding(r);
 
 	if (!is_fixup(command))
 		BUG("not a FIXUP or SQUASH %d", command);
@@ -2324,7 +2324,7 @@ static int do_pick_commit(struct repository *r,
 	else
 		parent = commit->parents->item;
 
-	if (get_message(commit, &msg) != 0)
+	if (get_message(r, commit, &msg) != 0)
 		return error(_("cannot get commit message for %s"),
 			oid_to_hex(&commit->object.oid));
 
@@ -3344,7 +3344,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	if (prepare_revs(opts))
 		return -1;
 
-	encoding = get_log_output_encoding();
+	encoding = get_log_output_encoding(the_repository);
 
 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
@@ -3730,7 +3730,7 @@ static int make_patch(struct repository *r,
 	}
 
 	if (!file_exists(rebase_path_message())) {
-		const char *encoding = get_commit_output_encoding();
+		const char *encoding = get_commit_output_encoding(r);
 		const char *commit_buffer = repo_logmsg_reencode(r,
 								 commit, NULL,
 								 encoding);
@@ -4187,7 +4187,7 @@ static int do_merge(struct repository *r,
 	}
 
 	if (commit) {
-		const char *encoding = get_commit_output_encoding();
+		const char *encoding = get_commit_output_encoding(r);
 		const char *message = repo_logmsg_reencode(r, commit, NULL,
 							   encoding);
 		const char *body;
@@ -4831,7 +4831,7 @@ static int stopped_at_head(struct repository *r)
 
 	if (repo_get_oid(r, "HEAD", &head) ||
 	    !(commit = lookup_commit(r, &head)) ||
-	    repo_parse_commit(r, commit) || get_message(commit, &message))
+	    repo_parse_commit(r, commit) || get_message(r, commit, &message))
 		fprintf(stderr, _("Stopped at HEAD\n"));
 	else {
 		fprintf(stderr, _("Stopped at %s\n"), message.label);
@@ -5311,7 +5311,7 @@ static int commit_staged_changes(struct repository *r,
 				struct commit *commit;
 				const char *msg;
 				const char *path = rebase_path_squash_msg();
-				const char *encoding = get_commit_output_encoding();
+				const char *encoding = get_commit_output_encoding(r);
 
 				if (parse_head(r, &commit)) {
 					ret = error(_("could not parse HEAD"));
@@ -6092,7 +6092,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out,
 	get_commit_format(format, &revs);
 	free(format);
 	pp.fmt = revs.commit_format;
-	pp.output_encoding = get_log_output_encoding();
+	pp.output_encoding = get_log_output_encoding(r);
 
 	setup_revisions_from_strvec(argv, &revs, NULL);
 	if (argv->nr > 1) {
diff --git a/submodule.c b/submodule.c
index 508938e4da..a58ed3652c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -479,7 +479,7 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
 	while ((commit = get_revision(rev))) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
-		ctx.output_encoding = get_log_output_encoding();
+		ctx.output_encoding = get_log_output_encoding(r);
 		strbuf_setlen(&sb, 0);
 		repo_format_commit_message(r, commit, format, &sb,
 				      &ctx);
-- 
2.43.0

