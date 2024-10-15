Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBD1AF0D5
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003799; cv=none; b=aYeRUlGxC6n9Cx5RceceFKQp5wyZGwYkwPpW3Fssgu9C09/7jt/7fTT14hw4tpI6/G1ztsx8ibhV5pJFatFNG/DZx1YlsGGoKSiO/7eUPlWmi3n53W1e0ruyFD8XZ7x7EsdWKbnZqkNNe2DslwaaRdV49HxyM3e4ohVz3V1YTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003799; c=relaxed/simple;
	bh=C8nlms8sc3nv4Dw+ExN+47pA+nNGi9pYvZSrOYioIME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWoQI+0s/wRBCQAHO+R8KDNrcyUF0zhuZjFPeW9bOsadXRi75XVO1CcbWlJVs0CZa1nK4m1HgDbhIUhVtRBYD45pZopra3Go/lnpEtprJ/CQXbE6p5CDteVN56sjJ48iwHf4HfsBv4MDNQ/tSzM8/miCpnCficWy4fK3gcDWw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKeo7+vW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKeo7+vW"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1487096a12.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729003796; x=1729608596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KAbmx006gDycFYOwmsVdx/mD8JOeZBZ66bqh4nzOPg=;
        b=HKeo7+vW9UeSaMJydp1nK144HCG7PNIGiIFFoh+K1l67Yc2XmjkqgnSegc8TGueFRF
         xY/j2/Wj2O5rVFzqoRbkiTfF89uNFfKr31vZ7+RPpEORuLI4CDZVeePoqHcYD8u2ZfKK
         rk/wXbQXXhF13iPxy9gWr2FOrbEoQ/Mn5W04Zy9RXgMYw4Zdcaf73mZRB/F1ywyjkN5Y
         /q3UlbJX22Hfrt48gGIvaE3DGkdiPPGsQeiL757W0+b08Epe3yYIoxmUVcL0xJt1vQim
         X49uxGnHu58DbtNGKNLlyQi1V3/DjqaVBmSKrH91tEC/jGayRX5E1RetzbcCNClHP3oI
         oBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003796; x=1729608596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KAbmx006gDycFYOwmsVdx/mD8JOeZBZ66bqh4nzOPg=;
        b=Zv56lcYBb1OV/gouuMkumw0Zuo555s7skNuMYljZ1qnb9mwn09r7XDqS2v9fzB2Xvj
         6UI30zgUU9HUF1B9ipIZTYJl4wjH3HB6kzKbNblTcQKQHga9WC+GUFL8PSzAf6tx0UsP
         UbSvRIuQ5eiFUvdL7UhBt29c/1Q82AKQh8ueAO96U3jzsgektAMnR5vI4aqnozYZLK0p
         bMQzG3j79DNlpZeaewVLOK5oiWfLhqrouQjfCUDrI3fPlop+6zTP2Z0Oy7VqKnJToFj0
         G51lsW4DlZ/B3EPL9tOVDzstuLRhPcLjznotm3i1OaCoYSpMG5jZnB3LVKemwXRdVkNU
         XQwg==
X-Gm-Message-State: AOJu0YzVczRhPog+tpnwSgRLxLZEdv4HDVqEMTOEjFLx2X4IGmrTgBaz
	rwZPSgV8RgKzf5vV2C+hyf/zIhtFoQSjayZ4VKvM0D3ENQJ9kXK78h9N5g==
X-Google-Smtp-Source: AGHT+IG2FYA3ecK1RgXL59rONfxsQGqApg5+p0bzQoqLzqup4UFQuI99fI1LfoY4kaSMgasf5dNWIA==
X-Received: by 2002:a05:6a21:393:b0:1d4:fb0c:613 with SMTP id adf61e73a8af0-1d8bceef275mr22156536637.1.1729003795860;
        Tue, 15 Oct 2024 07:49:55 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:51ac:756c:f3be:7ccc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e7753420asm1328000b3a.205.2024.10.15.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:49:55 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH 1/3] repository: move git_*_encoding configs to repo scope
Date: Tue, 15 Oct 2024 20:01:22 +0530
Message-ID: <20241015144935.4059-2-five231003@gmail.com>
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

Move "git_commit_encoding" and "git_log_output_encoding" to "struct
repository" and amend the functions associated with peeking at these
values so that now they take a "struct repository *" argument
accordingly.  While at it, rename the functions to repo_*() following
our usual convention.

Doing so removes the implicit dependency of these variables on
"the_repository", which is better because we now populate these
variables per repository.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 builtin/am.c       |  6 ++++--
 builtin/blame.c    |  2 +-
 builtin/commit.c   |  8 +++++---
 builtin/log.c      |  3 ++-
 builtin/mailinfo.c |  3 ++-
 builtin/replay.c   |  3 ++-
 builtin/rev-list.c |  2 +-
 builtin/shortlog.c |  2 +-
 bundle.c           |  2 +-
 commit.c           |  9 ++++++---
 config.c           | 10 ++++++----
 environment.c      | 13 -------------
 environment.h      |  6 ------
 log-tree.c         |  4 ++--
 pretty.c           |  2 +-
 remote-curl.c      |  4 +++-
 repository.c       | 13 +++++++++++++
 repository.h       |  6 ++++++
 revision.c         | 10 +++++-----
 sequencer.c        | 17 +++++++++--------
 submodule.c        |  2 +-
 21 files changed, 71 insertions(+), 56 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index bfa95147cf..1b6c9e3889 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -11,6 +11,7 @@
 #include "config.h"
 #include "editor.h"
 #include "environment.h"
+#include "repository.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
@@ -1213,7 +1214,8 @@ static int parse_mail(struct am_state *state, const char *mail)
 	setup_mailinfo(&mi);
 
 	if (state->utf8)
-		mi.metainfo_charset = get_commit_output_encoding();
+		mi.metainfo_charset =
+			repo_get_commit_output_encoding(the_repository);
 	else
 		mi.metainfo_charset = NULL;
 
@@ -1352,7 +1354,7 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	struct ident_split id;
 
 	buffer = repo_logmsg_reencode(the_repository, commit, NULL,
-				      get_commit_output_encoding());
+				      repo_get_commit_output_encoding(the_repository));
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 	if (!ident_line)
diff --git a/builtin/blame.c b/builtin/blame.c
index e407a22da3..ffbcedb2bf 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -203,7 +203,7 @@ static void get_commit_info(struct commit *commit,
 	const char *subject, *encoding;
 	const char *message;
 
-	encoding = get_log_output_encoding();
+	encoding = repo_get_log_output_encoding(the_repository);
 	message = repo_logmsg_reencode(the_repository, commit, NULL, encoding);
 	get_ac_line(message, "\nauthor ",
 		    &ret->author, &ret->author_mail,
diff --git a/builtin/commit.c b/builtin/commit.c
index 8db4e9df0c..4eac20ce86 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -763,7 +763,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			c = lookup_commit_reference_by_name(squash_message);
 			if (!c)
 				die(_("could not lookup commit '%s'"), squash_message);
-			ctx.output_encoding = get_commit_output_encoding();
+			ctx.output_encoding =
+				repo_get_commit_output_encoding(the_repository);
 			repo_format_commit_message(the_repository, c,
 						   "squash! %s\n\n", &sb,
 						   &ctx);
@@ -798,7 +799,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		commit = lookup_commit_reference_by_name(fixup_commit);
 		if (!commit)
 			die(_("could not lookup commit '%s'"), fixup_commit);
-		ctx.output_encoding = get_commit_output_encoding();
+		ctx.output_encoding =
+			repo_get_commit_output_encoding(the_repository);
 		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
 		repo_format_commit_message(the_repository, commit, fmt, &sb,
 					   &ctx);
@@ -1202,7 +1204,7 @@ static const char *read_commit_message(const char *name)
 	commit = lookup_commit_reference_by_name(name);
 	if (!commit)
 		die(_("could not lookup commit '%s'"), name);
-	out_enc = get_commit_output_encoding();
+	out_enc = repo_get_commit_output_encoding(the_repository);
 	return repo_logmsg_reencode(the_repository, commit, NULL, out_enc);
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 368f6580a6..c28064c6f3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -668,7 +668,8 @@ static void show_tagger(const char *buf, struct rev_info *rev)
 
 	pp.fmt = rev->commit_format;
 	pp.date_mode = rev->date_mode;
-	pp_user_info(&pp, "Tagger", &out, buf, get_log_output_encoding());
+	pp_user_info(&pp, "Tagger", &out, buf,
+		     repo_get_log_output_encoding(the_repository));
 	fprintf(rev->diffopt.file, "%s", out.buf);
 	strbuf_release(&out);
 }
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index e17dec27b1..828b2b5845 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -93,7 +93,8 @@ int cmd_mailinfo(int argc,
 
 	switch (meta_charset.policy) {
 	case CHARSET_DEFAULT:
-		mi.metainfo_charset = get_commit_output_encoding();
+		mi.metainfo_charset =
+			repo_get_commit_output_encoding(the_repository);
 		break;
 	case CHARSET_NO_REENCODE:
 		mi.metainfo_charset = NULL;
diff --git a/builtin/replay.c b/builtin/replay.c
index 2d12a4e403..c23972f044 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -59,7 +59,8 @@ static struct commit *create_commit(struct tree *tree,
 	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
-	const char *out_enc = get_commit_output_encoding();
+	const char *out_enc =
+		repo_get_commit_output_encoding(the_repository);
 	const char *message = repo_logmsg_reencode(the_repository, based_on,
 						   NULL, out_enc);
 	const char *orig_message = NULL;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f62bcbf2b1..e8427a7c0c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -218,7 +218,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.date_mode = revs->date_mode;
 		ctx.date_mode_explicit = revs->date_mode_explicit;
 		ctx.fmt = revs->commit_format;
-		ctx.output_encoding = get_log_output_encoding();
+		ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 		ctx.color = revs->diffopt.use_color;
 		ctx.rev = revs;
 		pretty_print_commit(&ctx, commit, &buf);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3ed5c46078..81b8baf44a 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -246,7 +246,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
 	ctx.date_mode = log->date_mode;
-	ctx.output_encoding = get_log_output_encoding();
+	ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 
 	if (!log->summary) {
 		if (log->user_format)
diff --git a/bundle.c b/bundle.c
index 4773b51eb1..aad00836b9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -483,7 +483,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 	write_or_die(bpi->fd, buf.buf, buf.len);
 
 	ctx.fmt = CMIT_FMT_ONELINE;
-	ctx.output_encoding = get_log_output_encoding();
+	ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 	strbuf_reset(&buf);
 	pretty_print_commit(&ctx, commit, &buf);
 	strbuf_trim(&buf);
diff --git a/commit.c b/commit.c
index cc03a93036..a3a0f458ae 100644
--- a/commit.c
+++ b/commit.c
@@ -1655,7 +1655,8 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 	size_t i;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+	encoding_is_utf8 =
+		is_encoding_utf8(the_repository->git_commit_encoding);
 
 	strbuf_grow(buffer, 8192); /* should avoid reallocs for the headers */
 	strbuf_addf(buffer, "tree %s\n", oid_to_hex(tree));
@@ -1676,7 +1677,8 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 		committer = git_committer_info(IDENT_STRICT);
 	strbuf_addf(buffer, "committer %s\n", committer);
 	if (!encoding_is_utf8)
-		strbuf_addf(buffer, "encoding %s\n", git_commit_encoding);
+		strbuf_addf(buffer, "encoding %s\n",
+			    the_repository->git_commit_encoding);
 
 	while (extra) {
 		add_extra_header(buffer, extra);
@@ -1705,7 +1707,8 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	size_t i, nparents;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+	encoding_is_utf8 =
+		is_encoding_utf8(the_repository->git_commit_encoding);
 
 	assert_oid_type(tree, OBJ_TREE);
 
diff --git a/config.c b/config.c
index a11bb85da3..656748692d 100644
--- a/config.c
+++ b/config.c
@@ -1690,13 +1690,15 @@ static int git_default_sparse_config(const char *var, const char *value)
 static int git_default_i18n_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "i18n.commitencoding")) {
-		FREE_AND_NULL(git_commit_encoding);
-		return git_config_string(&git_commit_encoding, var, value);
+		FREE_AND_NULL(the_repository->git_commit_encoding);
+		return git_config_string(&the_repository->git_commit_encoding,
+					 var, value);
 	}
 
 	if (!strcmp(var, "i18n.logoutputencoding")) {
-		FREE_AND_NULL(git_log_output_encoding);
-		return git_config_string(&git_log_output_encoding, var, value);
+		FREE_AND_NULL(the_repository->git_log_output_encoding);
+		return git_config_string(&the_repository->git_log_output_encoding,
+					 var, value);
 	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
diff --git a/environment.c b/environment.c
index a2ce998081..288fccb9af 100644
--- a/environment.c
+++ b/environment.c
@@ -37,8 +37,6 @@ int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
 int warn_on_object_refname_ambiguity = 1;
 int repository_format_precious_objects;
-char *git_commit_encoding;
-char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
 char *git_attributes_file;
@@ -199,17 +197,6 @@ const char *strip_namespace(const char *namespaced_ref)
 	return NULL;
 }
 
-const char *get_log_output_encoding(void)
-{
-	return git_log_output_encoding ? git_log_output_encoding
-		: get_commit_output_encoding();
-}
-
-const char *get_commit_output_encoding(void)
-{
-	return git_commit_encoding ? git_commit_encoding : "UTF-8";
-}
-
 static int the_shared_repository = PERM_UMASK;
 static int need_shared_repository_from_config = 1;
 
diff --git a/environment.h b/environment.h
index 923e12661e..5e380901cf 100644
--- a/environment.h
+++ b/environment.h
@@ -207,12 +207,6 @@ extern int grafts_keep_true_parents;
 
 extern int repository_format_precious_objects;
 
-const char *get_log_output_encoding(void);
-const char *get_commit_output_encoding(void);
-
-extern char *git_commit_encoding;
-extern char *git_log_output_encoding;
-
 extern char *editor_program;
 extern char *askpass_program;
 extern char *excludes_file;
diff --git a/log-tree.c b/log-tree.c
index ba5632805e..6bbddcf85a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -832,7 +832,7 @@ void show_log(struct rev_info *opt)
 
 		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 		format_display_notes(&commit->object.oid, &notebuf,
-				     get_log_output_encoding(), raw);
+				     repo_get_log_output_encoding(the_repository), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
@@ -852,7 +852,7 @@ void show_log(struct rev_info *opt)
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
 	ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
-	ctx.output_encoding = get_log_output_encoding();
+	ctx.output_encoding = repo_get_log_output_encoding(the_repository);
 	ctx.rev = opt;
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
diff --git a/pretty.c b/pretty.c
index 6403e26890..e7b069a48c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2296,7 +2296,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 		return;
 	}
 
-	encoding = get_log_output_encoding();
+	encoding = repo_get_log_output_encoding(the_repository);
 	msg = reencoded = repo_logmsg_reencode(the_repository, commit, NULL,
 					       encoding);
 
diff --git a/remote-curl.c b/remote-curl.c
index 9a71e04301..47c31e7def 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -4,6 +4,7 @@
 #include "git-curl-compat.h"
 #include "config.h"
 #include "environment.h"
+#include "repository.h"
 #include "gettext.h"
 #include "hex.h"
 #include "remote.h"
@@ -378,7 +379,8 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 	if (strcmp(type->buf, "text/plain"))
 		return -1;
 	if (charset->len)
-		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
+		strbuf_reencode(msg, charset->buf,
+				repo_get_log_output_encoding(the_repository));
 
 	strbuf_trim(msg);
 	if (!msg->len)
diff --git a/repository.c b/repository.c
index f988b8ae68..2b999c4bdc 100644
--- a/repository.c
+++ b/repository.c
@@ -131,6 +131,19 @@ const char *repo_get_work_tree(struct repository *repo)
 	return repo->worktree;
 }
 
+const char *repo_get_log_output_encoding(struct repository *repo)
+{
+	return (repo && repo->git_log_output_encoding) ?
+	       repo->git_log_output_encoding :
+	       repo_get_commit_output_encoding(repo);
+}
+
+const char *repo_get_commit_output_encoding(struct repository *repo)
+{
+	return (repo && repo->git_commit_encoding) ?
+	       repo->git_commit_encoding : "UTF-8";
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index 24a66a496a..0b71b55853 100644
--- a/repository.h
+++ b/repository.h
@@ -150,6 +150,8 @@ struct repository {
 
 	/* Configurations */
 	int repository_format_worktree_config;
+	char *git_commit_encoding;
+	char *git_log_output_encoding;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
@@ -179,6 +181,10 @@ struct set_gitdir_args {
 	int disable_ref_updates;
 };
 
+/* Get configurations */
+const char *repo_get_log_output_encoding(struct repository *repo);
+const char *repo_get_commit_output_encoding(struct repository *repo);
+
 void repo_set_gitdir(struct repository *repo, const char *root,
 		     const struct set_gitdir_args *extra_args);
 void repo_set_worktree(struct repository *repo, const char *path);
diff --git a/revision.c b/revision.c
index f5f5b84f2b..c3a54577b0 100644
--- a/revision.c
+++ b/revision.c
@@ -2688,11 +2688,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
-		free(git_log_output_encoding);
+		free(the_repository->git_log_output_encoding);
 		if (strcmp(optarg, "none"))
-			git_log_output_encoding = xstrdup(optarg);
+			the_repository->git_log_output_encoding = xstrdup(optarg);
 		else
-			git_log_output_encoding = xstrdup("");
+			the_repository->git_log_output_encoding = xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^= 1;
@@ -3142,7 +3142,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	diff_setup_done(&revs->diffopt);
 
-	if (!is_encoding_utf8(get_log_output_encoding()))
+	if (!is_encoding_utf8(repo_get_log_output_encoding(the_repository)))
 		revs->grep_filter.ignore_locale = 1;
 	compile_grep_patterns(&revs->grep_filter);
 
@@ -4041,7 +4041,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	 * so we will not end up with a buffer that has two different encodings
 	 * in it.
 	 */
-	encoding = get_log_output_encoding();
+	encoding = repo_get_log_output_encoding(the_repository);
 	message = repo_logmsg_reencode(the_repository, commit, NULL, encoding);
 
 	/* Copy the commit to temporary if we are using "fake" headers */
diff --git a/sequencer.c b/sequencer.c
index 8d01cd50ac..25783d3b8b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -490,7 +490,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
 	int subject_len;
 
 	out->message = repo_logmsg_reencode(the_repository, commit, NULL,
-					    get_commit_output_encoding());
+			repo_get_commit_output_encoding(the_repository));
 	abbrev = short_commit_name(the_repository, commit);
 
 	subject_len = find_commit_subject(out->message, &subject);
@@ -1561,7 +1561,7 @@ static int try_to_commit(struct repository *r,
 
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
-		const char *out_enc = get_commit_output_encoding();
+		const char *out_enc = repo_get_commit_output_encoding(r);
 		const char *message = repo_logmsg_reencode(r, current_head,
 							   NULL, out_enc);
 
@@ -2073,7 +2073,7 @@ static int update_squash_messages(struct repository *r,
 	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
 	const char *message, *body;
-	const char *encoding = get_commit_output_encoding();
+	const char *encoding = repo_get_commit_output_encoding(r);
 
 	if (ctx->current_fixup_count > 0) {
 		struct strbuf header = STRBUF_INIT;
@@ -3311,7 +3311,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	if (prepare_revs(opts))
 		return -1;
 
-	encoding = get_log_output_encoding();
+	encoding = repo_get_log_output_encoding(the_repository);
 
 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
@@ -3697,7 +3697,7 @@ static int make_patch(struct repository *r,
 	}
 
 	if (!file_exists(rebase_path_message())) {
-		const char *encoding = get_commit_output_encoding();
+		const char *encoding = repo_get_commit_output_encoding(r);
 		const char *commit_buffer = repo_logmsg_reencode(r,
 								 commit, NULL,
 								 encoding);
@@ -4186,7 +4186,7 @@ static int do_merge(struct repository *r,
 	}
 
 	if (commit) {
-		const char *encoding = get_commit_output_encoding();
+		const char *encoding = repo_get_commit_output_encoding(r);
 		const char *message = repo_logmsg_reencode(r, commit, NULL,
 							   encoding);
 		const char *body;
@@ -5320,7 +5320,8 @@ static int commit_staged_changes(struct repository *r,
 				struct commit *commit;
 				const char *msg;
 				const char *path = rebase_path_squash_msg();
-				const char *encoding = get_commit_output_encoding();
+				const char *encoding =
+					repo_get_commit_output_encoding(r);
 
 				if (parse_head(r, &commit)) {
 					ret = error(_("could not parse HEAD"));
@@ -6090,7 +6091,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	get_commit_format(format, &revs);
 	free(format);
 	pp.fmt = revs.commit_format;
-	pp.output_encoding = get_log_output_encoding();
+	pp.output_encoding = repo_get_log_output_encoding(r);
 
 	if (setup_revisions(argc, argv, &revs, NULL) > 1) {
 		ret = error(_("make_script: unhandled options"));
diff --git a/submodule.c b/submodule.c
index 74d5766f07..9cfc7ca23c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -501,7 +501,7 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
 	while ((commit = get_revision(rev))) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
-		ctx.output_encoding = get_log_output_encoding();
+		ctx.output_encoding = repo_get_log_output_encoding(r);
 		strbuf_setlen(&sb, 0);
 		repo_format_commit_message(r, commit, format, &sb,
 				      &ctx);
-- 
2.47.0.73.g7a80afd5fd.dirty

