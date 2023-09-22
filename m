Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC5CE7AB7
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjIVTv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjIVTvH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:51:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD91A2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405361bb9cdso23075785e9.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412251; x=1696017051; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHe98kkGbtTIzTXMF6lyNU0pFHVIK5w2W2RAaqYV3uI=;
        b=YGz+w65ncLzlU9lcNWK3dO1eZ+6bTKsChpS+xao9CoAxXHKD0kXqSS+oAyoRb90USW
         hB0t3/W8fKi/0mlbEFqSpmdiiyDSeC8t9152skf4pwIkY/+mm2tIDr87kpfEvekKSMHy
         Opia4S3pJVBbHH/q4sP5pHiPdJyjjmlBBvTclBqE64k/fzPA5RvFF5i2hR50x8WNAs/y
         gB2Fv2B9AUwpmNLclMJp27BftccrgHhJdZev1FqRXlkMFHi9Os8trKi15GFzqSUngpJ3
         dvdavefYlmoCdrNFbw9ddXP/Elq2K8E/h8B87nj1WD23a4PpMBADBeK+2ji2qjuiobLf
         rQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412251; x=1696017051;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHe98kkGbtTIzTXMF6lyNU0pFHVIK5w2W2RAaqYV3uI=;
        b=jJXIttQG6YeRRxXavTKUDCeGgIbm6ytaR+WAhJahrSPnxULmAvArrEEhsV8UtEnCZw
         cIGhKX5bK45zU6TghP56/uUyanmbi6NSJW61uZXt28i7jRvq+6SpMHVJpJYvubDoLpeg
         DBrnFlkOd082Qo2kvp48PQxxALMCzEgyDLWBVg32nsSM5U8mXlsiSEWlS7bjpdUOtrxT
         e0vpxpaZUcAXNCVWAN+tQZ+X4M+pUfoCBpo0S9Esv8fdY7h1Fab/jvv+Oj58BuMi1vq9
         7iJSpktC7t+fbhXNbnGcWaFwMl0R/Y3W7oJfrl5R+rfx0TYJ6ci9nF1dQsqyBOw+33kn
         P7TA==
X-Gm-Message-State: AOJu0YxhkLW0hpmfK1hSgZtC6LBmEt2wVqCFmdQ5tfrrF99aQhvwVvx3
        l694XSknWgQEiGmVSbw4gRLpK9ecuvc=
X-Google-Smtp-Source: AGHT+IEqX2W4sHE0tXK8y29U6YBV4qayNmM/2n6rNBBf4iqTNJW5Ap+f4NF2vKRjZBXjW+t8ujMLxQ==
X-Received: by 2002:a05:600c:2108:b0:404:7480:d821 with SMTP id u8-20020a05600c210800b004047480d821mr231229wml.37.1695412251513;
        Fri, 22 Sep 2023 12:50:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d4804000000b003179b3fd837sm5143759wrq.33.2023.09.22.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:51 -0700 (PDT)
Message-ID: <091805eb7d93efa6fbe3831bcddd2a6fdc033388.1695412245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:43 +0000
Subject: [PATCH v3 7/9] trailer: use offsets for trailer_start/trailer_end
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Previously these fields in the trailer_info struct were of type "const
char *" and pointed to positions in the input string directly (to the
start and end positions of the trailer block).

Use offsets to make the intended usage less ambiguous. We only need to
reference the input string in format_trailer_info(), so update that
function to take a pointer to the input.

While we're at it, rename trailer_start to trailer_block_start to be
more explicit about these offsets (that they are for the entire trailer
block including other trailers). Ditto for trailer_end.

Signed-off-by: Linus Arver <linusa@google.com>
---
 sequencer.c |  2 +-
 trailer.c   | 29 ++++++++++++++---------------
 trailer.h   | 13 ++++++++-----
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index adc9cfb4df3..77362f5cd5d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -331,7 +331,7 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	if (ignore_footer)
 		sb->buf[sb->len - ignore_footer] = saved_char;
 
-	if (info.trailer_start == info.trailer_end)
+	if (info.trailer_block_start == info.trailer_block_end)
 		return 0;
 
 	for (i = 0; i < info.trailer_nr; i++)
diff --git a/trailer.c b/trailer.c
index 9da89df9d8a..471c2722536 100644
--- a/trailer.c
+++ b/trailer.c
@@ -859,7 +859,7 @@ static size_t find_end_of_log_message(const char *input, int no_divider)
  * Return the position of the first trailer line or len if there are no
  * trailers.
  */
-static size_t find_trailer_start(const char *buf, size_t len)
+static size_t find_trailer_block_start(const char *buf, size_t len)
 {
 	const char *s;
 	ssize_t end_of_title, l;
@@ -1075,7 +1075,6 @@ void process_trailers(const char *file,
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct trailer_info info;
-	size_t trailer_end;
 	FILE *outfile = stdout;
 
 	ensure_configured();
@@ -1086,11 +1085,10 @@ void process_trailers(const char *file,
 		outfile = create_in_place_tempfile(file);
 
 	parse_trailers(&info, sb.buf, &head, opts);
-	trailer_end = info.trailer_end - sb.buf;
 
 	/* Print the lines before the trailers */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_start - sb.buf, outfile);
+		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
 
 	if (!opts->only_trailers && !info.blank_line_before_trailer)
 		fprintf(outfile, "\n");
@@ -1112,7 +1110,7 @@ void process_trailers(const char *file,
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
+		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
@@ -1124,7 +1122,7 @@ void process_trailers(const char *file,
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
-	int end_of_log_message, trailer_start;
+	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
 	size_t nr = 0, alloc = 0;
@@ -1133,10 +1131,10 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 	ensure_configured();
 
 	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
-	trailer_start = find_trailer_start(str, end_of_log_message);
+	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
 
-	trailer_lines = strbuf_split_buf(str + trailer_start,
-					 end_of_log_message - trailer_start,
+	trailer_lines = strbuf_split_buf(str + trailer_block_start,
+					 end_of_log_message - trailer_block_start,
 					 '\n',
 					 0);
 	for (ptr = trailer_lines; *ptr; ptr++) {
@@ -1157,9 +1155,9 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 	strbuf_list_free(trailer_lines);
 
 	info->blank_line_before_trailer = ends_with_blank_line(str,
-							       trailer_start);
-	info->trailer_start = str + trailer_start;
-	info->trailer_end = str + end_of_log_message;
+							       trailer_block_start);
+	info->trailer_block_start = trailer_block_start;
+	info->trailer_block_end = end_of_log_message;
 	info->trailers = trailer_strings;
 	info->trailer_nr = nr;
 }
@@ -1174,6 +1172,7 @@ void trailer_info_release(struct trailer_info *info)
 
 static void format_trailer_info(struct strbuf *out,
 				const struct trailer_info *info,
+				const char *msg,
 				const struct process_trailer_options *opts)
 {
 	size_t origlen = out->len;
@@ -1183,8 +1182,8 @@ static void format_trailer_info(struct strbuf *out,
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, info->trailer_start,
-			   info->trailer_end - info->trailer_start);
+		strbuf_add(out, msg + info->trailer_block_start,
+			   info->trailer_block_end - info->trailer_block_start);
 		return;
 	}
 
@@ -1238,7 +1237,7 @@ void format_trailers_from_commit(struct strbuf *out, const char *msg,
 	struct trailer_info info;
 
 	trailer_info_get(&info, msg, opts);
-	format_trailer_info(out, &info, opts);
+	format_trailer_info(out, &info, msg, opts);
 	trailer_info_release(&info);
 }
 
diff --git a/trailer.h b/trailer.h
index a689d768c79..4dcb9080327 100644
--- a/trailer.h
+++ b/trailer.h
@@ -32,16 +32,19 @@ int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
 struct trailer_info {
 	/*
 	 * True if there is a blank line before the location pointed to by
-	 * trailer_start.
+	 * trailer_block_start.
 	 */
 	int blank_line_before_trailer;
 
 	/*
-	 * Pointers to the start and end of the trailer block found. If there
-	 * is no trailer block found, these 2 pointers point to the end of the
-	 * input string.
+	 * Offsets to the trailer block start and end positions in the input
+	 * string. If no trailer block is found, these are both set to the
+	 * "true" end of the input, per find_true_end_of_input().
+	 *
+	 * NOTE: This will be changed so that these point to 0 in the next
+	 * patch if no trailers are found.
 	 */
-	const char *trailer_start, *trailer_end;
+	size_t trailer_block_start, trailer_block_end;
 
 	/*
 	 * Array of trailers found.
-- 
gitgitgadget

