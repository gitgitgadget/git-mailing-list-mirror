Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CF71CDFBC
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738441210; cv=none; b=Jo02wVHAzemz6j8JTF4RSb35eq1i14k0zTk1z3zX1N2bpde886O1eRca+HSuZ8cOoON0OXgUYEvm2UAm8Zixhqw25Uam6YWjC+lbqnwFB8KDg5C5Fc0LXt/LC6/fE/ibrDdArJQuBwStdufVNqQ2ya6VDbMP3Y9RHnKQ+N97NBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738441210; c=relaxed/simple;
	bh=64lgMiWh+2Ze1k7XBTu/SfF0i8j7YxNOKSVW3IWYdaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihpf+LSNcRhHEWQzmiYi3I28d8M2mmEUsIMJoqwn39I5osnrbqUnlQsXkc10d1AaewEwtA8T8OLktyjkfwpVEFIU4M48xFnBuBiWwsFl7m1CdfFBOTgYoplusIXXTzuQs8BdqH6AxqgHCcc7bSIfC//Dtb5aEOhd0btGU+73hpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1i3Ulm0; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1i3Ulm0"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb8559b6b0so1880970b6e.1
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738441208; x=1739046008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhkHmzFPePb+VueEvMYmbYngo1a6iUd/ux8IdFi6HRI=;
        b=L1i3Ulm01rli0dtcLwsfFZTmZeLSVtB6/30ObNWhpJRvIKwDf3TTXxwKOJRdYJPBdI
         peXO/TE1mh2/l64FZ5eO5a2NOavUjpvCmu0weCeRussiR8cdqtTtJOtRSzHpaFZSkC9+
         +iZOkQ5WT/jRckzZxRmTC/iSW6Et4L5rI7C65GogAWvA/weFv6DiZEhJx+yAEdPIygQC
         M6enoqF1w5VjV+Rb8f88gyOrh+pXF6PtgcOJQoKgc0RfDzBiaVFIoE7jyeauRI+p4jJz
         4xNjYlgQVUoRSJkg2Dh2bM1bWQNQD0f1bm4ODQnWSrms4fNQ0bAyxxItRLvswdXGWU2z
         XOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738441208; x=1739046008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhkHmzFPePb+VueEvMYmbYngo1a6iUd/ux8IdFi6HRI=;
        b=MCbXn8a8kdXeUGaA9dcbVQLDAx1zj8c0NyUsHKcLEnThr8bZ7hulnZBeX38oTrpy6f
         wEIQuC9a3hTZ7JUa7NmrCsqzq7TbMySbOFEfy0pJLow7tBoZ8Q4XqpGheRZyeJ+1vYCP
         dzIGjZIZ2unED5Xt7FOAj5xFUsIicAKthbpO6Dd+LKzEWqCLh7bI79jb+nxvXjVHbEpW
         9+ncEIw4aPAiEPkDjjnLNxozlRk8J7kMG/Q2AcWXEnwlddanw2EJY/yJTSZF5Pu+l1OZ
         xmZ5JNZ7KTeosiK3zQc5mWKMlwU7n7V996yu/fFRfDHo8vNtfPRMt4Vbp+3hr1VpBcL1
         tRTw==
X-Gm-Message-State: AOJu0YwyOAUhhBrnJK/k3hEpB6CtDM3VE4y+OeLKikDyBnOz48K4ROSZ
	kr1DEdllu2KPI5/gumFpONGRmlZQAyQubdF3qeAR63hHokum9C1i9AQsXw==
X-Gm-Gg: ASbGncvb/rYdb/zW3FKo7fW4Qr/pxM/VivZfRMUIRs39xQmoFfE6EO06TyfpzFKvpy7
	a8ENObRAcIHQPyMuIsMLTWpA4p7uLoRmzwbqxFRcclYA5P6jJWM4ifB0ZgOuxFWBN3Itu6dsS0d
	iAwzfF5LH49PMY2IDsGZw9vduJLKMM/uhf4hGAP7R3ZN9kI6UbfZG9Sh5yIdFeCT+Y5Iy4QpOBa
	LqoJqgFWG1S/s4BfIkuQxDi+NfTmMB/KRorYbLwyETEzPLgn3cquiYmaXkHK78IHdRCHQI7joiH
	Rfw7xSEY+eILFK0i/GlWFKc=
X-Google-Smtp-Source: AGHT+IF+n/z1y9tb/iRnrGvfrEx/WU5JhFuwHsJrG3OHvSSkI9ziBUzSOkIfJxcpWyFL7DsGpsz5Rg==
X-Received: by 2002:a05:6808:3386:b0:3ef:27fe:e969 with SMTP id 5614622812f47-3f323a3ea70mr11019672b6e.11.1738441207831;
        Sat, 01 Feb 2025 12:20:07 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3332bb032sm1588336b6e.0.2025.02.01.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 12:20:07 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/4] quote: add quote_path() flag to ignore config
Date: Sat,  1 Feb 2025 14:16:56 -0600
Message-ID: <20250201201658.11562-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1.157.g3b0d05c4a7
In-Reply-To: <20250201201658.11562-1-jltobler@gmail.com>
References: <20250110053417.2602109-2-jltobler@gmail.com>
 <20250201201658.11562-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `quote_path()` function invokes `quote_c_style_counted()` to handle
quoting. This means the output `quote_path()` is ultimately affected by
`core.quotePath` configuration. In a subsequent commit, `quote_path()`
will be used in a scenario where the output should remain consistent
regardless of the current configuration.

Introduce the `QUOTE_PATH_IGNORE_CONFIG` flag for `quote_path()`which
when set instructs the underlying `quote_c_style_counted()` to also
ignore the `core.quotePath` configuration when executed.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 quote.c | 13 ++++++++++---
 quote.h |  3 ++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/quote.c b/quote.c
index d129c1de70..baec34ca94 100644
--- a/quote.c
+++ b/quote.c
@@ -370,10 +370,18 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *rel = relative_path(in, prefix, &sb);
-	int force_dq = ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' '));
+	unsigned cquote_flags = 0;
+	int force_dq = 0;
 
 	strbuf_reset(out);
 
+	if ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' ')) {
+		force_dq = 1;
+		cquote_flags &= CQUOTE_NODQ;
+	}
+	if (flags & QUOTE_PATH_IGNORE_CONFIG)
+		cquote_flags &= CQUOTE_IGNORE_CONFIG;
+
 	/*
 	 * If the caller wants us to enclose the output in a dq-pair
 	 * whether quote_c_style_counted() needs to, we do it ourselves
@@ -381,8 +389,7 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
 	 */
 	if (force_dq)
 		strbuf_addch(out, '"');
-	quote_c_style_counted(rel, strlen(rel), out, NULL,
-			      force_dq ? CQUOTE_NODQ : 0);
+	quote_c_style_counted(rel, strlen(rel), out, NULL, cquote_flags);
 	if (force_dq)
 		strbuf_addch(out, '"');
 	strbuf_release(&sb);
diff --git a/quote.h b/quote.h
index 2a793fbef6..84903951ef 100644
--- a/quote.h
+++ b/quote.h
@@ -94,7 +94,8 @@ void write_name_quoted_relative(const char *name, const char *prefix,
 
 /* quote path as relative to the given prefix */
 char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigned flags);
-#define QUOTE_PATH_QUOTE_SP 01
+#define QUOTE_PATH_QUOTE_SP	 (1u << 0)
+#define QUOTE_PATH_IGNORE_CONFIG (1u << 1)
 
 /* quoting as a string literal for other languages */
 void perl_quote_buf(struct strbuf *sb, const char *src);
-- 
2.48.1.157.g3b0d05c4a7

