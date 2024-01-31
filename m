Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F863A7
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664156; cv=none; b=hhJ6wBKW7VKCD3cHOyQZV8Fbmcm9CglWSMtGdfWwrJNMN63k+vL8cQB6UOJe3llw8+88k3dvHV1qa3MTVu93ICrsCAtK2ACcKLKhDANBpcDj9tVHJwmCwvnedjtxNaXnpa1ZFreOD03xACzosDzDP2QJv+nEOlf71nQIxcNMNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664156; c=relaxed/simple;
	bh=iw1yqPdnLg9qX5+cNnOQStRxa5xjUrhPu5eBt2kpSFA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SoVQi42a2T0z9b6H+u7aXfNyinXofAr/igtwkwjx+AxNUt/xTVGTrSgD8jN/8cgGaAyezdjb1MGR+3h5wS27HW2jwhUKKB/9n5VB8Bc9FqPBzlqKCwHb/abNpQKBS9ra9+HT0QKyaFS/8br6tgE5o1LhPRjuzsW0bn2tWjujvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPhGg/ls; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPhGg/ls"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ae6dfa923so2060151f8f.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706664152; x=1707268952; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2apEInBK31bE3Ei7TrhNRecpv+hVokhZkV20ydfezk=;
        b=kPhGg/lsXcESqG1sIgBXre1f9pWSmVfvNvf6Pzw1KqH6yJhQQLKjeQKEeqdTlKva95
         lu6x3VtG1kPrxh8zZx1ZxbymosJJY6f3Ig6EcumRM83+rUbnsHtIMJlgbA/t5Nf7CkqT
         PeoGVaC9cTof/IoRp64VpUVi9hcvuuQPsrXW7TIopMdHZUz9gqXzPjotJxBtmlAQE7Qk
         AiwLSzaBsjVjXd6NAHYfffA9BCBryL6SCgdA4hLZRKwZT9P9X7NQrOE5E/a4fm2qeRWs
         GWL09d53/VTu3ZmNTdoBxBL2d+xwlMBgMDCq68zaJyxZebXlp+in18Bjkyi1/rz0gUi5
         ZvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706664152; x=1707268952;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2apEInBK31bE3Ei7TrhNRecpv+hVokhZkV20ydfezk=;
        b=lRfMt7sAKwAM/GVisrVS9YLqBII7/SdG5sJeDZzIwTUHQ762JYGONtqPL5MjHBpPQ1
         6KNI5t5giFjtRjDoJeiEqw3QFEdyZLgJRXafn3tf8KgCZjn57RVZb1zOt6Xr7yI7UBuk
         28+XJTDm950HuqvpRLvWNuQxtVl4Yp1QN4C6UqsybgKY7wtGakFKff5yUnn4bcgvW8sa
         vp0JuF8p+PS0yL9pQMpCxkABIhyDbbw3w0Rs+aiyqa7m9Y4vL5PJn3Bknb7EmfjAtKZW
         AOlIm3tDMPZqwhsfAMRhZVlxgd3tRj4fzQAfUfnoIw6NkiRc/jN+002XAF2rG9jUaz+U
         9Rfg==
X-Gm-Message-State: AOJu0YxAooQYk0EOKzyB8qfR8YKqlZARLATBRB00umGPL3cXxm41Duw+
	rboqJa4H9qjs9bi2XPLXnM/1TpxY88XyKHhoYWutP8EtBNLg6fhOoYJobnYV
X-Google-Smtp-Source: AGHT+IEln37EtIx4xTJ91yI0jkJ3Pl9/7TVL3KG++KJcUjS5o5ZU4HC+v1ouh8bot13K2xgKp6nW/w==
X-Received: by 2002:a5d:6b89:0:b0:33a:eda1:e68b with SMTP id n9-20020a5d6b89000000b0033aeda1e68bmr98940wrx.24.1706664152597;
        Tue, 30 Jan 2024 17:22:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cx18-20020a056000093200b0033935779a23sm11991703wrb.89.2024.01.30.17.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:22:32 -0800 (PST)
Message-ID: <0a9a7438c3ff39f1434087bf3ed6a9865758c803.1706664145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 01:22:20 +0000
Subject: [PATCH v3 06/10] trailer: spread usage of "trailer_block" language
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

Deprecate the "trailer_info" struct name and replace it with
"trailer_block". The main reason is to help readability, because
"trailer_info" on the surface sounds like it's about a single trailer
when in reality it is a collection of contiguous lines, at least 25% of
which are trailers.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 26 +++++-----
 trailer.c                    | 99 ++++++++++++++++++------------------
 trailer.h                    | 18 +++----
 3 files changed, 71 insertions(+), 72 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 9e6ed6b65e2..9e41fa20b5f 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -140,8 +140,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
-	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info *info;
+	struct strbuf tb = STRBUF_INIT;
+	struct trailer_block *trailer_block;
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -151,13 +151,13 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	info = parse_trailers(opts, sb.buf, &head);
+	trailer_block = parse_trailers(opts, sb.buf, &head);
 
-	/* Print the lines before the trailers */
+	/* Print the lines before the trailer block */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, trailer_block_start(info), outfile);
+		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
 
-	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
+	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
 		fprintf(outfile, "\n");
 
 
@@ -171,17 +171,17 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	}
 
 	/* Print trailer block. */
-	format_trailers(opts, &head, &trailer_block);
-	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
-	strbuf_release(&trailer_block);
+	format_trailers(opts, &head, &tb);
+	fwrite(tb.buf, 1, tb.len, outfile);
+	strbuf_release(&tb);
 
 	free_trailers(&head);
 
-	/* Print the lines after the trailers as is */
+	/* Print the lines after the trailer block as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
-
-	trailer_info_release(info);
+		fwrite(sb.buf + trailer_block_end(trailer_block),
+		       1, sb.len - trailer_block_end(trailer_block), outfile);
+	trailer_block_release(trailer_block);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
diff --git a/trailer.c b/trailer.c
index 63774cd068d..e2a48bea0ae 100644
--- a/trailer.c
+++ b/trailer.c
@@ -11,19 +11,20 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
 
-struct trailer_info {
+struct trailer_block {
 	/*
 	 * True if there is a blank line before the location pointed to by
-	 * trailer_block_start.
+	 * "start".
 	 */
 	int blank_line_before_trailer;
 
 	/*
-	 * Offsets to the trailer block start and end positions in the input
-	 * string. If no trailer block is found, these are both set to the
-	 * "true" end of the input (find_end_of_log_message()).
+	 * The locations of the start and end positions of the trailer block
+	 * found, as offsets from the beginning of the source text from which
+	 * this trailer block was parsed. If no trailer block is found, these
+	 * are both set to 0.
 	 */
-	size_t trailer_block_start, trailer_block_end;
+	size_t start, end;
 
 	/*
 	 * Array of trailers found.
@@ -1046,16 +1047,16 @@ void format_trailers(const struct process_trailer_options *opts,
 	}
 }
 
-static struct trailer_info *trailer_info_new(void)
+static struct trailer_block *trailer_block_new(void)
 {
-	struct trailer_info *info = xcalloc(1, sizeof(*info));
-	return info;
+	struct trailer_block *trailer_block = xcalloc(1, sizeof(*trailer_block));
+	return trailer_block;
 }
 
-static struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
-					     const char *str)
+static struct trailer_block *trailer_block_get(const struct process_trailer_options *opts,
+					       const char *str)
 {
-	struct trailer_info *info = trailer_info_new();
+	struct trailer_block *trailer_block = trailer_block_new();
 	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
@@ -1088,34 +1089,34 @@ static struct trailer_info *trailer_info_get(const struct process_trailer_option
 	}
 	strbuf_list_free(trailer_lines);
 
-	info->blank_line_before_trailer = ends_with_blank_line(str,
-							       trailer_block_start);
-	info->trailer_block_start = trailer_block_start;
-	info->trailer_block_end = end_of_log_message;
-	info->trailers = trailer_strings;
-	info->trailer_nr = nr;
+	trailer_block->blank_line_before_trailer = ends_with_blank_line(str,
+									trailer_block_start);
+	trailer_block->start = trailer_block_start;
+	trailer_block->end = end_of_log_message;
+	trailer_block->trailers = trailer_strings;
+	trailer_block->trailer_nr = nr;
 
-	return info;
+	return trailer_block;
 }
 
 /*
- * Parse trailers in "str", populating the trailer info and "head"
- * linked list structure.
+ * Parse trailers in "str", populating the trailer_block info and "head" linked
+ * list structure.
  */
-struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
-				    const char *str,
-				    struct list_head *head)
+struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
+				     const char *str,
+				     struct list_head *head)
 {
-	struct trailer_info *info;
+	struct trailer_block *trailer_block;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	size_t i;
 
-	info = trailer_info_get(opts, str);
+	trailer_block = trailer_block_get(opts, str);
 
-	for (i = 0; i < info->trailer_nr; i++) {
+	for (i = 0; i < trailer_block->trailer_nr; i++) {
 		int separator_pos;
-		char *trailer = info->trailers[i];
+		char *trailer = trailer_block->trailers[i];
 		if (trailer[0] == comment_line_char)
 			continue;
 		separator_pos = find_separator(trailer, separators);
@@ -1136,7 +1137,7 @@ struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
 		}
 	}
 
-	return info;
+	return trailer_block;
 }
 
 void free_trailers(struct list_head *trailers)
@@ -1148,28 +1149,28 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
-size_t trailer_block_start(struct trailer_info *info)
+size_t trailer_block_start(struct trailer_block *trailer_block)
 {
-	return info->trailer_block_start;
+	return trailer_block->start;
 }
 
-size_t trailer_block_end(struct trailer_info *info)
+size_t trailer_block_end(struct trailer_block *trailer_block)
 {
-	return info->trailer_block_end;
+	return trailer_block->end;
 }
 
-int blank_line_before_trailer_block(struct trailer_info *info)
+int blank_line_before_trailer_block(struct trailer_block *trailer_block)
 {
-	return info->blank_line_before_trailer;
+	return trailer_block->blank_line_before_trailer;
 }
 
-void trailer_info_release(struct trailer_info *info)
+void trailer_block_release(struct trailer_block *trailer_block)
 {
 	size_t i;
-	for (i = 0; i < info->trailer_nr; i++)
-		free(info->trailers[i]);
-	free(info->trailers);
-	free(info);
+	for (i = 0; i < trailer_block->trailer_nr; i++)
+		free(trailer_block->trailers[i]);
+	free(trailer_block->trailers);
+	free(trailer_block);
 }
 
 void format_trailers_from_commit(const struct process_trailer_options *opts,
@@ -1177,30 +1178,28 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 struct strbuf *out)
 {
 	LIST_HEAD(head);
-	struct trailer_info *info = parse_trailers(opts, msg, &head);
+	struct trailer_block *trailer_block = parse_trailers(opts, msg, &head);
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info->trailer_block_start,
-			   info->trailer_block_end - info->trailer_block_start);
+		strbuf_add(out, msg + trailer_block->start,
+			   trailer_block->end - trailer_block->start);
 	} else
 		format_trailers(opts, &head, out);
 
 	free_trailers(&head);
-	trailer_info_release(info);
+	trailer_block_release(trailer_block);
 }
 
 void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-	struct trailer_info *internal = trailer_info_new();
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
 	opts.no_divider = 1;
-	iter->internal.info = internal;
-	iter->internal.info = trailer_info_get(&opts, msg);
+	iter->internal.trailer_block = trailer_block_get(&opts, msg);
 	iter->internal.cur = 0;
 }
 
@@ -1208,8 +1207,8 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 {
 	char *line;
 	int separator_pos;
-	if (iter->internal.cur < iter->internal.info->trailer_nr) {
-		line = iter->internal.info->trailers[iter->internal.cur++];
+	if (iter->internal.cur < iter->internal.trailer_block->trailer_nr) {
+		line = iter->internal.trailer_block->trailers[iter->internal.cur++];
 		separator_pos = find_separator(line, separators);
 		iter->is_trailer = (separator_pos > 0);
 
@@ -1226,7 +1225,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(iter->internal.info);
+	trailer_block_release(iter->internal.trailer_block);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
diff --git a/trailer.h b/trailer.h
index e19ddf84e64..e74f9189c0a 100644
--- a/trailer.h
+++ b/trailer.h
@@ -4,7 +4,7 @@
 #include "list.h"
 #include "strbuf.h"
 
-struct trailer_info;
+struct trailer_block;
 
 enum trailer_where {
 	WHERE_DEFAULT,
@@ -70,15 +70,15 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
-				    const char *str,
-				    struct list_head *head);
+struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
+				     const char *str,
+				     struct list_head *head);
 
-size_t trailer_block_start(struct trailer_info *info);
-size_t trailer_block_end(struct trailer_info *info);
-int blank_line_before_trailer_block(struct trailer_info *info);
+size_t trailer_block_start(struct trailer_block *trailer_block);
+size_t trailer_block_end(struct trailer_block *trailer_block);
+int blank_line_before_trailer_block(struct trailer_block *trailer_block);
 
-void trailer_info_release(struct trailer_info *info);
+void trailer_block_release(struct trailer_block *trailer_block);
 
 void trailer_config_init(void);
 void format_trailers(const struct process_trailer_options *opts,
@@ -123,7 +123,7 @@ struct trailer_iterator {
 
 	/* private */
 	struct {
-		struct trailer_info *info;
+		struct trailer_block *trailer_block;
 		size_t cur;
 	} internal;
 };
-- 
gitgitgadget

