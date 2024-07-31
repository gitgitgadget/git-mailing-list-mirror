Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71CD1B0136
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433241; cv=none; b=QhIEu07Yb7mT3wrLqPD1eF9EC56JOoDshl2hTjJkkoQEseXqXeCbx1jBlmBVrwoNpO18eKqnKY3llB51HfUgYEwsu3RBu0Z+5CdWIMp6HXDs5o114czzfOCTFGvz6OigjL1ttxtK3qlXMTnKtjXTLpMUOZ5lf+R19foB1ifjZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433241; c=relaxed/simple;
	bh=inQhiDsZ0H9gi97ogwBjxug7M3qeW2t+atYHE4WdQ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ck/sMI54H0br/XSSgXKw9YmKWPutTgFexA/IJkdiGHk6xJUTrpLWbgFLAvAAtrVNi1qhZiQt4QUVk/cg3KXVywrQVP8yIb3PfhJHYw/U7/QGo/3k17q33EamFw7KfUIt6h+qhFhfHKpEKMjsejWUN1cOaxWDHOwVSd3i0UuE7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evp2jB+Q; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evp2jB+Q"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so9163173e87.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722433237; x=1723038037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuF3fmx0tQS7Jo2Nthk5t8HYgW9Wp3lOo6Sg4ynamPU=;
        b=evp2jB+Q2tVw700tB65qJN3asnoc5fYvTyK1TFhdxhBm4R861Asi7wkR0oaUPQwbVs
         +BzrQP8L36gc5JfJYNtAL82A7AeZ+y10uIS2jG7aJWFmd/3HT4o61yVPW3ak5DjHcOY4
         pSU1/og5hwb9Gvgehcl+zwkwVRVSXjVN8VnHyqWQYjYi0nKsJjruzSHZRMA/woOQNJbc
         jYaGXv1f/Z9H1HXRwKD4ykEc/ENJZrP7jpKywMu9N1cT2bd+GtU+SAKy6LA/pvuMYY0I
         +gAEMxPuao1C/XDuIUu/icef9zFBOKtPC0F/oBVjn3ujarPZHMdBKHy6E/XRPiIOZmSW
         33Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433237; x=1723038037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuF3fmx0tQS7Jo2Nthk5t8HYgW9Wp3lOo6Sg4ynamPU=;
        b=tqh02EnEaajtm2vo+Ha2TkfOe2rQvhgbq0PO+2+O7O0IeYITfWH08wMfev8eCInnIL
         7yKVyrpMb0LDC6fMr3XhsRDZ1OE0h5ty41dk5pz3jItlYRusDQ9p2ebtdWuSXlD4Rk1B
         3uGUPA3kpQutoPyD6ahRU2zH4m9pQvjo1fAYJViR4xJgGEn6zWLI11j5ydn+uMbdVH9s
         iZ6p4tJ1nSLaItww0tTL5I+EfTCYilTTQtBw1qA17Z9BzwudGjUYy1l3ECg73Mz0AvmZ
         ktQuqYpWGQ04YbA56M7sad6s73gDvqDa+z1NhgN7wQEnAq1N+5Z7cD9lBn8/yOI8a8/G
         DMZw==
X-Gm-Message-State: AOJu0Yz+l4O8d5x5kxevEeksV7/Faomq9WkMxC7r+d+oD2wu7ZPs3iM0
	pOHLJ1nEgEL2yIROmgGebmcoDpEVvB23wpUH0Vd+FjsFCdn5U1pUX0zHJg==
X-Google-Smtp-Source: AGHT+IF3r9TBZ6CXJwhKGbhPFVxF8uQu7OqFd53euzLw6nsekgVu3q68pySyZbbHkr6djoh4JyUcng==
X-Received: by 2002:a05:6512:3e08:b0:52e:bdfc:1d09 with SMTP id 2adb3069b0e04-5309b26c090mr9814816e87.18.1722433236959;
        Wed, 31 Jul 2024 06:40:36 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63c50fdesm8669641a12.56.2024.07.31.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:40:36 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] version: refactor strbuf_sanitize()
Date: Wed, 31 Jul 2024 15:40:11 +0200
Message-ID: <20240731134014.2299361-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.4.gbcb884ee16
In-Reply-To: <20240731134014.2299361-1-christian.couder@gmail.com>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git_user_agent_sanitized() function performs some sanitizing to
avoid special characters being sent over the line and possibly messing
up with the protocol or with the parsing on the other side.

Let's extract this sanitizing into a new strbuf_sanitize() function, as
we will want to reuse it in a following patch, and let's put it into
strbuf.{c,h}.

While at it, let's also make a few small improvements:
  - use 'size_t' for 'i' instead of 'int',
  - move the declaration of 'i' inside the 'for ( ... )',
  - use strbuf_detach() to explicitely detach the string contained by
    the 'sb' strbuf.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 strbuf.c  | 9 +++++++++
 strbuf.h  | 7 +++++++
 version.c | 9 ++-------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 3d2189a7f6..cccfdec0e3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1082,3 +1082,12 @@ void strbuf_strip_file_from_path(struct strbuf *sb)
 	char *path_sep = find_last_dir_sep(sb->buf);
 	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
 }
+
+void strbuf_sanitize(struct strbuf *sb)
+{
+	strbuf_trim(sb);
+	for (size_t i = 0; i < sb->len; i++) {
+		if (sb->buf[i] <= 32 || sb->buf[i] >= 127)
+			sb->buf[i] = '.';
+	}
+}
diff --git a/strbuf.h b/strbuf.h
index 003f880ff7..884157873e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -664,6 +664,13 @@ typedef int (*char_predicate)(char ch);
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
 			     char_predicate allow_unencoded_fn);
 
+/*
+ * Trim and replace each character with ascii code below 32 or above
+ * 127 (included) using a dot '.' character. Useful for sending
+ * capabilities.
+ */
+void strbuf_sanitize(struct strbuf *sb);
+
 __attribute__((format (printf,1,2)))
 int printf_ln(const char *fmt, ...);
 __attribute__((format (printf,2,3)))
diff --git a/version.c b/version.c
index 41b718c29e..951e6dca74 100644
--- a/version.c
+++ b/version.c
@@ -24,15 +24,10 @@ const char *git_user_agent_sanitized(void)
 
 	if (!agent) {
 		struct strbuf buf = STRBUF_INIT;
-		int i;
 
 		strbuf_addstr(&buf, git_user_agent());
-		strbuf_trim(&buf);
-		for (i = 0; i < buf.len; i++) {
-			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
-				buf.buf[i] = '.';
-		}
-		agent = buf.buf;
+		strbuf_sanitize(&buf);
+		agent = strbuf_detach(&buf, NULL);
 	}
 
 	return agent;
-- 
2.46.0.4.gbcb884ee16

