Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A458FEE020C
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 06:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjIZGXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 02:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjIZGXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 02:23:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4CEE6
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:23:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so3366257e87.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695709378; x=1696314178; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj9fPgAekG4Qh/8P7EF1+8FR/3JIU8xIJkNsOP7+fOE=;
        b=Ai63mgyXiASHYrC9WJ+UxC3J6rNKYNWXKjqQ9wkhVBRK2+mWA1n5X2Pq8WVNWjGQ+F
         t8CC4XL7Y988adLZYl+SqCbIEGu+txxGOlL1cIUZw698pTfyDC+tH4S1s9WLrsePanSd
         GvJSLGUMylFIy2R9U3mVXLbtwZLMKj+JNvIGvo+kYBjrgNY6KBOsWpen5HXfwyqCm/p5
         b9C1WieOtFIAafijDG4rWXQK7bYPUQH4AeUQneCSrTP7++r+ncgVYIHktE91n0a51P+7
         LSJEXCeXvWC8MeaASFKmbE97ylVWTyLwMuFB1Qa0qWTOhc2OSZxcbIUuDujdtagpZuvC
         TTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695709378; x=1696314178;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj9fPgAekG4Qh/8P7EF1+8FR/3JIU8xIJkNsOP7+fOE=;
        b=qsJlr2Dc6j+ZFudA/uruXjYKFdHGRBpKdLuWBlI36NazKUbUbjvH7lXFashcAg9fGq
         Vquj82riEImkrOqcC+b7EHl1WNxot7/IHjVR5wc70sGMhdksAf+yLvjgFD/f9bw8LYBQ
         Av2zrBSIVIxbLODk8BRMJhV/+Tk2Tml0dsAnLP8fFX6LCjVru/qZ1gtU+w7CWEXkouI2
         3uuVhCt2xo471j0vJSNwkKB0phLf04QP6GyceJ7kJ6ccbz7JnSGZVheTJhZuEwm1QbOL
         93XY+Gtyds43nKunZ3E84AMIBZnQeNH4qT5QFbYjtISUJ7zJulaYgJjD3l7yMpo+3xS7
         qkGA==
X-Gm-Message-State: AOJu0YxFPU6a4lPN4E6Q6RIgS0A47SuxaOSxntfFP1mDfVUeBl0sD/WU
        2jhVP8VK0m7d7CEd2eVVsaCLXuDTN4I=
X-Google-Smtp-Source: AGHT+IGen7F8+rwpzNPzc8KeNlsMfp6RawriEOQrvRGi+0JZMcWcmSPbH+sVrchXUouHXr1AQhDheA==
X-Received: by 2002:a05:6512:2829:b0:503:385c:4319 with SMTP id cf41-20020a056512282900b00503385c4319mr9685488lfb.19.1695709378001;
        Mon, 25 Sep 2023 23:22:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3-20020ac25223000000b004f9c44b3e6dsm2111359lfl.127.2023.09.25.23.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:22:57 -0700 (PDT)
Message-ID: <796e47c1e5fb50a8adb4cf803320de926912a8ad.1695709372.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
References: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
        <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Sep 2023 06:22:51 +0000
Subject: [PATCH v4 3/4] trailer: use offsets for trailer_start/trailer_end
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
index d584cac8ed9..8707a92204f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -345,7 +345,7 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	if (ignore_footer)
 		sb->buf[sb->len - ignore_footer] = saved_char;
 
-	if (info.trailer_start == info.trailer_end)
+	if (info.trailer_block_start == info.trailer_block_end)
 		return 0;
 
 	for (i = 0; i < info.trailer_nr; i++)
diff --git a/trailer.c b/trailer.c
index 96cb285a4ea..3dc2faa969c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -856,7 +856,7 @@ static size_t find_end_of_log_message(const char *input, int no_divider)
  * Return the position of the first trailer line or len if there are no
  * trailers.
  */
-static size_t find_trailer_start(const char *buf, size_t len)
+static size_t find_trailer_block_start(const char *buf, size_t len)
 {
 	const char *s;
 	ssize_t end_of_title, l;
@@ -1072,7 +1072,6 @@ void process_trailers(const char *file,
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct trailer_info info;
-	size_t trailer_end;
 	FILE *outfile = stdout;
 
 	ensure_configured();
@@ -1083,11 +1082,10 @@ void process_trailers(const char *file,
 		outfile = create_in_place_tempfile(file);
 
 	parse_trailers(&info, sb.buf, &head, opts);
-	trailer_end = info.trailer_end - sb.buf;
 
 	/* Print the lines before the trailers */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_start - sb.buf, outfile);
+		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
 
 	if (!opts->only_trailers && !info.blank_line_before_trailer)
 		fprintf(outfile, "\n");
@@ -1109,7 +1107,7 @@ void process_trailers(const char *file,
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
+		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
@@ -1121,7 +1119,7 @@ void process_trailers(const char *file,
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
-	int end_of_log_message, trailer_start;
+	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
 	size_t nr = 0, alloc = 0;
@@ -1130,10 +1128,10 @@ void trailer_info_get(struct trailer_info *info, const char *str,
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
@@ -1154,9 +1152,9 @@ void trailer_info_get(struct trailer_info *info, const char *str,
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
@@ -1171,6 +1169,7 @@ void trailer_info_release(struct trailer_info *info)
 
 static void format_trailer_info(struct strbuf *out,
 				const struct trailer_info *info,
+				const char *msg,
 				const struct process_trailer_options *opts)
 {
 	size_t origlen = out->len;
@@ -1180,8 +1179,8 @@ static void format_trailer_info(struct strbuf *out,
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, info->trailer_start,
-			   info->trailer_end - info->trailer_start);
+		strbuf_add(out, msg + info->trailer_block_start,
+			   info->trailer_block_end - info->trailer_block_start);
 		return;
 	}
 
@@ -1235,7 +1234,7 @@ void format_trailers_from_commit(struct strbuf *out, const char *msg,
 	struct trailer_info info;
 
 	trailer_info_get(&info, msg, opts);
-	format_trailer_info(out, &info, opts);
+	format_trailer_info(out, &info, msg, opts);
 	trailer_info_release(&info);
 }
 
diff --git a/trailer.h b/trailer.h
index ab2cd017567..70d7b8bf1d8 100644
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

