Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79D5B5B0
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308749; cv=none; b=LrvoBNF3r/VtbBjGL7Ya8NcxHbl7DSZLPfzUIEjzMP/mlFbTM+y+ISHrFIog4yohFTKL8bqKhfZCTv9Jpzx33ROEo68Jm3sjBJY9hRCwmWPjV9enXd3r6K2KT996j62bRkAryX1lveeJUrZ2fG8QYxdDXCwDlkQu8e5sPfAPm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308749; c=relaxed/simple;
	bh=+0TFUqA9sz6Ky6tbgIil3IGsgCN14v/W6mHcEs8v4A0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=be6i3UOn6W8dxUVQnx1gQ/QthNT6ExR3Nfd9yhZq8UPQGwvZQIPdAUsin9tWNSQ8rylLI8i82O0TS0UgfsYXsoMpUPDDklYYSXDnJzfAh4uwXucZlR7YJwdvaNe7E9YsNYu0TRN2DtFGMMDXxrXQoN6bqAV2sfjDyuLOSrE1DLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJiiduPN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJiiduPN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e80046264so18767905e9.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308745; x=1706913545; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTV4xRooiqYa2WvtjacIyyvfkiL/cL4magg3QWfhGIs=;
        b=LJiiduPNmAwIaAx80/5ppJv2I49i2Jwo+cPplWpq50VLBoZ/y50LmiuaU6JpAoM0AI
         Q5DnTASofET51u0A3mQuVKibD2KGErFn5UdmSH38USKtYAffoFLlyoSO48wWGESojISk
         P+GpgtPP6LPfpjOF58UXNdpd14xgus5t8EwomUHZy0Datw4ol+7BGAJZJshNkqQkLPib
         g3ksBrlirFDX9wXbJlRrwxAvIby+Yo+ucTrfwqzt6ZcbJnesZ7BWPJIx8cTjWfT67/Ye
         kVPthYo+WrKDYyuBrqP8SPWHgRFBhlsKmNDvO+SYq5SHBQedE0s8Bh+csebKfRbcB1pj
         3HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308745; x=1706913545;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTV4xRooiqYa2WvtjacIyyvfkiL/cL4magg3QWfhGIs=;
        b=RlClPrhtB6A1vwVIqEo7fxlHePluBeASQYWln2P7bOxLU1xGGrmRRkv8IpbHINzRt4
         3yoi5ricBX0lg3P5ptFksb0kKS23eXjpKZmBxS5kPty6cmjaC8MkMR8om6mS70Y1OiE2
         L3lex1PRJ+FwzLFiAMrWBA8GnRrdJgC7OU2rFWRQAZDL6tu+ah4ihtU+cdEntLSPv1Bx
         QEKY5NF7e9L7FUVjF6y5OEtOi2zysMLv+L5P7Z9Emu5i6mdWsQ543MUiejr5bl0HImtN
         aeRI3qc0fH8cNUjTHl5IzI870R6JUlopXcu1OcNWlV0NocUFlJ9Uuo5phHCZhFhZdIQm
         Hyow==
X-Gm-Message-State: AOJu0YyOHsMVEpwf+Y5Zd+el2iSvX5FChWvdOJdZZrjKRRagUCAsxph4
	KoljoGOdQoE5UMF+a81y2lpyQYQGGDhyiXjkaW3MW6AhtkUSP9GpWOxZuuPf
X-Google-Smtp-Source: AGHT+IHl3IMiSvZi26DX0gfXM0iBE1c7t15vK5dj6Oru7+A0EPBhiLnb7nCD119CSf5Eqb7zsKLbAg==
X-Received: by 2002:a05:600c:35d4:b0:40e:cd3e:2ff3 with SMTP id r20-20020a05600c35d400b0040ecd3e2ff3mr336712wmq.132.1706308745195;
        Fri, 26 Jan 2024 14:39:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc9-20020a5d5c09000000b00339443be964sm862685wrb.91.2024.01.26.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:39:04 -0800 (PST)
Message-ID: <f0ac2f6c4b90912c8f1a78f3c59098b21134560f.1706308737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:53 +0000
Subject: [PATCH v2 06/10] trailer: make trailer_info struct private
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

This change exposes some deficiencies in the API, mainly with regard to
information about the location of the trailer block that was parsed.
Expose new API functions to access this information (needed by
builtin/interpret-trailers.c).

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
of the trailer.h file. In other words, trailer.h exclusively controls
exactly how "trailer_info" pointers are to be used.

[1] Hanson, David R. "C Interfaces and Implementations: Techniques for
    Creating Reusable Software". Addison Wesley, 1997. p. 22

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  13 +--
 trailer.c                    | 154 +++++++++++++++++++++++------------
 trailer.h                    |  37 ++-------
 3 files changed, 117 insertions(+), 87 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 5352ee65bd1..9e6ed6b65e2 100644
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
 
 
@@ -176,11 +176,12 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	strbuf_release(&trailer_block);
 
 	free_trailers(&head);
-	trailer_info_release(&info);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
+
+	trailer_info_release(info);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
diff --git a/trailer.c b/trailer.c
index 5bcc9b0006c..63774cd068d 100644
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
@@ -1025,20 +1046,72 @@ void format_trailers(const struct process_trailer_options *opts,
 	}
 }
 
+static struct trailer_info *trailer_info_new(void)
+{
+	struct trailer_info *info = xcalloc(1, sizeof(*info));
+	return info;
+}
+
+static struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
+					     const char *str)
+{
+	struct trailer_info *info = trailer_info_new();
+	size_t end_of_log_message = 0, trailer_block_start = 0;
+	struct strbuf **trailer_lines, **ptr;
+	char **trailer_strings = NULL;
+	size_t nr = 0, alloc = 0;
+	char **last = NULL;
+
+	trailer_config_init();
+
+	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
+	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
+
+	trailer_lines = strbuf_split_buf(str + trailer_block_start,
+					 end_of_log_message - trailer_block_start,
+					 '\n',
+					 0);
+	for (ptr = trailer_lines; *ptr; ptr++) {
+		if (last && isspace((*ptr)->buf[0])) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
+			strbuf_addbuf(&sb, *ptr);
+			*last = strbuf_detach(&sb, NULL);
+			continue;
+		}
+		ALLOC_GROW(trailer_strings, nr + 1, alloc);
+		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
+		last = find_separator(trailer_strings[nr], separators) >= 1
+			? &trailer_strings[nr]
+			: NULL;
+		nr++;
+	}
+	strbuf_list_free(trailer_lines);
+
+	info->blank_line_before_trailer = ends_with_blank_line(str,
+							       trailer_block_start);
+	info->trailer_block_start = trailer_block_start;
+	info->trailer_block_end = end_of_log_message;
+	info->trailers = trailer_strings;
+	info->trailer_nr = nr;
+
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
 
-	trailer_info_get(info, str, opts);
+	info = trailer_info_get(opts, str);
 
 	for (i = 0; i < info->trailer_nr; i++) {
 		int separator_pos;
@@ -1062,6 +1135,8 @@ void parse_trailers(const struct process_trailer_options *opts,
 					 strbuf_detach(&val, NULL));
 		}
 	}
+
+	return info;
 }
 
 void free_trailers(struct list_head *trailers)
@@ -1073,47 +1148,19 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
-void trailer_info_get(struct trailer_info *info, const char *str,
-		      const struct process_trailer_options *opts)
+size_t trailer_block_start(struct trailer_info *info)
 {
-	size_t end_of_log_message = 0, trailer_block_start = 0;
-	struct strbuf **trailer_lines, **ptr;
-	char **trailer_strings = NULL;
-	size_t nr = 0, alloc = 0;
-	char **last = NULL;
-
-	trailer_config_init();
-
-	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
-	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
+	return info->trailer_block_start;
+}
 
-	trailer_lines = strbuf_split_buf(str + trailer_block_start,
-					 end_of_log_message - trailer_block_start,
-					 '\n',
-					 0);
-	for (ptr = trailer_lines; *ptr; ptr++) {
-		if (last && isspace((*ptr)->buf[0])) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
-			strbuf_addbuf(&sb, *ptr);
-			*last = strbuf_detach(&sb, NULL);
-			continue;
-		}
-		ALLOC_GROW(trailer_strings, nr + 1, alloc);
-		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
-		last = find_separator(trailer_strings[nr], separators) >= 1
-			? &trailer_strings[nr]
-			: NULL;
-		nr++;
-	}
-	strbuf_list_free(trailer_lines);
+size_t trailer_block_end(struct trailer_info *info)
+{
+	return info->trailer_block_end;
+}
 
-	info->blank_line_before_trailer = ends_with_blank_line(str,
-							       trailer_block_start);
-	info->trailer_block_start = trailer_block_start;
-	info->trailer_block_end = end_of_log_message;
-	info->trailers = trailer_strings;
-	info->trailer_nr = nr;
+int blank_line_before_trailer_block(struct trailer_info *info)
+{
+	return info->blank_line_before_trailer;
 }
 
 void trailer_info_release(struct trailer_info *info)
@@ -1122,6 +1169,7 @@ void trailer_info_release(struct trailer_info *info)
 	for (i = 0; i < info->trailer_nr; i++)
 		free(info->trailers[i]);
 	free(info->trailers);
+	free(info);
 }
 
 void format_trailers_from_commit(const struct process_trailer_options *opts,
@@ -1129,30 +1177,30 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 struct strbuf *out)
 {
 	LIST_HEAD(head);
-	struct trailer_info info;
-
-	parse_trailers(opts, &info, msg, &head);
+	struct trailer_info *info = parse_trailers(opts, msg, &head);
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info.trailer_block_start,
-			   info.trailer_block_end - info.trailer_block_start);
+		strbuf_add(out, msg + info->trailer_block_start,
+			   info->trailer_block_end - info->trailer_block_start);
 	} else
 		format_trailers(opts, &head, out);
 
 	free_trailers(&head);
-	trailer_info_release(&info);
+	trailer_info_release(info);
 }
 
 void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	struct trailer_info *internal = trailer_info_new();
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
 	opts.no_divider = 1;
-	trailer_info_get(&iter->internal.info, msg, &opts);
+	iter->internal.info = internal;
+	iter->internal.info = trailer_info_get(&opts, msg);
 	iter->internal.cur = 0;
 }
 
@@ -1160,8 +1208,8 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 {
 	char *line;
 	int separator_pos;
-	if (iter->internal.cur < iter->internal.info.trailer_nr) {
-		line = iter->internal.info.trailers[iter->internal.cur++];
+	if (iter->internal.cur < iter->internal.info->trailer_nr) {
+		line = iter->internal.info->trailers[iter->internal.cur++];
 		separator_pos = find_separator(line, separators);
 		iter->is_trailer = (separator_pos > 0);
 
@@ -1178,7 +1226,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(&iter->internal.info);
+	trailer_info_release(iter->internal.info);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
diff --git a/trailer.h b/trailer.h
index a47f18b1525..fff16a29a55 100644
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
@@ -89,13 +70,13 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-void parse_trailers(const struct process_trailer_options *opts,
-		    struct trailer_info *info,
-		    const char *str,
-		    struct list_head *head);
+struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
+				    const char *str,
+				    struct list_head *head);
 
-void trailer_info_get(struct trailer_info *info, const char *str,
-		      const struct process_trailer_options *opts);
+size_t trailer_block_start(struct trailer_info *info);
+size_t trailer_block_end(struct trailer_info *info);
+int blank_line_before_trailer_block(struct trailer_info *info);
 
 void trailer_info_release(struct trailer_info *info);
 
@@ -142,7 +123,7 @@ struct trailer_iterator {
 
 	/* private */
 	struct {
-		struct trailer_info info;
+		struct trailer_info *info;
 		size_t cur;
 	} internal;
 };
-- 
gitgitgadget

