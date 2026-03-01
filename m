Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC342FE042
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772397374; cv=none; b=eIi1MkIRFQP8we7+vGqx82+2aGPnClNsE7+lqwVl/NBzNB4BjPkgy2GYKRBQQzIeV7r4RHqlwbtF1j4lLWJ2sL+1vBKNs3X1hb+M+U437/KJuG5ToLFuWsMnaxW0xuyMZ5l9QDdv8+rf0yFPksKFCCMFamqW7ZYoLyhpSnxqbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772397374; c=relaxed/simple;
	bh=mbBF8BbC/ZPanBHYD0JJcvEyAgfAdBPB7B/xOJPamoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSK/3Qvzw0o6pLKM/BWRWebnv7QWQI/v/dDSHc27fv/0IH/w0NynBh/ot1d381oFPkNVPEkZ6lr65ylO/sbHsPttlzQTmJHPrMB0UUtfZoNRVekhdXU/bu4PzVpfJ9R0w1448Un3v5BT9rr2oTs0ZNrI/uPF7ytUqmYKJjXHtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUt++aCD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUt++aCD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a3e79fe2b8so5430915ad.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 12:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772397371; x=1773002171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/+0BAc/pMU2sq9r0g5dUAW7LwjFSWBntFKtsph/A78=;
        b=cUt++aCDftQReR+wFMPAlvojZaJIlCdA9uVqZMQTp60AHg0Jh2fXyYrdgNSYIoWRQc
         8Yz+etudr4vsqVQx4+Nik/oTtZlq6tHrsgOjecxtN7SEQ7KaoM4pfYDNJC/bGqkClWrj
         MTxZXuUAzzimWFbivXAzKsjBQvfA2Y9m70t+aC7PT5j3NVrjd8IszARO6e0F598gev3i
         hIKECwxBm2XBmMRtAOKcsisSHbibb1MD/kMkQXqpaARZDYavy7x7sH4kad/HLm68ETwv
         MdN4YbXxXYf77AWFK43GRSnM8xkdeSqhDqRD9oxlvOxXk8FyP6XsLmwP8n9E7YkOIW39
         oc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772397371; x=1773002171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/+0BAc/pMU2sq9r0g5dUAW7LwjFSWBntFKtsph/A78=;
        b=cOkFmeXaZLLhGf5pSkKuVloPpAwQ8MsODjFgNOOzaDblitUFXWwNa5EZsxxO/O2HTB
         amQOX1LZIxRAk7XVa9XvksW3D08silABvQhikcbVN4KKPZaJCtlr1T/tdWmxiHVTlN23
         woMb1aoxYfgLmTLkt7nBHO/Hyjnen/278zkVa6rcqHgIzJKAUC3U6ztaHHDlCfLlzxEg
         Ois8pN6fFVO2Iw6NHu+NlC/RG7tAHA5qviH0m1gr2MKrywmCVnwHTdlEqyIpUYax7NpG
         uL0bjpjcHnDovkpZGCDcf7PMclOMc/+KpMLeZIXlGpWqcf4Et4cX96LVc4VtulqJ6cFj
         pkSA==
X-Gm-Message-State: AOJu0YzW2eliAr3u+J9ldETMhrfG2RxfCgLe00iruor2CueN4DahgIUA
	GW1jiLAAKtgT653FTmVPsD/1AFsXmKccftBPtxlJf7y6hdtroYPq5HHijalWeQFK
X-Gm-Gg: ATEYQzyJf19cfMr9iS99AGul4rIVrjp4m1BDpFSJLE/qR+IRA6v5bCWOa9ETcfOD1vj
	xOMY9/VNY5BchTfVRivPb/93GfnRT2uFTVX6duT2a67g68VuZ5aTFVt0dMgO7cVVzwlHQwuksHd
	x+6hRBvr7HlQSunP1C/klSKdE4Fg/6IZyc1nWTWKw5AbuyMV7lN9sO7YeLPwmav9xBmNSULohZu
	TCku/Bwl7eEuGBZ722gdSp2DrGy1jPMaUUPSZlerg/IOXtPapY5lMuU3xpdlcayVgPIRoLdcJRh
	/ITdvcmt5ahhE5WoCs952VvglrwtUncyYPz8SvvYMJevA8xKQTWwLf++3owrGBg6SyubCTEbUM2
	WfrRFwEXIP+davaAZAtCHwv66PRPPbTnVY7P24/ArlWYCtq872nse9Fjh802UuuQMoq3xAV/s81
	raGJUDw0fYk2loiDoqEjGeNzhV2Bo7qiuP3bmduKw/Gx8YKaTfFyo71QTYx5Q/Cv9fTWSbnweMO
	xSN81909G1tJxJnjWoC//U=
X-Received: by 2002:a05:6a20:431f:b0:38e:53ed:bc05 with SMTP id adf61e73a8af0-395c3b582ddmr7253727637.7.1772397371440;
        Sun, 01 Mar 2026 12:36:11 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4abcsm9496976a12.5.2026.03.01.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 12:36:11 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [PATCH v3 3/3] environment: migrate encoding configs to struct repository
Date: Mon,  2 Mar 2026 04:35:39 +0800
Message-ID: <20260301203539.1421152-4-a3205153416@gmail.com>
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

The global variables 'git_commit_encoding' and 'git_log_output_encoding'
prevent libification.

Migrate these variables into 'struct repository'. Note that these variables
are not migrated to 'repo_settings'. As user preferences, they must be parsed
eagerly to maintain immediate UX feedback.

While the core read and write APIs (updated in previous patches) now
utilize the 'struct repository' pointer, the config parsing step
('git_default_i18n_config') currently parses these values into
'the_repository', since safely plumbing a repository pointer through
the 'git_default_config' callback machinery is highly invasive due to
the diverse and custom structures currently passed via the 'void *cb'
parameter.

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
 environment.c      | 19 ++++++++-----------
 environment.h      |  7 ++-----
 log-tree.c         |  4 ++--
 pretty.c           |  2 +-
 remote-curl.c      |  2 +-
 replay.c           |  2 +-
 repository.c       |  2 ++
 repository.h       |  5 +++++
 revision.c         | 10 +++++-----
 sequencer.c        | 22 +++++++++++-----------
 submodule.c        |  2 +-
 20 files changed, 59 insertions(+), 57 deletions(-)

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
index 0026eb2274..a27c13da3d 100644
--- a/environment.c
+++ b/environment.c
@@ -197,15 +197,14 @@ const char *strip_namespace(const char *namespaced_ref)
 	return NULL;
 }
 
-const char *get_log_output_encoding(void)
+const char *get_log_output_encoding(struct repository *r)
 {
-	return git_log_output_encoding ? git_log_output_encoding
-		: get_commit_output_encoding();
+	return r->log_output_encoding ? r->log_output_encoding : get_commit_output_encoding(r);
 }
 
-const char *get_commit_output_encoding(void)
+const char *get_commit_output_encoding(struct repository *r)
 {
-	return git_commit_encoding ? git_commit_encoding : "UTF-8";
+	return r->commit_encoding ? r->commit_encoding : "UTF-8";
 }
 
 int use_optional_locks(void)
@@ -569,16 +568,14 @@ static int git_default_sparse_config(const char *var, const char *value)
 static int git_default_i18n_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "i18n.commitencoding")) {
-		FREE_AND_NULL(git_commit_encoding);
-		return git_config_string(&git_commit_encoding, var, value);
+		FREE_AND_NULL(the_repository->commit_encoding);
+		return git_config_string(&the_repository->commit_encoding, var, value);
 	}
-
 	if (!strcmp(var, "i18n.logoutputencoding")) {
-		FREE_AND_NULL(git_log_output_encoding);
-		return git_config_string(&git_log_output_encoding, var, value);
+		FREE_AND_NULL(the_repository->log_output_encoding);
+		return git_config_string(&the_repository->log_output_encoding, var, value);
 	}
 
-	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
 
diff --git a/environment.h b/environment.h
index 27f657af04..d1c62a8296 100644
--- a/environment.h
+++ b/environment.h
@@ -193,11 +193,8 @@ extern enum object_creation_mode object_creation_mode;
 
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
index 46a7c99930..a2ab093a68 100644
--- a/repository.c
+++ b/repository.c
@@ -370,6 +370,8 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
+	FREE_AND_NULL(repo->commit_encoding);
+	FREE_AND_NULL(repo->log_output_encoding);
 
 	odb_free(repo->objects);
 	repo->objects = NULL;
diff --git a/repository.h b/repository.h
index 7141237f97..4e67b15c36 100644
--- a/repository.h
+++ b/repository.h
@@ -172,6 +172,11 @@ struct repository {
 
 	/* Should repo_config() check for deprecated settings */
 	bool check_deprecated_config;
+
+	/* User's preferred encoding for commit messages and log output. */
+
+	char *commit_encoding;
+	char *log_output_encoding;
 };
 
 #ifdef USE_THE_REPOSITORY_VARIABLE
diff --git a/revision.c b/revision.c
index 29972c3a19..b85cac9877 100644
--- a/revision.c
+++ b/revision.c
@@ -2675,11 +2675,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
-		free(git_log_output_encoding);
+		free(revs->repo->log_output_encoding);
 		if (strcmp(optarg, "none"))
-			git_log_output_encoding = xstrdup(optarg);
+			revs->repo->log_output_encoding = xstrdup(optarg);
 		else
-			git_log_output_encoding = xstrdup("");
+			revs->repo->log_output_encoding = xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^= 1;
@@ -3129,7 +3129,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	diff_setup_done(&revs->diffopt);
 
-	if (!is_encoding_utf8(get_log_output_encoding()))
+	if (!is_encoding_utf8(get_log_output_encoding(revs->repo)))
 		revs->grep_filter.ignore_locale = 1;
 	compile_grep_patterns(&revs->grep_filter);
 
@@ -4063,7 +4063,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
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

