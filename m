Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7E53D0A9
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725596043; cv=none; b=BrQKIhOuQzwtkm2tiKTCMQBgVAJS/BY9fvV1YYj9wkJFgzN0iBOLSOqzSFxvJ+4zK2AM2ZJZvBO4NGPhehQJ5AslTrJWQu7Bgr00AuF4s+TyAlKAtJXFQyu/l4uI0efAzJdso2M33469R6SjJH9xsUPvX/rgyzHdAr48pR5pSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725596043; c=relaxed/simple;
	bh=eG/lOJkSNDyHiE9SJS+cE5QsZzYh2vEuk/KtZ5f5uRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRGSbqSFjToebJ9LIbfnGtJxq5HhaVS7Fx87BG2yHr8EgJhOV0tTv2OuNfuKurDUG/pykDxT9NP9kXfI8xKRJnEedcG8oZAHkJ0EyjSIUPXx5JaGL2vzS7HHuJ11ACMG4bfc6FRpCMf4PHloUxQCJK7n5JoZBtP3Rui0xJh6Xjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCFBXmfg; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCFBXmfg"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3df09d398faso1052274b6e.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725596040; x=1726200840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T66eS1vMkCOza6r351eDeXdrLgXXcrXhwtBQvVmNkoA=;
        b=fCFBXmfg13pPJVmmC124qWGDQ5AFOGnKN+cvdn8BGwATpYUADWOa5tDS1pJF/8ikp/
         PZSaAfP+DdMBbTPAI4kj1Soz0pCjkr09p+tZF3m2Qj5+M8Vat57tlc40n56dhf+kWycZ
         lQm5Zlp6Gq/J8tuDMk2ATBS54axyWYDfpy54Q/kBA9hA9xvp88BRiCpvCczTyIysgLA2
         xaD9FRJJwYgikGkLC/gUjMrBquiLkb7AksMREPHyb6N32T75xmu0gLk1w31zV500CCe4
         tpA4D3WUqp7zQNMw1QoGH3VLUrzSTkeefv6sbeB/KP4Zza26vxzg9uumYIvU1Jh2lvsh
         oeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725596040; x=1726200840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T66eS1vMkCOza6r351eDeXdrLgXXcrXhwtBQvVmNkoA=;
        b=cWJGsK2Xe5Xy31fXvFPnFPRHXhultdWYe6GwU4bxwMqHss0pC01q9wOlI1Py7D2kiG
         14Kl5rQwUdLzFdBUNY1PZvZ7xeDmHDGNjqmb1zXQQRXFXeafonaVKP8LFrMaXrEzAXnh
         ZyxFMXrjmvR4LE3Qxbwv0f45bNFtzcOyz8U6g+nai+HA4GF5abCREOMyL20jnSdoyoKQ
         fyRJIMBdToA+CQMgWR5hMy4kulqqNsAvif9rdkGWerrCh2ZrB+CwTNQHZ1++vyHu1XYx
         y/Gp7USMLUEh/S8SJbDokz8pGT3ius53uJZPmjNCtYuAuHz5CYjUJ6hL4TD0waLBDQRY
         kd3w==
X-Gm-Message-State: AOJu0Yz10GdRFGqViHa+BdHwhmVvQ51STGvC27H+Lzc56CPamvYWdlVZ
	ry3hpxCT5xi9Xm5RL/Kbc8uUe1rcXw/OCpmAjFmE3UzXs26wOucZcrRrNg==
X-Google-Smtp-Source: AGHT+IFSq0cjo3OBKnzOSUhOW2M/UI5A9xSXiZWeHLa3w1TmeI0m+pNDZ1c2Y3QVOBMWotsc3UnIBw==
X-Received: by 2002:a05:6808:228e:b0:3d6:331d:b52d with SMTP id 5614622812f47-3e029cd2cb5mr1675418b6e.4.1725596040410;
        Thu, 05 Sep 2024 21:14:00 -0700 (PDT)
Received: from localhost.localdomain (syn-024-241-228-214.res.spectrum.com. [24.241.228.214])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df11865a48sm3525783b6e.43.2024.09.05.21.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 21:13:59 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH v2] interpret-trailers: handle message without trailing newline
Date: Thu,  5 Sep 2024 23:08:41 -0500
Message-ID: <20240906041326.1684570-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905173445.1677704-1-brianmlyles@gmail.com>
References: <20240905173445.1677704-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-interpret-trailers is used to add a trailer to a message that
does not end in a trailing newline, the new trailer is added on the line
immediately following the message instead of as a trailer block
separated from the message by a blank line.

For example, if a message's text was exactly "The subject" with no
trailing newline present, `git interpret-trailers --trailer
my-trailer=true` will result in the following malformed commit message:

    The subject
    my-trailer: true

While it is generally expected that a commit message should end with a
newline character, git-interpret-trailers should not be returning an
invalid message in this case.

Detect when a message exists but does not end with a newline character,
and add an extra newline before appending the new trailer.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Differences from v1:
- Minor tweak to commit message wording
- Updated stale documentation from initial prototype to accurately
  reflect the actual state of the code.

Range-diff vs v1:

1:  7f67f06a08 ! 1:  af02465f86 interpret-trailers: handle message without trailing newline
    @@ Commit message
         When git-interpret-trailers is used to add a trailer to a message that
         does not end in a trailing newline, the new trailer is added on the line
         immediately following the message instead of as a trailer block
    -    separated from the message by a newline character.
    +    separated from the message by a blank line.

    -    For example, if a message's text was "The subject" with no trailing
    -    newline at all, `git interpret-trailers --trailer my-trailer=true` will
    -    result in the following malformed commit message:
    +    For example, if a message's text was exactly "The subject" with no
    +    trailing newline present, `git interpret-trailers --trailer
    +    my-trailer=true` will result in the following malformed commit message:

             The subject
             my-trailer: true
    @@ trailer.c: struct trailer_info {
         int blank_line_before_trailer;

     +   /*
    -+    * True if the last character before the location pointed to be
    -+    * trailer_block_start is a newline character.
    ++    * True if there is a message before the trailer block and it does not
    ++    * end with a trailing newline character.
     +    */
     +   int message_without_trailing_newline_before_trailer;
     +
    @@ trailer.h: size_t trailer_block_end(struct trailer_info *);
      int blank_line_before_trailer_block(struct trailer_info *);

     +/*
    -+ * Return 1 if the trailer block had a newline character
    ++ * Return true if there is a message before the trailer block and it does not
    ++ * end with a trailing newline character.
     + */
     +int message_without_trailing_newline_before_trailer_block(struct trailer_info *);
     +

 builtin/interpret-trailers.c  | 12 ++++++-----
 t/t7513-interpret-trailers.sh | 40 +++++++++++++++++++++++++++++++++++
 trailer.c                     | 18 ++++++++++++++++
 trailer.h                     |  6 ++++++
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 1d969494cf..9d8f94341d 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -153,13 +153,15 @@ static void interpret_trailers(const struct process_trailer_options *opts,

 	info = parse_trailers(opts, sb.buf, &head);

-	/* Print the lines before the trailers */
-	if (!opts->only_trailers)
+	if (!opts->only_trailers) {
+		/* Print the lines before the trailers */
 		fwrite(sb.buf, 1, trailer_block_start(info), outfile);

-	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
-		fprintf(outfile, "\n");
-
+		if (message_without_trailing_newline_before_trailer_block(info))
+			fprintf(outfile, "\n\n");
+		else if (!blank_line_before_trailer_block(info))
+			fprintf(outfile, "\n");
+	}

 	if (!opts->only_input) {
 		LIST_HEAD(config_head);
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 3d3e13ccf8..d5303c3f74 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -175,6 +175,46 @@ test_expect_success 'with only a title in the message' '
 	test_cmp expected actual
 '

+test_expect_success 'with a bodiless message that lacks a trailing newline after the subject' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "area: change" | \
+	git interpret-trailers --trailer "Reviewed-by: Peff" \
+		--trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with a bodied message that lacks a trailing newline after the body' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		details about the change.
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "area: change\n\ndetails about the change." | \
+	git interpret-trailers --trailer "Reviewed-by: Peff" \
+		--trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with a message that lacks a trailing newline after the trailers' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "area: change\n\nReviewed-by: Peff" | \
+	git interpret-trailers --trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with multiline title in the message' '
 	cat >expected <<-\EOF &&
 		place of
diff --git a/trailer.c b/trailer.c
index 72e5136c73..178adae6ad 100644
--- a/trailer.c
+++ b/trailer.c
@@ -18,6 +18,12 @@ struct trailer_info {
 	 */
 	int blank_line_before_trailer;

+	/*
+	 * True if there is a message before the trailer block and it does not
+	 * end with a trailing newline character.
+	 */
+	int message_without_trailing_newline_before_trailer;
+
 	/*
 	 * Offsets to the trailer block start and end positions in the input
 	 * string. If no trailer block is found, these are both set to the
@@ -946,6 +952,11 @@ static int ends_with_blank_line(const char *buf, size_t len)
 	return is_blank_line(buf + ll);
 }

+static int has_message_without_trailing_newline_char(const char *buf, size_t len)
+{
+	return len > 0 && buf[len - 1] != '\n';
+}
+
 static void unfold_value(struct strbuf *val)
 {
 	struct strbuf out = STRBUF_INIT;
@@ -1017,6 +1028,8 @@ static struct trailer_info *trailer_info_get(const struct process_trailer_option

 	info->blank_line_before_trailer = ends_with_blank_line(str,
 							       trailer_block_start);
+	info->message_without_trailing_newline_before_trailer
+		= has_message_without_trailing_newline_char(str, trailer_block_start);
 	info->trailer_block_start = trailer_block_start;
 	info->trailer_block_end = end_of_log_message;
 	info->trailers = trailer_strings;
@@ -1090,6 +1103,11 @@ int blank_line_before_trailer_block(struct trailer_info *info)
 	return info->blank_line_before_trailer;
 }

+int message_without_trailing_newline_before_trailer_block(struct trailer_info *info)
+{
+	return info->message_without_trailing_newline_before_trailer;
+}
+
 void trailer_info_release(struct trailer_info *info)
 {
 	size_t i;
diff --git a/trailer.h b/trailer.h
index 6eb53df155..81449151c7 100644
--- a/trailer.h
+++ b/trailer.h
@@ -125,6 +125,12 @@ size_t trailer_block_end(struct trailer_info *);
  */
 int blank_line_before_trailer_block(struct trailer_info *);

+/*
+ * Return true if there is a message before the trailer block and it does not
+ * end with a trailing newline character.
+ */
+int message_without_trailing_newline_before_trailer_block(struct trailer_info *);
+
 /*
  * Free trailer_info struct.
  */
--
2.45.2
