Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F135A783
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308745; cv=none; b=Ydg9RPN3dIGnDIfpC4YZM6hgDR5djMLdJcdkGRJ+fcfBGpbqop7RZU7OoZ6lRAcrDX/dB7KnfXlk/TzMtbh1MAnazbf/5yT3FS4j1tj3z1qm0ENmUYnLPxtFYi9f0A7ekY8h9VXgb4HgTzp9gwS8JgYatJ142v8nUKjf4pPJYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308745; c=relaxed/simple;
	bh=O5jwe+h8ffItyEhBoUzHBQ/oWD++hIkdugUqqPZKEBc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X+MWQ4iITUE4ucMEICMgd5N6RlSv5BkET46fExc33ZBqO97I/8fbbRXU1ZFqtAtlnocFNVDcoBQ/5VOjNAlF7g5X/xKQHxHYX3MJ7BX9RRuieGHTMnIyp4bYYYlC0lMIVYB7fR3Mp1PNA8MzJq8Vci/YdKKNkBbuDYYg1A+asZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNqxJ7OA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNqxJ7OA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3394b892691so535298f8f.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308741; x=1706913541; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZmfdHp82bUljryEBfwEldFiToycrWOOk+xAtbl3FT0=;
        b=CNqxJ7OA5MzMmB6pjmEto3KwEOqO18BUuYkZA95sJ9okIiYvsWqJ76d+6HUVhTx8Aw
         6TCVbtUr1uZSh5O19yypagildR/Ww6yyUsS8s1kcHDK/55vXyjkGwCDLN+Hgc0DMuEUU
         O0ft0zYXRXcd22wixIFZjzYmoQ6Wljrq+HLnh5HyvvmKztEmT36q7rx6S3Pw8jXZj3v8
         xX0bs54aBCGlepiwiirbyueS5/DBl7REy2MnjVuwb0G4zzCgpukqVw5ibvd/wyezV19F
         z2nCSPuHr86/PwgW6ZAkQJoGU7ETTOOsZXM9VW0qSEpQEV07FTXDNKkxVglpUob1bpBu
         8K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308741; x=1706913541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZmfdHp82bUljryEBfwEldFiToycrWOOk+xAtbl3FT0=;
        b=odT65szoPaFu2drg3OT1OiKL1ACKm1t/RAN5vlP7r2LWTh2UfbQ1isj33Wfa/abqMs
         8fqfyO7ke+uMxhmCpRvF2P30ACPDDHxM1sQFZdWqLMmYaS3lY1diO2h8sDr3n1lE8+B9
         9mInjr/1mo+NbXyRQFN1PzSyDEaz0mDylnuKmHdFlH0IL+wRfy3YyWiQzc4mxSaoE2ZG
         NxPaXS6skN0T+gBfNpGwJFB3caKtc8iuIl48HuWKU3b0FFKjVxIKYpc5xmAyfRa+KW3L
         266o49OCa2f6mn5D3QTxKdCCatOvyTAZLb5+TBF6tlkNhMASO/ptVZ3/KMNcajFhT1WC
         H8sA==
X-Gm-Message-State: AOJu0Yzjj6MYaNX7ZcrTTjVDI1bg6Mv+FQm2ttYFvyBWsN6BuEJ9ZXx1
	EebBNJhPdl/ahOQ1Rlox7RrLutccB7N60Dzst98+OFnyEzAzB9alqettjRRN
X-Google-Smtp-Source: AGHT+IFPASiS63sC5cSn9Ob/582uXkwgnuuyFKOVPSaHXN8vD9zUIoTw5tJWZIksw2iNJDa91Vceuw==
X-Received: by 2002:adf:fcc7:0:b0:339:2827:d560 with SMTP id f7-20020adffcc7000000b003392827d560mr957366wrs.17.1706308741168;
        Fri, 26 Jan 2024 14:39:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020adff78e000000b0033925aa222dsm2106956wrp.57.2024.01.26.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:39:00 -0800 (PST)
Message-ID: <eaca39fd7eaa2c02ef2798cbb0304924bbc12b39.1706308737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:49 +0000
Subject: [PATCH v2 02/10] trailer: move interpret_trailers() to
 interpret-trailers.c
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

The interpret-trailers.c builtin is the only place we need to call
interpret_trailers(), so move its definition there.

Delete the corresponding declaration from trailer.h, which then forces
us to expose the working innards of that function. This enriches
trailer.h with a more granular API, which can then be unit-tested in the
future (because interpret_trailers() by itself does too many things to
be able to be easily unit-tested).

Take this opportunity to demote some file-handling functions out of the
trailer API implementation, as these have nothing to do with trailers.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  94 +++++++++++++++++++++++++++
 trailer.c                    | 120 ++++-------------------------------
 trailer.h                    |  20 +++++-
 3 files changed, 124 insertions(+), 110 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 85a3413baf5..8556acde4aa 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -9,6 +9,7 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "tempfile.h"
 #include "trailer.h"
 #include "config.h"
 
@@ -91,6 +92,99 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static struct tempfile *trailers_tempfile;
+
+static FILE *create_in_place_tempfile(const char *file)
+{
+	struct stat st;
+	struct strbuf filename_template = STRBUF_INIT;
+	const char *tail;
+	FILE *outfile;
+
+	if (stat(file, &st))
+		die_errno(_("could not stat %s"), file);
+	if (!S_ISREG(st.st_mode))
+		die(_("file %s is not a regular file"), file);
+	if (!(st.st_mode & S_IWUSR))
+		die(_("file %s is not writable by user"), file);
+
+	/* Create temporary file in the same directory as the original */
+	tail = strrchr(file, '/');
+	if (tail)
+		strbuf_add(&filename_template, file, tail - file + 1);
+	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
+
+	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
+	strbuf_release(&filename_template);
+	outfile = fdopen_tempfile(trailers_tempfile, "w");
+	if (!outfile)
+		die_errno(_("could not open temporary file"));
+
+	return outfile;
+}
+
+static void read_input_file(struct strbuf *sb, const char *file)
+{
+	if (file) {
+		if (strbuf_read_file(sb, file, 0) < 0)
+			die_errno(_("could not read input file '%s'"), file);
+	} else {
+		if (strbuf_read(sb, fileno(stdin), 0) < 0)
+			die_errno(_("could not read from stdin"));
+	}
+}
+
+static void interpret_trailers(const struct process_trailer_options *opts,
+			       struct list_head *new_trailer_head,
+			       const char *file)
+{
+	LIST_HEAD(head);
+	struct strbuf sb = STRBUF_INIT;
+	struct trailer_info info;
+	FILE *outfile = stdout;
+
+	trailer_config_init();
+
+	read_input_file(&sb, file);
+
+	if (opts->in_place)
+		outfile = create_in_place_tempfile(file);
+
+	parse_trailers(opts, &info, sb.buf, &head);
+
+	/* Print the lines before the trailers */
+	if (!opts->only_trailers)
+		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+
+	if (!opts->only_trailers && !info.blank_line_before_trailer)
+		fprintf(outfile, "\n");
+
+
+	if (!opts->only_input) {
+		LIST_HEAD(config_head);
+		LIST_HEAD(arg_head);
+		parse_trailers_from_config(&config_head);
+		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
+		list_splice(&config_head, &arg_head);
+		process_trailers_lists(&head, &arg_head);
+	}
+
+	format_trailers(opts, &head, outfile);
+
+	free_trailers(&head);
+	trailer_info_release(&info);
+
+	/* Print the lines after the trailers as is */
+	if (!opts->only_trailers)
+		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+
+	if (opts->in_place)
+		if (rename_tempfile(&trailers_tempfile, file))
+			die_errno(_("could not rename temporary file to %s"), file);
+
+	strbuf_release(&sb);
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
diff --git a/trailer.c b/trailer.c
index 66b6660f5a4..d3899195876 100644
--- a/trailer.c
+++ b/trailer.c
@@ -5,7 +5,6 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
-#include "tempfile.h"
 #include "trailer.h"
 #include "list.h"
 /*
@@ -163,8 +162,8 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void format_trailers(const struct process_trailer_options *opts,
-			    struct list_head *trailers, FILE *outfile)
+void format_trailers(const struct process_trailer_options *opts,
+		     struct list_head *trailers, FILE *outfile)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
@@ -366,8 +365,8 @@ static int find_same_and_apply_arg(struct list_head *head,
 	return 0;
 }
 
-static void process_trailers_lists(struct list_head *head,
-				   struct list_head *arg_head)
+void process_trailers_lists(struct list_head *head,
+			    struct list_head *arg_head)
 {
 	struct list_head *pos, *p;
 	struct arg_item *arg_tok;
@@ -589,7 +588,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	return 0;
 }
 
-static void trailer_config_init(void)
+void trailer_config_init(void)
 {
 	if (configured)
 		return;
@@ -719,7 +718,7 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 	list_add_tail(&new_item->list, arg_head);
 }
 
-static void parse_trailers_from_config(struct list_head *config_head)
+void parse_trailers_from_config(struct list_head *config_head)
 {
 	struct arg_item *item;
 	struct list_head *pos;
@@ -735,8 +734,8 @@ static void parse_trailers_from_config(struct list_head *config_head)
 	}
 }
 
-static void parse_trailers_from_command_line_args(struct list_head *arg_head,
-						  struct list_head *new_trailer_head)
+void parse_trailers_from_command_line_args(struct list_head *arg_head,
+					   struct list_head *new_trailer_head)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
@@ -775,17 +774,6 @@ static void parse_trailers_from_command_line_args(struct list_head *arg_head,
 	free(cl_separators);
 }
 
-static void read_input_file(struct strbuf *sb, const char *file)
-{
-	if (file) {
-		if (strbuf_read_file(sb, file, 0) < 0)
-			die_errno(_("could not read input file '%s'"), file);
-	} else {
-		if (strbuf_read(sb, fileno(stdin), 0) < 0)
-			die_errno(_("could not read from stdin"));
-	}
-}
-
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
@@ -1000,10 +988,10 @@ static void unfold_value(struct strbuf *val)
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
  */
-static void parse_trailers(struct trailer_info *info,
-			     const char *str,
-			     struct list_head *head,
-			     const struct process_trailer_options *opts)
+void parse_trailers(const struct process_trailer_options *opts,
+		    struct trailer_info *info,
+		    const char *str,
+		    struct list_head *head)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
@@ -1035,7 +1023,7 @@ static void parse_trailers(struct trailer_info *info,
 	}
 }
 
-static void free_trailers(struct list_head *trailers)
+void free_trailers(struct list_head *trailers)
 {
 	struct list_head *pos, *p;
 	list_for_each_safe(pos, p, trailers) {
@@ -1044,88 +1032,6 @@ static void free_trailers(struct list_head *trailers)
 	}
 }
 
-static struct tempfile *trailers_tempfile;
-
-static FILE *create_in_place_tempfile(const char *file)
-{
-	struct stat st;
-	struct strbuf filename_template = STRBUF_INIT;
-	const char *tail;
-	FILE *outfile;
-
-	if (stat(file, &st))
-		die_errno(_("could not stat %s"), file);
-	if (!S_ISREG(st.st_mode))
-		die(_("file %s is not a regular file"), file);
-	if (!(st.st_mode & S_IWUSR))
-		die(_("file %s is not writable by user"), file);
-
-	/* Create temporary file in the same directory as the original */
-	tail = strrchr(file, '/');
-	if (tail)
-		strbuf_add(&filename_template, file, tail - file + 1);
-	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
-
-	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
-	strbuf_release(&filename_template);
-	outfile = fdopen_tempfile(trailers_tempfile, "w");
-	if (!outfile)
-		die_errno(_("could not open temporary file"));
-
-	return outfile;
-}
-
-void interpret_trailers(const struct process_trailer_options *opts,
-			struct list_head *new_trailer_head,
-			const char *file)
-{
-	LIST_HEAD(head);
-	struct strbuf sb = STRBUF_INIT;
-	struct trailer_info info;
-	FILE *outfile = stdout;
-
-	trailer_config_init();
-
-	read_input_file(&sb, file);
-
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
-	parse_trailers(&info, sb.buf, &head, opts);
-
-	/* Print the lines before the trailers */
-	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
-
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
-		fprintf(outfile, "\n");
-
-
-	if (!opts->only_input) {
-		LIST_HEAD(config_head);
-		LIST_HEAD(arg_head);
-		parse_trailers_from_config(&config_head);
-		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
-		list_splice(&config_head, &arg_head);
-		process_trailers_lists(&head, &arg_head);
-	}
-
-	format_trailers(opts, &head, outfile);
-
-	free_trailers(&head);
-	trailer_info_release(&info);
-
-	/* Print the lines after the trailers as is */
-	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
-
-	if (opts->in_place)
-		if (rename_tempfile(&trailers_tempfile, file))
-			die_errno(_("could not rename temporary file to %s"), file);
-
-	strbuf_release(&sb);
-}
-
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
diff --git a/trailer.h b/trailer.h
index 37033e631a1..4f603e03ceb 100644
--- a/trailer.h
+++ b/trailer.h
@@ -81,15 +81,29 @@ struct process_trailer_options {
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
 
-void interpret_trailers(const struct process_trailer_options *opts,
-			struct list_head *new_trailer_head,
-			const char *file);
+void parse_trailers_from_config(struct list_head *config_head);
+
+void parse_trailers_from_command_line_args(struct list_head *arg_head,
+					   struct list_head *new_trailer_head);
+
+void process_trailers_lists(struct list_head *head,
+			    struct list_head *arg_head);
+
+void parse_trailers(const struct process_trailer_options *opts,
+		    struct trailer_info *info,
+		    const char *str,
+		    struct list_head *head);
 
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts);
 
 void trailer_info_release(struct trailer_info *info);
 
+void trailer_config_init(void);
+void format_trailers(const struct process_trailer_options *opts,
+		     struct list_head *trailers, FILE *outfile);
+void free_trailers(struct list_head *trailers);
+
 /*
  * Format the trailers from the commit msg "msg" into the strbuf "out".
  * Note two caveats about "opts":
-- 
gitgitgadget

