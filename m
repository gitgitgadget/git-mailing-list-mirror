Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD61DC1A7
	for <git@vger.kernel.org>; Tue, 13 May 2025 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104557; cv=none; b=e0I3QJcLuMPz2h5ItV8TvBH6NX1OB4aXaip89JeoZ+yFllYUV5JoHVKl1Zbg4CAIIX1M3xQ/TnrdbSIYtJsBvLrbtb6CfB3U80CJxUs2eCP0Q1Fd8k6Mjp+4MEtBxNt8tIeQQeDIuoQjdyKd2n9bjY6psAoB2Grq8Wh85SsZLEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104557; c=relaxed/simple;
	bh=/3SCJL7tRiFRuV3f0DCoa1iua8qIq8iJvtdvQwpRESo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hrX6E5JsJyCCFtYMxXuqJx8mkn1Vr2HNMRgwZsbpRnrSt3G3nrZNCM0htPnuxNxYgeQ8VuQ6FeODmO20qgYzlgUBbH/dBjN5PERMX/nEN9UcHzmAQAZ4yXJbSacbo1Aw1Iat8RnQpxX4eyKNWTXBdV/a9Irlz+LdrUSAiLb+hBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRZ05j4P; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRZ05j4P"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a1fb17a9beso2095220f8f.3
        for <git@vger.kernel.org>; Mon, 12 May 2025 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747104553; x=1747709353; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxVnV0CfP5X1zDcFiGnEREiRFGYhtX1UnpvQVJbsNL4=;
        b=TRZ05j4PG9tL9CNAeCi6dF29hw1vr9Pv7mxuwQ8MuUZyoY1X5KR04iwHmVZPEC9Eh0
         FuHpc9z5Y8RBAETug6USG1OJEj6ZUNyy7WZKdrF0pZxHM478+KpLuE/LX8tBVacAx58s
         7U5pDPUewNZMrLZcDXsuiGIjIzu2YfWIzGaBRpNt3chkSl3G/qe1Qn5m6IOg8rRRodZv
         2coyY0ornlUTJ1PBVPY+1EYkWaPsSU/d1eIqu9JYrliHqkWwscQIyc68MKVo7oHshDZr
         g2z+YKvrsCcAefAsy5T+Hv52/rIWCq+Lwl0vlWQXkbsYOi76hBp8DWyrwIeSzxenYEPr
         NxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747104553; x=1747709353;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxVnV0CfP5X1zDcFiGnEREiRFGYhtX1UnpvQVJbsNL4=;
        b=YFYMOvzV/6iTZOSW699aVjVu8Dbpj1Eod9slC0ts5JQwQXY/ZrgTJSD9DmS2kVKqPP
         DJ5H2cCNHVt72N/QMmWnK/GpNeuZcsIxuPgROvMTzYlPtbtnwWo4PX1zd59ZaV4YMTFd
         2OXPL5DuEJ0lycCczv5kSgKeEqbtkZ0XZMUvESvURBioNOD5vxRJSzS3OYDVrrxib3Dr
         j/lpjOljigcC9mvnsusJRyfpHQcS5ATYISzS+EOfVyCPDGFVD/66gpxyM+nds5oYQtJ7
         C/aXLqUk8HiyE5G8+PMyggIK3TwBzJWrxGpKVFDgEPHFVPMBL+39HGFbu37YPPa7mpPb
         uIZA==
X-Gm-Message-State: AOJu0Yx5kb9T8IYHCBLBJzSyXCr6OvsxfQsZazIZd5kvQHfN2hifHQTX
	aAAeDlvdhWkEFFvsrUbHL7FGTfTndb9y4+5BEz9xZy1TLDtE/wW5+1OPvw==
X-Gm-Gg: ASbGncsHVOyscTiydtYnJvZdyzwnZvdQtOdkxEpQNhKZLSJZswDLQC8mUuVah68n79Q
	dPhOhhsylRfw5jwUrrOCe1+jvfDWbg5uNmMdmFIrqQxRZ1kRo9qD/Byn/bvgYRfMQO4ksbrmigC
	Iaj+GrdIQG1p0ggm8srRYROZu/FetNOBUFeDhvNzSEkqLoVjCBUwtctzOGDPliKX5QPs3qdPitc
	JaTq2Z9zq9Pzij1djabu/P2ow3pQYiv2HNFTqm+f/dGjUnEw6KUC6/wNAZlIynZmgUS5Kuo2VUZ
	K4+NqwkLZqsJJIPtdqVsnm3ZRLrhCNRADZc0ReOCJy4zyHskZkng
X-Google-Smtp-Source: AGHT+IE+LH2EkZoPpOVaAUTnOAmNWKgGiuqvsJuOMd/jmfQWDTITQRAHAiMrcTX3ZiYrfanu/fmxCA==
X-Received: by 2002:a05:6000:1a8d:b0:3a0:b4fa:e594 with SMTP id ffacd0b85a97d-3a1f6445660mr13037952f8f.33.1747104552726;
        Mon, 12 May 2025 19:49:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ebd75sm14667480f8f.34.2025.05.12.19.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 19:49:12 -0700 (PDT)
Message-Id: <pull.1956.v4.git.git.1747104551204.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.v3.git.git.1747066627330.gitgitgadget@gmail.com>
References: <pull.1956.v3.git.git.1747066627330.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 May 2025 02:49:10 +0000
Subject: [PATCH v4] mailinfo: fix pointential memory leak if `decode_header`
 failed
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In mailinfo.c:decode_header, if convert_to_utf8 failed, the strbuf stored
in dec will leak. Simply add strbuf_release and free(dec) will solve
this problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    decode_header: fix pointential memory leak if decode_header failed
    
    In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored in
    dec will leak. Simply add strbuf_release and free(dec) will solve this
    problem.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1956%2Fbrandb97%2Ffix-mailinfo-decode-header-leak-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1956/brandb97/fix-mailinfo-decode-header-leak-v4
Pull-Request: https://github.com/git/git/pull/1956

Range-diff vs v3:

 1:  7f8ce472750 ! 1:  d00e805c5c5 mailinfo: fix pointential memory leak if `decode_header` failed
     @@ mailinfo.c: static int is_format_patch_separator(const char *line, int len)
       	const char *in = q_seg->buf;
       	int c;
      -	struct strbuf *out = xmalloc(sizeof(struct strbuf));
     - 	strbuf_init(out, q_seg->len);
     +-	strbuf_init(out, q_seg->len);
     ++	strbuf_grow(out, q_seg->len);
       
       	while ((c = *in++) != 0) {
     + 		if (c == '=') {
      @@ mailinfo.c: static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
       			c = 0x20;
       		strbuf_addch(out, c);
     @@ mailinfo.c: static struct strbuf *decode_q_segment(const struct strbuf *q_seg, i
       	int c, pos = 0, acc = 0;
       	const char *in = b_seg->buf;
      -	struct strbuf *out = xmalloc(sizeof(struct strbuf));
     - 	strbuf_init(out, b_seg->len);
     +-	strbuf_init(out, b_seg->len);
     ++	strbuf_grow(out, b_seg->len);
       
       	while ((c = *in++) != 0) {
     + 		if (c == '+')
      @@ mailinfo.c: static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
       			break;
       		}
     @@ mailinfo.c: static void decode_header(struct mailinfo *mi, struct strbuf *it)
       			break;
       		}
      -		if (convert_to_utf8(mi, dec, charset_q.buf))
     -+		if (convert_to_utf8(mi, &dec, charset_q.buf)) {
     ++		if (convert_to_utf8(mi, &dec, charset_q.buf))
       			goto release_return;
     -+		}
       
      -		strbuf_addbuf(&outbuf, dec);
      -		strbuf_release(dec);


 mailinfo.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 7b001fa5dbd..ee4597da6be 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -381,12 +381,12 @@ static int is_format_patch_separator(const char *line, int len)
 	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
 }
 
-static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
+static int decode_q_segment(struct strbuf *out, const struct strbuf *q_seg,
+			    int rfc2047)
 {
 	const char *in = q_seg->buf;
 	int c;
-	struct strbuf *out = xmalloc(sizeof(struct strbuf));
-	strbuf_init(out, q_seg->len);
+	strbuf_grow(out, q_seg->len);
 
 	while ((c = *in++) != 0) {
 		if (c == '=') {
@@ -405,16 +405,15 @@ static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
 			c = 0x20;
 		strbuf_addch(out, c);
 	}
-	return out;
+	return 0;
 }
 
-static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
+static int decode_b_segment(struct strbuf *out, const struct strbuf *b_seg)
 {
 	/* Decode in..ep, possibly in-place to ot */
 	int c, pos = 0, acc = 0;
 	const char *in = b_seg->buf;
-	struct strbuf *out = xmalloc(sizeof(struct strbuf));
-	strbuf_init(out, b_seg->len);
+	strbuf_grow(out, b_seg->len);
 
 	while ((c = *in++) != 0) {
 		if (c == '+')
@@ -447,7 +446,7 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 			break;
 		}
 	}
-	return out;
+	return 0;
 }
 
 static int convert_to_utf8(struct mailinfo *mi,
@@ -475,7 +474,7 @@ static int convert_to_utf8(struct mailinfo *mi,
 static void decode_header(struct mailinfo *mi, struct strbuf *it)
 {
 	char *in, *ep, *cp;
-	struct strbuf outbuf = STRBUF_INIT, *dec;
+	struct strbuf outbuf = STRBUF_INIT, dec = STRBUF_INIT;
 	struct strbuf charset_q = STRBUF_INIT, piecebuf = STRBUF_INIT;
 	int found_error = 1; /* pessimism */
 
@@ -530,18 +529,19 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 		default:
 			goto release_return;
 		case 'b':
-			dec = decode_b_segment(&piecebuf);
+			if ((found_error = decode_b_segment(&dec, &piecebuf)))
+				goto release_return;
 			break;
 		case 'q':
-			dec = decode_q_segment(&piecebuf, 1);
+			if ((found_error = decode_q_segment(&dec, &piecebuf, 1)))
+				goto release_return;
 			break;
 		}
-		if (convert_to_utf8(mi, dec, charset_q.buf))
+		if (convert_to_utf8(mi, &dec, charset_q.buf))
 			goto release_return;
 
-		strbuf_addbuf(&outbuf, dec);
-		strbuf_release(dec);
-		free(dec);
+		strbuf_addbuf(&outbuf, &dec);
+		strbuf_release(&dec);
 		in = ep + 2;
 	}
 	strbuf_addstr(&outbuf, in);
@@ -552,6 +552,7 @@ release_return:
 	strbuf_release(&outbuf);
 	strbuf_release(&charset_q);
 	strbuf_release(&piecebuf);
+	strbuf_release(&dec);
 
 	if (found_error)
 		mi->input_error = -1;
@@ -634,23 +635,22 @@ static int is_inbody_header(const struct mailinfo *mi,
 
 static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 {
-	struct strbuf *ret;
+	struct strbuf ret = STRBUF_INIT;
 
 	switch (mi->transfer_encoding) {
 	case TE_QP:
-		ret = decode_q_segment(line, 0);
+		decode_q_segment(&ret, line, 0);
 		break;
 	case TE_BASE64:
-		ret = decode_b_segment(line);
+		decode_b_segment(&ret, line);
 		break;
 	case TE_DONTCARE:
 	default:
 		return;
 	}
 	strbuf_reset(line);
-	strbuf_addbuf(line, ret);
-	strbuf_release(ret);
-	free(ret);
+	strbuf_addbuf(line, &ret);
+	strbuf_release(&ret);
 }
 
 static inline int patchbreak(const struct strbuf *line)

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
