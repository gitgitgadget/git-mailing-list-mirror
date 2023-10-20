Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD6208C7
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U324l8xP"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1E1D55
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:01:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083f613275so9154295e9.2
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697828499; x=1698433299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krbUNlo2DNDPxwRker4EVSmBk1LaDeLHsA9bsD+TeYo=;
        b=U324l8xPWvST9EJ2se/6NVD28xaJMFIYEycyg5tEd+I37kLqt+80q62GoapsuwOPbj
         B8Tj96c/akv6Y/q0XRf5CtJOIEKOBTzmnHjmyLr+VpQ1DvIddPyyhpKPzFMs9H+nPMVt
         iNplhXCGSopSUprceU5+1UT3Kli0n+aykyMbyMbmrDUtWQOIWdu0SO3f+FWIQFemDlrs
         h+ka4E3wRT9vBuxFHkyM4ser8k2zu7yCIfcb3faar92B+92Bl9/yAeSZzyDa6gqXcgYn
         KYcoWt9ECV01WA5tm81XN2HIKHSWsKEdWYTjBn9E8l7WAl/DTm8xWk8GlKtkh5o6Ub1a
         U2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828499; x=1698433299;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krbUNlo2DNDPxwRker4EVSmBk1LaDeLHsA9bsD+TeYo=;
        b=YkC9GPrXjhZf2sJfByIWRNDrwxjTNxFSHZi6uyOkkWDjMKrarXvxAhQXTR+ZMK6idL
         1b2Pw/msmbqfSZVrc/3tGXrvvTVjNHZbr+liFnRJa7Ou65K7Audsz7qyuVjUKSNcm9sE
         OuP90RRcIEg56nY9IpmH4mgyzULWONuLW5kWiyI8gkkyYkzpw0Kjn1Nrcdiy2wX4YqKI
         VIooroZadoNweOlaY0ZkBg0REhoRYb64c+UBw55s+wjp7vAP85kCWeRgHUf0aALiCeLT
         PXSpWmeD9+uCWE7xX9Io0dUDx+l7JI4c/+EHutl5J2wEEk9ZvemIkN+Mccyc3HvfEyVW
         d+kA==
X-Gm-Message-State: AOJu0YzdqGSjGK7pRw5bg/Rpv+0ogjCrB4KUvzofBcD8lUxg5lOaaRzT
	WjLdeEsiP2Nicstd+XgiAK/D0YwMnhY=
X-Google-Smtp-Source: AGHT+IGphJRLoSb7U6AePEwWjuC9H8+VPzzs97pUtQBtBec3LOw4xT+d2IePD8pHuOooPH3UwigEwQ==
X-Received: by 2002:a05:600c:4f52:b0:405:359a:c965 with SMTP id m18-20020a05600c4f5200b00405359ac965mr2214088wmq.4.1697828499154;
        Fri, 20 Oct 2023 12:01:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c00d900b004068495910csm7507450wmm.23.2023.10.20.12.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:01:38 -0700 (PDT)
Message-ID: <e3a7b150241c2d997026b8ccf7c88ecfecdfe4e7.1697828495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>
References: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
	<pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Oct 2023 19:01:35 +0000
Subject: [PATCH v5 3/3] trailer: use offsets for trailer_start/trailer_end
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
Cc: Glen Choo <glencbz@gmail.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

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

Reported-by: Glen Choo <glencbz@gmail.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 sequencer.c |  2 +-
 trailer.c   | 29 ++++++++++++++---------------
 trailer.h   | 10 +++++-----
 3 files changed, 20 insertions(+), 21 deletions(-)

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
index 70c81fda710..f7dc7c4c008 100644
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
index ab2cd017567..1644cd05f60 100644
--- a/trailer.h
+++ b/trailer.h
@@ -32,16 +32,16 @@ int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
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
+	 * "true" end of the input (find_end_of_log_message()).
 	 */
-	const char *trailer_start, *trailer_end;
+	size_t trailer_block_start, trailer_block_end;
 
 	/*
 	 * Array of trailers found.
-- 
gitgitgadget
