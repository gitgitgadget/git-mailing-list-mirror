Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A02DAFCF
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107082; cv=none; b=P32hODswFXnmwE4IZ2GRH3q3CFkCEfJ+0Sk1eTJyl5K/EGyTTAlvN1Zz1NMnEfXLwRHcZUC6LhUZTyBfwV8GexJZ5OZTqR3RHU1XhVPFU7+gYvEETeMh2PEmeMkF2DgIJaUC1SnQBpCqVRCSP6u1Ntx7G75+4loM9gZYfU9dFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107082; c=relaxed/simple;
	bh=NjXVbzJQ/0ayAh9EvM9naJUuvz69dFDHDyHvleR5qXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErmNTU/5hZRbM2kMf5zhqxw0qxWk9VOAJ1wXH34zjH6o7ecn/PTXV1yVS5wDB+CbL7XsM3x0+ZoFuOMZedVzW8SsJ0fbq0VCqbVAfO+Az5beLUXwzobR6rTcI2x/+U/3MvYmMLTM57NGPoYdxTFPQdhvcs+IAr3VvhtQCNkESok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDDYy1gd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDDYy1gd"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a510432236so2600005f8f.0
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753107078; x=1753711878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbwR9dmkpPfOsItTmzNimf92O5Acx4Uh4RJCooauTPY=;
        b=EDDYy1gdSSLF5zqcpIAQGOmIH6e4nMEgr4qFUnAH2w/UpKiQjbgaVro6JM7jNRJrct
         w3yfP9BvzRg+9mAYNcyb1u4XefEA/Dxj0nvobhQW89OcMFq+ESBkGTzkqXLWL8py/4bo
         y2G5XJdztMbO+5oVD8hEKvN+Q03brcu66mNbR1gTlh/b+tSc7uCvuOGKwG5g1t7mm0CM
         r1gcJErJpvFBNZdgFmAved1eFPjbd+zqPSSKqFacN65CQIRi4wgl58IpTh/AcB84Qjux
         +48y+dxLcpIVJl881FGKMgaPkSQlTb0LXNz7BzoU7KRG9ro/gITLIoAZQ7ReMI2SFVmT
         TzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107078; x=1753711878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbwR9dmkpPfOsItTmzNimf92O5Acx4Uh4RJCooauTPY=;
        b=MpXasBBVGNE0NaXkYKZcOM/YEPOCuEjBQpXBJkE2uTiSes7XCln1M1kyeAUPrsaVi4
         q4dOIL5ppXbtoJCv/eEggEJl+aoZr6JD4JDHAz36BXao3YvdSkkAlhEWPHgh+nZBFICC
         szK+hDkOw07GVL8f+LU1u2K7JkPgYRC90hhqFGsmjJnQvLmUJCV4rk764MFtFPur/sRC
         fzO7RDK16kJzbreCznxdC81hYc1UaN/deNjyGoWvb+snqsNgmD4onvdsDozGDM97wvyy
         sCau+67/OtVDT4ZarF3QbOlEyRWi5NrwthbXewAw72bv94awrYDTq5ljlcoke6jS0Qht
         8jjA==
X-Gm-Message-State: AOJu0YyPSgGZsuR3oXIuGw+w+p5J6cWDBcGglky1LNSutWJ6xF73EhXS
	Ahyv8pvzHYAtWUlfX+ewdMaaFDrVZzNSqJmmT9pY36j44IkprWIhDknTMVxRcQ==
X-Gm-Gg: ASbGnctQVTzGzDEJvdH2R6RhJIgsM4sTPDWoCnZM6mX3DvLHYP/fhdOXoFHCR0l5hSt
	D6NtbN1oRJLse+ebCMK12+PTHY6JmWpnZrhtvLzhmgeR2j7T1zq6YieaJUVYv73FtCfoDAwoEU6
	mfGuczDweyzBleOwRiGEUDQ2bjXONILpCbRkiG3ws87fPGjNzflJBDWkhYEOhbbkJuygkO8aAPY
	g2X8y3aeK1gu5A2eHMKCv1r+zn24ZvKgn1fCsgOfi92zoWdnyn9Do86QWyagMNPqwgblTH61qSL
	ZFVhuGyqrEj73X035xJW4VYwTa1USm5VssqGqLd07ubk42hllNvmugKysnVqZFxSV98HSnxFYWH
	wGbYzq7ZGhBxnWeALwQVjPndheLLB08DqiDHXsuf498Mf4Nks1Inw5iDA0PrGIDRWHgc9WuUeKT
	nWYxKZ
X-Google-Smtp-Source: AGHT+IGptx4uYrsi1CSS9uT6wnhhy2lHRx29YGwYkR5pGK0K5z/xJWRMPuNRi8flOTKqsdxvxJCIxg==
X-Received: by 2002:a5d:59c7:0:b0:3ab:27f9:e4f with SMTP id ffacd0b85a97d-3b60e51caccmr16873796f8f.35.1753107077346;
        Mon, 21 Jul 2025 07:11:17 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e68sm160885585e9.1.2025.07.21.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:11:16 -0700 (PDT)
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
Subject: [PATCH v6 5/5] promisor-remote: use string constants for 'name' and 'url' too
Date: Mon, 21 Jul 2025 16:10:23 +0200
Message-ID: <20250721141056.2283349-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.324.gc7d7c83534
In-Reply-To: <20250721141056.2283349-1-christian.couder@gmail.com>
References: <20250625125055.1375596-1-christian.couder@gmail.com>
 <20250721141056.2283349-1-christian.couder@gmail.com>
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
index 501cb92391..2f86c68397 100644
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
@@ -663,9 +669,9 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
 		*p = '\0';
 		value = url_percent_decode(p + 1);
 
-		if (!strcmp(elem, "name"))
+		if (!strcmp(elem, promisor_field_name))
 			info->name = value;
-		else if (!strcmp(elem, "url"))
+		else if (!strcmp(elem, promisor_field_url))
 			info->url = value;
 		else if (!strcasecmp(elem, promisor_field_filter))
 			info->filter = value;
-- 
2.50.1.324.gc7d7c83534

