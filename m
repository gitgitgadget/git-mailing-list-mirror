Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A3A2D047
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625680; cv=none; b=iUK33Xvom10PtqQ59bGz6olCjqIztfPRxtkU8w7oKJ4kWmwWlZpuVs7kZ7zGMuDHF4FP1u1Lsu8I+ivKPWIBusGG9oSKrHkAMHnB9EOriHISyJ0Y83aT8j2NlgECM9dIFwC2TF2M+5NKyHFsfFgGxyZo66ird5F/m6L6Owg5ukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625680; c=relaxed/simple;
	bh=WA3qy4XSE4VL6jtaIEj/rpUOZxgQP8ybPTieY9ejBcY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oQhX0Tex95SABNy0w8eGLfVExFVZkqIiVRxVPgmmDtJZLJbgnEx1MEoG26KYALJTvwbCAe3TNgbp+vMxN7RGAYSJhKEJD+uFJox0PbQPwhLK5LWTszKn9b5cU5m+E63li8chcvxHWFjjPjda//n4t+p9tnwJB1wZU1KKzPc/G5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5R4zFQ4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5R4zFQ4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b794510cdso49143645e9.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625676; x=1715230476; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvEPhzygcqCzWhKD1yYdWR0bGjbS+NZOV4zmlXp5GfU=;
        b=l5R4zFQ4dKDCyX5AV51iJDlA2y0Ep6OWuiy0+q+YuZihGU9CxvK4Z1jpXPVDURI8JM
         9uEKqXmSLm49REYkXVcJGln2NOhf/ospK+KI8ZedrjFFuW4ZgT131zIi3Dw4LoV7raun
         D3I6Q4sC2kPP87nAmXQgHiD1ZTqTr6nMuZ+ZxNUmqP/6ADBEcXrEB/6xqDUat+DjAUlN
         sYFg5/Wm93wRhP1I5xYxwdBqXpwhVeNLbxDi22au5b04biPye1EAwVBTdDJkugo8TnpY
         ihq96RRXeRoJ66LwrvdHGJTNGZ3Hi7a+Gn1DSfBuc6Ht/g5wcQIJhDMnSGicHgGuf63j
         OZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625676; x=1715230476;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvEPhzygcqCzWhKD1yYdWR0bGjbS+NZOV4zmlXp5GfU=;
        b=BQts5WAIoNIe/BkOb5I20QR1xnjAgBe+4u3Zo99Z+GzE4wtmRBVQsbXJIuz6988ClJ
         Tuo3SLBDHed2lMq0oTvZhDlzXKXWAK4wEny7rzzueNCF/NVEo4ppNVOsyVFuoB0T+dJa
         RPfCxNxsuhMyIR1Gng8Y/AZee1WzqLEcdCOnu+Lj3ii4Xc23fjXVV2Xu+TJagf+0lXSK
         R9YNeV4XWmWpxKI4j9929L2D3UuEopotkYPWSoUqwCovzOe/CGXUf7SzrNtp0rqInVRI
         IADz9tf38bb6lBH/4mnDzpQFdURv1YeTVRqBKddm+gD5NcQ6pJop+Om1X12k42FMBJZs
         Nt/A==
X-Gm-Message-State: AOJu0YysdPevTDM57v5MUaRkvhz4pXTKJXsFBpK5ewrxJmlfIN8lMApN
	FiiYbBvDYmWloGReU2olzkD4V+e1JfVkkPAfc6BoWQNe0garUNRYGeEReA==
X-Google-Smtp-Source: AGHT+IEJpChL2ait5Tnld2bqTdMLOFT/lM5q3LnGFJ1wU66QmlQ9BKIKanNgoRFUmdv42Vy/C8YA3g==
X-Received: by 2002:a5d:474e:0:b0:34a:cc2:1a34 with SMTP id o14-20020a5d474e000000b0034a0cc21a34mr2397077wrs.42.1714625676535;
        Wed, 01 May 2024 21:54:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a056000001200b0034c78001f6asm238653wrx.109.2024.05.01.21.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:35 -0700 (PDT)
Message-Id: <9ed7cef9d294bc4cc8920975451e610974bb75e0.1714625668.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:23 +0000
Subject: [PATCH v4 06/10] trailer: make parse_trailers() return trailer_info
 pointer
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
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linus@ucla.edu>

From: Linus Arver <linus@ucla.edu>

This is the second and final preparatory commit for making the
trailer_info struct private to the trailer implementation.

Make trailer_info_get() do the actual work of allocating a new
trailer_info struct, and return a pointer to it. Because
parse_trailers() wraps around trailer_info_get(), it too can return this
pointer to the caller. From the trailer API user's perspective, the call
to trailer_info_new() can be replaced with parse_trailers(); do so in
interpret-trailers.

Because trailer_info_new() is no longer called by interpret-trailers,
remove this function from the trailer API.

With this change, we no longer allocate trailer_info on the stack ---
all uses of it are via a pointer where the actual data is always
allocated at runtime through trailer_info_new(). Make
trailer_info_release() free this dynamically allocated memory.

Finally, due to the way the function signatures of parse_trailers() and
trailer_info_get() have changed, update the callsites in
format_trailers_from_commit() and trailer_iterator_init() accordingly.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Linus Arver <linus@ucla.edu>
---
 builtin/interpret-trailers.c |  4 ++--
 trailer.c                    | 41 +++++++++++++++++++-----------------
 trailer.h                    | 17 ++++++---------
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index f3240682e35..6bf8cec005a 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -141,7 +141,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info *info = trailer_info_new();
+	struct trailer_info *info;
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -151,7 +151,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	parse_trailers(opts, info, sb.buf, &head);
+	info = parse_trailers(opts, sb.buf, &head);
 
 	/* Print the lines before the trailers */
 	if (!opts->only_trailers)
diff --git a/trailer.c b/trailer.c
index 95b4c9b8f19..9179dd802c6 100644
--- a/trailer.c
+++ b/trailer.c
@@ -952,7 +952,7 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
-struct trailer_info *trailer_info_new(void)
+static struct trailer_info *trailer_info_new(void)
 {
 	struct trailer_info *info = xcalloc(1, sizeof(*info));
 	return info;
@@ -962,16 +962,16 @@ struct trailer_info *trailer_info_new(void)
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
@@ -995,6 +995,8 @@ void parse_trailers(const struct process_trailer_options *opts,
 					 strbuf_detach(&val, NULL));
 		}
 	}
+
+	return info;
 }
 
 void free_trailers(struct list_head *trailers)
@@ -1021,10 +1023,10 @@ int blank_line_before_trailer_block(struct trailer_info *info)
 	return info->blank_line_before_trailer;
 }
 
-void trailer_info_get(const struct process_trailer_options *opts,
-		      const char *str,
-		      struct trailer_info *info)
+struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
+				      const char *str)
 {
+	struct trailer_info *info = trailer_info_new();
 	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
@@ -1063,6 +1065,8 @@ void trailer_info_get(const struct process_trailer_options *opts,
 	info->trailer_block_end = end_of_log_message;
 	info->trailers = trailer_strings;
 	info->trailer_nr = nr;
+
+	return info;
 }
 
 void trailer_info_release(struct trailer_info *info)
@@ -1071,6 +1075,7 @@ void trailer_info_release(struct trailer_info *info)
 	for (i = 0; i < info->trailer_nr; i++)
 		free(info->trailers[i]);
 	free(info->trailers);
+	free(info);
 }
 
 void format_trailers(const struct process_trailer_options *opts,
@@ -1138,21 +1143,19 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 struct strbuf *out)
 {
 	LIST_HEAD(trailer_objects);
-	struct trailer_info info;
-
-	parse_trailers(opts, &info, msg, &trailer_objects);
+	struct trailer_info *info = parse_trailers(opts, msg, &trailer_objects);
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info.trailer_block_start,
-			   info.trailer_block_end - info.trailer_block_start);
+		strbuf_add(out, msg + info->trailer_block_start,
+			   info->trailer_block_end - info->trailer_block_start);
 	} else
 		format_trailers(opts, &trailer_objects, out);
 
 	free_trailers(&trailer_objects);
-	trailer_info_release(&info);
+	trailer_info_release(info);
 }
 
 void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
@@ -1161,14 +1164,14 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
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
@@ -1185,7 +1188,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(&iter->internal.info);
+	trailer_info_release(iter->internal.info);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
diff --git a/trailer.h b/trailer.h
index 9ba96721398..c8c0018c54d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -89,18 +89,15 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-void parse_trailers(const struct process_trailer_options *,
-		    struct trailer_info *,
-		    const char *str,
-		    struct list_head *head);
-
-void trailer_info_get(const struct process_trailer_options *,
-		      const char *str,
-		      struct trailer_info *);
+struct trailer_info *parse_trailers(const struct process_trailer_options *,
+				    const char *str,
+				    struct list_head *head);
+struct trailer_info *trailer_info_get(const struct process_trailer_options *,
+				      const char *str);
+
 size_t trailer_block_start(struct trailer_info *);
 size_t trailer_block_end(struct trailer_info *);
 int blank_line_before_trailer_block(struct trailer_info *);
-struct trailer_info *trailer_info_new(void);
 
 void trailer_info_release(struct trailer_info *info);
 
@@ -141,7 +138,7 @@ struct trailer_iterator {
 
 	/* private */
 	struct {
-		struct trailer_info info;
+		struct trailer_info *info;
 		size_t cur;
 	} internal;
 };
-- 
gitgitgadget

