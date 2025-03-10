Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172222E415
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622295; cv=none; b=pfO/r5w+2Qwr53lNrttLHMPtdwe9kORzT2FuXT11JyrD7GQYw+LkiqGpMQUcbEfevMTwwc9sxrQnKMW6lx3YTO+sOg3PYQk01Wa/GXlAbzuM4pX94EwNGTLv+ZFTm+4uXM8cFzZ1E1QblwPoq/nd/cxnrKGToCW3M0qzPNhbM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622295; c=relaxed/simple;
	bh=Rr8l6aAyNlSZm4fCpWL9wOIuuWeWUc5MoPp0m5UMeeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPIxKMMLxlpzYppXFp7BWXzGua01GM/zTIhMm8hn75z8dFXSSAT8EVcWLECtpwlCt+2Xan+9PBss0WIpKLVeGEEOZh0h835fgQ6zpo0U/bq3deBisXa2KR4OxCaNiqGXFXJLBSgZfoUMmQPivyB/a21CqAtZAfmSrlODfdXEr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXnDGCuU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXnDGCuU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf848528aso9967685e9.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622290; x=1742227090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGwBWOQe3C32hsFrUC22MWPghIdI9fz/VwkWsghhZbk=;
        b=AXnDGCuUJ9jGikWMKOgSWV6mF2BRuxQNgQD6PaxPIDFQdE6nINwIiI88WkaEbxvY7L
         9S7LMbGPXRX5P5c3cpeToy0UlAouyFhxPu4XBYmlo8TWlguMy5a7K3n4JlJCU8VJyGCa
         mU5DIVPzj56SO6iaSzjxHuvtOmOpvV6RkBlKshA6A5/FKfbFr3iCHQlV7kApXLv7XmmH
         1kY1QaFRGSWe+W44TOvNN3+Ord7b120XcWd6X0E1AwuzIck1VJy0POz3xD6SmV3u0m5n
         /G5shBMNu/pLKdHTCVv/Lu5PC94KRiCvwm3Oljm/OLtx68D9lqkBRRpIDabmvgx23itM
         uEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622290; x=1742227090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGwBWOQe3C32hsFrUC22MWPghIdI9fz/VwkWsghhZbk=;
        b=Owm5vsvW5LnLNUeVoKGYydKK+Wf6Or3sOKz4Etm+S6BaNmqmwCmG6sLHacP9LFZqas
         nhMgLKBeMyr3HFkr12Q3JFZXRPa/upAiS+WihEfoQ2QDHYLiyxLndTI3ZAOsWAMyoLBN
         qGQEVS0k8dCjnIU3t7UfmmhO8N89WU0TC02VTm5KUca83/g5sDV99vWapDnDMXdmLlXc
         4mBnqvxsz8XVhXDtuNRa1cqer+V9B8enz8DXRFBQiPNXD0HTOtFkPH/s4PvxATcoDFDx
         gobgdHYdLERPIy1OPdIkeihWFS2YzmM7Jqg4JQSRAZi/MMVdRx+6G6QvkpTxv92Dgcql
         uPUw==
X-Gm-Message-State: AOJu0YyM55J+iwV4vgE8sT5JGZh+9SaRIBFmTBYMTBjCJ47CCx3Mwfyn
	Aisg0lEhRZ3yjeSXwIX4tRWcpMSWq6TwJXdrrNaHqW4+8/UYjWBhquVF3g==
X-Gm-Gg: ASbGncsYea4DnE2oG5arbNRHGqeYanlPS6908SjZXJ2txvVJeGa0fNkx8xuduZQJiVE
	bDA0OYQs+HSZ8+Ai9TI3gsQGR02ult6qcVoXKXbSB+Xidk4MgcMhV4IiLBhBTTIZRkP5aej5jMo
	/gTPM7UnGR8Z2/WPgoBfU1WaT6Nq/Z1tpw7Ki4zXXfqFBDckjWTnm3S/Z501dQn93DDSriTHj/l
	xAQIGHprBmm8AOsS1+mFeRALh9XB4y323YBqxgLgj3L4d9u/wSkbGTi+WiFwU8z32ncEQ2WfcKA
	mo4Awp/R6y65OMsRaubKE102vfl9nU8yQamGC3lCV8hdgM7Roil65rct1ejaU7HFdzv94TpcAY/
	8kSI8oR7tQzbDhX8TKXrHXbmVLqk+K11AcWVykQ==
X-Google-Smtp-Source: AGHT+IHoEHz1fkQ/t0eDaFTSr9r44kBmZ5Rspd6yR/BFxlfs2BnhzypdHhOW6EL3Zx1BzD7tmKls/g==
X-Received: by 2002:a05:600c:3111:b0:43c:f7b8:83c7 with SMTP id 5b1f17b1804b1-43d01c22322mr1201465e9.25.1741622290108;
        Mon, 10 Mar 2025 08:58:10 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm15551831f8f.62.2025.03.10.08.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:58:09 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Luke Shumaker <lukeshu@datawire.io>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 6/6] fast-export, fast-import: add support for signed-commits
Date: Mon, 10 Mar 2025 16:57:46 +0100
Message-ID: <20250310155746.879481-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.89.g148d1db992
In-Reply-To: <20250310155746.879481-1-christian.couder@gmail.com>
References: <20250224142744.279643-1-christian.couder@gmail.com>
 <20250310155746.879481-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Shumaker <lukeshu@datawire.io>

fast-export has a --signed-tags= option that controls how to handle tag
signatures.  However, there is no equivalent for commit signatures; it
just silently strips the signature out of the commit (analogously to
--signed-tags=strip).

While signatures are generally problematic for fast-export/fast-import
(because hashes are likely to change), if they're going to support tag
signatures, there's no reason to not also support commit signatures.

So, implement a --signed-commits= option that mirrors the --signed-tags=
option.

On the fast-export side, try to be as much like signed-tags as possible,
in both implementation and in user-interface.  This will change the
default behavior to '--signed-commits=abort' from what is now
'--signed-commits=strip'.  In order to provide an escape hatch for users
of third-party tools that call fast-export and do not yet know of the
--signed-commits= option, add an environment variable
'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' that changes the default to
'--signed-commits=warn-strip'.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-export.adoc |  11 +++
 Documentation/git-fast-import.adoc |  18 +++++
 builtin/fast-export.c              | 123 ++++++++++++++++++++++++-----
 builtin/fast-import.c              |  23 ++++++
 t/t9350-fast-export.sh             |  98 +++++++++++++++++++++++
 5 files changed, 253 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 2bb52261a0..413a527496 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -44,6 +44,17 @@ affecting tags or any commit in their history will be performed by you
 or by fast-export or fast-import, or if you do not care that the
 resulting tag will have an invalid signature.
 
+--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
+	Specify how to handle signed commits.  Behaves exactly as
+	'--signed-tags', but for commits.  Default is 'abort'.
++
+Earlier versions this command that did not have '--signed-commits'
+behaved as if '--signed-commits=strip'.  As an escape hatch for users
+of tools that call 'git fast-export' but do not yet support
+'--signed-commits', you may set the environment variable
+'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' in order to change the default
+from 'abort' to 'warn-strip'.
+
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
 	Since revisions and files to export can be limited by path,
diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 8e0de618c0..7b107f5e8e 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -431,12 +431,21 @@ and control the current import process.  More detailed discussion
 Create or update a branch with a new commit, recording one logical
 change to the project.
 
+////
+Yes, it's intentional that the 'gpgsig' line doesn't have a trailing
+`LF`; the definition of `data` has a byte-count prefix, so it
+doesn't need an `LF` to act as a terminator (and `data` also already
+includes an optional trailing `LF?` just in case you want to include
+one).
+////
+
 ....
 	'commit' SP <ref> LF
 	mark?
 	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
+	('gpgsig' SP <alg> LF data)?
 	('encoding' SP <encoding> LF)?
 	data
 	('from' SP <commit-ish> LF)?
@@ -505,6 +514,15 @@ that was selected by the --date-format=<fmt> command-line option.
 See ``Date Formats'' above for the set of supported formats, and
 their syntax.
 
+`gpgsig`
+^^^^^^^^
+
+The optional `gpgsig` command is used to include a PGP/GPG signature
+that signs the commit data.
+
+Here <alg> specifies which hashing algorithm is used for this
+signature, either `sha1` or `sha256`.
+
 `encoding`
 ^^^^^^^^^^
 The optional `encoding` command indicates the encoding of the commit
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 39d43c2a29..126980f724 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -35,8 +35,11 @@ static const char *fast_export_usage[] = {
 	NULL
 };
 
+enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_WARN_VERBATIM, SIGN_WARN_STRIP };
+
 static int progress;
-static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
+static enum sign_mode signed_tag_mode = SIGN_ABORT;
+static enum sign_mode signed_commit_mode = SIGN_ABORT;
 static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
 static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
 static int fake_missing_tagger;
@@ -53,23 +56,24 @@ static int anonymize;
 static struct hashmap anonymized_seeds;
 static struct revision_sources revision_sources;
 
-static int parse_opt_signed_tag_mode(const struct option *opt,
+static int parse_opt_sign_mode(const struct option *opt,
 				     const char *arg, int unset)
 {
-	enum signed_tag_mode *val = opt->value;
-
-	if (unset || !strcmp(arg, "abort"))
-		*val = SIGNED_TAG_ABORT;
+	enum sign_mode *val = opt->value;
+	if (unset)
+		return 0;
+	else if (!strcmp(arg, "abort"))
+		*val = SIGN_ABORT;
 	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
-		*val = VERBATIM;
+		*val = SIGN_VERBATIM;
 	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
-		*val = WARN_VERBATIM;
+		*val = SIGN_WARN_VERBATIM;
 	else if (!strcmp(arg, "warn-strip"))
-		*val = WARN_STRIP;
+		*val = SIGN_WARN_STRIP;
 	else if (!strcmp(arg, "strip"))
-		*val = STRIP;
+		*val = SIGN_STRIP;
 	else
-		return error("Unknown signed-tags mode: %s", arg);
+		return error("Unknown %s mode: %s", opt->long_name, arg);
 	return 0;
 }
 
@@ -611,6 +615,43 @@ static void anonymize_ident_line(const char **beg, const char **end)
 	*end = out->buf + out->len;
 }
 
+/*
+ * find_commit_multiline_header is similar to find_commit_header,
+ * except that it handles multi-line headers, rather than simply
+ * returning the first line of the header.
+ *
+ * The returned string has had the ' ' line continuation markers
+ * removed, and points to allocated memory that must be free()d (not
+ * to memory within 'msg').
+ *
+ * If the header is found, then *end is set to point at the '\n' in
+ * msg that immediately follows the header value.
+ */
+static const char *find_commit_multiline_header(const char *msg,
+						const char *key,
+						const char **end)
+{
+	struct strbuf val = STRBUF_INIT;
+	const char *bol, *eol;
+	size_t len;
+
+	bol = find_commit_header(msg, key, &len);
+	if (!bol)
+		return NULL;
+	eol = bol + len;
+	strbuf_add(&val, bol, len);
+
+	while (eol[0] == '\n' && eol[1] == ' ') {
+		bol = eol + 2;
+		eol = strchrnul(bol, '\n');
+		strbuf_addch(&val, '\n');
+		strbuf_add(&val, bol, eol - bol);
+	}
+
+	*end = eol;
+	return strbuf_detach(&val, NULL);
+}
+
 static void handle_commit(struct commit *commit, struct rev_info *rev,
 			  struct string_list *paths_of_changed_objects)
 {
@@ -619,6 +660,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	const char *author, *author_end, *committer, *committer_end;
 	const char *encoding = NULL;
 	size_t encoding_len;
+	const char *signature_alg = NULL, *signature = NULL;
 	const char *message;
 	char *reencoded = NULL;
 	struct commit_list *p;
@@ -645,17 +687,25 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
 
 	/*
-	 * find_commit_header() gets a `+ 1` because
-	 * commit_buffer_cursor points at the trailing "\n" at the end
-	 * of the previous line, but find_commit_header() wants a
+	 * find_commit_header() and find_commit_multiline_header() get
+	 * a `+ 1` because commit_buffer_cursor points at the trailing
+	 * "\n" at the end of the previous line, but they want a
 	 * pointer to the beginning of the next line.
 	 */
+
 	if (*commit_buffer_cursor == '\n') {
 		encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
 		if (encoding)
 			commit_buffer_cursor = encoding + encoding_len;
 	}
 
+	if (*commit_buffer_cursor == '\n') {
+		if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
+			signature_alg = "sha1";
+		else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
+			signature_alg = "sha256";
+	}
+
 	message = strstr(commit_buffer_cursor, "\n\n");
 	if (message)
 		message += 2;
@@ -719,6 +769,31 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	printf("%.*s\n%.*s\n",
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer);
+	if (signature) {
+		switch (signed_commit_mode) {
+		case SIGN_ABORT:
+			die("encountered signed commit %s; use "
+			    "--signed-commits=<mode> to handle it",
+			    oid_to_hex(&commit->object.oid));
+		case SIGN_WARN_VERBATIM:
+			warning("exporting signed commit %s",
+				oid_to_hex(&commit->object.oid));
+			/* fallthru */
+		case SIGN_VERBATIM:
+			printf("gpgsig %s\ndata %u\n%s",
+			       signature_alg,
+			       (unsigned)strlen(signature),
+			       signature);
+			break;
+		case SIGN_WARN_STRIP:
+			warning("stripping signature from commit %s",
+				oid_to_hex(&commit->object.oid));
+			/* fallthru */
+		case SIGN_STRIP:
+			break;
+		}
+		free((char *)signature);
+	}
 	if (!reencoded && encoding)
 		printf("encoding %.*s\n", (int)encoding_len, encoding);
 	printf("data %u\n%s",
@@ -834,21 +909,21 @@ static void handle_tag(const char *name, struct tag *tag)
 					       "\n-----BEGIN PGP SIGNATURE-----\n");
 		if (signature)
 			switch (signed_tag_mode) {
-			case SIGNED_TAG_ABORT:
+			case SIGN_ABORT:
 				die("encountered signed tag %s; use "
 				    "--signed-tags=<mode> to handle it",
 				    oid_to_hex(&tag->object.oid));
-			case WARN_VERBATIM:
+			case SIGN_WARN_VERBATIM:
 				warning("exporting signed tag %s",
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
-			case VERBATIM:
+			case SIGN_VERBATIM:
 				break;
-			case WARN_STRIP:
+			case SIGN_WARN_STRIP:
 				warning("stripping signature from tag %s",
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
-			case STRIP:
+			case SIGN_STRIP:
 				message_size = signature + 1 - message;
 				break;
 			}
@@ -1194,6 +1269,7 @@ int cmd_fast_export(int argc,
 		    const char *prefix,
 		    struct repository *repo UNUSED)
 {
+	const char *env_signed_commits_noabort;
 	struct rev_info revs;
 	struct commit *commit;
 	char *export_filename = NULL,
@@ -1207,7 +1283,10 @@ int cmd_fast_export(int argc,
 			    N_("show progress after <n> objects")),
 		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, N_("mode"),
 			     N_("select handling of signed tags"),
-			     parse_opt_signed_tag_mode),
+			     parse_opt_sign_mode),
+		OPT_CALLBACK(0, "signed-commits", &signed_commit_mode, N_("mode"),
+			     N_("select handling of signed commits"),
+			     parse_opt_sign_mode),
 		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, N_("mode"),
 			     N_("select handling of tags that tag filtered objects"),
 			     parse_opt_tag_of_filtered_mode),
@@ -1248,6 +1327,10 @@ int cmd_fast_export(int argc,
 	if (argc == 1)
 		usage_with_options (fast_export_usage, options);
 
+	env_signed_commits_noabort = getenv("FAST_EXPORT_SIGNED_COMMITS_NOABORT");
+	if (env_signed_commits_noabort && *env_signed_commits_noabort)
+		signed_commit_mode = SIGN_WARN_STRIP;
+
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 397a6f46ad..e432e8d5a1 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2719,10 +2719,13 @@ static struct hash_list *parse_merge(unsigned int *count)
 
 static void parse_new_commit(const char *arg)
 {
+	static struct strbuf sig = STRBUF_INIT;
 	static struct strbuf msg = STRBUF_INIT;
+	struct string_list siglines = STRING_LIST_INIT_NODUP;
 	struct branch *b;
 	char *author = NULL;
 	char *committer = NULL;
+	char *sig_alg = NULL;
 	char *encoding = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
@@ -2746,6 +2749,13 @@ static void parse_new_commit(const char *arg)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
+	if (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
+		sig_alg = xstrdup(v);
+		read_next_command();
+		parse_data(&sig, 0, NULL);
+		read_next_command();
+	} else
+		strbuf_setlen(&sig, 0);
 	if (skip_prefix(command_buf.buf, "encoding ", &v)) {
 		encoding = xstrdup(v);
 		read_next_command();
@@ -2819,10 +2829,23 @@ static void parse_new_commit(const char *arg)
 		strbuf_addf(&new_data,
 			"encoding %s\n",
 			encoding);
+	if (sig_alg) {
+		if (!strcmp(sig_alg, "sha1"))
+			strbuf_addstr(&new_data, "gpgsig ");
+		else if (!strcmp(sig_alg, "sha256"))
+			strbuf_addstr(&new_data, "gpgsig-sha256 ");
+		else
+			die("Expected gpgsig algorithm sha1 or sha256, got %s", sig_alg);
+		string_list_split_in_place(&siglines, sig.buf, "\n", -1);
+		strbuf_add_separated_string_list(&new_data, "\n ", &siglines);
+		strbuf_addch(&new_data, '\n');
+	}
 	strbuf_addch(&new_data, '\n');
 	strbuf_addbuf(&new_data, &msg);
+	string_list_clear(&siglines, 1);
 	free(author);
 	free(committer);
+	free(sig_alg);
 	free(encoding);
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index cc110727fb..304bac5b1d 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -8,6 +8,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success 'setup' '
 
@@ -284,10 +285,107 @@ test_expect_success 'signed-tags=warn-strip' '
 	test -s err
 '
 
+test_expect_success GPG 'set up signed commit' '
+
+	# Generate a commit with both "gpgsig" and "encoding" set, so
+	# that we can test that fast-import gets the ordering correct
+	# between the two.
+	test_config i18n.commitEncoding ISO-8859-1 &&
+	git checkout -f -b commit-signing main &&
+	echo Sign your name >file-sign &&
+	git add file-sign &&
+	git commit -S -m "signed commit" &&
+	COMMIT_SIGNING=$(git rev-parse --verify commit-signing)
+
+'
+
+test_expect_success GPG 'signed-commits default' '
+
+	sane_unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
+	test_must_fail git fast-export --reencode=no commit-signing &&
+
+	FAST_EXPORT_SIGNED_COMMITS_NOABORT=1 git fast-export --reencode=no commit-signing >output 2>err &&
+	! grep ^gpgsig output &&
+	grep "^encoding ISO-8859-1" output &&
+	test -s err &&
+	sed "s/commit-signing/commit-strip-signing/" output | (
+		cd new &&
+		git fast-import &&
+		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
+		test $COMMIT_SIGNING != $STRIPPED
+	)
+
+'
+
+test_expect_success GPG 'signed-commits=abort' '
+
+	test_must_fail git fast-export --signed-commits=abort commit-signing
+
+'
+
+test_expect_success GPG 'signed-commits=verbatim' '
+
+	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
+	grep "^gpgsig sha" output &&
+	grep "encoding ISO-8859-1" output &&
+	(
+		cd new &&
+		git fast-import &&
+		STRIPPED=$(git rev-parse --verify refs/heads/commit-signing) &&
+		test $COMMIT_SIGNING = $STRIPPED
+	) <output
+
+'
+
+test_expect_success GPG 'signed-commits=warn-verbatim' '
+
+	git fast-export --signed-commits=warn-verbatim --reencode=no commit-signing >output 2>err &&
+	grep "^gpgsig sha" output &&
+	grep "encoding ISO-8859-1" output &&
+	test -s err &&
+	(
+		cd new &&
+		git fast-import &&
+		STRIPPED=$(git rev-parse --verify refs/heads/commit-signing) &&
+		test $COMMIT_SIGNING = $STRIPPED
+	) <output
+
+'
+
+test_expect_success GPG 'signed-commits=strip' '
+
+	git fast-export --signed-commits=strip --reencode=no commit-signing >output &&
+	! grep ^gpgsig output &&
+	grep "^encoding ISO-8859-1" output &&
+	sed "s/commit-signing/commit-strip-signing/" output | (
+		cd new &&
+		git fast-import &&
+		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
+		test $COMMIT_SIGNING != $STRIPPED
+	)
+
+'
+
+test_expect_success GPG 'signed-commits=warn-strip' '
+
+	git fast-export --signed-commits=warn-strip --reencode=no commit-signing >output 2>err &&
+	! grep ^gpgsig output &&
+	grep "^encoding ISO-8859-1" output &&
+	test -s err &&
+	sed "s/commit-signing/commit-strip-signing/" output | (
+		cd new &&
+		git fast-import &&
+		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
+		test $COMMIT_SIGNING != $STRIPPED
+	)
+
+'
+
 test_expect_success 'setup submodule' '
 
 	test_config_global protocol.file.allow always &&
 	git checkout -f main &&
+	test_might_fail git update-ref -d refs/heads/commit-signing &&
 	mkdir sub &&
 	(
 		cd sub &&
-- 
2.49.0.rc1.89.g148d1db992

