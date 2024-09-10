Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648613B2B8
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985825; cv=none; b=IxCO/D8uJXySH2T8l7uFK3bqnLbJhhrDNgpTUfYdjH01E0c5+lHkf3/9mb+ImiMlhHyaXmCPQ1LdYsvhbqKcDi1kU6G/UWX/iL2lu8tHbS99PUGxAUKTbr6lnmQ0LJtJcyFVXQe6PeQy14/PHL21tRp+ZhuSW/Y6TQa3vLmW3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985825; c=relaxed/simple;
	bh=ya0/CACRmTfh4fk0cbIlxjg7nz6daWeVS1RiID9z0Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFV5t3dTmmJ+OLI1Bf/OxJX3duEZ3sDGpu7QtcAuJktg01QwetYssewbJE0HQ1Ub+HIwb1Y0H6zxJjzhmwmqcnQ7TXniXR/qrqNVQiean7UuYnS9cDkWz1fzW+XJk091MMw++IQX15e6HIGkDnDGVzDpoNBJwcJ49IC7/zs60AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAnBbG9J; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAnBbG9J"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso25361775e9.2
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725985822; x=1726590622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfygiRTxI6/Pzw9YYF2AKnRPiTz3aD+gNb6HSs1gjPc=;
        b=MAnBbG9Jwrz09bYOx3piKZ28izYjxoxKXcGSZyGgYICka48hFhiB3SjV9whI5FTGAL
         FYkhLTHMSps40cIKC4JpbzuAI+L+3QTPMNaVoUu5Qt7cAJTdGcBtj3eq1Af28xUqkgAE
         M6W9BOPk1shQRbxNySxNTN6k8lqgq5ZewgprzlL5s+YqCg9TA2VZVT4h72KBUw5mibhk
         0d3yztIhveY0wpBUXLwfhrzDVwm1iezmtYCEeR3XNbRGAtvP8FRnHKqEfobwd0UKYFKR
         EWRhB4q1zb9KXbbpJGe1/J4A2lt0nIoCoGweY4dWQhU7yuIAbOwjjpehFN4gbZBLKBRg
         qsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985822; x=1726590622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfygiRTxI6/Pzw9YYF2AKnRPiTz3aD+gNb6HSs1gjPc=;
        b=tpbTg5oWlLQ3xkowEUANsNIRRYy3Mi//cn0hI3tjZld02yUwy69aokBrZO9szjCd9J
         s72F8DTOIqvmqFr+6SRZN8KwF2pAMpQktRVhGpjVIxEXxr2oIvg292RDJhsYTD+0fXAE
         wc8eU8WwVwzI2dunZ1cXhHF3X03NioTwPs8EQhZmE5mHc1Bz4u22UvBJDvHsH4eJ5zfH
         3kh7sQwCKKUgHxDvtTmIxV/Ag8u49gT5BwBmfxPyRC8be9okxAVuxMVhAoHwPMvpzoxh
         bBfsmlXRBXwze8SBYaqiBwgpNuqDnYealva3T+5a9qMMisZBQlhXe2K3BaZm8WBQC73c
         aPnw==
X-Gm-Message-State: AOJu0YyAAR60twSUAJag2yuC1pa2Mb8pi2uYy6xGBVBMXzCqnzLOxoDJ
	J+7x0bc3ZcopLoqBf3PTdtzxwJohuiFuWUxyCnzoQ28QZi5KvoHpTUTmHw==
X-Google-Smtp-Source: AGHT+IFJra3Fad3Jr5+FSCwhoJCy/Dx5VJNB9NBNV7aIAMKXMv1L/KPIb9Ak2z1/bOx9jq8Ke8kv/Q==
X-Received: by 2002:a05:600c:4f4e:b0:42c:b4f5:47a9 with SMTP id 5b1f17b1804b1-42cb4f54c54mr73501515e9.14.1725985821560;
        Tue, 10 Sep 2024 09:30:21 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm29897865e9.0.2024.09.10.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:30:19 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/4] strbuf: refactor strbuf_trim_trailing_ch()
Date: Tue, 10 Sep 2024 18:29:58 +0200
Message-ID: <20240910163000.1985723-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.4.g7a37e584ed
In-Reply-To: <20240910163000.1985723-1-christian.couder@gmail.com>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We often have to split strings at some specified terminator character.
The strbuf_split*() functions, that we can use for this purpose,
return substrings that include the terminator character, so we often
need to remove that character.

When it is a whitespace, newline or directory separator, the
terminator character can easily be removed using an existing triming
function like strbuf_rtrim(), strbuf_trim_trailing_newline() or
strbuf_trim_trailing_dir_sep(). There is no function to remove that
character when it's not one of those characters though.

Let's introduce a new strbuf_trim_trailing_ch() function that can be
used to remove any trailing character, and let's refactor existing code
that manually removed trailing characters using this new function.

We are also going to use this new function in a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 strbuf.c         |  7 +++++++
 strbuf.h         |  3 +++
 trace2/tr2_cfg.c | 10 ++--------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index cccfdec0e3..c986ec28f4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -134,6 +134,13 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_trim_trailing_ch(struct strbuf *sb, int c)
+{
+	while (sb->len > 0 && sb->buf[sb->len - 1] == c)
+		sb->len--;
+	sb->buf[sb->len] = '\0';
+}
+
 void strbuf_trim_trailing_newline(struct strbuf *sb)
 {
 	if (sb->len > 0 && sb->buf[sb->len - 1] == '\n') {
diff --git a/strbuf.h b/strbuf.h
index 884157873e..5e389ab065 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -197,6 +197,9 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb);
 /* Strip trailing LF or CR/LF */
 void strbuf_trim_trailing_newline(struct strbuf *sb);
 
+/* Strip trailing character c */
+void strbuf_trim_trailing_ch(struct strbuf *sb, int c);
+
 /**
  * Replace the contents of the strbuf with a reencoded form.  Returns -1
  * on error, 0 on success.
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index d96d908bb9..356fcd38f4 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -33,10 +33,7 @@ static int tr2_cfg_load_patterns(void)
 
 	tr2_cfg_patterns = strbuf_split_buf(envvar, strlen(envvar), ',', -1);
 	for (s = tr2_cfg_patterns; *s; s++) {
-		struct strbuf *buf = *s;
-
-		if (buf->len && buf->buf[buf->len - 1] == ',')
-			strbuf_setlen(buf, buf->len - 1);
+		strbuf_trim_trailing_ch(*s, ',');
 		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
@@ -72,10 +69,7 @@ static int tr2_load_env_vars(void)
 
 	tr2_cfg_env_vars = strbuf_split_buf(varlist, strlen(varlist), ',', -1);
 	for (s = tr2_cfg_env_vars; *s; s++) {
-		struct strbuf *buf = *s;
-
-		if (buf->len && buf->buf[buf->len - 1] == ',')
-			strbuf_setlen(buf, buf->len - 1);
+		strbuf_trim_trailing_ch(*s, ',');
 		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
-- 
2.46.0.4.g7a37e584ed

