Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E82364CF
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr6IDkwp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33677fb38a3so3793096f8f.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 22:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704869491; x=1705474291; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbYL5BD29oUaC8ih/ccgcKd52IkYxSzaOeYYLFNhE9U=;
        b=Rr6IDkwpQnCyOFtAqec/S62SUZIQNFnXENTNu74YI2gk3Oswpdd+3dBCJeWiai8GSI
         0i7D1yyU8GqYJbONGRAxBRpBpkrzCb5O0Af+68V57dGpYhgz1VjCf00tF0Gr1K14Kh6J
         Kj738npIxFeeeasiepZhj/D/gX2YVezChaWSnVIFcTq4ekHgiyph/L0IOTcOkVXZrKDK
         OpQBs8ZJei0uPSPW3ce2odLxnZ00MlMcUSUJWf428Y3aSs09/6h25zz1imoa+9A1caUb
         YTg8Zyye5Lkpjh4lB6fxRAJsJUlFqxuAry+9zUuvtdqTCkaV9qQbS5rvlYeK+VCgzTx9
         DyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869491; x=1705474291;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbYL5BD29oUaC8ih/ccgcKd52IkYxSzaOeYYLFNhE9U=;
        b=q17n8zOxbIQsS4ZEFZSl20qbk75c6xW/fIKKRW9sKQhqutCebCbz19FCT5UD6TRLR5
         NeCYEPAVYEyraOj+zCfysLTjpEZ9lBd9Od7fE9jw7GBnYcHgyNsYTo63PYtZwUmqYmnF
         7ExnUs1cVOZ/v0FzRguH+nyb4XxfIHORtE+2ThX+nQ8kfz7ugsIcUFpZ7jA6PWWZgu70
         epQZKj2bZxnlXgXA6PQln0jpUpYyUZzAKiYAB9GDSeur962sYWGFRbyT7FpYzlvCR1KX
         I5Jlgu0Zc+xD/cActRvTaWs/QDsl79kCDGM8AQ50v9v6NqO53QtozpuJy/xUI6EVCoJ8
         wLzA==
X-Gm-Message-State: AOJu0YzPVQaAhQRz0jMVpALagZ3zJbX4dw4gVfLTpNPkyZ+W5KO+zHVr
	3+qNp30/raSThCcnPzNdzAYn8EKzV6s=
X-Google-Smtp-Source: AGHT+IFwI7thYF7n+CMVs9/WcvPYnyM9IGWBDerhnldiqHy5ZC15VzsAAi/MDV54f1Z458q+Q/Bxqw==
X-Received: by 2002:a05:6000:2c1:b0:336:ca94:3e00 with SMTP id o1-20020a05600002c100b00336ca943e00mr282570wry.69.1704869490851;
        Tue, 09 Jan 2024 22:51:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020adffcd0000000b003373ef060d5sm4070464wrs.113.2024.01.09.22.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:51:30 -0800 (PST)
Message-ID: <d3326021fb6a63707e4ce56f166447143f4e55a2.1704869487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 06:51:19 +0000
Subject: [PATCH 03/10] trailer: unify trailer formatting machinery
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
Cc: Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Christian Couder <chriscool@tuxfamily.org>,
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

This will allow us to delete the format_trailer_info() and
print_tok_val() functions in the next patch. They are not deleted here
in order to keep the diff small.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |   5 +-
 pretty.c                     |   2 +-
 ref-filter.c                 |   2 +-
 trailer.c                    | 105 +++++++++++++++++++++++++++++------
 trailer.h                    |  21 +++----
 5 files changed, 102 insertions(+), 33 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index adb74276281..934833a4645 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -140,6 +140,7 @@ static void interpret_trailers(const char *file,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf trailer_block = STRBUF_INIT;
 	struct trailer_info info;
 	FILE *outfile = stdout;
 
@@ -170,7 +171,9 @@ static void interpret_trailers(const char *file,
 	}
 
 	/* Print trailer block. */
-	format_trailers(outfile, &head, opts);
+	format_trailers(&head, opts, &trailer_block);
+	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
+	strbuf_release(&trailer_block);
 
 	free_trailers(&head);
 	trailer_info_release(&info);
diff --git a/pretty.c b/pretty.c
index cf964b060cd..f0721a5214f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1759,7 +1759,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				goto trailer_out;
 		}
 		if (*arg == ')') {
-			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
+			format_trailers_from_commit(msg + c->subject_off, &opts, sb);
 			ret = arg - placeholder + 1;
 		}
 	trailer_out:
diff --git a/ref-filter.c b/ref-filter.c
index 35b989e1dfe..7fb13818686 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1985,7 +1985,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 			struct strbuf s = STRBUF_INIT;
 
 			/* Format the trailer info according to the trailer_opts given */
-			format_trailers_from_commit(&s, subpos, &atom->u.contents.trailer_opts);
+			format_trailers_from_commit(subpos, &atom->u.contents.trailer_opts, &s);
 
 			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_BARE)
diff --git a/trailer.c b/trailer.c
index 0ce7e9079ca..315d90ee1ab 100644
--- a/trailer.c
+++ b/trailer.c
@@ -162,19 +162,6 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-void format_trailers(FILE *outfile, struct list_head *head,
-		     const struct process_trailer_options *opts)
-{
-	struct list_head *pos;
-	struct trailer_item *item;
-	list_for_each(pos, head) {
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
@@ -984,6 +971,78 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
+void format_trailers(struct list_head *head,
+		     const struct process_trailer_options *opts,
+		     struct strbuf *out)
+{
+	struct list_head *pos;
+	struct trailer_item *item;
+	int need_separator = 0;
+
+	list_for_each(pos, head) {
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
@@ -1144,13 +1203,25 @@ static void format_trailer_info(struct strbuf *out,
 
 }
 
-void format_trailers_from_commit(struct strbuf *out, const char *msg,
-				 const struct process_trailer_options *opts)
+void format_trailers_from_commit(const char *msg,
+				 const struct process_trailer_options *opts,
+				 struct strbuf *out)
 {
+	LIST_HEAD(head);
 	struct trailer_info info;
 
-	trailer_info_get(&info, msg, opts);
-	format_trailer_info(out, &info, msg, opts);
+	parse_trailers(&info, msg, &head, opts);
+
+	/* If we want the whole block untouched, we can take the fast path. */
+	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
+	    !opts->separator && !opts->key_only && !opts->value_only &&
+	    !opts->key_value_separator) {
+		strbuf_add(out, msg + info.trailer_block_start,
+			   info.trailer_block_end - info.trailer_block_start);
+	} else
+		format_trailers(&head, opts, out);
+
+	free_trailers(&head);
 	trailer_info_release(&info);
 }
 
diff --git a/trailer.h b/trailer.h
index 0e4f0ece9b3..50f70556302 100644
--- a/trailer.h
+++ b/trailer.h
@@ -102,21 +102,16 @@ void trailer_info_release(struct trailer_info *info);
 void trailer_config_init(void);
 void free_trailers(struct list_head *trailers);
 
-void format_trailers(FILE *outfile, struct list_head *head,
-		     const struct process_trailer_options *opts);
+void format_trailers(struct list_head *head,
+		     const struct process_trailer_options *opts,
+		     struct strbuf *out);
 /*
- * Format the trailers from the commit msg "msg" into the strbuf "out".
- * Note two caveats about "opts":
- *
- *   - this is primarily a helper for pretty.c, and not
- *     all of the flags are supported.
- *
- *   - this differs from format_trailers slightly in that we always format
- *     only the trailer block itself, even if the "only_trailers" option is not
- *     set.
+ * Convenience function to format the trailers from the commit msg "msg" into
+ * the strbuf "out". Reuses format_trailers internally.
  */
-void format_trailers_from_commit(struct strbuf *out, const char *msg,
-				 const struct process_trailer_options *opts);
+void format_trailers_from_commit(const char *msg,
+				 const struct process_trailer_options *opts,
+				 struct strbuf *out);
 
 /*
  * An interface for iterating over the trailers found in a particular commit
-- 
gitgitgadget

