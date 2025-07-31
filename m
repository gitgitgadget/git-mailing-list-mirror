Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB829E0E9
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946669; cv=none; b=NKkrESufnbpljwFCcd0GHRuI/feiFV7YsyR5X4RS6MThZAr4onXMj5LdVqKn9Xs636igc0eTzqi5tKJwyWIZzkAn8qhZ7zJyTf/JOrTNpITigVeLy6nytth7rQMItEp81JWhRYcamxUA6M1EZej+dMnmrJw+Au0u7s7pcDpq7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946669; c=relaxed/simple;
	bh=+Oi5B3KQSKRUkfkZLiT+wL5f45Njh2qHPgmeWwF4zi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fcj4a2g9NKGOnJkwbSURosAJz/N7UfVx0esmxtrrsYTPsSbRZGA7jyOI8/IMdvpaf3Y61atrBECx2tIwLqKtatnFxrlRLIofFRK5YCLSPQVz+hrzkQmPiY5/BxOO+PcZKNU2RsDzRhhgr1jQHFJ+vg8XNhmyZncVBk/8JfasCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy6LiyWx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy6LiyWx"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b786421e36so326075f8f.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753946665; x=1754551465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zkev1dYGEAx6/XDSLYm+jLG9DlQgJ8f7KFhlrBlirg=;
        b=dy6LiyWxnlkBWmlV6PkOvhBq2fYyvxXSkN7MrWD7DecRGgZWEbnDkX8WL1voYjq6WX
         47gzpZ8Dy/Vt82yIg2Fy/D91txpn4xY02XZjt6YHeF58dycssChaDwPOs0ICIDSDCVX+
         XcbgVnzozEd+1sxqnfmjtuS25zaloKtCo/HpAhlCc1xcMtavL76YEJWeDFopYv/XM2Ux
         6C0bU6uAG7CdVqKDjPhkS0H6GQ+Sfq3VSSLpDF5RD64svqia6x5AIb04+jxrNUvGKhnn
         YPO9kEpw992C4FF1iJ2hG3f7Y5QafGM7rZ+K1zSbXYj6XpyV9pmyqRxjBHotr6+wWkks
         g8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946665; x=1754551465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zkev1dYGEAx6/XDSLYm+jLG9DlQgJ8f7KFhlrBlirg=;
        b=Yv6Ya7tv8CwjacaAYzDq6SLJN32nmPGzYImfPoFr8AVftNw/M10jHVQwUVkGbOwvmZ
         TnPXKSK9rMxE5DH3BVG70tCtUzmUdoKQGhAUwD/wiwidtI4KatICVJj+95aJ+RLMJFMy
         OhePfIWFIrbPqOLBqEV+wxp9tqrnFMK0h8jhBpmguMVPlFylv1UGNt6PSSqeN+kKLUtW
         HR7LYyC9qtJiOllN7fKwujFohvhvjCtoRWVDCGPTJj5+3FyCkcp+7nwCVkKbHdtj0Wtp
         xNsLYVd86u24JS/u+lgcfX3utikbnZHZ0rUhuVRkgO54J0+sgB00R/iZRED9Bqy9IADQ
         Nvdw==
X-Gm-Message-State: AOJu0Yxa/oP2Y+GsYcLznZoceQrqGjIaRBJSwFq7LNV9N330D72adlrH
	9Yc5K78j1J6ApsORZlsXuQwfNxPEWUkj9U74N9hwzATxj1FRi5ozgX5UCaTEpg==
X-Gm-Gg: ASbGncucBF6+lm57QUQwDFYAjRDizh8RVodgNzYa4f/3fTkd3HbK7wwCKa0YYbPsIo9
	kulae1KF9q1Ja92AhMGjjYY/HwecIelH33kHa80QjD1IwXFcv8nFCpsJBmfoDciO0DOgepErq0n
	v/N+TocIheKSiKGzusmfoCoaYKVxUVJs8YPFIoHU9VoJQ7T5ueCzsMKTlBIfozvuR1GPB0TQLHk
	LeZASkC08ORj6kVbZQxqn7bX3sjmzy5TF0qPqL6au/U1d7qtwHZodwc4ZuIfKFCssXDDrX84mlm
	ygkX5CE1hlnlb9/9oVldP1cBqCGFCBlzA6YwITwCRqkFVBMQC94fFDX9EO5XUk8AZC/8h/0pRLV
	6NcZm5PGd7K2+WGzSC2STfYlaxS7US9J3d1gDzFSkIUxaZzrssi+Zg4xmi6OYxO7pKl3PtU0dGK
	owJ3je1/pISdjXVNg=
X-Google-Smtp-Source: AGHT+IG9c95Trb9uYa+Fe/Y80GuBJYfbX4nyXtcasKChCUYT6He6yH6l+YxwNG0C0aiEtuZ8ajmWcw==
X-Received: by 2002:a5d:69d0:0:b0:3b7:899c:e88b with SMTP id ffacd0b85a97d-3b794fe4da0mr3905987f8f.11.1753946665188;
        Thu, 31 Jul 2025 00:24:25 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953f8e02sm52495175e9.32.2025.07.31.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 00:24:24 -0700 (PDT)
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
Subject: [PATCH v7 5/5] promisor-remote: use string constants for 'name' and 'url' too
Date: Thu, 31 Jul 2025 09:23:57 +0200
Message-ID: <20250731072401.3817074-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.323.g4e0625aa69.dirty
In-Reply-To: <20250731072401.3817074-1-christian.couder@gmail.com>
References: <20250721141056.2283349-1-christian.couder@gmail.com>
 <20250731072401.3817074-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit started to define `promisor_field_filter` and
`promisor_field_token`, and used them instead of the
"partialCloneFilter" and "token" string literals.

Let's do the same for "name" and "url" to avoid repeating them
several times and for consistency with the other fields.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 46b2cb0bc9..88ff4e658c 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,6 +314,12 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
+/*
+ * All the fields used in "promisor-remote" protocol capability,
+ * including the mandatory "name" and "url" ones.
+ */
+static const char promisor_field_name[] = "name";
+static const char promisor_field_url[] = "url";
 static const char promisor_field_filter[] = "partialCloneFilter";
 static const char promisor_field_token[] = "token";
 
@@ -520,9 +526,9 @@ char *promisor_remote_info(struct repository *repo)
 		if (item != config_info.items)
 			strbuf_addch(&sb, ';');
 
-		strbuf_addstr(&sb, "name=");
+		strbuf_addf(&sb, "%s=", promisor_field_name);
 		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
-		strbuf_addstr(&sb, ",url=");
+		strbuf_addf(&sb, ",%s=", promisor_field_url);
 		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
 
 		if (p->filter) {
@@ -664,9 +670,9 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
 		*p = '\0';
 		value = url_percent_decode(p + 1);
 
-		if (!strcmp(elem, "name"))
+		if (!strcmp(elem, promisor_field_name))
 			info->name = value;
-		else if (!strcmp(elem, "url"))
+		else if (!strcmp(elem, promisor_field_url))
 			info->url = value;
 		else if (!strcmp(elem, promisor_field_filter))
 			info->filter = value;
-- 
2.50.1.323.g4e0625aa69.dirty

