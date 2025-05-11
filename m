Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADD2571AC
	for <git@vger.kernel.org>; Sun, 11 May 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746980104; cv=none; b=JK5luGbDCOXL4XYaiCLPzOIrMQiAVTnwIw5O7RHqEEgfPB68XeGnyMAwo+3DXFyG9sCcPq87NjiTaKHKQpXeTmWfOd1zS86kRjvojxDrfwUxgWeSc2XaE3sLjgPsfSCW9eVrHK6EoQ2VAe9Ng5QnJ19AnFYYIhBf6RiHC0kqRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746980104; c=relaxed/simple;
	bh=ZrNdCILaQ877zy5gVNiOJBQWFnEJEtoLLaOv3yvtCe0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O8//ZRPDMgNbaArjYrwqMJYJcmQA3byeUe0GU1/E14Z5b5soXXvN1HZ5gi6r2xOYdmP6JdaLCrq6xWvixzgyU8rHTYGDy2KCCqsqO6FgjYESZ0WKM+F4+UJD87h4YXPiyF9KFZTq0kYzHUvNGL3fa18U2KgNZurdEj6njEvUoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9X+Gugx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9X+Gugx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so40334475e9.3
        for <git@vger.kernel.org>; Sun, 11 May 2025 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746980099; x=1747584899; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Tsw64GnNSMt3fN0JdvV0j2xHGPLtrzez0t4vl/fxgU=;
        b=b9X+GugxnQqJ+hXUBYozlfIr16BwXezGLwF5Wo4gYoP8E/9qluSE9NRzq6xQtBmrEF
         eC2S86jjexUv9+Xfu1jLA8mJCclwHLLgZSrP0TivK7YDV7tX5oUIeSpvX9KNUgzWgTpK
         9LzrVr4X2mf+GSbcw79xmF+JBnxC53ZhF0ZoDZFYt3/EQqt++24xh9YaYu1uZFljET7G
         IohgoWo/n0erpypMWflIqn2gKQLuh/O2SZOOW0d9Bu7DUf+69xZVUfBwh6ad00ky0gZ8
         pgP8/IhHY1Jx9XigTJndT/mL5WXGC9voXo+ppzK2Q8GaKzHhos7dL+3eB9uL0qO8mh9o
         p+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746980099; x=1747584899;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Tsw64GnNSMt3fN0JdvV0j2xHGPLtrzez0t4vl/fxgU=;
        b=mz5yJ9nQEvsBoMZdAg1bd+IHw3kxKXvxChwycQtg8p28JESahV9AukgJ7bEgSZzYl7
         jWedyM5qIwBoereT7He7IkP5tQRn3D3az3lhiTEzQ5SDv5NOSbFgdKyjUDsjgwQukRoy
         LwM71N6ty1ho/Xl4opTL+r5YT/1slpA1ZeopU5EYdMouAC0fiC1zA1M2bZrCB6OeleLJ
         UWeSrmOdiH39Qoj1tV9KSrLG8TsFa6ZpesnhP0+GFZeGepb4ViRf0T37gbVDxYxOJefz
         uOw1GCfRQb0XkURohoVJgDN1rll4rPoRsD4TFXgDZ8YlMgKA64+cyZcQ564ylZAIEpUE
         928g==
X-Gm-Message-State: AOJu0YypaDmq00biEHTpKNVDrBVW7sr3rwr0ELjqTJdMLZqXcS7znEw+
	Zdzqj12/BX8SmvgNVKqEC8hm4qXirmqZIdh2TQaT9RMSnktW7SBZIRgVmg==
X-Gm-Gg: ASbGncsqLrU7ZwSfPg7f3NurY8daYOFDOSWkmBsw2VKESG8vk+cCTW/xac6P4TUsSSf
	nlYWbPflCgjUyYQwMeS7YJMlKnRl4n8C5QYXhI7lwCP43QyyaCZ6KZaf8nlYUusJTEw8D2MA6sS
	r6rWJ9cRJewIMoCOp29+gDsvF4tEjAmANoNPZAM+dRIvoh6B6JFva0Lm2wie/FeiDd2hP+FQetp
	nDVeV+qHMCveRLmZE5adRVmcKB7pla9tlI2hGa4YevsL9PZMT0kva34FP2Qw7hUY+/1gyfWTR4Z
	XYPMMOOuWGhL2Bf7OGPRcMbhklt0nWfTVwHS1bomPCjWJvkJnSzG
X-Google-Smtp-Source: AGHT+IE+2KGDBnhqhndZv145bO6LMFZwjc5HvbKlojQLEpZ1+eukWsVj2rX9CZ3KYcC1FDSIoHeMAw==
X-Received: by 2002:a05:600c:1e18:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-442dc95a564mr59189275e9.15.1746980099047;
        Sun, 11 May 2025 09:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d6bf96bfsm96205835e9.6.2025.05.11.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 09:14:58 -0700 (PDT)
Message-Id: <pull.1956.v2.git.git.1746980097510.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.git.git.1746711521614.gitgitgadget@gmail.com>
References: <pull.1956.git.git.1746711521614.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 May 2025 16:14:57 +0000
Subject: [PATCH v2] mailinfo: fix pointential memory leak if `decode_header`
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1956%2Fbrandb97%2Ffix-mailinfo-decode-header-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1956/brandb97/fix-mailinfo-decode-header-leak-v2
Pull-Request: https://github.com/git/git/pull/1956

Range-diff vs v1:

 1:  81fdfb94315 ! 1:  90dc9b0d49b decode_header: fix pointential memory leak if decode_header failed
     @@ Metadata
      Author: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## Commit message ##
     -    decode_header: fix pointential memory leak if decode_header failed
     +    mailinfo: fix pointential memory leak if `decode_header` failed
      
     -    In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored
     +    In mailinfo.c:decode_header, if convert_to_utf8 failed, the strbuf stored
          in dec will leak. Simply add strbuf_release and free(dec) will solve
          this problem.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## mailinfo.c ##
     +@@ mailinfo.c: static int is_format_patch_separator(const char *line, int len)
     + 	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
     + }
     + 
     +-static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
     ++static int decode_q_segment(struct strbuf *out, const struct strbuf *q_seg,
     ++			    int rfc2047)
     + {
     + 	const char *in = q_seg->buf;
     + 	int c;
     +-	struct strbuf *out = xmalloc(sizeof(struct strbuf));
     + 	strbuf_init(out, q_seg->len);
     + 
     + 	while ((c = *in++) != 0) {
     +@@ mailinfo.c: static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
     + 			c = 0x20;
     + 		strbuf_addch(out, c);
     + 	}
     +-	return out;
     ++	return 0;
     + }
     + 
     +-static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
     ++static int decode_b_segment(struct strbuf *out, const struct strbuf *b_seg)
     + {
     + 	/* Decode in..ep, possibly in-place to ot */
     + 	int c, pos = 0, acc = 0;
     + 	const char *in = b_seg->buf;
     +-	struct strbuf *out = xmalloc(sizeof(struct strbuf));
     + 	strbuf_init(out, b_seg->len);
     + 
     + 	while ((c = *in++) != 0) {
     +@@ mailinfo.c: static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
     + 			break;
     + 		}
     + 	}
     +-	return out;
     ++	return 0;
     + }
     + 
     + static int convert_to_utf8(struct mailinfo *mi,
     +@@ mailinfo.c: static int convert_to_utf8(struct mailinfo *mi,
     + static void decode_header(struct mailinfo *mi, struct strbuf *it)
     + {
     + 	char *in, *ep, *cp;
     +-	struct strbuf outbuf = STRBUF_INIT, *dec;
     ++	struct strbuf outbuf = STRBUF_INIT, dec = STRBUF_INIT;
     + 	struct strbuf charset_q = STRBUF_INIT, piecebuf = STRBUF_INIT;
     + 	int found_error = 1; /* pessimism */
     + 
      @@ mailinfo.c: static void decode_header(struct mailinfo *mi, struct strbuf *it)
     - 			dec = decode_q_segment(&piecebuf, 1);
     + 		default:
     + 			goto release_return;
     + 		case 'b':
     +-			dec = decode_b_segment(&piecebuf);
     ++			if ((found_error = decode_b_segment(&dec, &piecebuf))) {
     ++				goto release_return;
     ++			}
     + 			break;
     + 		case 'q':
     +-			dec = decode_q_segment(&piecebuf, 1);
     ++			if ((found_error = decode_q_segment(&dec, &piecebuf, 1))) {
     ++				goto release_return;
     ++			}
       			break;
       		}
      -		if (convert_to_utf8(mi, dec, charset_q.buf))
     -+		if (convert_to_utf8(mi, dec, charset_q.buf)) {
     -+			strbuf_release(dec);
     -+			free(dec);
     ++		if (convert_to_utf8(mi, &dec, charset_q.buf)) {
     ++			strbuf_release(&dec);
       			goto release_return;
      +		}
       
     - 		strbuf_addbuf(&outbuf, dec);
     - 		strbuf_release(dec);
     +-		strbuf_addbuf(&outbuf, dec);
     +-		strbuf_release(dec);
     +-		free(dec);
     ++		strbuf_addbuf(&outbuf, &dec);
     ++		strbuf_release(&dec);
     + 		in = ep + 2;
     + 	}
     + 	strbuf_addstr(&outbuf, in);
     +@@ mailinfo.c: static int is_inbody_header(const struct mailinfo *mi,
     + 
     + static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
     + {
     +-	struct strbuf *ret;
     ++	struct strbuf ret;
     ++	int found_error = 0;
     + 
     + 	switch (mi->transfer_encoding) {
     + 	case TE_QP:
     +-		ret = decode_q_segment(line, 0);
     ++		found_error = decode_q_segment(&ret, line, 0);
     + 		break;
     + 	case TE_BASE64:
     +-		ret = decode_b_segment(line);
     ++		found_error = decode_b_segment(&ret, line);
     + 		break;
     + 	case TE_DONTCARE:
     + 	default:
     + 		return;
     + 	}
     + 	strbuf_reset(line);
     +-	strbuf_addbuf(line, ret);
     +-	strbuf_release(ret);
     +-	free(ret);
     ++	strbuf_addbuf(line, &ret);
     ++	if (!found_error)
     ++		strbuf_release(&ret);
     + }
     + 
     + static inline int patchbreak(const struct strbuf *line)


 mailinfo.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 7b001fa5dbd..11ec3914ce4 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -381,11 +381,11 @@ static int is_format_patch_separator(const char *line, int len)
 	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
 }
 
-static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
+static int decode_q_segment(struct strbuf *out, const struct strbuf *q_seg,
+			    int rfc2047)
 {
 	const char *in = q_seg->buf;
 	int c;
-	struct strbuf *out = xmalloc(sizeof(struct strbuf));
 	strbuf_init(out, q_seg->len);
 
 	while ((c = *in++) != 0) {
@@ -405,15 +405,14 @@ static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
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
 	strbuf_init(out, b_seg->len);
 
 	while ((c = *in++) != 0) {
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
 
@@ -530,18 +529,23 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 		default:
 			goto release_return;
 		case 'b':
-			dec = decode_b_segment(&piecebuf);
+			if ((found_error = decode_b_segment(&dec, &piecebuf))) {
+				goto release_return;
+			}
 			break;
 		case 'q':
-			dec = decode_q_segment(&piecebuf, 1);
+			if ((found_error = decode_q_segment(&dec, &piecebuf, 1))) {
+				goto release_return;
+			}
 			break;
 		}
-		if (convert_to_utf8(mi, dec, charset_q.buf))
+		if (convert_to_utf8(mi, &dec, charset_q.buf)) {
+			strbuf_release(&dec);
 			goto release_return;
+		}
 
-		strbuf_addbuf(&outbuf, dec);
-		strbuf_release(dec);
-		free(dec);
+		strbuf_addbuf(&outbuf, &dec);
+		strbuf_release(&dec);
 		in = ep + 2;
 	}
 	strbuf_addstr(&outbuf, in);
@@ -634,23 +638,24 @@ static int is_inbody_header(const struct mailinfo *mi,
 
 static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 {
-	struct strbuf *ret;
+	struct strbuf ret;
+	int found_error = 0;
 
 	switch (mi->transfer_encoding) {
 	case TE_QP:
-		ret = decode_q_segment(line, 0);
+		found_error = decode_q_segment(&ret, line, 0);
 		break;
 	case TE_BASE64:
-		ret = decode_b_segment(line);
+		found_error = decode_b_segment(&ret, line);
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
+	if (!found_error)
+		strbuf_release(&ret);
 }
 
 static inline int patchbreak(const struct strbuf *line)

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
