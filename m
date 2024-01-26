Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6D5A78F
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308746; cv=none; b=P0tEEo+SWlBgsJx3DvAoltmp8rR4KLuhi03oo3aP+B7bNiia+tOcKoQrqmWkjGugBGVV+K6+mBT/mTZZLSMqnvGADOfYlTaXk2hztw60J4IgPTBSiIR9sQOgoi2UQZNgW+L3ux3OgYONAPNHXdn6DYomPCwwoB5ERQBpOPfJJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308746; c=relaxed/simple;
	bh=kBFEdNiqzbM7lRdU4NHsD3q9dSujwy2MVPpxLZmPeLw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UU4L2qR4RtIkWQFXLEIpB8ahbUpVtz9VImlRUT92wza6LnRdR2x3ClEPu/SyC/In0cjgXgqFop080o6j9JjtPZ27CTm/KD7JYfF9mv4o3LzvhGx23tp470Ljhao7pxghAG81rccA/99dh7xt+ho1WM1uLls+Pr3fdtbhcOLjGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVUMNVCc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVUMNVCc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33921b8988fso976795f8f.3
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308742; x=1706913542; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XtF5Gk3QFBRNRpa1+EO6YCah2g8wGYKVIZusohDWNw=;
        b=NVUMNVCcI7MmAYU535DcqQFV7aFIt4tpUxcZfajIP6+7tQ2Se/mRYlm8SZc1AdhrxE
         /dwdrwMYCwi27E+2jv9fObIBbgfSWFinx2INvtLNId9sEMPRsau8108e5ltzLQ1qcMsu
         XCfJlxIcX9rBdf2RJbZOIqvoWhgfKTIpVuXxHnwZYzk00qdlkJ4sD+uU2J1uzOJz1r64
         KvRhaGUADYTPnORoeGqfX+/+eqmcqM4ikUTGH1aBtvmIFeX6qHkGlrS9XXN1qJs0Tr7I
         Mi8+4rfwavlrZSuWhA9RGEGy9vIRjkt+ah8vF7bttSb4zAvq5f1CHVBQIBdxgaNoNzrV
         Jlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308742; x=1706913542;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XtF5Gk3QFBRNRpa1+EO6YCah2g8wGYKVIZusohDWNw=;
        b=MHtORUffw/haYfwwXZzGdxFFkig0AyXCfHtsYq3gdOHRZkkwlBRT2sJNjAtLl4uCGK
         W15OX0qJxHlhiThT7bFxGm/0ZdAHUyk1ptskUiGuiMRJXea34/UDz2HGqsUmFm6duWLY
         B5MLEtp3ko3H/msIgXMR+gkbUWPLDqOhlnrKS2irf9rsGFOutaip40cGUPtGEsXjlvk6
         beNS5WJRbzXNz6Z6eJtSzSdQDBfTlPBSfYOLj12lhPg3B7HH1SCrQOwpR/+7+fKEpWxf
         tLi24/p6B1fMcsDOQmxChH5aWsbFr6xzukUTqM4hgUPEnWVgeoiuTgk2ZZcxt8lWvDzy
         oANQ==
X-Gm-Message-State: AOJu0YyfVHLtF3yPdE6IyEgnEbqJKp23fxb0nTjz1atSAI6GW9MXO/jN
	/CxgP7H+N/eH0Z4kfjYQiKeAX8mhSpUyFbY/IYdlBX8y8d7j16zi3drCsWAs
X-Google-Smtp-Source: AGHT+IGfn6d+EoqZYvKvi4LNidcDpsOxxRcWEOKJFUkJ5yE81+YrvJMG7tSg8Rmasv1LkWDPglL7Lw==
X-Received: by 2002:adf:e6cc:0:b0:339:437f:9a8c with SMTP id y12-20020adfe6cc000000b00339437f9a8cmr293018wrm.133.1706308742167;
        Fri, 26 Jan 2024 14:39:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d470e000000b00337cd6b1890sm2109415wrq.80.2024.01.26.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:39:01 -0800 (PST)
Message-ID: <9b7747d550e87457195c40a49347bc749a7290d0.1706308737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:50 +0000
Subject: [PATCH v2 03/10] trailer: unify trailer formatting machinery
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
 trailer.c                    | 105 +++++++++++++++++++++++++++++------
 trailer.h                    |  19 +++----
 5 files changed, 102 insertions(+), 32 deletions(-)

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
index d3899195876..7692bf9eb40 100644
--- a/trailer.c
+++ b/trailer.c
@@ -162,19 +162,6 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
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
@@ -984,6 +971,78 @@ static void unfold_value(struct strbuf *val)
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
@@ -1144,13 +1203,25 @@ static void format_trailer_info(struct strbuf *out,
 
 }
 
-void format_trailers_from_commit(struct strbuf *out, const char *msg,
-				 const struct process_trailer_options *opts)
+void format_trailers_from_commit(const struct process_trailer_options *opts,
+				 const char *msg,
+				 struct strbuf *out)
 {
+	LIST_HEAD(head);
 	struct trailer_info info;
 
-	trailer_info_get(&info, msg, opts);
-	format_trailer_info(out, &info, msg, opts);
+	parse_trailers(opts, &info, msg, &head);
+
+	/* If we want the whole block untouched, we can take the fast path. */
+	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
+	    !opts->separator && !opts->key_only && !opts->value_only &&
+	    !opts->key_value_separator) {
+		strbuf_add(out, msg + info.trailer_block_start,
+			   info.trailer_block_end - info.trailer_block_start);
+	} else
+		format_trailers(opts, &head, out);
+
+	free_trailers(&head);
 	trailer_info_release(&info);
 }
 
diff --git a/trailer.h b/trailer.h
index 4f603e03ceb..c309b01323d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -101,22 +101,17 @@ void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
 void format_trailers(const struct process_trailer_options *opts,
-		     struct list_head *trailers, FILE *outfile);
+		     struct list_head *trailers,
+		     struct strbuf *out);
 void free_trailers(struct list_head *trailers);
 
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

