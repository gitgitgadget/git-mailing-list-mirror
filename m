Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353A12CDBE
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220963; cv=none; b=L3RNOJjEUnQaAdu24Rnl/ejqvXxgK1zgCyJpDqVVIXEHNoysc+67OhtANj0/j3gEyptYR4YwM7Dk2NRWnwVWWWKUEc62u+tJUTvtOUVmroEcQ8sFUdv/SwrmIMGhYmGL5uB2nlpgZvnWTLiiny7tWoGrIEYKZdauE8xGqCaJibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220963; c=relaxed/simple;
	bh=aT+rXyEM9/0N/5SQSsX8WLfLEzTfHqpyw34C6HyHiS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlXwQMGd2g3UVlYhyo3Tjt6lH8ixblRYp38AHwZwNAcPc5DXTsqNPiSkboUBBNFbrkDZj6j0EEwdNp3VPGE3EI2MoskXgYM4NYtI050a5Zv1yOvAl0DTiDM2Ko5C00m8aboNN/hYNtKEDFkDC1o9X5qqbxsrqKMApQjn0807R6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hjv0XGOU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hjv0XGOU"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so3139629a12.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220952; x=1784825752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Fr+Uh9XsP2RNYFyRiGxv3KLCqkx0t/U3XR3B+wxXns=;
        b=Hjv0XGOUr0laPfrY4siG2ycoykoW22XdM52j/4cMB+L7dkEnTTIcMDjFk3JYuw7stz
         MFkxC1bBkHWOlgcaNU/If50qoDR8eEB52i6b3se5xEwmS28HVZmfh8gY6Y/wOO3cvHaS
         ds0nKgHzqe6bkDYOuS4Iw8KgTcq2K8fyoy+k5l+j1qZ89iuk1uh2+MKQAQ92uGALCy2d
         w1dJY/pJglSX+ORc0keyA1nxuv+FIFACypN3ibkes7tCiwmkrf6QHNaRUsII7aKhRN+r
         mTvlNNteJLrWPgUMVR9BIas9pgfxCjkuhqCxunhng3YVG+JmaeoNy9fPK/iWaQbKnHXz
         ARyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220952; x=1784825752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Fr+Uh9XsP2RNYFyRiGxv3KLCqkx0t/U3XR3B+wxXns=;
        b=XpEhenUjLDCa3DN+yms0iz8BTWcQYr5eLcGZbu6gzFFXXjhZ3b/1giIl7Ozo5EwxfE
         fh0FYgEOH1ZuGXGyGwE9kgcXr+4dfyll+EtBdxHzqmHxAIm1+Tf7CjFnED1uqevzP//u
         i+x5AUforObmTbJOUs7jGnrGKtEphEiligkikt4q6qWZZEr8dvjzKmX+zHNnYWCmwdGB
         uIo2uh4PJdfv5CP1Hacz0mudYJYSOk3r92Vw/O8vRcHp474YgZDy2pE49DZcfZDVryCh
         5BVwWo4m7Ad2kSuU817hks6MdyCXMT3+hHZ69oC6I/UfK2kJGYXpOTp0RX9EAOtZlPdk
         nihg==
X-Gm-Message-State: AOJu0YyOiMtqSWnQF/Q1QxJx/3gv+MD5uL1hs0dh2PpTEsMEMaTkHxAe
	2zvTMWRn66w/sGlaAX/Pkyp+XJba1PStYsM2mf8YbaaVpcdqAMBnkAqLnn5lQUuBEYU=
X-Gm-Gg: AfdE7cnRr1jVLSQQ/wqRaAsR+7ud7zGb0tpM0u0uP9J3smGRPaUyTXAXp4ojHiNjKPv
	6PtXoMMU5qVeqz8XYwrqlHFQkD/vf704xwZL7uFSHAxxQtcMa4xr0MbO8VdwBgzpn1hXmxPoWJA
	xHW/OXA9FRUe6nWi4pBikw2+BmDTk7v2fI4WEU4w083IcKjyUPejH6Q3RYXU/0iMhb03MZy92pk
	RsA65ApOJVfbgTteiravaK+KNkE74Tg3ERK5QbsruGfXAOetXYhpd1zKNhfD/YgAQ9b40wGkrHz
	6JsIaQmacNzrluUEL6c4Ob3OSMc6qrAzDHDAD0Yo+mGt7Zd6fM20dtj8Fd5q2sawylXlQNBbG1f
	96EYY9eLyESJyhqVTI+D25qkXr0XlgPezwO9gCY7VH51HHbdKAlZvodJBM9FEiJ8MArx/M1d+xe
	mT9ByveJqMiAV0r4nIMQNSfEbw6CbwGxOQP49HekophnIqytiKyekpUW+k23itNHksmF8JZlVUv
	a5VygFMebtfa3fbAepCY8eWG5BB
X-Received: by 2002:a05:6402:4286:b0:698:585c:f07b with SMTP id 4fb4d7f45d1cf-69e198a7038mr4857541a12.3.1784220952329;
        Thu, 16 Jul 2026 09:55:52 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2937527sm5017149a12.20.2026.07.16.09.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:50 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/7] fast-import: introduce 'struct fast_import_state'
Date: Thu, 16 Jul 2026 18:55:15 +0200
Message-ID: <20260716165517.433849-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.185.g9120d2b5c0
In-Reply-To: <20260716165517.433849-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"builtin/fast-import.c" uses a large number of global variables. This
makes it harder than necessary to reason about and improve. Especially
adding new features requires adding more global variables, while
modernizing and eventually libifying the code becomes more and more
difficult.

To start reverting the sad trend to more and more globals and to start
cleaning things up, let's introduce a 'struct fast_import_state' and
pass an instance of it as the first argument to many functions.

This is similar to what was done for "builtin/apply.c" by introducing a
'struct apply_state', see 07d7e290ff (apply: move 'struct apply_state'
to a header file, 2016-08-11) and related commits.

As a first step only the 'global_argc', 'global_argv' and
'global_prefix' variables are moved into the new struct. More variables
will be moved into it in the following commits.

Some functions receive the new 'state' parameter only to pass it
along or for future use, so they are marked with UNUSED for now to
satisfy '-Werror=unused-parameter'.

This is a mostly mechanical refactoring with no intended behavior
change.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-import.c | 262 ++++++++++++++++++++++--------------------
 1 file changed, 138 insertions(+), 124 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index fd4e13b7ca..d20353679a 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -184,10 +184,6 @@ static int failure;
 static FILE *pack_edges;
 static unsigned int show_stats = 1;
 static unsigned int quiet;
-static int global_argc;
-static const char **global_argv;
-static const char *global_prefix;
-
 static enum sign_mode signed_tag_mode = SIGN_VERBATIM;
 static enum sign_mode signed_commit_mode = SIGN_VERBATIM;
 static const char *signed_commit_keyid;
@@ -276,10 +272,27 @@ static kh_oid_map_t *sub_oid_map;
 /* Where to write output of cat-blob commands */
 static int cat_blob_fd = STDOUT_FILENO;
 
-static void parse_argv(void);
-static void parse_get_mark(const char *p);
-static void parse_cat_blob(const char *p);
-static void parse_ls(const char *p, struct branch *b);
+/* Command state */
+struct fast_import_state {
+	int argc;
+	const char **argv;
+	const char *prefix;
+};
+
+static void fast_import_state_init(struct fast_import_state *state,
+				   int argc, const char **argv,
+				   const char *prefix)
+{
+	memset(state, 0, sizeof(*state));
+	state->argc = argc;
+	state->argv = argv;
+	state->prefix = prefix;
+}
+
+static void parse_argv(struct fast_import_state *state);
+static void parse_get_mark(struct fast_import_state *state, const char *p);
+static void parse_cat_blob(struct fast_import_state *state, const char *p);
+static void parse_ls(struct fast_import_state *state, const char *p, struct branch *b);
 
 static void for_each_mark(struct mark_set *m, uintmax_t base, each_mark_fn_t callback, void *p)
 {
@@ -1844,7 +1857,7 @@ static void read_marks(void)
 }
 
 
-static int read_next_command(void)
+static int read_next_command(struct fast_import_state *state)
 {
 	static int stdin_eof = 0;
 
@@ -1866,7 +1879,7 @@ static int read_next_command(void)
 			if (!seen_data_command
 				&& !starts_with(command_buf.buf, "feature ")
 				&& !starts_with(command_buf.buf, "option ")) {
-				parse_argv();
+				parse_argv(state);
 			}
 
 			rc = rc_free;
@@ -1898,22 +1911,22 @@ static void skip_optional_lf(void)
 		ungetc(term_char, stdin);
 }
 
-static void parse_mark(void)
+static void parse_mark(struct fast_import_state *state)
 {
 	const char *v;
 	if (skip_prefix(command_buf.buf, "mark :", &v)) {
 		next_mark = strtoumax(v, NULL, 10);
-		read_next_command();
+		read_next_command(state);
 	}
 	else
 		next_mark = 0;
 }
 
-static void parse_original_identifier(void)
+static void parse_original_identifier(struct fast_import_state *state)
 {
 	const char *v;
 	if (skip_prefix(command_buf.buf, "original-oid ", &v))
-		read_next_command();
+		read_next_command(state);
 }
 
 static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
@@ -2067,11 +2080,11 @@ static void parse_and_store_blob(
 	}
 }
 
-static void parse_new_blob(void)
+static void parse_new_blob(struct fast_import_state *state)
 {
-	read_next_command();
-	parse_mark();
-	parse_original_identifier();
+	read_next_command(state);
+	parse_mark(state);
+	parse_original_identifier(state);
 	parse_and_store_blob(&last_blob, NULL, next_mark);
 }
 
@@ -2367,7 +2380,7 @@ static void parse_path_space(struct strbuf *sb, const char *p,
 	(*endp)++;
 }
 
-static void file_change_m(const char *p, struct branch *b)
+static void file_change_m(struct fast_import_state *state, const char *p, struct branch *b)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct object_entry *oe;
@@ -2434,10 +2447,10 @@ static void file_change_m(const char *p, struct branch *b)
 		if (S_ISDIR(mode))
 			die(_("directories cannot be specified 'inline': %s"),
 				command_buf.buf);
-		while (read_next_command() != EOF) {
+		while (read_next_command(state) != EOF) {
 			const char *v;
 			if (skip_prefix(command_buf.buf, "cat-blob ", &v))
-				parse_cat_blob(v);
+				parse_cat_blob(state, v);
 			else {
 				parse_and_store_blob(&last_blob, &oid, 0);
 				break;
@@ -2511,7 +2524,7 @@ static void file_change_cr(const char *p, struct branch *b, int rename)
 		leaf.tree);
 }
 
-static void note_change_n(const char *p, struct branch *b, unsigned char *old_fanout)
+static void note_change_n(struct fast_import_state *state, const char *p, struct branch *b, unsigned char *old_fanout)
 {
 	struct object_entry *oe;
 	struct branch *s;
@@ -2576,7 +2589,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		die(_("invalid ref name or SHA1 expression: %s"), p);
 
 	if (inline_data) {
-		read_next_command();
+		read_next_command(state);
 		parse_and_store_blob(&last_blob, &oid, 0);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
@@ -2643,7 +2656,7 @@ static void parse_from_existing(struct branch *b)
 	}
 }
 
-static int parse_objectish(struct branch *b, const char *objectish)
+static int parse_objectish(struct fast_import_state *state, struct branch *b, const char *objectish)
 {
 	struct branch *s;
 	struct object_id oid;
@@ -2686,31 +2699,31 @@ static int parse_objectish(struct branch *b, const char *objectish)
 		b->branch_tree.tree = NULL;
 	}
 
-	read_next_command();
+	read_next_command(state);
 	return 1;
 }
 
-static int parse_from(struct branch *b)
+static int parse_from(struct fast_import_state *state, struct branch *b)
 {
 	const char *from;
 
 	if (!skip_prefix(command_buf.buf, "from ", &from))
 		return 0;
 
-	return parse_objectish(b, from);
+	return parse_objectish(state, b, from);
 }
 
-static int parse_objectish_with_prefix(struct branch *b, const char *prefix)
+static int parse_objectish_with_prefix(struct fast_import_state *state, struct branch *b, const char *prefix)
 {
 	const char *base;
 
 	if (!skip_prefix(command_buf.buf, prefix, &base))
 		return 0;
 
-	return parse_objectish(b, base);
+	return parse_objectish(state, b, base);
 }
 
-static struct hash_list *parse_merge(unsigned int *count)
+static struct hash_list *parse_merge(struct fast_import_state *state, unsigned int *count)
 {
 	struct hash_list *list = NULL, **tail = &list, *n;
 	const char *from;
@@ -2744,7 +2757,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 		tail = &n->next;
 
 		(*count)++;
-		read_next_command();
+		read_next_command(state);
 	}
 	return list;
 }
@@ -2755,7 +2768,7 @@ struct signature_data {
 	struct strbuf data;   /* The actual signature data */
 };
 
-static void parse_one_signature(struct signature_data *sig, const char *v)
+static void parse_one_signature(struct fast_import_state *state, struct signature_data *sig, const char *v)
 {
 	char *args = xstrdup(v); /* Will be freed when sig->hash_algo is freed */
 	char *space = strchr(args, ' ');
@@ -2780,15 +2793,15 @@ static void parse_one_signature(struct signature_data *sig, const char *v)
 		warning(_("'unknown' signature format in gpgsig"));
 
 	/* Read signature data */
-	read_next_command();
+	read_next_command(state);
 	parse_data(&sig->data, 0, NULL);
 }
 
-static void discard_one_signature(void)
+static void discard_one_signature(struct fast_import_state *state)
 {
 	struct strbuf data = STRBUF_INIT;
 
-	read_next_command();
+	read_next_command(state);
 	parse_data(&data, 0, NULL);
 	strbuf_release(&data);
 }
@@ -2826,13 +2839,14 @@ static void store_signature(struct signature_data *stored_sig,
 	}
 }
 
-static void import_one_signature(struct signature_data *sig_sha1,
+static void import_one_signature(struct fast_import_state *state,
+				 struct signature_data *sig_sha1,
 				 struct signature_data *sig_sha256,
 				 const char *v)
 {
 	struct signature_data sig = { NULL, NULL, STRBUF_INIT };
 
-	parse_one_signature(&sig, v);
+	parse_one_signature(state, &sig, v);
 
 	if (!strcmp(sig.hash_algo, "sha1"))
 		store_signature(sig_sha1, &sig, "SHA-1");
@@ -2946,7 +2960,7 @@ static void handle_signature_if_invalid(struct strbuf *new_data,
 	strbuf_release(&tmp_buf);
 }
 
-static void parse_new_commit(const char *arg)
+static void parse_new_commit(struct fast_import_state *state, const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
 	struct signature_data sig_sha1 = { NULL, NULL, STRBUF_INIT };
@@ -2964,16 +2978,16 @@ static void parse_new_commit(const char *arg)
 	if (!b)
 		b = new_branch(arg);
 
-	read_next_command();
-	parse_mark();
-	parse_original_identifier();
+	read_next_command(state);
+	parse_mark(state);
+	parse_original_identifier(state);
 	if (skip_prefix(command_buf.buf, "author ", &v)) {
 		author = parse_ident(v);
-		read_next_command();
+		read_next_command(state);
 	}
 	if (skip_prefix(command_buf.buf, "committer ", &v)) {
 		committer = parse_ident(v);
-		read_next_command();
+		read_next_command(state);
 	}
 	if (!committer)
 		die(_("expected committer but didn't get one"));
@@ -2989,7 +3003,7 @@ static void parse_new_commit(const char *arg)
 			warning(_("stripping a commit signature"));
 			/* fallthru */
 		case SIGN_STRIP:
-			discard_one_signature();
+			discard_one_signature(state);
 			break;
 
 		/* Second, modes that parse the signature */
@@ -3000,24 +3014,24 @@ static void parse_new_commit(const char *arg)
 		case SIGN_STRIP_IF_INVALID:
 		case SIGN_SIGN_IF_INVALID:
 		case SIGN_ABORT_IF_INVALID:
-			import_one_signature(&sig_sha1, &sig_sha256, v);
+			import_one_signature(state, &sig_sha1, &sig_sha256, v);
 			break;
 
 		/* Third, BUG */
 		default:
 			BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 		}
-		read_next_command();
+		read_next_command(state);
 	}
 
 	if (skip_prefix(command_buf.buf, "encoding ", &v)) {
 		encoding = xstrdup(v);
-		read_next_command();
+		read_next_command(state);
 	}
 	parse_data(&msg, 0, NULL);
-	read_next_command();
-	parse_from(b);
-	merge_list = parse_merge(&merge_count);
+	read_next_command(state);
+	parse_from(state, b);
+	merge_list = parse_merge(state, &merge_count);
 
 	/* ensure the branch is active/loaded */
 	if (!b->branch_tree.tree || !max_active_branches) {
@@ -3030,7 +3044,7 @@ static void parse_new_commit(const char *arg)
 	/* file_change* */
 	while (command_buf.len > 0) {
 		if (skip_prefix(command_buf.buf, "M ", &v))
-			file_change_m(v, b);
+			file_change_m(state, v, b);
 		else if (skip_prefix(command_buf.buf, "D ", &v))
 			file_change_d(v, b);
 		else if (skip_prefix(command_buf.buf, "R ", &v))
@@ -3038,18 +3052,18 @@ static void parse_new_commit(const char *arg)
 		else if (skip_prefix(command_buf.buf, "C ", &v))
 			file_change_cr(v, b, 0);
 		else if (skip_prefix(command_buf.buf, "N ", &v))
-			note_change_n(v, b, &prev_fanout);
+			note_change_n(state, v, b, &prev_fanout);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
 		else if (skip_prefix(command_buf.buf, "ls ", &v))
-			parse_ls(v, b);
+			parse_ls(state, v, b);
 		else if (skip_prefix(command_buf.buf, "cat-blob ", &v))
-			parse_cat_blob(v);
+			parse_cat_blob(state, v);
 		else {
 			unread_command_buf = 1;
 			break;
 		}
-		if (read_next_command() == EOF)
+		if (read_next_command(state) == EOF)
 			break;
 	}
 
@@ -3187,7 +3201,7 @@ static void handle_tag_signature(struct strbuf *buf, struct strbuf *msg, const c
 	}
 }
 
-static void parse_new_tag(const char *arg)
+static void parse_new_tag(struct fast_import_state *state, const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
 	const char *from;
@@ -3206,8 +3220,8 @@ static void parse_new_tag(const char *arg)
 	else
 		first_tag = t;
 	last_tag = t;
-	read_next_command();
-	parse_mark();
+	read_next_command(state);
+	parse_mark(state);
 
 	/* from ... */
 	if (!skip_prefix(command_buf.buf, "from ", &from))
@@ -3235,15 +3249,15 @@ static void parse_new_tag(const char *arg)
 			type = oe->type;
 	} else
 		die(_("invalid ref name or SHA1 expression: %s"), from);
-	read_next_command();
+	read_next_command(state);
 
 	/* original-oid ... */
-	parse_original_identifier();
+	parse_original_identifier(state);
 
 	/* tagger ... */
 	if (skip_prefix(command_buf.buf, "tagger ", &v)) {
 		tagger = parse_ident(v);
-		read_next_command();
+		read_next_command(state);
 	} else
 		tagger = NULL;
 
@@ -3274,7 +3288,7 @@ static void parse_new_tag(const char *arg)
 		t->pack_id = pack_id;
 }
 
-static void parse_reset_branch(const char *arg)
+static void parse_reset_branch(struct fast_import_state *state, const char *arg)
 {
 	struct branch *b;
 	const char *tag_name;
@@ -3291,8 +3305,8 @@ static void parse_reset_branch(const char *arg)
 	}
 	else
 		b = new_branch(arg);
-	read_next_command();
-	parse_from(b);
+	read_next_command(state);
+	parse_from(state, b);
 	if (b->delete && skip_prefix(b->name, "refs/tags/", &tag_name)) {
 		/*
 		 * Elsewhere, we call dump_branches() before dump_tags(),
@@ -3377,7 +3391,7 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 		free(buf);
 }
 
-static void parse_get_mark(const char *p)
+static void parse_get_mark(struct fast_import_state *state UNUSED, const char *p)
 {
 	struct object_entry *oe;
 	char output[GIT_MAX_HEXSZ + 2];
@@ -3394,7 +3408,7 @@ static void parse_get_mark(const char *p)
 	cat_blob_write(output, the_hash_algo->hexsz + 1);
 }
 
-static void parse_cat_blob(const char *p)
+static void parse_cat_blob(struct fast_import_state *state UNUSED, const char *p)
 {
 	struct object_entry *oe;
 	struct object_id oid;
@@ -3559,7 +3573,7 @@ static void print_ls(int mode, const unsigned char *hash, const char *path)
 	cat_blob_write(line.buf, line.len);
 }
 
-static void parse_ls(const char *p, struct branch *b)
+static void parse_ls(struct fast_import_state *state UNUSED, const char *p, struct branch *b)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct tree_entry *root = NULL;
@@ -3606,13 +3620,13 @@ static void checkpoint(void)
 	dump_marks();
 }
 
-static void parse_checkpoint(void)
+static void parse_checkpoint(struct fast_import_state *state UNUSED)
 {
 	checkpoint_requested = 1;
 	skip_optional_lf();
 }
 
-static void parse_progress(void)
+static void parse_progress(struct fast_import_state *state UNUSED)
 {
 	fwrite(command_buf.buf, 1, command_buf.len, stdout);
 	fputc('\n', stdout);
@@ -3620,36 +3634,36 @@ static void parse_progress(void)
 	skip_optional_lf();
 }
 
-static void parse_alias(void)
+static void parse_alias(struct fast_import_state *state)
 {
 	struct object_entry *e;
 	struct branch b;
 
 	skip_optional_lf();
-	read_next_command();
+	read_next_command(state);
 
 	/* mark ... */
-	parse_mark();
+	parse_mark(state);
 	if (!next_mark)
 		die(_("expected 'mark' command, got %s"), command_buf.buf);
 
 	/* to ... */
 	memset(&b, 0, sizeof(b));
-	if (!parse_objectish_with_prefix(&b, "to "))
+	if (!parse_objectish_with_prefix(state, &b, "to "))
 		die(_("expected 'to' command, got %s"), command_buf.buf);
 	e = find_object(&b.oid);
 	assert(e);
 	insert_mark(&marks, next_mark, e);
 }
 
-static char* make_fast_import_path(const char *path)
+static char* make_fast_import_path(struct fast_import_state *state, const char *path)
 {
 	if (!relative_marks_paths || is_absolute_path(path))
-		return prefix_filename(global_prefix, path);
+		return prefix_filename(state->prefix, path);
 	return repo_git_path(the_repository, "info/fast-import/%s", path);
 }
 
-static void option_import_marks(const char *marks,
+static void option_import_marks(struct fast_import_state *state, const char *marks,
 					int from_stream, int ignore_missing)
 {
 	if (import_marks_file) {
@@ -3662,7 +3676,7 @@ static void option_import_marks(const char *marks,
 	}
 
 	free(import_marks_file);
-	import_marks_file = make_fast_import_path(marks);
+	import_marks_file = make_fast_import_path(state, marks);
 	import_marks_file_from_stream = from_stream;
 	import_marks_file_ignore_missing = ignore_missing;
 }
@@ -3702,13 +3716,13 @@ static void option_active_branches(const char *branches)
 	max_active_branches = ulong_arg("--active-branches", branches);
 }
 
-static void option_export_marks(const char *marks)
+static void option_export_marks(struct fast_import_state *state, const char *marks)
 {
 	free(export_marks_file);
-	export_marks_file = make_fast_import_path(marks);
+	export_marks_file = make_fast_import_path(state, marks);
 }
 
-static void option_cat_blob_fd(const char *fd)
+static void option_cat_blob_fd(struct fast_import_state *state UNUSED, const char *fd)
 {
 	unsigned long n = ulong_arg("--cat-blob-fd", fd);
 	if (n > (unsigned long) INT_MAX)
@@ -3716,16 +3730,16 @@ static void option_cat_blob_fd(const char *fd)
 	cat_blob_fd = (int) n;
 }
 
-static void option_export_pack_edges(const char *edges)
+static void option_export_pack_edges(struct fast_import_state *state, const char *edges)
 {
-	char *fn = prefix_filename(global_prefix, edges);
+	char *fn = prefix_filename(state->prefix, edges);
 	if (pack_edges)
 		fclose(pack_edges);
 	pack_edges = xfopen(fn, "a");
 	free(fn);
 }
 
-static void option_rewrite_submodules(const char *arg, struct string_list *list)
+static void option_rewrite_submodules(struct fast_import_state *state, const char *arg, struct string_list *list)
 {
 	struct mark_set *ms;
 	FILE *fp;
@@ -3737,7 +3751,7 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	f++;
 	CALLOC_ARRAY(ms, 1);
 
-	f = prefix_filename(global_prefix, f);
+	f = prefix_filename(state->prefix, f);
 	fp = fopen(f, "r");
 	if (!fp)
 		die_errno(_("cannot read '%s'"), f);
@@ -3750,7 +3764,7 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	free(s);
 }
 
-static int parse_one_option(const char *option)
+static int parse_one_option(struct fast_import_state *state, const char *option)
 {
 	if (skip_prefix(option, "max-pack-size=", &option)) {
 		unsigned long v;
@@ -3774,7 +3788,7 @@ static int parse_one_option(const char *option)
 	} else if (skip_prefix(option, "active-branches=", &option)) {
 		option_active_branches(option);
 	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
-		option_export_pack_edges(option);
+		option_export_pack_edges(state, option);
 	} else if (skip_prefix(option, "signed-commits=", &option)) {
 		if (parse_sign_mode(option, &signed_commit_mode, &signed_commit_keyid))
 			usagef(_("unknown --signed-commits mode '%s'"), option);
@@ -3795,34 +3809,34 @@ static int parse_one_option(const char *option)
 	return 1;
 }
 
-static void check_unsafe_feature(const char *feature, int from_stream)
+static void check_unsafe_feature(struct fast_import_state *state UNUSED, const char *feature, int from_stream)
 {
 	if (from_stream && !allow_unsafe_features)
 		die(_("feature '%s' forbidden in input without --allow-unsafe-features"),
 		    feature);
 }
 
-static int parse_one_feature(const char *feature, int from_stream)
+static int parse_one_feature(struct fast_import_state *state, const char *feature, int from_stream)
 {
 	const char *arg;
 
 	if (skip_prefix(feature, "date-format=", &arg)) {
 		option_date_format(arg);
 	} else if (skip_prefix(feature, "import-marks=", &arg)) {
-		check_unsafe_feature("import-marks", from_stream);
-		option_import_marks(arg, from_stream, 0);
+		check_unsafe_feature(state, "import-marks", from_stream);
+		option_import_marks(state, arg, from_stream, 0);
 	} else if (skip_prefix(feature, "import-marks-if-exists=", &arg)) {
-		check_unsafe_feature("import-marks-if-exists", from_stream);
-		option_import_marks(arg, from_stream, 1);
+		check_unsafe_feature(state, "import-marks-if-exists", from_stream);
+		option_import_marks(state, arg, from_stream, 1);
 	} else if (skip_prefix(feature, "export-marks=", &arg)) {
-		check_unsafe_feature(feature, from_stream);
-		option_export_marks(arg);
+		check_unsafe_feature(state, feature, from_stream);
+		option_export_marks(state, arg);
 	} else if (!strcmp(feature, "alias")) {
 		; /* Don't die - this feature is supported */
 	} else if (skip_prefix(feature, "rewrite-submodules-to=", &arg)) {
-		option_rewrite_submodules(arg, &sub_marks_to);
+		option_rewrite_submodules(state, arg, &sub_marks_to);
 	} else if (skip_prefix(feature, "rewrite-submodules-from=", &arg)) {
-		option_rewrite_submodules(arg, &sub_marks_from);
+		option_rewrite_submodules(state, arg, &sub_marks_from);
 	} else if (!strcmp(feature, "get-mark")) {
 		; /* Don't die - this feature is supported */
 	} else if (!strcmp(feature, "cat-blob")) {
@@ -3844,23 +3858,23 @@ static int parse_one_feature(const char *feature, int from_stream)
 	return 1;
 }
 
-static void parse_feature(const char *feature)
+static void parse_feature(struct fast_import_state *state, const char *feature)
 {
 	if (seen_data_command)
 		die(_("got feature command '%s' after data command"), feature);
 
-	if (parse_one_feature(feature, 1))
+	if (parse_one_feature(state, feature, 1))
 		return;
 
 	die(_("this version of fast-import does not support feature %s."), feature);
 }
 
-static void parse_option(const char *option)
+static void parse_option(struct fast_import_state *state, const char *option)
 {
 	if (seen_data_command)
 		die(_("got option command '%s' after data command"), option);
 
-	if (parse_one_option(option))
+	if (parse_one_option(state, option))
 		return;
 
 	die(_("this version of fast-import does not support option: %s"), option);
@@ -3896,12 +3910,12 @@ static void git_pack_config(void)
 static const char fast_import_usage[] =
 "git fast-import [--date-format=<f>] [--max-pack-size=<n>] [--big-file-threshold=<n>] [--depth=<n>] [--active-branches=<n>] [--export-marks=<marks.file>]";
 
-static void parse_argv(void)
+static void parse_argv(struct fast_import_state *state)
 {
 	unsigned int i;
 
-	for (i = 1; i < global_argc; i++) {
-		const char *a = global_argv[i];
+	for (i = 1; i < state->argc; i++) {
+		const char *a = state->argv[i];
 
 		if (*a != '-' || !strcmp(a, "--"))
 			break;
@@ -3909,20 +3923,20 @@ static void parse_argv(void)
 		if (!skip_prefix(a, "--", &a))
 			die(_("unknown option %s"), a);
 
-		if (parse_one_option(a))
+		if (parse_one_option(state, a))
 			continue;
 
-		if (parse_one_feature(a, 0))
+		if (parse_one_feature(state, a, 0))
 			continue;
 
 		if (skip_prefix(a, "cat-blob-fd=", &a)) {
-			option_cat_blob_fd(a);
+			option_cat_blob_fd(state, a);
 			continue;
 		}
 
 		die(_("unknown option --%s"), a);
 	}
-	if (i != global_argc)
+	if (i != state->argc)
 		usage(fast_import_usage);
 
 	seen_data_command = 1;
@@ -3936,6 +3950,8 @@ int cmd_fast_import(int argc,
 		    const char *prefix,
 		    struct repository *repo)
 {
+	struct fast_import_state state;
+
 	show_usage_if_asked(argc, argv, fast_import_usage);
 
 	reset_pack_idx_option(&pack_idx_opts);
@@ -3964,9 +3980,7 @@ int cmd_fast_import(int argc,
 			allow_unsafe_features = 1;
 	}
 
-	global_argc = argc;
-	global_argv = argv;
-	global_prefix = prefix;
+	fast_import_state_init(&state, argc, argv, prefix);
 
 	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
 	for (unsigned int i = 0; i < (cmd_save - 1); i++)
@@ -3976,34 +3990,34 @@ int cmd_fast_import(int argc,
 	start_packfile();
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
-	while (read_next_command() != EOF) {
+	while (read_next_command(&state) != EOF) {
 		const char *v;
 		if (!strcmp("blob", command_buf.buf))
-			parse_new_blob();
+			parse_new_blob(&state);
 		else if (skip_prefix(command_buf.buf, "commit ", &v))
-			parse_new_commit(v);
+			parse_new_commit(&state, v);
 		else if (skip_prefix(command_buf.buf, "tag ", &v))
-			parse_new_tag(v);
+			parse_new_tag(&state, v);
 		else if (skip_prefix(command_buf.buf, "reset ", &v))
-			parse_reset_branch(v);
+			parse_reset_branch(&state, v);
 		else if (skip_prefix(command_buf.buf, "ls ", &v))
-			parse_ls(v, NULL);
+			parse_ls(&state, v, NULL);
 		else if (skip_prefix(command_buf.buf, "cat-blob ", &v))
-			parse_cat_blob(v);
+			parse_cat_blob(&state, v);
 		else if (skip_prefix(command_buf.buf, "get-mark ", &v))
-			parse_get_mark(v);
+			parse_get_mark(&state, v);
 		else if (!strcmp("checkpoint", command_buf.buf))
-			parse_checkpoint();
+			parse_checkpoint(&state);
 		else if (!strcmp("done", command_buf.buf))
 			break;
 		else if (!strcmp("alias", command_buf.buf))
-			parse_alias();
+			parse_alias(&state);
 		else if (starts_with(command_buf.buf, "progress "))
-			parse_progress();
+			parse_progress(&state);
 		else if (skip_prefix(command_buf.buf, "feature ", &v))
-			parse_feature(v);
+			parse_feature(&state, v);
 		else if (skip_prefix(command_buf.buf, "option git ", &v))
-			parse_option(v);
+			parse_option(&state, v);
 		else if (starts_with(command_buf.buf, "option "))
 			/* ignore non-git options*/;
 		else
@@ -4015,7 +4029,7 @@ int cmd_fast_import(int argc,
 
 	/* argv hasn't been parsed yet, do so */
 	if (!seen_data_command)
-		parse_argv();
+		parse_argv(&state);
 
 	if (require_explicit_termination && feof(stdin))
 		die(_("stream ends early"));
-- 
2.55.0.185.g9120d2b5c0

