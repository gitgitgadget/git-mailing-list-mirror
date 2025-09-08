Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59E231A3B
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309486; cv=none; b=QvjWjuuQU5LvaSpBcEiBbpHdvv4uDenVX+0BnGSJggYlHvBMI4HfhzkrxmBuQXHzjg+AoCvEn9s5F8hXG484uUT95WgzJG9z6L5OaDOHczOEA6YjFYK7ilc2grH9prRRG2CTBDyrLeit8uC3iM3GQppf6Ous+0tR/S5E3SmPCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309486; c=relaxed/simple;
	bh=FfGkYzRuGjQBfrdq2i5iXV2m3zH6llLqwF9zVs817bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j21Rn8E6w/d8lHL5RVl/LINePhS0m7UAjzr2uIdWebgCG/8QK/kLTBbhad+5RZp8CecxJicc3A3297kmNVbGcFQbKZUglphsG1+ZH0x7n36aTlXPWaFkFEiS6hW1aX14zLsJ6bAkjUqqzcAJA59AG29d6jgs065HUCvMh/KLvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxEkFeGe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxEkFeGe"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so1051291f8f.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 22:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309482; x=1757914282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28ckB8UO/Ej6wLjsfZzGHCE0MToSNZ5xY4IUzHBpjcE=;
        b=gxEkFeGeWWVWft+hVY8qUyEP2fPNgcBJSFvVHASD98ah7uzg7qeaqPmLxSgjaVuXwi
         jSQR4PGZFcX1XjzYcdyXZEWUyxE32nvEW1PVoyeIA+bDx/C9Np9duROfhUYxUH+35h/L
         X5etUBdQFW5F/tNBYVeMcolEpqdz60612TeU+C/sGgN6WLLdVnXIiuj/zfcVsFYijHre
         pn7n++jTZ+nRrmBfVJKhMP6PwztcKsiqfvuwo+MzRXwdx3Hpjdo3gAo/K9JeRSGZblSQ
         b5jOmfcu0bshQlhjYZyrv2uarKLdXv9oZ2mX4NUspIR3oVHjhxlfSApTZkOTBk+fX7Z+
         xVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309482; x=1757914282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28ckB8UO/Ej6wLjsfZzGHCE0MToSNZ5xY4IUzHBpjcE=;
        b=gtQ2PPPX060VN2qEUUult64cSvpQL40iR57FUSuigHeNlRPisnwM/AvtkvZknt/TXw
         O6hLsoM2hrBnMe/8LM17qVIu0ZzowEDGJcWGazm5quyygo57V7xnCxgaOa2+j1ql2rB+
         9VovlLoiduIAH9loIP1ld35+v39MrACVhAaKYwNncc/er9oJiyWtVvYWCn4PyeNqoVcq
         Tgudchji3TOO+FHkKQpy2xglfE/Zwasqf55NCK60+MkhiXZaPC9gPFzxaOfXW3wiuUcj
         U2KuUIUZCCYaQhwpwfxVsQDQ2cmNp7OcczWhYqQbr2ADAFUG1APRruyooxQ4AlTZjll+
         826w==
X-Gm-Message-State: AOJu0YyVgu7p6ujhVIRgwmfy92pXgR60oN/F9PGRAntio1Wt0bYaNCfO
	aq6IakeDqU1xe8OA/J3nuwK+hgunMFwP4OxrBLkvg+jvb0+JmzFBHDg9bDAANA==
X-Gm-Gg: ASbGncti/onk94ApDIvVBm45Y7d3NHnaTVr0JPl48rZIID03A2SL3DdmkKw7+nsvWOG
	4nhxZOwS46PGrWO3P9u5tiYuYDXm4zL7T4Vn7lDgsrGb5LboCFq1P3nTTj2wgXTtc/2snQV4Zux
	gPzA4mCICuSxrBScBMD1H8pHBpWhv9m2QhRZqFCOCO1BnHnuWzf/BOh2YDIvr3MAOrZwV7eNa39
	XFz1EMf+OJ4drpS2DyH4/ptCYVOdm9S5UuSoJYK2W9SBcGOwSo787FBcsI8lYXdxwI7QaLTUZFH
	0gAuh7Sb7NvhxLm+wp4qSJ4BP51YqYvhdMN+b9q/u2cQGNVlVr0m646fAIqG7J8Oz+0EoWh/iBS
	5X33ukVEiA3vbM5fltLkYckqqeJNKlrG46RyNinCjkAbI76Xo0WSJnELFu9lxC703yosE0wH1ih
	2SGofq
X-Google-Smtp-Source: AGHT+IHi8VoeQJA0TagoebgLQ0fqlWBybyPbteSTSkrqXdfIa/MwFyZfmthtjk+d4Z3pZZNOigo3qQ==
X-Received: by 2002:a5d:5d02:0:b0:3e7:486b:45c9 with SMTP id ffacd0b85a97d-3e7486b4953mr1954646f8f.44.1757309482410;
        Sun, 07 Sep 2025 22:31:22 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm40356579f8f.27.2025.09.07.22.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:31:21 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 7/7] promisor-remote: use string_list_split() in mark_remotes_as_accepted()
Date: Mon,  8 Sep 2025 07:30:53 +0200
Message-ID: <20250908053056.956907-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.174.g123d41a7fc
In-Reply-To: <20250908053056.956907-1-christian.couder@gmail.com>
References: <20250731072401.3817074-1-christian.couder@gmail.com>
 <20250908053056.956907-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits replaced some strbuf_split*() calls with calls to
string_list_split*() in "promisor-remote.c".

For consistency, let's also replace the strbuf_split_str() call in
mark_remotes_as_accepted() with a call to string_list_split(), as we
don't need the splitted strings to be managed by a `struct strbuf`.
Using the lighter-weight `string_list` API is enough for our needs.

While at it let's remove a useless call to `strbuf_strip_suffix()`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index a6cfade223..77ebf537e2 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -769,16 +769,15 @@ char *promisor_remote_reply(const char *info)
 
 void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes)
 {
-	struct strbuf **accepted_remotes = strbuf_split_str(remotes, ';', 0);
+	struct string_list accepted_remotes = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 
-	for (size_t i = 0; accepted_remotes[i]; i++) {
-		struct promisor_remote *p;
-		char *decoded_remote;
+	string_list_split(&accepted_remotes, remotes, ";", -1);
 
-		strbuf_strip_suffix(accepted_remotes[i], ";");
-		decoded_remote = url_percent_decode(accepted_remotes[i]->buf);
+	for_each_string_list_item(item, &accepted_remotes) {
+		char *decoded_remote = url_percent_decode(item->string);
+		struct promisor_remote *p = repo_promisor_remote_find(r, decoded_remote);
 
-		p = repo_promisor_remote_find(r, decoded_remote);
 		if (p)
 			p->accepted = 1;
 		else
@@ -788,5 +787,5 @@ void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes
 		free(decoded_remote);
 	}
 
-	strbuf_list_free(accepted_remotes);
+	string_list_clear(&accepted_remotes, 0);
 }
-- 
2.51.0.168.gc8716bf361

