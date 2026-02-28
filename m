Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0053E5565
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305560; cv=none; b=hxrKwus+Tp2oRl6ENKzVYAD6fFMkqjGffxhNIvOrSWzDCv0yZ2e1eFAT3K5lt/PEFK+SxYDX2Mo2GUAip6KfexP3N7e2efBjnKsjhI8gT3ZboEbCpyWut48qKw/3AFyruXBkdnA63mDPgvi3yvheBdHvupGj8GRUpCdHXS15BQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305560; c=relaxed/simple;
	bh=em6RLt8InnvILUVysP9szKoBXkAedJRIbnCFYZjt6f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrsUJcOY7mImjtK8Wj3shNTCmv5Lmk2Nxpopfwswj8tBqoqYOt1EREJHbxv93vp86gLe66ejOjwmW08DzA/wVvO3Y86Mn6gKKpRHVnH3aJUqwkGJNMq5UwRq7tRi0/tAo4FppLi1NqIhiDJMXkecuGQg/RApqU8Qjg+Z4ahLcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HST7A3Iz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HST7A3Iz"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8244105fa96so102569b3a.3
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 11:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772305557; x=1772910357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab+g7w9e5wd82kBilA4hNte+kKNJxMyMxKK9mw40vjc=;
        b=HST7A3IzyTYJN9oFVBV+oTVETLh0ojAG9HvRCth87GlMXTumRHE/I7G4yzeKxIl9Gv
         6NVG0fPm3h3bl0PoZiIKE/njuVF07+G12JzFIJ5i4gKZx4AqorCHCqD8S6ut36PoWnv+
         8JcBBq7ug+pkwM1mHINh44TiGX1KuP8vNW9p1Y5Q093inm63P8Gl4dTBfIHvFObQlfjD
         UpZrld3CAnBEtvc5JW0zXiYzcPdkpl91Ev4ZM42qvgW+nboeu9karzxy6tqjoxYXonGf
         bL6wQvCg055Qs2K2eezkGGX2Fe1XhuwcDzyQp3Ukz3sFw2tKYRV6Znh1eyK3jQEv4ehW
         NNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305557; x=1772910357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ab+g7w9e5wd82kBilA4hNte+kKNJxMyMxKK9mw40vjc=;
        b=jnxrcH+Ojh9fhVlc9IVF+cuhF+HuR+41jNSntEDAfCRaW3hcvJ6YW7hjS0pCjWurg0
         d5KUQsm00j/5hsag1L4jihGMH5/dIMDMnkG+DU6HMkKcRSqSj5xwqp5w5XiZf0g/YKYo
         4IZ8IgNTNhZXHqA+eEEhWeb+g9rL3+fd4RwKtcdfosy+D96enPDfNxEKCAyDQ0tki50X
         U5e5bIXi9+TCDYiUCQYMnyl81Vafc38sbtk9rqFTWOBsqUn3VjyREjiTwuowf5obzkPN
         7CmuHhNfEF5M4Eft3/XnPVfxvybQbFA3KhsbGFK4bX6pwpNevNhvd756JhnSPcTU4Drq
         4bHA==
X-Gm-Message-State: AOJu0Yzwo4ZL3l+/XQRP5sUOjHMPHPwyzRo0b5v00KH5cRmzhRB15k+D
	4pNEAX7NSAZr7hhPdKrzUG10ewlGFPn4xgmMXZxAgNyWA7ECJ2n2pqsdvdJx4p01
X-Gm-Gg: ATEYQzzAX/6xaD+wOxwOZB55W8lZo8HbiAlFFhtz1iVpfq1zx8EF/3QGeX0js2sKi8O
	0bo45KCueM1UgaRPvNtL23e0otg1gmfqb99B6JZmTx9vDtu/caIK5aHoYJ0y8mPh1minMJB38LR
	ehNsmgVn9kELfAfg2ty5DkfnstWxNZ4y8cqq/0fG2ZgxKh0gsvg5mqv+4+5FbO6X9S46JhNf5rY
	xxdcsPwR3S65pU/qL5m+0stuVNHtKSsdLaVAn3D1+ev44/evEk1O3mRXRmYyalVm/mFyGxWr7jF
	A+SIf/mUYVQvC1gqClgFW6kVyD73TtrR/jwrkjDofibPN2r2rd49LgjaGFNQrn6PrYfW+44vm1N
	RtklsbTR5By1arjEp+6gwAfH1isX+tzPIg6yrsUDKb8r5cIhp3JaRtxJo7qJKcbN9rsmtobZl+D
	URrQGUaNw5qhBMU7X2V4ILPP55pNdulZS5zls9LmzMi+k6+4lf3VDKDgiSnZ4+3eH60EDZDT1eH
	MtAG17QzmjrvF7Tj+1M5js=
X-Received: by 2002:a05:6a00:2e98:b0:81f:44bc:8714 with SMTP id d2e1a72fcca58-8274d966ec6mr5371806b3a.2.1772305557125;
        Sat, 28 Feb 2026 11:05:57 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3e4asm8556644b3a.28.2026.02.28.11.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:05:56 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 1/3] environment: migrate encoding settings to repo-settings
Date: Sun,  1 Mar 2026 03:01:59 +0800
Message-ID: <20260228190201.3684705-2-a3205153416@gmail.com>
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

Global variables 'git_commit_encoding' and 'git_log_output_encoding'
hinder the ongoing libification effort by binding functions to a
single global state.

Move both variables into 'struct repo_settings' to enable lazy loading.
They are migrated together in this patch because the log encoding
directly falls back to the commit encoding.

Update callers to use the new 'repo_get_commit_output_encoding()' and
'repo_get_log_output_encoding()' apis. Functions now accept 'struct
repository' to bubble up dependency where possible. For callers in the
'builtin/' directory, and for core library functions that do not yet
receive a repository context, 'the_repository' is used as a fallback.

Additionally, in 'revision.c', ensure 'prepare_repo_settings()' is
triggered before CLI overrides, for example, '--encoding', to prevent
lazy-loading from mistakenly overwriting command-line choice later.

All tests passed, no memory leak.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 builtin/am.c       |  4 ++--
 builtin/blame.c    |  2 +-
 builtin/commit.c   |  6 +++---
 builtin/log.c      |  2 +-
 builtin/mailinfo.c |  2 +-
 builtin/rev-list.c |  2 +-
 builtin/shortlog.c |  2 +-
 bundle.c           |  2 +-
 commit.c           |  6 +++---
 environment.c      | 37 +++++++++++--------------------------
 environment.h      |  7 ++-----
 log-tree.c         |  4 ++--
 pretty.c           |  2 +-
 remote-curl.c      |  3 ++-
 replay.c           |  2 +-
 repo-settings.c    |  7 +++++++
 repo-settings.h    |  3 +++
 revision.c         | 11 ++++++-----
 sequencer.c        | 16 ++++++++--------
 submodule.c        |  2 +-
 20 files changed, 58 insertions(+), 64 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e0c767e223..96b8c00007 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1216,7 +1216,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	setup_mailinfo(the_repository, &mi);
 
 	if (state->utf8)
-		mi.metainfo_charset = get_commit_output_encoding();
+		mi.metainfo_charset = repo_get_commit_output_encoding(the_repository);
 	else
 		mi.metainfo_charset = NULL;
 
@@ -1355,7 +1355,7 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	struct ident_split id;
 
 	buffer = repo_logmsg_reencode(the_repository, commit, NULL,
-				      get_commit_output_encoding());
+				      repo_get_commit_output_encoding(the_repository));
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 	if (!ident_line)
diff --git a/builtin/blame.c b/builtin/blame.c
index eac2fe7320..cc82182c51 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -202,7 +202,7 @@ static void get_commit_info(struct commit *commit, struct commit_info *ret)
 	const char *subject, *encoding;
 	const char *message;
 
-	encoding = get_log_output_encoding();
+	encoding = repo_get_log_output_encoding(the_repository);
 	message = repo_logmsg_reencode(the_repository, commit, NULL, encoding);
 	get_ac_line(message, "\nauthor ",
 		    &ret->author, &ret->author_mail,
diff --git a/builtin/commit.c b/builtin/commit.c
index 9e3a09d532..2bbdd4c4c3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -794,7 +794,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			c = lookup_commit_reference_by_name(squash_message);
 			if (!c)
 				die(_("could not lookup commit '%s'"), squash_message);
-			ctx.output_encoding = get_commit_output_encoding();
+			ctx.output_encoding = repo_get_commit_output_encoding(the_repository);
 			repo_format_commit_message(the_repository, c,
 						   "squash! %s\n\n", &sb,
 						   &ctx);
@@ -829,7 +829,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		commit = lookup_commit_reference_by_name(fixup_commit);
 		if (!commit)
 			die(_("could not lookup commit '%s'"), fixup_commit);
-		ctx.output_encoding = get_commit_output_encoding();
+		ctx.output_encoding = repo_get_commit_output_encoding(the_repository);
 		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
 		repo_format_commit_message(the_repository, commit, fmt, &sb,
 					   &ctx);
@@ -1235,7 +1235,7 @@ static const char *read_commit_message(const char *name)
 	commit = lookup_commit_reference_by_name(name);
 	if (!commit)
 		die(_("could not lookup commit '%s'"), name);
-	out_enc = get_commit_output_encoding();
+	out_enc = repo_get_commit_output_encoding(the_repository);
 	return repo_logmsg_reencode(the_repository, commit, NULL, out_enc);
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 8ab6d3a943..1c9ec09098 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -568,7 +568,7 @@ static void show_tagger(const char *buf, struct rev_info *rev)
 
 	pp.fmt = rev->commit_format;
 	pp.date_mode = rev->date_mode;
-	pp_user_info(&pp, "Tagger", &out, buf, get_log_output_encoding());
+	pp_user_info(&pp, "Tagger", &out, buf, repo_get_log_output_encoding(the_repository));
 	fprintf(rev->diffopt.file, "%s", out.buf);
 	strbuf_release(&out);
 }
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 8de7ba7de1..eab4e05850 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -93,7 +93,7 @@ int cmd_mailinfo(int argc,
 
 	switch (meta_charset.policy) {
 	case CHARSET_DEFAULT:
-		mi.metainfo_charset = get_commit_output_encoding();
+		mi.metainfo_charset = repo_get_commit_output_encoding(the_repository);
 		break;
 	case CHARSET_NO_REENCODE:
 		mi.metainfo_charset = NULL;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ddea8aa251..3c6a2914d8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -304,7 +304,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.date_mode = revs->date_mode;
 		ctx.date_mode_explicit = revs->date_mode_explicit;
 		ctx.fmt = revs->commit_format;
-		ctx.output_encoding = get_log_output_encoding();
+		ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 		ctx.color = revs->diffopt.use_color;
 		ctx.rev = revs;
 		pretty_print_commit(&ctx, commit, &buf);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d80bf1a7d0..ce9f20de2f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -248,7 +248,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
 	ctx.date_mode = log->date_mode;
-	ctx.output_encoding = get_log_output_encoding();
+	ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 
 	if (!log->summary) {
 		if (log->user_format)
diff --git a/bundle.c b/bundle.c
index 42327f9739..7914a57b43 100644
--- a/bundle.c
+++ b/bundle.c
@@ -461,7 +461,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 	write_or_die(bpi->fd, buf.buf, buf.len);
 
 	ctx.fmt = CMIT_FMT_ONELINE;
-	ctx.output_encoding = get_log_output_encoding();
+	ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 	strbuf_reset(&buf);
 	pretty_print_commit(&ctx, commit, &buf);
 	strbuf_trim(&buf);
diff --git a/commit.c b/commit.c
index d16ae73345..d558db52dc 100644
--- a/commit.c
+++ b/commit.c
@@ -1673,7 +1673,7 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 	size_t i;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+	encoding_is_utf8 = is_encoding_utf8(repo_get_commit_output_encoding(the_repository));
 
 	strbuf_grow(buffer, 8192); /* should avoid reallocs for the headers */
 	strbuf_addf(buffer, "tree %s\n", oid_to_hex(tree));
@@ -1694,7 +1694,7 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 		committer = git_committer_info(IDENT_STRICT);
 	strbuf_addf(buffer, "committer %s\n", committer);
 	if (!encoding_is_utf8)
-		strbuf_addf(buffer, "encoding %s\n", git_commit_encoding);
+		strbuf_addf(buffer, "encoding %s\n", repo_get_commit_output_encoding(the_repository));
 
 	while (extra) {
 		add_extra_header(buffer, extra);
@@ -1723,7 +1723,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	size_t i, nparents;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+	encoding_is_utf8 = is_encoding_utf8(repo_get_commit_output_encoding(the_repository));
 
 	odb_assert_oid_type(the_repository->objects, tree, OBJ_TREE);
 
diff --git a/environment.c b/environment.c
index 0026eb2274..9c2a26c3c1 100644
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
 char *git_attributes_file;
@@ -197,15 +195,21 @@ const char *strip_namespace(const char *namespaced_ref)
 	return NULL;
 }
 
-const char *get_log_output_encoding(void)
+const char *repo_get_log_output_encoding(struct repository *r)
 {
-	return git_log_output_encoding ? git_log_output_encoding
-		: get_commit_output_encoding();
+	prepare_repo_settings(r);
+
+	return r->settings.log_output_encoding ?
+		r->settings.log_output_encoding :
+		repo_get_commit_output_encoding(r);
 }
 
-const char *get_commit_output_encoding(void)
+const char *repo_get_commit_output_encoding(struct repository *r)
 {
-	return git_commit_encoding ? git_commit_encoding : "UTF-8";
+	prepare_repo_settings(r);
+
+	return r->settings.commit_encoding ?
+		r->settings.commit_encoding : "UTF-8";
 }
 
 int use_optional_locks(void)
@@ -566,22 +570,6 @@ static int git_default_sparse_config(const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_i18n_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "i18n.commitencoding")) {
-		FREE_AND_NULL(git_commit_encoding);
-		return git_config_string(&git_commit_encoding, var, value);
-	}
-
-	if (!strcmp(var, "i18n.logoutputencoding")) {
-		FREE_AND_NULL(git_log_output_encoding);
-		return git_config_string(&git_log_output_encoding, var, value);
-	}
-
-	/* Add other config variables here and to Documentation/config.adoc. */
-	return 0;
-}
-
 static int git_default_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "branch.autosetupmerge")) {
@@ -688,9 +676,6 @@ int git_default_config(const char *var, const char *value,
 	    starts_with(var, "committer."))
 		return git_ident_config(var, value, ctx, cb);
 
-	if (starts_with(var, "i18n."))
-		return git_default_i18n_config(var, value);
-
 	if (starts_with(var, "branch."))
 		return git_default_branch_config(var, value);
 
diff --git a/environment.h b/environment.h
index 27f657af04..eba8d5786c 100644
--- a/environment.h
+++ b/environment.h
@@ -193,11 +193,8 @@ extern enum object_creation_mode object_creation_mode;
 
 extern int grafts_keep_true_parents;
 
-const char *get_log_output_encoding(void);
-const char *get_commit_output_encoding(void);
-
-extern char *git_commit_encoding;
-extern char *git_log_output_encoding;
+const char *repo_get_log_output_encoding(struct repository *r);
+const char *repo_get_commit_output_encoding(struct repository *r);
 
 extern char *editor_program;
 extern char *askpass_program;
diff --git a/log-tree.c b/log-tree.c
index 7e048701d0..aea3cbf7c6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -859,7 +859,7 @@ void show_log(struct rev_info *opt)
 
 		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 		format_display_notes(&commit->object.oid, &notebuf,
-				     get_log_output_encoding(), raw);
+				     repo_get_log_output_encoding(the_repository), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
@@ -879,7 +879,7 @@ void show_log(struct rev_info *opt)
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
 	ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
-	ctx.output_encoding = get_log_output_encoding();
+	ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 	ctx.rev = opt;
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
diff --git a/pretty.c b/pretty.c
index e0646bbc5d..e939d0ff3b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2298,7 +2298,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 		return;
 	}
 
-	encoding = get_log_output_encoding();
+	encoding = repo_get_log_output_encoding(the_repository);
 	msg = reencoded = repo_logmsg_reencode(the_repository, commit, NULL,
 					       encoding);
 
diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..cd7e5e701a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -379,7 +379,8 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 	if (strcmp(type->buf, "text/plain"))
 		return -1;
 	if (charset->len)
-		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
+		strbuf_reencode(msg, charset->buf,
+				repo_get_log_output_encoding(the_repository));
 
 	strbuf_trim(msg);
 	if (!msg->len)
diff --git a/replay.c b/replay.c
index f97d652f33..45d539f8fc 100644
--- a/replay.c
+++ b/replay.c
@@ -56,7 +56,7 @@ static struct commit *create_commit(struct repository *repo,
 	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
-	const char *out_enc = get_commit_output_encoding();
+	const char *out_enc = repo_get_commit_output_encoding(repo);
 	const char *message = repo_logmsg_reencode(repo, based_on,
 						   NULL, out_enc);
 	const char *orig_message = NULL;
diff --git a/repo-settings.c b/repo-settings.c
index 208e09ff17..de3b4c6ef1 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -32,6 +32,7 @@ void prepare_repo_settings(struct repository *r)
 	int experimental;
 	int value;
 	const char *strval;
+	char *alloc_strval;
 	int manyfiles;
 	int read_changed_paths;
 	unsigned long ulongval;
@@ -154,6 +155,12 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_ulong(r, "core.packedgitlimit", &ulongval))
 		r->settings.packed_git_limit = ulongval;
+
+	if (!repo_config_get_string(r, "i18n.commitencoding", &alloc_strval))
+		r->settings.commit_encoding = alloc_strval;
+
+	if (!repo_config_get_string(r, "i18n.logoutputencoding", &alloc_strval))
+		r->settings.log_output_encoding = alloc_strval;
 }
 
 void repo_settings_clear(struct repository *r)
diff --git a/repo-settings.h b/repo-settings.h
index cad9c3f0cc..9a6b91a3a9 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -70,6 +70,9 @@ struct repo_settings {
 	int max_allowed_tree_depth;
 
 	char *hooks_path;
+
+	char *commit_encoding;
+	char *log_output_encoding;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
diff --git a/revision.c b/revision.c
index 29972c3a19..961ecd1d6c 100644
--- a/revision.c
+++ b/revision.c
@@ -2675,11 +2675,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
-		free(git_log_output_encoding);
+		prepare_repo_settings(revs->repo);
+		free(revs->repo->settings.log_output_encoding);
 		if (strcmp(optarg, "none"))
-			git_log_output_encoding = xstrdup(optarg);
+			revs->repo->settings.log_output_encoding = xstrdup(optarg);
 		else
-			git_log_output_encoding = xstrdup("");
+			revs->repo->settings.log_output_encoding = xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^= 1;
@@ -3129,7 +3130,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	diff_setup_done(&revs->diffopt);
 
-	if (!is_encoding_utf8(get_log_output_encoding()))
+	if (!is_encoding_utf8(repo_get_log_output_encoding(the_repository)))
 		revs->grep_filter.ignore_locale = 1;
 	compile_grep_patterns(&revs->grep_filter);
 
@@ -4063,7 +4064,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	 * so we will not end up with a buffer that has two different encodings
 	 * in it.
 	 */
-	encoding = get_log_output_encoding();
+	encoding = repo_get_log_output_encoding(the_repository);
 	message = repo_logmsg_reencode(the_repository, commit, NULL, encoding);
 
 	/* Copy the commit to temporary if we are using "fake" headers */
diff --git a/sequencer.c b/sequencer.c
index a3eb39bb25..612f47fd12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -486,7 +486,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
 	int subject_len;
 
 	out->message = repo_logmsg_reencode(the_repository, commit, NULL,
-					    get_commit_output_encoding());
+					    repo_get_commit_output_encoding(the_repository));
 	abbrev = short_commit_name(the_repository, commit);
 
 	subject_len = find_commit_subject(out->message, &subject);
@@ -1539,7 +1539,7 @@ static int try_to_commit(struct repository *r,
 
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
-		const char *out_enc = get_commit_output_encoding();
+		const char *out_enc = repo_get_commit_output_encoding(r);
 		const char *message = repo_logmsg_reencode(r, current_head,
 							   NULL, out_enc);
 
@@ -2054,7 +2054,7 @@ static int update_squash_messages(struct repository *r,
 	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
 	const char *message, *body;
-	const char *encoding = get_commit_output_encoding();
+	const char *encoding = repo_get_commit_output_encoding(r);
 
 	if (!is_fixup(command))
 		BUG("not a FIXUP or SQUASH %d", command);
@@ -3344,7 +3344,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	if (prepare_revs(opts))
 		return -1;
 
-	encoding = get_log_output_encoding();
+	encoding = repo_get_log_output_encoding(the_repository);
 
 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
@@ -3730,7 +3730,7 @@ static int make_patch(struct repository *r,
 	}
 
 	if (!file_exists(rebase_path_message())) {
-		const char *encoding = get_commit_output_encoding();
+		const char *encoding = repo_get_commit_output_encoding(r);
 		const char *commit_buffer = repo_logmsg_reencode(r,
 								 commit, NULL,
 								 encoding);
@@ -4187,7 +4187,7 @@ static int do_merge(struct repository *r,
 	}
 
 	if (commit) {
-		const char *encoding = get_commit_output_encoding();
+		const char *encoding = repo_get_commit_output_encoding(r);
 		const char *message = repo_logmsg_reencode(r, commit, NULL,
 							   encoding);
 		const char *body;
@@ -5311,7 +5311,7 @@ static int commit_staged_changes(struct repository *r,
 				struct commit *commit;
 				const char *msg;
 				const char *path = rebase_path_squash_msg();
-				const char *encoding = get_commit_output_encoding();
+				const char *encoding = repo_get_commit_output_encoding(r);
 
 				if (parse_head(r, &commit)) {
 					ret = error(_("could not parse HEAD"));
@@ -6092,7 +6092,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out,
 	get_commit_format(format, &revs);
 	free(format);
 	pp.fmt = revs.commit_format;
-	pp.output_encoding = get_log_output_encoding();
+	pp.output_encoding = repo_get_log_output_encoding(r);
 
 	setup_revisions_from_strvec(argv, &revs, NULL);
 	if (argv->nr > 1) {
diff --git a/submodule.c b/submodule.c
index 508938e4da..59f5c79d7f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -479,7 +479,7 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
 	while ((commit = get_revision(rev))) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
-		ctx.output_encoding = get_log_output_encoding();
+		ctx.output_encoding = repo_get_log_output_encoding(r);
 		strbuf_setlen(&sb, 0);
 		repo_format_commit_message(r, commit, format, &sb,
 				      &ctx);
-- 
2.43.0

