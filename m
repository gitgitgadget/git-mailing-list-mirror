Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AE328634
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160237; cv=none; b=mrbCYXNIsa7s1TFYEn8uJqrKwzj70ytrsYFxK3xnHWACLov4qRfPRF8WWQQMdQSoZ9++NI/gdJPjUDs9gK90iuGtlSB3gJVT8c+HL2aDOympJfcID0jQ7gi+rCFpOFm6mqfZcIMUC8yajQJ68oi9SkzpBEDXmk6tGvJl4CMttoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160237; c=relaxed/simple;
	bh=vaSNADofwuo82kXyUyIQvVeVSa1JCXSq5FPjGOYdyR4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CvBqp6oPxRYtjb8gcc9cKlhTUGaNZk98dNzrOsY7AghAdufY7Mzyhq9y2amT+MNsF2pPMH5RJYBAuvjpJM8lrmvuNtDq/N18JoNpKjGgxe8XAgOvqFPZv3FksJWF8ZA20OW/er0pfvEvr0TKGJEEnrDa85D1S+8mL0ZIhbD8xoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSJbsw62; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSJbsw62"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so6919098a91.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 04:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764160234; x=1764765034; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9tV7j3HFixcOrci1PI7ZTFTra1boMdLHNPN9uko7yk=;
        b=dSJbsw62aikLOybtc1W2ItWIJtEziWpzmgRAbCpJveKTTL3s4ohatQCveCVQE8f5nN
         H/bX2avrEmZkY/+SneZwFEelFgNUZTRnpOEux2jNeQE2Z+D8iyVtc5CQn6cP9hqO4Ht1
         Grb/kXDHqsWg1jjjIGiT36sDXTq9+lQZDIjJk720C4REKZaJVgCE+yFR7/UUMe7xolpJ
         L9TcpFWqPUZN3xDGYTmcxIPJETCM8CPb7CM64DLgZf5rrTxJ/rzxi17/LLNKFCji5gHb
         2MpOAejIC/0c8CNnusN1y2DaZYhOuf+NdGsUNfRk4+djvwU1JZJ5+G9AlCZgdDnAVcxM
         KSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160234; x=1764765034;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9tV7j3HFixcOrci1PI7ZTFTra1boMdLHNPN9uko7yk=;
        b=U5RceUF93gMl2Y3gXJPseZxGhw7BxJgGspPp5JV5EKBV5Cq24xWOM0VTSjucqtr/gG
         y4jjKKVSucoYrrha/SzubwTlXNW6YJpP6Bsa0YlAcfdNaR4l9VJQdhTxzwm/0leNuedb
         sCI6eobkmK0w6+/YP+xfq8uymwi1M/IR1Bak/XMLDi3QVnMMBi3nN86M81GqLYGz5jM1
         w0IQ377lvFfWczSJASGBXqiS2jIpmHrI7DFh46iVWIVQkeKrogKt06XX3f8fEARupX2p
         dpR4v8bFKHKKc7hcI7CJsxFhpYx8NtTudK9hCs4SsBxcb8y12m+zyjd3wDqWjKX45YPE
         ddfA==
X-Gm-Message-State: AOJu0Yyux1EKrSHt3f7M39WbH8YlnqT2w6xBoMes/MCua6ga40r2oaGK
	olENhqfjuYAyQj5j9IpaPYv+6G+/kuMaNLhRTeT0y7KpdGICGHFcneOBqvk06A==
X-Gm-Gg: ASbGncsl5JQDhyvtgTEYJ8feiQ/bWksR1yVhc6HC3jkoHzY3aVc5BzNSuGQQKSVL2QP
	zovM4xD+lte/zLgrwGLawphLja8WhLh64AbIXm2jknRTKFOBAPPiUlkPnnw0xo2xU1dnszn6eHI
	5YILOYFEPx+4vLltZ5kDC1R7esDEZv8gUQ79dRTZKzrTyEVnNv1wVsIQ6nXvklceUKINLtV/1pF
	/CDzVYkIk2kiz5EQPQ19aFX15l5qqXBQHr9K1magf4OS1b3S6mOsr/j/T0b0dmzdmHDphpmH25i
	mVwlsDR51ffUMoxJSqwS8bdHGJL6NodY+w1qhKIe7t06gXY2QpPunGdc+dnr6h4odyZ6L4ogv74
	bTC6XTmnjbuw4nsmKkzKI4s3qXG5GsVPM+cwQwLTBsqXqjVfZrGL+xxHD6iYRJ2mhF6IYly6zKb
	k9MTO5nzx01jjeAHU=
X-Google-Smtp-Source: AGHT+IG2Aq4Ej9WgecxQoG9wZsuSFT7latJFJfhTgayG/z/uNYZ6671And2FnohSa6TfY3pA9A6IMQ==
X-Received: by 2002:a17:90a:8b:b0:343:6108:1706 with SMTP id 98e67ed59e1d1-34733ef70admr15854700a91.17.1764160234466;
        Wed, 26 Nov 2025 04:30:34 -0800 (PST)
Received: from [127.0.0.1] ([172.182.195.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a547abcsm2498351a91.3.2025.11.26.04.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:30:33 -0800 (PST)
Message-Id: <438223792264169082db8a1be5cb419b657bda26.1764160227.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 12:30:26 +0000
Subject: [PATCH 2/3] remote-curl: fix memory leak in show_http_message()
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
Cc: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Fix a memory leak in show_http_message() that was triggered when
displaying HTTP error messages before die(). The function would call
strbuf_reencode() which modifies the caller's strbuf in place,
allocating new memory for the re-encoded string. Since this function
is only called immediately before die(), the allocated memory was
never explicitly freed, causing leak detectors to report it.

The leak became visible when HTTP 429 rate limit retry support was
added, which introduced the HTTP_RATE_LIMITED error case. However,
the issue existed in pre-existing error paths as well
(HTTP_MISSING_TARGET, HTTP_NOAUTH, HTTP_NOMATCHPUBLICKEY) - the new
retry logic just made it more visible in tests because retries
exercise the error paths more frequently.

The leak was detected by LeakSanitizer in t5584 tests that enable
retries (maxRetries > 0). Tests with retries disabled passed because
they took a different code path or timing.

Fix this by making show_http_message() work on a local copy of the
message buffer instead of modifying the caller's buffer in place:

1. Create a local strbuf and copy the message into it
2. Perform re-encoding on the local copy if needed
3. Display the message from the local copy
4. Properly release the local copy before returning

This ensures all memory allocated by strbuf_reencode() is freed
before the function returns, even though die() is called immediately
after, eliminating the leak.

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 remote-curl.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 5959461cd3..dd0680e5ae 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -371,6 +371,7 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 			     struct strbuf *msg)
 {
 	const char *p, *eol;
+	struct strbuf msgbuf = STRBUF_INIT;
 
 	/*
 	 * We only show text/plain parts, as other types are likely
@@ -378,19 +379,24 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 	 */
 	if (strcmp(type->buf, "text/plain"))
 		return -1;
+
+	strbuf_addbuf(&msgbuf, msg);
 	if (charset->len)
-		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
+		strbuf_reencode(&msgbuf, charset->buf, get_log_output_encoding());
 
-	strbuf_trim(msg);
-	if (!msg->len)
+	strbuf_trim(&msgbuf);
+	if (!msgbuf.len) {
+		strbuf_release(&msgbuf);
 		return -1;
+	}
 
-	p = msg->buf;
+	p = msgbuf.buf;
 	do {
 		eol = strchrnul(p, '\n');
 		fprintf(stderr, "remote: %.*s\n", (int)(eol - p), p);
 		p = eol + 1;
 	} while(*eol);
+	strbuf_release(&msgbuf);
 	return 0;
 }
 
-- 
gitgitgadget

