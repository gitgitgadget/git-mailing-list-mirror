Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AEC538A
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 01:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664154; cv=none; b=M6EZvQdqB5ZVsGnN/SwHyHtg/9uiO8qnF1VMQm3qd+hlAX5SXpARR3yEcK1REuF1TxG+PaAU0qcQPOe1Jaxhxn4DhtlgaXIXR4TVMnU2cwCIVHb0D6AB/0oA5Yggqa6Ui0KDu6cepGhIMeZzPxxYIy+f9W9k7IRnwc7KvH/7kvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664154; c=relaxed/simple;
	bh=q1YPuIGuy9Tyw9goIgwi43rgcK2T5+A0V2OoozjLGiY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KHM5RuGNQiBHUA+vcC07ZWal56yAmmaFhX0/K2Q6aiczbiMZF7IJv3iYl4dgJvwChFmzGPplVpbQbAzMpnlPmq+dOb8ltC5c/b22SqRYE16gfaWTZVFWTWe2SCOfBhnFvYchNKctSw0laT1d6Dm8Pzoz1+mzu53z4muM3ctPoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDv7Cz6P; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDv7Cz6P"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ae53eb5a8so2164430f8f.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 17:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706664150; x=1707268950; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+S8JwqhMBSjfpGulKSpBMHKeVvufhIUPwqrrKVw+os=;
        b=VDv7Cz6PTCRw4ubZPdgd4siCAcO4QrERZ7QkESuLp85puailUPc4svnf4a3Tjoj2n7
         apAYTX8zBkhL+g0GHnMGI+2CzDOG8UmmIeZvJgiVxd7iiraO3afn7eSX8puUdWUISpkz
         QCdkIfGRRgiIK3Zn51iyNDsEx0+21nTR+S3FSmx7Jh1qnms182/QKhhbSydtpSH9o9pk
         R3as5/U9UN8PzSNS1OZpyAUdqI4+2PswoYutoeb3G1KvUxJqQsCmdmTR/j7q5HPniB0u
         yjcOLotWSvuLZ9iaKuRD9Gs1KfOGBYlCz+us3ArY0B5unC7MHMMf+NN/YaQmkmI14SF0
         aX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706664150; x=1707268950;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+S8JwqhMBSjfpGulKSpBMHKeVvufhIUPwqrrKVw+os=;
        b=pDEmZKsxVLsMSIUC7v8GjML8bG+JV0as4/xTXfdmMLbeCg/Q+WXBjcIZOFb2iZO5oW
         KyL4LgdPGrdN3Ff3EiHBc4wb8UjyJM6lq4BVu2/5XZUuJNkXFdmtmqZbhROrISLnDChI
         t4t/9WFF029ak/3g6fd+UaitPIvwLR8kQ6VRpn/M/xUlNy899NTZ3HREi3BXU4fSEstI
         LKkTnzoDAR2/PlsJBCA2TIGGk5QxziQ5DltzrsNhjAdM8ZQXs9DGYiJctO4bzEki295B
         ukx79fe66dUvRBfKP4COXSURYcKs/yAVeLUQWddWTmiwfVGqJwf4UgX0cpqF+a0Hwyj0
         Jtcw==
X-Gm-Message-State: AOJu0YxMugB4x4ek21DcFqoGrwPi0TbDbvgP19G4fxorQslRnqXHmEf+
	jUuONxAeKy21WOYGJiBx+g1JLtiZfGeGXKAzxUHJQgv8YH82iP2dgCpe1ans
X-Google-Smtp-Source: AGHT+IEsXYzPpPfCfsZkhiesVL7X8C3KUWp4vy4u3ES35GLke1S7z68AOTQg3S5pioAb7YDZhxuV5g==
X-Received: by 2002:a5d:4d44:0:b0:33a:e808:31a4 with SMTP id a4-20020a5d4d44000000b0033ae80831a4mr77831wru.55.1706664150350;
        Tue, 30 Jan 2024 17:22:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14-20020adff28e000000b003392172fd60sm11930404wro.51.2024.01.30.17.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:22:29 -0800 (PST)
Message-ID: <bf2b8e1a3c4bc77022fab1ebaa0fc89a7813b4c4.1706664145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 01:22:18 +0000
Subject: [PATCH v3 04/10] sequencer: use the trailer iterator
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
index 244f29fc91f..a7599067acc 100644
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

