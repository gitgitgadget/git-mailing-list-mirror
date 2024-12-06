Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0A205AA3
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488992; cv=none; b=evpSBNv61nh7b2hoXfKwhXgEFfN0CRmtcMi7DyqWblntoI7nKei9CacEHKzumiYido4lcFVd0rtdsWe50JQG3G3jHYXe5dfLrYflaGOImrtWoq6drL9oGmgS3vLvleTIHK1IGurxDzPo+YkaU7dMsUiA9I/X7slt2PGhHmweKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488992; c=relaxed/simple;
	bh=JQh6V06k4lThjh4865pSf5cjgG8MzpacqgbD7cBS+p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFJ8lMOyQsebuwqbzeyyBheMEON7STrP2TN11iMnWfpH7qk1hMeOCgmK+PGvaFcye3L+uCroxUE+lgPopsN/O7YYzbPUY/HzjeKawAhCX/Wtp0WMlm2nUtucyhkB89kmed4FEmhJug6VE7AK9bErcwv/icKXroVFK6tvmBQVydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBw4nkQR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBw4nkQR"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso251358966b.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 04:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733488988; x=1734093788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJcXylVXhIZnD6LVag+4lg1ND9yDNAOCRfQCaY+ewBo=;
        b=QBw4nkQRWi6jAOoOROOmrNGChzR5mEbtDRHoRi0Ruju7+XibphC1bcQ1QhRBQzUX/Z
         qv8tjgDYIgxakjZqObSsAq2kcxZ/s+F9VzYRv/kH0edxLabFR8Nf8D4YFWoT+6q/W4Tw
         cwmo1cYXuPfRMtAubVT2EgR/Uwmy2XXicDhXIPqMhgCy9tzsFSEfzaEp+KSPrdDslaoG
         vYp7vNIqTP4baHxPKJO3KtQhMIfiUtgCEaksAp6cG0wa2Zd/Uzr5rntUEihwzSAq+vHs
         1fgP+UpWTEloBZuuwqPPJ6AsWJ3+f2bZNoeQNy9jYMWAdYFLKBZZ4ELR34yrsykSS+X7
         S/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488988; x=1734093788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJcXylVXhIZnD6LVag+4lg1ND9yDNAOCRfQCaY+ewBo=;
        b=l6Wxpnq0fVRh3orsckefVOIw9nD8IX3mDlltxktEt1VJwULEUZy6x59yWU6qCBybOC
         bhjZhCgv5V5ni3bt96B38IQsdithOUSemdaSkprjZknwMBTvQMFmUxeg0JXYY4JwsmBo
         TYOkK2lENoZk2ctOJwb1wN28WLP4wOZaEjoAUvTAE9zZ3Vfl69vvE8sdwfvdKt11mNuN
         No2GoYcfI+/0Rouj7WfyM7JTb807yBhxZ/UL3xrGTQE9bElebGuWElqsmaWuY/DjQYNL
         vUHWeDUYhJ4DB9/b/zOx/8gMXCg5YsirRmHcuIgs/wGEloIvcaboEGCt8J6VBvGaFoog
         R5FQ==
X-Gm-Message-State: AOJu0YxRQZBQd7KudS1yL5ZeN608Pe7zrV6i+GhmkfgdZCRQvDJtE+4d
	aR1hu9jgO+S1rC69/oXIDeHq6x+/gLtZBdvjW8D71c4+IaVtJRDJqxJlVQ==
X-Gm-Gg: ASbGncu0cBiw0lPNwcYoTteAtjN4nQci4cEmxbmSJh3UdmkMV/3ecSdYp0gOf3tczZD
	d8hYDyOicEbh2a1Q/7fluXIg/D6/i7wIK2TnbjgoTJEuVCBfD+rpfjlpBXk6BKofffRZylDueY1
	qXPrWhX1LEa5LI2bqQ39r68xXdmyKRua/Ry7lzcTy0EUeStJS5qGJNOX4qVstdhGTbV1fgBzUYm
	QEaVw2sgRRKhv0sno7WbWleAwGTXhkKa8zpED6bxMitlt7gi8bxebx/AvZK4ksmrc4Ae0Omy15G
	8Q4T+3KYy9QtS3xhgEJyv7JxWGe9GMmy
X-Google-Smtp-Source: AGHT+IF2eub8dcEpOGoCAIPwcn0fprMCM6/jsY1/Cc8qw4Yu7m6kC75qjuyWBil9qDMKYx7EozqxgQ==
X-Received: by 2002:a17:906:31d1:b0:aa5:f288:e7d8 with SMTP id a640c23a62f3a-aa63a128104mr184483866b.26.1733488987887;
        Fri, 06 Dec 2024 04:43:07 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4da51sm236527266b.37.2024.12.06.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 04:43:06 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/5] version: refactor strbuf_sanitize()
Date: Fri,  6 Dec 2024 13:42:44 +0100
Message-ID: <20241206124248.160494-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.47.1.402.gc25c94707f
In-Reply-To: <20241206124248.160494-1-christian.couder@gmail.com>
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com>
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
  - use strbuf_detach() to explicitly detach the string contained by
    the 'sb' strbuf.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
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
2.47.1.402.gc25c94707f

