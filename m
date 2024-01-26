Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3F5B1E6
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308748; cv=none; b=JrSbtCxU5pLfnVNd0eHneS0uBCNUAzXtXw8S0kHCQ6fac1WMNuh2PhYEWQy+Vi1uYQCR/u965Ws+nZwRPIRKraT2glsyfp0klgh9JhSEG53j/iTlr6Qg3h4UmZIRWtiIpX7QytmVXQ0vMbQkfXjvVI36u5SMECRW5OhafJbl5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308748; c=relaxed/simple;
	bh=NrqDl9jO7w0p1uWSKnU1dungX5O33wIeWGNlllaJ/uY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=el/30B3Ap8bhSifCvk1MwmOWk5HTJn2DzUtYqHw5kP3E0+bJbvYn7AXl70oYPjKAWSh/ROXwdSIXa03j1j5hqoOz1KXTqNQU9iTM5f1oV6RG2karMyfKwJZwEShh9kzFwM59NepBxSiIDiIBasXS1L/q4YvP6bDxeSQ6cn/7240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVW9azS+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVW9azS+"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33924df7245so1182316f8f.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308744; x=1706913544; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3OQPNBRoI4s9xk+w81XwIFGbiMy8piXg1fxcmhx8Hc=;
        b=TVW9azS+ubVB4DmWvQ71BZjE3Gah3XGHMyBwlLKBb2Ifd3qxHgsMqBmxyz1zPMfidq
         qm7tVHqQR5SuRl5fKXCtTi1EwqNdLIrb/oiVN0bOK0wa4czfQXX1t2DNhSC4O5zIpqoU
         LWnqTgQewaGNeEc661zOjxWHCecEes+IOvZ7GHQTwk/ZDAuzCIu0tj7GHu7jPIMgxiTu
         JNP3qR4Dp7bsuMhD6U17aKb72+CTSIYvCL50BmHgX3A315/mJDlV63sxrQYfC4FU2PXI
         R31g2AjLb0JragkHMg0IYRNfoOSfE61MoIfl9gyCSfpvmxns/Cla2TW7fM1TbC6JDBzg
         bdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308744; x=1706913544;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3OQPNBRoI4s9xk+w81XwIFGbiMy8piXg1fxcmhx8Hc=;
        b=Z8DZ7KtkdoBbZsyiFdxgpxw8QfLedTuxYr5xuCECf2ZCZqFGOr2wmAJLboVM4vUTp3
         75iT71yFHT4YWpdjCq7sCCpLpPXRuJ8fGBUUS+N1Mo/yQaVa1q/5C1swwmE8YKO5FYa1
         QCpOQiGbyb5Kl0XdnlluwNTZWMTylAZwxqP27yrcOQbs+9SSrKyKCoUF/8h9R9WXeBYZ
         6e9u4lH7NdJ8Ryp07KHWJ6jdzd64tBOUGm9hr+JirbplM2Aja6H4TCCKg5awIJifZduH
         43kI3ODpz5WilWl1zglDqUDXNRlr4XjlYai7QcCRvv41m2i6HcgyEFJUXfq72PoN4DT+
         i5LA==
X-Gm-Message-State: AOJu0YxG9foenjb+lsU7S+xApj5S+pRBGN9sdNCddsHKsyfxJA8jtW3s
	MSPU/X6fl6yXmdvQLmLO28DkBY1gMVTVp8kbHJPcISTMAaMsVaV/wdcaP2Lk
X-Google-Smtp-Source: AGHT+IHtiRWHqvuiA4HKqBRkSgAiD6UB9BTy1YhOSv6LXXRsqN9H8ggj53SO1v1xEq+yfcPL9KJ7VQ==
X-Received: by 2002:adf:e544:0:b0:339:5570:59e7 with SMTP id z4-20020adfe544000000b00339557059e7mr287989wrm.49.1706308743912;
        Fri, 26 Jan 2024 14:39:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020adff745000000b003395642bc9bsm2104951wrp.117.2024.01.26.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:39:03 -0800 (PST)
Message-ID: <5ba842b5005ce2099a4de2884d48bfc894ce4c2c.1706308737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:52 +0000
Subject: [PATCH v2 05/10] sequencer: use the trailer iterator
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

This patch allows for the removal of "trailer_info_get()" from the
trailer.h API, which will be in the next patch.

Instead of calling "trailer_info_get()", which is a low-level function
in the trailers implementation (trailer.c), call
trailer_iterator_advance(), which was specifically designed for public
consumption in f0939a0eb1 (trailer: add interface for iterating over
commit trailers, 2020-09-27).

Avoiding "trailer_info_get()" means we don't have to worry about options
like "no_divider" (relevant for parsing trailers). We also don't have to
check for things like "info.trailer_start == info.trailer_end" to see
whether there were any trailers (instead we can just check to see
whether the iterator advanced at all).

Also, teach the iterator about non-trailer lines, by adding a new field
called "raw" to hold both trailer and non-trailer lines. This is
necessary because a "trailer block" is a list of trailer lines of at
least 25% trailers (see 146245063e (trailer: allow non-trailers in
trailer block, 2016-10-21)), such that it may hold non-trailer lines.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/shortlog.c |  7 +++++--
 sequencer.c        | 35 +++++++++++++++--------------------
 trailer.c          | 17 +++++++++--------
 trailer.h          | 13 +++++++++++++
 4 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1307ed2b88a..dc8fd5a5532 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -172,7 +172,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 					 const char *oneline)
 {
 	struct trailer_iterator iter;
-	const char *commit_buffer, *body;
+	const char *commit_buffer, *body, *value;
 	struct strbuf ident = STRBUF_INIT;
 
 	if (!log->trailers.nr)
@@ -190,7 +190,10 @@ static void insert_records_from_trailers(struct shortlog *log,
 
 	trailer_iterator_init(&iter, body);
 	while (trailer_iterator_advance(&iter)) {
-		const char *value = iter.val.buf;
+		if (!iter.is_trailer)
+			continue;
+
+		value = iter.val.buf;
 
 		if (!string_list_has_string(&log->trailers, iter.key.buf))
 			continue;
diff --git a/sequencer.c b/sequencer.c
index 3cc88d8a800..bc7c82c5271 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -319,37 +319,32 @@ static const char *get_todo_path(const struct replay_opts *opts)
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	size_t ignore_footer)
 {
-	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-	struct trailer_info info;
-	size_t i;
-	int found_sob = 0, found_sob_last = 0;
-	char saved_char;
-
-	opts.no_divider = 1;
+	struct trailer_iterator iter;
+	size_t i = 0, found_sob = 0;
+	char saved_char = sb->buf[sb->len - ignore_footer];
 
 	if (ignore_footer) {
-		saved_char = sb->buf[sb->len - ignore_footer];
 		sb->buf[sb->len - ignore_footer] = '\0';
 	}
 
-	trailer_info_get(&info, sb->buf, &opts);
+	trailer_iterator_init(&iter, sb->buf);
+	while (trailer_iterator_advance(&iter)) {
+		i++;
+		if (sob &&
+		    iter.is_trailer &&
+		    !strncmp(iter.raw, sob->buf, sob->len)) {
+			found_sob = i;
+		}
+	}
+	trailer_iterator_release(&iter);
 
 	if (ignore_footer)
 		sb->buf[sb->len - ignore_footer] = saved_char;
 
-	if (info.trailer_block_start == info.trailer_block_end)
+	if (!i)
 		return 0;
 
-	for (i = 0; i < info.trailer_nr; i++)
-		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
-			found_sob = 1;
-			if (i == info.trailer_nr - 1)
-				found_sob_last = 1;
-		}
-
-	trailer_info_release(&info);
-
-	if (found_sob_last)
+	if (found_sob == i)
 		return 3;
 	if (found_sob)
 		return 2;
diff --git a/trailer.c b/trailer.c
index 71ea2bb67f8..5bcc9b0006c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1158,17 +1158,18 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	while (iter->internal.cur < iter->internal.info.trailer_nr) {
-		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
-		int separator_pos = find_separator(trailer, separators);
-
-		if (separator_pos < 1)
-			continue; /* not a real trailer */
-
+	char *line;
+	int separator_pos;
+	if (iter->internal.cur < iter->internal.info.trailer_nr) {
+		line = iter->internal.info.trailers[iter->internal.cur++];
+		separator_pos = find_separator(line, separators);
+		iter->is_trailer = (separator_pos > 0);
+
+		iter->raw = line;
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
 		parse_trailer(&iter->key, &iter->val, NULL,
-			      trailer, separator_pos);
+			      line, separator_pos);
 		unfold_value(&iter->val);
 		return 1;
 	}
diff --git a/trailer.h b/trailer.h
index c309b01323d..a47f18b1525 100644
--- a/trailer.h
+++ b/trailer.h
@@ -127,6 +127,19 @@ struct trailer_iterator {
 	struct strbuf key;
 	struct strbuf val;
 
+	/*
+	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
+	 * key/val pair as part of a trailer block. A trailer block can be
+	 * either 100% trailer lines, or mixed in with non-trailer lines (in
+	 * which case at least 25% must be trailer lines).
+	 */
+	const char *raw;
+
+	/*
+	 * 1 if the raw line was parsed as a trailer line (key/val pair).
+	 */
+	int is_trailer;
+
 	/* private */
 	struct {
 		struct trailer_info info;
-- 
gitgitgadget

