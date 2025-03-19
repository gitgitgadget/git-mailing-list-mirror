Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD524EF7F
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369119; cv=none; b=PW8rFA0UFrcaqggRob9ZVU++LmNBWGtnX+76HdaHGYyN2fdvWqjvDNVJspt8+Lrh0IB/HZg3SdQSmOV1sgyIFjgiGpRLLyf+JQd5x9Tx/HOwv6UA23SWULA/yZJV5485vXuoboS2XJBZ9kt14o2NUatdN9Q4anQNh22PiW1pI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369119; c=relaxed/simple;
	bh=KLlDS11N3toOVeq97bE4WJrpZY69S6KAyE0yuUU6HuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS/dZcIWaRfh4CEQCUX6k8z3DJuQp2tUovN3I2S4GmD5Q9pny+uAJxZgDi0ybBgCEeJoebg+mjEKWDemdHYLf6TBjf44ID8KRKsygglJVdd6xOFOockH0Tf1ZUeDiCFb34Hr03ox5r/scxid0SO6XdPBXwdyHnJ030X/j2fDonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ9WR8nV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ9WR8nV"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso4279051fa.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369115; x=1742973915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN4tYwhgPHK4P01ThUx2abeHiZpY3QAT4sT12lJH4nM=;
        b=OZ9WR8nVptJSH0WMTIi9yEFRFEevTpaJjbwObBReoTnPYmIx5LK0NflH2AogjpNDjl
         sMsjF6jWOF4y6bP0f76I9mId1XUfqIyCBvTjACdcXICjR5XE/aD15H7eGqFdveLe6fp3
         VwsBT9oFm/R8ZD5MIdPVVnBLof2i17gMEu+NrNJ7qrpINWJzrUoSz6swWhOSZ+WHZgYT
         KWBN3qDPOQlLRjqSLbLiz1kFxC61ZClkSrLexPLnNbhCiW+931gW9eoyTfQ1s9bLwZJG
         mQOkOy3OBXw0easha8wlw/CCkV4ji2ZvDuUTf38P7DmZ201meoyH1TLm2bZ7mrYSVCVr
         zTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369115; x=1742973915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZN4tYwhgPHK4P01ThUx2abeHiZpY3QAT4sT12lJH4nM=;
        b=npbBRmPzuKAEcEBjfWKiqvKsX3ZcLdsqSAZ1mjC0Q0T85Zh45Z3zo/FO1mTjji0H+7
         Kbb++mdmZRFhwL/UIqzmisqtxl2VC1AHZBVeNxd0XatRfi4dWoEGteeBGGRlwatqwjq8
         eXR59rOjAPLJyi6PHKcNmiu2OhN36aiswWI1th6bjLf3H5m3B2Etfsi3tUiYJmkUmfeq
         Yl8XPfReYNSy+yZp3NsYyc05cOybK9JKk4jvvF5tRybvYc3MU40CzvOmhbaWrohs9odz
         8sORDz/KaVQL9GNxdI6XiasXYXolSyHlar1qXQqfq+MR/zyW4cTuaCo6kdisveOCGjUJ
         PnJw==
X-Gm-Message-State: AOJu0YyJ3le93VE/6fjjGKNf1zQrK8P8azagM8J4n6W7SsZyKV9RTU4p
	Z6+ub8E18vnbaPgRxRUkDTmPLPM/HtjR1yUXlacu30hN8n4ZgJv92Go50A==
X-Gm-Gg: ASbGncsmpltwsegDEpNz+szjTMXohE3bY1upFJMnGXp/1oOgIr1USMWACbsKMqp9Djb
	Ijk8ACqUMKg4CCuFJ7ZTsELLRXVsZD+NDhZAfsR7QwR0l00CJU3lzhX7FNxG32lHopSCFzF00Vn
	N4xcx2Z8tPzc5P5tPFrTL1TtzLUxN7hxU6F5nOrN4AIYFsrG3HckGXq2KnhkR3AG5mOvm4mwyyP
	mVy9UA1tB87TGIn4ReWIpOm2CSQ3Cd++ZBrvsrFgnkKD5iXlSZV+gMmUxy0Vm/ZxFTDbpSptENw
	41irfre213dg2NTESo5iceqTQ+t42K29KNp/ZJseG6sQYjawraOxqdMPjIl1LA==
X-Google-Smtp-Source: AGHT+IE3MmY3WxGvFV5yqLAAU+lcClDsbj+rIRc34h6l28oOGJnWHbuccls2fRns2hUmvwAu1oS6KQ==
X-Received: by 2002:a2e:9cd2:0:b0:30b:f599:d78f with SMTP id 38308e7fff4ca-30cd95bc544mr33748271fa.7.1742369114461;
        Wed, 19 Mar 2025 00:25:14 -0700 (PDT)
Received: from localhost.localdomain ([217.116.228.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm22089541fa.112.2025.03.19.00.25.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:25:13 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 3/8] pretty: collect padding-related fields in separate struct
Date: Wed, 19 Mar 2025 08:23:36 +0100
Message-ID: <1adaa171fb2de74aef811bb5e410a08da72718cf.1742367347.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec
In-Reply-To: <cover.1742367347.git.martin.agren@gmail.com>
References: <cover.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Padding ("%<" and "%>") involves three fields of `struct
format_commit_context`. This goes all the way back to commits a57523428b
(pretty: support padding placeholders, %< %> and %><, 2013-04-19) and
1640632b4f (pretty: support %>> that steal trailing spaces, 2013-04-19).
These fields are not used for anything else.

Make that clearer by collecting them into their own little struct. Let
our parser populate just that struct to make it obvious that the rest of
the big struct does not influence the parsing.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pretty.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6a4264dd01..e5e8ef24fa 100644
--- a/pretty.c
+++ b/pretty.c
@@ -887,6 +887,12 @@ enum trunc_type {
 	trunc_right
 };
 
+struct padding_args {
+	enum flush_type flush_type;
+	enum trunc_type truncate;
+	int padding;
+};
+
 struct format_commit_context {
 	struct repository *repository;
 	const struct commit *commit;
@@ -894,13 +900,11 @@ struct format_commit_context {
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
 	struct signature_check signature_check;
-	enum flush_type flush_type;
-	enum trunc_type truncate;
 	const char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
 	int auto_color;
-	int padding;
+	struct padding_args pad;
 
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -1112,7 +1116,7 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 }
 
 static size_t parse_padding_placeholder(const char *placeholder,
-					struct format_commit_context *c)
+					struct padding_args *p)
 {
 	const char *ch = placeholder;
 	enum flush_type flush_type;
@@ -1167,8 +1171,8 @@ static size_t parse_padding_placeholder(const char *placeholder,
 			if (width < 0)
 				return 0;
 		}
-		c->padding = to_column ? -width : width;
-		c->flush_type = flush_type;
+		p->padding = to_column ? -width : width;
+		p->flush_type = flush_type;
 
 		if (*end == ',') {
 			start = end + 1;
@@ -1176,15 +1180,15 @@ static size_t parse_padding_placeholder(const char *placeholder,
 			if (!end || end == start)
 				return 0;
 			if (starts_with(start, "trunc)"))
-				c->truncate = trunc_right;
+				p->truncate = trunc_right;
 			else if (starts_with(start, "ltrunc)"))
-				c->truncate = trunc_left;
+				p->truncate = trunc_left;
 			else if (starts_with(start, "mtrunc)"))
-				c->truncate = trunc_middle;
+				p->truncate = trunc_middle;
 			else
 				return 0;
 		} else
-			c->truncate = trunc_none;
+			p->truncate = trunc_none;
 
 		return end - placeholder + 1;
 	}
@@ -1504,7 +1508,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	case '<':
 	case '>':
-		return parse_padding_placeholder(placeholder, c);
+		return parse_padding_placeholder(placeholder, &c->pad);
 	}
 
 	if (skip_prefix(placeholder, "(describe", &arg)) {
@@ -1788,7 +1792,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 {
 	struct strbuf local_sb = STRBUF_INIT;
 	size_t total_consumed = 0;
-	int len, padding = c->padding;
+	int len, padding = c->pad.padding;
 
 	if (padding < 0) {
 		const char *start = strrchr(sb->buf, '\n');
@@ -1815,7 +1819,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 	}
 	len = utf8_strnwidth(local_sb.buf, local_sb.len, 1);
 
-	if (c->flush_type == flush_left_and_steal) {
+	if (c->pad.flush_type == flush_left_and_steal) {
 		const char *ch = sb->buf + sb->len - 1;
 		while (len > padding && ch > sb->buf) {
 			const char *p;
@@ -1841,11 +1845,11 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 			ch = p - 1;
 		}
 		strbuf_setlen(sb, ch + 1 - sb->buf);
-		c->flush_type = flush_left;
+		c->pad.flush_type = flush_left;
 	}
 
 	if (len > padding) {
-		switch (c->truncate) {
+		switch (c->pad.truncate) {
 		case trunc_left:
 			strbuf_utf8_replace(&local_sb,
 					    0, len - (padding - 2),
@@ -1868,9 +1872,9 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addbuf(sb, &local_sb);
 	} else {
 		size_t sb_len = sb->len, offset = 0;
-		if (c->flush_type == flush_left)
+		if (c->pad.flush_type == flush_left)
 			offset = padding - len;
-		else if (c->flush_type == flush_both)
+		else if (c->pad.flush_type == flush_both)
 			offset = (padding - len) / 2;
 		/*
 		 * we calculate padding in columns, now
@@ -1882,7 +1886,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		       local_sb.len);
 	}
 	strbuf_release(&local_sb);
-	c->flush_type = no_flush;
+	c->pad.flush_type = no_flush;
 	return total_consumed;
 }
 
@@ -1927,7 +1931,7 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 	}
 
 	orig_len = sb->len;
-	if (context->flush_type == no_flush)
+	if (context->pad.flush_type == no_flush)
 		consumed = format_commit_one(sb, placeholder, context);
 	else
 		consumed = format_and_pad_commit(sb, placeholder, context);
-- 
2.49.0.472.ge94155a9ec

