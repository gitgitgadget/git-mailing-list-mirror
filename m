Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7E24EF9B
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369128; cv=none; b=mDO+rKhASGwkTDCRy03D/2k6JUCeY8h5rCi0keXcWNeEi897jWpM2q2Z1ORybc53XP8e6dZcyVGVHQOl1vEWHLlX4FseuuUDgZ76sUEkv36xc6v3mKqUILvU6VpBI0Hzs4sllFjCE9Wk2+OI8YpJI7Mpl1zsWuhfnH/AEwaq4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369128; c=relaxed/simple;
	bh=gz1prJjDZEcrqdQ36GW6UD6vsUPNdi/R2etgQN8/klo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exBlTA/sTwfT09BseUDphxmnBM8Mt6wx+5Z86O1WpxIS7ZSnOqd0eTlvpm3vauP9tYPyFeEXJSYjyGCMc00HloC4R4BbCXiIxVkYM/hU4WY7tkXkViJm+dQ7JCMGdWXGDgj7sJB78bi0ElS610AOaL5a+5cYiJeMtxHJE5B6FIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBA+/3zl; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBA+/3zl"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a6bso71381271fa.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369124; x=1742973924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNfmTcWnY80hZ5/wwAmLAry92b+eyfMdh8mS6MNaui4=;
        b=bBA+/3zlMw4Pxd89vbPpiVVIgWfrZucLyikwrJOvAgHYhCBPKONmOnPbNqINWUI8qG
         jx4VsCqfmF7Te4drlZ87Bo7R596VpF2dCguZFrBzWPMhnXmZavJhvEQpEUzvb311eLGd
         dN/9z9v4U0uzo2ZwW4ds4+rig+idSrnXYKZJKj8JO++8y62NuaqnK/KXzQcUH4qV+kFY
         dG1EDIOK3/iQJX2wsMUzg8tr+24Ca5fBHcAGrPWbsgsj1CqT4DuOnaHSEqD36A0DjQ1E
         cMV8dyfEaRrKo0/5MxDucULiCGI9wLKy0HIodagFz6UVI482HON7aRvm7s9Nt6B00FSQ
         lnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369124; x=1742973924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNfmTcWnY80hZ5/wwAmLAry92b+eyfMdh8mS6MNaui4=;
        b=xDxE5MGQHtI4QbnxA///uMfR44Nee6Os7Z1eizfvmWz0EoGb8ufOOy6Uddm4fFH03I
         Sbyc69tluIWh7+PFmCpTuv1yDO3YWgoWrxWAdQlsMEr/m2Wgg5Lv2wY4ZZVVXEkjb5+r
         HqHPvkaDcp9wqSBDSEZkkXRn1yIqj491fi5AsvhPtMAtE4YUkmPHafkXspaHJAdzOVv5
         8Cubya45jIIuUZdlY4AnM3v5SDGNeUDh+cionG5QBJUsicOSD1X7XEKG3a6+ks80+tbD
         ES//GXm5R/+ycK0vLMvXpwLWu6e8YLqm48dBNKKHF1eLTzNMsMqy2o3N6ZyG2KiQzZV8
         JKpQ==
X-Gm-Message-State: AOJu0Ywi/ABfOdMh9C4cx+fVuBtNCfHGSfv1nPNSurOl+M76fg0DWiKU
	bxUqtYWKz8+fv3IR4kg1Fi8jQtdqvb0B67tjbWo0AeG9LJ25+q1LICmomA==
X-Gm-Gg: ASbGncu/yhhCEgz+NIryXNeqeJEFtPx7bFGOgdS91XCp6rQQbrSkbmR+FQjk2Fgweh+
	ojegOpIz9ivTrD0hBx4nR2B5Upvf7S2+mqSjoGYH7Q1b6zBZxJ5Zj3BdZSPdkQ5h1qwrS0hUH/x
	QfZ4hAd80qbURmgXUME7GQHCRfi9/IU53RfDd9XEy7FtLQlsPSWWOzoa/8Heo3Wv329YkYqR/i6
	nkqXGSL2tVeDGv5c6FpqABLP97B+uA+lhpw2JoPOePpiSRjQmU95qvRgADBQ++26YBuE62n20D/
	e1WdMTMUkLTtSEw1KgvhZPrh1siAkCWiR41ybNIZHC/crn2HjwONl91KXBHKLg==
X-Google-Smtp-Source: AGHT+IF07wVyw1cWzRmuSx5fEId0Gmclgp+f8d7avXzCzOnCKGrROP32dgB8bVegVtdK+jQxhHSufQ==
X-Received: by 2002:a05:651c:b10:b0:30c:189d:a169 with SMTP id 38308e7fff4ca-30d6a44c2ebmr7112401fa.25.1742369123496;
        Wed, 19 Mar 2025 00:25:23 -0700 (PDT)
Received: from localhost.localdomain ([217.116.228.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm22089541fa.112.2025.03.19.00.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:25:22 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] pretty: refactor parsing of magic
Date: Wed, 19 Mar 2025 08:23:40 +0100
Message-ID: <7c96899bb520ab945a650205982f54d65461d5bd.1742367347.git.martin.agren@gmail.com>
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

Similar to the previous commit, pull out our parsing of initial
placeholder magic into a separate function. This helps make it a bit
easier to get an overview of `format_commit_item()`. It also represents
another small step towards separating the parsing of placeholders from
subsequent usage of the parsed information.

This diff might be a bit easier to read with `-w`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pretty.c | 69 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/pretty.c b/pretty.c
index c44ff87481..ddc7fd6aab 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1929,17 +1929,17 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 	return total_consumed;
 }
 
-static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
-				 const char *placeholder,
-				 struct format_commit_context *context)
+enum magic {
+	NO_MAGIC,
+	ADD_LF_BEFORE_NON_EMPTY,
+	DEL_LF_BEFORE_EMPTY,
+	ADD_SP_BEFORE_NON_EMPTY
+};
+
+/* 2 for 'bad magic', otherwise whether we consumed 0 or 1 chars. */
+static size_t parse_magic(const char *placeholder, enum magic *ret)
 {
-	size_t consumed, orig_len;
-	enum {
-		NO_MAGIC,
-		ADD_LF_BEFORE_NON_EMPTY,
-		DEL_LF_BEFORE_EMPTY,
-		ADD_SP_BEFORE_NON_EMPTY
-	} magic = NO_MAGIC;
+	enum magic magic;
 
 	switch (placeholder[0]) {
 	case '-':
@@ -1952,28 +1952,43 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 		magic = ADD_SP_BEFORE_NON_EMPTY;
 		break;
 	default:
-		break;
+		*ret = NO_MAGIC;
+		return 0;
 	}
-	if (magic != NO_MAGIC) {
-		placeholder++;
 
-		switch (placeholder[0]) {
-		case 'w':
-			/*
-			 * `%+w()` cannot ever expand to a non-empty string,
-			 * and it potentially changes the layout of preceding
-			 * contents. We're thus not able to handle the magic in
-			 * this combination and refuse the pattern.
-			 */
-			return 0;
-		};
-	}
+	switch (placeholder[1]) {
+	case 'w':
+		/*
+		 * `%+w()` cannot ever expand to a non-empty string,
+		 * and it potentially changes the layout of preceding
+		 * contents. We're thus not able to handle the magic in
+		 * this combination and refuse the pattern.
+		 */
+		*ret = NO_MAGIC;
+		return 2;
+	};
+
+	*ret = magic;
+	return 1;
+}
+
+static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
+				 const char *placeholder,
+				 struct format_commit_context *context)
+{
+	size_t consumed, orig_len;
+	enum magic magic;
+
+	consumed = parse_magic(placeholder, &magic);
+	if (consumed > 1)
+		return 0;
+	placeholder += consumed;
 
 	orig_len = sb->len;
 	if (context->pad.flush_type == no_flush)
-		consumed = format_commit_one(sb, placeholder, context);
+		consumed += format_commit_one(sb, placeholder, context);
 	else
-		consumed = format_and_pad_commit(sb, placeholder, context);
+		consumed += format_and_pad_commit(sb, placeholder, context);
 	if (magic == NO_MAGIC)
 		return consumed;
 
@@ -1986,7 +2001,7 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
 			strbuf_insertstr(sb, orig_len, " ");
 	}
-	return consumed + 1;
+	return consumed;
 }
 
 void userformat_find_requirements(const char *fmt, struct userformat_want *w)
-- 
2.49.0.472.ge94155a9ec

