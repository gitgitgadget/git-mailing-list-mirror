Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975094C8B
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664153; cv=none; b=GUPoMY/AJpqikqjJ/t5p0iMhDuLfE5QFs47nmibIgS2NfpN75QAmzg5H3Ym0vyK2nJbDkal7BcOzeT4T/0EBJuxMy6JKmgLRx2cbl7gNYp+jveluEz8knptrXChaH5h8IpFpa0/Sh41jOY/p0fN5yBX66tKrbEOClDMQu1SvUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664153; c=relaxed/simple;
	bh=qD11dIUtmh9kRSMtA+SMDwCYtB3P4MWKWYsRkERDAuE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K7BnU3FubZ/uJ+2EZKwxDMITArQXfm9K3U1hfVU46rwa6AAHeDJvI0s3/sWoDzpGpykwha/5Nnk5rHslRlKB9FkvtkvoQE2wdQTvJ3Bun7Rh4H0BWE553Wv5DjOxDRy/E4yWQ67XAQHrUy8ESV1yiqISBNrojiS9e7Xk3vtglds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF2aEMQn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF2aEMQn"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ae3be1c37so197174f8f.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 17:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706664149; x=1707268949; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnHHQoR9/DDo6ct23yHBud4gJU5mZOnRADHbnIfxa4g=;
        b=TF2aEMQnVjsqeE+UHD9kLjZlwfrskXVA5QQQKYufwsO2bztRaSwKa0FIEryiacBgZc
         Tx5iF/E0wPOVN8BlhqeePvyz1sZyonQnos5Ojh4gAFAcZK/u32Ws92/h7ZrYls/EE95h
         lvDrRSwTSJBUvvVxPY72dGnr2Q8tWUuqxYBiIZWTEpnZQP/TvyEWREdvn+pXlpx7grqp
         glDL/VC+A5lEMJpNIJLRBr8QsXZi8LS0himhKecu821R35fqnZO7m1X9EhNT2UYsK5IZ
         Lnbqxp1MOZYEsJD6Wy93NdeiK2N1GmrOXmivSVkYgZV9vckdbBrtPSOYEBXKC3HkNtWT
         AOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706664149; x=1707268949;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnHHQoR9/DDo6ct23yHBud4gJU5mZOnRADHbnIfxa4g=;
        b=WAEnd2FiuPyqKikfnzGbFgEOBKGE+tJQqXC1sZtiZGx5hppZpTW26riTKt7/Ji7ebO
         u2ENG8kTSDe8mO92KRlxhxxNiorXKgFNMCnJcf8rUeeDAz6Vnlp57Y/HSsv5UpOCsc/x
         pIjK/sgCn1qyJ9IqhpSrCHG6TK9piLLsjXLAM4Jww87UKcfab2YCMUJHXjcYSyjupHtr
         WW8R3UWe8ANP7qNLVbTl87Kw9BoWRwsEuCmKQi0Tg4zxNN6EYUU3weEyBK951l3WrV2H
         t2G5L+ZLS+RZ/h4i+eddFwgfAtuIPprY40AAcEXoCyxm1PTOxm6zyga2mWVyCSy44g4S
         OjdQ==
X-Gm-Message-State: AOJu0YzElp20byoXkBljntiKIPhr0U3y5kTplcve+sDyJHeMOBaIQOdn
	hhrAsOMWWtz1qsbed4ZoHnCeNtj2Y70SH7/EaOyduVIrIjfi4QBLgd8TaTlP
X-Google-Smtp-Source: AGHT+IHwxtyHY/ONZ8YXDkHbIYTbbJwMP5Qye/UetWe7psOGoqjyLxa1awYBFLaPR4wImjXQIsur1g==
X-Received: by 2002:a5d:484c:0:b0:336:58e8:d444 with SMTP id n12-20020a5d484c000000b0033658e8d444mr2832820wrs.30.1706664149542;
        Tue, 30 Jan 2024 17:22:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay12-20020a5d6f0c000000b0033ad47d7b86sm12075982wrb.27.2024.01.30.17.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:22:28 -0800 (PST)
Message-ID: <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 01:22:17 +0000
Subject: [PATCH v3 03/10] trailer: unify trailer formatting machinery
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

Currently have two functions for formatting trailers exposed in
trailer.h:

    void format_trailers(FILE *outfile, struct list_head *head,
                        const struct process_trailer_options *opts);

    void format_trailers_from_commit(struct strbuf *out, const char *msg,
                                    const struct process_trailer_options *opts);

and previously these functions, although similar enough (even taking the
same process_trailer_options struct pointer), did not build on each
other.

Make format_trailers_from_commit() rely on format_trailers(). Teach
format_trailers() to process trailers with the additional
process_trailer_options fields like opts->key_only which is only used by
format_trailers_from_commit() and not builtin/interpret-trailers.c.
While we're at it, reorder parameters to put the trailer processing
options first, and the out parameter (strbuf we write into) at the end.

This unification will allow us to delete the format_trailer_info() and
print_tok_val() functions in the next patch. They are not deleted here
in order to keep the diff small.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |   6 +-
 pretty.c                     |   2 +-
 ref-filter.c                 |   2 +-
 trailer.c                    | 176 +++++++++++++++++------------------
 trailer.h                    |  19 ++--
 5 files changed, 98 insertions(+), 107 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 8556acde4aa..5352ee65bd1 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -140,6 +140,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf trailer_block = STRBUF_INIT;
 	struct trailer_info info;
 	FILE *outfile = stdout;
 
@@ -169,7 +170,10 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 		process_trailers_lists(&head, &arg_head);
 	}
 
-	format_trailers(opts, &head, outfile);
+	/* Print trailer block. */
+	format_trailers(opts, &head, &trailer_block);
+	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
+	strbuf_release(&trailer_block);
 
 	free_trailers(&head);
 	trailer_info_release(&info);
diff --git a/pretty.c b/pretty.c
index cf964b060cd..bdbed4295aa 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1759,7 +1759,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				goto trailer_out;
 		}
 		if (*arg == ')') {
-			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
+			format_trailers_from_commit(&opts, msg + c->subject_off, sb);
 			ret = arg - placeholder + 1;
 		}
 	trailer_out:
diff --git a/ref-filter.c b/ref-filter.c
index 35b989e1dfe..d358953b0ce 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1985,7 +1985,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 			struct strbuf s = STRBUF_INIT;
 
 			/* Format the trailer info according to the trailer_opts given */
-			format_trailers_from_commit(&s, subpos, &atom->u.contents.trailer_opts);
+			format_trailers_from_commit(&atom->u.contents.trailer_opts, subpos, &s);
 
 			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_BARE)
diff --git a/trailer.c b/trailer.c
index d3899195876..71ea2bb67f8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -144,37 +144,6 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(FILE *outfile, const char *tok, const char *val)
-{
-	char c;
-
-	if (!tok) {
-		fprintf(outfile, "%s\n", val);
-		return;
-	}
-
-	c = last_non_space_char(tok);
-	if (!c)
-		return;
-	if (strchr(separators, c))
-		fprintf(outfile, "%s%s\n", tok, val);
-	else
-		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
-}
-
-void format_trailers(const struct process_trailer_options *opts,
-		     struct list_head *trailers, FILE *outfile)
-{
-	struct list_head *pos;
-	struct trailer_item *item;
-	list_for_each(pos, trailers) {
-		item = list_entry(pos, struct trailer_item, list);
-		if ((!opts->trim_empty || strlen(item->value) > 0) &&
-		    (!opts->only_trailers || item->token))
-			print_tok_val(outfile, item->token, item->value);
-	}
-}
-
 static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
 	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
@@ -984,6 +953,78 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
+void format_trailers(const struct process_trailer_options *opts,
+		     struct list_head *trailers,
+		     struct strbuf *out)
+{
+	struct list_head *pos;
+	struct trailer_item *item;
+	int need_separator = 0;
+
+	list_for_each(pos, trailers) {
+		item = list_entry(pos, struct trailer_item, list);
+		if (item->token) {
+			char c;
+
+			struct strbuf tok = STRBUF_INIT;
+			struct strbuf val = STRBUF_INIT;
+			strbuf_addstr(&tok, item->token);
+			strbuf_addstr(&val, item->value);
+
+			/*
+			 * Skip key/value pairs where the value was empty. This
+			 * can happen from trailers specified without a
+			 * separator, like `--trailer "Reviewed-by"` (no
+			 * corresponding value).
+			 */
+			if (opts->trim_empty && !strlen(item->value))
+				continue;
+
+			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
+				if (opts->unfold)
+					unfold_value(&val);
+
+				if (opts->separator && need_separator)
+					strbuf_addbuf(out, opts->separator);
+				if (!opts->value_only)
+					strbuf_addbuf(out, &tok);
+				if (!opts->key_only && !opts->value_only) {
+					if (opts->key_value_separator)
+						strbuf_addbuf(out, opts->key_value_separator);
+					else {
+						c = last_non_space_char(tok.buf);
+						if (c) {
+							if (!strchr(separators, c))
+								strbuf_addf(out, "%c ", separators[0]);
+						}
+					}
+				}
+				if (!opts->key_only)
+					strbuf_addbuf(out, &val);
+				if (!opts->separator)
+					strbuf_addch(out, '\n');
+
+				need_separator = 1;
+			}
+
+			strbuf_release(&tok);
+			strbuf_release(&val);
+		} else if (!opts->only_trailers) {
+			if (opts->separator && need_separator) {
+				strbuf_addbuf(out, opts->separator);
+			}
+			strbuf_addstr(out, item->value);
+			if (opts->separator)
+				strbuf_rtrim(out);
+			else
+				strbuf_addch(out, '\n');
+
+			need_separator = 1;
+		}
+
+	}
+}
+
 /*
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
@@ -1083,74 +1124,25 @@ void trailer_info_release(struct trailer_info *info)
 	free(info->trailers);
 }
 
-static void format_trailer_info(struct strbuf *out,
-				const struct trailer_info *info,
-				const char *msg,
-				const struct process_trailer_options *opts)
+void format_trailers_from_commit(const struct process_trailer_options *opts,
+				 const char *msg,
+				 struct strbuf *out)
 {
-	size_t origlen = out->len;
-	size_t i;
+	LIST_HEAD(head);
+	struct trailer_info info;
+
+	parse_trailers(opts, &info, msg, &head);
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info->trailer_block_start,
-			   info->trailer_block_end - info->trailer_block_start);
-		return;
-	}
-
-	for (i = 0; i < info->trailer_nr; i++) {
-		char *trailer = info->trailers[i];
-		ssize_t separator_pos = find_separator(trailer, separators);
-
-		if (separator_pos >= 1) {
-			struct strbuf tok = STRBUF_INIT;
-			struct strbuf val = STRBUF_INIT;
-
-			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
-			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
-				if (opts->unfold)
-					unfold_value(&val);
-
-				if (opts->separator && out->len != origlen)
-					strbuf_addbuf(out, opts->separator);
-				if (!opts->value_only)
-					strbuf_addbuf(out, &tok);
-				if (!opts->key_only && !opts->value_only) {
-					if (opts->key_value_separator)
-						strbuf_addbuf(out, opts->key_value_separator);
-					else
-						strbuf_addstr(out, ": ");
-				}
-				if (!opts->key_only)
-					strbuf_addbuf(out, &val);
-				if (!opts->separator)
-					strbuf_addch(out, '\n');
-			}
-			strbuf_release(&tok);
-			strbuf_release(&val);
-
-		} else if (!opts->only_trailers) {
-			if (opts->separator && out->len != origlen) {
-				strbuf_addbuf(out, opts->separator);
-			}
-			strbuf_addstr(out, trailer);
-			if (opts->separator) {
-				strbuf_rtrim(out);
-			}
-		}
-	}
-
-}
-
-void format_trailers_from_commit(struct strbuf *out, const char *msg,
-				 const struct process_trailer_options *opts)
-{
-	struct trailer_info info;
+		strbuf_add(out, msg + info.trailer_block_start,
+			   info.trailer_block_end - info.trailer_block_start);
+	} else
+		format_trailers(opts, &head, out);
 
-	trailer_info_get(&info, msg, opts);
-	format_trailer_info(out, &info, msg, opts);
+	free_trailers(&head);
 	trailer_info_release(&info);
 }
 
diff --git a/trailer.h b/trailer.h
index ca701c04f3b..244f29fc91f 100644
--- a/trailer.h
+++ b/trailer.h
@@ -101,22 +101,17 @@ void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
 void format_trailers(const struct process_trailer_options *opts,
-		     struct list_head *trailers, FILE *outfile);
+		     struct list_head *trailers,
+		     struct strbuf *out);
 void free_trailers(struct list_head *);
 
 /*
- * Format the trailers from the commit msg "msg" into the strbuf "out".
- * Note two caveats about "opts":
- *
- *   - this is primarily a helper for pretty.c, and not
- *     all of the flags are supported.
- *
- *   - this differs from process_trailers slightly in that we always format
- *     only the trailer block itself, even if the "only_trailers" option is not
- *     set.
+ * Convenience function to format the trailers from the commit msg "msg" into
+ * the strbuf "out". Reuses format_trailers internally.
  */
-void format_trailers_from_commit(struct strbuf *out, const char *msg,
-				 const struct process_trailer_options *opts);
+void format_trailers_from_commit(const struct process_trailer_options *opts,
+				 const char *msg,
+				 struct strbuf *out);
 
 /*
  * An interface for iterating over the trailers found in a particular commit
-- 
gitgitgadget

