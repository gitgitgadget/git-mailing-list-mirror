Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D07E779
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196372; cv=none; b=OlPPKdmqXMiHBmdCMd9kJE8ktnddMmGEpQy54614EH/Lxm8/YEl406HmZUAWjYuYu2GOazhNkVv/jCDkQOoqe55BkNKcwCSdzTjhQdNpxB0GK+uCFaLBwJ/cxeMGhCe4Two4U1INTmdxoy0EXPWGKBqW3uwVbPWn5jsDCgXkfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196372; c=relaxed/simple;
	bh=vkbKYwZLShFNS6jl17IRtYOQxsLMPMAPqkoC/CuTQIk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jWEuyPaFEch4rfAC92cIBkyLHiJwQGp1CX8Vl9z2I5uGhfZbIuJPkg+S/P3tq/xviMdFqpYBafIxm9jSb6rddZFjeVUxMtvzjnAheCAzuuH77QFaTOvC3h60Wz2pI7q2Bo/eQUX2ymjBY7Qi47BISfOntRc6euj7fGhzwouQ17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq+xbTEB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq+xbTEB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fdf17fa89so840365e9.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196368; x=1707801168; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VstlCU1v4Fa1Y7Z0SF2X9KG815ulMMhkP/c2T5TQIdc=;
        b=nq+xbTEBT7d2YdAIhzah0Ztg9GoFuc4zN1+5Epg5Wn3AKV4wvfEOpSQ3NNAkVsTTaQ
         LDsS0QI808Zq6IbmSdvWu5gg7lRKjVOX1447n3smdbeqDxs10TLECzaMycIcf0zBCJn4
         lLrO25ET6WJvmvncBLAly2a9DbUzUGSRKyXnWa6TKYjuXbgJ2uxgtyDdPFykM9gDFy14
         4C5lBW/KJFFYBODBu+iq6A9Mbj3hAts/c4OuoKYQwjijjiBRErjrStu5etVWl5Thuhx0
         fGFkZktz+R8rIkN1jKz+fUzT1YXrjyBZXIXGYKo/iKUZ4CdftRXgqBpGFeZZ/kOCbC+V
         EjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196368; x=1707801168;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VstlCU1v4Fa1Y7Z0SF2X9KG815ulMMhkP/c2T5TQIdc=;
        b=tnywJIuALcLRJFX/s1iQR0TnQ+dRohr6hEWS5tRoGta3jX4vhV6ekpIx59lgNBRB4E
         GXbXbw3pl096swceDiIeYcLtrGjbdjyxZaavBE9JBd7/azJG6H/zJWYd3BctpnIa2vPH
         b9ou+cltQx/1nr+uKIJmKbWzAJumx/B3hwEO6FoWpWnJuoumcNMf2C+y8T1qbCapENpV
         mRfQzo9Gs4V6Niz+nrvRelj8Qim8dwwzobCT+Iw+A44Zrw1L9TpMj1GkNvZJ9nQghxLc
         53B7pEwkeZRU5x10arGx3cLKATBkhKOAss/cTMNdSmZeqERtfkSEmn8RzecAVQxeVsSS
         ojkg==
X-Gm-Message-State: AOJu0YypCN+QotpaasoRavP+y2jA+4D+a5z3oU65s9ceOY9t0CNQakUX
	n7I2ewDQH4qg3HELhJ7LJT6g2ZwOS0M78Okos4wULRzLDovGU3+07qLLRySl
X-Google-Smtp-Source: AGHT+IHDrSyX2LlrOCb05gS7A9pEI07XPicoVS4arnR6IihCGO3hYf9wuWjVyW7Q7qjUjEg1muD9mQ==
X-Received: by 2002:a05:600c:3111:b0:40f:e0ef:a174 with SMTP id g17-20020a05600c311100b0040fe0efa174mr732673wmo.8.1707196367901;
        Mon, 05 Feb 2024 21:12:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnAbR/97jVEFGy2lfkwd/gPcFP7dXUyuc2w4PtczAws0N9qNRTfhmuKrWLZcmAntMwvJ4sy+0BfWoeSc1LriGU7/KKlVO2j2ZwL5xYwEQ0RNuOdFluJ9Nj6XzUii8pUlO2yMO/+EZj7GT3/XKNWPTLUwsa+XBQNZerROIlhWyFh80qGwjsuWFBCoP6k0N4Ga5GftJ0lywi0w==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b0040e3bdff98asm653852wmq.23.2024.02.05.21.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:47 -0800 (PST)
Message-ID: <f5f0d06613f2701af9bd3a1a9274aae232e03d8f.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:19 +0000
Subject: [PATCH v4 19/28] trailer: make trailer_info struct private
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

In 13211ae23f (trailer: separate public from internal portion of
trailer_iterator, 2023-09-09) we moved trailer_info behind an anonymous
struct to discourage use by trailer.h API users. However it still left
open the possibility of external use of trailer_info itself. Now that
there are no external users of trailer_info, we can make this struct
private.

Make this struct private by putting its definition inside trailer.c.
This has two benefits:

  (1) it makes the surface area of the public facing
      interface (trailer.h) smaller, and

  (2) external API users are unable to peer inside this struct (because
      it is only ever exposed as an opaque pointer).

There are a couple disadvantages:

  (A) every time the member of the struct is accessed an extra pointer
      dereference must be done, and

  (B) for users of trailer_info outside trailer.c, this struct can no
      longer be allocated on the stack and may only be allocated on the
      heap (because its definition is hidden away in trailer.c) and
      appropriately deallocated by the user.

This patch believes that the benefits outweight the advantages for
designing APIs, as explained below.

Making trailer_info private exposes existing deficiencies in the API.
This is because users of this struct had full access to its internals,
so there wasn't much need to actually design it to be "complete" in the
sense that API users only needed to use what was provided by the API.
For example, the location of the trailer block (start/end offsets
relative to the start of the input text) was accessible by looking at
these struct members directly. Now that the struct is private, we have
to expose new API functions to allow clients to access this
information (see builtin/interpret-trailers.c).

The idea in this patch to hide implementation details behind an "opaque
pointer" is also known as the "pimpl" (pointer to implementation) idiom
in C++ and is a common pattern in that language (where, for example,
abstract classes only have pointers to concrete classes).

However, the original inspiration to use this idiom does not come from
C++, but instead the book "C Interfaces and Implementations: Techniques
for Creating Reusable Software" [1]. This book recommends opaque
pointers as a good design principle for designing C libraries, using the
term "interface" as the functions defined in *.h (header) files and
"implementation" as the corresponding *.c file which define the
interfaces.

The book says this about opaque pointers:

    ... clients can manipulate such pointers freely, but they can’t
    dereference them; that is, they can’t look at the innards of the
    structure pointed to by them. Only the implementation has that
    privilege. Opaque pointers hide representation details and help
    catch errors.

In our case, "struct trailer_info" is now hidden from clients, and the
ways in which this opaque pointer can be used is limited to the richness
of <trailer.h>. In other words, <trailer.h> exclusively controls exactly
how "trailer_info" pointers are to be used.

[1] Hanson, David R. "C Interfaces and Implementations: Techniques for
    Creating Reusable Software". Addison Wesley, 1997. p. 22

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 12 +++---
 trailer.c                    | 81 ++++++++++++++++++++++++++++--------
 trailer.h                    | 40 +++++-------------
 3 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 11f4ce9e4a2..6bf8cec005a 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -141,7 +141,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info info;
+	struct trailer_info *info;
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -151,13 +151,13 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	parse_trailers(opts, &info, sb.buf, &head);
+	info = parse_trailers(opts, sb.buf, &head);
 
 	/* Print the lines before the trailers */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+		fwrite(sb.buf, 1, trailer_block_start(info), outfile);
 
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
+	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
 		fprintf(outfile, "\n");
 
 
@@ -178,8 +178,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
-	trailer_info_release(&info);
+		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
+	trailer_info_release(info);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
diff --git a/trailer.c b/trailer.c
index 2cc4a910411..cc211dfeeae 100644
--- a/trailer.c
+++ b/trailer.c
@@ -11,6 +11,27 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
 
+struct trailer_info {
+	/*
+	 * True if there is a blank line before the location pointed to by
+	 * trailer_block_start.
+	 */
+	int blank_line_before_trailer;
+
+	/*
+	 * Offsets to the trailer block start and end positions in the input
+	 * string. If no trailer block is found, these are both set to the
+	 * "true" end of the input (find_end_of_log_message()).
+	 */
+	size_t trailer_block_start, trailer_block_end;
+
+	/*
+	 * Array of trailers found.
+	 */
+	char **trailers;
+	size_t trailer_nr;
+};
+
 struct conf_info {
 	char *name;
 	char *key;
@@ -953,20 +974,26 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
+static struct trailer_info *trailer_info_new(void)
+{
+	struct trailer_info *info = xcalloc(1, sizeof(*info));
+	return info;
+}
+
 /*
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
  */
-void parse_trailers(const struct process_trailer_options *opts,
-		    struct trailer_info *info,
-		    const char *str,
-		    struct list_head *head)
+struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
+				    const char *str,
+				    struct list_head *head)
 {
+	struct trailer_info *info;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	size_t i;
 
-	trailer_info_get(opts, str, info);
+	info = trailer_info_get(opts, str);
 
 	for (i = 0; i < info->trailer_nr; i++) {
 		int separator_pos;
@@ -990,6 +1017,8 @@ void parse_trailers(const struct process_trailer_options *opts,
 					 strbuf_detach(&val, NULL));
 		}
 	}
+
+	return info;
 }
 
 void free_trailers(struct list_head *trailers)
@@ -1001,10 +1030,25 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
-void trailer_info_get(const struct process_trailer_options *opts,
-		      const char *str,
-		      struct trailer_info *info)
+size_t trailer_block_start(struct trailer_info *info)
+{
+	return info->trailer_block_start;
+}
+
+size_t trailer_block_end(struct trailer_info *info)
+{
+	return info->trailer_block_end;
+}
+
+int blank_line_before_trailer_block(struct trailer_info *info)
+{
+	return info->blank_line_before_trailer;
+}
+
+struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
+				      const char *str)
 {
+	struct trailer_info *info = trailer_info_new();
 	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
@@ -1043,6 +1087,8 @@ void trailer_info_get(const struct process_trailer_options *opts,
 	info->trailer_block_end = end_of_log_message;
 	info->trailers = trailer_strings;
 	info->trailer_nr = nr;
+
+	return info;
 }
 
 void trailer_info_release(struct trailer_info *info)
@@ -1051,6 +1097,7 @@ void trailer_info_release(struct trailer_info *info)
 	for (i = 0; i < info->trailer_nr; i++)
 		free(info->trailers[i]);
 	free(info->trailers);
+	free(info);
 }
 
 void format_trailers(const struct process_trailer_options *opts,
@@ -1118,21 +1165,19 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 struct strbuf *out)
 {
 	LIST_HEAD(trailers);
-	struct trailer_info info;
-
-	parse_trailers(opts, &info, msg, &trailers);
+	struct trailer_info *info = parse_trailers(opts, msg, &trailers);
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info.trailer_block_start,
-			   info.trailer_block_end - info.trailer_block_start);
+		strbuf_add(out, msg + info->trailer_block_start,
+			   info->trailer_block_end - info->trailer_block_start);
 	} else
 		format_trailers(opts, &trailers, out);
 
 	free_trailers(&trailers);
-	trailer_info_release(&info);
+	trailer_info_release(info);
 }
 
 void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
@@ -1141,14 +1186,14 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
 	opts.no_divider = 1;
-	trailer_info_get(&opts, msg, &iter->internal.info);
+	iter->internal.info = trailer_info_get(&opts, msg);
 	iter->internal.cur = 0;
 }
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	if (iter->internal.cur < iter->internal.info.trailer_nr) {
-		char *line = iter->internal.info.trailers[iter->internal.cur++];
+	if (iter->internal.cur < iter->internal.info->trailer_nr) {
+		char *line = iter->internal.info->trailers[iter->internal.cur++];
 		int separator_pos = find_separator(line, separators);
 
 		iter->raw = line;
@@ -1165,7 +1210,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(&iter->internal.info);
+	trailer_info_release(iter->internal.info);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
diff --git a/trailer.h b/trailer.h
index ebafa3657e4..a63e97a2663 100644
--- a/trailer.h
+++ b/trailer.h
@@ -4,6 +4,8 @@
 #include "list.h"
 #include "strbuf.h"
 
+struct trailer_info;
+
 enum trailer_where {
 	WHERE_DEFAULT,
 	WHERE_END,
@@ -29,27 +31,6 @@ int trailer_set_where(enum trailer_where *item, const char *value);
 int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
 int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
 
-struct trailer_info {
-	/*
-	 * True if there is a blank line before the location pointed to by
-	 * trailer_block_start.
-	 */
-	int blank_line_before_trailer;
-
-	/*
-	 * Offsets to the trailer block start and end positions in the input
-	 * string. If no trailer block is found, these are both set to the
-	 * "true" end of the input (find_end_of_log_message()).
-	 */
-	size_t trailer_block_start, trailer_block_end;
-
-	/*
-	 * Array of trailers found.
-	 */
-	char **trailers;
-	size_t trailer_nr;
-};
-
 /*
  * A list that represents newly-added trailers, such as those provided
  * with the --trailer command line option of git-interpret-trailers.
@@ -89,14 +70,15 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-void parse_trailers(const struct process_trailer_options *,
-		    struct trailer_info *,
-		    const char *str,
-		    struct list_head *head);
+struct trailer_info *parse_trailers(const struct process_trailer_options *,
+				    const char *str,
+				    struct list_head *head);
+struct trailer_info *trailer_info_get(const struct process_trailer_options *,
+				      const char *str);
 
-void trailer_info_get(const struct process_trailer_options *,
-		      const char *str,
-		      struct trailer_info *);
+size_t trailer_block_start(struct trailer_info *);
+size_t trailer_block_end(struct trailer_info *);
+int blank_line_before_trailer_block(struct trailer_info *);
 
 void trailer_info_release(struct trailer_info *info);
 
@@ -138,7 +120,7 @@ struct trailer_iterator {
 
 	/* private */
 	struct {
-		struct trailer_info info;
+		struct trailer_info *info;
 		size_t cur;
 	} internal;
 };
-- 
gitgitgadget

