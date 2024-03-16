Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293CF510
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570438; cv=none; b=R38NDDTPlqQiS04mhIVkzTvRyBeJPeFZRIvqTm3/xA1O/AldQx3XA35qaa9XvsPOH3vooquj8khRn4EI1+e4NTiVaS7h2dnHoCPvra43ccBLMTZmM0B9njDa7+GkK3ilAGH9vdtYKscUTAX1F6Pz7GfzcokI4H3sK82Yu9G9uCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570438; c=relaxed/simple;
	bh=4uNz/BNgPU9bXhIVD83KXZWLdRC44l+OQ1r4zFrYzCs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pxwlt7l9+n9VZqFarmJFSH2vjT4BR8GgSRvF9nA4AgO854WrtVtEzUZu3RApLSebB2VOqNxhzOwv6AtRnZ8v/u43f56qeqSV2UCUisppwlS5t4RDvLTfviRsy6zh6yy7xUGSg8tKHvIbWJMerJud7PEmE5febMjdSMU1u4FuDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAd/YkCK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAd/YkCK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33fd8a2a3e6so33490f8f.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710570434; x=1711175234; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYH3cOb+6VK9nymkrwkTOMX8VDcmssy9ePiYCbDT9xU=;
        b=hAd/YkCKUsCoXCgBiETQg6Qx+VUE+SJyGsEx0tVVBBrNVQVHOuyIczqywBfJPFMiPQ
         xrbhBe39SPRK6pPKBj2pl2ErIihYwvxnogx2CCEtur/Jy6vcpAwpenK1gOQcTcQjW/u9
         NRha8M2cC9hihC0Y7T5AI/P+7DksWCTN5QozINaYcb2GJLuRivHxJ0o+0TPLCRJeI3M4
         Yw/o8bgMKAXRrujSkC2zPpOP99kQNAJ2mRvneJqU7cYivG8P3LskL8Y5qnfyR/2GfEhU
         TGu0c9ity76AjlvQxWj/+f4cvimkHhaWDSXZG6G3C341Btiqfx4dnbsfIh8shomB+4N7
         zb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710570434; x=1711175234;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYH3cOb+6VK9nymkrwkTOMX8VDcmssy9ePiYCbDT9xU=;
        b=Cki+mFzqpWdQEuZ4xoRqIylQYFyJc2GQofnHRu0Mx6A4z9UTZVPBzL4h9GkSii/+vz
         4uQlokcoiJzxzqR9WWU73mkGD1VMJNUdMmiUgwKoZyrKpiuWRTrlSOososazpdfaKcu4
         1Eb+L0y7qO7erXPJWxtRRIeXkCHLl1UNEbKvsDbE04puMCodf2cTV4hSB4geH+Y6PwRi
         JMtPzaP/1NJKSU0YYLK3jEYa2IAiBnroSY/OI19kcVnXu+TdrRtD4hKJoNWDXMxSyHFN
         Xqj4S9qv47agzGU7sUjxBSaWp/9vl24LZH6lH6sVF4YVWGIFGYQpoIKunUIwQlg1iqhZ
         S8AA==
X-Gm-Message-State: AOJu0YzwEXSdDSukKpVnaD+Om/MzdfYTOYvHk3pngb2eFEAVWvjN1EH0
	4F4C/U9h188Z9MRQAWp2ILm53lOpzijXR7dgnQylFXJi0wIPhjUPobCTL7sb
X-Google-Smtp-Source: AGHT+IEtPOP/BAKeF9wLksjg1DzLN1SR05Xx8TFuyF0u2trZpKVmauRedQr5BaE2JfiytKD96A6X7A==
X-Received: by 2002:a5d:66cf:0:b0:33d:9f58:8803 with SMTP id k15-20020a5d66cf000000b0033d9f588803mr4556129wrw.18.1710570434484;
        Fri, 15 Mar 2024 23:27:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5-20020adffcc5000000b0033e7b05edf3sm4708686wrs.44.2024.03.15.23.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 23:27:13 -0700 (PDT)
Message-ID: <c55ae2cbda9aea15f9f3c0bb3122aa6535624b24.1710570428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 06:27:06 +0000
Subject: [PATCH 4/6] trailer: make parse_trailers() return trailer_info
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

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
Signed-off-by: Linus Arver <linusa@google.com>
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
index 9ac4be853c5..b32213a9e23 100644
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
 
@@ -142,7 +139,7 @@ struct trailer_iterator {
 
 	/* private */
 	struct {
-		struct trailer_info info;
+		struct trailer_info *info;
 		size_t cur;
 	} internal;
 };
-- 
gitgitgadget

